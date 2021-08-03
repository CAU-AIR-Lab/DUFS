function ret = calqmi( data )
% row of data is sample
% q_{i, j} = I(f_i, f_j)
% q_{i, i} = sum( q(i, :) )

d = size(data, 2);
ret = zeros( d, d );
ent_f = zeros( d, 1 );
for i=1:d
    ent_f( i, 1 ) = b_entropy( data(:, i) );
end
for i=1:d
    for j=i+1:d
        ret(i, j) = ent_f(i, 1) + ent_f(j, 1) - b_entropy( [data(:, i), data(:, j)] );
    end
end
ret = ret + ret';
for i=1:d
    ret(i, i) = sum(ret(:, i));
end

end