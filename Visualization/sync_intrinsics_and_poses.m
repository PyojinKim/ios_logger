function sync_intrinsics_and_poses(cam_file, pose_file, out_file)

% load camera intrinsics
if (~isfile(cam_file))
    error('camera info:{} not found');
end
cam_intrinsics = importdata(cam_file, ',');


% load camera poses
if (~isfile(pose_file))
    error('camera info:{} not found');
end
cam_poses = importdata(pose_file, ',');


% synchronize camera intrinsics and pose
lines = [];
ip = 1;
numCamIntrinsics = size(cam_intrinsics,1);
numCamPoses = size(cam_poses,1);
for k = 1:numCamIntrinsics
    while (ip < numCamPoses) && (abs(cam_poses(ip+1,1) - cam_intrinsics(k,1)) < abs(cam_poses(ip,1) - cam_intrinsics(k,1)))
        ip = ip + 1;
    end
    cam_pose = [cam_poses(ip,2:4), cam_poses(ip,6:8), cam_poses(ip,5)];
    lines = [lines; [k, cam_pose]];
end


% save synced camera poses as text
fileID = fopen(out_file,'w');
for k = 1:length(lines)
    fprintf(fileID, '%05d %1.6f %1.6f %1.6f %1.6f %1.6f %1.6f %1.6f\n', lines(k,:));
end
fclose(fileID);


end