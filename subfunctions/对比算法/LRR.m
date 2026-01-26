<<<<<<< HEAD
function [Z,E] = LRR(X,lambda)
Q = orth(X');
A = X*Q;
[Z,E] = lrra(X,A,lambda,0);
=======
function [Z,E] = LRR(X,lambda)
Q = orth(X');
A = X*Q;
[Z,E] = lrra(X,A,lambda,0);
>>>>>>> f6a4ed6 (master)
Z = Q*Z;