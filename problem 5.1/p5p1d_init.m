clear
close all

%% Get output from simulation

amplitude = 1; % 1 degrees


sim('p5p1d.mdl');

[heading, rudder] = new_data(heading, rudder);


%% Calculate theoretical output from transfer function

K = 0.1553;  % 1/s. Calculated from task c)
T = 71.3716; % s.   Calculated from task c)

s = tf('s');

H = (K/T)/(s*(s + 1/T));

T_final = heading.time(end);

[y, t] = step(H, T_final);

heading_model = structify_data(t, y);

%% Plot response 

font_sizes = new_font_size();

labels = new_labels(...
    'Simulated step response vs theoretical',...
    {'$\psi_{ship}$', '$\psi_{model}$'},...
    'Time [s]',...
    'Degrees [$^{\circ}$]');

[fig, pl] = plot_nice({heading, heading_model}, labels, font_sizes, 'grid', 'thicklines');

PLOT_PATH = 'plots/';
filename = 'p5p1d_sim_vs_model_step_response';


