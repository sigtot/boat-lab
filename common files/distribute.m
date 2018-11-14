function [varargout] = distribute(inputs)

    if isstruct(inputs)
        inputs_fields = fieldnames(inputs);
        num_of_fields = length(inputs_fields);
        varargout = cell(1, num_of_fields);
        
        for i = 1:num_of_fields
            varargout{i} = inputs.(inputs_fields{i});
        
        end
    end

end

