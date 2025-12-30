# WoWLang / WoWAR – Development Journal

## 2025-12-29

- [Bubbles] Prevented double EN + AR chat bubble lines caused by enabling both Chat EN and Chat TR.
  - Startup normalization added in `common/Config/Core.lua`.
  - Mutual exclusion enforced in `common/Config/Tabs/Bubbles.lua`.

- [Quests] Stabilized QuestMapFrame translation behavior.
  - Removed `QuestMapFrame_ShowQuestDetails` call from `ToggleTranslation()` to prevent Blizzard overwrites.
  - Removed manual toggle suppression window in favor of state + post-layout reapply.
  - Fixed questID resolution to prefer modern QuestMapFrame paths with fallback.
  - Added `QuestMapDetailsScrollFrame:OnShow` hook to reapply translation for recap/info panels.

- [Quests] Corrected RTL and translation application logic.
  - `QuestPrepare()` now respects `QTR_curr_trans` instead of forcing English.
  - Added `TranslateOff(event="__keep_state__")` to avoid flipping global toggle during fallback.
  - Introduced short scheduled post-layout refresh passes to beat late Blizzard UI updates.
  - Arabic headers and RTL are applied only when real Arabic QuestData exists.
  - LTR layout and original headers are always restored when translation is missing.
  - Implemented Arabic script detection to prevent mixed-language UI.
  - Auto-downgrade to English when Arabic QuestData is absent.
  - Quest reward frames now receive:
    - Arabic label translations via `QTR_Messages.*`
    - Translated questline headers with proper reshaping
    - Arabic fonts + RIGHT justification without anchor mirroring
    - Full restoration to English + LTR on toggle off

- [Tooltips] Removed duplicate tooltip font and hook logic from config.
  - Tooltips module is now the single owner (`common/Tooltips/Hooks.lua`).
  - Hooks enabled early in `common/Tooltips/Main.lua`.

- [Fonts] Centralized Arabic font application.
  - Implemented in `common/UI/Fonts.lua`.
  - Config UI patched via `WOWTR.Fonts.HookAceConfigDialog()`.

- [UI] Introduced shared data-driven UI translation helper.
  - Added `common/UI/Translate.lua`.
  - Refactored GroupFinder, Frames, and AdventureGuide to use it.

- [RTL] Centralized RTL detection via `ns.RTL.IsRTL()`.
  - Reduced raw locale checks across touched modules.

- [Compat] Consolidated legacy `ST_*` globals.
  - Added `common/Core/Compat.lua`.
  - Removed scattered wrappers from UI modules.

- [Core] Deduplicated hook/ticker wiring.
  - Added `common/Core/HookUtils.lua`.
  - Updated `common/Core/Main.lua` to use shared helpers.

- [Config] Reduced config tab boilerplate.
  - Added `WOWTR.Config.MakeTab()` in `common/Config/Helpers.lua`.
  - Converted Tooltips, Bubbles, Movies, ChatAR, and Books tabs.
  - Left General tab custom due to side-effects.

- [Config][Fix] Fixed AceDB persistence issue.
  - Legacy migration now runs only when `WOWTR_DB` does not exist.

## 2025-12-30

- [Quests][QuestMapFrame Rewards][RTL] Fixed AR reward/questline labels clipping on the right edge.
  - Root cause: RIGHT-justified FontStrings were given near-full container width with no right padding, so the first Arabic glyph could render outside/clipped.
  - Fix: In `common/Quests/Details.lua`, when applying `QTR_Messages.*` to `MapQuestInfoRewardsFrame`, set label widths to `mapRewards:GetWidth() - leftInset - rightPad` (no anchor mirroring).