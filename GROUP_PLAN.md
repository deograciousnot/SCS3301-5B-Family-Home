# SCS3301 Group Project – 5B Family Home: Welcome & Onboarding

**What we're building:** an interactive 3D house in MATLAB with 3 rooms, furniture, a fridge, a TV and a sufuria on a cooker. Doors and the fridge swing open on their hinges, the TV screen changes when it's switched on, and the lighting follows the time of day (sunlight through a window plus lamps).

**Challenge mode:** **night mode**. At night the lamps switch on automatically, the TV dims and switches itself off at 23:00, and the fridge warns you if its door stays open for more than 10 seconds.

**Code repo:** https://github.com/deograciousnot/SCS3301-5B-Family-Home

**Why it matters:** the lecturer marks the code **as it runs**, and **any of us** can be asked to explain or change part of it live during the presentation. So the goal of this guide is for every member to be able to run the project and understand it.

---

## 1. Getting started (do this first)

Work through these steps in order. Each one should take a few minutes.

**Step 1: Create your accounts**
- **GitHub:** sign up free at https://github.com and send your **username** to the group coordinator so they can add you as a collaborator. Accept the email invite when it arrives.
- **MathWorks (MATLAB):** sign up at https://www.mathworks.com with your **university email**. If the university has a MATLAB licence, your account links to it automatically. If not, MATLAB Online still gives you 20 free hours a month.

**Step 2: Open MATLAB Online**
- Go to https://matlab.mathworks.com and sign in. MATLAB opens in your browser; nothing to install.

**Step 3: Get the code**
- In the **Command Window** (bottom of the screen), type:
```
gitclone("https://github.com/deograciousnot/SCS3301-5B-Family-Home.git")
cd SCS3301-5B-Family-Home/code
```
- No login is needed for this step.

**Step 4: Run it**
```
test_matrices
run_project
```
- `test_matrices` checks our matrix maths. Every line should say `ok`.
- `run_project` opens the 3D house. **Click once inside the 3D picture** so it receives your key presses.

**Step 5: Try the controls**

| Key | What it does |
|---|---|
| `1` / `2` | Open or close door 1 / door 2 |
| `F` | Open or close the fridge |
| `T` | TV on/off |
| `K` | Cooker on/off (the sufuria lid rattles) |
| `L` | Lamps on/off |
| `N` | Night mode (challenge mode) on/off |
| `J` | Jump the clock to 22:45, a quick way to see night mode |
| `C` | Next camera view |
| `P` | Perspective / orthographic projection |
| `+` / `-` or slider | Make time pass faster / slower |
| `Q` | Quit |

**Try night mode:** press `T`, then `J`, then `F`, and wait about 10 seconds. The TV switches itself off at 23:00 and "DOOR OPEN!" starts flashing above the fridge.

**Step 6: Pick a role** (see section 3) and read your files.

**Step 7: Make your first small change** (see section 4), then commit and push it (see section 5).

If anything goes wrong, copy the full red error message and post it in the group chat.

---

## 2. How the code works

### The big picture

```
run_project.m
 |- init_state()            make the "memory" S (time, door angles, TV on/off...)
 |- create_figure()         make the window, help text and slider
 |- build_scene()           draw every object ONCE and remember them in S
 |- setup_camera_lighting() add the sun and the camera positions
 |- LOOP, many times a second:
       S = update_scene(S, dt)   work out what changed and move objects
       drawnow                   show the new frame (key presses run here)
```

It works like a cartoon: draw everything once, then many times a second move things a little and redraw.

### The main ideas

- **`S`, the program's memory.** One variable that holds every setting (`S.hour`, `S.tvOn`, `S.doors(1).angle`) and a "remote control" (handle) for every drawn object, such as `S.h.tvScreen`. `guidata` stores S in the window so the key-press code and the main loop share it.
- **Building objects.** Everything is made from boxes (`draw_box`, using `patch`), cylinders (`draw_cylinder`) and spheres. A sofa is just four boxes.
- **Our own matrices (R2).** `mat_translate`, `mat_scale`, `mat_rotx`, `mat_roty`, `mat_rotz` each return a 4×4 matrix. Every point is written as `[x y z 1]`, so one matrix can both move and rotate. `apply_matrix` multiplies a list of points by a matrix; the sufuria lid rattles this way.
- **Rotating about a hinge.** `mat_rotz` rotates around the origin, but a door must swing around its hinge. `mat_about_pivot` does: slide the hinge to the origin → rotate → slide back. In maths: `T = translate(+hinge) * rotate(θ) * translate(−hinge)`.
- **Hierarchy (R3).** `hgtransform` is an invisible container with a matrix. Anything inside it moves with it: house → door → handle. We only rotate the door; the handle follows because it's the door's child.
- **Key presses.** `on_key_press.m` only *changes values* in S (e.g. "fridge target = 100° open"). It doesn't animate anything.
- **Every frame.** `update_scene.m` reads S and animates: moves the clock and sun, switches lamps, swings doors smoothly towards their target angle, updates the TV and cooker, runs the night-mode rules and writes the status bar.
- **Camera (R4).** `S.cams` holds 4 views. `apply_camera.m` sets the position, target, zoom and projection.

