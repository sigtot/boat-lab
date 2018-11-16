clear
close all

omega = 0.05; % rad/s
amplitude = 1; % 1


sim('p5p1c.mdl');

[heading, rudder] = new_data(heading, rudder);

labels = new_labels(...
    strcat('Sinusodial response, $\omega=$ ', num2str(omega), ' rad, with wave and measurement noise'),...
    {'$\psi$', '$\delta$'},...
    'Time [s]',...
    'Degrees [$^{\circ}$]');

[fig, pl] = plot_nice({heading, rudder}, labels, new_font_size(), 'grid', 'thicklines');

PLOT_PATH = 'plots/';
filename = strcat('p5p1c_sinusodial_response_omega_', strrep(num2str(omega), '.', '_dot_'), '_w_noise_thicklines');
