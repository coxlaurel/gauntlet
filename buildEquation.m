function [v] = buildEquation(v, x, y, x_coord, y_coord)
% Add new source to equation evaluted at meshgrid.
%
% Inputs
%   v (square matrix): Equation evaluted at meshgrid
%   x (square matrix): X coordinates of meshgrid
%   y (square matric): Y coordinates of meshgrid
%   x_coord (float): X coordinate of source
%   y_coord(float): Y coordinate of source
%
% Returns
%   v (square matrix): Newly built equation evaluted at meshgrid

    v = v - 0.16 * (log(sqrt((x-x_coord).^2+(y-y_coord).^2))); %had at 0.1 for vid 4/29
end