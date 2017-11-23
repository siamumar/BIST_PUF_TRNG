% clc
% clear all
% close all
% 
% load seq_RO3 rand1 rand1s% load random sequence
% rand1 = [rand1(1),rand1];
% rand1s = [rand1s(1),rand1s];% while reading from memory, the first address is read twice

n = 100;
M = 200;
N = n*M;
alpha = 0.01;
U = gammaincinv((1-alpha), n/2)*M/2;

H = floor(length(rand1)/N);
chi_sqr = zeros(1,H);
for h = 1:H
    blk_F = zeros(1,n);
    for k = 1:n
%         rand1s((h-1)*N+(k-1)*M+1:(h-1)*N+k*M)
        blk_F(k) = sum(rand1((h-1)*N+(k-1)*M+1:(h-1)*N+k*M));
%         fprintf('%d, %d, %d \n',h, k,blk_F(k));
    end
    chi_sqr(h) = sum((blk_F-M/2).^2);
end

fprintf(1,'\nBlock Frequency test results:\n');
fprintf(1,'chi_sqr:\n');
for k = 1:H
    fprintf(1,'%0.3f \t',chi_sqr(k));
end
fprintf(1,'\n');

fprintf(1,'chi_sqr normalized by upper limit:\n');
for k = 1:H
    fprintf(1,'%0.3f \t',chi_sqr(k)/U);
end
fprintf(1,'\n');

fprintf(1,'pass:\t');
for k = 1:H
    fprintf(1,'%d \t',(chi_sqr(k) < U));
end
fprintf(1,'\n');
