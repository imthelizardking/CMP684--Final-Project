clear all;
close all;
clc;
% load('test1.mat');
% U = [cntl_out, err_out]; Y = mdl_out;
U = [0 0;0 1;1 0;1 1];
Y = [0 0 0 1]';
Phi = 2*rand(3,1)-1;
Eta = 0.8;
PHI(1,:)=Phi';
for count=1:100
    epoche_error(count) = 0;
    for sample=1:max(size(U))
        inputvector=[U(sample,:)';-1];
        Yn(sample) = 1/(1+exp(-(Phi'*inputvector)));
        errorvector = Y(sample)-Yn(sample);
        Phi=Phi+Eta*errorvector*Yn(sample)*(1-Yn(sample))*inputvector;
        PHI((count-1)*max(size(U))+sample+1,:)=Phi';
        epoche_error(count) = epoche_error(count) + errorvector'*errorvector;
    end
    epoche_error(count)
end
[U,Y,Yn']