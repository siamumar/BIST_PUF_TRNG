a = [0.2148 0.3672 0.2305 0.1875]; % pi
ainv = 1./a;
ainvb = dec2bin(ainv*1024);

x = 12;
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

n = 16;
M = 8;
k = 3;
alpha = 0.01;

limit = int32((gammaincinv((1-alpha),k/2)*2*n + n^2)*1024);