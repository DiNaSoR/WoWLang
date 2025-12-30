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