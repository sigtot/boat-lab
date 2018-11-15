function varargout = new_data(varargin)
    varargout = cell(1, length(varargin));
    
    if ~isstruct(varargin{1}) % WARNING: Ugly code
        varargout{1} = struct(...
            'time', varargin{1},...
            'values', varargin{2});
    elseif any(cellfun(@isstruct,varargin))
        
        for i = 1:length(varargin)
            varargout{i} = struct(...
                'time', varargin{i}.time,...
                'values', varargin{i}.signals.values);
        end
    end

end

