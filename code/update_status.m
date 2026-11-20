function S = update_status(S, dt)
% UPDATE_STATUS  Write the status bar at the bottom of the window:
%   clock, day/night, modes, and any short event message.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
hh = floor(S.hour);  mm = floor(mod(S.hour, 1) * 60);
if S.isNight, dayStr = 'NIGHT'; else, dayStr = 'DAY'; end
if S.perspective, proj = 'persp'; else, proj = 'ortho'; end

S.messageTimer = max(S.messageTimer - dt, 0);
msg = '';
if S.messageTimer > 0, msg = ['| ' S.message]; end

set(S.h.status, 'String', sprintf( ...
    '  %02d:%02d %-5s | Night mode: %-3s | Camera: %-11s (%s) | TV: %-3s | Cooker: %-3s %s', ...
    hh, mm, dayStr, onoff(S.nightMode), S.cams(S.camIndex).name, ...
    proj, onoff(S.tvOn), onoff(S.cookerOn), msg));
end
