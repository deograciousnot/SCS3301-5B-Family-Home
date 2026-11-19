function T = mat_rotx(deg)
% MAT_ROTX  4x4 homogeneous rotation about the x-axis by DEG degrees (R2).
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
c = cosd(deg);  s = sind(deg);
T = [1 0  0 0;
     0 c -s 0;
     0 s  c 0;
     0 0  0 1];
end
