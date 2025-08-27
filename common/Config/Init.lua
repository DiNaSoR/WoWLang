-- Modular initialization for Settings UI
-------------------------------------------------------------------------------------------------------

local function safeSetChecked(name, value)
   local btn = _G[name]
   if btn and btn.SetChecked then btn:SetChecked(value) end
end

local function safeSetSlider(name, value)
   local s = _G[name]
   if s and s.SetValue and value ~= nil then s:SetValue(tonumber(value)) end
end

function WOWTR_SetCheckButtonState()
   safeSetChecked("WOWTR_CheckButton00", QTR_PS and QTR_PS["icon"] == "1")
   safeSetChecked("WOWTR_CheckButton11", QTR_PS and QTR_PS["active"] == "1")
   safeSetChecked("WOWTR_CheckButton12", QTR_PS and QTR_PS["transtitle"] == "1")
   safeSetChecked("WOWTR_CheckButton13", QTR_PS and QTR_PS["gossip"] == "1")
   safeSetChecked("WOWTR_CheckButton14", QTR_PS and QTR_PS["tracker"] == "1")
   safeSetChecked("WOWTR_CheckButton15", QTR_PS and QTR_PS["saveQS"] == "1")
   safeSetChecked("WOWTR_CheckButton16", QTR_PS and QTR_PS["saveGS"] == "1")
   safeSetChecked("WOWTR_CheckButton17", QTR_PS and QTR_PS["immersion"] == "1")
   safeSetChecked("WOWTR_CheckButton18", QTR_PS and QTR_PS["storyline"] == "1")
   safeSetChecked("WOWTR_CheckButton19", QTR_PS and QTR_PS["questlog"] == "1")
   safeSetChecked("WOWTR_CheckButton1a", QTR_PS and QTR_PS["ownnames"] == "1")
   safeSetChecked("WOWTR_CheckButton1b", QTR_PS and QTR_PS["dialogueui"] == "1")
   safeSetChecked("WOWTR_CheckButton1c", QTR_PS and QTR_PS["en_first"] == "1")

   safeSetChecked("WOWTR_CheckButton21", BB_PM and BB_PM["active"] == "1")
   safeSetChecked("WOWTR_CheckButton22", BB_PM and BB_PM["chat-en"] == "1")
   safeSetChecked("WOWTR_CheckButton23", BB_PM and BB_PM["chat-tr"] == "1")
   if BB_PM then
      safeSetChecked("WOWTR_CheckButton24", BB_PM["sex"] == "2")
      safeSetChecked("WOWTR_CheckButton25", BB_PM["sex"] == "3")
      safeSetChecked("WOWTR_CheckButton26", BB_PM["sex"] == "4")
      safeSetChecked("WOWTR_CheckButton27", BB_PM["saveNB"] == "1")
      safeSetChecked("WOWTR_CheckButton28", BB_PM["setsize"] == "1")
      safeSetChecked("WOWTR_CheckButton2d1", BB_PM["dungeon"] == "1")
      safeSetChecked("WOWTR_CheckButton2d2", false)
      BB_PM["dungeonF"] = "0"
   end

   safeSetChecked("WOWTR_CheckButton31", MF_PM and MF_PM["active"] == "1")
   safeSetChecked("WOWTR_CheckButton32", MF_PM and MF_PM["intro"] == "1")
   safeSetChecked("WOWTR_CheckButton33", MF_PM and MF_PM["movie"] == "1")
   safeSetChecked("WOWTR_CheckButton34", MF_PM and MF_PM["cinematic"] == "1")
   safeSetChecked("WOWTR_CheckButton35", MF_PM and MF_PM["save"] == "1")

   if WoWTR_Localization and WoWTR_Localization.lang == 'AR' then
      safeSetChecked("WOWTR_CheckButton36", CH_PM and CH_PM["active"] == "1")
      safeSetChecked("WOWTR_CheckButton37", CH_PM and CH_PM["setsize"] == "1")
      if CH_PM then safeSetSlider("WOWTR_slider6", CH_PM["fontsize"]) end
   end

   safeSetChecked("WOWTR_CheckButton40", TT_PS and TT_PS["ui8"] == "1")
   safeSetChecked("WOWTR_CheckButton41", TT_PS and TT_PS["active"] == "1")
   safeSetChecked("WOWTR_CheckButton42", TT_PS and TT_PS["save"] == "1")
   safeSetChecked("WOWTR_CheckButton43", TT_PS and TT_PS["ui1"] == "1")
   safeSetChecked("WOWTR_CheckButton44", TT_PS and TT_PS["saveui"] == "1")
   safeSetChecked("WOWTR_CheckButton45", TT_PS and TT_PS["ui2"] == "1")
   safeSetChecked("WOWTR_CheckButton46", TT_PS and TT_PS["ui3"] == "1")
   safeSetChecked("WOWTR_CheckButton47", TT_PS and TT_PS["ui4"] == "1")
   safeSetChecked("WOWTR_CheckButton48", TT_PS and TT_PS["ui5"] == "1")
   safeSetChecked("WOWTR_CheckButton49", TT_PS and TT_PS["ui6"] == "1")
   safeSetChecked("WOWTR_CheckButton50", TT_PS and TT_PS["ui7"] == "1")

   safeSetChecked("WOWTR_CheckButton51", BT_PM and BT_PM["active"] == "1")
   safeSetChecked("WOWTR_CheckButton52", BT_PM and BT_PM["title"] == "1")
   safeSetChecked("WOWTR_CheckButton53", BT_PM and BT_PM["showID"] == "1")
   safeSetChecked("WOWTR_CheckButton55", BT_PM and BT_PM["saveNW"] == "1")
   safeSetChecked("WOWTR_CheckButton58", BT_PM and BT_PM["setsize"] == "1")

   safeSetChecked("WOWTR_CheckButton61", ST_PM and ST_PM["active"] == "1")
   safeSetChecked("WOWTR_CheckButton62", ST_PM and ST_PM["item"] == "1")
   safeSetChecked("WOWTR_CheckButton63", ST_PM and ST_PM["spell"] == "1")
   safeSetChecked("WOWTR_CheckButton64", ST_PM and ST_PM["talent"] == "1")
   safeSetChecked("WOWTR_CheckButton65", ST_PM and ST_PM["showID"] == "1")
   safeSetChecked("WOWTR_CheckButton66", ST_PM and ST_PM["showHS"] == "1")
   safeSetChecked("WOWTR_CheckButton67", ST_PM and ST_PM["sellprice"] == "1")
   safeSetChecked("WOWTR_CheckButton68", ST_PM and ST_PM["constantly"] == "1")
   safeSetChecked("WOWTR_CheckButton69", ST_PM and ST_PM["saveNW"] == "1")
   if ST_TooltipsID then safeSetChecked("WOWTR_CheckButton6A", ST_PM and ST_PM["transtitle"] == "1") end

   if BB_PM then
      safeSetSlider("WOWTR_slider1", BB_PM["fontsize"])
      safeSetSlider("WOWTR_slider5", BB_PM["timeDisplay"])
   end
   if BT_PM then safeSetSlider("WOWTR_slider2", BT_PM["fontsize"]) end
   if ST_PM then safeSetSlider("WOWTR_slider3", ST_PM["timer"]) end
   if QTR_PS then safeSetSlider("WOWTR_slider4", QTR_PS["fontsize"]) end
