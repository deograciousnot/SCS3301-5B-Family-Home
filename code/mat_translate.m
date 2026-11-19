function T = mat_translate(tx, ty, tz)
% MAT_TRANSLATE  4x4 homogeneous translation matrix (requirement R2).
%   T = mat_translate(tx, ty, tz) moves a point by (tx, ty, tz).
%   Also accepts one vector: mat_translate([tx ty tz]).
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
if nargin == 1            % allow mat_translate([x y z])
    v = tx; tx = v(1); ty = v(2); tz = v(3);
end
T = [1 0 0 tx;
     0 1 0 ty;
     0 0 1 tz;
     0 0 0 1 ];
end
