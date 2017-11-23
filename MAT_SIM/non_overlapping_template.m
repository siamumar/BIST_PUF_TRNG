% clc
% clear all
% close all
% 
% load seq_RO2 rand1 rand1s% load random sequence
% rand1 = [rand1(1),rand1];
% rand1s = [rand1s(1),rand1s];% while reading from memory, the first address is read twice

n = 8;
M = 256;
m = 4;
N = n*M;
alpha = 0.01;

% rand1 = rand1(1:N*2);
% rand1s = rand1s(1:N*2);

r = 16; %multiply both mu by r and U by r^2 to increase precision
mu = (M-m+1)/(2^m)*r; 
sigma = M*((1/(2^m)) - (2*m-1)/(2^(2*m)));
U = 2*sigma*gammaincinv((1-alpha), n/2)*(r^2);
B = [1 1 0 0];

H = floor(length(rand1)/N);
chi_sqr = zeros(1, H);

for h = 1:H
    W = zeros(1,n);
    for j = 1:n
        k = 1;
        while (k <= M-m+1)
            if (min(rand1((h-1)*N+(j-1)*M+k:(h-1)*N+(j-1)*M+k+m-1) == B))
                W(j) = W(j) + 1;
            end
            k = k + 1;
        end
    end
    chi_sqr(h) = sum((r*W - mu).^2);
end

fprintf(1,'\nNonoverlapping Template Matching test results:\nPass rate');
mean(chi_sqr < U)*100

