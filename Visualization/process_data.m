function process_data(data_path)

% save image
disp('Extract images from video...');
video_path = [data_path '/Frames.m4v'];
image_path = [data_path '/images'];
if (~exist(image_path, 'dir'))
    mkdir(image_path);
end


%% extract_frames

video_path = video_path;
out_folder = image_path;
size = [480, 640];









%%








end

