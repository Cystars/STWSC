function [C, Z] = CDSSELRTL(X, params)
    % 输入：X - 数据矩阵，params - 参数
    % 输出：C - 最终亲和矩阵，Z - 第一次自表达结果
    
    % 第一次自表达（数据层）
    Z = self_expression(X, params.mode1); 
    
    % 第二次自表达（特征层）
    C = self_expression(Z, params.mode2);
    
    % 张量低秩优化
    tensor = cat(3, Z, C);
    [n, ~, ~] = size(tensor);
    
    % TNN约束优化
    for iter = 1:params.max_iter
        % 更新Z
        Z = tensor(:,:,1);
        Z = Z - params.eta*(Z - C*tensor(:,:,2));
        
        % 更新C
        C = (Z'*Z + params.lambda*eye(n)) \ Z';
        
        % 张量奇异值阈值
        tensor(:,:,1) = Z;
        tensor(:,:,2) = C;
        tensor = tnn_threshold(tensor, params.tau);
        
        % 收敛检查
        if norm(tensor(:,:,1)-prev_Z,'fro') < 1e-6
            break;
        end
        prev_Z = tensor(:,:,1);
    end
    C = 0.5*(abs(tensor(:,:,2)) + abs(tensor(:,:,2)'));
end

function Z = self_expression(X, mode)
    % 自表达层核心
    switch mode
        case 'SSC'
            Z = sparse_subspace_clustering(X, 0.1);
        case 'LRR'
            [Z, ~] = low_rank_representation(X, X, 0.1);
        case 'LSR'
            Z = (X'*X + 0.1*eye(size(X,2))) \ (X'*X);
    end
end

function tensor = tnn_threshold(tensor, tau)
    % 张量核范数阈值
    tensor_f = fft(tensor, [], 3);
    for i = 1:size(tensor_f,3)
        [U, S, V] = svd(tensor_f(:,:,i), 'econ');
        S = diag(max(diag(S) - tau, 0));
        tensor_f(:,:,i) = U*S*V';
    end
    tensor = ifft(tensor_f, [], 3, 'symmetric');
end