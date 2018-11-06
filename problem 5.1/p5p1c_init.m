clear
close all

omega = 0.005; % rad/s
amplitude = 1; % 1


sim('p5p1c.mdl');

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
        
plot(input_struct.time, input_struct.heading)
hold on
plot(heading.time, heading.angle)

legend('Input', 'Output with DC offset', 'Output without DC offset');
