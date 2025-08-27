# Repository Guidelines

## Project Structure & Module Organization
- core: `common/` shared Lua modules for all locales.
- quests: `common/Quests/` split by concern: `Utils.lua`, `Gossip.lua`, `Main.lua`, `Tracker.lua`, `UI.lua`, `Details.lua`.
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
- Modules load in this order: RTL → Quests/Utils → Gossip → Main → Tracker → UI → Details.
- Wrappers: global functions are thin shims delegating to `ns.Quests.*` methods.
- Translations and assets live per‑locale; logic remains in `common/`.
