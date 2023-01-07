% load('lp_chirp_0.1_to_0.5.mat');
% FORWARD PASS:
% input_training = [out.c, out.c_pre, out.y_pre,out.y_pre_pre];
% input_training = [c_train, c_pre_train, y_pre_train,...
%                   y_pre_pre_train];
% output_training = out.y;
c_ = (min(out.c)+max(out.c))/2;
r_ = ((max(out.c)-min(out.c))/2);
%%
for counter=1:max(size(input_training))
    input_vector = [input_training(counter,:)';BIAS];
    S1 = Phi(1:NUM_HID,1:NUM_INP+1)*input_vector;
    O1 = tanh(S1);
    S2 = Phi(NUM_HID+1:end,1:NUM_HID+1)*[O1;BIAS];
    y_(counter,:) = S2*r_+c_;
end
training_c = out.c; training_c_pre = out.c_pre;
training_y_pre = out.y_pre; training_y_pre_pre = out.y_pre_pre;
prediction_c = y_;
plot(training_c,'DisplayName','training_c');hold on;plot(prediction_c,'DisplayName','prediction_c');hold off;