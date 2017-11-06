%% snippets

%% show left and right image
clc
figure(1); clf
    imshow(left_img)
figure(2); clf
    imshow(right_img)


%% parallel computing
clc
tic
parfor (i=1:20, 15)
    disp(i) 
end
time = toc