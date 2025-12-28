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

  if WOWTR and WOWTR.LegacyBridge and WOWTR.LegacyBridge.SyncLegacyFromProfile then
    WOWTR.LegacyBridge.SyncLegacyFromProfile(p)
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
  if WOWTR and WOWTR.LegacyBridge and WOWTR.LegacyBridge.MigrateLegacyToProfile then
    WOWTR.LegacyBridge.MigrateLegacyToProfile(p)
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
local ChromeHooked = false
local function HookAceConfigDialogChrome()
  if ChromeHooked then return end
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

  local function AfterOpen(self, appName, container, ...)
    -- Only apply extra chrome changes to our standalone AceConfig frame (OpenFrames).
    if not (self and self.OpenFrames and self.OpenFrames[appName] and self.OpenFrames[appName].frame) then return end
    if appName ~= "WOWTR" then return end

    local openFrame = self.OpenFrames[appName].frame
    AttachConfigBanner(openFrame)
    FixTitleWidth(openFrame)
    -- push content down by banner height so tabs do not overlap the image
    local banner = openFrame and openFrame.WOWTR_Banner
    local content = openFrame and openFrame.content
    local bh = banner and banner.GetHeight and tonumber(banner:GetHeight()) or 96
    local topPad = bh
    if content and content.ClearAllPoints then
      content:ClearAllPoints()
      content:SetPoint("TOPLEFT", openFrame, "TOPLEFT", 12, -topPad)
      content:SetPoint("BOTTOMRIGHT", openFrame, "BOTTOMRIGHT", -12, 12)
    end
    NudgeTabGroupDown(openFrame, topPad)
    EnsureTopRightClose(openFrame, appName)
  end

  if hooksecurefunc then
    hooksecurefunc(AceConfigDialog, "Open", AfterOpen)
  else
    -- Fallback: wrap Open (unlikely in WoW)
    local orig = AceConfigDialog.Open
    AceConfigDialog.Open = function(self, appName, container, ...)
      local ret = orig(self, appName, container, ...)
      pcall(AfterOpen, self, appName, container, ...)
      return ret
    end
  end

  ChromeHooked = true
end

