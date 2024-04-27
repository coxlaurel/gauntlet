clear;
syms x y

% flatlands
f = 100*log(sqrt((x-0.244).^2+(y-1.128).^2));

load("global_points.mat")
global_points = global_points; % global points from gauntlet map

i = 1;
while i < length(global_points) + 1 % loop through all global points
    % define x, y coordinate pair
    x_coord = global_points(1,i);
    y_coord = global_points(2,i);
    f = build_equation(f, x, y, x_coord, y_coord); % add source at coordinate
    i = i + 1;
end

fx = diff(f,x);
fy = diff(f,y);
gradient = [fx, fy];


%Starting position and orientation
startingx = 0;
startingy = 0;
startingTheta = 0;

%Parameters
lambda = 0.05;
linearWheelV = 0.08;

%While loop parameters
i = 2;
i_max = 40;

%Initial position and gradient
r_0 = [startingx; startingy]; %First coordinate
r_list(:,1) = r_0;
r = r_0;

grad = double(subs(gradient, {x, y}, {r(1), r(2)}));
neatov2.setPositionAndOrientation(startingx,startingy,startingTheta)

%%FOR NON-SIMULATED%%
%orientation = startingTheta

while i < i_max && norm(grad) > 0.5
    grad = double(subs(gradient, {x, y}, {r(1), r(2)}));
    % CHANGE FOR #6: make lambda proportional to the gradiant
    lambda = 0.009*norm(grad); % default lambda
    if norm(grad) > 4 % adjust lambda for extra steep steps
        lambda = 0.0005*norm(grad);
    end
    next_r = r + lambda*grad;
    vectorDiff = next_r-r;
    newOrientation = atan2(vectorDiff(2),vectorDiff(1));

    %%FOR NON-SIMULATED%%
    %deltaTheta = newOrientation-orientation;
    %angularV = -0.1/0.254;
    %spinTime = abs(deltaTheta/angularV);
    %neatov2.driveFor(spinTime, sign(deltaTheta)*-0.05, sign(deltaTheta)*0.05, true);
    %pause(.01)

    distance = norm(vectorDiff);
    % CHANGE FOR #6: if distance of path is insignificant, end the loop
    if distance < 0.0018
        break
    end
    driveTime = distance/linearWheelV;
    neatov2.setPositionAndOrientation(r(1),r(2),newOrientation)
    neatov2.driveFor(driveTime, linearWheelV, linearWheelV, true)

    %%FOR NON-SIMULATED%%
    %pause(.01)

    r = next_r;
    r_list(:,i) = r;
    i = i + 1;

    %%FOR NON-SIMULATED%%
    %orientation = newOrientation; 
end


function [v] = build_equation(v, x, y, x_coord, y_coord)
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

    v = v - (log(sqrt((x-x_coord).^2+(y-y_coord).^2)));
end