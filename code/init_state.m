function S = init_state()
% INIT_STATE  All the variables the simulation needs, in one struct S.
%   Objects (doors, fridge, ...) add their own fields when they are built.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
S.quit           = false;
S.time           = 0;       % seconds since start
S.hour           = 7.0;     % time of day, 0..24
S.hoursPerSecond = 0.25;    % 0.25 -> one full day every 96 s
S.lampsOn        = false;   % lamps switched on by hand (key L)
S.nightMode      = true;    % CHALLENGE MODE: automatic night behaviour (key N)
S.isNight        = false;
S.tvOn           = false;
S.cookerOn       = false;
S.tvSleepHour    = 23;      % CHALLENGE: TV switches itself off at 23:00 at night
S.fridgeAlarmSec = 10;      % CHALLENGE: warn if fridge open > 10 s at night
S.message        = '';      % short event message shown in the status bar
S.messageTimer   = 0;       % seconds the message stays visible
S.camIndex       = 1;
S.perspective    = true;
end
