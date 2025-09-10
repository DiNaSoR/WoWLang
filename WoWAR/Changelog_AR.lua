-- Arabic locale pack changelog entries
-- Loaded before common/UI/Changelog.lua. Populates WOWTR.Changelog.entries

WOWTR = WOWTR or {}
WOWTR.Changelog = WOWTR.Changelog or {}

-- Newest first
WOWTR.Changelog.entries = {
  {
    version = "11.20",
    date = date("%d %b %Y"),
    color = "purple",
    type = "Feature",
    author = "WoWLang",
    title = "ﺛﻢ ﺗﻌﺎل أﻳﻬﺎ اﻟﻨﺎﺳﻚ! - 2",
    description = "Added a new What's New window with scrolling entries, colored badges, and auto-open on update.\n\n- New frame with title and close button\n- Scrollable content area\n- Dynamic entry sizing for long text"
  },
  {
    version = "11.19",
    date = date("%d %b %Y"),
    color = "blue",
    type = "Improvement",
    author = "WoWLang",
    title = nil,
    description = "Improved text shaping and RTL handling in the changelog body.\nThis entry intentionally spans multiple lines to test wrapping and height calculation."
  },
  {
    version = tostring(WOWTR_version or ""),
    date = date("%d %b %Y"),
    color = "red",
    type = "Fix",
    author = "WoWLang",
    title = nil,
    description = "Fixed minor layout issues and polished fonts for the changelog view."
  },
}






