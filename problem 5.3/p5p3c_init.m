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

%% Task c)

heading_reference = 30; % Degrees

sim('p5p3c.mdl')

data = new_data(heading, reference, rudder);

title_field = strcat('Heading response to $\psi_r=30^{\circ}$ with current disturbances. $K_{pd} = ', num2str(K_pd), '$');

labels = new_labels(title_field,...
                    {'$\psi_{ship}$', '$\psi_r$', '$\delta$'},...
                    'Time [s]',...
                    'Angle [$\circ$]');

fig4 = plot_nice(data, labels, font_size, 'grid', 'thicklines');

filename_p5p3c = strcat(...
    'p5p3c_heading_response_current_disturbance_K_pd_',...
    strrep(num2str(K_pd),'.','_dot_'));

