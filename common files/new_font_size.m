function font_size = new_font_size(varargin)

    if isempty(varargin)
        
        % Default values
        font_size = struct('title', 14, 'legend', 18, 'xlabel', 12, 'ylabel', 12);
        
    else        
        font_size = struct(...
            'title', title,...
            'legend', legend,...
            'xlabel', xlabel,...
            'ylabel', ylabel);
    end
    
end

