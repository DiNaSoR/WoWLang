# Repository Guidelines

## Project Structure & Module Organization
- core: `common/` shared Lua modules for all locales.
- quests: `common/Quests/` split by concern:
  - `State.lua` shared state/tables (`QTR_quest_*`, `QTR_MessOrig`, etc.).
  - `Utils.lua` helpers (`IsRTL`, `ApplyRTLText`, `CreateButton`, etc.).
  - `Gossip.lua` gossip flows and toggles.
  - `Main.lua` entrypoints and button wiring.
  - `Tracker.lua` tracker headers/list entries.
  - `UI.lua` small UI helpers.
  - `Details.lua` quest prepare/translate and constants.
  - `Integrations.lua` wrappers for Immersion/Storyline/DialogueUI/ClassicQuestLog.
- text: `common/Text.lua` centralized text shaping and WoW code handling; exposes wrappers for legacy `QTR_*` functions.
- rtl: `common/RTL.lua` centralized right‑to‑left helpers.
- libs: `common/Libs/` third‑party libraries (Ace3, LibDataBroker, etc.).
- locale packs: `WoWAR`, `WoWTR`, `WoWPL`, `WoWUA`, `WoWJP`, `WoWHU` (each has `.toc`, translations, fonts, images).
- plugins: `common/Plugins/` integrations (Immersion, Storyline, DialogueUI).
- rules: `.cursor/rules/` contributor and architecture guidance.

## Build, Test, and Development Commands
- Local run: copy a locale folder (e.g., `WoWAR/`) plus `common/` into your WoW `Interface/AddOns`.
- Package: zip the selected locale folder(s) with `common/` for distribution.
- Optional lint (if installed): `luacheck common/ WoWAR/` to catch Lua issues.

## Coding Style & Naming Conventions
- Language: Lua (WoW 11.x API).
- Indentation: 2 spaces; keep lines focused and readable.
- Namespacing: use `local addonName, ns = ...` and define modules under `ns.Quests.*` (avoid new globals).
- File names: PascalCase modules (e.g., `Details.lua`), one responsibility per file.
- RTL: never inline `lang == 'AR'`; use `ns.RTL.*` helpers.

## Testing Guidelines
- Manual in‑game verification: gossip toggles, quest texts, tracker titles, RTL alignment.
- Scope small: validate only the module you touched; watch for nil frames and load order issues.
- Optional: use `/reload` and toggle features to exercise code paths.

## Commit & Pull Request Guidelines
- Commits: concise, imperative subject; prefer Conventional style, e.g., `feat(quests): add DUI toggle`, `fix(rtl): correct icon layout`.
- PRs: include description of changes, affected files, screenshots (UI) or short clips, and note any `.toc` load‑order updates.
- Backward compatibility: keep global wrappers when changing module APIs; avoid breaking plugin integrations.

## Architecture Overview
- Load order (per‑locale `.toc`): RTL → Quests/State → Quests/Utils → Quests/Gossip → Quests/Main → Quests/Tracker → Quests/UI → Quests/Details → Quests/Integrations → Text.
- Wrappers: global functions are thin shims delegating to `ns.Quests.*`/`ns.Text.*` methods (e.g., `QTR_QuestPrepare`, `QTR_Translate_On/Off`, `QTR_display_constants`, `QTR_Gossip_Show`).
- Translations and assets live per‑locale; logic remains in `common/`.
- Monolith `WoW_Quests.lua` is removed; do not reintroduce monolithic logic.

## Quests Module Guidelines
- Prefer `ns.Quests.Utils.*` over custom code:
  - `IsRTL()` for direction checks (never inline `lang == 'AR'`).
  - `ApplyRTLText()` for shaping+justification.
  - `CreateButton()` for consistent buttons.
- Use `ns.Text` wrappers (`QTR_ExpandUnitInfo`, `QTR_ReverseIfAR`, etc.) for any text processing; do not duplicate WoW code handling.
- Plugin-facing wrappers belong in `Quests/Integrations.lua` (e.g., `isImmersion`, `IsDUIQuestFrame`).
- Keep global wrappers for backward compatibility; implementations stay in modules under `ns.Quests.*`.

## Ace3 Config Architecture

The manual Blizzard frames have been replaced with a modular Ace3 configuration.

