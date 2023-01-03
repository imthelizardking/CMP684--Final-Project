clear all;clc
mult = zeros(10,10);
u = [0.7845, -1];
for i=1:10
	mult(i,1+(i-1)*2:1+(i-1)*2+1) = u;
end		
mult

u = magic(1,11); u(11) = -1;
