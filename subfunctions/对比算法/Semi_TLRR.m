<<<<<<< HEAD
function [W, B] = Semi_TLRR(X, Omega, B_init, params)
    % 输入：X - 数据矩阵，Omega - 约束位置，B_init - 初始约束矩阵
    % 输出：W - 亲和矩阵，B - 优化后的约束矩阵
    
    [d, n] = size(X);
    max_iter = 50;
    rho = params.rho;
    
    % 初始化
    Z = zeros(n, n);
    E = zeros(d, n);
    Y1 = zeros(d, n); % 拉格朗日乘子
    Y2 = zeros(n, n); 
    B = B_init;
    
    % 构建图拉普拉斯矩阵
    L = construct_laplacian(X, params.knn);
    
    for iter = 1:max_iter
        % 更新Z
        temp = X'*(X - E + Y1/rho) + (B + Y2/rho);
        Z = (temp + temp') / (2*rho + 2*params.beta*diag(L));
        
        % 更新B（带约束）
        B = Z - Y2/rho;
        B(Omega) = B_init(Omega); % 固定已知约束
        
        % 更新E
        E = soft_threshold(X - X*Z + Y1/rho, params.lambda/rho);
        
        % 更新拉格朗日乘子
        Y1 = Y1 + rho*(X - X*Z - E);
        Y2 = Y2 + rho*(Z - B);
        rho = min(rho*1.1, 1e6);
        
        % 收敛判断
        if norm(Z - prev_Z, 'fro') < 1e-6
            break;
        end
        prev_Z = Z;
    end
    W = 0.5*(abs(Z) + abs(Z'));
end

function L = construct_laplacian(X, k)
    % 构建kNN图拉普拉斯矩阵
    D = pdist2(X', X');
    [~, idx] = mink(D, k+1, 2);
    W = zeros(size(D));
    for i = 1:size(X,2)
        W(i, idx(i,2:end)) = 1;
    end
    W = max(W, W'); % 确保对称
    D = diag(sum(W, 2));
    L = D - W;
=======
function [W, B] = Semi_TLRR(X, Omega, B_init, params)
    % 输入：X - 数据矩阵，Omega - 约束位置，B_init - 初始约束矩阵
    % 输出：W - 亲和矩阵，B - 优化后的约束矩阵
    
    [d, n] = size(X);
    max_iter = 50;
    rho = params.rho;
    
    % 初始化
    Z = zeros(n, n);
    E = zeros(d, n);
    Y1 = zeros(d, n); % 拉格朗日乘子
    Y2 = zeros(n, n); 
    B = B_init;
    
    % 构建图拉普拉斯矩阵
    L = construct_laplacian(X, params.knn);
    
    for iter = 1:max_iter
        % 更新Z
        temp = X'*(X - E + Y1/rho) + (B + Y2/rho);
        Z = (temp + temp') / (2*rho + 2*params.beta*diag(L));
        
        % 更新B（带约束）
        B = Z - Y2/rho;
        B(Omega) = B_init(Omega); % 固定已知约束
        
        % 更新E
        E = soft_threshold(X - X*Z + Y1/rho, params.lambda/rho);
        
        % 更新拉格朗日乘子
        Y1 = Y1 + rho*(X - X*Z - E);
        Y2 = Y2 + rho*(Z - B);
        rho = min(rho*1.1, 1e6);
        
        % 收敛判断
        if norm(Z - prev_Z, 'fro') < 1e-6
            break;
        end
        prev_Z = Z;
    end
    W = 0.5*(abs(Z) + abs(Z'));
end

function L = construct_laplacian(X, k)
    % 构建kNN图拉普拉斯矩阵
    D = pdist2(X', X');
    [~, idx] = mink(D, k+1, 2);
    W = zeros(size(D));
    for i = 1:size(X,2)
        W(i, idx(i,2:end)) = 1;
    end
    W = max(W, W'); % 确保对称
    D = diag(sum(W, 2));
    L = D - W;
>>>>>>> f6a4ed6 (master)
end