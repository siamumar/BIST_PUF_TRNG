clc
clear all
close all 

Data = {'load ','seq_PDL1 '};

internal = 1;

% rand1 = zeros(1,8192*8);
eval(cell2mat([' ',Data(1) ,Data(2)])); % load random sequence
if (internal)
    rand1 = R1;
end
runs

eval(cell2mat([' ',Data(1) ,Data(2)])); % load random sequence
if (internal)
    rand1 = R1;
end
Frequency_Block

eval(cell2mat([' ',Data(1) ,Data(2)])); % load random sequence
if (internal)
    rand1 = R1;
end
longest_run_of_ones

eval(cell2mat([' ',Data(1) ,Data(2)])); % load random sequence
if (internal)
    rand1 = R1;
end
non_overlapping_template

% overlapping_template

eval(cell2mat([' ',Data(1) ,Data(2)])); % load random sequence
if (internal)
    rand1 = R1;
end
Cumulative_Sums

close all