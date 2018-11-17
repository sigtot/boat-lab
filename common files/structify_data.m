function structified_data = structify_data(time,values_array)

    [~, num_of_cols] = size(values_array);
    
    structified_data = cell(1, num_of_cols);
    
    for i = 1:num_of_cols
       
        structified_data(i) = new_data(time, values_array(:, i));
        
    end
    
    if num_of_cols == 1
        structified_data = structified_data{1};
    end

end

