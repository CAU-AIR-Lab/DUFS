function ret = maxvar( data )

d = size( data, 2 );
ret = (1:d)';
ret(:, 2) = var( data )';
ret = sortrows( ret, -2 );
ret = ret(:, 1);

end