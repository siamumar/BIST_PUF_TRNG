% clc
% clear all
% close all
% 
% load seq_RO2 rand1 rand1s% load random sequence
% rand1 = [rand1(1),rand1];
% rand1s = [rand1s(1),rand1s];% while reading from memory, the first address is read twice

N = 20000;
U = 397;

H = floor(length(rand1)/N);
Csum_max_abs = zeros(1,H);

rand1 = 2*rand1-1;

for h = 1:H
    Csum = 0;
    for n = 1:N
        Csum = Csum + rand1((h-1)*N + n);
        if (abs(Csum) > Csum_max_abs(h))
            Csum_max_abs(h) = abs(Csum);
        end
    end
end


fprintf(1,'\nCumulative Sums test results:\n');
% Csum_max_abs
Csum_max_abs/U
Csum_max_abs<U