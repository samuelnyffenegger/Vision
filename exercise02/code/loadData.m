function data = loadData()
% data = loadData();
% loads data
% Output:
%   data    struct containing all data
% Samuel Nyffenegger, 16.10.17

%%  calculations

% load camera data and position of checker corners
data.K = load('data/K.txt');
data.p_W = load('data/p_W_corners.txt');
data.detected_corners = load('data/detected_corners.txt');

% load first image
data.img_0001 = rgb2gray(imread('data/images_undistorted/img_0001.jpg'));




end