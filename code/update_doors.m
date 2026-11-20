function S = update_doors(S, dt)
% UPDATE_DOORS  Swing the room doors about their hinges using OUR matrices
%   (R2, R3). Only the door's transform is set; its handle is a child, so it
%   follows automatically (genuine parent-child hierarchy).
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
speed = 120 * dt;                           % 120 degrees per second
for i = 1:numel(S.doors)
    S.doors(i).angle = step_toward(S.doors(i).angle, S.doors(i).target, speed);
    T = mat_about_pivot(mat_rotz(S.doors(i).angle), S.doors(i).hinge);
    set(S.doors(i).T, 'Matrix', T);
end
end
