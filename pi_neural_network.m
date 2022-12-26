% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This is a template for training a NN-PI controller
% 
%
%
%
%
%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% clear all; close all; clc;
% load('temp_signals_2.mat');
DIM_INP = 1; DIM_HID = 10; DIM_OUT = 1;
speed_pi_input = speed_pi_input/abs(max(speed_pi_input)); % normalize
U = speed_pi_input;
nSamples = max(size(U));
speed_pi_output = speed_pi_output/abs(max(speed_pi_output)); % normalize
Y = speed_pi_output;
Phi = 1*rand(DIM_INP+1,1)-1; % randomly start weights (3x1)
Eta = 1;
PHI(1,:)=Phi'; % weight dictionary
for count=1:5
    epoche_error(count) = 0;
    for sample=1:nSamples
        inputvector=[U(sample,:)';-0.1]; % inputvector = inputs + bias
        e_x = exp((Phi'*inputvector)); e_x_n = exp(-(Phi'*inputvector)); %tanh
        Yn(sample) = (e_x - e_x_n) / (e_x + e_x_n); %tanh
        errorvector = Y(sample)-Yn(sample);
        Phi=Phi+Eta*errorvector*(2/(e_x+e_x_n))^2*inputvector; %tanh
        PHI((count-1)*(DIM_INP+1)+sample+1,:)=Phi';
        epoche_error(count) = epoche_error(count) + errorvector'*errorvector;
    end
    epoche_error(count)
end
[U,Y,Yn']