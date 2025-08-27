-- Movies/Subtitles options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Movies()
  return {
    type = "group", order = 4,
    name = function() return QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.tab3 or "Subtitles") end,
    get = function(info) return WOWTR.db.profile.movies[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.movies[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      active = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.active or "Enable"), order = 1 },
      intro = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.intro or "Intro"), order = 2 },
      movie = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.movie or "Movies"), order = 3 },
      cinematic = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.cinematic or "Cinematics"), order = 4 },
      save = { type = "toggle", name = QTR_ReverseIfAR(WoWTR_Config_Interface and WoWTR_Config_Interface.save or "Save untranslated"), order = 5 },
    },
  }
end

