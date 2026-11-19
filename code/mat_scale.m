function T = mat_scale(sx, sy, sz)
% MAT_SCALE  4x4 homogeneous scaling matrix about the origin (R2).
%   T = mat_scale(s)          uniform scale
%   T = mat_scale(sx,sy,sz)   different scale on each axis
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
if nargin == 1
    sy = sx; sz = sx;
end
T = [sx 0  0  0;
     0  sy 0  0;
     0  0  sz 0;
     0  0  0  1];
end
