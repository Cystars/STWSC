function [Omega_m, Omega_c] = generate_pair_constraints(gt, p)
true_labels = gt(:); 
n = numel(true_labels);
if n < 2
    Omega_m = [];
    Omega_c = [];
    return;
end

N = n * (n - 1) / 2;
num_select = round(p * N);
if num_select == 0
    Omega_m = [];
    Omega_c = [];
    return;
end

rng(42);
selected_k = randperm(N, num_select);
k = selected_k(:); 
i = floor(((2*n - 1) - sqrt((2*n - 1)^2 - 8*(k - 1))) / 2) + 1;
sum_i_prev = (i - 1) .* n - (i - 1) .* i / 2;
offset = k - sum_i_prev;
j = i + offset;

i = max(min(i, n), 1);
j = max(min(j, n), 1);

labels_i = true_labels(i);
labels_j = true_labels(j);
is_must = (labels_i == labels_j);

Omega_m = [i(is_must), j(is_must)];
Omega_c = [i(~is_must), j(~is_must)];

Omega_m = max(min(Omega_m, n), 1);
Omega_c = max(min(Omega_c, n), 1);
end