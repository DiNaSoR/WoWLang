-- Config Core: AceDB init, migration, syncing, and options assembly
-------------------------------------------------------------------------------------------------------

local AceConfig = LibStub("AceConfig-3.0", true)
local AceConfigDialog = LibStub("AceConfigDialog-3.0", true)
local AceDB = LibStub("AceDB-3.0", true)
local AceDBOptions = LibStub("AceDBOptions-3.0", true)
local LSM = LibStub("LibSharedMedia-3.0", true)

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
local C = WOWTR.Config

local function b2s(v) return v and "1" or "0" end
local function s2b(v) return v == true or v == 1 or v == "1" end

C.defaults = {
  profile = {
    minimap = { hide = false, minimapPos = 238 },
    quests = {
      active = true, transtitle = true, gossip = true, tracker = true,
      saveQS = true, saveGS = true, immersion = true, storyline = true,
      questlog = true, dialogueui = true, ownnames = false, en_first = false,
      FontFile = WOWTR_Fonts and WOWTR_Fonts[1] or nil, FontLSM = nil, fontsize = tonumber(QTR_PS and QTR_PS["fontsize"]) or 13,
    },
    tooltips = {
      active = true, save = true, saveui = true,
      ui1 = true, ui2 = true, ui3 = true, ui4 = true, ui5 = true, ui6 = true, ui7 = true, ui8 = true,
      ui_talents = true,
      item = true, spell = true, talent = true, transtitle = false, showID = false, showHS = false,
      sellprice = false, constantly = true, timer = 10, saveNW = true,
    },
    bubbles = {
      active = true, chat_en = false, chat_tr = true, saveNB = true, setsize = false, fontsize = 13,
      sex = 4, dungeon = false, timeDisplay = 5, dungeonF1 = 270, dungeonF2 = 270, dungeonF3 = 270, dungeonF4 = 270, dungeonF5 = 270,
    },
    movies = { active = true, intro = true, movie = true, cinematic = true, save = true },
    books = { active = true, title = true, showID = true, setsize = false, fontsize = 15, saveNW = true },
    chatAR = { active = true, setsize = false, fontsize = 13 },
  }
}

