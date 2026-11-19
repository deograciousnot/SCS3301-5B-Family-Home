function on_key_press(src, evt)
% ON_KEY_PRESS  Keyboard controls (R7). Only CHANGES THE STATE in S;
%   update_scene.m does the actual animating on the next frame.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
S = guidata(src);
switch lower(evt.Key)
    case '1',  S.doors(1).target = toggle(S.doors(1).target, 90);
    case '2',  S.doors(2).target = toggle(S.doors(2).target, 90);
    case 'f',  S.fridge.target   = toggle(S.fridge.target, 100);
    case 't',  S.tvOn      = ~S.tvOn;
    case 'k',  S.cookerOn  = ~S.cookerOn;
    case 'l',  S.lampsOn   = ~S.lampsOn;
    case 'n',  S.nightMode = ~S.nightMode;
    case 'j',  S.hour = 22.75;     % jump to 22:45 - handy for demoing night mode
    case 'c'
        S.camIndex = mod(S.camIndex, numel(S.cams)) + 1;
        S = apply_camera(S);
    case 'p'
        S.perspective = ~S.perspective;
        S = apply_camera(S);
    case {'equal', 'add'}            % '+' key (main keyboard / numpad)
        S.hoursPerSecond = min(S.hoursPerSecond + 0.25, 2);
        set(S.h.speedSlider, 'Value', S.hoursPerSecond);
    case {'hyphen', 'subtract'}      % '-' key
        S.hoursPerSecond = max(S.hoursPerSecond - 0.25, 0);
        set(S.h.speedSlider, 'Value', S.hoursPerSecond);
    case {'q', 'escape'}
        S.quit = true;
end
guidata(src, S);
end

function t = toggle(current, openAngle)
% Closed -> open, anything else -> closed.
if current == 0, t = openAngle; else, t = 0; end
end
