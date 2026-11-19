function S = build_tv(S)
% BUILD_TV  TV stand, frame and a screen whose colour we change when the
%   TV is switched on (see update_scene).
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
P = S.h.house;
draw_box(P, [1.2 0.45 0.55], [1.60 5.45 0],    [0.30 0.20 0.12]);   % stand
draw_box(P, [1.5 0.06 0.85], [1.45 5.85 0.70], [0.05 0.05 0.05]);   % frame

% Screen: one flat patch just in front of the frame. FaceLighting 'none'
% so it looks like it is glowing rather than being lit by the lamps.
S.h.tvScreen = patch('Parent', P, ...
    'XData', [1.50 2.90 2.90 1.50], 'YData', 5.84*[1 1 1 1], ...
    'ZData', [0.75 0.75 1.50 1.50], 'FaceColor', [0.02 0.02 0.02], ...
    'EdgeColor', 'none', 'FaceLighting', 'none');
end
