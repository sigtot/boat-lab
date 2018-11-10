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

%% Task c)

heading_reference = 30; % Degrees

sim('p5p3d.mdl')

heading = new_data(heading.time, heading.signals.values);
reference = new_data(reference.time, reference.signals.values);
rudder = new_data(rudder.time, rudder.signals.values);

title_field = strcat('Heading response to $\psi_r=30^{\circ}$, wave disturbances. $K_{pd} = ', num2str(K_pd), '$');

labels = new_labels(title_field,...
                    {'$\psi_{ship}$', '$\psi_r$', '$\delta$'},...
                    'Time [s]',...
                    'Heading [$\circ$]');

fig3 = plot_nice({heading, reference, rudder}, labels, font_size, 'grid');

filename_p5p3d = strcat(...
    'Heading response wave disturbance degrees p5p3c K_pd ',...
    strrep(num2str(K_pd),'.','_dot_'));
pause
plot2pdf(PLOT_PATH, filename_p5p3d, fig3)