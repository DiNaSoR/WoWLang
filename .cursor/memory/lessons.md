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

## [Tooltips][Text] L-004: Translation placeholder functions must actually substitute values

- **Symptom:** Tooltip translations show literal `{1}%` or `{2} seconds` instead of actual spell values like `20%` or `8 seconds`.
- **Root cause:** `ST_TranslatePrepare(origin, tlumacz)` was designed to extract numbers from the original English text and substitute them into `{1}`, `{2}`, `{3}` placeholders in the translation—but the implementation was a stub that simply returned `tlumacz` unchanged.
- **Incorrect approach:** Assuming a proxy function will be overridden elsewhere, or assuming pre-shaped translation data doesn't need runtime value substitution.
- **Correct rule:** When translation data contains dynamic placeholders like `{1}`, `{2}`, always implement the value extraction and substitution logic. The function signature `(origin, tlumacz)` provides both the original text (with values) and translation (with placeholders)—use `string.gmatch(origin, "pattern")` to extract values and substitute them into the translation before returning.

## [Text][RTL] L-005: printf-style format tokens must be protected before RTL reversal

- **Symptom:** Strings containing `%s`, `%d`, `%1$s`, `%.2f` become corrupted after Arabic RTL processing (e.g., `%s` → `s%`, `%1$s` → `s$1%`).
- **Root cause:** `HandleWoWSpecialCodes` protects WoW escape codes (`|c`, `|T`, `|H`, etc.) but did not protect printf-style format tokens, which are also sensitive to character order reversal.
- **Incorrect approach:** Assuming only WoW-specific codes need protection; forgetting that any addon integration or edge case could introduce printf tokens.
- **Correct rule:** In `HandleWoWSpecialCodes`, protect printf tokens with patterns like `(%%%-?%d*%.?%d*[sdifFeEgGxXouc])` for standard tokens and `(%%%d+%$%-?%d*%.?%d*[sdifFeEgGxXouc])` for positional tokens. These should be converted to `\001INDEX\002` placeholders like other protected codes.

## [Text][RTL] L-006: Values substituted before RTL reversal must be marked for protection

- **Symptom:** Numbers like "20" appear reversed as "02" in Arabic tooltips after `{1}` placeholder substitution.
- **Root cause:** `ST_TranslatePrepare` substitutes `{1}` → `20` BEFORE `HandleWoWSpecialCodes` runs, so the "20" is treated as regular text and gets reversed during RTL processing.
- **Incorrect approach:** Directly substituting values into translation text without considering that the text will later go through RTL reversal.
- **Correct rule:** When substituting values into Arabic text that will be RTL-processed, wrap the values with marker characters (e.g., `\003VALUE\004`) that `HandleWoWSpecialCodes` can recognize and protect. The markers are stripped during protection, and the value is restored intact after reversal. This ensures substituted numbers maintain their correct digit order.

## [Tooltips] L-007: Number extraction patterns must require at least one digit

- **Symptom:** A placeholder like `{3}` shows a comma `,` or other punctuation instead of the expected number.
- **Root cause:** Pattern `[%d,]+` matches one or more digits OR commas, so a lone comma in the original text gets extracted as a "number" and substituted into a placeholder.
- **Incorrect approach:** Using `%-?[%d,]+%.?%d*` to extract numbers (matches commas without requiring digits).
- **Correct rule:** Use `%-?%d[%d,]*%.?%d*` which requires at least one digit (`%d`) before allowing optional commas. This prevents lone punctuation from being treated as numbers while still supporting formatted numbers like "1,000".

## [Tooltips][RTL] L-008: RTL justification must check for actual Arabic content, not just locale

- **Symptom:** English tooltips (without Arabic translation) appear right-aligned in Arabic mode, making them hard to read.
- **Root cause:** RTL justification code checked `WoWTR_Localization.lang == 'AR'` but didn't verify that the tooltip actually contained Arabic text. Untranslated tooltips showing English were incorrectly right-justified.
- **Incorrect approach:** Applying RTL layout based solely on the addon's current language setting.
- **Correct rule:** Before applying RTL justification, check if **any line in the tooltip contains Arabic characters** (using `ContainsArabic()` or checking for Arabic Unicode ranges). Only apply RTL layout when Arabic content is actually present.
