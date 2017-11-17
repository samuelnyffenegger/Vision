function F = fundamentalEightPoint_normalized(p1, p2)
% estimateEssentialMatrix_normalized: estimates the essential matrix
% given matching point coordinates
%
% Input: point correspondences
%  - p1(3,N): homogeneous coordinates of 2-D points in image 1
%  - p2(3,N): homogeneous coordinates of 2-D points in image 2
%
% Output:
%  - F(3,3) : fundamental matrix

%% calculations

% bridge
try
    % launched inside fundamentalEightPoint_normalized
    p1 = noisy_x1;
    p2 = noisy_x2;
catch
    % launched from main
end

[p1_tilde, T1] = normalise2dpts(p1); 
[p2_tilde, T2] = normalise2dpts(p2); 
F_tilde = fundamentalEightPoint(p1_tilde,p2_tilde); 
F = T2'*F_tilde*T1;

end