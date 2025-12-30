# WoWLang / WoWAR – Project Memo

Last updated: 2025-12-29

## High signal (current state)

- QuestMapFrame translation is applied **post-layout**; Blizzard refresh APIs must not be called during toggles.
- Translation toggle state is authoritative (`QTR_curr_trans`) and must never be flipped implicitly by fallback logic.
- Arabic RTL layout and headers are applied **only when real Arabic QuestData exists**.
- Mixed Arabic headers with English quest bodies are explicitly prevented.
- Tooltip hooks and font templating are owned exclusively by `common/Tooltips/*`.
- Arabic font application is centralized in `common/UI/Fonts.lua`.
- UI translation is data-driven via `common/UI/Translate.lua`; ad-hoc per-frame logic is discouraged.
- RTL detection is centralized via `ns.RTL.IsRTL()`; raw locale checks are deprecated.
- All legacy `ST_*` globals are registered only in `common/Core/Compat.lua`.
- Hook/ticker wiring uses shared helpers from `common/Core/HookUtils.lua`.
- Config tabs use `WOWTR.Config.MakeTab()` unless custom side-effects are required.
- AceDB is the source of truth for config persistence; legacy migration runs **once only** on first install.
- RTL text shaping preserves WoW special codes (`|T` / `|A` / links / colors); multi-digit placeholder restore was fixed to prevent inline quest icons disappearing in Arabic.
- Quest title “icons” may come from `|HRepeat...|h...|h` decorations or font glyphs; in RTL we render the icon as a separate overlay FontString using `Original_Font1` (avoid leaking control-char placeholders into the shaped Arabic title).

## Load order requirements

- `WoWAR/WoWAR.toc` must load:
  - `common/Core/Compat.lua`
  - `common/Core/HookUtils.lua`
  - `common/UI/Translate.lua`
