function ret = cal_lapla_rbf( data )
sigma = 1;

n = size( data, 1 );

ret = zeros(n, n);

for i=1:n
    for j=i+1:n
        t = data(i, :) - data(j, :);
        ret(i, j) = -exp( -sum(t.^2)/(sigma^2) );
    end
end
ret = ret + ret';
for i=1:n
    ret(i, i) = -sum(ret(:, i));
end

end