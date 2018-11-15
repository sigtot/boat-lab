function [varargout] = distribute(inputs)

    if isstruct(inputs)
        inputs_fields = fieldnames(inputs);
        num_of_fields = length(inputs_fields);
        varargout = cell(1, num_of_fields);
        
        for i = 1:num_of_fields
            varargout{i} = inputs.(inputs_fields{i});
        
        end
        
    elseif isvector(inputs)
        num_of_inputs = length(inputs);
        varargout = cell(1, num_of_inputs);
        
        for i = 1:num_of_inputs
           
            varargout{i} = inputs(i);
        
        end
    end

end

