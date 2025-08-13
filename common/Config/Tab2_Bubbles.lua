function WOWTR_CreateOptionPanel2(WOWTR_OptionPanel2)
   ----- TAB 2

   local WOWTR_OptionsHeaderIcon2 = WOWTR_OptionPanel2:CreateTexture(nil, "OVERLAY");
   WOWTR_OptionsHeaderIcon2:SetWidth(200);
   WOWTR_OptionsHeaderIcon2:SetHeight(200);
   WOWTR_OptionsHeaderIcon2:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\bubbles_mini.jpg"); -- WOWTR_OptionPanel2 thumbnail
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderIcon2:SetPoint("CENTER", -230, 150);
   else
      WOWTR_OptionsHeaderIcon2:SetPoint("CENTER", 230, 150);
   end

   local WOWTR_Panel2Header1 = WOWTR_OptionPanel2:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel2Header1:SetFontObject(GameFontNormal);
   WOWTR_Panel2Header1:SetJustifyH("LEFT");
   WOWTR_Panel2Header1:SetJustifyV("TOP");
   WOWTR_Panel2Header1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel2Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel2, "TOPLEFT", 500, -25);
   else
      WOWTR_Panel2Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel2, "TOPLEFT", 20, -25);
   end
   WOWTR_Panel2Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.generalMainHeaderBB)); -- Bubbles translations
   WOWTR_Panel2Header1:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton21 = CreateFrame("CheckButton", "WOWTR_CheckButton21", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton21:SetScript("OnClick",
      function(self) if (BB_PM["active"] == "1") then BB_PM["active"] = "0" else BB_PM["active"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton21:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", 135, -20);
      WOWTR_CheckButton21.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -7, -30);
   else
      WOWTR_CheckButton21:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton21.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.activateBubblesTranslations) .. "|r"); -- Activate bubble translations
   WOWTR_CheckButton21.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton21:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.activateBubblesTranslations) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.activateBubblesTranslationsDESC, false,
            getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton21:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton22 = CreateFrame("CheckButton", "WOWTR_CheckButton22", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton22:SetScript("OnClick",
      function(self) if (BB_PM["chat-en"] == "1") then BB_PM["chat-en"] = "0" else BB_PM["chat-en"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton22:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", 135, -70);
      WOWTR_CheckButton22.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -75, -80);
   else
      WOWTR_CheckButton22:SetPoint("TOPLEFT", WOWTR_CheckButton21, "BOTTOMLEFT", 0, -20);
   end
   WOWTR_CheckButton22.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayOriginalTexts) .. "|r"); -- Display original text in chat frame
   WOWTR_CheckButton22.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton22:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayOriginalTexts) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayOriginalTextsDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton22:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton23 = CreateFrame("CheckButton", "WOWTR_CheckButton23", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton23:SetScript("OnClick",
      function(self) if (BB_PM["chat-tr"] == "1") then BB_PM["chat-tr"] = "0" else BB_PM["chat-tr"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton23:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", 135, -100);
      WOWTR_CheckButton23.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -91, -110);
   else
      WOWTR_CheckButton23:SetPoint("TOPLEFT", WOWTR_CheckButton22, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton23.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslatedTexts) ..
      "|r"); -- Display translated text in chat frame
   WOWTR_CheckButton23.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton23:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslatedTexts) .. NONBREAKINGSPACE, false); -- red color, no wrap
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslatedTextsDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show() -- Show the tooltip
   end);
   WOWTR_CheckButton23:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton24 = CreateFrame("CheckButton", "WOWTR_CheckButton24", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton24:SetScript("OnClick",
      function(self)
         if (BB_PM["sex"] == "2") then
            BB_PM["sex"] = "4"; WOWTR_CheckButton26:SetChecked(true);
         else
            BB_PM["sex"] = "2"; WOWTR_CheckButton25:SetChecked(false); WOWTR_CheckButton26:SetChecked(false);
         end;
      end);
   WOWTR_CheckButton24:SetChecked(BB_PM["sex"] == "2")
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton24:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", 135, -130);
      WOWTR_CheckButton24.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -105, -140);
   else
      WOWTR_CheckButton24:SetPoint("TOPLEFT", WOWTR_CheckButton23, "BOTTOMLEFT", 0, -20);
   end
   WOWTR_CheckButton24.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.choiceGender1OfPlayer) .. "|r"); -- Choice of male expression
   WOWTR_CheckButton24.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton24:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.choiceGender1OfPlayer) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.choiceGender1OfPlayerDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton24:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton25 = CreateFrame("CheckButton", "WOWTR_CheckButton25", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton25:SetScript("OnClick",
      function(self)
         if (BB_PM["sex"] == "3") then
            BB_PM["sex"] = "4"; WOWTR_CheckButton26:SetChecked(true);
         else
            BB_PM["sex"] = "3"; WOWTR_CheckButton24:SetChecked(false); WOWTR_CheckButton26:SetChecked(false);
         end;
      end);
   WOWTR_CheckButton25:SetChecked(BB_PM["sex"] == "3")
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton25:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", 135, -160);
      WOWTR_CheckButton25.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -103, -170);
   else
      WOWTR_CheckButton25:SetPoint("TOPLEFT", WOWTR_CheckButton24, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton25.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.choiceGender2OfPlayer) .. "|r"); -- Choice of female expression
   WOWTR_CheckButton25.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton25:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.choiceGender2OfPlayer) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.choiceGender2OfPlayerDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton25:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton26 = CreateFrame("CheckButton", "WOWTR_CheckButton26", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton26:SetScript("OnClick",
      function(self)
         if (BB_PM["sex"] == "4") then
            BB_PM["sex"] = "2"; WOWTR_CheckButton24:SetChecked(true);
         else
            BB_PM["sex"] = "4"; WOWTR_CheckButton24:SetChecked(false); WOWTR_CheckButton25:SetChecked(false);
         end;
      end);
   WOWTR_CheckButton26:SetChecked(BB_PM["sex"] == "4")
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton26:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", 135, -190);
      WOWTR_CheckButton26.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -106, -200);
   else
      WOWTR_CheckButton26:SetPoint("TOPLEFT", WOWTR_CheckButton25, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton26.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.choiceGender3OfPlayer) .. "|r"); -- Choice of expression for the player depending
   WOWTR_CheckButton26.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton26:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.choiceGender3OfPlayer) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.choiceGender3OfPlayerDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton26:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton2d1 = CreateFrame("CheckButton", "WOWTR_CheckButton2d1", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton2d1:SetScript("OnClick",
      function(self) if (BB_PM["dungeon"] == "1") then BB_PM["dungeon"] = "0" else BB_PM["dungeon"] = "1"; end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton2d1:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -200, -220);
      WOWTR_CheckButton2d1.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -430, -230);
   elseif ((WoWTR_Localization.lang == 'TR') or (WoWTR_Localization.lang == 'UA')) then
      WOWTR_CheckButton2d1:SetPoint("TOPLEFT", WOWTR_CheckButton26, "BOTTOMLEFT", 310, 0);
   else
      WOWTR_CheckButton2d1:SetPoint("TOPLEFT", WOWTR_CheckButton26, "BOTTOMLEFT", 400, 0);
   end
   WOWTR_CheckButton2d1.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.showBubblesInDungeon) .. "|r"); -- show bubbles in dungeon
   WOWTR_CheckButton2d1.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton2d1:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.showBubblesInDungeon) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.showBubblesInDungeonDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton2d1:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton2d2 = CreateFrame("CheckButton", "WOWTR_CheckButton2d2", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton2d2:SetScript("OnClick", function(self)
      if (BB_PM["dungeonF"] == "1") then
         BB_PM["dungeonF"] = "0";
         WOWTR_SetDungeonFrames(WOWBB1, false);
         WOWTR_SetDungeonFrames(WOWBB2, false);
         WOWTR_SetDungeonFrames(WOWBB3, false);
         WOWTR_SetDungeonFrames(WOWBB4, false);
         WOWTR_SetDungeonFrames(WOWBB5, false);
      else
         BB_PM["dungeonF"] = "1";
         WOWTR_SetDungeonFrames(WOWBB1, true, 0);
         WOWTR_SetDungeonFrames(WOWBB2, true, 250);
         WOWTR_SetDungeonFrames(WOWBB3, true, -250);
         WOWTR_SetDungeonFrames(WOWBB4, true, 500);
         WOWTR_SetDungeonFrames(WOWBB5, true, -500);
      end;
   end);

   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton2d2:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -200, -250);
      WOWTR_CheckButton2d2.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header1, "TOPLEFT", -395, -260);
   else
      WOWTR_CheckButton2d2:SetPoint("TOPLEFT", WOWTR_CheckButton2d1, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton2d2.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.setDungeonFrames) .. "|r"); -- show bubbles in dungeon
   WOWTR_CheckButton2d2.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton2d2:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.setDungeonFrames) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.setDungeonFramesDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton2d2:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_slider5 = CreateFrame("Slider", "WOWTR_slider5", WOWTR_OptionPanel2, "OptionsSliderTemplate");
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_slider5:SetPoint("TOPLEFT", WOWTR_CheckButton2d2, "BOTTOMLEFT", -120, -25);
   else
      WOWTR_slider5:SetPoint("TOPLEFT", WOWTR_CheckButton2d2, "BOTTOMLEFT", 20, -30);
   end
   WOWTR_slider5:SetMinMaxValues(3, 10);
   WOWTR_slider5.minValue, WOWTR_slider5.maxValue = WOWTR_slider5:GetMinMaxValues();
   WOWTR_slider5.Low:SetText(WOWTR_slider5.minValue);
   WOWTR_slider5.High:SetText(WOWTR_slider5.maxValue);
   getglobal(WOWTR_slider5:GetName() .. 'Text'):SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.timerDisplay));
   getglobal(WOWTR_slider5:GetName() .. 'Text'):SetFont(WOWTR_Font2, 11);
   WOWTR_slider5:SetValue(tonumber(BB_PM["timeDisplay"]));
   WOWTR_slider5:SetValueStep(1);
   WOWTR_slider5:SetScript("OnValueChanged", function(self, event, arg1)
      BB_PM["timeDisplay"] = string.format("%d", event);
      WOWTR_sliderVal5:SetText(BB_PM["timeDisplay"]);
   end);
   WOWTR_sliderVal5 = WOWTR_OptionPanel2:CreateFontString(nil, "ARTWORK");
   WOWTR_sliderVal5:SetFontObject(GameFontNormal);
   WOWTR_sliderVal5:SetJustifyH("CENTER");
   WOWTR_sliderVal5:SetJustifyV("TOP");
   WOWTR_sliderVal5:ClearAllPoints();
   WOWTR_sliderVal5:SetPoint("CENTER", WOWTR_slider5, "CENTER", 0, -12);
   WOWTR_sliderVal5:SetText(BB_PM["timeDisplay"]);
   WOWTR_sliderVal5:SetFont(WOWTR_Font2, 13);

   local WOWTR_Panel2Header2 = WOWTR_OptionPanel2:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel2Header2:SetFontObject(GameFontNormal);
   WOWTR_Panel2Header2:SetJustifyH("LEFT");
   WOWTR_Panel2Header2:SetJustifyV("TOP");
   WOWTR_Panel2Header2:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel2Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel2, "TOPLEFT", 579, -290);
   else
      WOWTR_Panel2Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel2, "TOPLEFT", 20, -290);
   end
   WOWTR_Panel2Header2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.savingUntranslatedBubbles)); -- Saving untranslated bubble texts
   WOWTR_Panel2Header2:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton27 = CreateFrame("CheckButton", "WOWTR_CheckButton27", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton27:SetScript("OnClick",
      function(self) if (BB_PM["saveBN"] == "1") then BB_PM["saveBM"] = "0" else BB_PM["saveBM"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton27:SetPoint("TOPLEFT", WOWTR_Panel2Header2, "TOPLEFT", 55, -20);
      WOWTR_CheckButton27.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header2, "TOPLEFT", -112, -30);
   else
      WOWTR_CheckButton27:SetPoint("TOPLEFT", WOWTR_Panel2Header2, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton27.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedBubbles) ..
      "|r"); -- Save untranslated bubbles
   WOWTR_CheckButton27.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton27:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedBubbles) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveUntranslatedBubblesDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton27:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_Panel2Header3 = WOWTR_OptionPanel2:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel2Header3:SetFontObject(GameFontNormal);
   WOWTR_Panel2Header3:SetJustifyH("LEFT");
   WOWTR_Panel2Header3:SetJustifyV("TOP");
   WOWTR_Panel2Header3:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel2Header3:SetPoint("TOPLEFT", WOWTR_OptionPanel2, "TOPLEFT", 600, -370);
   else
      WOWTR_Panel2Header3:SetPoint("TOPLEFT", WOWTR_OptionPanel2, "TOPLEFT", 20, -370);
   end
   WOWTR_Panel2Header3:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontSizeHeader)); -- Font size of bubbles
   WOWTR_Panel2Header3:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton28 = CreateFrame("CheckButton", "WOWTR_CheckButton28", WOWTR_OptionPanel2,
      "UICheckButtonTemplate");
   WOWTR_CheckButton28:SetScript("OnClick",
      function(self) if (BB_PM["setsize"] == "1") then BB_PM["setsize"] = "0" else BB_PM["setsize"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton28:SetPoint("TOPLEFT", WOWTR_Panel2Header3, "TOPLEFT", 35, -20);
      WOWTR_CheckButton28.Text:SetPoint("TOPLEFT", WOWTR_Panel2Header3, "TOPLEFT", -100, -30);
   else
      WOWTR_CheckButton28:SetPoint("TOPLEFT", WOWTR_Panel2Header3, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton28.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.setFontActivate) .. "|r"); -- Activate font size changes
   WOWTR_CheckButton28.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton28:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.setFontActivate) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.setFontActivateDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton28:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_slider1 = CreateFrame("Slider", "WOWTR_slider1", WOWTR_OptionPanel2, "OptionsSliderTemplate");
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_slider1:SetPoint("TOPLEFT", WOWTR_CheckButton28, "BOTTOMLEFT", -120, -30);
   else
      WOWTR_slider1:SetPoint("TOPLEFT", WOWTR_CheckButton28, "BOTTOMLEFT", 20, -30);
   end
   WOWTR_slider1:SetMinMaxValues(10, 20);
   WOWTR_slider1.minValue, WOWTR_slider1.maxValue = WOWTR_slider1:GetMinMaxValues();
   WOWTR_slider1.Low:SetText(WOWTR_slider1.minValue);
   WOWTR_slider1.High:SetText(WOWTR_slider1.maxValue);
   getglobal(WOWTR_slider1:GetName() .. 'Text'):SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontsizeBubbles));
   getglobal(WOWTR_slider1:GetName() .. 'Text'):SetFont(WOWTR_Font2, 11);
   WOWTR_slider1:SetValue(tonumber(BB_PM["fontsize"]));
   WOWTR_slider1:SetValueStep(1);
   WOWTR_slider1:SetScript("OnValueChanged", function(self, event, arg1)
      BB_PM["fontsize"] = string.format("%d", event);
      WOWTR_sliderVal1:SetText(BB_PM["fontsize"]);
      WOWTR_Opis1:SetFont(WOWTR_Font2, event);
   end);
   WOWTR_sliderVal1 = WOWTR_OptionPanel2:CreateFontString(nil, "ARTWORK");
   WOWTR_sliderVal1:SetFontObject(GameFontNormal);
   WOWTR_sliderVal1:SetJustifyH("CENTER");
   WOWTR_sliderVal1:SetJustifyV("TOP");
   WOWTR_sliderVal1:ClearAllPoints();
   WOWTR_sliderVal1:SetPoint("CENTER", WOWTR_slider1, "CENTER", 0, -12);
   WOWTR_sliderVal1:SetText(BB_PM["fontsize"]);
   WOWTR_sliderVal1:SetFont(WOWTR_Font2, 13);

   WOWTR_Opis1 = WOWTR_OptionPanel2:CreateFontString(nil, "ARTWORK");
   WOWTR_Opis1:SetFontObject(GameFontNormalLarge);
   WOWTR_Opis1:SetJustifyH("LEFT");
   WOWTR_Opis1:SetJustifyV("TOP");
   WOWTR_Opis1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Opis1:SetPoint("TOPLEFT", WOWTR_slider1, "BOTTOMLEFT", -200, 30);
   else
      WOWTR_Opis1:SetPoint("TOPLEFT", WOWTR_slider1, "BOTTOMLEFT", 200, 30);
   end
   local fontsize = tonumber(BB_PM["fontsize"]);
   if (BB_PM["setsize"] == "1") then
      WOWTR_Opis1:SetFont(WOWTR_Font2, fontsize);
   else
      WOWTR_Opis1:SetFont(WOWTR_Font2, 13);
   end
   WOWTR_Opis1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.sampleText));
end
