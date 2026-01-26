<<<<<<< HEAD
function [W_tensor, alpha] = RSC_MAMF(X, params)
    % 输入：X - d×n数据矩阵，params - 参数结构体
    % 输出：W_tensor - n×n×V亲和张量，alpha - 视图权重
    
    % 生成多视图亲和矩阵
    V = 3; % SSC, LRR, LSR三种方法
    W_tensor = zeros(size(X,2), size(X,2), V);
    
    % SSC视图
    W_tensor(:,:,1) = sparse_subspace_clustering(X, params.ssc_lambda);
    
    % LRR视图
    [Z_lrr, ~] = low_rank_representation(X, X, params.lrr_lambda);
    W_tensor(:,:,2) = 0.5*(abs(Z_lrr) + abs(Z_lrr'));
    
    % LSR视图
    Z_lsr = (X'*X + params.lsr_lambda*eye(size(X,2))) \ (X'*X);
    W_tensor(:,:,3) = 0.5*(abs(Z_lsr) + abs(Z_lsr'));
    
    % 张量低秩融合（WTNN约束）
    [W_tensor, alpha] = weighted_tnn_fusion(W_tensor, params);
end

function [Z, alpha] = weighted_tnn_fusion(W, params)
    % 加权张量核范数融合
    [n, ~, V] = size(W);
    max_iter = 100;
    rho = params.rho_init;
    mu = params.mu_init;
    
    % 初始化
    Z = W;
    E = zeros(size(W));
    Y = zeros(size(W));
    alpha = ones(1,V)/V; % 均匀初始化权重
    
    for iter = 1:max_iter
        % 更新Z
        Z_prev = Z;
        for v = 1:V
            % 求解每个视图的子问题
            T = W(:,:,v) - E(:,:,v) + Y(:,:,v)/rho;
            [U, S, V] = svd(T, 'econ');
            S_thresh = max(S - alpha(v)/(rho*V), 0);
            Z(:,:,v) = U*S_thresh*V';
        end
        
        % 更新E
        E = W - Z + Y/rho;
        E = sign(E) .* max(abs(E) - params.lambda/rho, 0);
        
        % 更新权重alpha（基于残差）
        res = squeeze(sum(sum((W - Z).^2, 1), 2));
        alpha = softmax(-res); % 残差越小权重越大
        
        % 更新拉格朗日乘子
        Y = Y + rho*(W - Z - E);
        rho = min(rho*1.1, params.rho_max);
        
        % 收敛检查
        if norm(Z(:)-Z_prev(:)) < params.tol
            break;
        end
    end
=======
function [W_tensor, alpha] = RSC_MAMF(X, params)
    % 输入：X - d×n数据矩阵，params - 参数结构体
    % 输出：W_tensor - n×n×V亲和张量，alpha - 视图权重
    
    % 生成多视图亲和矩阵
    V = 3; % SSC, LRR, LSR三种方法
    W_tensor = zeros(size(X,2), size(X,2), V);
    
    % SSC视图
    W_tensor(:,:,1) = sparse_subspace_clustering(X, params.ssc_lambda);
    
    % LRR视图
    [Z_lrr, ~] = low_rank_representation(X, X, params.lrr_lambda);
    W_tensor(:,:,2) = 0.5*(abs(Z_lrr) + abs(Z_lrr'));
    
    % LSR视图
    Z_lsr = (X'*X + params.lsr_lambda*eye(size(X,2))) \ (X'*X);
    W_tensor(:,:,3) = 0.5*(abs(Z_lsr) + abs(Z_lsr'));
    
    % 张量低秩融合（WTNN约束）
    [W_tensor, alpha] = weighted_tnn_fusion(W_tensor, params);
end

function [Z, alpha] = weighted_tnn_fusion(W, params)
    % 加权张量核范数融合
    [n, ~, V] = size(W);
    max_iter = 100;
    rho = params.rho_init;
    mu = params.mu_init;
    
    % 初始化
    Z = W;
    E = zeros(size(W));
    Y = zeros(size(W));
    alpha = ones(1,V)/V; % 均匀初始化权重
    
    for iter = 1:max_iter
        % 更新Z
        Z_prev = Z;
        for v = 1:V
            % 求解每个视图的子问题
            T = W(:,:,v) - E(:,:,v) + Y(:,:,v)/rho;
            [U, S, V] = svd(T, 'econ');
            S_thresh = max(S - alpha(v)/(rho*V), 0);
            Z(:,:,v) = U*S_thresh*V';
        end
        
        % 更新E
        E = W - Z + Y/rho;
        E = sign(E) .* max(abs(E) - params.lambda/rho, 0);
        
        % 更新权重alpha（基于残差）
        res = squeeze(sum(sum((W - Z).^2, 1), 2));
        alpha = softmax(-res); % 残差越小权重越大
        
        % 更新拉格朗日乘子
        Y = Y + rho*(W - Z - E);
        rho = min(rho*1.1, params.rho_max);
        
        % 收敛检查
        if norm(Z(:)-Z_prev(:)) < params.tol
            break;
        end
    end
>>>>>>> f6a4ed6 (master)
end