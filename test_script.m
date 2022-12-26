clear all;clc;
load('trained_weights1.mat'); load('test_data1.mat');
%%
phi_ = PHI(end,:);
outp = zeros(size(test_input));
for i=1:max(size(test_input))
    outp(i) = phi_* [test_input(i);-5];
end
plot(outp,'DisplayName','outp');hold on;plot(test_output,'DisplayName','test_output');hold off;