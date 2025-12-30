-- Bubbles options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Bubbles()
  return WOWTR.Config.MakeTab("bubbles", {
    order = 3,
    name = function() return WOWTR.Config.Label("titleTab2", "Bubbles") end,
    set = function(info, val)
      local key = info[#info]
      local b = WOWTR.db.profile.bubbles

      b[key] = val

      -- Prevent “double language” output in chat:
      -- - If enabling Chat TR, disable Chat EN
      -- - If enabling Chat EN, disable Chat TR
      if key == "chat_tr" and val == true then
        b.chat_en = false
      elseif key == "chat_en" and val == true then
        b.chat_tr = false
      end

      WOWTR.Config.SyncGlobalsFromDB()
      WOWTR.Config.NotifyChange()
    end,
    args = {
      basics = {
        type = "group", inline = true, order = 1,
        name = WOWTR.Config.Label("generalMainHeaderBB", "Basics"),
        args = {
          active = { type = "toggle", name = WOWTR.Config.Label("activateBubblesTranslations", "Enable"), order = 1, width = "full" },
          chat_en = { type = "toggle", name = WOWTR.Config.Label("displayOriginalTexts", "Chat EN"), order = 2, width = "full" },
          chat_tr = { type = "toggle", name = WOWTR.Config.Label("displayTranslatedTexts", "Chat TR"), order = 3, width = "full" },
          saveNB = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedBubbles", "Save untranslated bubbles"), order = 4, width = "full" },
        }
      },
      appearance = {
        type = "group", inline = true, order = 5,
        name = WOWTR.Config.Label("fontSizeHeader", "Appearance"),
        args = {
          setsize = { type = "toggle", name = WOWTR.Config.Label("setFontActivate", "Custom size"), order = 5, width = "full" },
          fontsize = { type = "range", name = WOWTR.Config.Label("fontsizeBubbles", "Font size"), min = 10, max = 24, step = 1, order = 6, width = "full" },
        }
      },
      behavior = {
        type = "group", inline = true, order = 10,
        name = WOWTR.Config.Label("choiceGender3OfPlayer", "Behavior"),
        args = {
          sex = { type = "select", name = WOWTR.Config.Label("choiceGender3OfPlayer", "Speaker"), values = { [2] = "Male", [3] = "Female", [4] = "Character" }, order = 7, width = "full" },
          dungeon = { type = "toggle", name = WOWTR.Config.Label("showBubblesInDungeon", "Dungeon frames"), order = 8, width = "full" },
          timeDisplay = { type = "range", name = WOWTR.Config.Label("timerDisplay", "Time"), min = 1, max = 20, step = 1, order = 9, width = "full" },
        }
      },
    },
  })
end


