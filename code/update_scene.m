function S = update_scene(S, dt)
% UPDATE_SCENE  Advance the simulation by DT seconds. Called once per frame
%   from run_project.m. Each part of the house is updated by its own file,
%   so each group member owns a separate file (no editing clashes):
%
%     update_lighting.m    clock, sun, sky, lamps          (camera & lighting)
%     update_doors.m       room doors swinging on hinges   (matrices & doors)
%     update_appliances.m  fridge, TV, cooker, night mode  (appliances)
%     update_status.m      status bar at the bottom        (coordinator)
%
%   ORDER MATTERS: update_lighting runs first because it works out the time
%   of day and S.nightNow, which update_appliances needs.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
S.time = S.time + dt;

S = update_lighting(S, dt);
S = update_doors(S, dt);
S = update_appliances(S, dt);
S = update_status(S, dt);
end
