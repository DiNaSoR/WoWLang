-- Books options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Books()
  return {
    type = "group", order = 5,
    name = function() return WOWTR.Config.Label("titleTab5", "Books") end,
    get = function(info) return WOWTR.db.profile.books[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.books[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      active = { type = "toggle", name = WOWTR.Config.Label("activateBooksTranslations", "Enable"), order = 1 },
      title = { type = "toggle", name = WOWTR.Config.Label("translateBookTitles", "Translate title"), order = 2 },
      showID = { type = "toggle", name = "Show ID", order = 3 },
      setsize = { type = "toggle", name = WOWTR.Config.Label("setFontActivate", "Custom size"), order = 4 },
      fontsize = { type = "range", name = WOWTR.Config.Label("fontsize", "Font size"), min = 10, max = 24, step = 1, order = 5 },
      saveNW = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedBooks", "Save untranslated"), order = 6 },
    },
  }
end


