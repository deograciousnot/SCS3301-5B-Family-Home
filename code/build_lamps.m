function S = build_lamps(S)
% BUILD_LAMPS  One ceiling lamp per room: a sphere bulb + a local light.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
pos = [2.5 3 2.55;      % living room
       7.0 3 2.55;      % kitchen
       10.5 3 2.55];    % bedroom
[X, Y, Z] = sphere(16);
S.h.bulbs = gobjects(1, size(pos, 1));
S.h.lamps = gobjects(1, size(pos, 1));
for i = 1:size(pos, 1)
    draw_cylinder(S.h.house, 0.01, 0.25, pos(i,:), [0.2 0.2 0.2], 8); % cord
    S.h.bulbs(i) = surf(0.1*X + pos(i,1), 0.1*Y + pos(i,2), 0.1*Z + pos(i,3), ...
        'Parent', S.h.house, 'FaceColor', [0.5 0.5 0.5], ...
        'EdgeColor', 'none', 'FaceLighting', 'none');
    S.h.lamps(i) = light('Parent', S.ax, 'Style', 'local', ...
        'Position', pos(i,:) - [0 0 0.2], 'Color', [1 0.85 0.6], 'Visible', 'off');
end
end
