clc;
close all;
clear variables; %clear classes;
rand('state',0); % rand('state',sum(100*clock));
dbstop if error;

addpath(genpath(pwd));


%% common setting to read text files

delimiter = ',';
datasetPath = '../ios_logger_datasets/2021-07-29T12-52-25';
data_path = datasetPath;











%%


textFileName = 'ARposes.txt';
textFileDir = [datasetPath '/' textFileName];


videoFileName = 'Frames.m4v';
video_path = [datasetPath '/' videoFileName];


%% extract image frames from mp4 video files

outputFolder1 = ('temp_rgb_dataset_snowflake_square_building4');
v1 = VideoReader(video_path);
vid1Frames = read(v1);
for frame = 1:size(vid1Frames,4)
    outputBaseFileName = sprintf('%08d.png',frame);
    outputFullFileName = fullfile(outputFolder1,outputBaseFileName);
    imwrite(vid1Frames(:,:,:,frame),outputFullFileName,'png');
    frame
end


%%



textARposeData = importdata(textFileDir, delimiter);

ARposes.time = textARposeData(:,1).';
ARposes.p_gc = [textARposeData(:,2).'; textARposeData(:,3).'; textARposeData(:,4).'];
ARposes.q_gc = [textARposeData(:,5).'; textARposeData(:,6).'; textARposeData(:,7).'; textARposeData(:,8).'];

numARposes = size(textARposeData,1);

M = numARposes;






% plot update rate of ARKit camera pose
timeDifference = diff(ARposes.time);
meanUpdateRate = (1/mean(timeDifference));
figure;
plot(ARposes.time(2:end), timeDifference, 'm'); hold on; grid on; axis tight;
set(gcf,'color','w'); hold off;
axis([min(ARKitPoseTime) max(ARKitPoseTime) min(timeDifference) max(timeDifference)]);
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman','FontSize',17);
xlabel('Time [sec]','FontName','Times New Roman','FontSize',17);
ylabel('Time Difference [sec]','FontName','Times New Roman','FontSize',17);
title(['Mean Update Rate: ', num2str(meanUpdateRate), ' Hz'],'FontName','Times New Roman','FontSize',17);
set(gcf,'Units','pixels','Position',[100 200 1800 900]);  % modify figure




%%

figure;
plot3(ARposePosition(1,:), ARposePosition(2,:), ARposePosition(3,:), 'm', 'LineWidth', 2); hold on; grid on; axis equal;


% ground truth trajectory in TUM RGBD dataset
R_gc_true = zeros(3,3,M);
p_gc_true = zeros(3,M);
T_gc_true = cell(1,M);
for k = 1:M
    % camera body frame
    R_gc_true(:,:,k) = q2r(ARposes.q_gc(:,k));
    p_gc_true(:,k) = ARposes.p_gc(:,k);
    T_gc_true{k} = [ R_gc_true(:,:,k), p_gc_true(:,k);
        zeros(1,3),           1; ];
end

figure; hold on; axis equal;
L = 0.1; % coordinate axis length
A = [0 0 0 1; L 0 0 1; 0 0 0 1; 0 L 0 1; 0 0 0 1; 0 0 L 1]';
for k = 1:10:M
    T = T_gc_true{k};
    B = T * A;
    plot3(B(1,1:2),B(2,1:2),B(3,1:2),'-r','LineWidth',1); % x: red
    plot3(B(1,3:4),B(2,3:4),B(3,3:4),'-g','LineWidth',1); % y: green
    plot3(B(1,5:6),B(2,5:6),B(3,5:6),'-b','LineWidth',1); % z: blue
end
plot3(p_gc_true(1,:),p_gc_true(2,:),p_gc_true(3,:),'k','LineWidth',2);
title('ground truth trajectory of cam0 frame')
xlabel('x'); ylabel('y'); zlabel('z'); grid on; axis tight;



% 1) play 3D trajectory of ARKit camera pose
figure(10);
for k = 1:M
    figure(10); cla;
    
    % draw moving trajectory
    p_gc_ARKit = p_gc_true(1:3,1:k);
    plot3(p_gc_ARKit(1,:), p_gc_ARKit(2,:), p_gc_ARKit(3,:), 'm', 'LineWidth', 2); hold on; grid on; axis equal;
    
    % draw camera body and frame
    plot_inertial_frame(0.5);
    
    
    set(gca, 'YDir','reverse');
    set(gca, 'ZDir','reverse');
    view(-2, -59);
    
    Rgc_ARKit_current = T_gc_true{k}(1:3,1:3);
    pgc_ARKit_current = T_gc_true{k}(1:3,4);
    plot_camera_ARKit_frame(Rgc_ARKit_current, pgc_ARKit_current, 0.5, 'm'); hold off;
    refresh; pause(0.01); k
end











