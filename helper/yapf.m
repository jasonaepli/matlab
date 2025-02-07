function y_pos = yapf(y,pos,yl)
% Helper function for determining which position in a figure the data point
% provided in 'y' refers to.
%   y - desired y position on figure in data units
%   pos - pass in figure.Position
%   yl - pass in the xlim of the fiture

    y_pos = pos(4)*(y-min(yl))/diff(yl)+pos(2);

end