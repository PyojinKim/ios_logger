function save_camera_intrinsic(intrinsics_path, cam_intrinsic_dict)

% save camera intrinsics as text file
for k = progress(1:length(cam_intrinsic_dict))
    out_file = [intrinsics_path sprintf('/%05d.txt', k)];
    fileID = fopen(out_file,'w');
    fprintf(fileID, '%.6f %.6f %.6f\n', cam_intrinsic_dict(1,:,k));
    fprintf(fileID, '%.6f %.6f %.6f\n', cam_intrinsic_dict(2,:,k));
    fprintf(fileID, '%.6f %.6f %.6f\n', cam_intrinsic_dict(3,:,k));
    fclose(fileID);
end


end

