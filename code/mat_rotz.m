function T = mat_rotz(deg)
% MAT_ROTZ  4x4 homogeneous rotation about the z-axis by DEG degrees (R2).
%   Positive angle = anticlockwise when looking down from +z.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
c = cosd(deg);  s = sind(deg);
T = [c -s 0 0;
     s  c 0 0;
     0  0 1 0;
     0  0 0 1];
end
