-- WoW_Quests_Gossip.lua
-- Gossip toggle handlers (modularized)

local addonName, ns = ...
ns = ns or {}
ns.Quests = ns.Quests or {}
local Quests = ns.Quests

Quests.Gossip = Quests.Gossip or {}

local function isRTL()
   return (Quests.Utils and Quests.Utils.IsRTL and Quests.Utils.IsRTL()) or false
end

-- Store original fonts so we can restore when switching back to EN
local OriginalGossipFonts = setmetatable({}, { __mode = "k" })
local function RememberFont(fs)
   if fs and fs.GetFont and not OriginalGossipFonts[fs] then
      local font, size, flags = fs:GetFont()
      OriginalGossipFonts[fs] = { font = font, size = size, flags = flags }
   end
end

local function RestoreOriginalFont(fs)
   if not fs then return end
   local o = OriginalGossipFonts[fs]
   if o and o.font then fs:SetFont(o.font, o.size, o.flags) end
end

local function ApplyFontToGossipScrollTarget()
   local size = tonumber(QTR_PS and QTR_PS["fontsize"] or 13)
   local fontPath = WOWTR_Font2
   local target = GossipFrame and GossipFrame.GreetingPanel and GossipFrame.GreetingPanel.ScrollBox and GossipFrame.GreetingPanel.ScrollBox.ScrollTarget
   if not (target and fontPath and size) then return end
   local function setFonts(frame)
      if not (frame and frame.GetRegions) then return end
      local regions = { frame:GetRegions() }
      for _, region in pairs(regions) do
         if region and region.GetObjectType and region:GetObjectType() == "FontString" then
            RememberFont(region)
            region:SetFont(fontPath, size)
         end
      end
   end
   setFonts(target)
   local children = { target:GetChildren() }
   for _, child in ipairs(children) do setFonts(child) end
end

local function RestoreFontInGossipScrollTarget()
   local target = GossipFrame and GossipFrame.GreetingPanel and GossipFrame.GreetingPanel.ScrollBox and GossipFrame.GreetingPanel.ScrollBox.ScrollTarget
   if not target then return end
   local function restoreFonts(frame)
      if not (frame and frame.GetRegions) then return end
      local regions = { frame:GetRegions() }
      for _, region in pairs(regions) do
         if region and region.GetObjectType and region:GetObjectType() == "FontString" then
            RestoreOriginalFont(region)
         end
      end
   end
   restoreFonts(target)
   local children = { target:GetChildren() }
   for _, child in ipairs(children) do restoreFonts(child) end
end

function Quests.Gossip.ToggleNPCGossip()
   if (QTR_curr_goss=="1") then         -- turn off translation, show original
      QTR_curr_goss="0"
      if GossipGreetingText and QTR_GS then
         GossipGreetingText:SetText(QTR_GS[QTR_curr_hash])
         GossipGreetingText:SetJustifyH("LEFT")
         local size = tonumber(QTR_PS and QTR_PS["fontsize"] or 13)
         if WOWTR_Font2 then GossipGreetingText:SetFont(WOWTR_Font2, size) end
      end
      if QTR_ToggleButtonGS1 then
         QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." EN")
      end
      if (QTR_goss_optionsEN) then
         for k, v in pairs(QTR_goss_optionsEN) do
            if k and k.SetText then
               k:SetText(v)
               if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then Quests.Utils.ApplyOptionButtonLayout(k, false) end
               local fr = Quests.Utils and Quests.Utils.GetFirstFontStringRegion and Quests.Utils.GetFirstFontStringRegion(k)
               if fr and WOWTR_Font2 and QTR_PS then fr:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"])) end
               if k.Resize then k:Resize() end
            end
         end
      end
      -- Also restore any ScrollBox choice strings we cached
      if QTR_goss_optionsEN then
         for frame, original in pairs(QTR_goss_optionsEN) do
            if frame and frame.SetText then frame:SetText(original or "") end
            if frame and frame.Resize then frame:Resize() end
         end
      end
      RestoreFontInGossipScrollTarget()
   else                                   -- show translation
      QTR_curr_goss="1"
      local Greeting_TR = GS_Gossip and GS_Gossip[QTR_curr_hash]
      if (string.sub((Nazwa_NPC or ""),1,17) == "Bronze Timekeeper") then
         if Quests.Utils and Quests.Utils.FormatBronzeTimekeeper then
            Greeting_TR = Quests.Utils.FormatBronzeTimekeeper(QTR_GS[QTR_curr_hash], Greeting_TR)
         end
      end
      if GossipGreetingText and Quests.Utils and Quests.Utils.ApplyRTLText then
         Quests.Utils.ApplyRTLText(GossipGreetingText, (Greeting_TR or "") .. NONBREAKINGSPACE, WOWTR_Font2, tonumber(QTR_PS and QTR_PS["fontsize"] or 13), -5, "LEFT")
      end
      if QTR_ToggleButtonGS1 then
         QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." "..WoWTR_Localization.lang)
      end
      if (QTR_goss_optionsTR) then
         for k, v in pairs(QTR_goss_optionsTR) do
            if k and k.SetText then
               k:SetText(v)
               if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then Quests.Utils.ApplyOptionButtonLayout(k, isRTL()) end
               local fr = Quests.Utils and Quests.Utils.GetFirstFontStringRegion and Quests.Utils.GetFirstFontStringRegion(k)
               if fr and WOWTR_Font2 and QTR_PS then fr:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"])) end
               if k.Resize then k:Resize() end
            end
         end
      end
      -- Ensure fonts applied for pooled children after this toggle
      ApplyFontToGossipScrollTarget()
      StartDelayedFunction(ApplyFontToGossipScrollTarget, 0.02)
      StartDelayedFunction(ApplyFontToGossipScrollTarget, 0.10)
   end
