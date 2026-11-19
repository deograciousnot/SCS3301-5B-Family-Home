function S = build_scene(S)
% BUILD_SCENE  Model every object in the house and keep the handles in S.h.
%
%   House layout (metres, viewed from above, front wall left open so the
%   camera can see inside - a "doll's house" cut-away):
%
%     y=6  +-----------------+-------------+-----------+
%          |  TV       window|  cooker  fridge | bed     |
%          |   LIVING ROOM   |   KITCHEN   |  BEDROOM  |
%          |  sofa           |   table     | wardrobe  |
%     y=1  |              door1         door2           |
%     y=0  +-----------------+-------------+-----------+
%          x=0              x=5           x=9        x=12
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
S.h.house = hgtransform('Parent', S.ax);   % level 1 of every hierarchy

S = build_rooms(S);       % floors, walls, window
S = build_doors(S);       % house -> door -> handle   (hierarchy, R3)
S = build_furniture(S);   % sofa, tables, bed, wardrobe
S = build_fridge(S);      % house -> fridge -> door -> handle
S = build_tv(S);
S = build_cooker(S);      % cooker + sufuria + lid moved by our matrices (R2)
S = build_lamps(S);       % ceiling lamps + their light sources
end
