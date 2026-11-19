# SCS3301 Group Project – 5B Family Home: Group Plan

**What we're building:** an interactive 3D house in MATLAB with at least 3 rooms, furniture, a fridge, a TV and a sufuria on a cooker. Doors and the fridge open on their hinges, the TV screen changes when it's switched on, and the lighting follows the time of day (sunlight through a window plus lamps).

**Challenge mode (recommended option):** **night mode**. At night the room lights come on automatically and **at least two appliances behave differently**.

**Marks:** 30 in total = MATLAB project 15 + presentation 5 + report 10. The lecturer marks the code **as it runs**, and **every member** may be asked to explain or change a small part of it live.

---

## 1. Timeline

| When | What | Who / output |
|---|---|---|
| **Tue 17 – Wed 18 Nov** | Kick-off meeting: agree on roles (section 2), everyone gets MATLAB or MATLAB Online working and runs `run_project` | All |
| Wed 18 Nov | Lecture: hierarchical modelling and `hgtransform` | All attend |
| **Thu 19 Nov, 23:59** | **M1 Proposal due**: project choice, objectives, challenge mode, team roles, Gantt chart (2–3 pages, Word) | Docs lead + all |
| Fri 20 – Wed 25 Nov | Build: modelling, matrices, hierarchy, first controls | Each member in their own files |
| Mon 23 Nov | Lecture: viewing, camera and projection | |
| Wed 25 Nov | Lecture: lighting and shading | |
| **Thu 26 Nov, 23:59** | **M2 screenshots due**: scene modelled, our own matrices moving an object, a 3-level hierarchy, one working control | Lead submits |
| **Mon 30 Nov, in class** | **M2 live demo (2 minutes)** | 1–2 presenters |
| Mon 30 Nov – Thu 3 Dec | Challenge mode (night behaviour of 2 appliances), extensions, polish | Interaction + appliance owners |
| Wed 2 Dec | Project clinic: bring code and questions | All |
| Thu 3 – Sat 5 Dec | Record the video (≥ 60 s), write the report (≤ 12 pages), make the slides (8–12) | Docs lead + all |
| **Sun 6 Dec, 23:59** | **Final submission**: zipped code folder + README.txt, video, slides, report (all named `GXX_SCS3301_Project_...`) | Lead submits |
| **Mon 7 Dec, in class** | Technical check: run the project on the presentation PC (setup fixes only, no code changes) | Lead + 1 |
| **Wed 9 Dec** | **Presentation**: 10 min + 5 min questions; everyone speaks | All |

Save a **dated backup** in `backups/` at every milestone, e.g. `backup_2026-11-26.zip`.

---

## 2. Roles (adjust for 5–7 members)

| # | Role | Files they own | Also responsible for |
|---|---|---|---|
| 1 | **Lead and integration** | `run_project.m`, `init_state.m`, `update_scene.m` | Merging everyone's work, backups, submissions |
| 2 | **Matrices and hierarchy** (R2, R3) | `mat_*.m`, `apply_matrix.m`, `test_matrices.m`, `build_doors.m` | Report section on 4×4 matrices and the hierarchy diagram |
| 3 | **House and furniture modelling** (R1) | `build_rooms.m`, `build_furniture.m`, `draw_box.m`, `draw_cylinder.m` | Making the scene look good |
| 4 | **Appliances** | `build_fridge.m`, `build_tv.m`, `build_cooker.m` | Appliance behaviour at night (challenge) |
| 5 | **Camera, lighting, day/night** (R4, R5) | `setup_camera_lighting.m`, `apply_camera.m`, `build_lamps.m` | Sun logic in `update_scene.m` |
| 6 | **Interaction and challenge mode** (R7) | `create_figure.m`, `on_key_press.m` | Night-mode logic, on-screen controls |
| 7 | **Documentation and media** (R6) | `README.txt` | Video, report, slides, Gantt chart, contribution table |

With 5 members, merge role 6 into role 4 and role 7 into role 1. **Everyone** writes part of the report and speaks at the presentation.

**Rules for working together:**
- Use one shared folder (MATLAB Drive or similar).
- Only edit the files you own. If you need to change someone else's file, tell them first.
- Put your name in the `Author(s):` header of each file you work on (required by R8).
- Each person must be able to explain their own code **and** the main loop.

---

## 3. Requirements checklist

