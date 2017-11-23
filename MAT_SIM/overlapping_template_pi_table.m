clc
a = [0.364091, 0.185659, 0.139381, 0.100571, 0.0704323, 0.139865]; % pi
ainv = 1./a;
r = 10;
ainvb = dec2bin(ainv*(2^r));
int32(ainv*(2^r))

x = floor(log2(max(1./a)*1024));
while(x+1)
fprintf(1,'%d\t',x);
x=x-1;
end 
fprintf('\n');

[r, c] = size(ainvb);
for m = 1:r
    for n = 1:c        
        fprintf(1,'%d\t',ainvb(m,n)-48);
    end
    fprintf('\n');
end

