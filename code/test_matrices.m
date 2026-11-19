% TEST_MATRICES  Quick self-check of our own matrix functions (R2).
%   Run this on its own. Every line should print "ok".
%   Good to show in the report / presentation as evidence the maths works.
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
p = [1 0 0];
check('translate (1,0,0) by (2,3,4)', apply_matrix(p, mat_translate(2,3,4)), [3 3 4]);
check('scale by 2',                    apply_matrix(p, mat_scale(2)),          [2 0 0]);
check('rotz 90: x-axis -> y-axis',     apply_matrix(p, mat_rotz(90)),          [0 1 0]);
check('roty 90: z-axis -> x-axis',     apply_matrix([0 0 1], mat_roty(90)),    [1 0 0]);
check('rotx 90: y-axis -> z-axis',     apply_matrix([0 1 0], mat_rotx(90)),    [0 0 1]);
% Door hinge at (5,1,0): a point 1 m along +y from the hinge, rotated 90 deg,
% should end up 1 m along -x from the hinge.
check('rotate about pivot (door hinge)', ...
      apply_matrix([5 2 0], mat_about_pivot(mat_rotz(90), [5 1 0])), [4 1 0]);
check('pivot point itself does not move', ...
      apply_matrix([5 1 0], mat_about_pivot(mat_rotz(37), [5 1 0])), [5 1 0]);

function check(name, got, expected)
if norm(got - expected) < 1e-9
    fprintf('%-36s ok\n', name);
else
    fprintf('%-36s FAILED  got [%g %g %g]\n', name, got);
end
end
