clear all ;
clc;
%% Load data
% data=load('simplefit_dataset');
% x=data.simplefitInputs'; 
% y=data.simplefitTargets';
load('C:\Users\Yusuf\Documents\MATLAB\CMP684--Final-Project\temp_signals_2.mat');
q_in = q_in/abs(max(q_in)); % normalize
x = q_in;
q_out = q_out/abs(max(q_out)); % normalize
y = q_out;
%% Initialize parameters
desired_error=1e-3;
Learning_Rate=0.1;
hidden_layers=[5];
plotting='yes';
%% Training
[net]=BP_TB(x,y,desired_error,Learning_Rate,hidden_layers,plotting);
%%%%%%%%%%% prediction
%% Prediction 
[outputs]=predict(net,x);
%%% Illustration
figure(2)
plot(x,y,'+-r',x,outputs,'+-b');
legend('original values','predicted values');
grid