end

function WOWTR_SetDungeonFrames(obj, tryb, horiz)
   if (tryb) then
      obj:SetOwner(UIParent, "ANCHOR_NONE")
      obj:ClearAllPoints()
      obj:SetPoint("CENTER", horiz, obj.vertical)
      obj:ClearLines()
      obj:AddLine(QTR_ReverseIfAR(WoWTR_Localization.moveFrameUpDown), 1, 1, 1, true)
      if (BB_PM and BB_PM["setsize"] == "1") then
         _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, tonumber(BB_PM["fontsize"]))
      else
         _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, 13)
      end
      obj:Show()
      obj:SetMovable(true)
      obj:SetScript("OnMouseDown", function() WOWBB_OnMouseDown(obj) end)
      obj:SetScript("OnMouseUp", function() WOWBB_OnMouseUp(obj) end)
   else
      obj:SetMovable(false)
      obj:SetScript("OnMouseDown", nil)
      obj:SetScript("OnMouseUp", nil)
      obj:Hide()
      if BB_PM then
         BB_PM["dungeonF1"] = WOWBB1.vertical
         BB_PM["dungeonF2"] = WOWBB2.vertical
         BB_PM["dungeonF3"] = WOWBB3.vertical
         BB_PM["dungeonF4"] = WOWBB4.vertical
         BB_PM["dungeonF5"] = WOWBB5.vertical
      end
   end
end

function WOWTR_HideOptionsFrame()
   WOWTR_SetDungeonFrames(WOWBB1, false)
   WOWTR_SetDungeonFrames(WOWBB2, false)
   WOWTR_SetDungeonFrames(WOWBB3, false)
   WOWTR_SetDungeonFrames(WOWBB4, false)
   WOWTR_SetDungeonFrames(WOWBB5, false)
end

