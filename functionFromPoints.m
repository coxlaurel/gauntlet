function [v, x, y] = functionFromPoints(points)
    [x,y]=meshgrid(-1:0.05:2,-1:0.05:2); % define the potential at all mesh points

    v = 38*log(sqrt((x-0.244).^2+(y-1.128).^2)); % function that defines Bob as sink (put at 35 for vid 4/29)

    i = 1;
    while i < length(points) + 1 % loop through all global points
        % define x, y coordinate pair
            x_coord = points(1,i);
            y_coord = points(2,i);
            v = buildEquation(v, x, y, x_coord, y_coord); % add source at coordinate          
            i = i + 1;
    end
end