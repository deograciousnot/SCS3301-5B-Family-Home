function S = build_rooms(S)
% BUILD_ROOMS  Floors, walls and the living-room window.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
P = S.h.house;
H = 2.8;                 % wall height
t = 0.1;                 % wall thickness
wallCol = [0.93 0.90 0.82];

% Floors (a different colour per room)
draw_box(P, [5 6 0.02], [0 0 -0.02], [0.60 0.45 0.30]);   % living: wood
draw_box(P, [4 6 0.02], [5 0 -0.02], [0.80 0.80 0.78]);   % kitchen: tiles
draw_box(P, [3 6 0.02], [9 0 -0.02], [0.55 0.60 0.70]);   % bedroom: carpet

% Outer walls (front wall left out on purpose = cut-away view)
draw_box(P, [12+2*t t H], [-t 6 0], wallCol);   % back wall
draw_box(P, [t 6 H],      [-t 0 0], wallCol);   % left wall
draw_box(P, [t 6 H],      [12 0 0], wallCol);   % right wall

% Interior walls at x = 5 and x = 9, each with a door opening y = 1..2
for x = [5 9]
    draw_box(P, [t 1 H],   [x-t/2 0 0],   wallCol);   % y 0..1
    draw_box(P, [t 4 H],   [x-t/2 2 0],   wallCol);   % y 2..6
    draw_box(P, [t 1 0.7], [x-t/2 1 2.1], wallCol);   % lintel above door
end

% Window on the living-room back wall (sunlight "comes in" from here)
S.h.window = patch('Parent', P, ...
    'XData', [3.6 4.6 4.6 3.6], 'YData', 5.99*[1 1 1 1], ...
    'ZData', [1.0 1.0 2.0 2.0], ...
    'FaceColor', [0.6 0.8 1.0], 'EdgeColor', [0.3 0.2 0.1], ...
    'LineWidth', 2, 'FaceLighting', 'none');
end