function WOWTR_BlizzardOptions()
   local WOWTR_Options = CreateFrame("FRAME", "WOWTR_Options", SettingsPanel)
   WOWTR_Options:SetScript("OnHide", WOWTR_HideOptionsFrame)
   WOWTR_Options.name = WoWTR_Localization.optionName
   WOWTR_Options.refresh = function(self) WOWTR_SetCheckButtonState() end
   local category = Settings.RegisterCanvasLayoutCategory(WOWTR_Options, WoWTR_Localization.optionName)
   Settings.RegisterAddOnCategory(category)
   WOWTR.CategoryID = category:GetID()
   WOWTR_Options:SetScript("OnShow", function(self) WOWTR_SetCheckButtonState() end)

   local WOWTR_OptionsHeader = WOWTR_Options:CreateFontString(nil, "ARTWORK")
   WOWTR_OptionsHeader:SetFontObject(GameFontNormalLarge)
   WOWTR_OptionsHeader:SetJustifyH("LEFT")
   WOWTR_OptionsHeader:SetJustifyV("TOP")
   WOWTR_OptionsHeader:ClearAllPoints()
   WOWTR_OptionsHeader:SetPoint("TOPLEFT", 8, -8)

   local WOWTR_OptionsHeaderIcon = WOWTR_Options:CreateTexture(nil, "OVERLAY")
   WOWTR_OptionsHeaderIcon:SetPoint("TOPLEFT", 0, 0)
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderIcon:SetWidth(48); WOWTR_OptionsHeaderIcon:SetHeight(48)
   else
      WOWTR_OptionsHeaderIcon:SetWidth(32); WOWTR_OptionsHeaderIcon:SetHeight(32)
   end
   WOWTR_OptionsHeaderIcon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon.png")

   local WOWTR_OptionsHeaderText = WOWTR_Options:CreateFontString(nil, "OVERLAY", "GameFontNormal")
   WOWTR_OptionsHeaderText:SetFont(WOWTR_Font2, 18)
   WOWTR_OptionsHeaderText:SetWidth(600)
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderText:SetPoint("LEFT", WOWTR_OptionsHeaderIcon, "RIGHT", 50, 10)
      WOWTR_OptionsHeaderText:SetText(AS_UTF8reverse(WoWTR_Localization.optionTitleAR))
   else
      WOWTR_OptionsHeaderText:SetPoint("LEFT", WOWTR_OptionsHeaderIcon, "RIGHT", 0, 0)
      WOWTR_OptionsHeaderText:SetText(" " .. WoWTR_Localization.optionTitle .. " |cff8080ffv" .. WOWTR_version .. "|r                          by Platine © 2024")
   end

   local WOWTR_CheckButton00 = CreateFrame("CheckButton", "WOWTR_CheckButton00", WOWTR_Options, "UICheckButtonTemplate")
   WOWTR_CheckButton00:SetScript("OnClick", function(self)
      if (QTR_PS["icon"] == "1") then
         QTR_PS["icon"] = "0"; WOWTR.db.profile.minimap.hide = true; LibDBIcon10_WOWTR_LDB:Hide()
      else
         QTR_PS["icon"] = "1"; WOWTR.db.profile.minimap.hide = false; LibDBIcon10_WOWTR_LDB:Show()
      end
   end)
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton00:SetPoint("TOPLEFT", WOWTR_OptionsHeaderText, "TOPLEFT", 525, -20)
      WOWTR_CheckButton00.Text:SetText("|cffffffff" .. AS_UTF8reverse(WoWTR_Config_Interface.showMinimapIcon) .. "|r")
      WOWTR_CheckButton00.Text:SetPoint("TOPLEFT", WOWTR_OptionsHeaderText, "TOPLEFT", 265, -30)
   else
      WOWTR_CheckButton00:SetPoint("TOPLEFT", WOWTR_OptionsHeaderText, "TOPLEFT", 20, -20)
      WOWTR_CheckButton00.Text:SetText("|cffffffff" .. WoWTR_Config_Interface.showMinimapIcon .. "|r")
   end
   WOWTR_CheckButton00.Text:SetFont(WOWTR_Font2, 13)
   WOWTR_CheckButton00:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT"); GameTooltip:ClearLines()
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.showMinimapIcon) .. NONBREAKINGSPACE, false)
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13)
      GameTooltip:AddLine(QTR_ExpandUnitInfo(WoWTR_Config_Interface.showMinimapIconDESC, false, getglobal("GameTooltipTextLeft1"), WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true)
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13); GameTooltip:Show()
   end)
   WOWTR_CheckButton00:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

   -- Tab Buttons A/B
   local WOWTR_Tab1TitleA = CreateFrame("BUTTON", "WOWTR_Tab1TitleA", WOWTR_Options, "GameMenuButtonTemplate")
   WOWTR_Tab1TitleA:SetWidth(100); WOWTR_Tab1TitleA:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab1TitleA:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab1)); WOWTR_Tab1TitleA:SetFontString(fo)
   end
   WOWTR_Tab1TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab1))
   WOWTR_Tab1TitleA:ClearAllPoints(); WOWTR_Tab1TitleA:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -10, -60); WOWTR_Tab1TitleA:Show()

   local WOWTR_Tab1TitleB = CreateFrame("BUTTON", "WOWTR_Tab1TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate")
   WOWTR_Tab1TitleB:SetWidth(100); WOWTR_Tab1TitleB:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab1TitleB:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab1)); WOWTR_Tab1TitleB:SetFontString(fo)
   end
   WOWTR_Tab1TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab1))
   WOWTR_Tab1TitleB:ClearAllPoints(); WOWTR_Tab1TitleB:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -10, -60); WOWTR_Tab1TitleB:Hide(); WOWTR_Tab1TitleB:SetScript("OnClick", WOWTR_ChangePanel1)

   local WOWTR_Tab2TitleA = CreateFrame("BUTTON", "WOWTR_Tab2TitleA", WOWTR_Options, "GameMenuButtonTemplate")
   WOWTR_Tab2TitleA:SetWidth(100); WOWTR_Tab2TitleA:SetHeight(20)
   if (WoWTR_Localization.lang == 'AR') then local fo = WOWTR_Tab2TitleA:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab2)); WOWTR_Tab2TitleA:SetFontString(fo) end
   WOWTR_Tab2TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab2))
   WOWTR_Tab2TitleA:ClearAllPoints(); WOWTR_Tab2TitleA:SetPoint("TOPLEFT", WOWTR_Tab1TitleA, "TOPRIGHT", -4, 0); WOWTR_Tab2TitleA:Hide()

   local WOWTR_Tab2TitleB = CreateFrame("BUTTON", "WOWTR_Tab2TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate")
   WOWTR_Tab2TitleB:SetWidth(100); WOWTR_Tab2TitleB:SetHeight(20)
   if (WoWTR_Localization.lang == 'AR') then local fo = WOWTR_Tab2TitleB:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab2)); WOWTR_Tab2TitleB:SetFontString(fo) end
   WOWTR_Tab2TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab2))
   WOWTR_Tab2TitleB:ClearAllPoints(); WOWTR_Tab2TitleB:SetPoint("TOPLEFT", WOWTR_Tab1TitleB, "TOPRIGHT", -4, 0); WOWTR_Tab2TitleB:Show(); WOWTR_Tab2TitleB:SetScript("OnClick", WOWTR_ChangePanel2)

   local WOWTR_Tab3TitleA = CreateFrame("BUTTON", "WOWTR_Tab3TitleA", WOWTR_Options, "GameMenuButtonTemplate")
   WOWTR_Tab3TitleA:SetWidth(100); WOWTR_Tab3TitleA:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then local fo = WOWTR_Tab3TitleA:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab3)); WOWTR_Tab3TitleA:SetFontString(fo) end
   WOWTR_Tab3TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab3))
   WOWTR_Tab3TitleA:ClearAllPoints(); WOWTR_Tab3TitleA:SetPoint("TOPLEFT", WOWTR_Tab2TitleA, "TOPRIGHT", -4, 0); WOWTR_Tab3TitleA:Hide()

   local WOWTR_Tab3TitleB = CreateFrame("BUTTON", "WOWTR_Tab3TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate")
   WOWTR_Tab3TitleB:SetWidth(100); WOWTR_Tab3TitleB:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then local fo = WOWTR_Tab3TitleB:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab3)); WOWTR_Tab3TitleB:SetFontString(fo) end
   WOWTR_Tab3TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab3))
   WOWTR_Tab3TitleB:ClearAllPoints(); WOWTR_Tab3TitleB:SetPoint("TOPLEFT", WOWTR_Tab2TitleB, "TOPRIGHT", -4, 0); WOWTR_Tab3TitleB:Show(); WOWTR_Tab3TitleB:SetScript("OnClick", WOWTR_ChangePanel3)

   local WOWTR_Tab4TitleA = CreateFrame("BUTTON", "WOWTR_Tab4TitleA", WOWTR_Options, "GameMenuButtonTemplate")
   WOWTR_Tab4TitleA:SetWidth(100); WOWTR_Tab4TitleA:SetHeight(20)
   if (WoWTR_Localization.lang == 'AR') then local fo = WOWTR_Tab4TitleA:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab4)); WOWTR_Tab4TitleA:SetFontString(fo) end
   WOWTR_Tab4TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab4))
   WOWTR_Tab4TitleA:ClearAllPoints(); WOWTR_Tab4TitleA:SetPoint("TOPLEFT", WOWTR_Tab3TitleA, "TOPRIGHT", -4, 0); WOWTR_Tab4TitleA:Hide()

   local WOWTR_Tab4TitleB = CreateFrame("BUTTON", "WOWTR_Tab4TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate")
   WOWTR_Tab4TitleB:SetWidth(100); WOWTR_Tab4TitleB:SetHeight(20)
   if (WoWTR_Localization.lang == 'AR') then local fo = WOWTR_Tab4TitleB:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab4)); WOWTR_Tab4TitleB:SetFontString(fo) end
   WOWTR_Tab4TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab4))
   WOWTR_Tab4TitleB:ClearAllPoints(); WOWTR_Tab4TitleB:SetPoint("TOPLEFT", WOWTR_Tab3TitleB, "TOPRIGHT", -4, 0); WOWTR_Tab4TitleB:Show(); WOWTR_Tab4TitleB:SetScript("OnClick", WOWTR_ChangePanel4)

   local WOWTR_Tab5TitleA = CreateFrame("BUTTON", "WOWTR_Tab5TitleA", WOWTR_Options, "GameMenuButtonTemplate")
   WOWTR_Tab5TitleA:SetWidth(100); WOWTR_Tab5TitleA:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP') or (WoWTR_Localization.lang == 'PL')) then local fo = WOWTR_Tab5TitleA:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab5)); WOWTR_Tab5TitleA:SetFontString(fo) end
   WOWTR_Tab5TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab5))
   WOWTR_Tab5TitleA:ClearAllPoints(); WOWTR_Tab5TitleA:SetPoint("TOPLEFT", WOWTR_Tab4TitleA, "TOPRIGHT", -4, 0); WOWTR_Tab5TitleA:Hide()

   local WOWTR_Tab5TitleB = CreateFrame("BUTTON", "WOWTR_Tab5TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate")
   WOWTR_Tab5TitleB:SetWidth(100); WOWTR_Tab5TitleB:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP') or (WoWTR_Localization.lang == 'PL')) then local fo = WOWTR_Tab5TitleB:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab5)); WOWTR_Tab5TitleB:SetFontString(fo) end
   WOWTR_Tab5TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab5))
   WOWTR_Tab5TitleB:ClearAllPoints(); WOWTR_Tab5TitleB:SetPoint("TOPLEFT", WOWTR_Tab4TitleB, "TOPRIGHT", -4, 0); WOWTR_Tab5TitleB:Show(); WOWTR_Tab5TitleB:SetScript("OnClick", WOWTR_ChangePanel5)

   local WOWTR_Tab6TitleA = CreateFrame("BUTTON", "WOWTR_Tab6TitleA", WOWTR_Options, "GameMenuButtonTemplate")
   WOWTR_Tab6TitleA:SetWidth(100); WOWTR_Tab6TitleA:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then local fo = WOWTR_Tab6TitleA:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab6)); WOWTR_Tab6TitleA:SetFontString(fo) end
   WOWTR_Tab6TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab6))
   WOWTR_Tab6TitleA:ClearAllPoints(); WOWTR_Tab6TitleA:SetPoint("TOPLEFT", WOWTR_Tab5TitleA, "TOPRIGHT", -4, 0); WOWTR_Tab6TitleA:Hide()

   local WOWTR_Tab6TitleB = CreateFrame("BUTTON", "WOWTR_Tab6TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate")
   WOWTR_Tab6TitleB:SetWidth(100); WOWTR_Tab6TitleB:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then local fo = WOWTR_Tab6TitleB:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab6)); WOWTR_Tab6TitleB:SetFontString(fo) end
   WOWTR_Tab6TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab6))
   WOWTR_Tab6TitleB:ClearAllPoints(); WOWTR_Tab6TitleB:SetPoint("TOPLEFT", WOWTR_Tab5TitleB, "TOPRIGHT", -4, 0); WOWTR_Tab6TitleB:Show(); WOWTR_Tab6TitleB:SetScript("OnClick", WOWTR_ChangePanel6)

   local WOWTR_Tab9TitleA = CreateFrame("BUTTON", "WOWTR_Tab9TitleA", WOWTR_Options, "GameMenuButtonTemplate")
   WOWTR_Tab9TitleA:SetWidth(100); WOWTR_Tab9TitleA:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then local fo = WOWTR_Tab9TitleA:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab9)); WOWTR_Tab9TitleA:SetFontString(fo) end
   WOWTR_Tab9TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab9))
   WOWTR_Tab9TitleA:ClearAllPoints(); WOWTR_Tab9TitleA:SetPoint("TOPLEFT", WOWTR_Tab6TitleA, "TOPRIGHT", -4, 0); WOWTR_Tab9TitleA:Hide()

   local WOWTR_Tab9TitleB = CreateFrame("BUTTON", "WOWTR_Tab9TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate")
   WOWTR_Tab9TitleB:SetWidth(100); WOWTR_Tab9TitleB:SetHeight(20)
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then local fo = WOWTR_Tab9TitleB:CreateFontString(); fo:SetFont(WOWTR_Font2, 12); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab9)); WOWTR_Tab9TitleB:SetFontString(fo) end
   WOWTR_Tab9TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab9))
   WOWTR_Tab9TitleB:ClearAllPoints(); WOWTR_Tab9TitleB:SetPoint("TOPLEFT", WOWTR_Tab6TitleB, "TOPRIGHT", -4, 0); WOWTR_Tab9TitleB:Show(); WOWTR_Tab9TitleB:SetScript("OnClick", WOWTR_ChangePanel9)

   -- Panels
   WOWTR_OptionPanel1 = CreateFrame("FRAME", "WOWTR_OptionPanel1", WOWTR_Options, "BackdropTemplate")
   WOWTR_OptionPanel1:SetMovable(false); WOWTR_OptionPanel1:SetWidth(682); WOWTR_OptionPanel1:SetHeight(530)
   WOWTR_OptionPanel1:ClearAllPoints(); WOWTR_OptionPanel1:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73); WOWTR_OptionPanel1:Show()

   WOWTR_OptionPanel2 = CreateFrame("FRAME", "WOWTR_OptionPanel2", WOWTR_Options, "BackdropTemplate")
   WOWTR_OptionPanel2:SetMovable(false); WOWTR_OptionPanel2:SetWidth(682); WOWTR_OptionPanel2:SetHeight(530)
   WOWTR_OptionPanel2:ClearAllPoints(); WOWTR_OptionPanel2:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73); WOWTR_OptionPanel2:Hide()

   WOWTR_OptionPanel3 = CreateFrame("FRAME", "WOWTR_OptionPanel3", WOWTR_Options, "BackdropTemplate")
   WOWTR_OptionPanel3:SetMovable(false); WOWTR_OptionPanel3:SetWidth(682); WOWTR_OptionPanel3:SetHeight(530)
   WOWTR_OptionPanel3:ClearAllPoints(); WOWTR_OptionPanel3:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73); WOWTR_OptionPanel3:Hide()

   WOWTR_OptionPanel4 = CreateFrame("FRAME", "WOWTR_OptionPanel4", WOWTR_Options, "BackdropTemplate")
   WOWTR_OptionPanel4:SetMovable(false); WOWTR_OptionPanel4:SetWidth(682); WOWTR_OptionPanel4:SetHeight(530)
   WOWTR_OptionPanel4:ClearAllPoints(); WOWTR_OptionPanel4:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73); WOWTR_OptionPanel4:Hide()

   WOWTR_OptionPanel5 = CreateFrame("FRAME", "WOWTR_OptionPanel5", WOWTR_Options, "BackdropTemplate")
   WOWTR_OptionPanel5:SetMovable(false); WOWTR_OptionPanel5:SetWidth(682); WOWTR_OptionPanel5:SetHeight(530)
   WOWTR_OptionPanel5:ClearAllPoints(); WOWTR_OptionPanel5:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73); WOWTR_OptionPanel5:Hide()

   WOWTR_OptionPanel6 = CreateFrame("FRAME", "WOWTR_OptionPanel6", WOWTR_Options, "BackdropTemplate")
   WOWTR_OptionPanel6:SetMovable(false); WOWTR_OptionPanel6:SetWidth(682); WOWTR_OptionPanel6:SetHeight(530)
   WOWTR_OptionPanel6:ClearAllPoints(); WOWTR_OptionPanel6:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73); WOWTR_OptionPanel6:Hide()

   WOWTR_OptionPanel9 = CreateFrame("FRAME", "WOWTR_OptionPanel9", WOWTR_Options, "BackdropTemplate")
   WOWTR_OptionPanel9:SetMovable(false); WOWTR_OptionPanel9:SetWidth(682); WOWTR_OptionPanel9:SetHeight(530)
   WOWTR_OptionPanel9:ClearAllPoints(); WOWTR_OptionPanel9:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73); WOWTR_OptionPanel9:Hide()

   if WOWTR_BuildTab1 then WOWTR_BuildTab1(WOWTR_OptionPanel1) end
   if WOWTR_BuildTab2 then WOWTR_BuildTab2(WOWTR_OptionPanel2) end
   if WOWTR_BuildTab3 then WOWTR_BuildTab3(WOWTR_OptionPanel3) end
   if WOWTR_BuildTab4 then WOWTR_BuildTab4(WOWTR_OptionPanel4) end
   if WOWTR_BuildTab5 then WOWTR_BuildTab5(WOWTR_OptionPanel5) end
   if WOWTR_BuildTab6 then WOWTR_BuildTab6(WOWTR_OptionPanel6) end
   if WOWTR_BuildTab9 then WOWTR_BuildTab9(WOWTR_OptionPanel9) end
