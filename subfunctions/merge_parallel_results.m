<<<<<<< HEAD
function results = merge_parallel_results(results, data_idx)
    % 初始化带默认值的结构体
    default_metrics = struct(...
        'ACC', struct('mean', 0, 'std', 0),...
        'NMI', struct('mean', 0, 'std', 0),...
        'Time', struct('mean', 0, 'std', 0));
    
    % 在数据加载时填充默认值
    parfor f = 1:num_combinations
        try
            data = load(filepath);
            for m = 1:num_methods
                if ~isfield(data.method_results{m}, 'Metrics')
                    data.method_results{m}.Metrics = default_metrics;
                end
                % 数据提取逻辑...
            end
        catch
            fprintf('处理文件失败: %s\n', file_list(f).name);
        end
    end
=======
function results = merge_parallel_results(results, data_idx)
    % 初始化带默认值的结构体
    default_metrics = struct(...
        'ACC', struct('mean', 0, 'std', 0),...
        'NMI', struct('mean', 0, 'std', 0),...
        'Time', struct('mean', 0, 'std', 0));
    
    % 在数据加载时填充默认值
    parfor f = 1:num_combinations
        try
            data = load(filepath);
            for m = 1:num_methods
                if ~isfield(data.method_results{m}, 'Metrics')
                    data.method_results{m}.Metrics = default_metrics;
                end
                % 数据提取逻辑...
            end
        catch
            fprintf('处理文件失败: %s\n', file_list(f).name);
        end
    end
>>>>>>> f6a4ed6 (master)
end