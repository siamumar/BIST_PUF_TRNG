% clc
% clear all
% close all
% 
% load seq_long rand1 %rand1s% load random sequence
% rand1 = [rand1(1),rand1];
% rand1s = [rand1s(1),rand1s];% while reading from memory, the first address is read twice

n = 1000;
M = 1032;
m = 9;
K = 5;
N = n*M;
alpha = 0.01;
r = 10;

% 
% rand1 = rand1(1:N);
% rand1s = rand1s(1:N);
% rand1 = [rand1, ones(1, length(rand1))];

a = [0.364091, 0.185659, 0.139381, 0.100571, 0.0704323, 0.139865];
     
U = (2*n*gammaincinv((1-alpha), K/2) + (n^2))*(2^r);
B = [1 1 1 1 1 1 1 1 1];

H = floor(length(rand1)/N);
chi_sqr = zeros(1, H);
V = zeros(H, K+1);

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
    for l = 1:K
        V(h,l) = length(find(W == (l-1)));
    end
    V(h,K+1) = length(find(W >= K));
    chi_sqr(h) = (sum((V(h,:).^2)./a)*(2^r));
end

fprintf(1,'\nNonoverlapping Template Matching test results:\n');
mean(chi_sqr < U)*100

