close all;

%% Plot graphs

PART_PATH = 'problem5.1';
PART_AND_PROBLEM = 'p5p1b';

font_size = struct(...
    'legend', 14,...
    'title', 18,...
    'xlabel', 12,...
    'ylabel', 12);

fig1 = figure(1); % Elevation rate
    plot(input_struct.time, input_struct.heading, 'color', 'g');
    hold on
    plot(heading.time, heading.angle, 'color', 'b');
    title({'Heading, $\omega = 0.05$'}, 'Interpreter', 'latex', 'fontsize', font_size.title);
    legend({'$\psi_{input}$', '$\psi_{output}$'}, 'Interpreter', 'latex', 'fontsize', font_size.legend, 'location', 'best');
    ylabel({'Amplitude'}, 'Interpreter', 'latex', 'fontsize', font_size.ylabel);
    xlabel({'Time [s]'}, 'Interpreter', 'latex', 'fontsize', font_size.xlabel)

    % Save to .pdf
    
    set(fig1, 'Units', 'Inches');
    pos1 = get(fig1, 'Position');
    set(fig1, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos1(3), pos1(4)]);
    print(fig1, strrep(strcat(PART_PATH, PART_AND_PROBLEM, '_heading', 'omega_', num2str(omega)), '.', 'pnt'), '-dpdf', '-r0');
    
% fig2 = figure(2); % Pitch 
%     plot(measurements.time, measurements.p , 'color', 'g');
%     hold on
%     plot(references.time, references.p , 'color', 'b');
%     title('Pitch', 'Interpreter', 'latex', 'fontsize', font_size.title);
%     legend({'$p_{meas}$', '$p_c$'}, 'Interpreter', 'latex', 'fontsize', font_size.legend, 'location', 'best');
%     ylabel({'Angle [$\circ$]'}, 'Interpreter', 'latex', 'fontsize', font_size.ylabel);
%     xlabel({'Time [s]'}, 'Interpreter', 'latex', 'fontsize', font_size.xlabel);
% 
%     % Save to .pdf
%     
%     set(fig2, 'Units', 'Inches');
%     pos1 = get(fig2, 'Position');
%     set(fig2, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos1(3), pos1(4)]);
%     print(fig2, strrep(strcat(PART_PATH, PART_AND_PROBLEM, '_pitch'), '.', 'pnt'), '-dpdf', '-r0');