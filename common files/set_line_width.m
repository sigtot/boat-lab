function set_line_width(fig, line_width)

    set(findall(fig, 'Type', 'Line'), 'LineWidth', line_width);

end

