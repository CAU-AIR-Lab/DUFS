function res = b_entropy( vector )

count = accumarray( (vector * (2.^((1:size(vector,2))-1))')+1, 1 );
count( count == 0 ) = [];
res = -( (count/size(vector,1))'*log2( (count/size(vector,1)) ) );