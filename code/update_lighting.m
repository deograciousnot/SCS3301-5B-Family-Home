function S = update_lighting(S, dt)
% UPDATE_LIGHTING  Clock, sun, sky colour and lamps (theme logic, R5).
%   Also works out S.isNight and S.nightNow (is night-mode behaviour active?)
%   which the appliances use.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B

%% 1. Time of day -> sun position and colour
S.prevHour = S.hour;                        % remembered for the TV sleep timer
S.hour     = mod(S.hour + S.hoursPerSecond * dt, 24);
S.isNight  = S.hour < 6 || S.hour >= 18;
S.nightNow = S.nightMode && S.isNight;      % CHALLENGE behaviour active?

if ~S.isNight
    a = (S.hour - 6) / 12 * pi;             % 0 at sunrise, pi at sunset
    k = sin(a);                             % 0 at horizon, 1 at noon
    % Sun shines in through the back (window) wall, moving east -> west
    set(S.h.sun, 'Position', [cos(a) 1 0.2 + k], ...
                 'Color', [1, 0.55 + 0.45*k, 0.35 + 0.6*k]);   % orange -> white
    sky = [0.35 0.55 0.85] * (0.4 + 0.6*k);
else
    set(S.h.sun, 'Position', [0 1 1], 'Color', [0.15 0.18 0.35]); % moonlight
    sky = [0.02 0.02 0.08];
end
set(S.h.window, 'FaceColor', min(sky + 0.15, 1));
set(S.fig, 'Color', sky * 0.5);

%% 2. Lamps: by hand (L) or automatically at night (challenge mode)
lampsOn = S.lampsOn || S.nightNow;
for i = 1:numel(S.h.lamps)
    set(S.h.lamps(i), 'Visible', onoff(lampsOn));
    if lampsOn
        set(S.h.bulbs(i), 'FaceColor', [1 0.95 0.7]);
    else
        set(S.h.bulbs(i), 'FaceColor', [0.5 0.5 0.5]);
    end
end
end
