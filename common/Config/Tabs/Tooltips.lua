-- Tooltips and UI options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Tooltips()
  return {
    type = "group", order = 2,
    name = function() return QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.tab6 or "Tooltips/UI") end,
    get = function(info) return WOWTR.db.profile.tooltips[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.tooltips[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      active = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.active or "Enable"), order = 1 },
      save = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.save or "Save untranslated"), order = 2 },
      saveui = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.saveui or "Save UI"), order = 3 },
      ui1 = { type = "toggle", name = "Game Menu", order = 10 },
      ui2 = { type = "toggle", name = "Character Info", order = 11 },
      ui3 = { type = "toggle", name = "Group Finder", order = 12 },
      ui4 = { type = "toggle", name = "Collections", order = 13 },
      ui5 = { type = "toggle", name = "Adventure Guide", order = 14 },
      ui6 = { type = "toggle", name = "Friends", order = 15 },
      ui7 = { type = "toggle", name = "Professions", order = 16 },
      ui8 = { type = "toggle", name = "Misc UI", order = 17 },
      ui_talents = { type = "toggle", name = "Talents UI", order = 18 },
      item = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.item or "Items"), order = 20 },
      spell = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.spell or "Spells"), order = 21 },
      talent = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.talent or "Talents"), order = 22 },
      transtitle = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.transtitle or "Translate titles"), order = 23 },
      showID = { type = "toggle", name = "Show ID", order = 24 },
      showHS = { type = "toggle", name = "Show Hash", order = 25 },
      sellprice = { type = "toggle", name = "Hide sell price", order = 26 },
      constantly = { type = "toggle", name = "Always show", order = 27 },
      timer = { type = "range", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.timer or "Timer"), min = 1, max = 60, step = 1, order = 28 },
      saveNW = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.saveNW or "Save untranslated"), order = 29 },
    },
  }
end

