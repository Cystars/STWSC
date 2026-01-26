%=============== 文件保存函数 ===============%
function save_temp_results(method_results, data_idx, param_idx)
    % 创建临时文件存储目录
    temp_dir = fullfile(pwd, 'temp_results');
    if ~exist(temp_dir, 'dir')
        mkdir(temp_dir);
    end
    
    % 生成唯一文件名
    filename = sprintf('data%d_param%d_%s.mat', data_idx, param_idx, datestr(now,'HHMMSSFFF'));
    filepath = fullfile(temp_dir, filename);
    
    % 保存结果到临时文件
    save(filepath, 'method_results');
end

