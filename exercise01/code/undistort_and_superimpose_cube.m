function undistort_and_superimpose_cube(data)
% undistort_and_superimpose_cube(data);
% undistorts images and superimposes a cube
% Input:
%   Files in data/images/img_xxxx.jpg
%   data    struct containing K, D and poses
% Output:
%   Files in data/images_undistorted/img_xxxx.jpg
% Samuel Nyffenegger, 12.10.17

%% calculations
fprintf(['Starting to undistort images and superimpose a cube on ', ...
    num2str(param.n_frames),' frames... \n'])

for i = 1:param.n_frames
    % print status message
    fprintf(['\tPreparing image ',num2str(i),' of ',num2str(param.n_frames),'\n'])
    
    % load image
    eval(['img_d = rgb2gray(imread(''data/images/img_',num2str(i,'%04.0f'),'.jpg''));'])
    
    % undistort image
    img_u = undistort_image(img_d, data.K, data.D, 'interpolation');

    % generate grid points in real world cooridnate frame
    Pw = generateRealWorldPoints('cube');

    % get relative position and orientation
    pose = data.poses(i,:);
    RT = poseVectorToTransformationMatrix(pose);

    % project points to pixel coordinate system
    Pp = projectPoints(Pw, data.K, RT);

    % connect points to a cube
    [~, ~, z_vec] = helper_CubeLineCoordinates(Pp);
        
    % draw cube on image
    for j = 0:15
        img_u = insertShape(img_u,'Line',z_vec(2*j+1:(2*j+1)+3)','LineWidth',4,'Color','red');
    end
    
    % plot
    % figure(i); clf; hold on;
    %     imshow(img_u,'InitialMagnification','fit');
    %     % line(x_vec,y_vec,'LineWidth',3,'Color','r')

    % save image
    eval(['imwrite(img_u,''data/images_undistorted/img_',num2str(i,'%04.0f'),'.jpg'');']);
     
end


end