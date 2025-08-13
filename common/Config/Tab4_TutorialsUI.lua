function WOWTR_CreateOptionPanel4(WOWTR_OptionPanel4)
   ----- TAB 4

   local WOWTR_OptionsHeaderIcon4 = WOWTR_OptionPanel4:CreateTexture(nil, "OVERLAY");
   WOWTR_OptionsHeaderIcon4:SetWidth(200);
   WOWTR_OptionsHeaderIcon4:SetHeight(200);
   WOWTR_OptionsHeaderIcon4:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\tutorials_mini.jpg"); -- WOWTR_OptionPanel4 thumbnail
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderIcon4:SetPoint("CENTER", -230, 150);
   else
      WOWTR_OptionsHeaderIcon4:SetPoint("CENTER", 230, 150);
   end

   local WOWTR_Panel4Header1 = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel4Header1:SetFontObject(GameFontNormal);
   WOWTR_Panel4Header1:SetJustifyH("LEFT");
   WOWTR_Panel4Header1:SetJustifyV("TOP");
   WOWTR_Panel4Header1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel4Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 445, -25);
   else
      WOWTR_Panel4Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 20, -25);
   end
   WOWTR_Panel4Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.generalMainHeaderTT)); -- Tutorial translations
   WOWTR_Panel4Header1:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton41 = CreateFrame("CheckButton", "WOWTR_CheckButton41", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton41:SetScript("OnClick",
      function(self) if (TT_PS["active"] == "1") then TT_PS["active"] = "0" else TT_PS["active"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton41:SetPoint("TOPLEFT", WOWTR_Panel4Header1, "TOPLEFT", 190, -20);
      WOWTR_CheckButton41.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header1, "TOPLEFT", 5, -30);
   else
      WOWTR_CheckButton41:SetPoint("TOPLEFT", WOWTR_Panel4Header1, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton41.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.activateTutorialTranslations) .. "|r"); -- Activate subtitle translations
   WOWTR_CheckButton41.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton41:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.activateTutorialTranslations), false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.activateTutorialTranslationsDESC, false,
            getglobal("GameTooltipTextLeft1"), WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                                                         -- Show the tooltip
   end);
   WOWTR_CheckButton41:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_Panel4Header2 = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel4Header2:SetFontObject(GameFontNormal);
   WOWTR_Panel4Header2:SetJustifyH("LEFT");
   WOWTR_Panel4Header2:SetJustifyV("TOP");
   WOWTR_Panel4Header2:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel4Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 580, -100);
   else
      WOWTR_Panel4Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 20, -100);
   end
   WOWTR_Panel4Header2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.savingUntranslatedTutorials)); -- Saving untranslated tutorials
   WOWTR_Panel4Header2:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton42 = CreateFrame("CheckButton", "WOWTR_CheckButton42", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton42:SetScript("OnClick",
      function(self) if (TT_PS["save"] == "1") then TT_PS["save"] = "0" else TT_PS["save"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton42:SetPoint("TOPLEFT", WOWTR_Panel4Header2, "TOPLEFT", 55, -20);
      WOWTR_CheckButton42.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header2, "TOPLEFT", -155, -30);
   else
      WOWTR_CheckButton42:SetPoint("TOPLEFT", WOWTR_Panel4Header2, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton42.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedTutorials) .. "|r"); -- Save untranslated tutorials
   WOWTR_CheckButton42.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton42:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedTutorials) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveUntranslatedTutorialsDESC, false,
            getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton42:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   if (#WOWTR_Fonts > 1) then
      local WOWTR_Panel4Header2f = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
      WOWTR_Panel4Header2f:SetFontObject(GameFontNormal);
      WOWTR_Panel4Header2f:SetJustifyH("LEFT");
      WOWTR_Panel4Header2f:SetJustifyV("TOP");
      WOWTR_Panel4Header2f:ClearAllPoints();
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_Panel4Header2f:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 545, -170);
      else
         WOWTR_Panel4Header2f:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 20, -170);
      end
      WOWTR_Panel4Header2f:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontSelectingFontHeader)); -- Select a font header
      WOWTR_Panel4Header2f:SetFont(WOWTR_Font2, 15);

      local WOWTR_Panel4Header2g = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
      WOWTR_Panel4Header2g:SetFontObject(GameFontNormal);
      WOWTR_Panel4Header2g:SetJustifyH("LEFT");
      WOWTR_Panel4Header2g:SetJustifyV("TOP");
      WOWTR_Panel4Header2g:ClearAllPoints();
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_Panel4Header2g:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 300, -170);
      else
         WOWTR_Panel4Header2g:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 290, -170);
      end
      WOWTR_Panel4Header2g:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontCurrentFont)); -- Current font:
      WOWTR_Panel4Header2g:SetFont(WOWTR_Font2, 15);

      local WOWTR_Panel4Header2h = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
      WOWTR_Panel4Header2h:SetFontObject(GameFontWhite);
      WOWTR_Panel4Header2h:SetJustifyH("LEFT");
      WOWTR_Panel4Header2h:SetJustifyV("TOP");
      WOWTR_Panel4Header2h:ClearAllPoints();
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_Panel4Header2h:SetPoint("TOPLEFT", WOWTR_Panel4Header2g, "TOPLEFT", 0, -30);
      else
         WOWTR_Panel4Header2h:SetPoint("TOPLEFT", WOWTR_Panel4Header2g, "TOPLEFT", 0, -30);
      end
      WOWTR_Panel4Header2h:SetText(QTR_PS["FontFile"]); -- current font file
      WOWTR_Panel4Header2h:SetFont(WOWTR_Font2, 13);

      local WOWTR_Panel4SelectF = CreateFrame("Frame", "WOWTR_Panel4SelectF", WOWTR_OptionPanel4,
         "UIDropDownMenuTemplate");
      WOWTR_Panel4SelectF:ClearAllPoints();
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_Panel4SelectF:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 460, -195);
      else
         WOWTR_Panel4SelectF:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 0, -195);
      end
      UIDropDownMenu_SetWidth(WOWTR_Panel4SelectF, 170);
      UIDropDownMenu_SetText(WOWTR_Panel4SelectF, WoWTR_Config_Interface.fontSelectFontFile); -- Select a font file
      UIDropDownMenu_Initialize(WOWTR_Panel4SelectF, function(self, level, _)
         for i, font in ipairs(WOWTR_Fonts) do
            local info = UIDropDownMenu_CreateInfo();
            info.text = font;
            --      info.text:SetFont(WOWTR_Font2, 13);
            info.value = font;
            info.func = function(self, arg1, arg2, checked) -- function is called when option is clicked
               QTR_PS["FontFile"] = self.value;
               WOWTR_Panel4Header2h:SetText(self.value);    -- Selected font
               WOWTR_Font2 = WoWTR_Localization.mainFolder .. "\\Fonts\\" .. self.value;
               WOWTR_Panel4Header2h:SetFont(WOWTR_Font2, 13);
               WOWTR_ReloadButtonUI:Show();
            end;
            UIDropDownMenu_AddButton(info);
         end
         UIDropDownMenu_SetSelectedValue(WOWTR_Panel4SelectF, QTR_PS["FontFile"]);
      end);
   end -- if

   local WOWTR_Panel4Separator = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel4Separator:SetFontObject(GameFontWhite);
   WOWTR_Panel4Separator:SetJustifyH("LEFT");
   WOWTR_Panel4Separator:SetJustifyV("TOP");
   WOWTR_Panel4Separator:ClearAllPoints();
   WOWTR_Panel4Separator:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 20, -250);
   local frame = WOWTR_OptionPanel4:CreateTexture(nil, "BACKGROUND")
   frame:SetSize(684, 1)
   frame:SetPoint("TOPLEFT", 0, -240)
   frame:SetColorTexture(0.2, 0.2, 0.2, 1)

   local WOWTR_OptionsHeaderIcon5 = WOWTR_OptionPanel4:CreateTexture(nil, "OVERLAY");
   WOWTR_OptionsHeaderIcon5:SetWidth(200);
   WOWTR_OptionsHeaderIcon5:SetHeight(200);
   WOWTR_OptionsHeaderIcon5:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\ui_mini.jpg"); -- WOWTR_OptionPanel4 thumbnail
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderIcon5:SetPoint("CENTER", -230, -100);
   else
      WOWTR_OptionsHeaderIcon5:SetPoint("CENTER", 230, -100);
   end

   local WOWTR_Panel4Header3 = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel4Header3:SetFontObject(GameFontNormal);
   WOWTR_Panel4Header3:SetJustifyH("LEFT");
   WOWTR_Panel4Header3:SetJustifyV("TOP");
   WOWTR_Panel4Header3:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel4Header3:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 480, -10);
   else
      WOWTR_Panel4Header3:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 0, -10);
   end
   WOWTR_Panel4Header3:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.translationUI)); -- Translation of user interface
   WOWTR_Panel4Header3:SetFont(WOWTR_Font2, 15);

   local WOWTR_Panel4Text1 = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel4Text1:SetFontObject(GameFontWhite);
   WOWTR_Panel4Text1:SetJustifyH("LEFT");
   WOWTR_Panel4Text1:SetJustifyV("TOP");
   WOWTR_Panel4Text1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel4Text1:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 480, -30);
   else
      WOWTR_Panel4Text1:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 0, -30);
   end
   WOWTR_Panel4Text1:SetWidth(640);
   WOWTR_Panel4Text1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationtxt));
   WOWTR_Panel4Text1:SetFont(WOWTR_Font2, 12);

   local WOWTR_CheckButton43 = CreateFrame("CheckButton", "WOWTR_CheckButton43", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton43:SetScript("OnClick",
      function(self) if (TT_PS["ui1"] == "1") then TT_PS["ui1"] = "0" else TT_PS["ui1"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton43:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 135, -45);
      WOWTR_CheckButton43.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 65, -55);
   else
      WOWTR_CheckButton43:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 10, -45);
   end
   WOWTR_CheckButton43.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI1) .. "|r");
   WOWTR_CheckButton43.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton43:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI1) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft1"):SetWidth(150);
      if (WoWTR_Localization.lang == 'AR') then
         getglobal("GameTooltipTextLeft1"):SetJustifyH("RIGHT");
      end
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslationUI1DESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton43:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton45 = CreateFrame("CheckButton", "WOWTR_CheckButton45", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton45:SetScript("OnClick",
      function(self) if (TT_PS["ui2"] == "1") then TT_PS["ui2"] = "0" else TT_PS["ui2"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton45:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 135, -75);
      WOWTR_CheckButton45.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 22, -85);
   else
      WOWTR_CheckButton45:SetPoint("TOPLEFT", WOWTR_CheckButton43, "TOPLEFT", 0, -28);
   end
   WOWTR_CheckButton45.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI2) .. "|r"); -- Display translation of user interface (Character Info)
   WOWTR_CheckButton45.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton45:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI2) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft1"):SetWidth(150);
      if (WoWTR_Localization.lang == 'AR') then
         getglobal("GameTooltipTextLeft1"):SetJustifyH("RIGHT");
      end
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslationUI2DESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton45:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton46 = CreateFrame("CheckButton", "WOWTR_CheckButton46", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton46:SetScript("OnClick",
      function(self) if (TT_PS["ui3"] == "1") then TT_PS["ui3"] = "0" else TT_PS["ui3"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton46:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 135, -105);
      WOWTR_CheckButton46.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 20, -115);
   else
      WOWTR_CheckButton46:SetPoint("TOPLEFT", WOWTR_CheckButton45, "TOPLEFT", 0, -28);
   end
   WOWTR_CheckButton46.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI3) .. "|r"); -- Display translation of user interface (Group Finder)
   WOWTR_CheckButton46.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton46:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI3) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft1"):SetWidth(150);
      if (WoWTR_Localization.lang == 'AR') then
         getglobal("GameTooltipTextLeft1"):SetJustifyH("RIGHT");
      end
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslationUI3DESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton46:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton50 = CreateFrame("CheckButton", "WOWTR_CheckButton50", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton50:SetScript("OnClick",
      function(self) if (TT_PS["ui7"] == "1") then TT_PS["ui7"] = "0" else TT_PS["ui7"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton50:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 135, -135);
      WOWTR_CheckButton50.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 61, -145);
   else
      WOWTR_CheckButton50:SetPoint("TOPLEFT", WOWTR_CheckButton46, "TOPLEFT", 0, -28);
   end
   WOWTR_CheckButton50.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI7) .. "|r"); -- Display translation of user interface (Group Finder)
   WOWTR_CheckButton50.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton50:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI7) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft1"):SetWidth(150);
      if (WoWTR_Localization.lang == 'AR') then
         getglobal("GameTooltipTextLeft1"):SetJustifyH("RIGHT");
      end
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslationUI7DESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton50:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton47 = CreateFrame("CheckButton", "WOWTR_CheckButton47", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton47:SetScript("OnClick",
      function(self) if (TT_PS["ui4"] == "1") then TT_PS["ui4"] = "0" else TT_PS["ui4"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton47:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", -100, -45);
      WOWTR_CheckButton47.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", -172, -55);
   else
      WOWTR_CheckButton47:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 230, -45);
   end
   WOWTR_CheckButton47.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI4) .. "|r"); -- Display translation of user interface (Collections Frame)
   WOWTR_CheckButton47.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton47:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI4) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft1"):SetWidth(150);
      if (WoWTR_Localization.lang == 'AR') then
         getglobal("GameTooltipTextLeft1"):SetJustifyH("RIGHT");
      end
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslationUI4DESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton47:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton48 = CreateFrame("CheckButton", "WOWTR_CheckButton48", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton48:SetScript("OnClick",
      function(self) if (TT_PS["ui5"] == "1") then TT_PS["ui5"] = "0" else TT_PS["ui5"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton48:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", -100, -75);
      WOWTR_CheckButton48.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", -190, -85);
   else
      WOWTR_CheckButton48:SetPoint("TOPLEFT", WOWTR_CheckButton47, "TOPLEFT", 0, -28);
   end
   WOWTR_CheckButton48.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI5) .. "|r"); -- Display translation of user interface (Advanture Guide)
   WOWTR_CheckButton48.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton48:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI5) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft1"):SetWidth(150);
      if (WoWTR_Localization.lang == 'AR') then
         getglobal("GameTooltipTextLeft1"):SetJustifyH("RIGHT");
      end
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslationUI5DESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton48:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton49 = CreateFrame("CheckButton", "WOWTR_CheckButton49", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton49:SetScript("OnClick",
      function(self) if (TT_PS["ui6"] == "1") then TT_PS["ui6"] = "0" else TT_PS["ui6"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton49:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", -100, -105);
      WOWTR_CheckButton49.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", -187, -115);
   else
      WOWTR_CheckButton49:SetPoint("TOPLEFT", WOWTR_CheckButton48, "TOPLEFT", 0, -28);
   end
   WOWTR_CheckButton49.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI6) .. "|r"); -- Display translation of user interface (Friend List)
   WOWTR_CheckButton49.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton49:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI6) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft1"):SetWidth(150);
      if (WoWTR_Localization.lang == 'AR') then
         getglobal("GameTooltipTextLeft1"):SetJustifyH("RIGHT");
      end
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslationUI6DESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton49:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton40 = CreateFrame("CheckButton", "WOWTR_CheckButton40", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton40:SetScript("OnClick",
      function(self) if (TT_PS["ui8"] == "1") then TT_PS["ui8"] = "0" else TT_PS["ui8"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton40:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", -100, -135);
      WOWTR_CheckButton40.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", -239, -145);
   else
      WOWTR_CheckButton40:SetPoint("TOPLEFT", WOWTR_CheckButton49, "TOPLEFT", 0, -28);
   end
   WOWTR_CheckButton40.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI8) .. "|r"); -- Display translation of user interface (Friend List)
   WOWTR_CheckButton40.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton40:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationUI8) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft1"):SetWidth(150);
      if (WoWTR_Localization.lang == 'AR') then
         getglobal("GameTooltipTextLeft1"):SetJustifyH("RIGHT");
      end
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslationUI8DESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton40:SetScript("OnLeave", function(self)
      GameTooltip:Hide()       -- Hide the tooltip
   end);
   WOWTR_CheckButton40:Hide(); -- Hide button
   TT_PS["ui8"] = "0";

   WOWTR_ReloadButtonUI = CreateFrame("BUTTON", nil, WOWTR_OptionPanel4, "UIPanelButtonTemplate");
   WOWTR_ReloadButtonUI:SetWidth(350);
   WOWTR_ReloadButtonUI:SetHeight(32);
   if (WoWTR_Localization.lang == 'AR') then
      local fo = WOWTR_ReloadButtonUI:CreateFontString();
      fo:SetFont(WOWTR_Font2, 13);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.ReloadButtonUI));
      WOWTR_ReloadButtonUI:SetFontString(fo);
   end
   WOWTR_ReloadButtonUI:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.ReloadButtonUI)); -- Przywróć ustawienia domyślne dodatku
   WOWTR_ReloadButtonUI:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_ReloadButtonUI:SetPoint("TOPLEFT", WOWTR_CheckButton46, "TOPLEFT", -320, -60);
   else
      WOWTR_ReloadButtonUI:SetPoint("TOPLEFT", WOWTR_CheckButton46, "TOPLEFT", 0, -60);
   end
   WOWTR_ReloadButtonUI:Hide();
   WOWTR_ReloadButtonUI:SetScript("OnClick", function() ReloadUI() end);
   WOWTR_CheckButton40:HookScript("OnClick", function() WOWTR_ReloadButtonUI:Show(); end);
   WOWTR_CheckButton43:HookScript("OnClick", function() WOWTR_ReloadButtonUI:Show(); end);
   WOWTR_CheckButton45:HookScript("OnClick", function() WOWTR_ReloadButtonUI:Show(); end);
   WOWTR_CheckButton46:HookScript("OnClick", function() WOWTR_ReloadButtonUI:Show(); end);
   WOWTR_CheckButton47:HookScript("OnClick", function() WOWTR_ReloadButtonUI:Show(); end);
   WOWTR_CheckButton48:HookScript("OnClick", function() WOWTR_ReloadButtonUI:Show(); end);
   WOWTR_CheckButton49:HookScript("OnClick", function() WOWTR_ReloadButtonUI:Show(); end);
   WOWTR_CheckButton50:HookScript("OnClick", function() WOWTR_ReloadButtonUI:Show(); end);

   local WOWTR_Panel4Header4 = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel4Header4:SetFontObject(GameFontNormal);
   WOWTR_Panel4Header4:SetJustifyH("LEFT");
   WOWTR_Panel4Header4:SetJustifyV("TOP");
   WOWTR_Panel4Header4:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel4Header4:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 470, -220);
   else
      WOWTR_Panel4Header4:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 0, -220);
   end
   WOWTR_Panel4Header4:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.savingTranslationUI)); -- Saving untranslated user interface
   WOWTR_Panel4Header4:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton44 = CreateFrame("CheckButton", "WOWTR_CheckButton44", WOWTR_OptionPanel4,
      "UICheckButtonTemplate");
   WOWTR_CheckButton44:SetScript("OnClick",
      function(self) if (TT_PS["saveui"] == "1") then TT_PS["saveui"] = "0" else TT_PS["saveui"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton44:SetPoint("TOPLEFT", WOWTR_Panel4Header4, "TOPLEFT", 145, -20);
      WOWTR_CheckButton44.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header4, "TOPLEFT", -105, -30);
   else
      WOWTR_CheckButton44:SetPoint("TOPLEFT", WOWTR_Panel4Header4, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton44.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.saveTranslationUI) .. "|r"); -- Save untranslated user interface
   WOWTR_CheckButton44.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton44:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveTranslationUI) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveTranslationUIDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton44:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   WOWTR_ResetButton2 = CreateFrame("BUTTON", nil, WOWTR_OptionPanel4, "UIPanelButtonTemplate");
   WOWTR_ResetButton2:SetWidth(204);
   WOWTR_ResetButton2:SetHeight(40);
   if (WoWTR_Localization.lang == 'AR') then
      local fo = WOWTR_ResetButton2:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(WoWTR_Localization.resetButton2);
      WOWTR_ResetButton2:SetFontString(fo);
   end
   WOWTR_ResetButton2:SetText(QTR_ReverseIfAR(WoWTR_Localization.resetButton2)); -- Przywróć ustawienia domyślne dodatku
   WOWTR_ResetButton2:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_ResetButton2:SetPoint("TOPLEFT", WOWTR_Panel4Header1, "TOPLEFT", -435, -450);
   else
      WOWTR_ResetButton2:SetPoint("TOPLEFT", WOWTR_Panel4Header1, "TOPLEFT", 449, -450);
   end
   WOWTR_ResetButton2:Show();
   WOWTR_ResetButton2:SetScript("OnClick", function()
      WOWTR_Confirmation1:Hide(); WOWTR_Confirmation2:Show();
   end);
   WOWTR_ResetButton2:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Localization.resetButton2Opis) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Localization.resetButton2OpisDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) ..
         NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                   --Show the tooltip
   end);
   WOWTR_ResetButton2:SetScript("OnLeave", function(self)
      GameTooltip:Hide() --Hide the tooltip
   end);
end
