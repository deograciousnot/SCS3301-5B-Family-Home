function S = build_doors(S)
% BUILD_DOORS  Two interior doors, each a 3-level hierarchy (R3):
%       house (hgtransform)  ->  door (hgtransform)  ->  handle (hgtransform)
%   Moving the door's transform also moves its handle (genuine parent-child).
%   The door rotates about its HINGE, which is not the origin (R3).
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
hinges = [5 1 0;      % door 1: living room <-> kitchen
          9 1 0];     % door 2: kitchen     <-> bedroom
for i = 1:size(hinges, 1)
    x = hinges(i, 1);
    doorT   = hgtransform('Parent', S.h.house);   % level 2
    draw_box(doorT, [0.04 0.95 2.05], [x-0.02 1.0 0], [0.55 0.35 0.20]);

    handleT = hgtransform('Parent', doorT);       % level 3
    draw_box(handleT, [0.18 0.03 0.03], [x-0.09 1.8 1.0], [0.85 0.75 0.30]);

    S.doors(i).T      = doorT;
    S.doors(i).handle = handleT;
    S.doors(i).hinge  = hinges(i, :);
    S.doors(i).angle  = 0;      % current angle (degrees)
    S.doors(i).target = 0;      % angle we are animating towards
end
end
