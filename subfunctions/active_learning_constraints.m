<<<<<<< HEAD
% function [Omega, B] = active_learning_constraints(X, labels, ratio)
%     [~, scores] = pca(X');
%     boundary_idx = find_boundary_points(scores);
%     [Omega, B] = sample_pairs(boundary_idx, labels, ratio);
% end

function [Omega, B] = active_learning_constraints(X, labels, ratio)
    % 增强边界样本检测
    [~, score] = pca(X');
    [~, ~, latent] = pca(X');
    energy = cumsum(latent)./sum(latent);
    dim = find(energy > 0.95, 1); % 自动确定PCA维度
    
    boundary_idx = find_boundary_points(score(:,1:dim));
    [Omega, B] = sample_pairs(boundary_idx, labels, ratio);
end

=======
% function [Omega, B] = active_learning_constraints(X, labels, ratio)
%     [~, scores] = pca(X');
%     boundary_idx = find_boundary_points(scores);
%     [Omega, B] = sample_pairs(boundary_idx, labels, ratio);
% end

function [Omega, B] = active_learning_constraints(X, labels, ratio)
    % 增强边界样本检测
    [~, score] = pca(X');
    [~, ~, latent] = pca(X');
    energy = cumsum(latent)./sum(latent);
    dim = find(energy > 0.95, 1); % 自动确定PCA维度
    
    boundary_idx = find_boundary_points(score(:,1:dim));
    [Omega, B] = sample_pairs(boundary_idx, labels, ratio);
end

>>>>>>> f6a4ed6 (master)
