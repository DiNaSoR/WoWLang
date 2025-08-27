-- About / Reset options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.About()
  return {
    type = "group", order = 98,
    name = function() return QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.tab9 or "About") end,
    args = {
      info = { type = "description", name = function() return QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.generalText or "WoWLang translations addon.") end, order = 1 },
      resetLogs = { type = "execute", order = 10, name = QTR_ReverseIfAR(WoWTR_Localization and WoWTR_Localization.resetButton1 or "Reset logs"), func = function() if WOWTR_ResetVariables then WOWTR_ResetVariables(1) end end },
      resetAll = { type = "execute", order = 11, name = QTR_ReverseIfAR(WoWTR_Localization and WoWTR_Localization.stopTheMovieYes or "Reset settings and reload"), confirm = true, func = function() if WOWTR_ResetVariables then WOWTR_ResetVariables(2) end if WOWTR_ReloadUI then WOWTR_ReloadUI() end end },
    },
  }
end

