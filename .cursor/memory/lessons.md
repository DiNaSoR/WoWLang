# WoWLang / WoWAR – Lessons Learned
(Read before coding. Do not violate.)

---

## L-001 — Blizzard QuestMapFrame refresh overwrites custom text

### Symptom
- Quest text reverts to English after toggling translation.
- Arabic headers or RTL layout disappear after scrolling or reopening quests.

### Root cause
- Calling `QuestMapFrame_ShowQuestDetails` triggers Blizzard’s internal refresh,
  rebuilding the DetailsFrame and overwriting modified FontStrings.

### Wrong approach (DO NOT REPEAT)
- Forcing QuestMapFrame refresh calls to “fix” translation state.

### Correct approach
- Modify text in place.
- Reapply translation **after layout** using short scheduled passes.

### Rule
> Never call Blizzard QuestMapFrame refresh APIs to control translation state.

---

## L-002 — Mixed Arabic headers with English quest body

### Symptom
- Arabic “الوصف” header appears above English quest text.
- RTL layout applies even when translation data is missing.

### Root cause
- RTL logic was triggered by language toggle alone, not by actual QuestData content.

### Wrong approach
- Applying RTL and Arabic headers whenever AR is enabled.

### Correct approach
- Detect real Arabic QuestData via Arabic script checks.
- Downgrade to English when translation data is missing.

### Rule
> RTL layout must depend on data, not user preference alone.

---

## L-003 — Translation fallback must not mutate global toggle state

### Symptom
- User enables Arabic, but toggle flips back to English after visiting untranslated quests.

### Root cause
- Fallback logic reused translation toggle paths and mutated global state.

### Wrong approach
- Treating fallback-to-English as a real toggle-off.

### Correct approach
- Support fallback events that preserve user intent.
- Keep `QTR_curr_trans` authoritative.

### Rule
> Translation fallback must never flip the user’s global toggle.

---

## L-004 — Duplicate tooltip hooks cause inconsistent rendering

### Symptom
- Tooltip fonts and layout behave inconsistently across UI paths.

### Root cause
- Tooltip hooks were implemented in both config and tooltips modules.

### Wrong approach
- Adding tooltip hooks opportunistically wherever convenient.

### Correct approach
- Centralize all tooltip hooks and font logic in `common/Tooltips/*`.

### Rule
> Tooltips must have exactly one owning subsystem.

---

## L-005 — Anchor mirroring breaks RTL reward layouts

### Symptom
- Arabic reward labels drift outside reward frames.

### Root cause
- Anchor mirroring combined with RIGHT justification caused cumulative offsets.

### Wrong approach
- Mirroring anchors to simulate RTL.

### Correct approach
- Keep anchors intact.
- Use RIGHT justification + Arabic fonts only.

### Rule
> Do not mirror anchors for RTL; control layout via justification and fonts.

---

## L-006 — Legacy migration must never run repeatedly

### Symptom
- User config resets every login.
- Options appear unsaved.

### Root cause
- Legacy → AceDB migration ran on every startup, overwriting saved profiles.

### Wrong approach
- Migrating legacy config unconditionally.

### Correct approach
- Migrate legacy settings only when AceDB does not yet exist.

### Rule
> Config migration must be one-time only.

---

## L-007 — RTL RIGHT justification can clip Arabic glyphs without padding

### Symptom
- Arabic UI labels (especially in QuestMapFrame rewards) show the first/rightmost glyph partially outside the frame.

### Root cause
- The FontString was RIGHT-justified, but its width was set too close to the container width without accounting for insets/padding.

### Wrong approach
- Setting `SetJustifyH("RIGHT")` and expanding the label to full container width blindly.

### Correct approach
- Keep anchors intact (no mirroring).
- When applying RTL, set label width to `containerWidth - leftInset - rightPadding` so the rightmost glyph stays inside the visible area.

### Rule
> For RTL UI labels, always include safe right padding when sizing RIGHT-justified FontStrings.

---

## L-008 — Special-code placeholders must restore correctly after reversal (multi-digit indices)

### Symptom
- Inline icons/textures (e.g. quest type `|T...|t` / atlas `|A...|a`) or other WoW formatting codes disappear in Arabic (RTL) views.

