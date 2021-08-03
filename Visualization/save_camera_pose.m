function save_camera_pose(poses_path, cam_pose_dict)

% save camera extrinsics (pose) as text file
for k = progress(1:length(cam_pose_dict))
    out_file = [poses_path sprintf('/%05d.txt', k)];
    fileID = fopen(out_file,'w');
    fprintf(fileID, '%.10f %.10f %.10f %.10f\n', cam_pose_dict(1,:,k));
    fprintf(fileID, '%.10f %.10f %.10f %.10f\n', cam_pose_dict(2,:,k));
    fprintf(fileID, '%.10f %.10f %.10f %.10f\n', cam_pose_dict(3,:,k));
    fprintf(fileID, '%.10f %.10f %.10f %.10f\n', cam_pose_dict(4,:,k));
    fclose(fileID);
end


end

