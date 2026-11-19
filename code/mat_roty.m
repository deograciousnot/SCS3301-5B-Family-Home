function T = mat_roty(deg)
% MAT_ROTY  4x4 homogeneous rotation about the y-axis by DEG degrees (R2).
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
c = cosd(deg);  s = sind(deg);
T = [ c 0 s 0;
      0 1 0 0;
     -s 0 c 0;
      0 0 0 1];
end
