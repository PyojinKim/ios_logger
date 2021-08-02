function [cam_dict] = load_camera_intrinsic(cam_file, original_image_size, target_image_size)

% load camera intrinsics
if (~isfile(cam_file))
    error('camera info:{} not found');
end
cam_intrinsics = importdata(cam_file, ',');
numCamIntrinsics = size(cam_intrinsics,1);


% extract camera intrinsics
cam_dict = zeros(3,3,numCamIntrinsics);
for k = 1:numCamIntrinsics
    cam_dict(:,:,k) = [cam_intrinsics(k,3), 0, cam_intrinsics(k,5);
        0, cam_intrinsics(k,4), cam_intrinsics(k,6);
        0, 0, 1];
end


% adjust camera intrinsics with target image size
for k = 1:numCamIntrinsics
    cam_dict(1,:,k) = cam_dict(1,:,k) / (original_image_size(2) / target_image_size(2));
    cam_dict(2,:,k) = cam_dict(2,:,k) / (original_image_size(1) / target_image_size(1));
end


end

