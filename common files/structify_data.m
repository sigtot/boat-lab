function structified_data = structify_data(time,values_array)

    [~, num_of_rows] = size(values_array);
    
    structified_data = cell(1, num_of_rows);
    
    for i = 1:num_of_rows
       
        structified_data{i} = new_data(time, values_array(:, i));
        
    end
    
    if num_of_rows == 1
        structified_data = structified_data{1};
    end

end

