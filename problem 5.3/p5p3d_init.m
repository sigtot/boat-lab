clear
close all

%% Create structs for plotting

NUM_OF_PLOTS = 2;

PLOT_PATH = 'plots/';

font_size = new_font_size();
                 
                        
%% Task a)

s = tf('s');
K = 0.1553;  % s^-1
T = 71.3716; % s
T_d = T;     % So the derivative term cancels the transfer function time constant
T_f = 8.391;
K_pd = 0.8406; % Phase margin 50 degrees
H_ship = (K/T)/(s*(s + 1/T));
H_pd = K_pd*(1 + T_d*s)/(1 + T_f*s);

%% Task d)

heading_reference = 30; % Degrees

sim('p5p3d.mdl')

data_1 = new_data(heading, reference, rudder);

labels_1 = new_labels(...
                    'Heading response to $\psi_r=30^{\circ}$ with wave disturbance',...
                   {'$\psi_{ship}$', '$\psi_r$', '$\delta$'},...
                    'Time [s]',...
                    'Angle [$\circ$]');

[fig, pl] = plot_nice(data_1, labels_1, font_size, 'grid');
xlim([0 500]); ylim([-35 55]);
set(pl, 'LineWidth', 2);
l = findall(fig, 'Type', 'Line');
set(l(2), 'LineWidth', 3, 'LineStyle', '--');
set(fig, 'Units', 'Inches');
set(fig, 'Position', [-14.8750    4.2813    8.4834    5.4896]);
plot2pdf('plots/', 'p5p3d_wave_disturbance', fig);