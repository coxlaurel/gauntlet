function [positions, angles, scans] = hw8()
    % connect to the Neato
    neatov2.connect('192.168.16.116');
    neatov2.testConnection();
    % these are the angles and positions we will test.  There will be a
    % pause to alert the user to reposition the Neato between each of these
    % the angles are defined in degrees using counterclockwise rotations
    % relative to the x-axis
    angles = [0.0; 90.0; 0.0; 90.0; 180; 270;];
    positions = [0.0, 0.0; 
                 0.0, 0.0;
                 0.5, 1.0;
                 0.5, 1.0;
                 0.5, 1.0;
                 0.5, 1.0];
                 
    scans = cell(6,1);


    for i = 1:size(positions,1)
        disp(['Move the Neato to position x=', ...
               num2str(positions(i,1)), ...
               ' y=', ...
               num2str(positions(i,2)), ...
               ' at an angle of ', ...
               num2str(angles(i)), ...
               ' degrees counterclockwise from the x-axis']);
        pause;
        scans{i} = neatov2.receive();
    end

    save('valorant3','angles','positions','scans');
    end
