clear
close all

%% Create structs for plotting

NUM_OF_PLOTS = 2;

PLOT_PATH = 'plots/';

filename = {'p5p5e_heading_kalman', 'p5p5e_wave_influence'};

font_size = new_font_size();
                 
%% Set up constants for later use

omega_0 = 0.7823;               % From problem 5.2
lambda = 0.1;                   % From problem 5.2
K = 0.1553;                     % From problem 5.1
T = 71.3716;                    % From problem 5.1
sigma = 0.0281;                 % From problem 5.2
K_w = 2*lambda*omega_0*sigma;   % From problem 5.1

A = [        0,                 1, 0,    0,    0;...
    -omega_0^2, -2*lambda*omega_0, 0,    0,    0;...
             0,                 0, 0,    1,    0;...
             0,                 0, 0, -1/T, -K/T;...
             0,                 0, 0,    0,    0];
         
B = [0, 0, 0, K/T, 0]';

E = [ 0, 0;...
    K_w, 0;...
      0, 0;...
      0, 0;...
      0, 1];
  
C = [0, 1, 1, 0, 0];

f_s = 10;    % Hz
T_s = 1/f_s; % s

s = tf('s');
T_d = T;     
T_f = 10;
K_pd = 0.707;
H_ship = (K/T)/(s*(s + 1/T));
H_pd = K_pd*(1 + T_d*s)/(1 + T_f*s);

%% Task a)

[A_d, B_d] = c2d(A, B, T_s);
[~, E_d]   = c2d(A, E, T_s);
C_d        = C;

%% Task b)

measurement_noise_variance = 0.0020; % Hardcoded to save time and resources

%% Set up for Kalman filter

Q = [30,    0;...
      0, 1E-6];
  
Q_factor = 0.01;  
  
Q = Q_factor*Q;

R = measurement_noise_variance/T_s;

P_0_ = [1,     0,    0, 0,      0;...
                0, 0.013,    0, 0,      0;...
                0,     0, pi^2, 0,      0;...
                0,     0,    0, 1,      0;...
                0,     0,    0, 0, 2.5E-3];

x_est_0_ = [0, 0, 0, 0, 0]';

H = 1;

sys_init = struct(...
    'A_d', A_d,...
    'B_d', B_d,...
    'C_d', C_d,...
    'E_d', E_d,...
    'H_d', H,...
    'P_0_', P_0_,...
    'x_est_0_', x_est_0_,...
    'Q', Q,...
    'R', R);

Simulink.Bus.createObject(sys_init);

%% First plot of heading, estimated heading, rudder and estimated bias

reference = 30; % Degrees

sim('p5p5e.mdl');

data1 = new_data(heading, heading_est, rudder, bias_est);

% labels_heading = new_labels(...
%     'Heading with Kalman filter with $\hat{\psi}$ as feedback to controller',...
%     {'$\psi$', '$\hat{\psi}$', '$\delta$', '$\hat{b}$'},...
%     'Time [s]',...
%     'Angle [$^{\circ}$]');

labels_heading = new_labels(... Added to see difference in Qs
    ['Heading with Kalman filter with $\hat{\psi}$ as feedback to controller. $\mathbf{Q''}=',num2str(Q_factor),'\mathbf{Q}$'],...
    {'$\psi$', '$\hat{\psi}$', '$\delta$', '$\hat{b}$'},...
    'Time [s]',...
    'Angle [$^{\circ}$]');

% [fig1, pl] = plot_nice(data1, labels_heading, font_size, 'grid');

%% Second plot of estimated and measured wave influence

reference = 0; % Degrees

sim('p5p5e_wave_influence.mdl');

data2 = new_data(wave_influence, wave_influence_est);

% labels_wave_influence = new_labels(...
%     'Measured wave influence vs estimated wave influence',...
%     {'$\psi_w$', '$\hat{\psi_w}$'},...
%     'Time [s]',...
%     'Angle [$^{\circ}$]');

labels_wave_influence = new_labels(... Added to see difference in Qs
    ['Measured wave influence vs estimated wave influence. $\mathbf{Q''}=',num2str(Q_factor),'\mathbf{Q}$'],...
    {'$\psi_w$', '$\hat{\psi_w}$'},...
    'Time [s]',...
    'Angle [$^{\circ}$]');

% [fig2, pl2] = plot_nice(data2, labels_wave_influence, font_size, 'grid');

[fig, subp3] = subplot_nice({data1; data2}, {labels_heading; labels_wave_influence}, font_size, 'grid');
set_line_width(fig, 2);
filename = strcat('p5p5e_wave_influence_Q_', num2str(Q_factor));

