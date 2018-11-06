clear
close all

omega = 0.005; % rad/s
amplitude = 1; % 1


sim('p5p1b.mdl');

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

labels = new_labels('Just a test', 'Test legend', 'Ylabel test', 'Xlabel test');

font_size = new_font_size(14, 18, 12, 12);

data_array = [heading, input_struct];

plot_nice(data_array, labels, font_size);


