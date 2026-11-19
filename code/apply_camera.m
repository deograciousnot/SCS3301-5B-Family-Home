function S = apply_camera(S)
% APPLY_CAMERA  Set the current camera position and projection (R4).
%
% Author(s): <MEMBER NAME>   |   SCS3301 Group XX, Project 5B
c = S.cams(S.camIndex);
campos(S.ax, c.pos);
camtarget(S.ax, c.target);
camup(S.ax, c.up);
camva(S.ax, c.va);
if S.perspective
    camproj(S.ax, 'perspective');
else
    camproj(S.ax, 'orthographic');
end
end
