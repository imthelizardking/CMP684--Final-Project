clear all; close all; clc;
% input_training = [0, 0;
%                   0, 1;
%                   1, 0;
%                   1, 1];
% output_training = [0, 0;
%                    1, 0;
%                    1, 0;
%                    1, 1];

% load('lp_step.mat');
% input_training =  nn_c; input_training = input_training(1:200);
% output_training = nn_y; output_training = output_training(1:200);

% load('gtcs_math_step_500.mat');
load('gtcs_math_sine_400.mat');
% %%  FM
% c_train = (out.c-(min(out.c)+max(out.c))/2)/((max(out.c)-min(out.c))/2);
% c_pre_train = (out.c_pre-(min(out.c_pre)+max(out.c_pre))/2)/((max(out.c_pre)-min(out.c_pre))/2);
% y_pre_train = (out.y_pre-(min(out.y_pre)+max(out.y_pre))/2)/((max(out.y_pre)-min(out.y_pre))/2);
% y_pre_pre_train = (out.y_pre_pre-(min(out.y_pre_pre)+max(out.y_pre_pre))/2)/((max(out.y_pre_pre)-min(out.y_pre_pre))/2);
% y_train = (out.y-(min(out.y)+max(out.y))/2)/((max(out.y)-min(out.y))/2);
% sf = [((max(out.y)-min(out.y))/2) ((min(out.y)+max(out.y))/2)];
% input_training = [c_train, c_pre_train, y_pre_train,y_pre_pre_train];
% output_training = y_train;
%%  IM
c_train = (out.c-(min(out.c)+max(out.c))/2)/((max(out.c)-min(out.c))/2);
output_training = c_train;
y_train = (out.y-(min(out.y)+max(out.y))/2)/((max(out.y)-min(out.y))/2);
input_training = y_train;
%%
NUM_SAMPLES = max(size(input_training));
% NUM_EPOCHS = 50; ETA = 0.2;
NUM_EPOCHS = 15; ETA = 0.02;
sz_input = size(input_training); sz_output = size(output_training);
NUM_INP = sz_input(2); NUM_HID = 3; NUM_OUT = sz_output(2);
BIAS = -.1;
error_epochs = zeros(NUM_EPOCHS,1);

% Phi = 2*rand(NUM_HID+NUM_OUT, max(NUM_INP,NUM_HID+1))-1;
Phi = zeros(NUM_HID+NUM_OUT, max(NUM_INP,NUM_HID+1));
output_estimated = zeros(NUM_SAMPLES,NUM_OUT);
k = 0;
for counter_epoch=1:NUM_EPOCHS
    for counter_sample=1:NUM_SAMPLES 
        Phi_delta = zeros(NUM_HID+NUM_OUT, max(NUM_INP,NUM_HID+1));
        input_vector = [input_training(counter_sample,:)';BIAS];
        % FORWARD PASS:
        S1 = Phi(1:NUM_HID,1:NUM_INP+1)*input_vector;
        O1 = tanh(S1);
        S2 = Phi(NUM_HID+1:end,1:NUM_HID+1)*[O1;BIAS];
        O2 = S2;
        output_estimated(counter_sample,:) = O2';
        error = output_training(counter_sample,:)' - O2;        
%         error = sqrt((output_training(counter_sample,:)' - O2).^2);
        % BACKWARD PASS:
        % W1:
        for counter_outputs=1:NUM_OUT
            Phi_delta(NUM_HID+1:end,1:NUM_HID+1) ...
                = Phi_delta(NUM_HID+1:end,1:NUM_HID+1) + ...
                  ETA * error(counter_outputs) * ...
                  [O1;BIAS]';
        end
        % W0:
        input_vector_repeated = [];
        for counter_repeat=1:NUM_HID
            input_vector_repeated = [input_vector_repeated; input_vector'];
        end
        for counter_outputs=1:NUM_OUT
            Phi_delta(1:NUM_HID,1:NUM_INP+1)...
                = Phi_delta(1:NUM_HID,1:NUM_INP+1) +...
                  ETA * error(counter_outputs) * ...
                  Phi(NUM_HID+counter_outputs,:) * ...
                  (1 - [O1;BIAS].^2) * ...
                  input_vector_repeated;
        end
        Phi = Phi + Phi_delta;
%         error_epochs(counter_epoch) = error_epochs(counter_epoch) + sum(error);
        error_epochs(counter_epoch) = error_epochs(counter_epoch) + sqrt(error'*error);
    end
    error_epochs(counter_epoch)
%     err_sum = zeros(max(size(input_training)),1);
%     for counter_test_error=1:max(size(input_training))
%         input_vector = [input_training(counter_test_error,:)';BIAS];
%         S1 = Phi(1:NUM_HID,1:NUM_INP+1)*input_vector;
%         O1 = tanh(S1);
%         S2 = Phi(NUM_HID+1:end,1:NUM_HID+1)*[O1;BIAS];
%         y_hat = S2;
%         err_sum = err_sum + (output_training(counter_test_error) - y_hat);
%     end
end
% % % [input_training output_training output_estimated];
% % % Phi;
% %%
% weight_saving_name = 'forward_plant';
% save(weight_saving_name,'Phi');