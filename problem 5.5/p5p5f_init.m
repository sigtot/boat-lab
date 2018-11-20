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
T_f = 8.391;
K_pd = 0.8406; % Phase margin 50 degrees
H_ship = (K/T)/(s*(s + 1/T));
H_pd = K_pd*(1 + T_d*s)/(1 + T_f*s);

%% Task a)

[A_d, B_d] = c2d(A, B, T_s);
[~, E_d]   = c2d(A, E, T_s);
C_d        = C;

%% Task b)

measurement_noise_variance = 0.0020; % Hardcoded to save time and resources

%% Set up for Kalman filter

q_w_w = 30;
q_w_b = 1e-6;
 
Q = diag([q_w_w q_w_b]);

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

%% Plotting

reference = 30; % Degrees

sim('p5p5e.mdl');

data1 = new_data(heading, heading_est, rudder, bias_est);

labels_heading_2 = new_labels(... Added to see difference in Qs
    ['Heading with Kalman filter with $\hat{\psi}$ as feedback to controller. $\mathbf{Q}=\pmatrix{', num2str(Q(1,1)), '& 0 \cr 0 &', num2str(Q(2,2)), '}$'],...
    {'$\psi$', '$\hat{\psi}$', '$\delta$', '$\hat{b}$'},...
    'Time [s]',...
    'Angle [$^{\circ}$]');

reference = 0; % Degrees

sim('p5p5f.mdl');

data2 = new_data(wave_influence, wave_influence_est);

labels_wave_influence = new_labels(... Added to see difference in Qs %['Measured wave influence vs estimated wave influence. $\mathbf{Q''}=\texttt{diag}\left(\left[',num2str(q_w_w),',~',num2str(q_w_b),'\right]\right)$'],
    ['Measured wave influence vs estimated wave influence. $\mathbf{Q}=\pmatrix{', num2str(Q(1,1)), '& 0 \cr 0 &', num2str(Q(2,2)), '}$'],...
    {'$\psi_w$', '$\hat{\psi}_w$'},...    
    'Time [s]',...
    'Angle [$^{\circ}$]');

[fig, subp3] = subplot_nice({data1; data2}, {labels_heading_2; labels_wave_influence}, font_size, 'grid');

set(fig, 'Units', 'Inches');
pos = [-19.9896    0.4271    9.9063    9.9375];
set(fig, 'Position', pos);

set_line_width(fig, 2);
l = findall(fig, 'Type', 'Line');
a = findall(fig, 'Type', 'Axes');
%set(a, 'XLim', [0 500]);
%set(a(2), 'YLim', [-35 55]);

plot2pdf('plots/', 'p5p5f_low_q_w_b_and_low_q_w_w', fig)