function [feature_idx] = dufs(data, class_size, lambda1, lambda2, lambda3)
% Revised by Lim, 180403
% data: each row is sample

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
X = data';
ITER1 = 10;
ITER2 = 10;

[d, n] = size(X);
d2 = ones(d, 1);
X = X - mean(X,2)* ones(1,n); 

m = class_size;
W = rand( d, m );
B = qr( rand( m, m ), 0 );
E = qr( rand( n, m ), 0 );

H = rand(size(E));
b = zeros(m, 1);
XX = X * X';
q = calqmi(data);

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
    W = (XX + lambda1 * D2 + lambda3 * q) \ (X * (EB - ones(n, 1) * b'));
%      b = mean(EB' - W'*X, 2);
    d2 = 1./ (2 * (sqrt(sum(W .* W, 2) + eps)));
end

[~, feature_idx] = sort(sum(W.*W,2), 'descend');
end