end

function Quests.Gossip.ToggleQuestFrame()
   if (QTR_curr_goss=="1") then         -- switch to English (LTR)
      if QTR_display_constants then QTR_display_constants(0) end
      QTR_curr_goss="0"
      if GreetingText then
         GreetingText:SetText(QTR_GS[QTR_curr_hash] or "")
         GreetingText:SetJustifyH("LEFT")
         RestoreOriginalFont(GreetingText)
      end
      if QTR_ToggleButton0 then
         QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." EN")
      end
      -- Restore options to English LTR layout
      if (QTR_goss_optionsEN) then
         for k, v in pairs(QTR_goss_optionsEN) do
            if k and k.SetText then
               k:SetText(v or "")
               if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then Quests.Utils.ApplyOptionButtonLayout(k, false) end
               local fr = Quests.Utils and Quests.Utils.GetFirstFontStringRegion and Quests.Utils.GetFirstFontStringRegion(k)
               if fr then RestoreOriginalFont(fr) end
               if k.Resize then k:Resize() end
            end
         end
      end
      RestoreFontInGossipScrollTarget()
   else                                   -- switch to translated (potentially RTL)
      if QTR_display_constants then QTR_display_constants(1) end
      QTR_curr_goss="1"
      local Greeting_TR = (GS_Gossip and GS_Gossip[QTR_curr_hash]) or (QTR_GS[QTR_curr_hash] or "")
      if (string.sub((Nazwa_NPC or ""),1,17) == "Bronze Timekeeper") then
         if Quests.Utils and Quests.Utils.FormatBronzeTimekeeper then
            Greeting_TR = Quests.Utils.FormatBronzeTimekeeper(QTR_GS[QTR_curr_hash], Greeting_TR)
         end
      end
      if GreetingText and Quests.Utils and Quests.Utils.ApplyRTLText then
         RememberFont(GreetingText)
         Quests.Utils.ApplyRTLText(GreetingText, (Greeting_TR or "") .. NONBREAKINGSPACE, WOWTR_Font2, tonumber(QTR_PS and QTR_PS["fontsize"] or 13), -5, "LEFT")
      end
      if QTR_ToggleButton0 then
         QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." "..WoWTR_Localization.lang)
      end
      if (QTR_goss_optionsTR) then
         for k, v in pairs(QTR_goss_optionsTR) do
            if k and k.SetText then
               k:SetText(v or "")
               local fontStringRegion = Quests.Utils and Quests.Utils.GetFirstFontStringRegion and Quests.Utils.GetFirstFontStringRegion(k)
               if fontStringRegion and WOWTR_Font2 and QTR_PS then
                  RememberFont(fontStringRegion)
                  fontStringRegion:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"]))
               end
               if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then Quests.Utils.ApplyOptionButtonLayout(k, isRTL()) end
               if k.Resize then k:Resize() end
            end
         end
      end
   end
