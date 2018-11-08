function font_size = new_font_size(varargin)

    if isempty(varargin)
        
        % Default values
        font_size = struct('title', 14, 'legend', 18, 'xlabel', 12, 'ylabel', 12);
        
    else        
        font_size = struct(...
            'title',  varargin(1),...
            'legend', varargin(2),...
            'xlabel', varargin(3),...
            'ylabel', varargin(4));
    end
    
end

