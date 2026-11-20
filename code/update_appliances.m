function S = update_appliances(S, dt)
% UPDATE_APPLIANCES  Fridge, TV and cooker, including the night-mode
%   (challenge mode) behaviour of the fridge and TV.
%   Needs S.nightNow and S.prevHour from update_lighting.m.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
t = S.time;
speed = 120 * dt;                           % door speed, degrees per second

%% 1. Fridge door swings about its hinge (R3)
S.fridge.angle = step_toward(S.fridge.angle, S.fridge.target, speed);
set(S.fridge.door, 'Matrix', mat_about_pivot(mat_rotz(S.fridge.angle), S.fridge.hinge));
doorOpen = S.fridge.angle > 5;
set(S.fridge.glow, 'Visible', onoff(doorOpen));

% CHALLENGE (appliance 1 - fridge): at night the interior light is dimmed,
% and if the door stays open longer than S.fridgeAlarmSec a warning flashes.
if doorOpen
    S.fridge.openTime = S.fridge.openTime + dt;
else
    S.fridge.openTime = 0;
end
S.fridge.alarm = S.nightNow && S.fridge.openTime > S.fridgeAlarmSec;
if S.fridge.alarm
    blinkOn = mod(t, 0.6) < 0.3;            % flash about 1.7 times per second
    if blinkOn
        set(S.fridge.glow, 'FaceColor', [1 0.3 0.25]);   % red flash
    else
        set(S.fridge.glow, 'FaceColor', [0.55 0.55 0.45]);
    end
    set(S.fridge.warn, 'Visible', onoff(blinkOn));
    S = show_message(S, sprintf('WARNING: fridge open for %.0f s', S.fridge.openTime));
elseif S.nightNow
    set(S.fridge.glow, 'FaceColor', [0.55 0.55 0.45]);   % dimmed night light
    set(S.fridge.warn, 'Visible', 'off');
else
    set(S.fridge.glow, 'FaceColor', [1 1 0.85]);         % normal bright light
    set(S.fridge.warn, 'Visible', 'off');
end

%% 2. TV: screen colour changes while it is on
% CHALLENGE (appliance 2 - TV): sleep timer switches it off at 23:00 at night
if S.nightMode && S.tvOn && S.prevHour < S.tvSleepHour && S.hour >= S.tvSleepHour
    S.tvOn = false;
    S = show_message(S, 'TV sleep timer: TV switched off at 23:00');
end
if S.tvOn
    c = 0.5 + 0.4 * [sin(2*t), sin(2*t + 2), sin(2*t + 4)];   % "programme"
    if S.nightNow
        c = 0.35 * c .* [0.7 0.8 1.0];      % CHALLENGE: dim, blue-tinted night screen
    end
    set(S.h.tvScreen, 'FaceColor', c);
else
    set(S.h.tvScreen, 'FaceColor', [0.02 0.02 0.02]);
end

%% 3. Cooker: burner glows, lid rattles - lid VERTICES x OUR matrices (R2)
if S.cookerOn
    set(S.h.burner, 'FaceColor', [0.9 0.25 0.05]);
    lift = 0.006 + 0.006 * sin(25*t);       % small hop
    tilt = 4 * sin(31*t);                   % small wobble (degrees)
    T = mat_translate(0, 0, lift) * ...
        mat_about_pivot(mat_rotx(tilt), S.lidCentre);
    set(S.h.lid, 'Vertices', apply_matrix(S.lidV0, T));
else
    set(S.h.burner, 'FaceColor', [0.15 0.15 0.15]);
    set(S.h.lid, 'Vertices', S.lidV0);
end
end
