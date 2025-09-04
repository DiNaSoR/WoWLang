-- Bubbles options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Bubbles()
  return {
    type = "group", order = 3,
    name = function() return WOWTR.Config.Label("titleTab2", "Bubbles") end,
    get = function(info) return WOWTR.db.profile.bubbles[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.bubbles[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      active = { type = "toggle", name = WOWTR.Config.Label("activateBubblesTranslations", "Enable"), order = 1 },
      chat_en = { type = "toggle", name = WOWTR.Config.Label("displayOriginalTexts", "Chat EN"), order = 2 },
      chat_tr = { type = "toggle", name = WOWTR.Config.Label("displayTranslatedTexts", "Chat TR"), order = 3 },
      saveNB = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedBubbles", "Save untranslated bubbles"), order = 4 },
      setsize = { type = "toggle", name = WOWTR.Config.Label("setFontActivate", "Custom size"), order = 5 },
      fontsize = { type = "range", name = WOWTR.Config.Label("fontsizeBubbles", "Font size"), min = 10, max = 24, step = 1, order = 6 },
      sex = { type = "select", name = WOWTR.Config.Label("choiceGender3OfPlayer", "Speaker"), values = { [2] = "Male", [3] = "Female", [4] = "Character" }, order = 7 },
      dungeon = { type = "toggle", name = WOWTR.Config.Label("showBubblesInDungeon", "Dungeon frames"), order = 8 },
      timeDisplay = { type = "range", name = WOWTR.Config.Label("timerDisplay", "Time"), min = 1, max = 20, step = 1, order = 9 },
    },
  }
end


