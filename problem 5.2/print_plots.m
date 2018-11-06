close all;

%% Plot graphs

PART_PATH = 'problem5.2';
PART_AND_PROBLEM = 'p5p2a';

font_size = struct(...
    'legend', 14,...
    'title', 18,...
    'xlabel', 12,...
    'ylabel', 12);

% fig1 = figure(1); % a)
%     plot(omega, pxx, 'color', 'g');
% %     hold on
% %     plot(heading.time, heading.angle, 'color', 'b');
%     title({'Power Spectral Density Function'}, 'Interpreter', 'latex', 'fontsize', font_size.title);
%     legend({'$S_{\psi_w}(\omega)$'}, 'Interpreter', 'latex', 'fontsize', font_size.legend, 'location', 'best');
%     ylabel({'Power density'}, 'Interpreter', 'latex', 'fontsize', font_size.ylabel);
%     xlabel({'Frequency [rad/s]'}, 'Interpreter', 'latex', 'fontsize', font_size.xlabel)
% 
%     % Save to .pdf
%     
%     set(fig1, 'Units', 'Inches');
%     pos1 = get(fig1, 'Position');
%     set(fig1, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos1(3), pos1(4)]);
%     filename = strrep(strcat(PART_PATH, PART_AND_PROBLEM), '.', '_dot_');
%     print(fig1, filename, '-dpdf', '-r0');

 fig1 = figure(1); % c)
    plot(omega, pxx, 'color', 'g');
    title({'Power Spectral Density Function'}, 'Interpreter', 'latex', 'fontsize', font_size.title);
    legend({'$S_{\psi_w}(\omega)$'}, 'Interpreter', 'latex', 'fontsize', font_size.legend, 'location', 'best');
    ylabel({'Power density'}, 'Interpreter', 'latex', 'fontsize', font_size.ylabel);
    xlabel({'Frequency [rad/s]'}, 'Interpreter', 'latex', 'fontsize', font_size.xlabel)

    % Save to .pdf
    
    set(fig1, 'Units', 'Inches');
    pos1 = get(fig1, 'Position');
    set(fig1, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos1(3), pos1(4)]);
    filename = strrep(strcat(PART_PATH, PART_AND_PROBLEM), '.', '_dot_');
    print(fig1, filename, '-dpdf', '-r0');
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    