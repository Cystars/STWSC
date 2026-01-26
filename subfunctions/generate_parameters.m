<<<<<<< HEAD
%=============== 辅助函数 ===============%
function params = generate_parameters(range)
    % 增强参数生成：添加参数有效性验证
    validate_range(range);
    
    [lambdas, betas, rhos] = ndgrid(...
        linspace(range.lambda(1), range.lambda(2), 3), ...
        linspace(range.beta(1), range.beta(2), 3), ...
        linspace(range.rho(1), range.rho(2), 3) ...
    );
    
    params = [lambdas(:), betas(:), rhos(:)];
    params = unique(params, 'rows'); % 去除重复组合
end

=======
%=============== 辅助函数 ===============%
function params = generate_parameters(range)
    % 增强参数生成：添加参数有效性验证
    validate_range(range);
    
    [lambdas, betas, rhos] = ndgrid(...
        linspace(range.lambda(1), range.lambda(2), 3), ...
        linspace(range.beta(1), range.beta(2), 3), ...
        linspace(range.rho(1), range.rho(2), 3) ...
    );
    
    params = [lambdas(:), betas(:), rhos(:)];
    params = unique(params, 'rows'); % 去除重复组合
end

>>>>>>> f6a4ed6 (master)
