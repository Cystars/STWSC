<<<<<<< HEAD
function [Omega, B] = sample_pairs(idx, labels, ratio)
    n = length(idx);
    Omega = [];
    B = [];
    for i = 1:ceil(n*ratio)
        j = randi(n); k = randi(n);
        Omega = [Omega; idx(j), idx(k)];
        B = [B; labels(idx(j)) == labels(idx(k))];
    end
=======
function [Omega, B] = sample_pairs(idx, labels, ratio)
    n = length(idx);
    Omega = [];
    B = [];
    for i = 1:ceil(n*ratio)
        j = randi(n); k = randi(n);
        Omega = [Omega; idx(j), idx(k)];
        B = [B; labels(idx(j)) == labels(idx(k))];
    end
>>>>>>> f6a4ed6 (master)
end