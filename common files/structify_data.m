function values_cell_array = structify_data(time,values_array)

    [~, num_of_rows] = size(values_array);

    values_cell_array = cell(1, num_of_rows);
    
    for i = 1:num_of_rows
       
        values_cell_array{i} = new_data(time, values_array(:, i));
        
    end

end

