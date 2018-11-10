function legend_holder = append_label(legend_holder, legend_to_append)

    if ~iscell(legend_holder)
           legend_holder = {legend_holder}; 
    end

    legend_holder = [legend_holder, {legend_to_append}];

end

