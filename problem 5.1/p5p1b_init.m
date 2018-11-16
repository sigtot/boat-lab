clear
close all

omega = 0.005; % rad/s
amplitude = 1; % 1

PLOT_PATH = 'plots/';

sim('p5p1b.mdl');

data = new_data(heading, rudder);

labels = new_labels(...
    strcat('Sinusodial response, $\omega=$ ', num2str(omega), ' rad'),...
    {'$\psi$', '$\delta$'},...
    'Time [s]',...
    'Degrees [$^{\circ}$]');

font_size = new_font_size();

path = 'plots/';
filename = strcat('p5p1b_sinusodial_response_omega_', strrep(num2str(omega), '.', '_dot_'));

[fig, pl] = plot_nice(data, labels, font_size, 'thicklines');
grid on
