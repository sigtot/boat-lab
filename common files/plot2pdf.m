function plot2pdf(path, filename, fig)

    set(fig, 'Units', 'Inches');
    pos1 = get(fig, 'Position');
    set(fig, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos1(3), pos1(4)]);    
    print(fig, strcat(path, filename), '-dpdf', '-r0');

end

