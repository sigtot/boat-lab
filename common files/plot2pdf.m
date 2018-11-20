function plot2pdf(path, filename, fig, varargin)

    % Optional tuning to get a snugger pdf
    if ~isempty(varargin)
        width_tuning_factor = varargin{1};
        height_tuning_factor = varargin{2};
    else % Default values
        width_tuning_factor = 0.9;
        height_tuning_factor = 1;
    end

    set(fig, 'Units', 'Inches');
    pos1 = get(fig, 'Position');
    
    width = pos1(3);
    height = pos1(4);
    
    set(fig, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches',...
        'PaperSize', [width*width_tuning_factor, height*height_tuning_factor]);    
    
    print(fig, strcat(path, filename), '-dpdf', '-r0');

end

