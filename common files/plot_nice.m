function [fig, pl] = plot_nice(data, labels, font_size, varargin)
%% Function description
% Makes a nice plot of arbitrary data in LaTeX font and returns a handler
% to the figure
% -----------------------------------
% Input:
%
% 1. data: cell array
%       --- struct
%           --- 'time' : time array corresponding to 'values'
%           --- 'values' : value array corresponding to 'time'
% 2. labels: struct
%         --- 'title' : String containing the title, in LaTeX syntax
%         --- 'legend' : String containing the legend, in LaTeX syntax. If only one legend,
%            pass as string. Otherwise, pass as cell array.
%         --- 'ylabel' : String containing the ylabel, in LaTeX syntax
%         --- 'xlabel' : String containing the xlabel, in LaTeX syntax
% 3. font_size: struct
%            --- 'title' : Size of the 'title' font
%            --- 'legend' : Size of the 'legend' font. 
%            --- 'ylabel' : Size of the 'ylabel' font
%            --- 'xlabel' : Size of the 'xlabel' font
% 4. varargin: Optional input parameters
%            --- 'loglog' : Pass in the string 'loglog' for loglog plot
%            --- 'grid'   : Pass in the strin 'grid' to turn on grids
%
% ----------------------------------
% Output:
% 
% 1. fig: Handle to the figure created.
% 2. pl : Array with handles to all overlapping plots created
% ----------------------------------
%% Code
    
    fig = figure;
    pl = zeros(1, length(data));
    
    % Used to get pretty colors
    colors = linspecer(length(data));
    
    % To get right type for later
    if ~iscell(data)
       data = {data}; 
    end
    
    if ~iscell(labels.legend)
       labels.legend = {labels.legend}; 
    end
    
    % Check for optional input parameters
    use_loglog = any(strcmp(varargin, 'loglog'));
    use_grid_on = any(strcmp(varargin, 'grid'));
    
    %% Actual plotting
    if use_loglog
        for i = 1:length(data)

            pl(i) = loglog(data{i}.time, data{i}.values, 'color', colors(i, :));
            hold on

        end
    % Default is ordinary 'plot'    
    else
        for i = 1:length(data)
        
            pl(i) = plot(data{i}.time, data{i}.values, 'color', colors(i, :));
            hold on
            
        end
    end
    
    % Turn on grid if requested
    if use_grid_on
       grid on; 
    end
    
    title({labels.title},   'Interpreter', 'latex', 'fontsize', font_size.title);
    legend(labels.legend,   'Interpreter', 'latex', 'fontsize', font_size.legend, 'location', 'best');
    ylabel({labels.ylabel}, 'Interpreter', 'latex', 'fontsize', font_size.ylabel);
    xlabel({labels.xlabel}, 'Interpreter', 'latex', 'fontsize', font_size.xlabel);
    
end