end

function WOWTR_ChangePanel1()
   WOWTR_Tab1TitleB:Hide(); WOWTR_Tab2TitleA:Hide(); WOWTR_Tab3TitleA:Hide(); WOWTR_Tab4TitleA:Hide(); WOWTR_Tab5TitleA:Hide(); WOWTR_Tab6TitleA:Hide(); WOWTR_Tab9TitleA:Hide()
   WOWTR_Tab1TitleA:Show(); WOWTR_Tab2TitleB:Show(); WOWTR_Tab3TitleB:Show(); WOWTR_Tab4TitleB:Show(); WOWTR_Tab5TitleB:Show(); WOWTR_Tab6TitleB:Show(); WOWTR_Tab9TitleB:Show()
   WOWTR_OptionPanel1:Show(); WOWTR_OptionPanel2:Hide(); WOWTR_OptionPanel3:Hide(); WOWTR_OptionPanel4:Hide(); WOWTR_OptionPanel5:Hide(); WOWTR_OptionPanel6:Hide(); WOWTR_OptionPanel9:Hide()
end

function WOWTR_ChangePanel2()
   WOWTR_Tab1TitleA:Hide(); WOWTR_Tab2TitleB:Hide(); WOWTR_Tab3TitleA:Hide(); WOWTR_Tab4TitleA:Hide(); WOWTR_Tab5TitleA:Hide(); WOWTR_Tab6TitleA:Hide(); WOWTR_Tab9TitleA:Hide()
   WOWTR_Tab1TitleB:Show(); WOWTR_Tab2TitleA:Show(); WOWTR_Tab3TitleB:Show(); WOWTR_Tab4TitleB:Show(); WOWTR_Tab5TitleB:Show(); WOWTR_Tab6TitleB:Show(); WOWTR_Tab9TitleB:Show()
   WOWTR_OptionPanel1:Hide(); WOWTR_OptionPanel2:Show(); WOWTR_OptionPanel3:Hide(); WOWTR_OptionPanel4:Hide(); WOWTR_OptionPanel5:Hide(); WOWTR_OptionPanel6:Hide(); WOWTR_OptionPanel9:Hide()
