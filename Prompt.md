Make the WoW addon code modular and DRY by extracting monolithic logic into small, well‑named modules that use existing helpers and libraries. Follow these exact
constraints and deliverables.

Context

- Language: Lua (WoW 11.x API)
- Namespacing: always start files with local addonName, ns = ... and define under ns.* (no new globals)
- Existing helpers/libs:
    - common/RTL.lua: ns.RTL.IsRTL(), ns.RTL.JustifyFontString
    - common/Text.lua: QTR_ExpandUnitInfo, QTR_ReverseIfAR, WOW_ZmienKody, etc. (wrappers already exported as globals)
    - common/Quests/Utils.lua: IsRTL(), ApplyRTLText(), CreateButton()
    - Ace3, LDB, DBIcon, LSM (already packaged under common/Libs/)

Tasks

- Extract module(s) from monoliths into common/<Area>/<Name>.lua, mirroring how Quests and Books were modularized.
    - Keep implementation inside ns.<Area>.* with thin global wrappers for back‑compat, e.g., function XYZ_Global() return ns.Area.Func() end
    - Use ns.Text wrappers and ns.RTL for shaping and justification; never inline lang == 'AR'
    - Reuse ns.Quests.Utils where applicable (IsRTL, ApplyRTLText, CreateButton)
- Add a simple State module when a file defines many globals, e.g., common/<Area>/State.lua that initializes shared tables and constants (like QTR_MessOrig, QTR_quest_*)
- Put plugin-facing wrappers (Immersion, Storyline, DialogueUI) into common/<Area>/Integrations.lua and delegate to plugin modules
- Update all locale .toc files:
    - Replace old monolith file entries with the new modular files
    - Ensure load order matches: RTL → /State → /Utils → /Main (and other submodules) → /Integrations → Text
- If you see a “config orchestrator” file, relocate it to common/Config/Main.lua and update .toc references (as done for WoW_Config.lua)

Best Practices

- Minimize duplication: call helpers; don’t reimplement text/RTL logic
- Keep globals as wrappers only; implementations live under ns.*
- Preserve behavior and saved variables; do not break plugin integrations
- Guard nil frames and respect in‑game load order; never assume a frame exists
- Keep changes minimal and focused; do not rewrite unrelated code

Acceptance Criteria

- Code compiles in-game; no nil global errors from removed monoliths
- All previous entrypoints keep working through wrappers (e.g., QTR_QuestPrepare, QTR_Gossip_Show, BookTranslator_ShowTranslation, toggles, tracker hooks)
- .toc files list the new modules in correct order; the removed monoliths are no longer referenced
- RTL behavior unchanged but implemented via helpers
- SavedVariables behavior unchanged (titles/fonts/IDs still display correctly)
- A short CHANGELOG in the PR description listing:
    - Files added/removed/updated
    - TOC changes
    - Any global wrappers kept for back‑compat

Targets (example)

- If working on Books: move common/WoW_Books.lua → common/Books/Main.lua with global wrappers BookTranslator_ShowTranslation() and BT_ON_OFF(). Use ns.Text + ns.RTL;
keep BT_PM/BT_SAVED behavior; update all .toc to Books/Main.lua.
- If working on another area (e.g., Bubbles/Tooltips), apply the same pattern: split into State.lua (if needed), Main.lua, optional Utils.lua and Integrations.lua,
update wrappers and .toc.

Notes

- Do not change translation data files under WoW*/Translations/
- Do not add new dependencies
- Keep code style consistent: 2 spaces indent, PascalCase module filenames, small focused functions

Deliverables

- New modular files under common/<Area>/
- Updated .toc files for all locales
- Removal of monolithic file(s) replaced by modules
- Short summary of changes and manual test steps (what was opened/toggled to validate)