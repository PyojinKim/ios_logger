function [pose_dict] = load_camera_pose(pose_file)

% load camera poses
if (~isfile(pose_file))
    error('camera info:{} not found');
end
cam_poses = importdata(pose_file, ' ');
numCamPoses = size(cam_poses,1);


% extract camera poses
R_constant = [1, 0, 0;
    0, -1, 0;
    0, 0, -1];
pose_dict = zeros(4,4,numCamPoses);
for k = 1:numCamPoses
    R_gc = q2r([cam_poses(k,8), cam_poses(k,5:7)]);
    p_gc = cam_poses(k,2:4).';
    
    R_gc = rotx(pi/2) * R_gc * R_constant;
    p_gc = rotx(pi/2) * p_gc;
    
    T_gc = eye(4);
    T_gc(1:3,1:3) = R_gc;
    T_gc(1:3,4) = p_gc;
    pose_dict(:,:,k) = T_gc;
end


end