end

function WOWTR_ChangePanel3()
   WOWTR_Tab1TitleA:Hide(); WOWTR_Tab2TitleA:Hide(); WOWTR_Tab3TitleB:Hide(); WOWTR_Tab4TitleA:Hide(); WOWTR_Tab5TitleA:Hide(); WOWTR_Tab6TitleA:Hide(); WOWTR_Tab9TitleA:Hide()
   WOWTR_Tab1TitleB:Show(); WOWTR_Tab2TitleB:Show(); WOWTR_Tab3TitleA:Show(); WOWTR_Tab4TitleB:Show(); WOWTR_Tab5TitleB:Show(); WOWTR_Tab6TitleB:Show(); WOWTR_Tab9TitleB:Show()
   WOWTR_OptionPanel1:Hide(); WOWTR_OptionPanel2:Hide(); WOWTR_OptionPanel3:Show(); WOWTR_OptionPanel4:Hide(); WOWTR_OptionPanel5:Hide(); WOWTR_OptionPanel6:Hide(); WOWTR_OptionPanel9:Hide()
end

function WOWTR_ChangePanel4()
   WOWTR_Tab1TitleA:Hide(); WOWTR_Tab2TitleA:Hide(); WOWTR_Tab3TitleA:Hide(); WOWTR_Tab4TitleB:Hide(); WOWTR_Tab5TitleA:Hide(); WOWTR_Tab6TitleA:Hide(); WOWTR_Tab9TitleA:Hide()
   WOWTR_Tab1TitleB:Show(); WOWTR_Tab2TitleB:Show(); WOWTR_Tab3TitleB:Show(); WOWTR_Tab4TitleA:Show(); WOWTR_Tab5TitleB:Show(); WOWTR_Tab6TitleB:Show(); WOWTR_Tab9TitleB:Show()
   WOWTR_OptionPanel1:Hide(); WOWTR_OptionPanel2:Hide(); WOWTR_OptionPanel3:Hide(); WOWTR_OptionPanel4:Show(); WOWTR_OptionPanel5:Hide(); WOWTR_OptionPanel6:Hide(); WOWTR_OptionPanel9:Hide()
