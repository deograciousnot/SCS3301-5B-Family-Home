function S = build_furniture(S)
% BUILD_FURNITURE  Sofa, coffee table, dining table, bed and wardrobe,
%   all built from boxes and cylinders (R1).
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
P = S.h.house;

% --- Living room: sofa facing the TV --------------------------------------
sofa = [0.45 0.15 0.15];
draw_box(P, [2.0 0.8 0.45], [1.3 2.4 0],    sofa);    % seat
draw_box(P, [2.0 0.2 0.90], [1.3 2.2 0],    sofa);    % back rest
draw_box(P, [0.2 0.8 0.65], [1.1 2.4 0],    sofa);    % arm left
draw_box(P, [0.2 0.8 0.65], [3.3 2.4 0],    sofa);    % arm right

% Coffee table: top + 4 cylinder legs
draw_box(P, [1.0 0.5 0.05], [1.8 3.8 0.40], [0.40 0.25 0.12]);
for lx = [1.85 2.75], for ly = [3.85 4.25]
    draw_cylinder(P, 0.025, 0.40, [lx ly 0], [0.2 0.2 0.2], 12);
end, end

% --- Kitchen: dining table ------------------------------------------------
draw_box(P, [1.2 0.8 0.05], [6.4 1.8 0.75], [0.70 0.55 0.35]);
for lx = [6.45 7.55], for ly = [1.85 2.55]
    draw_cylinder(P, 0.03, 0.75, [lx ly 0], [0.35 0.25 0.15], 12);
end, end

% --- Bedroom: bed and wardrobe -------------------------------------------
draw_box(P, [1.8 2.0 0.40], [9.8 3.8 0],    [0.45 0.30 0.20]);   % frame
draw_box(P, [1.7 1.9 0.15], [9.85 3.85 0.40], [0.90 0.90 0.95]); % mattress
draw_box(P, [0.6 0.35 0.10], [10.0 5.35 0.55], [1 1 1]);         % pillow
draw_box(P, [0.6 0.35 0.10], [10.9 5.35 0.55], [1 1 1]);         % pillow
draw_box(P, [1.8 0.08 1.00], [9.8 5.80 0],  [0.40 0.25 0.15]);   % headboard
draw_box(P, [0.6 1.2 2.00], [11.35 0.5 0],  [0.50 0.35 0.25]);   % wardrobe
end
