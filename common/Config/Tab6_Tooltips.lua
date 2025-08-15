function WOWTR_CreateOptionPanel6(WOWTR_OptionPanel6)
   ----- TAB 6

   local WOWTR_OptionsHeaderIcon7 = WOWTR_OptionPanel6:CreateTexture(nil, "OVERLAY");
   WOWTR_OptionsHeaderIcon7:SetWidth(200);
   WOWTR_OptionsHeaderIcon7:SetHeight(200);
   WOWTR_OptionsHeaderIcon7:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\tooltips_mini.jpg"); -- WOWTR_OptionPanel6 thumbnail
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderIcon7:SetPoint("CENTER", -230, 150);
   else
      WOWTR_OptionsHeaderIcon7:SetPoint("CENTER", 230, 150);
   end

   local WOWTR_Panel6Header1 = WOWTR_OptionPanel6:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel6Header1:SetFontObject(GameFontNormal);
   WOWTR_Panel6Header1:SetJustifyH("LEFT");
   WOWTR_Panel6Header1:SetJustifyV("TOP");
   WOWTR_Panel6Header1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel6Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 492, -25);
   else
      WOWTR_Panel6Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 20, -25);
   end
   WOWTR_Panel6Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.generalMainHeaderST)); -- Tooltips translations
   WOWTR_Panel6Header1:SetFont(WOWTR_Font2, 15);

   local WOWTR_CheckButton61 = CreateFrame("CheckButton", "WOWTR_CheckButton61", WOWTR_OptionPanel6,
      "UICheckButtonTemplate");
   WOWTR_CheckButton61:SetScript("OnClick",
      function(self) if (ST_PM["active"] == "1") then ST_PM["active"] = "0" else ST_PM["active"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton61:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 143, -20);
      WOWTR_CheckButton61.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", -2, -30);
   else
      WOWTR_CheckButton61:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton61.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.activateTooltipTranslations) .. "|r"); -- Activate tooltip translations
   WOWTR_CheckButton61.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton61:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.activateTooltipTranslations) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.activateTooltipTranslationsDESC, false,
            getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton61:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton62 = CreateFrame("CheckButton", "WOWTR_CheckButton62", WOWTR_OptionPanel6,
      "UICheckButtonTemplate");
   WOWTR_CheckButton62:SetScript("OnClick",
      function(self) if (ST_PM["item"] == "1") then ST_PM["item"] = "0" else ST_PM["item"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton62:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 143, -50);
      WOWTR_CheckButton62.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", -58, -60);
   else
      WOWTR_CheckButton62:SetPoint("TOPLEFT", WOWTR_CheckButton61, "BOTTOMLEFT", 0, -20);
   end
   WOWTR_CheckButton62.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateItems) .. "|r"); -- Display translated tooltips for items
   WOWTR_CheckButton62.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton62:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateItems) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateItemsDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) ..
         NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                   -- Show the tooltip
   end);
   WOWTR_CheckButton62:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton63 = CreateFrame("CheckButton", "WOWTR_CheckButton63", WOWTR_OptionPanel6,
      "UICheckButtonTemplate");
   WOWTR_CheckButton63:SetScript("OnClick",
      function(self) if (ST_PM["spell"] == "1") then ST_PM["spell"] = "0" else ST_PM["spell"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton63:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 143, -80);
      WOWTR_CheckButton63.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", -54, -90);
   else
      WOWTR_CheckButton63:SetPoint("TOPLEFT", WOWTR_CheckButton62, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton63.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateSpells) .. "|r"); -- Display translated tooltips for spells
   WOWTR_CheckButton63.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton63:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateSpells) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateSpellsDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton63:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton64 = CreateFrame("CheckButton", "WOWTR_CheckButton64", WOWTR_OptionPanel6,
      "UICheckButtonTemplate");
   WOWTR_CheckButton64:SetScript("OnClick",
      function(self) if (ST_PM["talent"] == "1") then ST_PM["talent"] = "0" else ST_PM["talent"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton64:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 143, -110);
      WOWTR_CheckButton64.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", -58, -120);
   else
      WOWTR_CheckButton64:SetPoint("TOPLEFT", WOWTR_CheckButton63, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton64.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateTalents) .. "|r"); -- Display translated tooltips for talents
   WOWTR_CheckButton64.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton64:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateTalents) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateTalentsDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton64:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   if (ST_TooltipsID) then
      local WOWTR_CheckButton6A = CreateFrame("CheckButton", "WOWTR_CheckButton6A", WOWTR_OptionPanel6,
         "UICheckButtonTemplate");
      WOWTR_CheckButton6A:SetScript("OnClick",
         function(self) if (ST_PM["transtitle"] == "1") then ST_PM["transtitle"] = "0" else ST_PM["transtitle"] = "1" end; end);
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_CheckButton6A:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 143, -140);
         WOWTR_CheckButton6A.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", -147, -150);
      else
         WOWTR_CheckButton6A:SetPoint("TOPLEFT", WOWTR_CheckButton64, "BOTTOMLEFT", 0, 0);
      end
      WOWTR_CheckButton6A.Text:SetText("|cffffffff" ..
         QTR_ReverseIfAR(WoWTR_Config_Interface.translateTooltipTitle) .. "|r"); -- Display translated title of tooltips
      WOWTR_CheckButton6A.Text:SetFont(WOWTR_Font2, 15);
      WOWTR_CheckButton6A:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateTooltipTitle) .. NONBREAKINGSPACE, false); -- red color, no wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:AddLine(
            QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateTooltipTitleDESC, false, getglobal("GameTooltipTextLeft1"),
               WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                      -- Show the tooltip
      end);
      WOWTR_CheckButton6A:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);
   end

   local WOWTR_CheckButton65 = CreateFrame("CheckButton", "WOWTR_CheckButton65", WOWTR_OptionPanel6,
      "UICheckButtonTemplate");
   WOWTR_CheckButton65:SetScript("OnClick",
      function(self) if (ST_PM["showID"] == "1") then ST_PM["showID"] = "0" else ST_PM["showID"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton65:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 143, -170);
      WOWTR_CheckButton65.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 26, -180);
   else
      WOWTR_CheckButton65:SetPoint("TOPLEFT", WOWTR_CheckButton64, "BOTTOMLEFT", 0, -28);
   end
   WOWTR_CheckButton65.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.showTooltipID) .. "|r"); -- Display tooltips ID
   WOWTR_CheckButton65.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton65:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.showTooltipID) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      if (WoWTR_Localization.lang == 'AR') then
         GameTooltip:AddLine(
            QTR_ExpandUnitInfo(WoWTR_Config_Interface.showTooltipIDDESC, false, getglobal("GameTooltipTextLeft1"),
               WOWTR_Font2, -5) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      else
         GameTooltip:AddLine(
            QTR_ExpandUnitInfo(WoWTR_Config_Interface.showTooltipIDDESC, false, getglobal("GameTooltipTextLeft1"),
               WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      end
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show() -- Show the tooltip
   end);
   WOWTR_CheckButton65:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);

   local WOWTR_CheckButton66 = CreateFrame("CheckButton", "WOWTR_CheckButton66", WOWTR_OptionPanel6,
      "UICheckButtonTemplate");
   WOWTR_CheckButton66:SetScript("OnClick",
      function(self) if (ST_PM["showHS"] == "1") then ST_PM["showHS"] = "0" else ST_PM["showHS"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton66:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 143, -200);
      WOWTR_CheckButton66.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 37, -210);
   else
      WOWTR_CheckButton66:SetPoint("TOPLEFT", WOWTR_CheckButton65, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton66.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.showTooltipHash) .. "|r"); -- Display tooltips Hash
   WOWTR_CheckButton66.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton66:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.showTooltipHash) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.showTooltipHashDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      --Show the tooltip
   end);
   WOWTR_CheckButton66:SetScript("OnLeave", function(self)
      GameTooltip:Hide() --Hide the tooltip
   end);

   local WOWTR_CheckButton67 = CreateFrame("CheckButton", "WOWTR_CheckButton67", WOWTR_OptionPanel6,
      "UICheckButtonTemplate");
   WOWTR_CheckButton67:SetScript("OnClick",
      function(self) if (ST_PM["sellprice"] == "1") then ST_PM["sellprice"] = "0" else ST_PM["sellprice"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton67:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 143, -230);
      WOWTR_CheckButton67.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", -4, -240);
   else
      WOWTR_CheckButton67:SetPoint("TOPLEFT", WOWTR_CheckButton66, "BOTTOMLEFT", 0, 0);
   end
   WOWTR_CheckButton67.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.hideSellPrice) .. "|r"); -- Hide sell price
   WOWTR_CheckButton67.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton67:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.hideSellPrice) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.hideSellPriceDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) ..
         NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                   --Show the tooltip
   end);
   WOWTR_CheckButton67:SetScript("OnLeave", function(self)
      GameTooltip:Hide() --Hide the tooltip
   end);

   local WOWTR_Panel6Header2 = WOWTR_OptionPanel6:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel6Header2:SetFontObject(GameFontNormal);
   WOWTR_Panel6Header2:SetJustifyH("LEFT");
   WOWTR_Panel6Header2:SetJustifyV("TOP");
   WOWTR_Panel6Header2:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel6Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 560, -330);
   else
      WOWTR_Panel6Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 20, -330);
   end
   WOWTR_Panel6Header2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.timerHoldTranslation)); -- Select a translation hold time
   WOWTR_Panel6Header2:SetFont(WOWTR_Font2, 14);

   local WOWTR_CheckButton68 = CreateFrame("CheckButton", "WOWTR_CheckButton68", WOWTR_OptionPanel6,
      "UICheckButtonTemplate");
   WOWTR_CheckButton68:SetScript("OnClick",
      function(self) if (ST_PM["constantly"] == "1") then ST_PM["constantly"] = "0" else ST_PM["constantly"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton68:SetPoint("TOPLEFT", WOWTR_Panel6Header2, "TOPLEFT", 75, -20);
      WOWTR_CheckButton68.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header2, "TOPLEFT", -82, -30);
   else
      WOWTR_CheckButton68:SetPoint("TOPLEFT", WOWTR_Panel6Header2, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton68.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationConstantly) .. "|r"); -- Display translation constantly
   WOWTR_CheckButton68.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton68:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationConstantly) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.displayTranslationConstantlyDESC, false,
            getglobal("GameTooltipTextLeft1"), WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                                                         --Show the tooltip
   end);
   WOWTR_CheckButton68:SetScript("OnLeave", function(self)
      GameTooltip:Hide() --Hide the tooltip
   end);

   local WOWTR_slider3 = CreateFrame("Slider", "WOWTR_slider3", WOWTR_OptionPanel6, "OptionsSliderTemplate");
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_slider3:SetPoint("TOPLEFT", WOWTR_CheckButton68, "BOTTOMLEFT", -150, -30);
   else
      WOWTR_slider3:SetPoint("TOPLEFT", WOWTR_CheckButton68, "BOTTOMLEFT", 5, -30);
   end
   WOWTR_slider3:SetMinMaxValues(5, 30);
   WOWTR_slider3.minValue, WOWTR_slider3.maxValue = WOWTR_slider3:GetMinMaxValues();
   WOWTR_slider3.Low:SetText(WOWTR_slider3.minValue);
   WOWTR_slider3.High:SetText(WOWTR_slider3.maxValue);
   getglobal(WOWTR_slider3:GetName() .. 'Text'):SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.timerLimitSeconds));
   getglobal(WOWTR_slider3:GetName() .. 'Text'):SetFont(WOWTR_Font2, 11);
   WOWTR_slider3:SetValue(tonumber(ST_PM["timer"]));
   WOWTR_slider3:SetValueStep(1);
   WOWTR_slider3:SetScript("OnValueChanged", function(self, event, arg1)
      ST_PM["timer"] = string.format("%d", event);
      WOWTR_sliderVal3:SetText(ST_PM["timer"]);
   end);
   WOWTR_sliderVal3 = WOWTR_OptionPanel6:CreateFontString(nil, "ARTWORK");
   WOWTR_sliderVal3:SetFontObject(GameFontNormal);
   WOWTR_sliderVal3:SetJustifyH("CENTER");
   WOWTR_sliderVal3:SetJustifyV("TOP");
   WOWTR_sliderVal3:ClearAllPoints();
   WOWTR_sliderVal3:SetPoint("CENTER", WOWTR_slider3, "CENTER", 0, -12);
   WOWTR_sliderVal3:SetText(ST_PM["timer"]);
   WOWTR_sliderVal3:SetFont(WOWTR_Font2, 13);

   local WOWTR_Panel6Header3 = WOWTR_OptionPanel6:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel6Header3:SetFontObject(GameFontNormal);
   WOWTR_Panel6Header3:SetJustifyH("LEFT");
   WOWTR_Panel6Header3:SetJustifyV("TOP");
   WOWTR_Panel6Header3:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel6Header3:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 587, -460);
   else
      WOWTR_Panel6Header3:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 20, -460);
   end
   WOWTR_Panel6Header3:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.savingUntranslatedTooltips)); -- Saving untranslated tooltips
   WOWTR_Panel6Header3:SetFont(WOWTR_Font2, 14);

   local WOWTR_CheckButton69 = CreateFrame("CheckButton", "WOWTR_CheckButton69", WOWTR_OptionPanel6,
      "UICheckButtonTemplate");
   WOWTR_CheckButton69:SetScript("OnClick",
      function(self) if (ST_PM["saveNW"] == "1") then ST_PM["saveNW"] = "0" else ST_PM["saveNW"] = "1" end; end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton69:SetPoint("TOPLEFT", WOWTR_Panel6Header3, "TOPLEFT", 45, -20);
      WOWTR_CheckButton69.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header3, "TOPLEFT", -125, -30);
   else
      WOWTR_CheckButton69:SetPoint("TOPLEFT", WOWTR_Panel6Header3, "TOPLEFT", 10, -20);
   end
   WOWTR_CheckButton69.Text:SetText("|cffffffff" ..
      QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedTooltips) .. "|r"); -- Save untranslated tooltips
   WOWTR_CheckButton69.Text:SetFont(WOWTR_Font2, 15);
   WOWTR_CheckButton69:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedTooltips) .. NONBREAKINGSPACE, false); -- red color, no wrap
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveUntranslatedTooltipsDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show() --Show the tooltip
   end);
   WOWTR_CheckButton69:SetScript("OnLeave", function(self)
      GameTooltip:Hide() --Hide the tooltip
   end);
end