end

function WOWTR_ChangePanel5()
   WOWTR_Tab1TitleA:Hide(); WOWTR_Tab2TitleA:Hide(); WOWTR_Tab3TitleA:Hide(); WOWTR_Tab4TitleA:Hide(); WOWTR_Tab5TitleB:Hide(); WOWTR_Tab6TitleA:Hide(); WOWTR_Tab9TitleA:Hide()
   WOWTR_Tab1TitleB:Show(); WOWTR_Tab2TitleB:Show(); WOWTR_Tab3TitleB:Show(); WOWTR_Tab4TitleB:Show(); WOWTR_Tab5TitleA:Show(); WOWTR_Tab6TitleB:Show(); WOWTR_Tab9TitleB:Show()
   WOWTR_OptionPanel1:Hide(); WOWTR_OptionPanel2:Hide(); WOWTR_OptionPanel3:Hide(); WOWTR_OptionPanel4:Hide(); WOWTR_OptionPanel5:Show(); WOWTR_OptionPanel6:Hide(); WOWTR_OptionPanel9:Hide()
end

function WOWTR_ChangePanel6()
   WOWTR_Tab1TitleA:Hide(); WOWTR_Tab2TitleA:Hide(); WOWTR_Tab3TitleA:Hide(); WOWTR_Tab4TitleA:Hide(); WOWTR_Tab5TitleA:Hide(); WOWTR_Tab6TitleB:Hide(); WOWTR_Tab9TitleA:Hide()
   WOWTR_Tab1TitleB:Show(); WOWTR_Tab2TitleB:Show(); WOWTR_Tab3TitleB:Show(); WOWTR_Tab4TitleB:Show(); WOWTR_Tab5TitleB:Show(); WOWTR_Tab6TitleA:Show(); WOWTR_Tab9TitleB:Show()
   WOWTR_OptionPanel1:Hide(); WOWTR_OptionPanel2:Hide(); WOWTR_OptionPanel3:Hide(); WOWTR_OptionPanel4:Hide(); WOWTR_OptionPanel5:Hide(); WOWTR_OptionPanel6:Show(); WOWTR_OptionPanel9:Hide()
