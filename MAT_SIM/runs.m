% clc
% clear all
% close all
% 
% load seq_RO3 rand1 rand1s% load random sequence
% rand1 = [rand1(1),rand1];
% rand1s = [rand1s(1),rand1s];% while reading from memory, the first address is read twice


N = 20000; % sequence length
% limits according to Veljkovic
U = (erfcinv(.01)*(2*N)^.5+N)/2;
L = (-erfcinv(.01)*(2*N)^.5+N)/2;
% limits according to NIST doc
% U = 2*(N^.5) + N/2;
% L = -2*(N^.5) + N/2;
alpha = 0.01;
k = erfcinv(alpha);
e = L:U; % no of ones

Vmax = e.*(N-e)*(2+2*k*((2*N)^.5)/N)/N;
Vmax1 = round(Vmax);
Vmin = e.*(N-e)*(2-2*k*((2*N)^.5)/N)/N;
Vmin1 = round(Vmin);

emax1 = e(1);
emin1 = e(1);
Vmax2 = Vmax1(1);
Vmin2 = Vmin1(1);
m = 2;
n = 2;
for k = 1:length(Vmax1)-1
    if (Vmax1(k) ~= Vmax1(k+1))
        emax1(m) = e(k+1);
        Vmax2(m) = Vmax1(k);
        m = m+1;
    end
    if (Vmin1(k) ~= Vmin1(k+1))
        emin1(n) = e(k+1);
        Vmin2(n) = Vmin1(k);
        n = n+1;
    end
end
emax1(m) = e(end);
Vmax2(m) = Vmax1(end);
emin1(n) = e(end);
Vmin2(n) = Vmin1(end);

figure, subplot (2,1,1), hold on
plot (e, Vmax,'--')
plot (e, Vmax1)
plot (emax1, Vmax2, 'rx')
xlabel('No of ones')
ylabel('Upper limit for no of runs')
subplot (2,1,2) , hold on
plot (e, Vmin,'--')
plot (e, Vmin1)
plot (emin1, Vmin2, 'rx')
xlabel('No of ones')
ylabel('Lower limit for no of runs')

% [emax1;Vmax2;emin1;Vmin2];


rand1xor = [0,xor(rand1(1:end-1),rand1(2:end))];
H = floor(length(rand1)/N);
F = zeros(1,H);
R = zeros(1,H);
p1 = ones(1,H);
p2 = ones(1,H);
pass = ones(1,H);

figure

for h = 1:H    
    R(h) = sum(rand1xor((h-1)*N+1:h*N))+1;
    F(h) = sum(rand1((h-1)*N+1:h*N));
    % fprintf(1,'\n%s\n%s %d\n',rand1s((h-1)*N+1:h*N), regexprep(num2str(rand1xor((h-1)*N+1:h*N)),'[^\w'']',''),R(h)-1);
    if ((F(h) < L) || (F(h) > U))
        pass(h) = 0;
    else
        for k = 2:length(emax1)
            if (F(h) < emax1(k))
                UR = Vmax2(k);  
                break              
            end                
        end
        for k = 2:length(emin1)
            if (F(h) < emin1(k))
                LR = Vmin2(k);  
                break                
            end              
        end  
        p1(h) = (R(h) < UR);
        p2(h) = (R(h) > LR);
        pass(h) = p1(h)&p2(h);
        
        subplot(2,1,1)
        plot(F(h),UR,'go')
%         plot(F(h),R(h),'rs')
        subplot(2,1,2)
        plot(F(h),LR,'go')
%         plot(F(h),R(h),'rs')
    end

end
fprintf(1,'Frequency test result');
((F < U) & (F > L))
% F
fprintf(1,'Normalized distance from ideal value');
2*(F-(U+L)/2)/(U-L)
fprintf(1,'Runs test result');
pass
% R
if (max(((F < U) & (F > L))))
fprintf(1,'Normalized distance from ideal value\n');
2*(R-(UR+LR)/2)/(UR-LR)
end





