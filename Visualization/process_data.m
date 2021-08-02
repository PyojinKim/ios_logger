function process_data(data_path)

% initial value
data_source = 'ARKit';
window_size = 9;
min_angle = 15;
min_distance = 0.1;
ori_size = [1440, 1920];
size = [480, 640];


% save image
disp('Extract images from video...');
video_path = [data_path '/Frames.m4v'];
image_path = [data_path '/images'];
if (~exist(image_path, 'dir'))
    mkdir(image_path);
end
extract_frames(video_path, image_path, size);


% load intrinsics and extrinsics (ARKit poses)
disp('Load intrinsics and extrinsics');
sync_intrinsics_and_poses([data_path '/Frames.txt'], [data_path '/ARposes.txt'], [data_path '/SyncedPoses.txt']);


%%












end

