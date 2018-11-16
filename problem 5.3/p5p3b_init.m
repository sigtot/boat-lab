clear
close all

%% Create structs for plotting

NUM_OF_PLOTS = 2;

PLOT_PATH = 'plots/';

labels_bode_amplitude = new_labels(...
    'Amplitude plot of $H_{pd}\cdot H_{ship}$',...
    '$\left|H_{pd}\cdot H_{ship}\right|$',...
    'Frequency [rad/s]',...
    'Amplitude [1]');

labels_bode_phase = new_labels(...
    'Phase plot of $H_{pd}\cdot H_{ship}$',...
    '$\angle \left(H_{pd}\cdot H_{ship}\right)$',...
    'Frequency [rad/s]',...
    'Phase [rad]');       

font_size = new_font_size();
                 
                        
%% Task a)


K = 0.1553;  % s^-1
T = 71.3716; % s
T_d = T;     % So the derivative term cancels the transfer function time constant
T_f = 10;
K_pd = 0.707; % Phase margin 50 degrees

s = tf('s');
H_ship = (K/T)/(s*(s + 1/T));
H_pd = K_pd*(1 + T_d*s)/(1 + T_f*s);

H_open_loop = H_pd*H_ship;

[mag, phase, wout] = bode(H_open_loop);

mag = squeeze(mag);
phase = squeeze(phase);

transfer_fcn = structify_data(wout, [mag, phase]);

% [fig_a, pl_a] = plot_nice(transfer_fcn{1}, labels_bode_amplitude, font_size, 'loglog', 'grid', 'thicklines');
% [fig_b, pl_b] = plot_nice(transfer_fcn{2}, labels_bode_phase, font_size, 'loglog', 'grid', 'thicklines');

% [sub_fig, subp] = subplot_nice(transfer_fcn', {labels_bode_amplitude; labels_bode_phase}, font_size, 'loglog', 'grid', 'thicklines');

%% Task b)

heading_reference = 30; % Degrees

sim('p5p3b.mdl')

data = new_data(heading, reference, rudder);
title_field = strcat('Heading response to $\psi_r=30^{\circ}$, no disturbances. $K_{pd} = ', num2str(K_pd), '$');

labels = new_labels(title_field,...
                    {'$\psi_{ship}$', '$\psi_{r}$', '$\delta$'},...
                    'Time [s]',...
                    'Angle [$\circ$]');

fig3 = plot_nice(data, labels, font_size, 'thicklines', 'grid');
 
filename = strcat('heading_response_no_disturbances_p5p3b K_pd_', strrep(num2str(K_pd), '.', '_dot_'));

% plot2pdf(PLOT_PATH, filename, fig3);

