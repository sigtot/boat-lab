function [fig] = plot_nice(data, labels, font_size)
%% Function description
% Makes a nice plot of arbitrary data in LaTeX font and returns a handler
% to the figure
% -----------------------------------
% Input:
%
% 1. data: array
%       --- struct
%           --- 'time' : time array corresponding to 'values'
%           --- 'values' : value array corresponding to 'time'
% 2. labels: struct
%         --- 'title' : String containing the title, in LaTeX syntax
%         --- 'legend' : String containing the legend, in LaTeX syntax
%         --- 'ylabel' : String containing the ylabel, in LaTeX syntax
%         --- 'xlabel' : String containing the xlabel, in LaTeX syntax
% 3. font_size: struct
%            --- 'title' : Size of the 'title' font
%            --- 'legend' : Size of the 'legend' font
%            --- 'ylabel' : Size of the 'ylabel' font
%            --- 'xlabel' : Size of the 'xlabel' font
%
% ----------------------------------
% Output:
% 
% 1. fig: Handler to the figure created.
% ----------------------------------
%% Code


    fig = figure;
    
    for i = 1:length(data)
    
        plot(data(i).time, data(i).values, 'color', rand(1, 3));
        hold on
        
    end
    
    title({labels.title}, 'Interpreter', 'latex', 'fontsize', font_size.title);
    legend({labels.legend}, 'Interpreter', 'latex', 'fontsize', font_size.legend, 'location', 'best');
    ylabel({labels.ylabel}, 'Interpreter', 'latex', 'fontsize', font_size.ylabel);
    xlabel({labels.xlabel}, 'Interpreter', 'latex', 'fontsize', font_size.xlabel);
    

end

