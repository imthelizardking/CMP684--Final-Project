% Model         :  BLDC  six step commutation
% Description   :  Set Parameters for BLDC Six Step Control
% File name     :  mcb_bldc_sixstep_f28379d_data.m

% Copyright 2020 The MathWorks, Inc.

%% Set PWM Switching frequency
PWM_frequency 	= 20e3;             %Hz     // converter s/w freq
T_pwm           = 1/PWM_frequency;  %s      // PWM switching time period
Ts_motor_simscape = T_pwm/100;

%% Set Sample Times
Ts          	= T_pwm;            %sec    // Sample time step for controller
Ts_simulink     = T_pwm/2;          %sec    // Simulation time step for model simulation
Ts_motor        = T_pwm/2;          %Sec    // Simulation sample time
Ts_inverter     = T_pwm/2;          %sec    // Simulation time step for average value inverter
Ts_speed        = 10*Ts;            %Sec    // Sample time for speed controller

%% Set data type for controller & code-gen
% dataType = fixdt(1,32,17);        % Fixed point code-generation
dataType = 'single';                % Floating point code-generation

%% System Parameters
% Set motor parameters

% bldc = mcb_SetPMSMMotorParameters('BLY171D');
% bldc = mcb_SetPMSMMotorParameters('Teknic2310P');
load('mcb_bldc_param');
bldc = mcb_bldc_param;

%% Hall Sequence Calibration
% update hall sequence using "mcb_hall_calibration_f28379d" workflow

% bldc.HallSequence = [1,5,4,6,2,3]; % BLY171D Motor

bldc.HallSequence = [4,6,2,3,1,5]; % Teknic Motor

% position offset needed if position is sensed using QEP
bldc.PositionOffset     = 0; %QEP offset 

%% Traget & inverter parameters
% Set target hardware parameters
target = mcb_SetProcessorDetails('F28379D',PWM_frequency);

% Set inverter parameters
inverter = mcb_SetInverterParameters('BoostXL-DRV8305');
% ADC Offset for phase current C is added below. The value will be
% calibrated during hardware init if automatic calibration is enabled.
% If calibration is disabled, manually update the offset value in the next section (Inverter Calibration)of this script.
inverter.CtSensCOffset= 2286;

%% Inverter Calibration
% Enable automatic calibration of ADC offset for current measurement
inverter.ADCOffsetCalibEnable = 1; % Enable: 1, Disable: 0

% If automatic ADC offset calibration is disabled, uncomment and update the 
% offset values below manually
% inverter.CtSensAOffset = 2295;      % ADC Offset for phase current A 
% inverter.CtSensBOffset = 2286;      % ADC Offset for phase current B
% inverter.CtSensCOffset = 2286;;     % ADC Offset for phase current B

% Update inverter.ISenseMax based for the chosen motor and target
inverter = mcb_updateInverterParameters(bldc,inverter,target);

% Max and min ADC counts for current sense offsets
inverter.CtSensOffsetMax = 2500; % Maximum permitted ADC counts for current sense offset
inverter.CtSensOffsetMin = 1500; % Minimum permitted ADC counts for current sense offset

%% Derive Characteristics
bldc.N_base = mcb_getBaseSpeed(bldc,inverter); %rpm // Base speed of motor at given Vdc
% mcb_getCharacteristics(bldc,inverter);

%% PU System details // Set base values for pu conversion

PU_System = mcb_SetPUSystem(bldc,inverter);

%% Controller design // Get ballpark values!

PI_params = mcb.internal.SetControllerParameters(bldc,inverter,PU_System,T_pwm,2*Ts,Ts_speed);
PI_params.Kp_speed = 60;
PI_params.Kp_i = 0.07;
%Updating delays for simulation
PI_params.delay_Currents    = 1;
PI_params.delay_Position    = 1;

% mcb_getControlAnalysis(bldc,inverter,PU_System,PI_params,Ts,Ts_speed); 

%% Displaying model variables
disp(bldc);
disp(inverter);
disp(target);
disp(PU_System);