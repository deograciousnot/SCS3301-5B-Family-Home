function h = draw_cylinder(parent, r, height, base, col, n)
% DRAW_CYLINDER  Vertical cylinder with a top cap (requirement R1).
%   h = draw_cylinder(parent, radius, height, [x y z], [r g b], nSides)
%   base is the centre of the bottom circle.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
if nargin < 6, n = 24; end
[X, Y, Z] = cylinder(r, n);
h = surf(X + base(1), Y + base(2), Z*height + base(3), ...
         'Parent', parent, 'FaceColor', col, 'EdgeColor', 'none', ...
         'FaceLighting', 'gouraud');
% top cap
th = linspace(0, 2*pi, n+1)';
patch('Parent', parent, ...
      'XData', base(1) + r*cos(th), 'YData', base(2) + r*sin(th), ...
      'ZData', (base(3) + height) * ones(size(th)), ...
      'FaceColor', col, 'EdgeColor', 'none', 'FaceLighting', 'gouraud');
end
