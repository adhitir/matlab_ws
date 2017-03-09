

% Creating a probabaistic occupancy grid

image = imread(fullfile('yourfilepath/randomthings.pgm'));
imageCropped = image(150:360,150:360);
imshow(imageCropped)

% PGM values are expressed from 0 to 255 as uint8.
% Normalize these values by converting the cropped image to double 
% and dividing each cell by 255. This image shows obstacles as values 
% close to 0. Subtract the normalized image from 1 to get occupancy 
% values with 1 representing occupied space.

imageNorm = double(imageCropped)/255;
imageOccupancy = 1 - imageNorm;

map = robotics.OccupancyGrid(imageOccupancy,20);
show(map)

% set the radius of the robot as PRM does not account for it. We want to
% increase the size of the walls to account for the robot raduis.
robotRadius = 0.01;

mapInflated = copy(map);
inflate(mapInflated, robotRadius);
show(mapInflated)

% Creating a Probabalistic Road Map

prm = robotics.PRM;

prm.Map = mapInflated;
prm.NumNodes = 60;
prm.ConnectionDistance = 5;

% Display PRM graph
show(prm)

% Select the start and end points
uiwait(msgbox('Locate the start point'))
startLocation = ginput(1);

uiwait(msgbox('Locate the end point'))
endLocation = ginput(1);

% Search for a solution between start and end location.
path = findpath(prm, startLocation, endLocation);

% If a path does not exist, increase the number of nodes.
while isempty(path)
    prm.NumNodes = prm.NumNodes + 10;
    update(prm);
    path = findpath(prm, startLocation, endLocation);
end

% Display path
path

show(prm)

% % If prm plots nodes in the grey area it's because the grey region isn't
% % dark enough. Increase contrast to correct this.
% X = imread('filepath/randomthings.jpeg');
% Y = rgb2gray(X);
% J = imadjust(Y,[0.6 1],[]);
% imshow(J)
% imwrite(X,'randomthings.pgm')