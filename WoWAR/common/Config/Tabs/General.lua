-- General options group
-------------------------------------------------------------------------------------------------------

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.Groups = WOWTR.Config.Groups or {}

local LSM = LibStub("LibSharedMedia-3.0", true)

function WOWTR.Config.Groups.General()
  local fontValues
  if LSM then
    fontValues = {}
    local reg = LSM:HashTable("font")
    for name, _ in pairs(reg) do fontValues[name] = name end
  end

  return {
    type = "group", order = 1,
    name = function() return WOWTR.Config.Label("titleTab1", "General") end,
    get = function(info) return WOWTR.db.profile.quests[info[#info]] end,
    set = function(info, val)
      WOWTR.db.profile.quests[info[#info]] = val
      WOWTR.Config.SyncGlobalsFromDB()
    end,
    args = {
      core = {
        type = "group", inline = true, order = 1,
        name = WOWTR.Config.Label("generalMainHeaderQS", "Core"),
        args = {
          active = { type = "toggle", name = WOWTR.Config.Label("activateQuestsTranslations", "Enable translations"), order = 2, width = "full" },
          transtitle = { type = "toggle", name = WOWTR.Config.Label("translateQuestTitles", "Translate quest titles"), order = 3, width = "full" },
          gossip = { type = "toggle", name = WOWTR.Config.Label("translateGossipTexts", "Translate gossip"), order = 4, width = "full" },
          tracker = { type = "toggle", name = WOWTR.Config.Label("translateTrackObjectives", "Translate tracker"), order = 5, width = "full" },
          ownnames = { type = "toggle", name = WOWTR.Config.Label("translateOwnNames", "Translate own names"), order = 6, width = "full" },
          en_first = { type = "toggle", name = WOWTR.Config.Label("displayENfirst", "Show English first"), order = 7, width = "full" },
        }
      },
      saving = {
        type = "group", inline = true, order = 5,
        name = WOWTR.Config.Label("savingUntranslatedQuests", "Saving"),
        args = {
          saveQS = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedQuests", "Save untranslated quests"), order = 8, width = "full" },
          saveGS = { type = "toggle", name = WOWTR.Config.Label("saveUntranslatedGossip", "Save untranslated gossip"), order = 9, width = "full" },
        }
      },
      plugins = {
        type = "group", inline = true, order = 10,
        name = WOWTR.Config.Label("integrationWithOtherAddons", "Plugins"),
        args = {
          immersion = { type = "toggle", name = "Immersion", order = 11, width = "full" },
          storyline = { type = "toggle", name = "Storyline", order = 12, width = "full" },
          questlog = { type = "toggle", name = "ClassicQuestLog", order = 13, width = "full" },
          dialogueui = { type = "toggle", name = "DialogueUI", order = 14, width = "full" },
        }
      },
      fonts = {
        type = "group", inline = true, order = 16,
        name = WOWTR.Config.Label("fontSelectingFontHeader", "Font"),
        args = {
          FontLSM = fontValues and { type = "select", name = WOWTR.Config.Label("fontSelectingFontHeader", "Font"), values = fontValues, order = 16, width = "full" } or nil,
          fontsize = { type = "range", name = WOWTR.Config.Label("fontsize", "Font size"), min = 10, max = 24, step = 1, order = 17, width = "full" },
        }
      },
      minimapGroup = {
        type = "group", inline = true, order = 18,
        name = WOWTR.Config.Label("minimap", "Minimap"),
        args = {
          minimap = {
            type = "toggle", order = 19,
            name = WOWTR.Config.Label("showMinimapIcon", "Show minimap icon"), width = "full",
            get = function() return not WOWTR.db.profile.minimap.hide end,
            set = function(_, val)
              WOWTR.db.profile.minimap.hide = not val
              WOWTR.Config.SyncGlobalsFromDB()
              local LDBIcon = LibStub("LibDBIcon-1.0", true)
              if LDBIcon then
                if WOWTR.db.profile.minimap.hide then LDBIcon:Hide("WOWTR_LDB") else LDBIcon:Show("WOWTR_LDB") end
              end
            end,
          },
        }
      },
    },
  }
end


