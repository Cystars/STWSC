<<<<<<< HEAD

function visualize_embedding(results, method)
    [~, score] = pca(results.Features.W);
    gscatter(score(:,1), score(:,2), results.Features.C);
    title('特征可视化');
=======

function visualize_embedding(results, method)
    [~, score] = pca(results.Features.W);
    gscatter(score(:,1), score(:,2), results.Features.C);
    title('特征可视化');
>>>>>>> f6a4ed6 (master)
end