- Layout
  - Core: `common/Config/Core.lua` initializes AceDB, migrates legacy SVs, registers options with AceConfig, and exposes `WOWTR.Config.Init()` and `WOWTR.Config.Open()`.
  - Tabs: `common/Config/Tabs/*.lua` export option groups by setting `WOWTR.Config.Groups.<Name>()` and returning an Ace options table.
  - Orchestrator: `common/Config/Main.lua` is a thin wrapper that calls `WOWTR.Config.Init()` on enable and `WOWTR.Config.Open()` for the `/wowtr` slash.

- Load order (per-locale `.toc`)
  1. Ace libs (LibStub, AceAddon, AceConsole, AceDB, AceGUI, AceConfig, AceDBOptions, LibDataBroker, LibDBIcon, LibSharedMedia)
  2. `WoW_Core.lua`, then `common/Config/Helpers.lua`
  3. `common/Config/Core.lua`
  4. Tabs: `common/Config/Tabs/*.lua`
  5. `common/Config/Main.lua` (orchestrator)
  6. `common/Config/Minimap.lua`

- SavedVariables
  - New: `WOWTR_DB` (AceDB profile store).
  - Legacy maintained: `QTR_PS`, `TT_PS`, `ST_PM`, `BB_PM`, `MF_PM`, `BT_PM`, `CH_PM` via shims.
  - Migration: `MigrateLegacyToDB()` imports legacy tables once; `SyncGlobalsFromDB()` mirrors profile → legacy on every change/profile switch.

- Profiles
  - Profile UI is injected via `AceDBOptions-3.0` and appears as a “Profiles” panel in the options.
  - Ensure new options read/write `WOWTR.db.profile.<area>` and call `WOWTR.Config.SyncGlobalsFromDB()` in setters.

- Fonts (LibSharedMedia)
  - Packaged fonts are registered in Core via LSM; the General tab provides a `Font` dropdown (`FontLSM`).
  - If no LSM selection is made, fallback to locale fonts (`WOWTR_Fonts`, `FontFile`).

- Minimap
  - Uses `LibDataBroker-1.1` + `LibDBIcon-1.0`, bound to `WOWTR.db.profile.minimap` (no separate DB).
  - Clicking the icon opens the Ace options dialog.

- RTL and Labels
  - Wrap all user-visible strings in `QTR_ReverseIfAR(...)`.
  - Prefer using `WoWTR_Config_Interface` keys for names/descriptions; avoid hardcoding locale checks in the UI except for visibility (`ChatAR` group is hidden when not AR).

## Adding A New Config Tab

1. Create `common/Config/Tabs/<Name>.lua`.
2. Define a function `WOWTR.Config.Groups.<Name>()` returning an Ace options group table: `{ type = "group", name = ..., order = ..., args = { ... } }`.
3. Use `get`/`set` to bind to `WOWTR.db.profile.<area>`; call `WOWTR.Config.SyncGlobalsFromDB()` in `set`.
4. Add the file to each locale `.toc` after `Config/Core.lua` and before `Config/Main.lua`.
5. If you introduce new profile fields, extend `C.defaults.profile` and update both `MigrateLegacyToDB()` and `SyncGlobalsFromDB()` in `Config/Core.lua`.
6. Do not create frames directly; all UI should be expressed as Ace options.

Example snippet:

```lua
function WOWTR.Config.Groups.MyFeature()
  return {
    type = "group", order = 7,
    name = function() return QTR_ReverseIfAR("My Feature") end,
    get = function(info) return WOWTR.db.profile.myfeature[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.myfeature[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      enabled = { type = "toggle", name = QTR_ReverseIfAR("Enable"), order = 1 },
      level = { type = "range", name = QTR_ReverseIfAR("Level"), min = 1, max = 10, step = 1, order = 2 },
    },
  }
end
```

## Config Best Practices

- Keep options tables declarative; avoid complex logic in UI definitions.
- Prefer concise, localizable names; wrap with `QTR_ReverseIfAR`.
- Any setting that needs a reload should use an execute button with a confirmation, calling `WOWTR_ReloadUI()`.
- When touching SavedVariables, keep backward compatibility: do not remove legacy globals without a deprecation window.
- Do not call Blizzard Settings APIs directly; `AceConfigDialog` handles registration and opening.
- The `/wowtr` slash opens the Ace dialog; minimap icon also opens it.

## Manual Testing Checklist (Config)

- Options open via `/wowtr` and the minimap icon.
- General toggles: quests, gossip, tracker, plugin toggles behave as expected.
- Tooltips/UI toggles and timer apply.
- Bubbles: chat toggles, custom font size, dungeon setting.
- Movies/Books: toggles apply; About/Reset actions work (logs reset; full reset reloads UI).
- Profiles: switching/copying/resets keep legacy globals in sync without breaking plugins.
