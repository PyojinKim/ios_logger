function process_data(data_path)

% initial value
window_size = 9;
min_angle = 15;
min_distance = 0.1;
original_image_size = [1440, 1920];
target_image_size = [480, 640];


% save image
disp('Extract images from video...');
video_path = [data_path '/Frames.m4v'];
image_path = [data_path '/images'];
if (~exist(image_path, 'dir'))
    mkdir(image_path);
end
extract_frames(video_path, image_path, target_image_size);


% load intrinsics and extrinsics (ARKit poses)
disp('Load intrinsics and extrinsics');
sync_intrinsics_and_poses([data_path '/Frames.txt'], [data_path '/ARposes.txt'], [data_path '/SyncedPoses.txt']);


% save camera intrinsics
intrinsics_path = [data_path '/intrinsics'];
if (~exist(intrinsics_path, 'dir'))
    mkdir(intrinsics_path);
end
cam_intrinsic_dict = load_camera_intrinsic([data_path '/Frames.txt'], original_image_size, target_image_size);
for k = progress(1:length(cam_intrinsic_dict))
    out_file = [intrinsics_path sprintf('/%05d.txt', k)];
    fileID = fopen(out_file,'w');
    fprintf(fileID, '%.6f %.6f %.6f\n', cam_intrinsic_dict(1,:,k));
    fprintf(fileID, '%.6f %.6f %.6f\n', cam_intrinsic_dict(2,:,k));
    fprintf(fileID, '%.6f %.6f %.6f\n', cam_intrinsic_dict(3,:,k));
    fclose(fileID);
end


%%

% save camera poses
cam_pose_dict = load_camera_pose([data_path '/SyncedPoses.txt']);









end

