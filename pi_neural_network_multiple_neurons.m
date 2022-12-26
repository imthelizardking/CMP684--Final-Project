% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This is a template for training a NN-PI controller
% 
%
%
%
%
%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
clear all; close all; clc; load('test_data1.mat');
DIM_INP = 1; DIM_HID = 10; DIM_OUT = 1; NUM_LAYERS = 3;
NUM_EPOCHS = 100; ETA = 0.2;
w0 = 1*rand(DIM_HID,DIM_INP+1)-1; w1 = 1*rand(DIM_OUT,DIM_HID+1)-1;
test_input = test_input/abs(max(test_input)); % normalize
U = test_input; NUM_SAMPLES = max(size(U)); % input
U(1) = U(2);
test_output = test_output/abs(max(test_output)); % normalize
Y = test_output; % output
Y(1) = Y(2);
for counter_epoch=1:NUM_EPOCHS
    sample_error = 0;
    for counter_sample=1:NUM_SAMPLES
        % FORWARD PASS
        input = [U(counter_sample)';-1];
        S1 = w0*input; % vector of hidden layer input sums
        O1 = tanh(S1); % hidden layer outputs
        S2 = w1*[O1;-1]; O2=S2; Tau=S2;
        % CALCULATE ERROR
        % TO-DO: extend to LM
        e = Tau - Y(counter_sample);
        % BACKWARD PASS
        w1_delta = ETA*e*1*[O1;-1];
        w0_delta = ETA*e*reshape((repelem(w1(1:DIM_HID),2)*diag(repelem(O1,2)))'*U(counter_sample),[DIM_HID,DIM_INP+1]);
        %w0_delta = ETA*e*w1*(1-[O1;-1].*[O1;-1])*input;
        w0 = w0 - w0_delta; w1 = w1 - w1_delta';
        sample_error = sample_error + e;
    end
    sample_error
end
