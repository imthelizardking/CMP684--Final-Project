clear all; close all; clc;
load('pretraining_weights.mat'); load('test_set.mat');
pretraining_weights = PHI(end,:);
estimated_output = zeros(size(test_inputs));
temp_Vec = -0.1 * ones(size(test_inputs));
test_inputs = [test_inputs,temp_Vec];
for i=1:max(size(test_inputs))
    e_x = exp((pretraining_weights*test_inputs(i,:)')); e_x_n = exp(-(pretraining_weights*test_inputs(i,:)'));
    estimated_output(i) = (e_x - e_x_n) / (e_x + e_x_n); %tanh
end
plot(estimated_output,'DisplayName','estimated_output');hold on;plot(test_outputs,'DisplayName','test_outputs');hold off;