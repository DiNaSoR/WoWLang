-- Tooltips and UI options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Tooltips()
  return WOWTR.Config.MakeTab("tooltips", {
    order = 2,
    name = function() return WOWTR.Config.Label("titleTab6", "Tooltips/UI") end,
    args = {
      basics = {
        type = "group", inline = true, order = 1,
        name = WOWTR.Config.Label("generalMainHeaderTT", "Basics"),
        args = {
          active = { type = "toggle", name = WOWTR.Config.Label("activateTooltipTranslations", "Enable"), order = 1, width = "full" },
          constantly = { type = "toggle", name = WOWTR.Config.Label("displayTranslationConstantly", "Always show"), order = 2, width = "full" },
          timer = { type = "range", name = WOWTR.Config.Label("timerLimitSeconds", "Timer"), min = 1, max = 60, step = 1, order = 3, width = "full" },
        }
      },
      uiTargets = {
        type = "group", inline = true, order = 5,
        name = WOWTR.Config.Label("translationUI", "UI Targets"),
        args = {
          saveui = { type = "toggle", name = WOWTR.Config.Label("saveTranslationUI", "Save UI"), order = 3, width = "full" },
          ui1 = { type = "toggle", name = "Game Menu", order = 10, width = "full" },
          ui2 = { type = "toggle", name = "Character Info", order = 11, width = "full" },
          ui3 = { type = "toggle", name = "Group Finder", order = 12, width = "full" },
          ui4 = { type = "toggle", name = "Collections", order = 13, width = "full" },
          ui5 = { type = "toggle", name = "Adventure Guide", order = 14, width = "full" },
          ui6 = { type = "toggle", name = "Friends", order = 15, width = "full" },
          ui7 = { type = "toggle", name = "Professions", order = 16, width = "full" },
          ui8 = { type = "toggle", name = "Misc UI", order = 17, width = "full" },
          ui_talents = { type = "toggle", name = "Talents UI", order = 18, width = "full" },
        }
      },
      content = {
        type = "group", inline = true, order = 10,
        name = WOWTR.Config.Label("savingUntranslatedTooltips", "Content"),
        args = {
          item = { type = "toggle", name = WOWTR.Config.Label("translateItems", "Items"), order = 20, width = "full" },
          spell = { type = "toggle", name = WOWTR.Config.Label("translateSpells", "Spells"), order = 21, width = "full" },
          talent = { type = "toggle", name = WOWTR.Config.Label("translateTalents", "Talents"), order = 22, width = "full" },
          transtitle = { type = "toggle", name = WOWTR.Config.Label("translateTooltipTitle", "Translate titles"), order = 23, width = "full" },
          -- TT_PS["save"] controls tutorial capture (TT_TUTORIALS) in common/Tutorials/Main.lua
          save = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedTutorials", "Save untranslated tutorials"), order = 24, width = "full" },
          showID = { type = "toggle", name = "Show ID", order = 25, width = "full" },
          showHS = { type = "toggle", name = "Show Hash", order = 26, width = "full" },
          sellprice = { type = "toggle", name = "Hide sell price", order = 27, width = "full" },
          saveNW = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedTooltips", "Save untranslated"), order = 29, width = "full" },
        }
      },
    },
  })
end


