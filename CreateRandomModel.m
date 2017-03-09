

gazebo = ExampleHelperGazeboCommunicator();

%% Creating a random model

random_model = ExampleHelperGazeboModel('WhatIwanttocallmymodel');

% Add ball in my model 
balllink = addLink(random_model,'sphere',0.5,'position',[0 0 0],'color',[0 0 1 1]);
% Add a cube to my model
cubelink = addLink(random_model,'box',[1 1 1],'position',[1 0 0],'color',[0 0 1 1]);

spawnModel(gazebo,random_model,[0,2,0])

%% Remove the model

try
    removeModel(gazebo,'WhatIwanttocallmymodel');
catch
    disp('Error while removing model');
end