function C.SyncGlobalsFromDB()
  if not WOWTR.db then return end
  local p = WOWTR.db.profile

  QTR_PS = QTR_PS or {}
  QTR_PS["icon"]       = b2s(not p.minimap.hide)
  QTR_PS["active"]     = b2s(p.quests.active)
  QTR_PS["transtitle"] = b2s(p.quests.transtitle)
  QTR_PS["gossip"]     = b2s(p.quests.gossip)
  QTR_PS["tracker"]    = b2s(p.quests.tracker)
  QTR_PS["saveQS"]     = b2s(p.quests.saveQS)
  QTR_PS["saveGS"]     = b2s(p.quests.saveGS)
  QTR_PS["immersion"]  = b2s(p.quests.immersion)
  QTR_PS["storyline"]  = b2s(p.quests.storyline)
  QTR_PS["questlog"]   = b2s(p.quests.questlog)
  QTR_PS["dialogueui"] = b2s(p.quests.dialogueui)
  QTR_PS["ownnames"]   = b2s(p.quests.ownnames)
  QTR_PS["en_first"]   = b2s(p.quests.en_first)
  if p.quests.FontFile then QTR_PS["FontFile"] = p.quests.FontFile end
  QTR_PS["fontsize"]   = tostring(p.quests.fontsize)

  TT_PS = TT_PS or {}
  TT_PS["active"]   = b2s(p.tooltips.active)
  TT_PS["save"]     = b2s(p.tooltips.save)
  TT_PS["saveui"]   = b2s(p.tooltips.saveui)
  for i=1,8 do TT_PS["ui"..i] = b2s(p.tooltips["ui"..i]) end
  TT_PS["ui_talents"] = b2s(p.tooltips.ui_talents)

  ST_PM = ST_PM or {}
  ST_PM["active"]     = b2s(p.tooltips.active)
  ST_PM["item"]       = b2s(p.tooltips.item)
  ST_PM["spell"]      = b2s(p.tooltips.spell)
  ST_PM["talent"]     = b2s(p.tooltips.talent)
  ST_PM["transtitle"] = b2s(p.tooltips.transtitle)
  ST_PM["showID"]     = b2s(p.tooltips.showID)
  ST_PM["showHS"]     = b2s(p.tooltips.showHS)
  ST_PM["sellprice"]  = b2s(p.tooltips.sellprice)
  ST_PM["constantly"] = b2s(p.tooltips.constantly)
  ST_PM["timer"]      = tostring(p.tooltips.timer)
  ST_PM["saveNW"]     = b2s(p.tooltips.saveNW)

  BB_PM = BB_PM or {}
  BB_PM["active"]     = b2s(p.bubbles.active)
  BB_PM["chat-en"]    = b2s(p.bubbles.chat_en)
  BB_PM["chat-tr"]    = b2s(p.bubbles.chat_tr)
  BB_PM["saveNB"]     = b2s(p.bubbles.saveNB)
  BB_PM["setsize"]    = b2s(p.bubbles.setsize)
  BB_PM["fontsize"]   = tostring(p.bubbles.fontsize)
  BB_PM["sex"]        = tostring(p.bubbles.sex)
  BB_PM["dungeon"]    = b2s(p.bubbles.dungeon)
  BB_PM["timeDisplay"] = tostring(p.bubbles.timeDisplay)
  BB_PM["dungeonF1"]  = p.bubbles.dungeonF1; BB_PM["dungeonF2"] = p.bubbles.dungeonF2
  BB_PM["dungeonF3"]  = p.bubbles.dungeonF3; BB_PM["dungeonF4"] = p.bubbles.dungeonF4
  BB_PM["dungeonF5"]  = p.bubbles.dungeonF5

  MF_PM = MF_PM or {}
  MF_PM["active"]    = b2s(p.movies.active)
  MF_PM["intro"]     = b2s(p.movies.intro)
  MF_PM["movie"]     = b2s(p.movies.movie)
  MF_PM["cinematic"] = b2s(p.movies.cinematic)
  MF_PM["save"]      = b2s(p.movies.save)

  BT_PM = BT_PM or {}
  BT_PM["active"]   = b2s(p.books.active)
  BT_PM["title"]    = b2s(p.books.title)
  BT_PM["showID"]   = b2s(p.books.showID)
  BT_PM["setsize"]  = b2s(p.books.setsize)
  BT_PM["fontsize"] = p.books.fontsize
  BT_PM["saveNW"]   = b2s(p.books.saveNW)

  if WoWTR_Localization and WoWTR_Localization.lang == 'AR' then
    CH_PM = CH_PM or {}
    CH_PM["active"]   = b2s(p.chatAR.active)
    CH_PM["setsize"]  = b2s(p.chatAR.setsize)
    CH_PM["fontsize"] = tostring(p.chatAR.fontsize)
  end

  if LSM and p.quests.FontLSM then
    local fontPath = LSM:Fetch("font", p.quests.FontLSM)
    if fontPath then
      WOWTR_Font1 = fontPath
      WOWTR_Font2 = fontPath
    end
  elseif p.quests.FontFile and WOWTR_Fonts and #WOWTR_Fonts > 1 then
    WOWTR_Font2 = WoWTR_Localization.mainFolder .. "\\Fonts\\" .. p.quests.FontFile
  end
end