end

-- Show gossip on Blizzard GossipFrame, handling translations and options
function Quests.Gossip.Show()
   -- print("QTR_Gossip_Show")
   local Nazwa_NPC -- forward declare so ProcessOPT captures the local
   local function ProcessOPT(buttonString)
      local fontString = buttonString.Content.Name
      local GOptionText = WOWTR_DetectAndReplacePlayerName(fontString:GetText())
      local prefix, sufix = "", ""
      table.insert(Gossip2DUI_EN, fontString:GetText())
      local _font1, _size1 = fontString:GetFont()
      fontString:SetFont(WOWTR_Font2, _size1)
      if (string.sub(GOptionText,1,2) == "|c") then
         prefix = string.sub(GOptionText, 1, 10)
         sufix = "|r"
         GOptionText = string.gsub(GOptionText, prefix, "")
         GOptionText = string.gsub(GOptionText, sufix, "")
      end
      if (string.sub(GOptionText,2,2)==".") then
         GOptionText = string.sub(GOptionText,4)
      end
      local OptHash = StringHash(GOptionText)
      if (GS_Gossip[OptHash]) then
         local transLN = prefix .. QTR_ExpandUnitInfo(GS_Gossip[OptHash], false, fontString, WOWTR_Font2, -40) .. sufix .. NONBREAKINGSPACE
         fontString:SetText(transLN)
      else
         -- Save missing DUI/Immersion option if saving is enabled
         if (QTR_PS and QTR_PS["saveGS"] == "1") then
            local orig = WOWTR_DetectAndReplacePlayerName(fontString:GetText())
            orig = string.gsub(orig, '"', '\\"')
            orig = WOWTR_StripUEColorMarker(orig)
            local mapId = C_Map.GetBestMapForUnit("player") or 0
            QTR_GOSSIP[(Nazwa_NPC or "Unknown").."@"..tostring(OptHash).."@"..tostring(mapId)] = orig.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class
         end
      end
      table.insert(Gossip2DUI_LN, fontString:GetText())
   end

   if QTR_IconAI then QTR_IconAI:Hide() end
   if GoQ_IconAI then GoQ_IconAI:Hide() end
   Nazwa_NPC = GossipFrameTitleText and GossipFrameTitleText:GetText() or nil
   if (isImmersion and isImmersion()) then
      if (not Nazwa_NPC) then
         Nazwa_NPC = ImmersionFrame.TalkBox.NameFrame.Name:GetText()
      end
      if QTR_ToggleButton4 then
         QTR_ToggleButton4:SetText(QTR_ReverseIfAR(WoWTR_Localization.gossipText))
         QTR_ToggleButton4:Disable()
      end
   elseif (isStoryline and isStoryline()) then
      if (not Nazwa_NPC) then
         Nazwa_NPC = Storyline_NPCFrameChatName:GetText()
      end
      if QTR_ToggleButton5 then
         QTR_ToggleButton5:SetText(QTR_ReverseIfAR(WoWTR_Localization.gossipText))
      end
   end
   if (not Nazwa_NPC) then Nazwa_NPC = UnitName("target") end
   QTR_curr_hash = 0
   local QTR_first_ok = false
   if (Nazwa_NPC) then
      local GossipTextFrame
      local Greeting_Text = C_GossipInfo:GetText()
      local GO_resized = 0
      QTR_goss_optionsEN = {}
      QTR_goss_optionsTR = {}
      for _, GTxtframe in GossipFrame.GreetingPanel.ScrollBox:EnumerateFrames() do
         if (GTxtframe.GreetingText) then GossipTextFrame = GTxtframe end
      end

      -- Ensure fonts are applied across all ScrollTarget descendants (freshly pooled widgets)
      ApplyFontToGossipScrollTarget()
      StartDelayedFunction(ApplyFontToGossipScrollTarget, 0.02)
      StartDelayedFunction(ApplyFontToGossipScrollTarget, 0.10)

      if (Greeting_Text and (string.find(Greeting_Text, NONBREAKINGSPACE) == nil)) then
         Nazwa_NPC = string.gsub(Nazwa_NPC, '"', '\\"')
         local Origin_Text = WOWTR_DetectAndReplacePlayerName(Greeting_Text)
         local Czysty_Text = WOWTR_NormalizeForHash(Origin_Text)
         if (string.sub(Nazwa_NPC,1,17) == "Bronze Timekeeper") then
            Czysty_Text = (Czysty_Text or ""):gsub("%d", "")
         end
         local Hash = StringHash(Czysty_Text)
         QTR_curr_hash = Hash
         QTR_GS[Hash] = Greeting_Text
         if (GS_Gossip[Hash] == nil) then
            Origin_Text = string.gsub(Origin_Text, ' (low level)', '')
            Czysty_Text = string.gsub(Czysty_Text, ' (low level)', '')
            Hash = StringHash(Czysty_Text)
            QTR_curr_hash = Hash
         end

         if (GS_Gossip[Hash]) then
            local Greeting_TR = GS_Gossip[Hash]
            if (string.sub(Nazwa_NPC,1,17) == "Bronze Timekeeper") then
               Greeting_TR = Quests.Utils and Quests.Utils.FormatBronzeTimekeeper and Quests.Utils.FormatBronzeTimekeeper(Greeting_Text, Greeting_TR) or Greeting_TR
            end
            if (GossipTextFrame) then
               if QTR_ToggleButtonGS1 then
                  QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(Hash).." "..WoWTR_Localization.lang)
                  QTR_ToggleButtonGS1:Enable()
               end
               GossipGreetingText = GossipTextFrame.GreetingText
               local GO_height = GossipGreetingText:GetHeight()
               local isRTL = Quests.Utils and Quests.Utils.IsRTL and Quests.Utils.IsRTL() or false
               if (isRTL and Quests.Utils and Quests.Utils.ApplyRTLText) then
                  Quests.Utils.ApplyRTLText(GossipGreetingText, Greeting_TR .. NONBREAKINGSPACE, WOWTR_Font2, tonumber(QTR_PS and QTR_PS["fontsize"] or 13), -5, "LEFT")
               else
                  GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR..NONBREAKINGSPACE,false,GossipGreetingText,WOWTR_Font2))
                  if ns and ns.RTL and ns.RTL.JustifyFontString then ns.RTL.JustifyFontString(GossipGreetingText, "LEFT") end
                  GossipGreetingText:SetFont(WOWTR_Font2, tonumber(QTR_PS and QTR_PS["fontsize"] or 13))
               end
               QTR_curr_goss = "1"
               if (GossipGreetingText:GetHeight() > GO_height+1) then
                  GO_resized = GO_resized + GossipGreetingText:GetHeight() - GO_height
               end
               if (GS_AI and GS_AI[Hash] and QTR_IconAI) then
                  QTR_IconAI:Show()
               end
            end
            if (isImmersion and isImmersion()) then
               ImmersionFrame.TalkBox.TextFrame.Text:SetFont(WOWTR_Font2, 14)
               ImmersionFrame.TalkBox.TextFrame.Text:SetText(QTR_ExpandUnitInfo(Greeting_TR,false,ImmersionFrame.TalkBox.TextFrame.Text,WOWTR_Font2))
            elseif (isStoryline and isStoryline()) then
               if (Storyline_NPCFrameChat.texts == nil) then
                  C_Timer.After(1.0, function() txt0txt = QTR_ExpandUnitInfo(Greeting_TR,false,Storyline_NPCFrameChat.texts[0],WOWTR_Font2); QTR_Storyline_Gossip(); end)
               else
                  txt0txt = QTR_ExpandUnitInfo(Greeting_TR,false,Storyline_NPCFrameChat.texts[0],WOWTR_Font2)
                  if (not WOWTR_wait(1.0, QTR_Storyline_Gossip)) then end
               end
            end
            if (IsDUIQuestFrame and IsDUIQuestFrame()) then
               if QTR_ToggleButton6 then
                  QTR_ToggleButton6:SetText("Gossip-Hash="..tostring(Hash).." ("..WoWTR_Localization.lang..")")
                  QTR_ToggleButton6:Enable()
               end
               if QTR_DUIGossipFrame then QTR_DUIGossipFrame() end
            end
            if (QTR_PS and QTR_PS["en_first"] == "1") then
               QTR_first_ok = true
            end
         else
            if QTR_ToggleButtonGS1 then
               QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(Hash).." (EN)")
               QTR_ToggleButtonGS1:Disable()
            end
            if (IsDUIQuestFrame and IsDUIQuestFrame()) then
               if QTR_ToggleButton6 then
                  QTR_ToggleButton6:SetText("Gossip-Hash="..tostring(Hash).." (EN)")
                  QTR_ToggleButton6:Show(); QTR_ToggleButton6:Disable()
               end
               if QTR_ToggleButton7 then QTR_ToggleButton7:Hide() end
               if (TT_PS and TT_PS["ui1"] == "1") then
                  if QTR_DUIbuttons then QTR_DUIbuttons() end
                  DUIQuestFrame.optionButtonPool:ProcessActiveObjects(ProcessOPT)
               end
            end
            if (QTR_PS and QTR_PS["saveGS"] == "1") then
               Origin_Text = string.gsub(Origin_Text, '"', '\\"')
               Origin_Text = WOWTR_StripUEColorMarker(Origin_Text)
               local map = C_Map.GetBestMapForUnit("player") or 0
               QTR_GOSSIP[Nazwa_NPC.."@"..tostring(Hash).."@"..tostring(map)] = Origin_Text.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class
            end
         end
      end

      for _, GTxtframe in GossipFrame.GreetingPanel.ScrollBox:EnumerateFrames() do
         local GTtype = GTxtframe.GetElementData and GTxtframe.GetElementData().buttonType
         if (GTxtframe.GreetingText) then
            GossipTextFrame = GTxtframe
         else
            -- Try to read option text from the button or its first FontString region
            local rawText = (GTxtframe.GetText and GTxtframe:GetText()) or nil
            if (not rawText) and GTxtframe.GetRegions then
               local regions = { GTxtframe:GetRegions() }
               for _, r in pairs(regions) do
                  if r and r.GetObjectType and r:GetObjectType() == "FontString" and r.GetText then rawText = r:GetText(); break end
               end
            end
            if (rawText and (QTR_PS["gossip"]=="1") and (string.find(rawText,NONBREAKINGSPACE)==nil)) then
               local GOptionText = WOWTR_DetectAndReplacePlayerName(rawText, nil, '$N')
               local prefix, sufix = "", ""
               -- Strip both |cXXXXXXXX and |cnNAME: wrappers for hashing, preserve for display
               if (string.sub(GOptionText,1,2) == "|c") or (string.sub(GOptionText,1,3) == "|cn") then
                  local stripped = WOWTR_StripWoWColors(GOptionText)
                  -- Try to capture visible prefix/suffix for rendering if desired
                  if (string.sub(GOptionText,1,2) == "|c") then
                     prefix = string.sub(GOptionText, 1, 10); sufix = "|r"
                  elseif (string.sub(GOptionText,1,3) == "|cn") then
                     local start = string.match(GOptionText, "^(|cn[%w_]+:)")
                     if start then prefix = start; sufix = "|r" end
                  end
                  GOptionText = stripped
               end
               local Czysty_Text = WOWTR_DeleteSpecialCodes(GOptionText, '$N')
               local OptHash = StringHash(Czysty_Text)
               local transTR
               if (GS_Gossip[OptHash]) then
                  local fontStringRegion = Quests.Utils and Quests.Utils.GetFirstFontStringRegion and Quests.Utils.GetFirstFontStringRegion(GTxtframe)
                  local clean = QTR_ExpandUnitInfo(GS_Gossip[OptHash], false, fontStringRegion or GTxtframe, WOWTR_Font2, -40)
                  transTR = prefix .. clean .. sufix .. NONBREAKINGSPACE
               end
               if transTR then
                  local GO_height = GTxtframe:GetHeight()
                  -- Cache original and translated texts for toggling
                  QTR_goss_optionsEN[GTxtframe] = GTxtframe:GetText()
                  QTR_goss_optionsTR[GTxtframe] = transTR
                  GTxtframe:SetText(transTR)
                  if GTxtframe.Resize then GTxtframe:Resize() end
                  if (GossipTextFrame and GO_resized > 0) then
                     local point, relativeTo, relativePoint, xOfs, yOfs = GTxtframe:GetPoint(1)
                     GTxtframe:ClearAllPoints()
                     GTxtframe:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-GO_resized)
                  end
                  if (GTxtframe:GetHeight() > GO_height+1) then
                     GO_resized = GO_resized + GTxtframe:GetHeight() - GO_height
                  end
                  local isRTL = Quests.Utils and Quests.Utils.IsRTL and Quests.Utils.IsRTL() or false
                  if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then
                     Quests.Utils.ApplyOptionButtonLayout(GTxtframe, isRTL)
                  end
               else
                  -- No translation available: save original option text if enabled
                  if (QTR_PS and QTR_PS["saveGS"] == "1") then
                     local origText = WOWTR_DetectAndReplacePlayerName(rawText)
                     origText = string.gsub(origText, '"', '\\"')
                     origText = WOWTR_StripUEColorMarker(origText)
                     local mapId = C_Map.GetBestMapForUnit("player") or 0
                     QTR_GOSSIP[(Nazwa_NPC or "Unknown").."@"..tostring(OptHash).."@"..tostring(mapId)] = origText.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class
                  end
               end
            end
         end
      end
   end

   local GFGoodbyeBtext = GossipFrame.GreetingPanel.GoodbyeButton.Text
   ST_CheckAndReplaceTranslationText(GFGoodbyeBtext, true, "ui", false, true)
