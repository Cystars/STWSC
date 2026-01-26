%=============== 修改后的proposed_method函数 ===============%
function [W_tensor, alpha_hist] = proposed_method(X, Omega, B, params)
    % 步骤1：生成多源亲和矩阵（SSC/LRR/LSR/DeepAE）
    Z_ssc = SSC(X, 0, false, 20, false, 1);  % SSC视图
    [Z_lrr, ~] = LRR(X, 20);           % LRR视图 
    Z_lsr = LSR(X, 0.1);                      % LSR视图
    
    % 构建初始亲和张量
    W_tensor = cat(3, Z_ssc, Z_lrr, Z_lsr);
    [n, ~, V] = size(W_tensor);
    
    % 步骤2：初始化动态权重和ADMM变量
    alpha = ones(1,V)/V; 
    alpha_hist = struct('iter', [], 'values', []);
    Z = W_tensor; G = Z; Y = zeros(size(Z)); % 拉格朗日乘子
    rho = 1; mu = 1; % 惩罚参数
    
    % 步骤3：ADMM主循环
    for iter = 1:params.max_iter
        % ---- 子问题1：更新各视图Z^{(v)} ----
        for v = 1:V
            % 构建监督项矩阵
            M = zeros(n);
            M(Omega) = 1; % 仅约束位置有效
            Q = (sum(Z(:,:,setdiff(1:V,v)),3) + B*V)/(V-1);
            
            % 闭式解更新Z^{(v)}
            Z(:,:,v) = (alpha(v)*eye(n) + params.beta*M) \ ...
                       (alpha(v)*W_tensor(:,:,v) + params.beta*M.*Q - Y(:,:,v)/rho);
        end
        
        % ---- 子问题2：更新辅助变量G（WTNN约束）----
        G_prev = G;
        G = tensor_nuclear_norm(Z + Y/rho, alpha, params.lambda);
        
        % ---- 子问题3：更新动态权重α ----
        res = squeeze(sum(sum((W_tensor - Z).^2,1),2)); % 重构误差
        grad = res' + mu*(sum(alpha)-1); % 带正则化的梯度
        alpha = projected_gradient(alpha, grad, params.eta);
        alpha_hist.iter = [alpha_hist.iter; iter];
        alpha_hist.values = [alpha_hist.values; alpha];
        
        % ---- 更新拉格朗日乘子和惩罚参数 ----
        Y = Y + rho*(Z - G);
        rho = min(rho*1.1, 1e6);
        mu = min(mu*1.1, 1e6);
        
        % 收敛检查
        if norm(Z(:)-G_prev(:)) < 1e-6 && norm(grad) < 1e-4
            break;
        end
    end
    
    % 步骤4：返回融合后的张量
    W_tensor = G;
end

%=============== 新增关键子函数 ===============%
function G = tensor_nuclear_norm(T, alpha, lambda)
    % 加权张量核范数优化（WTNN）
    T_f = fft(T, [], 3);
    [~,~,V] = size(T);
    parfor v = 1:V
        [U,S,V] = svd(T_f(:,:,v), 'econ');
        S_thresh = diag(max(diag(S) - lambda*alpha(v), 0)); % 加权阈值
        T_f(:,:,v) = U*S_thresh*V';
    end
    G = ifft(T_f, [], 3, 'symmetric');
end

function alpha_new = projected_gradient(alpha, grad, eta)
    % 带投影的梯度下降（确保∑α=1且α≥0）
    alpha_new = alpha - eta*grad;
    alpha_new = max(alpha_new, 0); % 非负约束
    alpha_new = alpha_new / sum(alpha_new); % 归一化
end

