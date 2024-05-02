# Gauntlet Challenge
## Summary
Our goal for this project is to get our Neato through the obstacle course of spiky walls and death traps so that it could touch the Ball of Benevolence, gaining the power of infinite knowledge. 

## Data Collection
Run neato_lidar.m file to collect Neato Lidar data at different
positions and angles. 

Then, in buildMap.m, on line 3, in the load function, add the file
you saved from data_collection.m. Our's is 'valorant3.mat'. This function will output a file named 'global_points.mat'. This is a matrix containing the X and Y coordinates of detected objects in the global frame.

From global_points.mat, we utilize these points to construct a potential field.
