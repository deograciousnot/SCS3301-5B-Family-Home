function S = build_fridge(S)
% BUILD_FRIDGE  Fridge as a hierarchy (R3):
%       house -> fridge body -> fridge door -> door handle
%   The door swings about a hinge on its front-right edge.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
body = hgtransform('Parent', S.h.house);
bodyPatch = draw_box(body, [0.75 0.70 1.80], [8.10 5.20 0], [0.92 0.93 0.96]);
material(bodyPatch, 'shiny');

% Interior light: only visible while the door is open (see update_scene)
glow = patch('Parent', body, ...
    'XData', [8.15 8.80 8.80 8.15], 'YData', 5.19*[1 1 1 1], ...
    'ZData', [0.10 0.10 1.70 1.70], 'FaceColor', [1 1 0.85], ...
    'EdgeColor', 'none', 'FaceLighting', 'none', 'Visible', 'off');

door = hgtransform('Parent', body);
doorPatch = draw_box(door, [0.75 0.05 1.80], [8.10 5.15 0], [0.85 0.87 0.92]);
material(doorPatch, 'shiny');

handle = hgtransform('Parent', door);
draw_box(handle, [0.04 0.05 0.50], [8.15 5.10 0.90], [0.3 0.3 0.3]);

S.fridge.body   = body;
S.fridge.door   = door;
S.fridge.handle = handle;
S.fridge.glow   = glow;
S.fridge.hinge  = [8.85 5.15 0];   % front-right corner, vertical axis
S.fridge.angle  = 0;
S.fridge.target = 0;
S.fridge.openTime = 0;             % seconds the door has been open

% Night-mode warning sign above the fridge (hidden until needed)
S.fridge.warn = text(S.ax, 8.47, 5.0, 2.15, 'DOOR OPEN!', ...
    'Color', [1 0.15 0.1], 'FontWeight', 'bold', 'FontSize', 12, ...
    'HorizontalAlignment', 'center', 'Visible', 'off');
end
