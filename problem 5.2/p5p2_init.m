clear
close all

%% Create structs for plotting

NUM_OF_TASKS = 2;
TASK_A = 1;
TASK_D = 2;

labels = cell(1, NUM_OF_TASKS);

labels{TASK_A} = new_labels('Estimated power spectral density $S_{\psi_w}$',...
                            '$S_{\psi_w}$',...
                            'Frequency [rad/s]',...
                            'Power density [power/rad/s]');
                        
labels{TASK_D} = new_labels('Curve-fitting of $\lambda$ in $P_{\psi_w}$',...
                            '$S_{\psi_w}$',...
                            'Frequency [rad/s]',...
                            'Power density [power/rad/s]');
                        
font_size = new_font_size();


filename_task_a = 'p5p2a_numeric_psd';
filename_task_d = 'p5p2d_curvefitting_lambda';
PLOT_PATH = 'plots/';
                        
%% Task a)

CONVERT_HZ_TO_RAD_S = 2*pi;
CONVERT_DEG_TO_RAD = pi/180;
CONVERT_RAD_TO_DEG = 1/CONVERT_DEG_TO_RAD;
CONVERT_RAD_S_TO_HZ = 1/CONVERT_HZ_TO_RAD_S;

load('wave.mat')
x = psi_w(2,:)*CONVERT_DEG_TO_RAD;
WINDOW_SIZE = 4096; % Given in assignement
sampling_frequency = 10; % Hz



[pxx, f] = pwelch(x, WINDOW_SIZE, [], [], sampling_frequency);

omega = f*CONVERT_HZ_TO_RAD_S; % Convert Hz to rad/s
pxx = pxx/CONVERT_HZ_TO_RAD_S; % Convert power/Hz to power/rad/s

pxx_struct = new_data(omega, pxx);

%[fig1, pl1] = plot_nice(pxx_struct, labels{TASK_A}, font_size, 'grid', 'thicklines');

%% Task b)

%% Task c)

[sigma_squared, index] = max(pxx);

omega_0 = omega(index);

fprintf('sigma_squared = %.2f\nomega_0 = %.4f\n', sigma_squared, omega_0);

%% Task d)

sigma = sqrt(sigma_squared);
lambda = 0.05:0.05:0.3;
K_w = 2*lambda*omega_0*sigma;

labels{TASK_D}.legend = {labels{TASK_D}.legend};

for i = 1:length(lambda)
        pxx_theoretical = (omega*K_w).^2./...
              (omega.^4 + omega_0^4 + 2*omega_0.^2*omega.^2*(2*lambda.^2-1));
        legend_to_append = strcat('$\lambda_{',num2str(i),'} = ', num2str(lambda(i)), '$');
        labels{TASK_D} = append_legend(labels{TASK_D}, legend_to_append);
end
 
data = structify_data(omega, [pxx, pxx_theoretical]);
[fig2, pl2] = plot_nice(data, labels{TASK_D}, font_size, 'grid');
