## Conventions (do not skip)

- Lessons are append-only: never delete or rewrite old lessons.
- If a lesson becomes outdated due to refactor or patch changes:
  - Add a NEW lesson that explicitly **supersedes** the old one (e.g. “Supersedes: L-013”).
  - Optionally add a short “Status: Superseded by L-0xx” line inside the old lesson (do not remove content).
- Prefer consistent tags in lesson titles:
  - [Quests], [RTL], [Text], [Tooltips], [Config], [Hooks], [Compat]

## [Config] L-001: Avoid Lua `a and b or default` for booleans

- **Symptom:** A checkbox/toggle appears stuck ON (or stuck OFF) even though click handlers run.
- **Root cause:** Using the Lua idiom `a and b or default` where `b` can be `false` causes the expression to fall through to `default`.
- **Incorrect approach:** `return p and p.minimap and (not p.minimap.hide) or true`
- **Correct rule:** For boolean values, use an explicit conditional or a boolean-safe expression, e.g.:
  - `if p and p.minimap then return not p.minimap.hide end; return true`
  - `return not (p and p.minimap and p.minimap.hide)`

## [Config][Text][RTL] L-002: Don't bake Arabic shaping into config strings at load time

- **Symptom:** Arabic descriptions in the settings UI show without reshaping/RTL (letters look unjoined / order looks wrong), especially for newly added strings.
- **Root cause:** `QTR_ReverseIfAR` (and the reshaper) are loaded later in the TOC (`common/Text.lua`), so any localization resolved earlier (e.g., `WOWTR.Config.Label()` calls inside `Registry.lua`) can freeze unshaped text into module metadata.
- **Incorrect approach:** Compute and store shaped/reversed description strings during addon file load.
- **Correct rule:** Keep stored config metadata as raw strings and apply shaping/RTL at render time (e.g., in `SettingsPanel.lua` using `QTR_ExpandUnitInfo`), or ensure TOC load order guarantees shaping helpers exist before localization is resolved.

## [Quests][UI] L-003: Re-parent shared overlay elements when switching between parent frames

- **Symptom:** A UI element (e.g., quest title decoration glyph) appears only on whichever frame opens first (QuestMapFrame or QuestFrame); switching to the other frame makes it disappear until /reload.
- **Root cause:** The overlay FontString/Frame was created **once** and parented to the first frame's parent. WoW hides child elements when the parent is hidden, so the overlay becomes invisible when switching to a different parent frame.
- **Incorrect approach:** Create the overlay element once with `parent:CreateFontString()` or `CreateFrame("Frame", nil, parent)` and never update the parent.
- **Correct rule:** When a shared overlay may be used across multiple parent frames (e.g., QuestMapFrame vs QuestFrame), call `SetParent(currentParent)` each time the overlay is positioned—not just during initial creation.
