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
    -omega_o^2, -2*lambda*omega_0, 0,    0,    0;...
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

%% Task a)



%% Task b)

heading_reference = 30; % Degrees

sim('p5p3b.mdl')

heading = new_data(heading.time, heading.signals.values);
reference = new_data(reference.time, reference.signals.values);
rudder = new_data(rudder.time, rudder.signals.values);
title_field = strcat('Heading response to $\psi_r=30^{\circ}$, no disturbances. $K_{pd} = ', num2str(K_pd), '$');

labels = new_labels(title_field,...
                    {'$\psi_{ship}$', '$\delta$'},...
                    'Time [s]',...
                    'Heading [$\circ$]');

% labels = append_legend(labels, '$\psi_r$');

fig3 = plot_nice({heading, rudder}, labels, font_size, 'grid');

filename = strcat('Heading response no disturbances p5p3b K_pd ', strrep(num2str(K_pd), '.', '_dot_'));

plot2pdf(PLOT_PATH, filename, fig3);

