function  points = projectPoints(Pw, K, RT, D)
% points = projectPoints(Pw, K, RT);
% points = projectPoints(Pw, K, RT, D);
% projects points in world coordinate Pw frame to pixel coordinates on image (u,v)
% Input:
%   Pw      Nx3 Points in world frame Pw = [x1,y1,z1; x2,y2,z2; ...]
%   K       3x3 Camera matrix
%   RT      3x4 transformation
%   D       2x1 distortion model, two parameters
% Output:
%   points  Nx2 discretized pixel coordinates, points = [u1, v1; u2, v2; ...]
% Samuel Nyffenegger, 09.10.17
    
%%  calculations
N = size(Pw,1); 
points = zeros(N,2);

if nargin < 4
    % do not apply radial distortion
    
    % loop over points
    for i = 1:N
        % get single point in homogeneous coordinates
        point_tilde = [Pw(i,:)';1];

        % perspective projection
        p_tilde = K*RT*point_tilde; 

        % get discretized pixel coordinates 
        u = p_tilde(1)/p_tilde(3);
        v = p_tilde(2)/p_tilde(3);

        % update
        points(i,:) = [u, v];
    end   
   
else
    % apply radial distortion up to forth order

    % loop over points
    for i = 1:N
        % get single point in homogeneous coordinates
        point_tilde = [Pw(i,:)';1];

        % map world point into camera frame
        p_c_tilde = RT*point_tilde;

        % map into image plane with normalized coordinates
        p = [p_c_tilde(1)/p_c_tilde(3); p_c_tilde(2)/p_c_tilde(3)];

        % apply lens distortion
        r = sqrt(p(1).^2 + p(2).^2);
        p_d = (1 + D(1)*r.^2 + D(2)*r.^4) * p; 
        
        % get discretized pixel coordinates 
        p_d_tilde = [p_d;1];
        p_tilde = K*p_d_tilde; 
        u = p_tilde(1)/p_tilde(3);
        v = p_tilde(2)/p_tilde(3);

        % update
        points(i,:) = [u, v];
    end
end



end

