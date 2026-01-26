<<<<<<< HEAD
function [CKSym] = SSC(X,r,affine,alpha,outlier,rho)

if (nargin < 6)
    rho = 1;
end
if (nargin < 5)
    outlier = false;
end
if (nargin < 4)
    alpha = 20;
end
if (nargin < 3)
    affine = false;
end
if (nargin < 2)
    r = 0;
end

% n = max(s);
Xp = DataProjection(X,r);

if (~outlier)
    CMat = admmLasso_mat_func(Xp,affine,alpha);
     C = CMat;
else
    CMat = admmOutlier_mat_func(Xp,affine,alpha);
    N = size(Xp,2);
    C = CMat(1:N,:);
end

CKSym = BuildAdjacency(thrC(C,rho));
% grps = SpectralClustering(CKSym,n);
% grps = bestMap(s,grps);
=======
function [CKSym] = SSC(X,r,affine,alpha,outlier,rho)

if (nargin < 6)
    rho = 1;
end
if (nargin < 5)
    outlier = false;
end
if (nargin < 4)
    alpha = 20;
end
if (nargin < 3)
    affine = false;
end
if (nargin < 2)
    r = 0;
end

% n = max(s);
Xp = DataProjection(X,r);

if (~outlier)
    CMat = admmLasso_mat_func(Xp,affine,alpha);
     C = CMat;
else
    CMat = admmOutlier_mat_func(Xp,affine,alpha);
    N = size(Xp,2);
    C = CMat(1:N,:);
end

CKSym = BuildAdjacency(thrC(C,rho));
% grps = SpectralClustering(CKSym,n);
% grps = bestMap(s,grps);
>>>>>>> f6a4ed6 (master)
% missrate = sum(s(:) ~= grps(:)) / length(s);