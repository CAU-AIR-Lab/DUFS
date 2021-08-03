
function [rank_idx, A] = DISR(X,lambda1,lambda2)
%The code is written by Yanbei Liu (liuyanbei@tju.edu.cn), and details of the algorithm can be found in 
% "Unsupervised feature selection via diversity-induced self-representation"  (Neurocomputing 2017)  
% 
%our model: min ||Et||21 + lambda1||Z||21 + lambda2 tr(S^tG1G^t)
%%%--------------input-------------------------------
%X: data matrix, rows corresponds to samples  
%lambda1,lambda2: two regularization coefficients
%%%---------------output-----------------------------
%A: representation coefficient matrix
%rank_idx: rank index of features
%$--------------------------------------------------
%


[Nrow,Ncol] = size(X);
S = X'*X + eye(Ncol);
% Initialization
Z = zeros(Ncol); A = zeros(Ncol); G = zeros(Ncol);          
Y1 = zeros(Nrow,Ncol); Y2 = zeros(Ncol); Y3 = zeros(Ncol);  
E = zeros(Nrow,Ncol);               

err = 1e-4;                                              %iterative error
mu = 1e-6;  mu_max = 1e6;                                %penalty factors
rr = 1.1;                                                %penalty rate

nCount = 1;
errZ = realmax; errE = realmax;
G1 = (S' + S)\eye(Ncol);     

while (errE > err)&&(errZ > err)  
    %%%%%%%%%%%%%%%%%%%update Z
    TPMat = (A + Y2/mu)';  
    arho = lambda1/mu;   
    
    
    ZT = solve_l1l2(TPMat,arho);
    Z = ZT';                   
    
    Z = Z - diag(diag(Z));
    Z(Z<0)=0;
    %%%%%%%%%%%%%%%%%%%%%%%%update A
    A = inv(X'* X + 2*eye(Ncol))*(X'*X - X'*E + Z + G + (X'*Y1 - Y2 - Y3)/mu);
    % 
    A= A - diag(diag(A));
    A(A<0)=0;
    %%%%%%%%%%%%%%%%%%%%%%%%update E 
    TPMat2 = X - X*A + Y1/mu;  
    arho2 = 1/mu;   
    
    E = solve_l1l2(TPMat2,arho2);  
        
    %%%%%%%%%%%%%%%%%%%%%%%%update G
    G2 = (lambda2/mu)*ones(Ncol);
    G3 = -(G1 * (A + Y3/mu));
    G = lyap(G1,G2,G3);
    % 
    G = G - diag(diag(G));
    G(G<0)=0;
    %%%%%%%%%%%%%%%%%%%%%%%%update Y,W,K
    Y1 = Y1 + mu*(X-X*A-E);
    Y2 = Y2 + mu*(A-Z);
    Y3 = Y3 + mu*(A-G);
    
    %%%%%%%%%%%%%%%%%%%%update mu
    mu = min(rr*mu,mu_max);
    %
    errZ = norm(A-Z,Inf);                                     
    errE = norm(X-X*A-E,Inf)
	
    if (norm(A-Z,Inf) < err) && (norm(A-G,Inf) < err) && (norm(X-X*A-E,Inf) < err)
        break;
    end
    nCount = nCount + 1;
    if mod(nCount,5) == 0
        nCount
    end
    
end

%%row-sum ranking
a1 = sum(abs(A),2);
[~, rank_idx] = sort(a1,'descend');





