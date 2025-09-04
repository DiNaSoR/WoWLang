-- Arabic Chat options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.ChatAR()
  return {
    type = "group", order = 6,
    name = function() return WOWTR.Config.Label("chatService", "Arabic Chat") end,
    hidden = function() return not (WoWTR_Localization and WoWTR_Localization.lang == 'AR') end,
    get = function(info) return WOWTR.db.profile.chatAR[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.chatAR[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      active = { type = "toggle", name = WOWTR.Config.Label("activateChatService", "Enable"), order = 1 },
      setsize = { type = "toggle", name = WOWTR.Config.Label("chatFontActivate", "Custom size"), order = 2 },
      fontsize = { type = "range", name = WOWTR.Config.Label("fontsizeChat", "Font size"), min = 10, max = 24, step = 1, order = 3 },
    },
  }
end

