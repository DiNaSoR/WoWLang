# Contributing Guide

Thanks for helping improve WoWLang! This short guide points you to the docs you’ll use most and gives copy‑pasteable patterns to move fast without breaking things.

## Where Things Live
- Module overview and coding conventions: see `AGENTS.md`.
- Ace3 config architecture (Core/Tabs/Orchestrator): see the “Ace3 Config Architecture” section in `AGENTS.md`.
- Third‑party libs: `common/Libs/` (Ace3, LibDataBroker, LibDBIcon, LibSharedMedia).
- Per‑locale packs: `WoWAR`, `WoWTR`, `WoWPL`, `WoWUA`, `WoWJP`, `WoWHU`.

## Quick Start
- Local run: copy one locale (e.g. `WoWAR/`) and `common/` into `Interface/AddOns`.
- In game: `/reload` to apply changes; open options via `/wowtr` or the minimap icon.
- Optional lint: `luacheck common/ WoWAR/`.

## Commit & PR Style
- Commits: concise, imperative; prefer Conventional style.
  - Examples: `feat(config): add tooltips setting`, `fix(tracker): nil frame guard`.
- PRs: describe changes, list key files, include screenshots/short clips for UI, and note any `.toc` changes.

## Adding A New Config Tab
Use the modular Ace3 config.

1) Create a file under `common/Config/Tabs/<Name>.lua`.
2) Export a function that returns an Ace options group.
3) Bind fields to `WOWTR.db.profile.<area>`; call `WOWTR.Config.SyncGlobalsFromDB()` inside setters.
4) Add the file to each locale `.toc` after `Config/Core.lua` and before `Config/Main.lua`.

Template file you can copy: `common/Config/Tabs/_Template.lua`.

Example skeleton:

```
WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.MyFeature()
  return {
    type = "group", order = 7,
    name = function() return QTR_ReverseIfAR("My Feature") end,
    get = function(info) return WOWTR.db.profile.myfeature[info[#info]] end,
    set = function(info, val)
      WOWTR.db.profile.myfeature[info[#info]] = val
      WOWTR.Config.SyncGlobalsFromDB()
    end,
    args = {
      enabled = { type = "toggle", name = QTR_ReverseIfAR("Enable"), order = 1 },
      level   = { type = "range",  name = QTR_ReverseIfAR("Level"),  min = 1, max = 10, step = 1, order = 2 },
    },
  }
end
```

## Adding New Settings (DB + Migration)
1) Define defaults: update `C.defaults.profile` in `common/Config/Core.lua`.
2) Migration: map legacy globals → new DB in `C.MigrateLegacyToDB()`.
3) Shims: mirror DB → legacy globals in `C.SyncGlobalsFromDB()` so plugins keep working.
4) UI: expose the options in a Tab file with `get`/`set` and call `SyncGlobalsFromDB()` in `set`.

## Updating TOC Files
For every locale pack `WoW*/WoW*.toc`, add new tabs after Core and before the orchestrator:

```
Config/Core.lua
Config/Tabs/<Name>.lua
Config/Main.lua
```

## Fonts (LibSharedMedia)
- Packaged fonts are registered in Core; General tab exposes a `Font` dropdown (`FontLSM`).
- If no LSM selection is made, locale `WOWTR_Fonts` fallback stays in effect.

## Minimap Icon
- Uses LDB + DBIcon and reads `WOWTR.db.profile.minimap` (no separate DB var).
- Clicking opens the Ace options dialog.

## RTL & Labels
- Wrap user‑visible strings with `QTR_ReverseIfAR(...)`.
- Prefer `WoWTR_Config_Interface` strings; avoid hardcoding language checks except when hiding/showing groups (e.g., `ChatAR`).

## Manual Testing (Config)
- `/wowtr` opens options; minimap icon opens options.
- Flip General toggles (quests, gossip, tracker, plugin toggles) and verify effects.
- Try Tooltips/UI toggles, timer, Books/Movies toggles, and About reset actions.
- Switch profiles (copy/reset) and ensure behavior stays in sync; plugins keep working.
