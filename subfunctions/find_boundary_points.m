<<<<<<< HEAD
% function idx = find_boundary_points(projections)
%     [~, score] = pca(projections);
%     [~, idx] = sort(score(:,1), 'descend');
%     idx = idx(1:ceil(0.2*length(idx)));
% end

function idx = find_boundary_points(projections)
    % 使用KNN不确定性检测
    [n, ~] = size(projections);
    D = pdist2(projections, projections);
    [~, idx] = sort(std(D, 0, 2), 'descend');
    idx = idx(1:ceil(0.2*n)); % 取20%最不确定点
=======
% function idx = find_boundary_points(projections)
%     [~, score] = pca(projections);
%     [~, idx] = sort(score(:,1), 'descend');
%     idx = idx(1:ceil(0.2*length(idx)));
% end

function idx = find_boundary_points(projections)
    % 使用KNN不确定性检测
    [n, ~] = size(projections);
    D = pdist2(projections, projections);
    [~, idx] = sort(std(D, 0, 2), 'descend');
    idx = idx(1:ceil(0.2*n)); % 取20%最不确定点
>>>>>>> f6a4ed6 (master)
end