end

-- Process translations for the QuestFrame gossip section
function Quests.Gossip.OnQuestFrame()
   if QTR_IconAI then QTR_IconAI:Hide() end
   if GoQ_IconAI then GoQ_IconAI:Hide() end
   if ((GreetingText and GreetingText:IsVisible()) and (QTR_PS["gossip"]=="1")) then
      if QTR_ToggleButton0 then QTR_ToggleButton0:Disable(); QTR_ToggleButton0:SetWidth(200) end
      local Greeting_Text = GreetingText:GetText()
      if (Greeting_Text and (string.find(Greeting_Text,NONBREAKINGSPACE)==nil)) then
         local GO_resized = 0
         QTR_goss_optionsEN = {}
         QTR_goss_optionsTR = {}
         local Origin_Text = WOWTR_DetectAndReplacePlayerName(Greeting_Text)
         local Czysty_Text = WOWTR_NormalizeForHash(Origin_Text)
         local Hash = StringHash(Czysty_Text)
         QTR_curr_hash = Hash
         QTR_GS[Hash] = Greeting_Text
         if (GS_Gossip[Hash]) then
            if QTR_ToggleButton0 then
               QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(Hash).." "..WoWTR_Localization.lang)
               QTR_ToggleButton0:SetScript("OnClick", GS_ON_OFF2)
               QTR_ToggleButton0:Enable()
            end
            local Greeting_TR = GS_Gossip[Hash]
            local GO_height = GreetingText:GetHeight()
            GreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR..NONBREAKINGSPACE,false,GreetingText,WOWTR_Font2))
            GreetingText:SetFont(WOWTR_Font2, tonumber(QTR_PS and QTR_PS["fontsize"] or 13))
            QTR_curr_goss="1"
            if (GreetingText:GetHeight() > GO_height+1) then
               GO_resized = GO_resized + GreetingText:GetHeight() - GO_height
            end
            if (GS_AI and GS_AI[Hash] and GoQ_IconAI) then
               GoQ_IconAI:Show()
            end
            if (IsDUIQuestFrame and IsDUIQuestFrame()) then
               if QTR_ToggleButton6 then
                 QTR_ToggleButton6:SetText("Gossip-Hash="..tostring(Hash).." ("..WoWTR_Localization.lang..")"); QTR_ToggleButton6:Enable()
               end
               if QTR_DUIGossipFrame then QTR_DUIGossipFrame() end
            end
         else
            if QTR_ToggleButton0 then QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(Hash).." (EN)") end
            if (QTR_PS and QTR_PS["saveGS"]=="1") then
               local Nazwa_NPC = QuestFrameTitleText:GetText()
               Origin_Text = string.gsub(Origin_Text, '"', '\\"')
               Origin_Text = WOWTR_StripUEColorMarker(Origin_Text)
               local map = C_Map.GetBestMapForUnit("player")
               QTR_GOSSIP[Nazwa_NPC..'@'..tostring(Hash)..'@'..map] = Origin_Text..'@'..WOWTR_player_name..':'..WOWTR_player_race..':'..WOWTR_player_class
            end
         end

         if (CurrentQuestsText and CurrentQuestsText:IsVisible()) then
            CurrentQuestsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.currquests,false,CurrentQuestsText,WOWTR_Font1,-30))
            CurrentQuestsText:SetFont(WOWTR_Font1, 18)
         end
         if (AvailableQuestsText and AvailableQuestsText:IsVisible()) then
            AvailableQuestsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.avaiquests,false,AvailableQuestsText,WOWTR_Font1,-30))
            AvailableQuestsText:SetFont(WOWTR_Font1, 18)
         end

         if (QTR_PS["gossip"]=="1") then
            for GText in QuestFrameGreetingPanel.titleButtonPool:EnumerateActive() do
               local originalGossText = GText:GetText()
               local questID = GText.questID
               local transTR, prefix, sufix, isTranslated = nil, "", "", false
               if (string.sub(originalGossText,1,2) == "|c") then
                  prefix = string.sub(originalGossText, 1, 10); sufix = "|r"
               end
               if questID and questID ~= 0 and QTR_PS["transtitle"] == "1" then
                  local str_ID = tostring(questID)
                  if QTR_QuestData[str_ID] and QTR_QuestData[str_ID]["Title"] then
                     local translatedTitle = QTR_QuestData[str_ID]["Title"]
                     local cleanTransTR = QTR_ExpandUnitInfo(translatedTitle, false, GText, WOWTR_Font2, -40)
                     transTR = prefix .. cleanTransTR .. sufix .. " "
                     isTranslated = true
                  end
               end
               if not isTranslated then
                  local GOptionText = WOWTR_DetectAndReplacePlayerName(originalGossText, nil, '$N')
                  local cleanOptionText = GOptionText
                  if (string.sub(cleanOptionText,1,2) == "|c") or (string.sub(cleanOptionText,1,3) == "|cn") then
                     local detectedPrefix, detectedSuffix = "", ""
                     if (string.sub(cleanOptionText,1,2) == "|c") then
                        detectedPrefix = string.sub(cleanOptionText, 1, 10); detectedSuffix = "|r"
                     else
                        local start = string.match(cleanOptionText, "^(|cn[%w_]+:)")
                        if start then detectedPrefix = start; detectedSuffix = "|r" end
                     end
                     if detectedPrefix ~= "" then prefix = detectedPrefix; sufix = detectedSuffix end
                     cleanOptionText = WOWTR_StripWoWColors(cleanOptionText)
                  end
                  local Czysty_Text = WOWTR_DeleteSpecialCodes(cleanOptionText, '$N')
                  local TitleHash = StringHash(Czysty_Text)
                  if GS_Gossip[TitleHash] then
                     local cleanTransTR = QTR_ExpandUnitInfo(GS_Gossip[TitleHash], false, GText, WOWTR_Font2, -40)
                     transTR = prefix .. cleanTransTR .. sufix .. " "
                     isTranslated = true
                  else
                     if (QTR_PS and QTR_PS["saveGS"]=="1") then
                        local Nazwa_NPC = QuestFrameTitleText:GetText()
                        local textToSave = WOWTR_DetectAndReplacePlayerName(originalGossText)
                        textToSave = string.gsub(textToSave, '"', '\\"')
                        textToSave = WOWTR_StripUEColorMarker(textToSave)
                        local mapId = C_Map.GetBestMapForUnit("player") or "0"
                        QTR_GOSSIP[Nazwa_NPC..'@'..tostring(TitleHash).."@"..mapId] = textToSave.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class
                     end
                  end
               end
               if isTranslated and transTR then
                  if (GO_resized > 0) then
                     local point, relativeTo, relativePoint, xOfs, yOfs = GText:GetPoint(1)
                     GText:ClearAllPoints(); GText:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs - GO_resized)
                  end
                  local GO_height = GText:GetHeight()
                  QTR_goss_optionsEN[GText] = originalGossText
                  QTR_goss_optionsTR[GText] = transTR
                  GText:SetText(transTR)
                  if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then Quests.Utils.ApplyOptionButtonLayout(GText, (Quests.Utils.IsRTL and Quests.Utils.IsRTL() or false)) end
                  do
                     local fr = Quests.Utils and Quests.Utils.GetFirstFontStringRegion and Quests.Utils.GetFirstFontStringRegion(GText)
                     if fr and WOWTR_Font2 and QTR_PS then fr:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"])) end
                  end
                  if GText.Resize then GText:Resize() end
                  if (GText:GetHeight() > GO_height+1) then
                     GO_resized = GO_resized + GText:GetHeight() - GO_height
                  end
               else
                  if (GO_resized > 0) then
                     local point, relativeTo, relativePoint, xOfs, yOfs = GText:GetPoint(1)
                     GText:ClearAllPoints(); GText:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs - GO_resized)
                  end
                  local GO_height = GText:GetHeight()
                  local fontStringRegion
                  local iconRegion = GText.Icon
                  local regions = { GText:GetRegions() }
                  for k, v in pairs(regions) do
                     if (v:GetObjectType() == "FontString") then fontStringRegion = v; break end
                  end
                  if fontStringRegion then
                     local leftPadding = 10
                     if iconRegion then
                        iconRegion:ClearAllPoints(); iconRegion:SetPoint("TOPLEFT", GText, "TOPLEFT", 5, -2)
                        if iconRegion.GetWidth then leftPadding = iconRegion:GetWidth() + 10 end
                     end
                     fontStringRegion:ClearAllPoints(); fontStringRegion:SetPoint("TOPLEFT", GText, "TOPLEFT", leftPadding, -2)
                     fontStringRegion:SetJustifyH("LEFT")
                     if WOWTR_Font2 and QTR_PS then fontStringRegion:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"])) end
                  end
                  if GText.Resize then GText:Resize() end
                  if (GText:GetHeight() > GO_height+1) then
                     GO_resized = GO_resized + GText:GetHeight() - GO_height
                  end
               end
            end
         end
      end
   end

   -- QuestFrame buttons' text
   ST_CheckAndReplaceTranslationText(QuestFrameCompleteQuestButtonText, true, "ui", false, true)
   ST_CheckAndReplaceTranslationText(QuestFrameCompleteButtonText, true, "ui", false, true)
   ST_CheckAndReplaceTranslationText(QuestFrameAcceptButtonText, true, "ui", false, true)
   ST_CheckAndReplaceTranslationText(QuestFrameDeclineButtonText, true, "ui", false, true)
   ST_CheckAndReplaceTranslationText(QuestFrameContinueButtonText, true, "ui", false, true)
   ST_CheckAndReplaceTranslationText(QuestFrameGreetingGoodbyeButtonText, true, "ui", false, true)
   ST_CheckAndReplaceTranslationText(QuestFrameGoodbyeButtonText, true, "ui", false, true)
   ST_CheckAndReplaceTranslationText(QuestFrameCompleteButtonText, true, "ui", false, true)

   local notice = QuestFrame.AccountCompletedNotice and QuestFrame.AccountCompletedNotice.Text
   if notice then
      ST_CheckAndReplaceTranslationText(notice, true, "ui", false, true)
      notice:SetTextColor(0.5, 0, 0.5)
      if ns and ns.RTL and ns.RTL.JustifyFontString then ns.RTL.JustifyFontString(notice, "LEFT") end
      if ns and ns.RTL and ns.RTL.IsRTL and ns.RTL.IsRTL() then
         local point, relativeTo, relativePoint, xOfs, yOfs = notice:GetPoint(1)
         notice:SetPoint(point, relativeTo, relativePoint, xOfs - 20, yOfs)
      end
   end
end

-- Back-compat global wrappers to override monolith definitions
function QTR_Gossip_Show() return Quests.Gossip.Show() end
function GossipOnQuestFrame() return Quests.Gossip.OnQuestFrame() end

-- Backward-compatible global wrappers (define only if absent)
if not GS_ON_OFF then
   function GS_ON_OFF()
      return Quests.Gossip.ToggleNPCGossip()
   end
end

if not GS_ON_OFF2 then
   function GS_ON_OFF2()
      return Quests.Gossip.ToggleQuestFrame()
   end
end
