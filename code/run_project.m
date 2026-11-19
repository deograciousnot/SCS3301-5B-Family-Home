%% RUN_PROJECT  SCS3301 Computer Graphics - Group XX - Project 5B: Family Home
%  The ONE script that runs everything (requirement R8). Press F5 / Run.
%
%  Author(s): <ALL MEMBER NAMES>
%  MATLAB version tested: <e.g. R2024b / MATLAB Online>
%  AI / external code acknowledgement: see README.txt
%
%  How it works:
%    1. init_state            - all simulation variables in one struct S
%    2. create_figure         - window, axes, on-screen controls (R7)
%    3. build_scene           - models every object (R1, R3)
%    4. setup_camera_lighting - sun, cameras, projection (R4, R5)
%    5. main loop             - update_scene(S, dt) each frame, drawnow (R6)
%  Key presses (on_key_press.m) only change S; the loop does the animating.

clear; close all; clc;

RECORD_VIDEO  = false;   % true = also save the animation as a video (R6)
VIDEO_SECONDS = 70;      % brief asks for >= 60 s
VIDEO_FPS     = 25;
VIDEO_NAME    = 'GXX_SCS3301_Project_Video';

S = init_state();
[fig, S] = create_figure(S);
S = build_scene(S);
S = setup_camera_lighting(S);
guidata(fig, S);         % store S inside the figure so callbacks can reach it

if RECORD_VIDEO
    try
        vw = VideoWriter(VIDEO_NAME, 'MPEG-4');           % .mp4
    catch
        vw = VideoWriter(VIDEO_NAME, 'Motion JPEG AVI');  % fallback (.avi)
    end
    vw.FrameRate = VIDEO_FPS;
    open(vw);
    nFrames = 0;
end

clk = tic;  lastT = 0;
while ishandle(fig)
    S = guidata(fig);
    if S.quit, break; end

    if RECORD_VIDEO
        dt = 1 / VIDEO_FPS;                 % fixed step -> video plays at real speed
    else
        t  = toc(clk);
        dt = min(t - lastT, 0.1);           % real time, capped if a frame lags
        lastT = t;
    end

    S = update_scene(S, dt);
    guidata(fig, S);
    drawnow;                                % draw frame + run any key callbacks

    if RECORD_VIDEO && ishandle(fig)
        writeVideo(vw, getframe(fig));
        nFrames = nFrames + 1;
        if nFrames >= VIDEO_SECONDS * VIDEO_FPS, break; end
    end
end

if RECORD_VIDEO
    close(vw);
    fprintf('Video saved: %s\n', vw.Filename);
end
if ishandle(fig), close(fig); end