end

function WOWTR_ChangePanel9()
   WOWTR_Tab1TitleA:Hide(); WOWTR_Tab2TitleA:Hide(); WOWTR_Tab3TitleA:Hide(); WOWTR_Tab4TitleA:Hide(); WOWTR_Tab5TitleA:Hide(); WOWTR_Tab6TitleA:Hide(); WOWTR_Tab9TitleB:Hide()
   WOWTR_Tab1TitleB:Show(); WOWTR_Tab2TitleB:Show(); WOWTR_Tab3TitleB:Show(); WOWTR_Tab4TitleB:Show(); WOWTR_Tab5TitleB:Show(); WOWTR_Tab6TitleB:Show(); WOWTR_Tab9TitleA:Show()
   WOWTR_OptionPanel1:Hide(); WOWTR_OptionPanel2:Hide(); WOWTR_OptionPanel3:Hide(); WOWTR_OptionPanel4:Hide(); WOWTR_OptionPanel5:Hide(); WOWTR_OptionPanel6:Hide(); WOWTR_OptionPanel9:Show()
end

function Config_OnEnable()
   WOWTR_BlizzardOptions()
end

function WOWTR_SlashCommand(msg)
   if not msg or msg:trim() == "" then
      Settings.OpenToCategory(WOWTR.CategoryID)
   end
