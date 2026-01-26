<<<<<<< HEAD
function W_tensor = weighted_tnn_optimization(W, alpha, params)
    W_f = fft(W, [], 3);
    parfor k = 1:size(W_f,3)
        [U,S,V] = svd(W_f(:,:,k), 'econ');
        S_thresh = diag(max(diag(S) - alpha(k)*params.tau, 0));
        W_f(:,:,k) = U*S_thresh*V';
    end
    W_tensor = ifft(W_f, [], 3, 'symmetric');
end

function x = softmax(v)
    x = exp(v)/sum(exp(v));
=======
function W_tensor = weighted_tnn_optimization(W, alpha, params)
    W_f = fft(W, [], 3);
    parfor k = 1:size(W_f,3)
        [U,S,V] = svd(W_f(:,:,k), 'econ');
        S_thresh = diag(max(diag(S) - alpha(k)*params.tau, 0));
        W_f(:,:,k) = U*S_thresh*V';
    end
    W_tensor = ifft(W_f, [], 3, 'symmetric');
end

function x = softmax(v)
    x = exp(v)/sum(exp(v));
>>>>>>> f6a4ed6 (master)
end