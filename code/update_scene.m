function S = update_scene(S, dt)
% UPDATE_SCENE  Advance the simulation by DT seconds and update the graphics.
%   Called once per frame from run_project.m.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
S.time = S.time + dt;
t = S.time;

%% 1. Time of day -> sun position and colour (theme logic, R5)
prevHour  = S.hour;
S.hour    = mod(S.hour + S.hoursPerSecond * dt, 24);
S.isNight = S.hour < 6 || S.hour >= 18;
nightNow  = S.nightMode && S.isNight;    % is the CHALLENGE behaviour active?
if ~S.isNight
    a = (S.hour - 6) / 12 * pi;          % 0 at sunrise, pi at sunset
    k = sin(a);                          % 0 at horizon, 1 at noon
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
lampsOn = S.lampsOn || nightNow;
for i = 1:numel(S.h.lamps)
    set(S.h.lamps(i), 'Visible', onoff(lampsOn));
    if lampsOn
        set(S.h.bulbs(i), 'FaceColor', [1 0.95 0.7]);
    else
        set(S.h.bulbs(i), 'FaceColor', [0.5 0.5 0.5]);
    end
end

%% 3. Doors: rotate about the hinge with OUR matrices (R2, R3)
speed = 120 * dt;                        % 120 degrees per second
for i = 1:numel(S.doors)
    S.doors(i).angle = step_toward(S.doors(i).angle, S.doors(i).target, speed);
    T = mat_about_pivot(mat_rotz(S.doors(i).angle), S.doors(i).hinge);
    set(S.doors(i).T, 'Matrix', T);      % the handle (child) follows
end

%% 4. Fridge door
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
alarm = nightNow && S.fridge.openTime > S.fridgeAlarmSec;
if alarm
    blinkOn = mod(t, 0.6) < 0.3;                 % flash about 1.7 times per second
    if blinkOn
        set(S.fridge.glow, 'FaceColor', [1 0.3 0.25]);   % red flash
    else
        set(S.fridge.glow, 'FaceColor', [0.55 0.55 0.45]);
    end
    set(S.fridge.warn, 'Visible', onoff(blinkOn));
elseif nightNow
    set(S.fridge.glow, 'FaceColor', [0.55 0.55 0.45]);   % dimmed night light
    set(S.fridge.warn, 'Visible', 'off');
else
    set(S.fridge.glow, 'FaceColor', [1 1 0.85]);         % normal bright light
    set(S.fridge.warn, 'Visible', 'off');
end

%% 5. TV: screen colour changes while it is on
% CHALLENGE (appliance 2 - TV): sleep timer switches it off at 23:00 at night
if S.nightMode && S.tvOn && prevHour < S.tvSleepHour && S.hour >= S.tvSleepHour
    S.tvOn = false;
    S = show_message(S, 'TV sleep timer: TV switched off at 23:00');
end
if S.tvOn
    c = 0.5 + 0.4 * [sin(2*t), sin(2*t + 2), sin(2*t + 4)];   % "programme"
    if nightNow
        % CHALLENGE: dim, blue-tinted night screen (easier on the eyes)
        c = 0.35 * c .* [0.7 0.8 1.0];
    end
    set(S.h.tvScreen, 'FaceColor', c);
else
    set(S.h.tvScreen, 'FaceColor', [0.02 0.02 0.02]);
end

%% 6. Cooker: burner glows, lid rattles - lid VERTICES x OUR matrices (R2)
if S.cookerOn
    set(S.h.burner, 'FaceColor', [0.9 0.25 0.05]);
    lift = 0.006 + 0.006 * sin(25*t);                    % small hop
    tilt = 4 * sin(31*t);                                % small wobble (deg)
    T = mat_translate(0, 0, lift) * ...
        mat_about_pivot(mat_rotx(tilt), S.lidCentre);
    set(S.h.lid, 'Vertices', apply_matrix(S.lidV0, T));
else
    set(S.h.burner, 'FaceColor', [0.15 0.15 0.15]);
    set(S.h.lid, 'Vertices', S.lidV0);
end

%% 7. Status bar
hh = floor(S.hour);  mm = floor(mod(S.hour, 1) * 60);
if S.isNight, dayStr = 'NIGHT'; else, dayStr = 'DAY'; end
if alarm
    S = show_message(S, sprintf('WARNING: fridge open for %.0f s', S.fridge.openTime));
end
S.messageTimer = max(S.messageTimer - dt, 0);
msg = '';
if S.messageTimer > 0, msg = ['| ' S.message]; end
set(S.h.status, 'String', sprintf( ...
    '  %02d:%02d %-5s | Night mode: %-3s | Camera: %-11s (%s) | TV: %-3s | Cooker: %-3s %s', ...
    hh, mm, dayStr, onoff(S.nightMode), S.cams(S.camIndex).name, ...
    projName(S.perspective), onoff(S.tvOn), onoff(S.cookerOn), msg));
end

function S = show_message(S, txt)
% Show TXT in the status bar for 3 seconds.
S.message = txt;
S.messageTimer = 3;
end

function s = onoff(b)
if b, s = 'on'; else, s = 'off'; end
end

function s = projName(p)
if p, s = 'persp'; else, s = 'ortho'; end
end
