function extract_frames(video_path, out_folder, size)

% extract image frames from the video file
cap = VideoReader(video_path);
frame_count = cap.NumFrames;
for k = progress(1:frame_count)
    frame = read(cap, k);
    frame = imresize(frame, size);
    imwrite(frame, [out_folder sprintf('/%05d.png', k)]);
end


end

% k = 1;
% figure;
% imshow(frame);
