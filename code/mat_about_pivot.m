function T = mat_about_pivot(R, pivot)
% MAT_ABOUT_PIVOT  Apply transform R about a pivot point instead of the origin.
%   T = mat_about_pivot(mat_rotz(45), [5 1 0]) rotates 45 degrees about a
%   vertical axis through (5,1,0) - e.g. a door on its hinge (R3).
%
%   Idea: move the pivot to the origin, rotate, move it back:
%         T = Translate(+p) * R * Translate(-p)
%   (read right-to-left: the right-most matrix is applied first)
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
T = mat_translate(pivot) * R * mat_translate(-pivot);
end
