clear all; close all; clc;
% input_training = [0, 0;
%                   0, 1;
%                   1, 0;
%                   1, 1];
% output_training = [0, 0;
%                    1, 0;
%                    1, 0;
%                    1, 1];

load('test1.mat');
input_training = [cntl_out, err_out];
output_training = mdl_out;

NUM_SAMPLES = max(size(input_training));
NUM_EPOCHS = 100; ETA = 0.2;
sz_input = size(input_training); sz_output = size(output_training);
NUM_INP = sz_input(2); NUM_HID = 5; NUM_OUT = sz_output(2);
BIAS = -1;
error_epochs = zeros(NUM_EPOCHS);

Phi = 2*rand(NUM_HID+NUM_OUT, max(NUM_INP,NUM_HID+1))-1;
output_estimated = zeros(NUM_SAMPLES,NUM_OUT);

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
        error = - O2 + output_training(counter_sample,:)';
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
        error_epochs(counter_epoch) = error_epochs(counter_epoch) + sum(error);
    end
    error_epochs(counter_epoch)
end
[input_training output_training output_estimated]