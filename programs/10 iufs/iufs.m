function ret = iufs(data, num, dis)
% described in el, 2018
% sum H( f+, f_i ) - (|S|-1) H(f+)
% data: each row is sample
% implemented by lim
% ver 1.0 180403

d = size( data, 2 );

ent_f = zeros( d, 1 );
ent_ff = zeros( d, d );

if strcmp( dis, 'on' )
    data = dis_gauss( data );
end

for i=1:d
    ent_f(i, 1) = b_entropy( data(:, i) );
end
for i=1:d
    for j=i+1:d
        ent_ff(i, j) = b_entropy( [data(:, i) data(:, j)] );
    end
end
ent_ff = ent_ff + ent_ff';

ret = zeros( num, 1 );
[~, ret(1, 1)] = max( ent_f, [], 1 );
[~, ret(2, 1)] = max( ent_ff( :, ret(1, 1) ), [], 1 );

for i=3:num
    temp = zeros( d, 1 );
    for j=1:d
        if sum(ret == j) == 1
            temp(j, 1) = intmin;
        else
            temp(j, 1) = sum( ent_ff( j, ret(1:(i-1), 1) ) ) - (i-2) * ent_f( j, 1 );
        end
    end
    [~, ret(i, 1)] = max(temp, [], 1);
end




end