function C.MigrateLegacyToDB()
  if not WOWTR.db then return end
  local p = WOWTR.db.profile
  if QTR_PS then
    p.minimap.hide            = not s2b(QTR_PS["icon"])
    p.quests.active           = s2b(QTR_PS["active"])
    p.quests.transtitle       = s2b(QTR_PS["transtitle"])
    p.quests.gossip           = s2b(QTR_PS["gossip"])
    p.quests.tracker          = s2b(QTR_PS["tracker"])
    p.quests.saveQS           = s2b(QTR_PS["saveQS"])
    p.quests.saveGS           = s2b(QTR_PS["saveGS"])
    p.quests.immersion        = s2b(QTR_PS["immersion"])
    p.quests.storyline        = s2b(QTR_PS["storyline"])
    p.quests.questlog         = s2b(QTR_PS["questlog"])
    p.quests.dialogueui       = s2b(QTR_PS["dialogueui"])
    p.quests.ownnames         = s2b(QTR_PS["ownnames"])
    p.quests.en_first         = s2b(QTR_PS["en_first"])
    if QTR_PS["FontFile"] then p.quests.FontFile = QTR_PS["FontFile"] end
    if QTR_PS["fontsize"] then p.quests.fontsize = tonumber(QTR_PS["fontsize"]) or p.quests.fontsize end
  end
  if TT_PS then
    p.tooltips.active  = s2b(TT_PS["active"])
    p.tooltips.save    = s2b(TT_PS["save"])
    p.tooltips.saveui  = s2b(TT_PS["saveui"])
    for i=1,8 do p.tooltips["ui"..i] = s2b(TT_PS["ui"..i]) end
    p.tooltips.ui_talents = s2b(TT_PS["ui_talents"]) 
  end
  if ST_PM then
    p.tooltips.item       = s2b(ST_PM["item"])      or p.tooltips.item
    p.tooltips.spell      = s2b(ST_PM["spell"])     or p.tooltips.spell
    p.tooltips.talent     = s2b(ST_PM["talent"])    or p.tooltips.talent
    p.tooltips.transtitle = s2b(ST_PM["transtitle"]) or p.tooltips.transtitle
    p.tooltips.showID     = s2b(ST_PM["showID"])    or p.tooltips.showID
    p.tooltips.showHS     = s2b(ST_PM["showHS"])    or p.tooltips.showHS
    p.tooltips.sellprice  = s2b(ST_PM["sellprice"]) or p.tooltips.sellprice
    p.tooltips.constantly = s2b(ST_PM["constantly"]) or p.tooltips.constantly
    if ST_PM["timer"] then p.tooltips.timer = tonumber(ST_PM["timer"]) or p.tooltips.timer end
    p.tooltips.saveNW     = s2b(ST_PM["saveNW"]) or p.tooltips.saveNW
  end
  if BB_PM then
    p.bubbles.active     = s2b(BB_PM["active"]) 
    p.bubbles.chat_en    = s2b(BB_PM["chat-en"]) 
    p.bubbles.chat_tr    = s2b(BB_PM["chat-tr"]) 
    p.bubbles.saveNB     = s2b(BB_PM["saveNB"]) 
    p.bubbles.setsize    = s2b(BB_PM["setsize"]) 
    if BB_PM["fontsize"] then p.bubbles.fontsize = tonumber(BB_PM["fontsize"]) or p.bubbles.fontsize end
    if BB_PM["sex"] then p.bubbles.sex = tonumber(BB_PM["sex"]) or p.bubbles.sex end
    p.bubbles.dungeon    = s2b(BB_PM["dungeon"]) 
    if BB_PM["timeDisplay"] then p.bubbles.timeDisplay = tonumber(BB_PM["timeDisplay"]) or p.bubbles.timeDisplay end
    p.bubbles.dungeonF1  = BB_PM["dungeonF1"] or p.bubbles.dungeonF1
    p.bubbles.dungeonF2  = BB_PM["dungeonF2"] or p.bubbles.dungeonF2
    p.bubbles.dungeonF3  = BB_PM["dungeonF3"] or p.bubbles.dungeonF3
    p.bubbles.dungeonF4  = BB_PM["dungeonF4"] or p.bubbles.dungeonF4
    p.bubbles.dungeonF5  = BB_PM["dungeonF5"] or p.bubbles.dungeonF5
  end
  if MF_PM then
    p.movies.active    = s2b(MF_PM["active"]) 
    p.movies.intro     = s2b(MF_PM["intro"]) 
    p.movies.movie     = s2b(MF_PM["movie"]) 
    p.movies.cinematic = s2b(MF_PM["cinematic"]) 
    p.movies.save      = s2b(MF_PM["save"]) 
  end
  if BT_PM then
    p.books.active   = s2b(BT_PM["active"]) 
    p.books.title    = s2b(BT_PM["title"]) 
    p.books.showID   = s2b(BT_PM["showID"]) 
    p.books.setsize  = s2b(BT_PM["setsize"]) 
    if BT_PM["fontsize"] then p.books.fontsize = tonumber(BT_PM["fontsize"]) or p.books.fontsize end
    p.books.saveNW   = s2b(BT_PM["saveNW"]) 
  end
  if WoWTR_Localization and WoWTR_Localization.lang == 'AR' and CH_PM then
    p.chatAR.active   = s2b(CH_PM["active"]) 
    p.chatAR.setsize  = s2b(CH_PM["setsize"]) 
    if CH_PM["fontsize"] then p.chatAR.fontsize = tonumber(CH_PM["fontsize"]) or p.chatAR.fontsize end
  end
end

local function RegisterLSMFonts()
  if not LSM then return end
  if not WoWTR_Localization then return end
  if WOWTR_Font1 then LSM:Register("font", "WoWLang Font1", WOWTR_Font1) end
  if WOWTR_Font2 then LSM:Register("font", "WoWLang Font2", WOWTR_Font2) end
  if WOWTR_Fonts and type(WOWTR_Fonts) == "table" then
    for _, filename in ipairs(WOWTR_Fonts) do
      local name = tostring(filename):gsub("%.ttf$", "")
      local path = WoWTR_Localization.mainFolder .. "\\Fonts\\" .. filename
      LSM:Register("font", "WoWLang " .. name, path)
    end
  end
