-- Movies/Subtitles options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

function WOWTR.Config.Groups.Movies()
  return {
    type = "group", order = 4,
    name = function() return WOWTR.Config.Label("titleTab3", "Subtitles") end,
    get = function(info) return WOWTR.db.profile.movies[info[#info]] end,
    set = function(info, val) WOWTR.db.profile.movies[info[#info]] = val; WOWTR.Config.SyncGlobalsFromDB() end,
    args = {
      basics = {
        type = "group", inline = true, order = 1,
        name = WOWTR.Config.Label("generalMainHeaderMF", "Basics"),
        args = {
          active = { type = "toggle", name = WOWTR.Config.Label("activateSubtitleTranslations", "Enable"), order = 1, width = "full" },
          save = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedSubtitles", "Save untranslated"), order = 5, width = "full" },
        }
      },
      types = {
        type = "group", inline = true, order = 5,
        name = WOWTR.Config.Label("subtitleMovies", "Types"),
        args = {
          intro = { type = "toggle", name = WOWTR.Config.Label("subtitleIntro", "Intro"), order = 2, width = "full" },
          movie = { type = "toggle", name = WOWTR.Config.Label("subtitleMovies", "Movies"), order = 3, width = "full" },
          cinematic = { type = "toggle", name = WOWTR.Config.Label("subtitleCinematics", "Cinematics"), order = 4, width = "full" },
        }
      },
    },
  }
end

