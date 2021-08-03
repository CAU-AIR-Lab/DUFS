function [feature_idx] = socfs(X, m, W, B, E, lambda1, lambda2, ITER1, ITER2)
% This code is for the algorithm described in 
% "Unsupervised Simultaneous Orthogonal Basis Clustering Feature Selection" (CVPR 2015)
% Revised Aug, 2015 by Dongyoon Han 

%% Problem:
% min_W,b,B,E ||X'W + b1' - EB'||^2 + lambda1 * ||W||_21
% s.t. B'B = I, E'E = I, E>=0
%% Input and output:
% [Input]
% X: the data matrix
% E: the encoding matix 
% B: the orthogonal basis matrix
% W, b: the feature selection matrix and the offset vector

% [Output]
% feature_idx: indices of selected features
%% 
[d, n] = size(X);
d2 = ones(d, 1);
X = X - mean(X,2)* ones(1,n); 

H = rand(size(E));
b = zeros(m, 1);
XX = X * X';

for iter = 1 : ITER1    
    iter2 = 1;
    WXB = (W' * X + b * ones(1, n))' * B;
    while(iter2 <= ITER2)               
        [LE, ~, RE] = svd(WXB + lambda2 * H, 'econ'); E = LE * RE';
        H = 0.5 * (E + abs(E));   
        iter2 = iter2 + 1;    
    end
     
    AB = E' * (W' * X + b * ones(1, n))';
    [LE, ~, RE] = svd(AB', 'econ');
    B = LE * RE'; 
    
    EB = E * B';
    D2 = spdiags(d2, 0, d, d);
    W = (XX + lambda1 * D2) \ (X * (EB - ones(n, 1) * b'));
%      b = mean(EB' - W'*X, 2);
    d2 = 1./ (2 * (sqrt(sum(W .* W, 2) + eps)));
end

[dumb idx] = sort(sum(W.*W,2), 'descend');
feature_idx = idx;
end