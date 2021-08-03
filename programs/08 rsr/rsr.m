function ret = rsr( data, lambda )
% implemeted by lim
% ufs by regularized self-representation, 2015, pr

[n, d] = size( data );

gl = eye( n );
gr = eye( d );

iter = 10;

w = zeros( d, d );

for i=1:iter
	w = ( gr \ data' * gl * data * lambda * eye(d) ) \ ( gr \ data' * gl * data );
    
	t_data = data - ( data * w );

	for j=1:n
		gl(j, j) = 1 / ( max( [eps; 2 * sqrt( sum(t_data(j, :).^2) )] ) );
	end

	for j=1:d
		gr( j, j ) = 1 / ( max([eps; 2*sqrt(sum(w(j, :).^2))]) );
	end

end

[~, ret] = sort(sum(w.^2, 2), 'descend');

end