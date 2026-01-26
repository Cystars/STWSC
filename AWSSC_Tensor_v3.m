function [labels, alpha] = AWSSC_Tensor_v3(W_list, Omega_m, Omega_c, params)
    V = length(W_list);
    [n, ~] = size(W_list{1});
    max_iter = params.max_iter;
    tol = params.tol;
    tau = params.tau;
    epsilon = params.epsilon;
    
    
    tensor_W = cat(3, W_list{:});
    
    Z = cell(1, V);
    for v = 1:V
        Z{v} = max(W_list{v}, 0); 
    end
    tensor_Z = cat(3, Z{:});
    tensor_H=tensor_Z;
   
    alpha = ones(1, V) / V; 
    Y1 = zeros(n, n, V); 
    Y2=zeros(n, n, V);
    rho1 = 1e-3; 
    rho2 = 1e-3;
    rhomax=1e10;
    mm=1.2;
    mu = 0.01; 
     tensor_E = tensor_W - tensor_Z + Y1/rho1;
   

    for iter = 1:max_iter
        % ========== update Z^{(v)} ==========
        tensor_Z_prev = tensor_H;
        tensor_F = tensor_W - tensor_E + Y1/rho1;
        tensor_D= tensor_H - Y2/rho2;
        for v = 1:V
            W = W_list{v};
            Zv_old = Z{v};
            
            
            grad_recon = 2 * alpha(v) * (Zv_old - W);
            grad_must = -params.beta * sparse(Omega_m(:,1), Omega_m(:,2), ...
                Zv_old(sub2ind([n,n], Omega_m(:,1), Omega_m(:,2))) < tau, n, n);
            grad_cannot = params.beta * sparse(Omega_c(:,1), Omega_c(:,2), ...
                Zv_old(sub2ind([n,n], Omega_c(:,1), Omega_c(:,2))) > epsilon, n, n);
            grad_Z1=rho1*(Zv_old-tensor_F(:,:,v));
            grad_Z2=rho2*(Zv_old-tensor_D(:,:,v));
            grad = grad_recon + grad_must + grad_cannot+grad_Z1+grad_Z2;
            
            
            Zv_new = Zv_old - mu * grad;
            
            Zv_new = max(Zv_new, 0);
            
            Z{v} = Zv_new;
        end
        
        % ========== update alpha ==========
        recon_err = zeros(1, V);
        for v = 1:V
            recon_err(v) = norm(W_list{v} - Z{v}, 'fro')^2;
        end
        alpha = 1 ./ (recon_err + params.eta);
        alpha = alpha / sum(alpha); % 归一化

        % ========== updata H ==========
        
        tensor_H = cat(3, Z{:});
        tensor_G = tensor_H + Y2/rho2;
        tensor_H = tensor_nuclear_norm_threshold(tensor_G, params.lambda/rho2);

        % ========== updata E ==========
        tensor_E = tensor_W - tensor_Z + Y1/rho1;
        tensor_E = l21_threshold(tensor_E, params.theta/rho1);


         
        % ========== updata Y ==========
        Y1 = Y1 + rho1 * (tensor_H + tensor_E - tensor_W);
        Y2 = Y2 + rho2 * (tensor_H - tensor_Z);
        rho1 = min(rho1*mm, rhomax);
        rho2 = min(rho2*mm, rhomax);
        
      

        if iter > 1 && norm(tensor_Z_prev - tensor_Z, 'fro') < tol
            break;
        end
    end
    % ========== spectral clustering ==========
        A = zeros(n);
        for v = 1:V
            A = A + alpha(v) * (Z{v} + Z{v}') / 2;
        end      
        epsilon_reg = 1e-5; 
        D = diag(sum(A, 2) + epsilon_reg); 
        L = D - A;
        [F, ~] = eigs(L, params.k, 'smallestreal');
    labels = kmeans(F, params.k, 'Replicates', 10);
end


function Z = tensor_nuclear_norm_threshold(G, lambda)
    [n, m, p] = size(G);
    G_f = fft(G, [], 3);
    Z_f = zeros(size(G_f));
    for i = 1:p
        [U, S, V] = svd(G_f(:,:,i), 'econ');
        S_thresh = max(S - lambda, 0);
        Z_f(:,:,i) = U * S_thresh * V';
    end
    Z = real(ifft(Z_f, [], 3));
end

function E = l21_threshold(R, theta)
    [n, m, p] = size(R);
    E = zeros(n, m, p);
    for i = 1:n
        for j = 1:m
            tube = squeeze(R(i,j,:));
            norm_tube = norm(tube);
            if norm_tube > theta
                E(i,j,:) = (norm_tube - theta) / norm_tube * tube;
            else
                E(i,j,:) = 0;
            end
        end
    end
end