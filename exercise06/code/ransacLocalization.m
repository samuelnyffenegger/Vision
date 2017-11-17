function [R_C_W, t_C_W, query_keypoints, all_matches, best_inlier_mask, ...
    max_num_inliers_history] = ransacLocalization(...
    query_image, database_image, database_keypoints, p_W_landmarks, K)
% query_keypoints should be 2x1000
% all_matches should be 1x1000 and correspond to the output from the
%   matchDescriptors() function from exercise 3.
% best_inlier_mask should be 1xnum_matched (!!!) and contain, only for the
%   matched keypoints (!!!), 0 if the match is an outlier, 1 otherwise.

%% calculations

% bridge
try 
    % launched inside ransacLocalization
    if ~exist('query_image','var'); query_image = imread('../data/000001.png'); end
catch
    % launched from main
end

%% find keypoints in the query image
clc
harris_patch_size = 9;
harris_kappa = 0.08;
num_keypoints = 1000;
nonmaximum_supression_radius = 8;
descriptor_radius = 9;
match_lambda = 5;

% calculate keypoints and descriptors for query image
query_harris = harris(query_image, harris_patch_size, harris_kappa);
query_keypoints = selectKeypoints(query_harris, num_keypoints, nonmaximum_supression_radius);
query_descriptors = describeKeypoints(query_image, query_keypoints, descriptor_radius); 

% calculate keypoints and descriptors for database image
database_harris = harris(database_image, harris_patch_size, harris_kappa);
database_keypoints = selectKeypoints(database_harris, num_keypoints, nonmaximum_supression_radius);
database_descriptors = describeKeypoints(database_image, database_keypoints, descriptor_radius); 

% match query and database keypoints and plot it
matches = matchDescriptors(query_descriptors, database_descriptors, match_lambda);
plotMatches(matches, query_keypoints, database_keypoints, query_image, 1); 

%%
figure(1); clf; 
    imshow(query_image);
    hold on;
    plot(query_keypoints(2, 1:num_keypoints), query_keypoints(1, 1:num_keypoints), 'rx', 'Linewidth', 2);
    title('query image');


%% tmp
n_matched = 100;
R_C_W = eye(3); 
t_C_W = zeros(3,1);
query_keypoints = zeros(2,1000);
all_matches = zeros(1,1000);
best_inlier_mask = ones(1,n_matched);
max_num_inliers_history = ones(1,2000); 

end