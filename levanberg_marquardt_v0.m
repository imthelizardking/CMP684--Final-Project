clear all; close all; clc; %load('test_data1.mat');
DIM_INP = 1; DIM_HID = 10; DIM_OUT = 1; NUM_LAYERS = 3;
NUM_EPOCHS = 1; ETA = 0.2;

NUM_WEIGHTS = 10; % ! fix
% !normalize inp and out
% for test purpose
test_input = 1:10; test_output = test_input.^1.98;

U = test_input; NUM_SAMPLES = max(size(U)); % input
test_output = test_output/abs(max(test_output)); % normalize
Y = test_output; % output
m = 1; % nü
w = (1*rand(DIM_HID*2+DIM_HID+1,1)-1);
E = [];
for counter_epoch=1:NUM_EPOCHS    
    for counter_pair=1:NUM_SAMPLES
        u = U(counter_pair); % set input
        for counter_output=1:DIM_OUT
            out1 = tanh(w(1+DIM_HID*2:end)' * diag([repelem(u,DIM_HID),-1]));
            %for counter_weights=1:NUM_WEIGHTS
                temp1 = [1-tanh(u)^2, tanh(u)^2-1];
                J_temp1 = repmat(temp1,[1,DIM_HID]);                
                J(counter_pair,:) = [J_temp1, out1];
            %end
        end
    tau = out1*w(1+DIM_HID*2:end);
    E = [E,(Y(counter_pair)-tau)];
    end
    w = w - inv(m*eye(size(J'*J))+J'*J)*J'*E';
end