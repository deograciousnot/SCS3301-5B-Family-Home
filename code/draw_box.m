function h = draw_box(parent, sz, origin, col)
% DRAW_BOX  Draw a rectangular box with PATCH (requirement R1).
%   h = draw_box(parent, [w d h], [x y z], [r g b])
%   parent : axes or hgtransform that will own the box
%   sz     : size along x, y, z (metres)
%   origin : the box's minimum corner (x, y, z)
%   col    : face colour
%
%   Each face gets its own 4 vertices (24 in total) so that the lighting
%   normals stay sharp at the edges even with smooth (Gouraud) shading.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
c = [0 0 0; 1 0 0; 1 1 0; 0 1 0;      % unit cube corners
     0 0 1; 1 0 1; 1 1 1; 0 1 1];
faces = [1 2 3 4; 5 6 7 8; 1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8];

V = zeros(24, 3);
for k = 1:6
    V(4*k-3:4*k, :) = c(faces(k, :), :);
end
V = V .* sz + origin;                 % scale then move into place
F = reshape(1:24, 4, 6)';

h = patch('Parent', parent, 'Vertices', V, 'Faces', F, ...
          'FaceColor', col, 'EdgeColor', 'none', ...
          'FaceLighting', 'gouraud');  % smooth shading (R5)
end
