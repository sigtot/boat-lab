clear
close all

%% Create structs for plotting

NUM_OF_PLOTS = 2;

PLOT_PATH = 'plots/';

labels_task_a = cell(1, NUM_OF_PLOTS);

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
    

%%

% heading_reference = 30; % Degrees
% 
% sim('p5p3b.mdl')
% 
% heading = new_data(heading.time, heading.signals.values);
% reference = new_data(reference.time, reference.signals.values);
% rudder = new_data(rudder.time, rudder.signals.values);
% title_field = strcat('Heading response to $\psi_r=30^{\circ}$, no disturbances. $K_{pd} = ', num2str(K_pd), '$');
% 
% labels = new_labels(title_field,...
%                     {'$\psi_{ship}$', '$\delta$'},...
%                     'Time [s]',...
%                     'Heading [$\circ$]');
% 
% % labels = append_legend(labels, '$\psi_r$');
% 
% fig3 = plot_nice({heading, rudder}, labels, font_size, 'grid');
% 
% filename = strcat('Heading response no disturbances p5p3b K_pd ', strrep(num2str(K_pd), '.', '_dot_'));
% 
% plot2pdf(PLOT_PATH, filename, fig3);
% 
