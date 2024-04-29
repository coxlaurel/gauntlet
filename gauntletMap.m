function gauntletMap()
    % Load data from 'valorant2.mat'
    load('valorant3','angles','positions','scans');

    % Create a figure to hold all the subplots
    allPlots = figure;
    title('Superimposed Plots');

    % Initialize an empty array to store global points
    global_points = [];

    % Iterate over each position
    for i = 1:size(positions,1)
        % Calculate rotation angle in radians
        th = deg2rad(angles(i));

        % Transformation matrix from robot's frame to global frame
        RobotToGlobal = [cos(th) -sin(th) positions(i,1);
                         sin(th) cos(th) positions(i,2);
                         0 0 1];

        % Scanner's position relative to the robot
        ScannerToRobot = [1 0 -0.082;
                          0 1 0;
                          0 0 1];

        % Transformation matrix from scanner's frame to global frame
        ScannerToGlobal = RobotToGlobal * ScannerToRobot;

        % Extract ranges and thetas
        ranges = scans{i}.ranges;
        thetasInRadians = scans{i}.thetasInRadians;

        % Convert polar coordinates to Cartesian coordinates
        cart = [cos(thetasInRadians);
                sin(thetasInRadians)] .* [ranges; ranges];

        % Convert to homogeneous coordinates
        cartHomogeneous = [cart; ones(1, size(cart,2))];

        % Remove points with zero range
        cleaned = cartHomogeneous(:, ranges~=0);

        % Transform points to global frame
        globalCleaned = ScannerToGlobal * cleaned;

        % Store global points
        global_points = [global_points, globalCleaned];

        % Plot individual scan for current position
        figure;
        title(['x=',num2str(positions(i,1)), ...
                ' y=', num2str(positions(i,2)),...
                ' angles=', num2str(angles(i))]);
        scatter(globalCleaned(1,:), globalCleaned(2,:), 'b.');
        axis equal;

        % Plot on combined plot
        figure(allPlots);
        hold on;
        scatter(globalCleaned(1,:), globalCleaned(2,:), 'b.');
        axis equal;
    end

    % Save global points
    save('global_points.mat', 'global_points');
end


% function gauntletMap()
%     load('valorant2.mat','angles','positions','scans');
%     allPlots = figure;
%     title('Superimposed Plots');
%     for i=1:size(positions,1)
%         th = deg2rad(angles(i));
%         RobotToGlobal = [cos(th) -sin(th) positions(i,1);
%                          sin(th) cos(th) positions(i,2);
%                          0 0 1];
%         % the scanner is located about 8cm behind the center of rotation of
%         % the robot
%         ScannerToRobot = [1 0 -0.082;
%                           0 1 0;
%                           0 0 1];
% 
%         ScannerToGlobal = RobotToGlobal * ScannerToRobot;
%         ranges = scans{i}.ranges;
%         thetasInRadians = scans{i}.thetasInRadians;
%         cart = [cos(thetasInRadians);
%                 sin(thetasInRadians)].*[ranges; ranges];
%         cartHomogeneous = [cart; ones(1, size(cart,2))];
%         cleaned = cartHomogeneous(:, ranges~=0);
%         globalCleaned = ScannerToGlobal*cleaned;
%         points_i = globalCleaned;
%         figure;
%         title(['x=',num2str(positions(i,1)), ...
%                 ' y=', num2str(positions(i,2)),...
%                 ' angles=', num2str(angles(i))]);
%         scatter(globalCleaned(1,:), globalCleaned(2,:), 'b.');
%         axis("equal");
%         figure(allPlots);
%         hold on;
%         scatter(globalCleaned(1,:), globalCleaned(2,:), 'b.');
%         axis("equal");
%     end
%     global_points = [points_1; points_2; points_3; points_4; points_5];
%     save('global_points', 'global_points')
% end