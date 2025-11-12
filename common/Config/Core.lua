-- Config Core: AceDB init, migration, syncing, and options assembly
-------------------------------------------------------------------------------------------------------

local AceConfig = LibStub("AceConfig-3.0", true)
local AceConfigDialog = LibStub("AceConfigDialog-3.0", true)
local AceDB = LibStub("AceDB-3.0", true)
local AceDBOptions = LibStub("AceDBOptions-3.0", true)
local LSM = LibStub("LibSharedMedia-3.0", true)
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0", true)

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
local C = WOWTR.Config
function C.NotifyChange()
  if AceConfigRegistry then
    AceConfigRegistry:NotifyChange("WOWTR")
  end
end

local function b2s(v) return v and "1" or "0" end
local function s2b(v) return v == true or v == 1 or v == "1" end

C.defaults = {
  profile = {
    minimap = { hide = false, minimapPos = 238 },
    core = {
      lastShownChangelogVersion = "",
      debug = false, -- Debug mode toggle
      debugConfig = {
        quests = 3,    -- NORMAL by default
        gossip = 3,
        tooltips = 3,
        books = 3,
        movies = 3,
        bubbles = 3,
        chat = 3,
        config = 3,
        general = 3,
      },
    },
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

  -- Apply to AceGUI widget label/text if present on the frame (covers checkboxes, labels, headers)
  if obj.obj then
    local w = obj.obj
    local okText, textRegion = pcall(function() return rawget(w, "text") end)
    if okText and type(textRegion) == "table" and textRegion.SetFont then setFontOnRegion(textRegion) end
    local okLabel, labelRegion = pcall(function() return rawget(w, "label") end)
    if okLabel and type(labelRegion) == "table" and labelRegion.SetFont then setFontOnRegion(labelRegion) end
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
  
  local function FixTitleWidth(frameRef)
    if not frameRef or not frameRef.obj then return end
    local widget = frameRef.obj
    if widget.WOWTR_TitleHooked then return end
    widget.WOWTR_TitleHooked = true
    local origSetTitle = widget.SetTitle
    if type(origSetTitle) ~= "function" then return end
    widget.SetTitle = function(self, title)
      origSetTitle(self, title)
      local bg = self.titlebg
      if not bg or not bg.SetWidth then return end
      local tw = 0
      if self.titletext and self.titletext.GetStringWidth then
        tw = tonumber(self.titletext:GetStringWidth()) or 0
      elseif self.titletext and self.titletext.GetWidth then
        tw = tonumber(self.titletext:GetWidth()) or 0
      elseif bg.GetWidth then
        tw = tonumber(bg:GetWidth()) or 200
      end
      tw = math.max(120, math.floor(tw + 12))
      if not self.WOWTR_TitleFixedWidth or tw > self.WOWTR_TitleFixedWidth then
        self.WOWTR_TitleFixedWidth = tw
      end
      bg:SetWidth(self.WOWTR_TitleFixedWidth)
    end
    -- Apply immediately after fonts are set so first render is stable
    local bg = widget.titlebg
    local current = (bg and bg.GetWidth and tonumber(bg:GetWidth())) or 200
    local tw = 0
    if widget.titletext and widget.titletext.GetStringWidth then
      tw = tonumber(widget.titletext:GetStringWidth()) or 0
    elseif widget.titletext and widget.titletext.GetWidth then
      tw = tonumber(widget.titletext:GetWidth()) or 0
    end
    local target = math.max(120, math.floor(math.max(current, tw + 12)))
    widget.WOWTR_TitleFixedWidth = target
    if bg and bg.SetWidth then bg:SetWidth(target) end
  end
  
  local function NudgeTabGroupDown(frameRef, topPad)
    -- No-op: rely on AceGUI's internal layout; our banner only adjusts content padding
  end
  
  -- (removed) ElevateTopControls: superseded by EnsureTopRightClose/HideFooterControls

  local function HideFooterControls(frameRef)
    if not frameRef then return end
    local function kill(f)
      if not f then return end
      if f.Hide then pcall(f.Hide, f) end
      if f.SetAlpha then pcall(f.SetAlpha, f, 0) end
      if f.EnableMouse then pcall(f.EnableMouse, f, false) end
      if f.SetFrameStrata then pcall(f.SetFrameStrata, f, "BACKGROUND") end
      if f.ClearAllPoints and f.SetPoint then pcall(f.ClearAllPoints, f); pcall(f.SetPoint, f, "BOTTOMLEFT", frameRef, "BOTTOMLEFT", 0, -9999) end
      if f.HookScript then pcall(f.HookScript, f, "OnShow", function(self) self:Hide() end) end
    end
    local closeBtn = (frameRef.obj and frameRef.obj.closebutton) or frameRef.closebutton
    local searchBox = (frameRef.obj and frameRef.obj.searchbox) or frameRef.searchbox
    kill(closeBtn); kill(searchBox)
    if frameRef.GetChildren then
      local kids = { frameRef:GetChildren() }
      for _, k in ipairs(kids) do
        local t = k.GetObjectType and k:GetObjectType() or nil
        if (t == "Button" or t == "EditBox") and (k ~= frameRef.WOWTR_TopRightClose) then
          -- Skip our top-right close and only target footer-like controls
          local name = k.GetName and k:GetName() or ""
          local p1 = k.GetPoint and select(1, k:GetPoint()) or nil
          local anchoredBottom = p1 == "BOTTOM" or p1 == "BOTTOMLEFT" or p1 == "BOTTOMRIGHT"
          local looksLikeFooter = anchoredBottom or (name and (name:find("Search") or name:find("Close")))
          if looksLikeFooter then kill(k) end
        end
      end
    end
  end

  local function EnsureTopRightClose(frameRef, appName)
    if not frameRef then return end
    HideFooterControls(frameRef)
    if not frameRef.WOWTR_TopRightClose then
      local btn = CreateFrame("Button", nil, frameRef, "UIPanelCloseButton")
      frameRef.WOWTR_TopRightClose = btn
      btn:SetPoint("TOPRIGHT", frameRef, "TOPRIGHT", -6, -6)
      if btn.SetFrameStrata then btn:SetFrameStrata("FULLSCREEN_DIALOG") end
      if btn.SetFrameLevel and frameRef.GetFrameLevel then btn:SetFrameLevel((frameRef:GetFrameLevel() or 0) + 250) end
      btn:SetScript("OnClick", function() if AceConfigDialog and AceConfigDialog.Close then AceConfigDialog:Close(appName or "WOWTR") else frameRef:Hide() end end)
    end
    frameRef.WOWTR_TopRightClose:Show()
    -- Keep footer controls removed even if AceGUI rebuilds them
    if not frameRef.WOWTR_KillFooterHooked and frameRef.HookScript then
      frameRef.WOWTR_KillFooterHooked = true
      local acc = 0
      frameRef:HookScript("OnUpdate", function(f, elapsed)
        acc = (acc or 0) + (elapsed or 0)
        if acc >= 0.5 then
          acc = 0
          HideFooterControls(f)
        end
      end)
    end
  end
  local function NeutralizeFrameChrome(frameRef)
    if not frameRef then return end
    if frameRef.titlebg and frameRef.titlebg.Hide then frameRef.titlebg:Hide() end
    if frameRef.statusbg and frameRef.statusbg.Hide then frameRef.statusbg:Hide() end
  end

  local function AttachConfigBanner(container)
    if not container or not container.CreateTexture then return end
    if not container.WOWTR_Banner then
      local tex = container:CreateTexture(nil, "BACKGROUND")
      container.WOWTR_Banner = tex
      tex:SetHorizTile(false); tex:SetVertTile(false)
      tex:SetAlpha(1)
      tex:SetVertexColor(1, 1, 1, 1)
      tex:SetDrawLayer("ARTWORK")
      tex:SetPoint("TOPLEFT", container, "TOPLEFT", 2, 73)
      tex:SetPoint("TOPRIGHT", container, "TOPRIGHT", -2, 73)
      tex:SetHeight(80)
    end
    local path
    if WoWTR_Localization and WoWTR_Localization.mainFolder then
      path = WoWTR_Localization.mainFolder .. "\\Images\\bannar.png"
    end
    if path then container.WOWTR_Banner:SetTexture(path) end
    container.WOWTR_Banner:Show()
    NeutralizeFrameChrome(container)
    local content = container.content
    -- Do not push content down; keep banner as a top overlay above the frame
    if content and content.ClearAllPoints then
      content:ClearAllPoints()
      content:SetPoint("TOPLEFT", container, "TOPLEFT", 12, -12)
      content:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", -12, 12)
    end
    -- Do not re-anchor children; let AceGUI position TabGroup within content
    if not container.WOWTR_BannerHooked and container.HookScript then
      container.WOWTR_BannerHooked = true
      container:HookScript("OnShow", function(f)
        local c = f.content
        if c and c.ClearAllPoints then
          c:ClearAllPoints()
          c:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -12)
          c:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -12, 12)
        end
      end)
      container:HookScript("OnSizeChanged", function(f)
        local c = f.content
        if c and c.ClearAllPoints then
          c:ClearAllPoints()
          c:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -12)
          c:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -12, 12)
        end
      end)
    end
  end
  local function wrap(methodName)
    local orig = AceConfigDialog[methodName]
    if type(orig) ~= "function" then return end
    AceConfigDialog[methodName] = function(self, appName, ...)
      local ret = orig(self, appName, ...)
      if WoWTR_Localization and WoWTR_Localization.lang == 'AR' and WOWTR_Font2 and self.OpenFrames and self.OpenFrames[appName] and self.OpenFrames[appName].frame then
        ApplyFontsRecursive(self.OpenFrames[appName].frame)
      end
      if self.OpenFrames and self.OpenFrames[appName] and self.OpenFrames[appName].frame then
        local frameRef = self.OpenFrames[appName].frame
        AttachConfigBanner(frameRef)
        FixTitleWidth(frameRef)
        -- push content down by banner height so tabs do not overlap the image
        local banner = frameRef and frameRef.WOWTR_Banner
        local content = frameRef and frameRef.content
        local bh = banner and banner.GetHeight and tonumber(banner:GetHeight()) or 96
        local topPad = bh
        if content and content.ClearAllPoints then
          content:ClearAllPoints()
          content:SetPoint("TOPLEFT", frameRef, "TOPLEFT", 12, -topPad)
          content:SetPoint("BOTTOMRIGHT", frameRef, "BOTTOMRIGHT", -12, 12)
        end
        NudgeTabGroupDown(frameRef, topPad)
        EnsureTopRightClose(frameRef, appName)
        -- no periodic nudge; anchors are applied immediately in this wrapper
      end
      return ret
    end
  end
  wrap("Open")
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

local function GetOptionTitle()
  return QTR_ReverseIfAR(WoWTR_Localization and WoWTR_Localization.optionTitle or "WoWLang")
end

local function BuildOptions()
  local options = {
    type = "group",
    childGroups = "tab",
    name = GetOptionTitle(),
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
    -- Initialize debug system after database is ready
    if WOWTR and WOWTR.Debug and WOWTR.Debug.Initialize then
      WOWTR.Debug.Initialize()
    end
  end
  if AceConfig and AceConfigDialog then
    AceConfig:RegisterOptionsTable("WOWTR", BuildOptions())
    AceConfigDialog:AddToBlizOptions("WOWTR", GetOptionTitle())
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