### Root cause
- Our `Text.HandleWoWSpecialCodes()` uses numeric placeholders like `\00112\002`.
- When the Arabic pipeline reverses the text, multi-digit placeholders reverse internally (`\00112\002` → `\00221\001`).
- If restoration doesn’t reverse the digits back, indices ≥ 10 restore to the wrong entry (or nil), effectively dropping the code.

### Wrong approach
- Restoring reversed placeholders using the digit run as-is.

### Correct approach
- When restoring the reversed placeholder pattern (`\002(%d+)\001`), reverse the digits back before lookup.

### Rule
> Any placeholder scheme that includes digits must handle digit-order reversal, otherwise icons/codes will vanish in RTL.

---

## L-009 — Some “icons” in quest titles are font glyphs (not `|T`/`|A`) and vanish when switching fonts

### Symptom
- The small quest-type “!” icon shown before some quest titles disappears only in Arabic translation mode.

### Root cause
- The icon is a **leading font glyph character** present in Blizzard’s quest-title font.
- When we switch the title FontString to an Arabic font (`WOWTR_Font1`), that glyph is missing, so it renders as nothing.

### Wrong approach
- Assuming all title icons are inline textures (`|T` / `|A`) or part of the translation text.

### Correct approach
- Detect the leading glyph from the original (EN) title.
- Render it with a separate overlay FontString using the original quest-title font (`Original_Font1`).
- Keep the Arabic title itself rendered with the Arabic font.

### Rule
> Treat title “icons” as either inline texture tags or font glyphs; glyphs must be rendered with the original font in a separate overlay when using Arabic fonts.

---

## L-010 — Quest title decorations can be generic hyperlinks (`|H...|h...|h`), not just `|T`/`|A` or `[...]` links

### Symptom
- Quest title icon/tag (e.g. repeatable “!”) disappears or the title string becomes padded spaces in Arabic mode.

### Root cause
- Some title decorations start with `|HRepeat...|h<icon>|h` (no bracketed `[...]`).
- If the RTL pipeline reverses the string without protecting that hyperlink, the link breaks and the embedded icon text is lost.

### Wrong approach
- Only protecting `|H...|h[...|h` links and assuming all title icons are `|T`/`|A`.

### Correct approach
- Protect generic `|H...|h...|h` hyperlinks in `Text.HandleWoWSpecialCodes()` before RTL shaping.
- When extracting title decorations, treat leading `|H...|h...|h` segments as "tags" and extract the display glyph from inside them if needed.

### Rule
> Always preserve generic `|H...|h...|h` hyperlinks through RTL processing; quest title icons may depend on them.

---

## L-011 — Avoid injecting `|H...|h...|h` title decorations into RTL-shaped FontStrings (placeholder leak)

### Symptom
- Arabic quest titles show visible placeholder garbage like `□1□` at the start of the title.

### Root cause
- RTL shaping uses special-code placeholders (`\0011\002`) while reversing/wrapping.
- Some title decorations (repeatable icon links) are `|H...|h...|h` and can cause those placeholders to leak into visible FontStrings in certain wrapping/padding paths.

### Wrong approach
- Appending `|H...|h...|h` decorations into the Arabic title string and sending it through the shaping pipeline.

### Correct approach
- Keep the Arabic title clean (no `|H...|h...|h` injected).
- Extract the icon glyph from the EN title and render it with a separate overlay FontString using `Original_Font1`.

### Rule
> For quest titles in RTL, render `|H`-based decorations as separate overlays instead of embedding them in the shaped title string.

---

## L-012 — `|H...|h...|h` title decorations may display an inline atlas/texture (`|A`/`|T`), not a glyph

### Symptom
- Repeatable/quest-type “!” icon still missing in Arabic even after preserving `|H` links.

### Root cause
- The hyperlink display text can be `|A:...|a` or `|T...|t` (inline atlas/texture), not a Unicode glyph.
- Glyph-only extraction logic won’t capture it, so the overlay stays empty.

### Correct approach
- When parsing a leading `|H...|h...|h`, inspect the display part (`|h...|h`) for an initial `|A...|a` or `|T...|t` and treat that as the icon to render.

### Rule
> For title decorations, handle `|H` display payloads that start with `|A`/`|T` tags, not just glyphs.