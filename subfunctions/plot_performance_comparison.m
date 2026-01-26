<<<<<<< HEAD
function plot_performance_comparison(results)
    % 正确提取数值数据
    acc_values = arrayfun(@(x) x.Metrics.ACC.mean, results);
    method_names = results(1).Methods;
    
    % 创建有效柱状图
    figure;
    bar(acc_values);
    set(gca, 'XTickLabel', method_names, 'XTick', 1:numel(method_names));
    ylabel('Accuracy');
    title('各方法性能对比');
    
    % 添加误差条（若需要）
    if isfield(results(1).Metrics.ACC, 'std')
        hold on;
        errorbar(1:numel(method_names), acc_values, results(1).Metrics.ACC.std, 'k.');
        hold off;
    end
=======
function plot_performance_comparison(results)
    % 正确提取数值数据
    acc_values = arrayfun(@(x) x.Metrics.ACC.mean, results);
    method_names = results(1).Methods;
    
    % 创建有效柱状图
    figure;
    bar(acc_values);
    set(gca, 'XTickLabel', method_names, 'XTick', 1:numel(method_names));
    ylabel('Accuracy');
    title('各方法性能对比');
    
    % 添加误差条（若需要）
    if isfield(results(1).Metrics.ACC, 'std')
        hold on;
        errorbar(1:numel(method_names), acc_values, results(1).Metrics.ACC.std, 'k.');
        hold off;
    end
>>>>>>> f6a4ed6 (master)
end