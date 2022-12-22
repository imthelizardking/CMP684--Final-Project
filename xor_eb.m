clear all; close all; clc;
U = [0 0;0 1;1 0;1 1];
Y = [0 1 1 0]';
Phi = 2*rand(6,1)-1; % randomly start weights (3x1)
Phi_ = 2*rand(3,1)-1;
Eta = 0.8;
PHI(1,:)=Phi'; % weight dictionary
PHI_(1,:) = Phi_;
for count=1:50
    epoche_error(count) = 0;
    for sample=1:4 % !make parametric
        inputvector=[U(sample,:)';-1]; % set input vector
        Yn_11 = Phi(1:3)'*inputvector; % get sum S11
        e_x = exp(Yn_11); e_x_n = exp(-Yn_11); % act. func. prep.
        O_11 = (e_x - e_x_n) / (e_x + e_x_n); % get o11
        Yn_21 = Phi(4:6)'*inputvector; % get sum S11
        e_x = exp(Yn_21); e_x_n = exp(-Yn_21); % act. func. prep.
        O_21 = (e_x - e_x_n) / (e_x + e_x_n); % get o11
        Yn_12 = Phi_'*[O_11;O_21;-1]; % get sum S12
        e_x = exp(Yn_12); e_x_n = exp(-Yn_12); % act. func. prep.
        Tau = (e_x - e_x_n) / (e_x + e_x_n); % get final output
        Delta_ = Eta*(Tau-Y(sample))*[O_11,O_21,-1]; % update weights of output layer
        Phi_ = Phi_'+Delta_; % update weights of output layer
        PHI_((count-1)*4+sample+1,:) = Phi_; % update weights of output layer
        Delta = Eta*(Tau-Y(sample))*Phi_*(1-[Yn_11,Yn_21,-1]*[Yn_11,Yn_21,-1]')*Phi;
        Phi = Phi+Delta;
        PHI((count-1)*4+sample+1,:) = Phi;
    end
    epoche_error(count)
end