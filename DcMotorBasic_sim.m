close all; clear all; clc;
Kt = 1; Ke = 1; L = 1e-6; R = 1e-03; J = 1e-03; B = 5e-03;
numerator = Kt;
denominator1 = [L, R]; denominator2 = [J, B];
denominator = [L*J, L*B+R*J, R*B+Kt*Ke];
modelDcMotorBasic = tf(numerator, denominator);
% stepplot(modelDcMotorBasic);
t = 0:0.01:4;
u = sin(10*t);
lsim(modelDcMotorBasic,u,t)   % u,t define the input signal