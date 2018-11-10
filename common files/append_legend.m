function legend_holder = append_legend(legend_holder, varargin)

    legends_to_append = varargin;

    % Convert type
    if ~iscell(legend_holder.legend)
           legend_holder.legend = {legend_holder.legend}; 
    end

    legend_holder.legend = [legend_holder.legend, legends_to_append];

end

