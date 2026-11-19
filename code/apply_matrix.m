function Vout = apply_matrix(V, T)
% APPLY_MATRIX  Multiply an N-by-3 list of vertices by a 4x4 matrix (R2).
%   Each row [x y z] becomes [x y z 1] (homogeneous), is multiplied by T,
%   and the result is turned back into [x y z].
%
%   Example: lid vertices moved with our own matrices in update_scene.m
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
n  = size(V, 1);
Vh = [V, ones(n, 1)]';     % 4-by-N, one column per vertex
Vh = T * Vh;               % transform every vertex at once
Vout = Vh(1:3, :)';        % back to N-by-3
end