end

function WOWTR_WelcomePanel()
   if (not WOWTR.WelcomePanel) then
      QTR_PS["welcome"] = "1"
      WOWTR.WelcomePanel = CreateFrame("Frame", nil, UIParent, "UIPanelDialogTemplate")
      WOWTR.WelcomePanel:SetWidth(800); WOWTR_WelcomePanel:SetHeight(400)
      WOWTR.WelcomePanel:ClearAllPoints(); WOWTR.WelcomePanel:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
      WOWTR.WelcomePanel:SetFrameStrata("TOOLTIP")
      WOWTR.WelcomePanel.Title:SetText(QTR_ReverseIfAR(WoWTR_Localization.optionTitle))
      WOWTR_WelcomePanel.Title:SetFont(WOWTR_Font2, 15)
      if (WoWTR_Localization.welcomeIconPos > 0) then
         WOWTR.Icon = WOWTR.WelcomePanel:CreateTexture(nil, "OVERLAY")
         WOWTR.Icon:ClearAllPoints(); WOWTR.Icon:SetPoint("BOTTOMRIGHT", WOWTR.WelcomePanel, -10, 10, -WoWTR_Localization.welcomeIconPos)
         WOWTR.Icon:SetWidth(32); WOWTR.Icon:SetHeight(32)
         WOWTR.Icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon.png")
      end
      WOWTR.WelcomePanel.Text = WOWTR.WelcomePanel:CreateFontString(nil, "ARTWORK")
      WOWTR.WelcomePanel.Text:SetFontObject(GameFontWhite)
      WOWTR.WelcomePanel.Text:SetJustifyH("LEFT"); WOWTR.WelcomePanel.Text:SetJustifyV("TOP")
      WOWTR.WelcomePanel.Text:ClearAllPoints(); WOWTR.WelcomePanel.Text:SetPoint("TOPLEFT", WOWTR.WelcomePanel, "TOPLEFT", 20, -40)
      WOWTR.WelcomePanel.Text:SetWidth(770)
      WOWTR.WelcomePanel.Text:SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.welcomeText, false, WOWTR.WelcomePanel.Text, WOWTR_Font2, -140, "RIGHT"))
      WOWTR.WelcomePanel.Text:SetFont(WOWTR_Font2, 14)
      WOWTR.WelcomePanel.Button = CreateFrame("Button", nil, WOWTR.WelcomePanel, "UIPanelButtonTemplate")
      WOWTR.WelcomePanel.Button:SetWidth(160); WOWTR.WelcomePanel.Button:SetHeight(20)
      local fo = WOWTR.WelcomePanel.Button:CreateFontString(); fo:SetFont(WOWTR_Font2, 13); fo:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Config_Interface.welcomeButton)))
      WOWTR.WelcomePanel.Button:SetFontString(fo)
      WOWTR.WelcomePanel.Button:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.welcomeButton))
      WOWTR.WelcomePanel.Button:ClearAllPoints(); WOWTR.WelcomePanel.Button:SetPoint("BOTTOMLEFT", WOWTR.WelcomePanel, "BOTTOMLEFT", WOWTR.WelcomePanel:GetWidth() / 2 - WOWTR.WelcomePanel.Button:GetWidth() / 2, 10)
      WOWTR.WelcomePanel.Button:Show(); WOWTR.WelcomePanel.Button:SetScript("OnClick", function() WOWTR.WelcomePanel:Hide() end)
   end
   WOWTR.WelcomePanel:Show()
end


