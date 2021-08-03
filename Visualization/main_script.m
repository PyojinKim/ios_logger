clc;
close all;
clear variables; %clear classes;
rand('state',0); % rand('state',sum(100*clock));
dbstop if error;

addpath(genpath(pwd));


%% main sciprt to process ARKit and image data

% define dataset directory from iOS Logger app
datasetPath = '../ios_logger_datasets/2021-07-29T12-52-25';
process_data(datasetPath);


% load ARKit camera poses
cam_pose_dict = load_camera_pose([datasetPath '/SyncedPoses.txt']);
M = length(cam_pose_dict);
R_gc_ARKit = zeros(3,3,M);
p_gc_ARKit = zeros(3,M);
T_gc_ARKit = cell(1,M);
for k = 1:M
    % camera body frame
    R_gc_ARKit(:,:,k) = cam_pose_dict(1:3,1:3,k);
    p_gc_ARKit(:,k) = cam_pose_dict(1:3,4,k);
    T_gc_ARKit{k} = [ R_gc_ARKit(:,:,k), p_gc_ARKit(:,k);
        zeros(1,3),           1; ];
end


% 1) visualize ARKit VIO motion estimation results
figure; hold on; axis equal;
L = 0.1;
A = [0 0 0 1; L 0 0 1; 0 0 0 1; 0 L 0 1; 0 0 0 1; 0 0 L 1]';
for k = 1:10:M
    T = T_gc_ARKit{k};
    B = T * A;
    plot3(B(1,1:2),B(2,1:2),B(3,1:2),'-r','LineWidth',1); % x: red
    plot3(B(1,3:4),B(2,3:4),B(3,3:4),'-g','LineWidth',1); % y: green
    plot3(B(1,5:6),B(2,5:6),B(3,5:6),'-b','LineWidth',1); % z: blue
end
plot3(p_gc_ARKit(1,:),p_gc_ARKit(2,:),p_gc_ARKit(3,:),'k','LineWidth',2);
title('ARKit VIO motion estimation results');
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]'); grid on; axis tight;

% figure options
f = FigureRotator(gca());


% 2) play 3D trajectory of ARKit camera pose
figure(10);
for k = 1:M
    figure(10); cla;
    
    % draw moving trajectory
    plot3(p_gc_ARKit(1,1:k), p_gc_ARKit(2,1:k), p_gc_ARKit(3,1:k), 'm', 'LineWidth', 2); hold on; grid on; axis equal;
    
    % draw camera body and frame
    plot_inertial_frame(0.5); view(-8, 30);
    Rgc_ARKit_current = T_gc_ARKit{k}(1:3,1:3);
    pgc_ARKit_current = T_gc_ARKit{k}(1:3,4);
    plot_camera_ARKit_frame(Rgc_ARKit_current, pgc_ARKit_current, 0.5, 'm'); hold off;
    refresh; pause(0.01); k
end











