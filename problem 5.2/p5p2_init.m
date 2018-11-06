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

plot(omega, pxx)

%% Task b)

%% Task c)

[sigma_squared, index] = max(pxx);

omega_0 = omega(index);

fprintf('sigma_squared = %.2f\nomega_0 = %.4f', sigma_squared, omega_0);