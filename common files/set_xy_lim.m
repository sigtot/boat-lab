function [fig] = set_xy_lim(fig, xlim, ylim)

    a = findall(fig, 'Type', 'Axes');
    set(a, 'XLim', xlim, 'YLim', ylim);

end