### Where things live

| If you want to change… | Look in… |
|---|---|
| Furniture, walls, floors | `build_furniture.m`, `build_rooms.m` |
| Fridge, TV, cooker shapes | `build_fridge.m`, `build_tv.m`, `build_cooker.m` |
| How things move or behave over time | `update_scene.m` |
| What a key does | `on_key_press.m` |
| Starting values (start time, timers) | `init_state.m` |
| Camera positions | `setup_camera_lighting.m` |
| The matrix maths | `mat_*.m`, `apply_matrix.m`, `mat_about_pivot.m` |

---

## 3. Roles

Pick one role. Each role owns certain files, so we don't edit the same files at the same time.

| # | Role | Files they own | Also responsible for |
|---|---|---|---|
| 1 | **Lead and integration** | `run_project.m`, `init_state.m`, `update_scene.m` | Merging everyone's work, submissions |
| 2 | **Matrices and hierarchy** (R2, R3) | `mat_*.m`, `apply_matrix.m`, `test_matrices.m`, `build_doors.m` | Report section on 4×4 matrices and the hierarchy diagram |
| 3 | **House and furniture modelling** (R1) | `build_rooms.m`, `build_furniture.m`, `draw_box.m`, `draw_cylinder.m` | Making the scene look good |
| 4 | **Appliances** | `build_fridge.m`, `build_tv.m`, `build_cooker.m` | Appliance behaviour at night |
| 5 | **Camera, lighting, day/night** (R4, R5) | `setup_camera_lighting.m`, `apply_camera.m`, `build_lamps.m` | Sun logic in `update_scene.m` |
| 6 | **Interaction and challenge mode** (R7) | `create_figure.m`, `on_key_press.m` | Night-mode logic, on-screen controls |
| 7 | **Documentation and media** (R6) | `README.txt` | Video, report, slides, contribution table |

**Everyone** writes part of the report and speaks at the presentation.

**Rules for working together:**
- Only edit the files you own. If you need to change someone else's file, tell them first.
- Put your name in the `Author(s):` line at the top of each file you work on (required by R8).
- Understand your own files **and** the main loop (`run_project.m` + `update_scene.m`).

---

## 4. Your first change (practice)

Try one of these to get comfortable. Change it, run `run_project`, and see what happens:

- In `init_state.m`, change `S.hour = 7.0` to `20`. The program now starts at night.
- In `on_key_press.m`, change the `toggle(..., 90)` for door 1 to `45`. The door only half-opens.
- In `build_furniture.m`, change the sofa colour `[0.45 0.15 0.15]` to `[0 0 1]`. The sofa turns blue.

Undo practice changes before you commit, unless the group agrees to keep them. This is exactly the kind of thing the lecturer may ask you to do live.

---

## 5. How we use Git (GitHub)

The repo is **public**: anyone can clone or download it without logging in. **To push changes** you must be a collaborator (send your GitHub username to the coordinator, then accept the invite).

**Golden rules**
1. **Only edit the files you own** (see section 3). The shared files (`run_project.m`, `init_state.m`, `update_scene.m`) are changed by the lead, or on a branch the lead reviews.
2. **Pull before you start, every time.**
3. **Run `run_project` before you push.** If it doesn't run, don't push.
4. Write clear commit messages, e.g. `Add rug and chairs to living room`, not `update`.
5. Videos and backups are **not** stored in Git; share them on Google Drive. Write the report and slides together in Google Docs/Slides or OneDrive, and commit only the final versions.
6. Commit under your own name. Because the repo is public, the history is our proof of who wrote what.

**First-time setup in MATLAB Online:** set your Git name and email under **Home → Preferences (or Settings) → MATLAB → Source Control → Git**.

