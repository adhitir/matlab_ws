
%% Publish velocity
vel_publisher = rospublisher('/cmd_vel_mux/input/teleop');
msg = rosmessage(vel_publisher);
msg.Linear.X = 0.2;
send(vel_publisher,msg);

%% Subscribe to the pose
odom_sub = rossubscriber('/odom');
odomdata = receive(odom_sub);
pose = odomdata.Pose.Pose;
quat = pose.Orientation;

x = pose.Position.X;
y = pose.Position.Y;
z = pose.Position.Z;

current_position = [x,y,z]

angle = quat2eul([quat.W quat.X quat.Y quat.Z]);

current_theta =  rad2deg(angle(1))