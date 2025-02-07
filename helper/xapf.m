function x_pos = xapf(x,pos,xl)
% Helper function for determining which position in a figure the data point
% provided in 'x' refers to.
%   x - desired x position on figure in data units
%   pos - pass in figure.Position
%   xl - pass in the xlim of the fiture

    x_pos = pos(3)*(x-min(xl))/diff(xl)+pos(1);

end