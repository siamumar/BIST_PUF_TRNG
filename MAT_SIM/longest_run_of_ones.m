% clc
% clear all
% close all
% 
% load seq_RO2 rand1 rand1s% load random sequence
% rand1 = [rand1(1),rand1];
% rand1s = [rand1s(1),rand1s];% while reading from memory, the first address is read twice

n = 16;
M = 8;
k = 3;
N = n*M;
alpha = 0.01;
mult = 1024;

U = (gammaincinv((1-alpha),k/2)*2*n + n^2)*mult;

a = [0.2148 0.3672 0.2305 0.1875];
ainv = 1./a;

H = floor(length(rand1)/N);
v0 = zeros(1,H);
v1 = zeros(1,H);
v2 = zeros(1,H);
v3 = zeros(1,H);
chi_sqr = zeros(1,H);

for h = 1:H
    for k = 1:n
        r = 0;
        R = 0;
%         rand1s((h-1)*N+(k-1)*M+1:(h-1)*N+k*M)
        for l = 1:M
            if (rand1((h-1)*N+(k-1)*M+l))
                r = r + 1;
            else
                if (r > R)
                    R = r;
                end
                r = 0;
            end
%              fprintf('%d',r);
        end
        if (r > R)
            R = r;
        end
%          fprintf(1,'\n%d %d, %d \n',h, k-1, R);
        if (R <= 1)
            v0(h) = v0(h) + 1;
        elseif (R == 2)
            v1(h) = v1(h) + 1;
        elseif (R == 3)
            v2(h) = v2(h) + 1;
        else
            v3(h) = v3(h) + 1;
        end
    end
    
    chi_sqr(h) = sum(([v0(h), v1(h), v2(h), v3(h)].^2).*ainv)*mult;
end

% disp(chi_sqr)
% (chi_sqr < U)
% [v0(1), v1(1), v2(1), v3(1)]
% [v0(2), v1(2), v2(2), v3(2)]
% [v0(3), v1(3), v2(3), v3(3)]
figure
subplot(2,1,1),hold on
stem(chi_sqr,'k.')
plot(U*ones(1,H),'rx')
subplot(2,1,2),hold on
plot(v0,'r.')
plot(v1,'gx')
plot(v2,'bo')
plot(v3,'ys')
legend ('v0','v1','v2','v3')
% plot(mean(chi_sqr)*ones(1,H),'gx')
fprintf(1,'\nLongest Run of Ones test results:\n');
fprintf(1,'pass rate: %0.2f \n',mean(chi_sqr < U)*100);
% 
% figure,
% subplot(2,1,1),hold on
% plot(v3,'b.')
% plot(v2,'y.')
% plot(v1,'r.')
% plot(v0,'g.')
% legend('v3','v2','v1','v0')
% subplot(2,1,2),hold on
% plot(v0,'g.')
% plot(v1,'r.')
% plot(v2,'y.')
% plot(v3,'b.')