end

-- Apply WOWTR_Font2 to AceConfigDialog UI when Arabic is active
local FontsHooked = false
local WOWTR_AceNormalFO, WOWTR_AceHighlightFO
local function EnsureFontObjects()
  if not (WoWTR_Localization and WoWTR_Localization.lang == 'AR' and WOWTR_Font2) then return end
  if not WOWTR_AceNormalFO then
    WOWTR_AceNormalFO = CreateFont("WOWTR_AceNormal")
    WOWTR_AceNormalFO:SetFont(WOWTR_Font2, 13, "")
  end
  if not WOWTR_AceHighlightFO then
    WOWTR_AceHighlightFO = CreateFont("WOWTR_AceHighlight")
    WOWTR_AceHighlightFO:SetFont(WOWTR_Font2, 13, "")
  end
end

local function ApplyFontsRecursive(obj)
  if not obj then return end
  if not (WoWTR_Localization and WoWTR_Localization.lang == 'AR' and WOWTR_Font2) then return end
  EnsureFontObjects()

  local function setFontOnRegion(region)
    if not region then return end
    if region.SetFont then
      local ok, _, size, flags = pcall(region.GetFont, region)
      if not ok or not size then size = 13 end
      local f = type(flags) == "string" and flags or ""
      pcall(region.SetFont, region, WOWTR_Font2, size, f)
    end
  end

  local objType = obj.GetObjectType and obj:GetObjectType() or nil

  if objType == "FontString" or objType == "EditBox" then
    setFontOnRegion(obj)
  end

  if obj.GetFontString then
    local fs = obj:GetFontString()
    if fs then setFontOnRegion(fs) end
  end

  if obj.SetNormalFontObject and WOWTR_AceNormalFO then
    pcall(obj.SetNormalFontObject, obj, WOWTR_AceNormalFO)
  end
  if obj.SetHighlightFontObject and WOWTR_AceHighlightFO then
    pcall(obj.SetHighlightFontObject, obj, WOWTR_AceHighlightFO)
  end
  if obj.SetDisabledFontObject and WOWTR_AceNormalFO then
    pcall(obj.SetDisabledFontObject, obj, WOWTR_AceNormalFO)
  end

  if obj.GetRegions then
    local regions = { obj:GetRegions() }
    for _, r in pairs(regions) do
      if r and r.GetObjectType and r:GetObjectType() == "FontString" then
        setFontOnRegion(r)
      end
    end
  end

  if obj.GetChildren then
    local children = { obj:GetChildren() }
    for _, c in pairs(children) do ApplyFontsRecursive(c) end
  end
end

local function HookAceConfigDialogFonts()
  if FontsHooked then return end
  if not AceConfigDialog or not AceConfigDialog.Open then return end
  local function wrap(methodName)
    local orig = AceConfigDialog[methodName]
    if type(orig) ~= "function" then return end
    AceConfigDialog[methodName] = function(self, appName, ...)
      local ret = orig(self, appName, ...)
      if WoWTR_Localization and WoWTR_Localization.lang == 'AR' and WOWTR_Font2 and self.OpenFrames and self.OpenFrames[appName] and self.OpenFrames[appName].frame then
        ApplyFontsRecursive(self.OpenFrames[appName].frame)
      end
      return ret
    end
  end
  wrap("Open")
  wrap("SelectGroup")
  wrap("FeedGroup")
  FontsHooked = true
end

-- Hook tooltip frames to use WOWTR_Font2 for Arabic
local TooltipsHooked = false
local function ApplyTooltipFonts(tt)
  if not tt or not tt.GetRegions then return end
  if not (WoWTR_Localization and WoWTR_Localization.lang == 'AR' and WOWTR_Font2) then return end
  local function setFS(fs)
    if not fs or not fs.SetFont then return end
    local ok, _, size, flags = pcall(fs.GetFont, fs)
    if not ok or not size then size = 13 end
    local f = type(flags) == "string" and flags or ""
    pcall(fs.SetFont, fs, WOWTR_Font2, size, f)
  end

  local regions = { tt:GetRegions() }
  for _, r in pairs(regions) do
    if r and r.GetObjectType and r:GetObjectType() == "FontString" then
      setFS(r)
    end
  end

  local name = tt.GetName and tt:GetName() or nil
  if name then
    for i = 1, 40 do
      setFS(_G[name .. "TextLeft" .. i])
      setFS(_G[name .. "TextRight" .. i])
    end
  end
