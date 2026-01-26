<<<<<<< HEAD
function Z = LSR(X, lambda)
    % 最小二乘回归亲和矩阵（补充.pdf中缺失的实现）
    [~,n] = size(X);
    if n < size(X,1)
        Z = (X'*X + lambda*eye(n)) \ (X'*X);
    else
        Z = X' / (X*X' + lambda*eye(size(X,1))) * X;
    end
    Z = 0.5*(abs(Z) + abs(Z'));
=======
function Z = LSR(X, lambda)
    % 最小二乘回归亲和矩阵（补充.pdf中缺失的实现）
    [~,n] = size(X);
    if n < size(X,1)
        Z = (X'*X + lambda*eye(n)) \ (X'*X);
    else
        Z = X' / (X*X' + lambda*eye(size(X,1))) * X;
    end
    Z = 0.5*(abs(Z) + abs(Z'));
>>>>>>> f6a4ed6 (master)
end