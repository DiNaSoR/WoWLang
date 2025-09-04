-- Tooltips and UI options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Tooltips()
  return {
    type = "group", order = 2,
    name = function() return WOWTR.Config.Label("titleTab6", "Tooltips/UI") end,
    get = function(info) return WOWTR.db.profile.tooltips[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.tooltips[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      active = { type = "toggle", name = WOWTR.Config.Label("activateTooltipTranslations", "Enable"), order = 1 },
      save = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedTooltips", "Save untranslated"), order = 2 },
      saveui = { type = "toggle", name = WOWTR.Config.Label("saveTranslationUI", "Save UI"), order = 3 },
      ui1 = { type = "toggle", name = "Game Menu", order = 10 },
      ui2 = { type = "toggle", name = "Character Info", order = 11 },
      ui3 = { type = "toggle", name = "Group Finder", order = 12 },
      ui4 = { type = "toggle", name = "Collections", order = 13 },
      ui5 = { type = "toggle", name = "Adventure Guide", order = 14 },
      ui6 = { type = "toggle", name = "Friends", order = 15 },
      ui7 = { type = "toggle", name = "Professions", order = 16 },
      ui8 = { type = "toggle", name = "Misc UI", order = 17 },
      ui_talents = { type = "toggle", name = "Talents UI", order = 18 },
      item = { type = "toggle", name = WOWTR.Config.Label("translateItems", "Items"), order = 20 },
      spell = { type = "toggle", name = WOWTR.Config.Label("translateSpells", "Spells"), order = 21 },
      talent = { type = "toggle", name = WOWTR.Config.Label("translateTalents", "Talents"), order = 22 },
      transtitle = { type = "toggle", name = WOWTR.Config.Label("translateTooltipTitle", "Translate titles"), order = 23 },
      showID = { type = "toggle", name = "Show ID", order = 24 },
      showHS = { type = "toggle", name = "Show Hash", order = 25 },
      sellprice = { type = "toggle", name = "Hide sell price", order = 26 },
      constantly = { type = "toggle", name = WOWTR.Config.Label("displayTranslationConstantly", "Always show"), order = 27 },
      timer = { type = "range", name = WOWTR.Config.Label("timerLimitSeconds", "Timer"), min = 1, max = 60, step = 1, order = 28 },
      saveNW = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedTooltips", "Save untranslated"), order = 29 },
    },
  }
end


