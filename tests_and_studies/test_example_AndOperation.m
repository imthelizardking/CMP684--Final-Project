% from M.Ö.E. CMP684 Slides, page 70
% Yn:NN output Y:Ref. Output U:Ref. Input
% Here's what happens: 
% This is a 2 by 3 by 1 Neural Network
% Input/output pairs: U,Y
% Phi: weight vector, PHI: weight dictionary
% 1000 iterations
% For each sample (4 of them):
% input vector = u(1), where u is length 2, and bias -1 for bias term input
% sigmoid(Phi,inputvector), sigmoid gives estimated NN output, is a
% function of inputs and weights
% Then calculate error, errovector
% Then update weight, Phi=...
% Add new weight vector to PHI, weight matrix
% Add up the epoche_error
clear all; close all; clc;
nInputLength = 1;
U = [1;2;3;4];
nSamples = max(size(U));
Y = [0.2;0.4;0.75;1]';
Phi = [2;0];%rand(nInputLength+1,1)-1; % randomly start weights (3x1)
Eta = 0.8;
PHI(1,:)=Phi'; % weight dictionary
for count=1:200
    epoche_error(count) = 0;
    for sample=1:nSamples
        inputvector=[U(sample,:)';-1]; % inputvector = inputs + bias
        Yn(sample) = 1/(1+exp(-(Phi'*inputvector))); % NN output = sigmoid(weights,input)
        errorvector = Y(sample)-Yn(sample);
        Phi=Phi+Eta*errorvector*Yn(sample)*(1-Yn(sample))*inputvector;
        PHI((count-1)*(nInputLength+1)+sample+1,:)=Phi';
        epoche_error(count) = epoche_error(count) + errorvector'*errorvector;
    end
    epoche_error(count)
end
[U,Y',Yn']