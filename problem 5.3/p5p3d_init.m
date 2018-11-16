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
H_ship = (K/T)/(s*(s + 1/T));
H_pd = K_pd*(1 + T_d*s)/(1 + T_f*s);

%% Task d)

heading_reference = 30; % Degrees

sim('p5p3d.mdl')

data = new_data(heading, reference, rudder);

title_field = strcat('Heading response to $\psi_r=30^{\circ}$ with wave disturbances. $K_{pd} = ', num2str(K_pd), '$');

labels = new_labels(title_field,...
                    {'$\psi_{ship}$', '$\psi_r$', '$\delta$'},...
                    'Time [s]',...
                    'Angle [$\circ$]');

fig3 = plot_nice(data, labels, font_size, 'grid', 'thicklines');

filename_p5p3d = strcat(...
    'p5p3d_heading_response_wave_disturbance_degrees_K_pd ',...
    strrep(num2str(K_pd),'.','_dot_'));
