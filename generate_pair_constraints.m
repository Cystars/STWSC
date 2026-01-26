<<<<<<< HEAD
% function [Omega_m, Omega_c] = generate_pair_constraints(gt,p)
% % 从标签中随机采样生成Must-link和Cannot-link对
% true_labels = gt; % n x 1 向量
% n = length(true_labels);
% 
% % 生成所有可能的样本对
% all_pairs = combnk(1:n, 2); % 生成n(n-1)/2对
% total_pairs = size(all_pairs, 1);
% num_select = round(p * total_pairs); % 选取的样本对数
% 
% % 随机选择样本对
% rng(42); % 固定随机种子
% selected_indices = randperm(total_pairs, num_select);
% selected_pairs = all_pairs(selected_indices, :);
% 
% % 根据标签生成Omega_m和Omega_c
% Omega_m = [];
% Omega_c = [];
% for i = 1:size(selected_pairs, 1)
%     idx1 = selected_pairs(i, 1);
%     idx2 = selected_pairs(i, 2);
%     if true_labels(idx1) == true_labels(idx2)
%         Omega_m = [Omega_m; idx1, idx2]; % Must-link
%     else
%         Omega_c = [Omega_c; idx1, idx2]; % Cannot-link
%     end
% end
% 
% % 确保索引不越界
% Omega_m = max(min(Omega_m, n), 1);
% Omega_c = max(min(Omega_c, n), 1);
% end

function [Omega_m, Omega_c] = generate_pair_constraints(gt, p)
true_labels = gt(:); % 确保标签为列向量
n = numel(true_labels);
if n < 2
    Omega_m = [];
    Omega_c = [];
    return;
end

% 计算总可能的对数
N = n * (n - 1) / 2;
num_select = round(p * N);
if num_select == 0
    Omega_m = [];
    Omega_c = [];
    return;
end

% 固定随机种子以确保结果可复现
rng(42);

% 随机选择唯一的k值，避免生成所有组合
selected_k = randperm(N, num_select);
k = selected_k(:); % 转换为列向量

% 向量化计算将k转换为(i,j)对
i = floor(((2*n - 1) - sqrt((2*n - 1)^2 - 8*(k - 1))) / 2) + 1;
sum_i_prev = (i - 1) .* n - (i - 1) .* i / 2;
offset = k - sum_i_prev;
j = i + offset;

% 确保i和j在有效范围内（理论上无需此步骤，但为了鲁棒性保留）
i = max(min(i, n), 1);
j = max(min(j, n), 1);

% 提取标签并向量化比较
labels_i = true_labels(i);
labels_j = true_labels(j);
is_must = (labels_i == labels_j);

% 直接构建结果矩阵，避免动态扩展
Omega_m = [i(is_must), j(is_must)];
Omega_c = [i(~is_must), j(~is_must)];

% 可选：进一步确保索引不越界
Omega_m = max(min(Omega_m, n), 1);
Omega_c = max(min(Omega_c, n), 1);
=======
% function [Omega_m, Omega_c] = generate_pair_constraints(gt,p)
% % 从标签中随机采样生成Must-link和Cannot-link对
% true_labels = gt; % n x 1 向量
% n = length(true_labels);
% 
% % 生成所有可能的样本对
% all_pairs = combnk(1:n, 2); % 生成n(n-1)/2对
% total_pairs = size(all_pairs, 1);
% num_select = round(p * total_pairs); % 选取的样本对数
% 
% % 随机选择样本对
% rng(42); % 固定随机种子
% selected_indices = randperm(total_pairs, num_select);
% selected_pairs = all_pairs(selected_indices, :);
% 
% % 根据标签生成Omega_m和Omega_c
% Omega_m = [];
% Omega_c = [];
% for i = 1:size(selected_pairs, 1)
%     idx1 = selected_pairs(i, 1);
%     idx2 = selected_pairs(i, 2);
%     if true_labels(idx1) == true_labels(idx2)
%         Omega_m = [Omega_m; idx1, idx2]; % Must-link
%     else
%         Omega_c = [Omega_c; idx1, idx2]; % Cannot-link
%     end
% end
% 
% % 确保索引不越界
% Omega_m = max(min(Omega_m, n), 1);
% Omega_c = max(min(Omega_c, n), 1);
% end

function [Omega_m, Omega_c] = generate_pair_constraints(gt, p)
true_labels = gt(:); % 确保标签为列向量
n = numel(true_labels);
if n < 2
    Omega_m = [];
    Omega_c = [];
    return;
end

% 计算总可能的对数
N = n * (n - 1) / 2;
num_select = round(p * N);
if num_select == 0
    Omega_m = [];
    Omega_c = [];
    return;
end

% 固定随机种子以确保结果可复现
rng(42);

% 随机选择唯一的k值，避免生成所有组合
selected_k = randperm(N, num_select);
k = selected_k(:); % 转换为列向量

% 向量化计算将k转换为(i,j)对
i = floor(((2*n - 1) - sqrt((2*n - 1)^2 - 8*(k - 1))) / 2) + 1;
sum_i_prev = (i - 1) .* n - (i - 1) .* i / 2;
offset = k - sum_i_prev;
j = i + offset;

% 确保i和j在有效范围内（理论上无需此步骤，但为了鲁棒性保留）
i = max(min(i, n), 1);
j = max(min(j, n), 1);

% 提取标签并向量化比较
labels_i = true_labels(i);
labels_j = true_labels(j);
is_must = (labels_i == labels_j);

% 直接构建结果矩阵，避免动态扩展
Omega_m = [i(is_must), j(is_must)];
Omega_c = [i(~is_must), j(~is_must)];

% 可选：进一步确保索引不越界
Omega_m = max(min(Omega_m, n), 1);
Omega_c = max(min(Omega_c, n), 1);
>>>>>>> f6a4ed6 (master)
end