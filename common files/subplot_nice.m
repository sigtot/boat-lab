function [fig, subp] = subplot_nice(data, labels, font_size, varargin)

    [rows, cols] = size(data);
    subp = zeros(rows, cols);

    fig = figure;
    
    for i = 1:rows
        for j = 1:cols
            subp(i, j) = subplot(rows, cols, (i-1)*cols + j);
            plot_nice(data{i, j}, labels{i, j}, font_size, varargin{:}, 'disableFigure', fig);
        end
    end
    
end