**Committing in MATLAB Online (point and click)**
1. Right-click in the Files panel → **Source Control → Pull**.
2. Edit your files and run `run_project`.
3. Right-click → **Source Control → Commit**, and write a message.
4. Right-click → **Source Control → Push**. Use your GitHub username, and a **token** as the password (see below).

**Committing in MATLAB Online (commands, R2023b or newer)**
```
repo = gitrepo;
pull(repo)
add(repo, "code/build_furniture.m")
commit(repo, Message="Add chairs to kitchen")
push(repo)
```

**Getting a token (needed to push):** go to **https://github.com/settings/tokens** → *Generate new token (classic)* → tick **repo** → *Generate*, then copy it straight away (GitHub shows it only once). This is in your **account** settings (profile picture, top right → Settings → *Developer settings* at the bottom of the left menu), not the repo's Settings tab.

**Desktop (Git installed)**
```
# first time only
git clone https://github.com/deograciousnot/SCS3301-5B-Family-Home.git

# every time you start working
git pull

# ... edit your files, run run_project in MATLAB, then:
git add code/build_furniture.m
git commit -m "Add rug and chairs to living room"
git pull
git push
```

**Common problems**
- **Push rejected:** someone pushed before you. Pull, run `run_project` again, then push.
- **Password fails:** use your token, not your GitHub password, and make sure you accepted the collaborator invite.
- **Merge conflict:** don't panic and don't delete anything. Post in the group chat and the file's owner will sort it out.
- **Git too painful?** Send your changed `.m` files to a teammate to commit. Keep your name in the file header so your work still counts.

---

## 6. Requirements checklist

What the brief requires, and where we are.

| Req | What the brief wants | Where it is now | Status |
|---|---|---|---|
| R1 | ≥ 5 objects from primitives | Rooms, sofa, tables, bed, wardrobe, fridge, TV, cooker, sufuria, lamps | ✅ done |
| R2 | Own 4×4 matrices; move an object by multiplying its **vertices** | `mat_*.m`; sufuria lid in `update_scene.m` §6 | ✅ done |
| R3 | 3-level hierarchy + rotation about a pivot that isn't the origin | house → door → handle; house → fridge → door → handle | ✅ done |
| R4 | Perspective + orthographic; ≥ 2 camera positions; switch with a key | `C` and `P` keys, 4 cameras | ✅ done |
| R5 | Light, Gouraud shading, suitable materials | Sun + 3 lamps, Gouraud shading, `material` | ✅ done (improve colours) |
| R6 | ≥ 60 s animation with event-driven changes, plus an exported video | Day/night cycle, `RECORD_VIDEO` flag | ⚠️ add timed events, record the video |
| R7 | ≥ 2 controls, one that changes behaviour, shown on screen | Keys + time-speed slider + help panel | ✅ done |
| R8 | `run_project.m`, functions, comments, author headers | Done | ⚠️ fill in names |
| Challenge | Night mode: lights on **and 2 appliances behave differently** | Lamps; TV dims + 23:00 sleep timer; fridge 10 s door warning | ✅ done |

### What we still have to do
1. **Timed events for R6.** For example, a daily routine where the cooker comes on at 07:00 and 19:00 and the TV at 20:00, so the 60-second video shows things happening without anyone pressing keys.
2. **Make it look better:** colours, a rug, kitchen counter, chairs, curtains, a patch of sunlight on the floor.
3. **Optional extensions** (pick 1–2 at most; quality matters more than quantity):
   - Ceiling fan: ceiling → hub → blades (another nice hierarchy)
   - Textures (wood floor, picture on the TV)
   - A camera tour of the house
4. **Fill in names** in every file header and in `README.txt`.

---

## 7. Folder layout

```
SCS3301-5B-Family-Home/
|- GROUP_PLAN.md / .docx   <- this guide
|- code/                   <- THE MATLAB PROJECT (zip this folder to submit)
|   |- run_project.m       <- run this
|   |- README.txt          <- controls + how to run
|   |- *.m                 <- one function per file
|- docs/                   <- proposal, report, slides
|- media/                  <- screenshots, video (video not in Git)
```

---

## 8. Academic integrity
- The starter code was generated with AI help. That's allowed, **but it must be acknowledged** (already noted in `README.txt`; also mention it in the report).
- Every member must understand the code. Anyone can be asked to change a transformation, camera position, callback or algorithm live.
- If you use any other online example, note it in `README.txt`.
