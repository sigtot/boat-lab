clear
close all

%% Get output from simulation

amplitude = 1; % 1 degrees



sim('p5p1d.mdl');

coordinates = struct(...
            'time', coordinates_output.time',...
            'x', coordinates_output.signals.values(:,1)',...
            'y', coordinates_output.signals.values(:,2)');
 
heading = struct(...
            'time', compass_output.time',...
            'angle', compass_output.signals.values');
        
input_struct = struct(...
            'time', input.time',...
            'heading', input.signals.values');


%% Calculate theoratical output from transfer function

K = 0.1553;  % 1/s. Calculated from task c)
T = 71.3716; % s.   Calculated from task c)

s = tf('s');

H = (K/T)/(s*(s + 1/T));

T_final = heading.time(end);

step(H, T_final);

%% Plot response 
hold on
plot(heading.time, heading.angle)

legend('Heading', 'Output without DC offset');
