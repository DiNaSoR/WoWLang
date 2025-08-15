function WOWTR_CreateOptionPanel3(WOWTR_OptionPanel3)
   ----- TAB 3

   local WOWTR_OptionsHeaderIcon3 = WOWTR_OptionPanel3:CreateTexture(nil, "OVERLAY");
   WOWTR_OptionsHeaderIcon3:SetWidth(200);
   WOWTR_OptionsHeaderIcon3:SetHeight(200);
   WOWTR_OptionsHeaderIcon3:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\movies_mini.jpg"); -- WOWTR_OptionPanel3 thumbnail
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderIcon3:SetPoint("CENTER", -230, 150);
   else
      WOWTR_OptionsHeaderIcon3:SetPoint("CENTER", 230, 150);
   end

   local WOWTR_Panel3Header1 = WOWTR_OptionPanel3:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel3Header1:SetFontObject(GameFontNormal);
   WOWTR_Panel3Header1:SetJustifyH("LEFT");
   WOWTR_Panel3Header1:SetJustifyV("TOP");
   WOWTR_Panel3Header1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel3Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel3, "TOPLEFT", 397, -25);
   else
      WOWTR_Panel3Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel3, "TOPLEFT", 20, -25);
   end
   WOWTR_Panel3Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.generalMainHeaderMF)); -- Subtitle translations
   WOWTR_Panel3Header1:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton31 = CreateFrame("CheckButton", "WOWTR_CheckButton31", WOWTR_OptionPanel3,
      "UICheckButtonTemplate");
   WOWTR_CheckButton31:SetScript("OnClick",
      function(self) if (MF_PM["active"] == "1") then MF_PM["active"] = "0" else MF_PM["active"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton31:SetPoint("TOPLEFT", WOWTR_Panel3Header1, "TOPLEFT", 240, -20);
      WOWTR_CheckButton31.Text:SetPoint("TOPLEFT", WOWTR_Panel3Header1, "TOPLEFT", 0, -30);
   else
      WOWTR_CheckButton31:SetPoint("TOPLEFT", WOWTR_Panel3Header1, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton31.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.activateSubtitleTranslations) .. "|r"); -- Activate subtitle translations
   WOWTR_CheckButton31.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton31:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.activateSubtitleTranslations) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.activateSubtitleTranslationsDESC, false,
            getglobal("GameTooltipTextLeft1"), WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                                                         -- Show the tooltip
   end);
   WOWTR_CheckButton31:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton32 = CreateFrame("CheckButton", "WOWTR_CheckButton32", WOWTR_OptionPanel3,
      "UICheckButtonTemplate");
   WOWTR_CheckButton32:SetScript("OnClick",
      function(self) if (MF_PM["intro"] == "1") then MF_PM["intro"] = "0" else MF_PM["intro"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton32:SetPoint("TOPLEFT", WOWTR_Panel3Header1, "TOPLEFT", 240, -50);
      WOWTR_CheckButton32.Text:SetPoint("TOPLEFT", WOWTR_Panel3Header1, "TOPLEFT", 50, -60);
   else
      WOWTR_CheckButton32:SetPoint("TOPLEFT", WOWTR_CheckButton31, "BOTTOMLEFT", 0, -20);
   end
   WOWTR_CheckButton32.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.subtitleIntro) .. "|r"); -- Display translated subtitles of Intro
   WOWTR_CheckButton32.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton32:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.subtitleIntro) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.subtitleIntroDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) ..
         NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                   -- Show the tooltip
   end);
   WOWTR_CheckButton32:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton33 = CreateFrame("CheckButton", "WOWTR_CheckButton33", WOWTR_OptionPanel3,
      "UICheckButtonTemplate");
   WOWTR_CheckButton33:SetScript("OnClick",
      function(self) if (MF_PM["movie"] == "1") then MF_PM["movie"] = "0" else MF_PM["movie"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton33:SetPoint("TOPLEFT", WOWTR_Panel3Header1, "TOPLEFT", 240, -80);
      WOWTR_CheckButton33.Text:SetPoint("TOPLEFT", WOWTR_Panel3Header1, "TOPLEFT", 44, -90);
   else
      WOWTR_CheckButton33:SetPoint("TOPLEFT", WOWTR_CheckButton32, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton33.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.subtitleMovies) .. "|r"); -- Display translated subtitle of Movies
   WOWTR_CheckButton33.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton33:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.subtitleMovies) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.subtitleMoviesDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) ..
         NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                   -- Show the tooltip
   end);
   WOWTR_CheckButton33:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton34 = CreateFrame("CheckButton", "WOWTR_CheckButton34", WOWTR_OptionPanel3,
      "UICheckButtonTemplate");
   WOWTR_CheckButton34:SetScript("OnClick",
      function(self) if (MF_PM["cinematic"] == "1") then MF_PM["cinematic"] = "0" else MF_PM["cinematic"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton34:SetPoint("TOPLEFT", WOWTR_Panel3Header1, "TOPLEFT", 240, -110);
      WOWTR_CheckButton34.Text:SetPoint("TOPLEFT", WOWTR_Panel3Header1, "TOPLEFT", 45, -120);
   else
      WOWTR_CheckButton34:SetPoint("TOPLEFT", WOWTR_CheckButton33, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton34.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.subtitleCinematics) .. "|r"); -- Display translated sybtitles of Cinematics
   WOWTR_CheckButton34.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton34:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.subtitleCinematics) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.subtitleCinematicsDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton34:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_Panel3Header2 = WOWTR_OptionPanel3:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel3Header2:SetFontObject(GameFontNormal);
   WOWTR_Panel3Header2:SetJustifyH("LEFT");
   WOWTR_Panel3Header2:SetJustifyV("TOP");
   WOWTR_Panel3Header2:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel3Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel3, "TOPLEFT", 582, -210);
   else
      WOWTR_Panel3Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel3, "TOPLEFT", 20, -210);
   end
   WOWTR_Panel3Header2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.savingUntranslatedSubtitles)); -- Saving untranslated subtitles
   WOWTR_Panel3Header2:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton35 = CreateFrame("CheckButton", "WOWTR_CheckButton35", WOWTR_OptionPanel3,
      "UICheckButtonTemplate");
   WOWTR_CheckButton35:SetScript("OnClick",
      function(self) if (MF_PM["save"] == "1") then MF_PM["save"] = "0" else MF_PM["save"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton35:SetPoint("TOPLEFT", WOWTR_Panel3Header2, "TOPLEFT", 55, -20);
      WOWTR_CheckButton35.Text:SetPoint("TOPLEFT", WOWTR_Panel3Header2, "TOPLEFT", -115, -30);
   else
      WOWTR_CheckButton35:SetPoint("TOPLEFT", WOWTR_Panel3Header2, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton35.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedSubtitles) .. "|r"); -- Save untranslated subtitles
   WOWTR_CheckButton35.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton35:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedSubtitles) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveUntranslatedSubtitlesDESC, false,
            getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton35:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   if (WoWTR_Localization.lang == 'AR') then -- part: Chat
      local WOWTR_Panel3Separator = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
      WOWTR_Panel3Separator:SetFontObject(GameFontWhite);
      WOWTR_Panel3Separator:SetJustifyH("LEFT");
      WOWTR_Panel3Separator:SetJustifyV("TOP");
      WOWTR_Panel3Separator:ClearAllPoints();
      WOWTR_Panel3Separator:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 50, -300);
      local frame3 = WOWTR_OptionPanel3:CreateTexture(nil, "BACKGROUND")
      frame3:SetSize(684, 1)
      frame3:SetPoint("TOPLEFT", 0, -300)
      frame3:SetColorTexture(0.2, 0.2, 0.2, 1)

      local WOWTR_OptionsHeaderIcon8 = WOWTR_OptionPanel3:CreateTexture(nil, "OVERLAY");
      WOWTR_OptionsHeaderIcon8:SetWidth(200);
      WOWTR_OptionsHeaderIcon8:SetHeight(200);
      WOWTR_OptionsHeaderIcon8:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\archat.jpg");
      WOWTR_OptionsHeaderIcon8:SetPoint("CENTER", -230, -150);

      local WOWTR_Panel3Header3 = WOWTR_OptionPanel3:CreateFontString(nil, "ARTWORK");
      WOWTR_Panel3Header3:SetFontObject(GameFontNormal);
      WOWTR_Panel3Header3:SetJustifyH("LEFT");
      WOWTR_Panel3Header3:SetJustifyV("TOP");
      WOWTR_Panel3Header3:ClearAllPoints();
      WOWTR_Panel3Header3:SetPoint("TOPLEFT", WOWTR_Panel3Separator, "TOPLEFT", 400, -20);
      WOWTR_Panel3Header3:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.chatService));
      WOWTR_Panel3Header3:SetFont(WOWTR_Font2, 15);

      local WOWTR_CheckButton36 = CreateFrame("CheckButton", "WOWTR_CheckButton36", WOWTR_OptionPanel3,
         "UICheckButtonTemplate");
      WOWTR_CheckButton36:SetScript("OnClick",
         function(self)
            if (CH_PM["active"] == "1") then
               CH_PM["active"] = "0"; CH_ToggleButton:SetText("EN"); CH_ToggleButton:Hide()
            else
               CH_PM["active"] = "1"; CH_ToggleButton:Show()
            end;
         end);
      WOWTR_CheckButton36:SetPoint("TOPLEFT", WOWTR_Panel3Header3, "TOPLEFT", 185, -20);
      WOWTR_CheckButton36.Text:SetPoint("TOPLEFT", WOWTR_Panel3Header3, "TOPLEFT", -10, -30);
      WOWTR_CheckButton36.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.activateChatService) ..
         "|r"); -- Activate service of arabic chat
      WOWTR_CheckButton36.Text:SetFont(WOWTR_Font2, 15);
      WOWTR_CheckButton36:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.activateChatService) .. NONBREAKINGSPACE, false); -- red color, no wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:AddLine(
            QTR_ExpandUnitInfo(WoWTR_Config_Interface.activateChatServiceDESC, false, getglobal("GameTooltipTextLeft1"),
               WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                      -- Show the tooltip
      end);
      WOWTR_CheckButton36:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);

      local WOWTR_CheckButton37 = CreateFrame("CheckButton", "WOWTR_CheckButton37", WOWTR_OptionPanel3,
         "UICheckButtonTemplate");
      WOWTR_CheckButton37:SetScript("OnClick",
         function(self) if (CH_PM["setsize"] == "1") then CH_PM["setsize"] = "0" else CH_PM["setsize"] = "1" end; end);
      WOWTR_CheckButton37:SetPoint("TOPLEFT", WOWTR_Panel3Header3, "TOPLEFT", 185, -50);
      WOWTR_CheckButton37.Text:SetPoint("TOPLEFT", WOWTR_Panel3Header3, "TOPLEFT", 48, -60);
      WOWTR_CheckButton37.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.chatFontActivate) .. "|r"); -- Activate font size changes
      WOWTR_CheckButton37.Text:SetFont(WOWTR_Font2, 15);
      WOWTR_CheckButton37:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.chatFontActivate) .. NONBREAKINGSPACE, false); -- red color, no wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:AddLine(
            QTR_ExpandUnitInfo(WoWTR_Config_Interface.chatFontActivateDESC, false, getglobal("GameTooltipTextLeft1"),
               WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                      -- Show the tooltip
      end);
      WOWTR_CheckButton37:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);

      local WOWTR_slider6 = CreateFrame("Slider", "WOWTR_slider6", WOWTR_OptionPanel3, "OptionsSliderTemplate");
      WOWTR_slider6:SetPoint("TOPLEFT", WOWTR_CheckButton37, "BOTTOMLEFT", -150, -30);
      WOWTR_slider6:SetMinMaxValues(10, 20);
      WOWTR_slider6.minValue, WOWTR_slider6.maxValue = WOWTR_slider6:GetMinMaxValues();
      WOWTR_slider6.Low:SetText(WOWTR_slider6.minValue);
      WOWTR_slider6.High:SetText(WOWTR_slider6.maxValue);
      getglobal(WOWTR_slider6:GetName() .. 'Text'):SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontsizeBubbles));
      getglobal(WOWTR_slider6:GetName() .. 'Text'):SetFont(WOWTR_Font2, 11);
      if CH_PM and CH_PM["fontsize"] then
         local fontsize = tonumber(CH_PM["fontsize"])
         if fontsize then
            WOWTR_slider6:SetValue(fontsize);
         else
            WOWTR_slider6:SetValue(13);
         end
      else
         WOWTR_slider6:SetValue(13);
      end
      WOWTR_slider6:SetValueStep(1);
      WOWTR_slider6:SetScript("OnValueChanged", function(self, event, arg1)
         CH_PM["fontsize"] = string.format("%d", event);
         WOWTR_sliderVal6:SetText(CH_PM["fontsize"]);
      end);
      WOWTR_sliderVal6 = WOWTR_OptionPanel3:CreateFontString(nil, "ARTWORK");
      WOWTR_sliderVal6:SetFontObject(GameFontNormal);
      WOWTR_sliderVal6:SetJustifyH("CENTER");
      WOWTR_sliderVal6:SetJustifyV("TOP");
      WOWTR_sliderVal6:ClearAllPoints();
      WOWTR_sliderVal6:SetPoint("CENTER", WOWTR_slider6, "CENTER", 0, -12);
      if CH_PM and CH_PM["fontsize"] then
        WOWTR_sliderVal6:SetText(CH_PM["fontsize"]);
      end
      WOWTR_sliderVal6:SetFont(WOWTR_Font2, 13);
   end
end