-- Hook tooltip frames to use WOWTR_Font2 for Arabic
local TooltipsHooked = false
-- Cache to track processed frames and prevent excessive processing
local processedFrames = {}
local function ApplyTooltipFonts(tt)
  if not tt or not tt.GetRegions then return end
  if not (WoWTR_Localization and WoWTR_Localization.lang == 'AR' and WOWTR_Font2) then return end
  
  -- Helper function to get original WoW font
  local function GetOriginalWoWFont()
    if _G.ST_GetOriginalWoWFont then
      return _G.ST_GetOriginalWoWFont()
    end
    -- Fallback to default WoW font
    return "Fonts\\FRIZQT__.TTF", 12, ""
  end
  
  -- Count processed FontStrings for debugging
  local checkedCount = 0      -- Total FontStrings checked
  local processedCount = 0   -- FontStrings that had fonts changed
  local translationCount = 0 -- FontStrings with translations
  local restoreCount = 0     -- FontStrings restored to original font
  local skippedCount = 0     -- FontStrings skipped (empty or cached)
  
  local function setFS(fs)
    if not fs or not fs.SetFont then return end
    local ok, currentFont, size, flags = pcall(fs.GetFont, fs)
    if not ok or not size then size = 13 end
    local f = type(flags) == "string" and flags or ""
    local frameName = fs.GetName and fs:GetName() or "unknown"
    local textOk, textResult = pcall(function() 
      if fs.GetText then
        return fs:GetText()
      end
      return nil
    end)
    
    -- Count all FontStrings checked
    checkedCount = checkedCount + 1
    
    -- Test if we can actually use the text value (secret values fail here)
    local text = nil
    if textOk and textResult ~= nil then
      -- Try to use the value as a string - secret values will fail this test
      -- We test the actual operations we'll need: comparison and length
      local canUse, usableText = pcall(function()
        -- Test comparison (secret values fail here)
        local isEmpty = (textResult == "")
        -- Test length (secret values fail here)  
        local len = string.len(textResult)
        -- If we got here, the value is usable - return it
        return textResult
      end)
      
      if canUse and usableText ~= nil then
        -- Double-check it's actually a string type
        if type(usableText) == "string" then
          text = usableText
        else
          -- Not a string type - skip
          skippedCount = skippedCount + 1
          return
        end
      else
        -- Secret value detected - skip this frame
        skippedCount = skippedCount + 1
        return
      end
    end
    
    -- Skip empty frames
    if not text or text == "" then
      skippedCount = skippedCount + 1
      return
    end
    
    -- Check if text already has NONBREAKINGSPACE (processed marker)
    local isProcessed = string.find(text, NONBREAKINGSPACE) ~= nil
    
    -- Create cache key for this frame+text combination
    local cacheKey = frameName .. "|" .. text
    local cached = processedFrames[cacheKey]
    
    -- If cached and font is already correct, skip
    if cached and cached.font == currentFont then
      skippedCount = skippedCount + 1
      return
    end
    
    -- Check if text has a translation in hash table
    local hasTranslation = false
    local translationReason = ""
    local hash = nil
    
    if text and text ~= "" and _G.StringHash and _G.ST_UsunZbedneZnaki then
      -- Remove NONBREAKINGSPACE for hash lookup (it's just a processing marker)
      local textForHash = string.gsub(text, NONBREAKINGSPACE, "")
      hash = StringHash(ST_UsunZbedneZnaki(textForHash))
      local hs = rawget(_G, "ST_TooltipsHS")
      if hs and hs[hash] then
        hasTranslation = true
        translationReason = "Hash:" .. tostring(hash)
      end
    end
    
    -- Special case: If text has NONBREAKINGSPACE and font is already WOWTR_Font2,
    -- keep it as WOWTR_Font2 (it was already translated, don't restore)
    -- This prevents restoring font when checking translated Arabic text
    if isProcessed and currentFont == _G.WOWTR_Font2 and not hasTranslation then
      -- Text is processed but hash check failed (likely translated text being re-checked)
      -- Keep WOWTR_Font2 if it's already set
      hasTranslation = true
      translationReason = "Processed with WOWTR_Font2 (keep)"
    end
    
    -- NONBREAKINGSPACE alone is NOT enough to mark as translated
    -- We need either a hash translation OR the font is already WOWTR_Font2 with NONBREAKINGSPACE
    
    -- Determine target font
    local targetFont, targetSize, targetFlags
    if hasTranslation then
      targetFont, targetSize, targetFlags = WOWTR_Font2, size, f
    else
      targetFont, targetSize, targetFlags = GetOriginalWoWFont()
      targetSize = targetSize or size
      targetFlags = targetFlags or f
    end
    
    -- Only process if font needs to change or if not cached
    local fontNeedsChange = (currentFont ~= targetFont) or 
                           (currentFont == WOWTR_Font2 and not hasTranslation) or
                           (currentFont ~= WOWTR_Font2 and hasTranslation)
    
    if fontNeedsChange or not cached then
      -- Only restore if current font is WOWTR_Font2 and no translation, or if translation exists and font is not WOWTR_Font2
      if (not hasTranslation and (currentFont == WOWTR_Font2 or (type(currentFont) == "string" and (string.find(currentFont, "WoWAR") or string.find(currentFont, "WOWTR"))))) or
         (hasTranslation and currentFont ~= WOWTR_Font2) then
        pcall(fs.SetFont, fs, targetFont, targetSize, targetFlags)
        
        -- If translation found and text doesn't already have NONBREAKINGSPACE, translate the text
        -- NOTE: GT.OnShow() handles most translations, so ApplyTooltipFonts should only translate
        -- if GT.OnShow() hasn't already done it (i.e., text doesn't have NONBREAKINGSPACE yet)
        if hasTranslation and hash and not string.find(text, NONBREAKINGSPACE) then
          local hs = rawget(_G, "ST_TooltipsHS")
          if hs and hs[hash] and fs.SetText then
            local ST_tlumaczenie = hs[hash]
            -- Use ST_TranslatePrepare if available
            if _G.ST_TranslatePrepare then
              ST_tlumaczenie = ST_TranslatePrepare(text, ST_tlumaczenie)
            end
            -- For short text (like "Back", "Chest", etc.), use simple RTL reverse instead of QTR_ExpandUnitInfo
            -- QTR_ExpandUnitInfo does line-breaking/shaping that can truncate short labels
            local isShortText = text and string.len(text) <= 15
            local translatedText
            if isShortText and _G.QTR_ReverseIfAR then
              -- Use simple RTL reverse for short labels to avoid truncation
              translatedText = QTR_ReverseIfAR(ST_tlumaczenie) .. NONBREAKINGSPACE
              -- Debug: Log the translation attempt
              if WOWTR and WOWTR.Debug and WOWTR.Debug.Normal then
                WOWTR.Debug.Normal(WOWTR.Debug.Categories.TOOLTIPS,
                  "[ApplyTooltipFonts] Translating text (short, using QTR_ReverseIfAR)",
                  "| Frame:", frameName,
                  "| Original:", string.sub(text or "", 1, 50),
                  "| Translation:", string.sub(ST_tlumaczenie or "", 1, 50),
                  "| Result:", string.sub(translatedText or "", 1, 50))
              end
            elseif _G.QTR_ExpandUnitInfo then
              -- Use QTR_ExpandUnitInfo for longer text
              translatedText = QTR_ExpandUnitInfo(ST_tlumaczenie, false, fs, WOWTR_Font2, -5) .. NONBREAKINGSPACE
              -- Debug: Log the translation attempt
              if WOWTR and WOWTR.Debug and WOWTR.Debug.Normal then
                WOWTR.Debug.Normal(WOWTR.Debug.Categories.TOOLTIPS,
                  "[ApplyTooltipFonts] Translating text",
                  "| Frame:", frameName,
                  "| Original:", string.sub(text or "", 1, 50),
                  "| Translation:", string.sub(ST_tlumaczenie or "", 1, 50),
                  "| Expanded:", string.sub(translatedText or "", 1, 50))
              end
            else
              translatedText = ST_tlumaczenie .. NONBREAKINGSPACE
            end
            pcall(fs.SetText, fs, translatedText)
          end
        end
        
        -- Debug: Log font changes (only when actually changing)
        if WOWTR and WOWTR.Debug and WOWTR.Debug.Normal then
          local afterFont, afterSize, afterFlags = fs:GetFont()
          local afterText = fs.GetText and fs:GetText() or text
          local setSuccess = (afterFont == targetFont) and (math.abs((afterSize or 0) - (targetSize or 0)) < 0.1)
          
          if hasTranslation then
            WOWTR.Debug.Normal(WOWTR.Debug.Categories.TOOLTIPS,
              "[ApplyTooltipFonts] Translation found, setting WOWTR_Font2",
              "| Frame:", frameName,
              "| Reason:", translationReason,
              "| Hash:", hash or "nil",
              "| Before Font:", currentFont or "nil",
              "| After Font:", afterFont or "nil",
              "| SetFont Success:", setSuccess and "YES" or "NO",
              "| Before Text:", string.sub(text or "", 1, 50) .. (string.len(text or "") > 50 and "..." or ""),
              "| After Text:", string.sub(afterText or "", 1, 50) .. (string.len(afterText or "") > 50 and "..." or ""))
          else
            WOWTR.Debug.Normal(WOWTR.Debug.Categories.TOOLTIPS,
              "[ApplyTooltipFonts] No translation, restoring original font",
              "| Frame:", frameName,
              "| Hash:", hash or "nil",
              "| Before Font:", currentFont or "nil",
              "| Restored Font:", targetFont or "nil",
              "| After Font:", afterFont or "nil",
              "| SetFont Success:", setSuccess and "YES" or "NO",
              "| Text:", string.sub(text or "", 1, 50) .. (string.len(text or "") > 50 and "..." or ""))
          end
        end
        
        -- Cache this frame+text combination
        processedFrames[cacheKey] = {
          font = targetFont,
          hasTranslation = hasTranslation,
          time = GetTime()
        }
        
        -- Increment counters for summary
        processedCount = processedCount + 1
        if hasTranslation then
          translationCount = translationCount + 1
        else
          restoreCount = restoreCount + 1
        end
      end
    end
  end

  local regions = { tt:GetRegions() }
  for _, r in pairs(regions) do
    if r and r.GetObjectType and r:GetObjectType() == "FontString" then
      local oldCount = processedCount
      setFS(r)
      if processedCount > oldCount then
        -- Count was incremented in setFS
      end
    end
  end

  local name = tt.GetName and tt:GetName() or nil
  if name then
    for i = 1, 40 do
      setFS(_G[name .. "TextLeft" .. i])
      setFS(_G[name .. "TextRight" .. i])
    end
  end
  
  -- Debug: Log summary only when fonts are actually changed (to reduce spam)
  if processedCount > 0 and WOWTR and WOWTR.Debug and WOWTR.Debug.Normal then
    local tooltipName = name or (tt.GetName and tt:GetName()) or "unknown"
    WOWTR.Debug.Normal(WOWTR.Debug.Categories.TOOLTIPS,
      "[ApplyTooltipFonts] Summary",
      "| Tooltip:", tooltipName,
      "| Checked FontStrings:", checkedCount,
      "| Changed Fonts:", processedCount,
      "| With Translation:", translationCount,
      "| Restored:", restoreCount,
      "| Skipped (empty/cached):", skippedCount)
  end
end

local function HookTooltipFonts()
  if TooltipsHooked then return end
  -- Ensure base tooltip FontObjects use WOWTR_Font2
  -- NOTE: These FontObjects are templates - new tooltip lines inherit from them
  -- They are ALWAYS set to WOWTR_Font2 (not conditional on translations)
  -- Individual FontStrings are then checked and restored if no translation exists
  if WoWTR_Localization and WoWTR_Localization.lang == 'AR' and WOWTR_Font2 then
    local function SetFO(obj, objName)
      if not obj then return end
      local ok, currentFont, size, flags = pcall(obj.GetFont, obj)
      if not ok or not size then size = 13 end
      local f = type(flags) == "string" and flags or ""
      pcall(obj.SetFont, obj, WOWTR_Font2, size, f)
      
      -- Debug: Log FontObject changes
      if WOWTR and WOWTR.Debug and WOWTR.Debug.Normal then
        WOWTR.Debug.Normal(WOWTR.Debug.Categories.TOOLTIPS,
          "[HookTooltipFonts] Setting FontObject template",
          "| FontObject:", objName or "unknown",
          "| Before Font:", currentFont or "nil",
          "| Set to: WOWTR_Font2",
          "| Size:", size or "nil",
          "| Note: This is a template - individual FontStrings are checked separately")
      end
    end
    SetFO(_G.GameTooltipHeaderText, "GameTooltipHeaderText")
    SetFO(_G.GameTooltipText, "GameTooltipText")
    SetFO(_G.GameTooltipTextSmall, "GameTooltipTextSmall")
    SetFO(_G.Tooltip_Med, "Tooltip_Med")
    SetFO(_G.Tooltip_Small, "Tooltip_Small")
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
      -- Clear cache when tooltip is hidden
      if tt:HasScript("OnHide") then
        tt:HookScript("OnHide", function()
          -- Clear cache for this tooltip's frames
          local ttName = tt:GetName()
          if ttName then
            for key, _ in pairs(processedFrames) do
              if string.find(key, "^" .. ttName) then
                processedFrames[key] = nil
              end
            end
          end
        end)
      end
      -- Throttle OnUpdate to prevent excessive calls (only run every 0.1 seconds)
      if tt:HasScript("OnUpdate") then
        local lastUpdate = 0
        tt:HookScript("OnUpdate", function(self, elapsed)
          if self:IsShown() then
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= 0.1 then
              ApplyTooltipFonts(self)
              lastUpdate = 0
            end
          else
            lastUpdate = 0
          end
        end)
      end
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
  if WOWTR and WOWTR.Fonts then
    WOWTR.Fonts.HookAceConfigDialog("WOWTR")
    WOWTR.Fonts.HookBlizzardAddOnsList()
    WOWTR.Fonts.HookDropdownLists()
  end
  HookAceConfigDialogChrome()
  HookTooltipFonts()
end

function C.Open()
  if AceConfigDialog then
    AceConfigDialog:Open("WOWTR")
  elseif Settings and WOWTR and WOWTR.CategoryID then
    Settings.OpenToCategory(WOWTR.CategoryID)
  end
end

