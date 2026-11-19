function S = build_cooker(S)
% BUILD_COOKER  Cooker, burner, sufuria (cylinder) and its lid.
%   The lid's vertices are stored so update_scene can move it by
%   multiplying them with OUR OWN 4x4 matrices (requirement R2).
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
P = S.h.house;
draw_box(P, [0.80 0.60 0.90], [5.50 5.30 0], [0.95 0.95 0.95]);   % cooker
draw_box(P, [0.80 0.02 0.25], [5.50 5.28 0.50], [0.1 0.1 0.1]);   % oven door glass

c = [5.90 5.60];                         % burner / sufuria centre (x,y)
S.h.burner = draw_cylinder(P, 0.15, 0.02, [c 0.90], [0.15 0.15 0.15], 24);
pot = draw_cylinder(P, 0.17, 0.18, [c 0.92], [0.75 0.75 0.78], 24);
material(pot, 'metal');

% Lid: a flat disc made with patch
th = linspace(0, 2*pi, 32)'; th(end) = [];
lidZ = 1.105;
S.lidV0 = [c(1) + 0.18*cos(th), c(2) + 0.18*sin(th), lidZ*ones(size(th))];
S.lidCentre = [c lidZ];
S.h.lid = patch('Parent', P, 'Vertices', S.lidV0, 'Faces', 1:numel(th), ...
                'FaceColor', [0.65 0.65 0.68], 'EdgeColor', [0.4 0.4 0.4], ...
                'FaceLighting', 'gouraud');
end
