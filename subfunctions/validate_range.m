<<<<<<< HEAD
function validate_range(range)
    % 参数范围有效性验证
    fields = {'lambda', 'beta', 'rho'};
    for f = 1:length(fields)
        if numel(range.(fields{f})) ~= 2 || diff(range.(fields{f})) <= 0
            error('Invalid range for %s: must be [min,max] pair', fields{f});
        end
    end
=======
function validate_range(range)
    % 参数范围有效性验证
    fields = {'lambda', 'beta', 'rho'};
    for f = 1:length(fields)
        if numel(range.(fields{f})) ~= 2 || diff(range.(fields{f})) <= 0
            error('Invalid range for %s: must be [min,max] pair', fields{f});
        end
    end
>>>>>>> f6a4ed6 (master)
end