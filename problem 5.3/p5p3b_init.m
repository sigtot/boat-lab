clear
close all

%% Create structs for plotting

NUM_OF_PLOTS = 2;

PLOT_PATH = 'plots/';

labels_task_a = cell(1, NUM_OF_PLOTS);

% labels{TASK_A} = new_labels('Estimated power spectral density $S_{\psi_w}$',...
%                             '$S_{\psi_w}$',...
%                             'Frequency [rad/s]',...
%                             'Power density [power/rad/s]');
%                         
% labels{TASK_D} = new_labels('Curve-fitting of $\lambda$ in $P_{\psi_w}$',...
%                             '$S_{\psi_w}$',...
%                             'Frequency [rad/s]',...
%                            'Power density [power/rad/s]');

% labels_task_a{1} = new_labels('Amplitude plot of $H_{pd}(s)\cdot H_{ship}(s)$',...
%                             '$H_{pd}(s)\cdot H_{ship}(s)$',...
%                             'Frequency [rad/s]',...
%                             'Amplitude [1]');
%                         
% labels_task_a{2} = new_labels('Phase plot of $H_{pd}(s)\cdot H_{ship}(s)$',...
%                             '$H_{pd}(s)\cdot H_{ship}(s)$',...
%                             'Frequency [rad/s]',...
%                             'Phase [$\circ$]');                        
font_size = new_font_size();
                 
                        
%% Task a)

s = tf('s');
K = 0.1553;  % s^-1
T = 71.3716; % s
T_d = T;     % So the derivative term cancels the transfer function time constant
T_f = 10;
K_pd = 0.707; % Phase margin 50 degrees
%K_pd = 0.02;
H_ship = (K/T)/(s*(s + 1/T));
H_pd = K_pd*(1 + T_d*s)/(1 + T_f*s);

H_open_loop = H_pd*H_ship;

[mag, phase, wout] = bode(H_open_loop);

mag = squeeze(mag);
phase = squeeze(phase);

[Gm, Pm, Wcg, Wcp] = margin(H_open_loop);

% bode_data = cell(1, 2);
% 
% bode_data{1} = new_data(wout, mag);
% 
% bode_data{2} = new_data(wout, phase);
% 
% fig1 = plot_nice(bode_data{1}, labels_task_a{1}, font_size, 'loglog');
%fig2 = plot_nice(bode_data{2}, labels_task_a{2}, font_size, 'loglog');

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

