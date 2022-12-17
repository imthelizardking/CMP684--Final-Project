close all; clear all; clc;
% Number of points in each class
N=50;
% Amount of intersection in between the classes
% If Intersect>0 then there will be some overlap in between the classes
Overlap = 0;
% Positive class point coordinates
U1 = rand(N,3)-Overlap;
% Negative class point coordinates
U2 = -rand(N,3)+Overlap;
% Positive class output
Y1 = ones(N,1);
% Negative class output
Y2 = -ones(N,1);
% Concatenate the input coordinates
U = [U1;U2];
% COncatenate the output coordinates
Y = [Y1;Y2];
% Initial values of the adjustable parameter vector
Phi = [-0.2 -0.6 0]';
% Learning rapte
Eta = 0.01;
% Data collection variable for Phi
PHI(1,:)=Phi';
% Mesh coordinates
[x y]=meshgrid(-1:0.1:1,-1:0.1:1);
% Chosen adaptation method
method = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop below
for count=1:20
    % Loop for 2N samples available in [U Y] set
    for sample=1:2*N
        % Choose the input pattern coordinates
        inputvector=U(sample,:)';
        % Depending on the 'method' calculate the output
        if method==1 || method==3 || method==4
            Yn(sample) = sign(Phi'*inputvector);
        elseif method==2
            Yn(sample) = tanh(Phi'*inputvector/2);
        else
            disp(' The variable <method> must be 1,2,3 or 4.')
            break
        end
        % Calculate the output error
        error = Y(sample)-Yn(sample);
        % Update laws
        if method ==1
            Phi=Phi+Eta*error*inputvector;
        elseif method ==2
            Phi=Phi+Eta*error*(1/2)*(1-Yn(sample)^2)*inputvector;
        elseif method==3
            Phi = Phi+Eta*(1-Y(sample)*Yn(sample))*Y(sample)*inputvector;
        elseif method==4
            if Y(sample) ~= Yn(sample)
                Phi=Phi-Eta*2*Yn(sample)*inputvector;
            end
        else
            disp(' The variable <method> must be 1,2,3 or 4.')
            break
        end
        % Write the parameters to PHI variable
        PHI=[PHI;Phi'];
    end
end