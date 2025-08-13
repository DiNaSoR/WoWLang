function WOWTR_CreateOptionPanel1(WOWTR_OptionPanel1)
   ----- TAB 1

   local WOWTR_OptionsHeaderIcon1 = WOWTR_OptionPanel1:CreateTexture(nil, "OVERLAY");
   WOWTR_OptionsHeaderIcon1:SetWidth(200);
   WOWTR_OptionsHeaderIcon1:SetHeight(200);
   WOWTR_OptionsHeaderIcon1:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\quests_mini.jpg"); -- WOWTR_OptionPanel1 thumbnail
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderIcon1:SetPoint("CENTER", -230, 150);
   else
      WOWTR_OptionsHeaderIcon1:SetPoint("CENTER", 230, 150);
   end

   local WOWTR_Panel1Header1 = WOWTR_OptionPanel1:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel1Header1:SetFontObject(GameFontNormal);
   WOWTR_Panel1Header1:SetJustifyH("LEFT");
   WOWTR_Panel1Header1:SetJustifyV("TOP");
   WOWTR_Panel1Header1:ClearAllPoints();
   WOWTR_Panel1Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.generalMainHeaderQS)); -- Quest translations
   WOWTR_Panel1Header1:SetFont(WOWTR_Font2, 15);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel1Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel1, "TOPLEFT", 525, -25);
   else
      WOWTR_Panel1Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel1, "TOPLEFT", 20, -25);
   end

   local WOWTR_CheckButton11 = CreateFrame("CheckButton", "WOWTR_CheckButton11", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton11:SetScript("OnClick",
      function(self) if (QTR_PS["active"] == "1") then QTR_PS["active"] = "0" else QTR_PS["active"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton11:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", 110, -20);
      WOWTR_CheckButton11.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", -13, -30);
   else
      WOWTR_CheckButton11:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton11.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.activateQuestsTranslations) .. "|r"); -- Activate quest translations
   WOWTR_CheckButton11.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton11:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT");
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.activateQuestsTranslations) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.activateQuestsTranslationsDESC, false,
            getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton11:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton12 = CreateFrame("CheckButton", "WOWTR_CheckButton12", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton12:SetScript("OnClick",
      function(self) if (QTR_PS["transtitle"] == "1") then QTR_PS["transtitle"] = "0" else QTR_PS["transtitle"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton12:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", 110, -70);
      WOWTR_CheckButton12.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", -50, -80);
   else
      WOWTR_CheckButton12:SetPoint("TOPLEFT", WOWTR_CheckButton11, "BOTTOMLEFT", 0, -20);
   end
   WOWTR_CheckButton12.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateQuestTitles) .. "|r"); -- Display translation of quest TITLES
   WOWTR_CheckButton12.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton12:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateQuestTitles) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateQuestTitlesDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton12:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton13 = CreateFrame("CheckButton", "WOWTR_CheckButton13", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton13:SetScript("OnClick",
      function(self) if (QTR_PS["gossip"] == "1") then QTR_PS["gossip"] = "0" else QTR_PS["gossip"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton13:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", 110, -100);
      WOWTR_CheckButton13.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", -105, -110);
   else
      WOWTR_CheckButton13:SetPoint("TOPLEFT", WOWTR_CheckButton12, "BOTTOMLEFT", 0, 5);
   end
   WOWTR_CheckButton13.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateGossipTexts) .. "|r"); -- Display translation of GOSSIP texts
   WOWTR_CheckButton13.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton13:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateGossipTexts) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateGossipTextsDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton13:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton1a = CreateFrame("CheckButton", "WOWTR_CheckButton1a", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton1a:SetScript("OnClick",
      function(self) if (QTR_PS["ownnames"] == "1") then QTR_PS["ownnames"] = "0" else QTR_PS["ownnames"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton1a:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", 110, -130);
      WOWTR_CheckButton1a.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", -148, -140);
   else
      WOWTR_CheckButton1a:SetPoint("TOPLEFT", WOWTR_CheckButton13, "BOTTOMLEFT", 0, 5);
   end
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton1a.Text:SetText(QTR_ReverseIfAR(WOW_ZmienKody(WoWTR_Config_Interface.translateOwnNames) .. "")); -- Display translation of GOSSIP texts
   else
      WOWTR_CheckButton1a.Text:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.translateOwnNames));                      -- Display translation of GOSSIP texts
   end
   WOWTR_CheckButton1a.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton1a:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      if (WoWTR_Localization.lang == 'AR') then
         GameTooltip:AddLine(
            QTR_ReverseIfAR(WOW_ZmienKody(WoWTR_Config_Interface.translateOwnNames)) .. NONBREAKINGSPACE,
            false);
      else
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateOwnNames) .. NONBREAKINGSPACE, false);
      end
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateOwnNamesDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton1a:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   -- QUEST TRACKER
   local WOWTR_CheckButton14 = CreateFrame("CheckButton", "WOWTR_CheckButton14", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton14:SetScript("OnClick",
      function(self) if (QTR_PS["tracker"] == "1") then QTR_PS["tracker"] = "0" else QTR_PS["tracker"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton14:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", 110, -160);
      WOWTR_CheckButton14.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header1, "TOPLEFT", -108, -170);
   else
      WOWTR_CheckButton14:SetPoint("TOPLEFT", WOWTR_CheckButton1a, "BOTTOMLEFT", 0, 5);
   end
   WOWTR_CheckButton14.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.translateTrackObjectives) .. "|r"); -- Display translation of GOSSIP texts
   WOWTR_CheckButton14.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton14:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateTrackObjectives) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateTrackObjectivesDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton14:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton14:Hide(); -- opcja Quest Tracker jest wyłączona w wersji AR
   end

   local WOWTR_slider4 = CreateFrame("Slider", "WOWTR_slider4", WOWTR_OptionPanel1, "OptionsSliderTemplate");
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_slider4:SetPoint("TOPLEFT", WOWTR_CheckButton14, "BOTTOMLEFT", -120, -30);
   else
      WOWTR_slider4:SetPoint("TOPLEFT", WOWTR_CheckButton14, "BOTTOMLEFT", 0, -30);
   end
   WOWTR_slider4:SetMinMaxValues(11, 14);
   WOWTR_slider4.minValue, WOWTR_slider4.maxValue = WOWTR_slider4:GetMinMaxValues();
   WOWTR_slider4.Low:SetText(WOWTR_slider4.minValue);
   WOWTR_slider4.High:SetText(WOWTR_slider4.maxValue);
   getglobal(WOWTR_slider4:GetName() .. 'Text'):SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontsizeBubbles));
   getglobal(WOWTR_slider4:GetName() .. 'Text'):SetFont(WOWTR_Font2, 11);
   WOWTR_slider4:SetValue(tonumber(QTR_PS["fontsize"]));
   WOWTR_slider4:SetValueStep(1);
   WOWTR_slider4:SetScript("OnValueChanged", function(self, event, arg1)
      QTR_PS["fontsize"] = string.format("%d", event);
      WOWTR_sliderVal4:SetText(QTR_PS["fontsize"]);
      WOWTR_Opis4:SetFont(WOWTR_Font2, event);
   end);
   WOWTR_sliderVal4 = WOWTR_OptionPanel1:CreateFontString(nil, "ARTWORK");
   WOWTR_sliderVal4:SetFontObject(GameFontNormal);
   WOWTR_sliderVal4:SetJustifyH("CENTER");
   WOWTR_sliderVal4:SetJustifyV("TOP");
   WOWTR_sliderVal4:ClearAllPoints();
   WOWTR_sliderVal4:SetPoint("CENTER", WOWTR_slider4, "CENTER", 0, -12);
   WOWTR_sliderVal4:SetText(QTR_PS["fontsize"]);
   WOWTR_sliderVal4:SetFont(WOWTR_Font2, 13);

   WOWTR_Opis4 = WOWTR_OptionPanel1:CreateFontString(nil, "ARTWORK");
   WOWTR_Opis4:SetFontObject(GameFontNormalLarge);
   WOWTR_Opis4:SetJustifyH("LEFT");
   WOWTR_Opis4:SetJustifyV("TOP");
   WOWTR_Opis4:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Opis4:SetPoint("TOPLEFT", WOWTR_slider4, "BOTTOMLEFT", -230, 20);
   else
      WOWTR_Opis4:SetPoint("TOPLEFT", WOWTR_slider4, "BOTTOMLEFT", 180, 30);
   end
   local fontsize = tonumber(QTR_PS["fontsize"]);
   WOWTR_Opis4:SetFont(WOWTR_Font2, fontsize);
   WOWTR_Opis4:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.sampleGossipText));

   local WOWTR_CheckButton1c = CreateFrame("CheckButton", "WOWTR_CheckButton1c", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton1c:SetScript("OnClick",
      function(self) if (QTR_PS["en_first"] == "1") then QTR_PS["en_first"] = "0" else QTR_PS["en_first"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton1c:SetPoint("TOPLEFT", WOWTR_Opis4, "TOPLEFT", -120, 0);
      WOWTR_CheckButton1c.Text:SetPoint("TOPLEFT", WOWTR_Opis4, "TOPLEFT", -265, -7);
   else
      WOWTR_CheckButton1c:SetPoint("TOPLEFT", WOWTR_Opis4, "TOPLEFT", 200, 0);
   end
   WOWTR_CheckButton1c.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayENfirst) .. "|r"); -- Display text in English first
   WOWTR_CheckButton1c.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton1c:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayENfirst) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayENfirstDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) ..
         NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                   -- Show the tooltip
   end);
   WOWTR_CheckButton1c:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_Panel1Header2 = WOWTR_OptionPanel1:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel1Header2:SetFontObject(GameFontNormal);
   WOWTR_Panel1Header2:SetJustifyH("LEFT");
   WOWTR_Panel1Header2:SetJustifyV("TOP");
   WOWTR_Panel1Header2:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel1Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel1, "TOPLEFT", 580, -290);
   else
      WOWTR_Panel1Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel1, "TOPLEFT", 20, -290);
   end
   WOWTR_Panel1Header2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.savingUntranslatedQuests)); -- Saving untranslated quests and gossip texts
   WOWTR_Panel1Header2:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton15 = CreateFrame("CheckButton", "WOWTR_CheckButton15", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton15:SetScript("OnClick",
      function(self) if (QTR_PS["saveQS"] == "1") then QTR_PS["saveQS"] = "0" else QTR_PS["saveQS"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton15:SetPoint("TOPLEFT", WOWTR_Panel1Header2, "TOPLEFT", 55, -20);
      WOWTR_CheckButton15.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header2, "TOPLEFT", -95, -30);
   else
      WOWTR_CheckButton15:SetPoint("TOPLEFT", WOWTR_Panel1Header2, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton15.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedQuests) ..
      "|r"); -- Save untranslated quests
   WOWTR_CheckButton15.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton15:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedQuests) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveUntranslatedQuestsDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton15:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton16 = CreateFrame("CheckButton", "WOWTR_CheckButton16", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton16:SetScript("OnClick",
      function(self) if (QTR_PS["saveGS"] == "1") then QTR_PS["saveGS"] = "0" else QTR_PS["saveGS"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton16:SetPoint("TOPLEFT", WOWTR_Panel1Header2, "TOPLEFT", 55, -50);
      WOWTR_CheckButton16.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header2, "TOPLEFT", -138, -60);
   else
      WOWTR_CheckButton16:SetPoint("TOPLEFT", WOWTR_CheckButton15, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton16.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedGossip) ..
      "|r"); -- Save untranslated gossip texts
   WOWTR_CheckButton16.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton16:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedGossip) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveUntranslatedGossipDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton16:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_Panel1Header3 = WOWTR_OptionPanel1:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel1Header3:SetFontObject(GameFontNormal);
   WOWTR_Panel1Header3:SetJustifyH("LEFT");
   WOWTR_Panel1Header3:SetJustifyV("TOP");
   WOWTR_Panel1Header3:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel1Header3:SetPoint("TOPLEFT", WOWTR_OptionPanel1, "TOPLEFT", 620, -390);
   else
      WOWTR_Panel1Header3:SetPoint("TOPLEFT", WOWTR_OptionPanel1, "TOPLEFT", 20, -400);
   end
   WOWTR_Panel1Header3:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.integrationWithOtherAddons)); -- Integration with other addons
   WOWTR_Panel1Header3:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton17 = CreateFrame("CheckButton", "WOWTR_CheckButton17", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton17:SetScript("OnClick",
      function(self) if (QTR_PS["immersion"] == "1") then QTR_PS["immersion"] = "0" else QTR_PS["immersion"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton17:SetPoint("TOPLEFT", WOWTR_Panel1Header3, "TOPLEFT", 12, -20);
      WOWTR_CheckButton17.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header3, "TOPLEFT", -210, -30);
   else
      WOWTR_CheckButton17:SetPoint("TOPLEFT", WOWTR_Panel1Header3, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton17.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateImmersion) .. "|r"); -- Display translation in Immersion addon
   WOWTR_CheckButton17.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton17:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateImmersion) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateImmersionDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton17:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton18 = CreateFrame("CheckButton", "WOWTR_CheckButton18", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton18:SetScript("OnClick",
      function(self) if (QTR_PS["storyline"] == "1") then QTR_PS["storyline"] = "0" else QTR_PS["storyline"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton18:SetPoint("TOPLEFT", WOWTR_Panel1Header3, "TOPLEFT", 12, -50);
      WOWTR_CheckButton18.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header3, "TOPLEFT", -203, -60);
   else
      WOWTR_CheckButton18:SetPoint("TOPLEFT", WOWTR_CheckButton17, "BOTTOMLEFT", 0, 5);
   end
   WOWTR_CheckButton18.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateStoryLine) .. "|r"); -- Display translation in StoryLine addon
   WOWTR_CheckButton18.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton18:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateStoryLine) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateStoryLineDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton18:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton19 = CreateFrame("CheckButton", "WOWTR_CheckButton19", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton19:SetScript("OnClick",
      function(self) if (QTR_PS["questlog"] == "1") then QTR_PS["questlog"] = "0" else QTR_PS["questlog"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton19:SetPoint("TOPLEFT", WOWTR_Panel1Header3, "TOPLEFT", 12, -80);
      WOWTR_CheckButton19.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header3, "TOPLEFT", -255, -90);
   else
      WOWTR_CheckButton19:SetPoint("TOPLEFT", WOWTR_CheckButton18, "BOTTOMLEFT", 0, 5);
   end
   WOWTR_CheckButton19.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateQuestLog) .. "|r"); -- Display translation in StoryLine addon
   WOWTR_CheckButton19.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton19:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateQuestLog) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateQuestLogDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton19:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton1b = CreateFrame("CheckButton", "WOWTR_CheckButton1b", WOWTR_OptionPanel1,
      "UICheckButtonTemplate");
   WOWTR_CheckButton1b:SetScript("OnClick",
      function(self) if (QTR_PS["dialogueui"] == "1") then QTR_PS["dialogueui"] = "0" else QTR_PS["dialogueui"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton1b:SetPoint("TOPLEFT", WOWTR_Panel1Header3, "TOPLEFT", 12, -110);
      WOWTR_CheckButton1b.Text:SetPoint("TOPLEFT", WOWTR_Panel1Header3, "TOPLEFT", -213, -120);
   else
      WOWTR_CheckButton1b:SetPoint("TOPLEFT", WOWTR_CheckButton19, "BOTTOMLEFT", 0, 5);
   end
   WOWTR_CheckButton1b.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateDialogueUI) .. "|r"); -- Display translation in StoryLine addon
   WOWTR_CheckButton1b.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton1b:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateDialogueUI) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateDialogueUIDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton1b:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);
end