| Req | What the brief wants | Where it is now | Status |
|---|---|---|---|
| R1 | ≥ 5 objects from primitives | Rooms, sofa, tables, bed, wardrobe, fridge, TV, cooker, sufuria, lamps | ✅ skeleton |
| R2 | Own 4×4 matrices; move an object by multiplying its **vertices** | `mat_*.m`; sufuria lid vertices × matrices in `update_scene.m` §6 | ✅ skeleton |
| R3 | 3-level hierarchy + rotation about a pivot that isn't the origin | house → door → handle; house → fridge → door → handle; hinges | ✅ skeleton |
| R4 | Perspective + orthographic; ≥ 2 camera positions; switch with a key | `C` and `P` keys, 4 cameras | ✅ skeleton |
| R5 | Light, Gouraud shading, suitable materials | Sun + 3 lamps, `FaceLighting gouraud`, `material` | ✅ skeleton (improve colours) |
| R6 | ≥ 60 s animation with event-driven changes, plus an exported video | Day/night cycle, `RECORD_VIDEO` flag | ⚠️ add scheduled events, record the video |
| R7 | ≥ 2 controls, one that changes behaviour, shown on screen | Keys + time-speed slider + help panel | ✅ skeleton |
| R8 | `run_project.m`, functions, comments, author headers | Done; **fill in names** | ⚠️ names |
| **Challenge** | Night mode: lights on **and 2 appliances behave differently** | Lamps; TV dims + 23:00 sleep timer; fridge light dims + 10 s door-open warning (`update_scene.m` §4–5) | ✅ coded, untested |

### What we still have to do
1. **Test the challenge mode in MATLAB.** Press T, then J (jump to 22:45), then F, and wait. The TV should dim and switch off at 23:00, and "DOOR OPEN!" should flash after 10 s. Optional third appliance: the cooker won't switch on after 22:00 (child lock).
2. **Events for R6.** For example, a daily routine where the cooker goes on at 07:00 and 19:00, the TV comes on at 20:00 and the lamps come on at sunset, so that the 60 s video shows things happening without anyone touching the keys.
3. **Optional extensions** (pick 1–2 at most; quality matters more than quantity):
   - Ceiling fan: ceiling → hub → blades (another nice hierarchy)
   - A character walking from room to room
   - A camera tour of the house
4. **Make it look better:** colours, a rug, kitchen counter, chairs, curtains, a patch of sunlight on the floor.
5. **Test on the presentation computer or MATLAB Online early.** Video formats differ between platforms (`.mp4` vs `.avi`).

---

## 4. Folder layout

```
5B_Family_Home/
├── GROUP_PLAN.md          ← this file
├── code/                  ← THE MATLAB PROJECT (zip this folder for submission)
│   ├── run_project.m      ← press Run here
│   ├── README.txt
│   └── *.m                ← one function per file
├── docs/
│   ├── M1_proposal/       ← GXX proposal .docx
│   ├── report/            ← GXX_SCS3301_Project_Report.docx
│   └── slides/            ← GXX_SCS3301_Project_Slides.pptx
├── media/
│   ├── screenshots/       ← M2 screenshots, report figures
│   └── video/             ← GXX_SCS3301_Project_Video.mp4
└── backups/               ← dated zips at each milestone
```

---

## 5. How we use Git (GitHub)

The code lives in a **private** GitHub repo. Keep it private so other groups can't copy it. Ask the repo owner to add you as a collaborator.

**Golden rules**
1. **Only edit the files you own** (see section 2). The shared files (`run_project.m`, `init_state.m`, `update_scene.m`) are changed by the lead, or on a branch that the lead reviews.
2. **Pull before you start, every time.**
3. **Run `run_project` before you push.** If it doesn't run, don't push.
4. Write clear commit messages, e.g. `Add rug and chairs to living room`, not `update`.
5. Videos and backups are **not** stored in Git (see `.gitignore`); share them on Google Drive. Write the report and slides together in Google Docs/Slides or OneDrive, and commit only the final versions.

**Desktop (Git installed)**
```
git clone https://github.com/<owner>/<repo>.git     (first time only)
git pull                                            (before you start)
... edit your files, run run_project in MATLAB ...
git add code/build_furniture.m
git commit -m "Add rug and chairs to living room"
git pull
git push
```

**MATLAB Online**
- First time: in the Command Window run `gitclone("https://github.com/<owner>/<repo>.git")`, or use the Files panel's source-control option. For the password, use a GitHub **personal access token** (GitHub → Settings → Developer settings → Personal access tokens).
- After that, right-click in the Files panel → **Source Control** → *Pull*, *Commit*, *Push*.
- If Git gets too painful, send your changed `.m` files to a teammate who can commit them for you. Keep your name in the file header so your work still counts.

**If you get a merge conflict:** don't panic and don't delete anything. Message the group chat, and the lead or the person who owns the file will sort it out.

---

## 6. Academic integrity
- The skeleton code was generated with AI help. That's allowed, **but it must be acknowledged** (already noted in `README.txt`; also mention it in the report).
- Every member must understand the code. Anyone can be asked to change a transformation, camera position, callback or algorithm live.
- M2 screenshots must match the final submission, so build on the same code.
