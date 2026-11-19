SCS3301 Computer Graphics - Class Project
Group XX - Project 5B: Family Home
=================================================================

MEMBERS
  <Name 1> (<reg no>)   <Name 2> (<reg no>)   <Name 3> (<reg no>)
  <Name 4> (<reg no>)   <Name 5> (<reg no>)   ...

MATLAB VERSION USED
  <e.g. MATLAB R2024b on Windows 11 / MATLAB Online>
  Base MATLAB only - no toolboxes required.

HOW TO RUN
  1. Open MATLAB and set the Current Folder to this folder.
  2. Run:   run_project
  3. Click inside the figure window once so it receives key presses.
  To export the video, set RECORD_VIDEO = true at the top of
  run_project.m and run again (keep the window size fixed while recording).
  To check our matrix functions on their own, run:   test_matrices

CONTROLS (also shown on screen)
  1 / 2    open / close door 1 (living-kitchen) / door 2 (kitchen-bedroom)
  F        open / close the fridge
  T        TV on / off
  K        cooker on / off (sufuria lid starts rattling)
  L        lamps on / off
  N        night mode (challenge mode) on / off
  J        jump the clock to 22:45 (quick way to demonstrate night mode)

CHALLENGE MODE - NIGHT MODE (on by default, toggle with N)
  From 18:00 to 06:00, with night mode on:
  - all ceiling lamps switch on automatically
  - TV: screen dims to a blue-tinted night picture, and a sleep timer
    switches the TV off at 23:00
  - Fridge: interior light is dimmed, and if the door stays open for more
    than 10 s a red "DOOR OPEN!" warning flashes
  Demo: press T (TV on), J (jump to 22:45), F (open fridge), then wait.
  C        next camera position
  P        perspective / orthographic projection
  + / -    time of day passes faster / slower  (or use the slider)
  Q / Esc  quit

DATA FILES
  None. The project does not need any external or online data.

FILES
  run_project.m            main script - runs everything
  init_state.m             all simulation variables (struct S)
  create_figure.m          window, axes, on-screen controls and slider
  build_scene.m            calls every build_*.m function
  build_rooms.m            floors, walls, window
  build_doors.m            house -> door -> handle hierarchy
  build_furniture.m        sofa, tables, bed, wardrobe
  build_fridge.m           house -> fridge -> door -> handle hierarchy
  build_tv.m               TV and screen
  build_cooker.m           cooker, sufuria and lid
  build_lamps.m            ceiling lamps and their lights
  setup_camera_lighting.m  sun light and camera list
  apply_camera.m           sets camera position and projection
  on_key_press.m           keyboard controls
  update_scene.m           per-frame animation and theme logic
  step_toward.m            smooth movement helper
  mat_translate.m, mat_scale.m, mat_rotx.m, mat_roty.m, mat_rotz.m
                           our own 4x4 homogeneous matrices
  mat_about_pivot.m        rotation about a pivot (door hinge)
  apply_matrix.m           multiplies vertices by a 4x4 matrix
  draw_box.m, draw_cylinder.m   primitive builders
  test_matrices.m          self-test of the matrix functions

ACKNOWLEDGEMENTS (required by brief section 8)
  The starting folder structure and skeleton code were generated with
  the help of an AI assistant (Claude, Anthropic) and then studied,
  modified and extended by the group. <List any other online examples used.>