end

local function HookTooltipFonts()
  if TooltipsHooked then return end
  -- Ensure base tooltip FontObjects use WOWTR_Font2
  if WoWTR_Localization and WoWTR_Localization.lang == 'AR' and WOWTR_Font2 then
    local function SetFO(obj)
      if not obj then return end
      local ok, _, size, flags = pcall(obj.GetFont, obj)
      if not ok or not size then size = 13 end
      local f = type(flags) == "string" and flags or ""
      pcall(obj.SetFont, obj, WOWTR_Font2, size, f)
    end
    SetFO(_G.GameTooltipHeaderText)
    SetFO(_G.GameTooltipText)
    SetFO(_G.GameTooltipTextSmall)
    SetFO(_G.Tooltip_Med)
    SetFO(_G.Tooltip_Small)
  end

  local names = { "GameTooltip", "ItemRefTooltip", "ShoppingTooltip1", "ShoppingTooltip2", "ShoppingTooltip3", "ItemRefShoppingTooltip1", "ItemRefShoppingTooltip2", "ItemRefShoppingTooltip3" }
  for _, n in ipairs(names) do
    local tt = _G[n]
    if tt and tt.HookScript then
      tt:HookScript("OnShow", ApplyTooltipFonts)
      if tt:HasScript("OnTooltipSetText") then tt:HookScript("OnTooltipSetText", ApplyTooltipFonts) end
      if tt:HasScript("OnTooltipSetItem") then tt:HookScript("OnTooltipSetItem", ApplyTooltipFonts) end
      if tt:HasScript("OnTooltipSetSpell") then tt:HookScript("OnTooltipSetSpell", ApplyTooltipFonts) end
      if tt:HasScript("OnTooltipSetUnit") then tt:HookScript("OnTooltipSetUnit", ApplyTooltipFonts) end
      if tt:HasScript("OnUpdate") then tt:HookScript("OnUpdate", function(self) if self:IsShown() then ApplyTooltipFonts(self) end end) end
    end
  end
  TooltipsHooked = true
end

local function BuildOptions()
  local options = {
    type = "group",
    childGroups = "tab",
    name = function() return QTR_ReverseIfAR(WoWTR_Localization and WoWTR_Localization.optionTitle or "WoWLang") end,
    args = {}
  }

  local G = C.Groups or {}
  if G.General then options.args.general = G.General() end
  if G.Tooltips then options.args.tooltips = G.Tooltips() end
  if G.Bubbles then options.args.bubbles = G.Bubbles() end
  if G.Movies then options.args.movies = G.Movies() end
  if G.Books then options.args.books = G.Books() end
  if G.ChatAR then options.args.chatAR = G.ChatAR() end
  if G.About then options.args.about = G.About() end

  if AceDBOptions and WOWTR.db then
    options.args.profiles = AceDBOptions:GetOptionsTable(WOWTR.db)
    options.args.profiles.order = 99
  end
  return options
end

function C.Init()
  if AceDB then
    WOWTR.db = AceDB:New("WOWTR_DB", C.defaults, true)
    C.MigrateLegacyToDB()
    C.SyncGlobalsFromDB()
    if WOWTR.db.RegisterCallback then
      WOWTR.db:RegisterCallback("OnProfileChanged", C.SyncGlobalsFromDB)
      WOWTR.db:RegisterCallback("OnProfileCopied", C.SyncGlobalsFromDB)
      WOWTR.db:RegisterCallback("OnProfileReset", C.SyncGlobalsFromDB)
    end
  end
  if AceConfig and AceConfigDialog then
    AceConfig:RegisterOptionsTable("WOWTR", BuildOptions())
    AceConfigDialog:AddToBlizOptions("WOWTR", QTR_ReverseIfAR(WoWTR_Localization and WoWTR_Localization.optionName or "WoWLang"))
  end
  RegisterLSMFonts()
  HookAceConfigDialogFonts()
  HookTooltipFonts()
end

function C.Open()
  if AceConfigDialog then
    AceConfigDialog:Open("WOWTR")
  elseif Settings and WOWTR and WOWTR.CategoryID then
    Settings.OpenToCategory(WOWTR.CategoryID)
  end
end

