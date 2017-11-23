% clc
% clear all
% close all
% 
% load seq_SR1 rand1 rand1s% load random sequence
% rand1 = [rand1(1),rand1];
% rand1s = [rand1s(1),rand1s];% while reading from memory, the first address is read twice

N = 20000;
% N =  length(rand1);
U = (erfcinv(.01)*(2*N)^.5+N)/2;
L = (-erfcinv(.01)*(2*N)^.5+N)/2;

H = floor(length(rand1)/N);
F = zeros(1,H);

for h = 1:H
    F(h) = sum(rand1((h-1)*N+1:h*N));
end

fprintf(1,'\nFrequency test results:\n');
F
2*(F-(U+L)/2)/(U-L)
((F < U) & (F > L))