# Repository Guidelines

## Project Overview
WoWLang delivers localized, right-to-left-aware quest and gossip experiences for World of Warcraft retail. The addon is intentionally modular: shared logic and helpers sit in `common/`, locale packs supply translations and assets, and optional plugins integrate with Immersion, Storyline, DialogueUI, and other UI replacements. Files are loaded directly by the game—there is no compile phase—so keeping modules focused and reusable is key to supporting every locale consistently.

## Project Structure & Module Organization
Shared logic lives in `common/`, with quests split into focused modules such as `common/Quests/Utils.lua`, `Gossip.lua`, and `Details.lua`; text shaping sits in `common/Text.lua`, and RTL helpers in `common/RTL.lua`. Locale packs (`WoWAR/`, `WoWTR/`, etc.) bundle translations, fonts, and their `.toc` files; copy one locale plus `common/` into your WoW `Interface/AddOns` when testing. Config code resides in `common/Config/`, where `Core.lua` wires Ace3 and `Tabs/*.lua` define option groups. Third-party libs live under `common/Libs/`, and plugin bridges under `common/Plugins/`.

## Build, Test, and Development Commands
World of Warcraft loads the Lua files directly; there is no compile or build pipeline.
- `cp -r common WoWAR /path/to/WoW/_retail_/Interface/AddOns/` – stage the addon locally (swap `WoWAR` for your locale).
- `zip -r WoWTR.zip common WoWTR` – package the addon for release.
- `luacheck common/ WoWAR/` – optional lint; catches Lua syntax and style issues.

## Coding Style & Naming Conventions
Use Lua 5.1 compatible syntax with 2-space indentation and concise, scoped functions. Begin modules with `local addonName, ns = ...` and attach features via `ns.Quests.*` rather than globals. Favor helper APIs (`ns.Quests.Utils.CreateButton`, `ns.Text.QTR_ReverseIfAR`) over bespoke logic, and avoid hardcoded RTL checks—call `ns.RTL.IsRTL()`. Name files with PascalCase (`Tracker.lua`, `Integrations.lua`) and keep a single responsibility per file.

## Testing Guidelines
Manual in-game testing is expected: `/reload`, open `/wowtr`, toggle quests, gossip, tracker, and plugin options, and confirm RTL layouts. When touching config setters, switch Ace profiles to ensure `WOWTR.Config.SyncGlobalsFromDB()` mirrors legacy globals. For scripts, rerun `luacheck` before submitting.
