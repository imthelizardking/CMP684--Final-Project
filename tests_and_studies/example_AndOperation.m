% from M.Ö.E. CMP684 Slides, page 70
clear all;
close all;
clc;
U = [0 0;0 1;1 0;1 1];
Y = [0 0 0 1]';
Phi = 2*rand(3,1)-1;
Eta = 0.8;
PHI(1,:)=Phi';
for count=1:1000
    epoche_error(count) = 0;
    for sample=1:4
        inputvector=[U(sample,:)';-1];
        Yn(sample) = 1/(1+exp(-(Phi'*inputvector)));
        errorvector = Y(sample)-Yn(sample);
        Phi=Phi+Eta*errorvector*Yn(sample)*(1-Yn(sample))*inputvector;
        PHI((count-1)*4+sample+1,:)=Phi';
        epoche_error(count) = epoche_error(count) + errorvector'*errorvector;
    end
    epoche_error(count)
end
[U,Y,Yn']