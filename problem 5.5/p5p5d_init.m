clear
close all

%% Create structs for plotting

NUM_OF_PLOTS = 2;

PLOT_PATH = 'plots/';

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

sim('p5p5b.mdl');

measurement_noise = struct(...
    'time', measurement_noise.time,...
    'values', measurement_noise.signals.values);

measurement_noise_variance = var(measurement_noise.values); % Degrees

%% Task c)

Q = [30,    0;...
      0, 1E-6];

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
%% Task d)

reference = 30; % Degrees

sim('p5p5d.mdl');

data = new_data(heading, reference, rudder, bias_est);

labels = new_labels(...
    'Heading with Kalman',...
    {'$\psi$', '$\psi_r$', '$\delta$', '$\hat{b}$'},...
    'Time [s]',...
    'Angle [$^{\circ}$]');

plot_nice(data, labels, font_size);

