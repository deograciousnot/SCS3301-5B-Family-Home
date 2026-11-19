function a = step_toward(a, target, maxStep)
% STEP_TOWARD  Move value A towards TARGET by at most MAXSTEP.
%   Used for smooth door / fridge animation instead of jumping.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
d = target - a;
a = a + sign(d) * min(abs(d), maxStep);
end
