function WOWTR_CreateBooksTab(parent)
  local WOWTR_OptionsHeaderIcon6 = parent:CreateTexture(nil, "OVERLAY");
  WOWTR_OptionsHeaderIcon6:SetWidth(200);
  WOWTR_OptionsHeaderIcon6:SetHeight(200);
  WOWTR_OptionsHeaderIcon6:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\books_mini.jpg"); -- parent thumbnail
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_OptionsHeaderIcon6:SetPoint("CENTER", -230, 150);
  else
    WOWTR_OptionsHeaderIcon6:SetPoint("CENTER", 230, 150);
  end

  local WOWTR_Panel5Header1 = parent:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel5Header1:SetFontObject(GameFontNormal);
  WOWTR_Panel5Header1:SetJustifyH("LEFT");
  WOWTR_Panel5Header1:SetJustifyV("TOP");
  WOWTR_Panel5Header1:ClearAllPoints();
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_Panel5Header1:SetPoint("TOPLEFT", parent, "TOPLEFT", 525, -25);
  else
    WOWTR_Panel5Header1:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, -25);
  end
  WOWTR_Panel5Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.generalMainHeaderBT)); -- Books translations
  WOWTR_Panel5Header1:SetFont(WOWTR_Font2, 15);

  local WOWTR_CheckButton51 = CreateFrame("CheckButton", "WOWTR_CheckButton51", parent,
    "UICheckButtonTemplate");
  WOWTR_CheckButton51:SetScript("OnClick",
    function(self) if (BT_PM["active"] == "1") then BT_PM["active"] = "0" else BT_PM["active"] = "1" end; end);
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_CheckButton51:SetPoint("TOPLEFT", WOWTR_Panel5Header1, "TOPLEFT", 110, -20);
    WOWTR_CheckButton51.Text:SetPoint("TOPLEFT", WOWTR_Panel5Header1, "TOPLEFT", -12, -30);
  else
    WOWTR_CheckButton51:SetPoint("TOPLEFT", WOWTR_Panel5Header1, "TOPLEFT", 10, -20);
  end
  WOWTR_CheckButton51.Text:SetText("|cffffffff" ..
    QTR_ReverseIfAR(WoWTR_Config_Interface.activateBooksTranslations) .. "|r"); -- Activate subtitle translations
  WOWTR_CheckButton51.Text:SetFont(WOWTR_Font2, 15);
  WOWTR_CheckButton51:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
    GameTooltip:ClearLines();
    GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.activateBooksTranslations) .. NONBREAKINGSPACE, false); -- red color, no wrap
    getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
    GameTooltip:AddLine(
      QTR_ExpandUnitInfo(WoWTR_Config_Interface.activateBooksTranslationsDESC, false,
        getglobal("GameTooltipTextLeft1"),
        WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
    getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
    GameTooltip:Show()
  end);
  WOWTR_CheckButton51:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end);

  local WOWTR_CheckButton52 = CreateFrame("CheckButton", "WOWTR_CheckButton52", parent,
    "UICheckButtonTemplate");
  WOWTR_CheckButton52:SetScript("OnClick",
    function(self)
      if (BT_PM["title"] == "1") then
        BT_PM["title"] = "0"
      else
        BT_PM["title"] = "1"; BB_PM["chat-tr"] = "0"; WOWTR_CheckButton23:SetValue(false);
      end;
    end);
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_CheckButton52:SetPoint("TOPLEFT", WOWTR_Panel5Header1, "TOPLEFT", 110, -70);
    WOWTR_CheckButton52.Text:SetPoint("TOPLEFT", WOWTR_Panel5Header1, "TOPLEFT", -50, -80);
  else
    WOWTR_CheckButton52:SetPoint("TOPLEFT", WOWTR_CheckButton51, "BOTTOMLEFT", 0, -20);
  end
  WOWTR_CheckButton52.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.translateBookTitles) .. "|r"); -- translate book tltles
  WOWTR_CheckButton52.Text:SetFont(WOWTR_Font2, 15);
  WOWTR_CheckButton52:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
    GameTooltip:ClearLines();
    GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.translateBookTitles) .. NONBREAKINGSPACE, false); -- red color, no wrap
    getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
    GameTooltip:AddLine(
      QTR_ExpandUnitInfo(WoWTR_Config_Interface.translateBookTitlesDESC, false, getglobal("GameTooltipTextLeft1"),
        WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
    getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
    GameTooltip:Show()
  end);
  WOWTR_CheckButton52:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end);

  local WOWTR_CheckButton53 = CreateFrame("CheckButton", "WOWTR_CheckButton53", parent,
    "UICheckButtonTemplate");
  WOWTR_CheckButton53:SetScript("OnClick",
    function(self)
      if (BT_PM["showID"] == "1") then
        BT_PM["showID"] = "0"
      else
        BT_PM["showID"] = "1"; BB_PM["chat-en"] = "0"; WOWTR_CheckButton22:SetValue(false);
      end;
    end);
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_CheckButton53:SetPoint("TOPLEFT", WOWTR_Panel5Header1, "TOPLEFT", 110, -100);
    WOWTR_CheckButton53.Text:SetPoint("TOPLEFT", WOWTR_Panel5Header1, "TOPLEFT", -3, -110);
  else
    WOWTR_CheckButton53:SetPoint("TOPLEFT", WOWTR_CheckButton52, "BOTTOMLEFT", 0, 0);
  end
  WOWTR_CheckButton53.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.showBookID) .. "|r"); -- Show ID of book
  WOWTR_CheckButton53.Text:SetFont(WOWTR_Font2, 15);
  WOWTR_CheckButton53:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
    GameTooltip:ClearLines();
    GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.showBookID) .. NONBREAKINGSPACE, false); -- red color, no wrap
    getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
    GameTooltip:AddLine(
      QTR_ExpandUnitInfo(WoWTR_Config_Interface.showBookIDDESC, false, getglobal("GameTooltipTextLeft1"), WOWTR_Font2) ..
      NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
    getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
    GameTooltip:Show()
  end);
  WOWTR_CheckButton53:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end);

  local WOWTR_Panel5Header2 = parent:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel5Header2:SetFontObject(GameFontNormal);
  WOWTR_Panel5Header2:SetJustifyH("LEFT");
  WOWTR_Panel5Header2:SetJustifyV("TOP");
  WOWTR_Panel5Header2:ClearAllPoints();
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_Panel5Header2:SetPoint("TOPLEFT", parent, "TOPLEFT", 587, -190);
  else
    WOWTR_Panel5Header2:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, -190);
  end
  WOWTR_Panel5Header2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.savingUntranslatedBooks)); -- Saving untranslated books
  WOWTR_Panel5Header2:SetFont(WOWTR_Font2, 14);

  local WOWTR_CheckButton55 = CreateFrame("CheckButton", "WOWTR_CheckButton55", parent,
    "UICheckButtonTemplate");
  WOWTR_CheckButton55:SetScript("OnClick",
    function(self) if (BT_PM["saveNW"] == "1") then BT_PM["saveNW"] = "0" else BT_PM["saveNW"] = "1" end; end);
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_CheckButton55:SetPoint("TOPLEFT", WOWTR_Panel5Header2, "TOPLEFT", 47, -20);
    WOWTR_CheckButton55.Text:SetPoint("TOPLEFT", WOWTR_Panel5Header2, "TOPLEFT", -100, -30);
  else
    WOWTR_CheckButton55:SetPoint("TOPLEFT", WOWTR_Panel5Header2, "TOPLEFT", 10, -20);
  end
  WOWTR_CheckButton55.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedBooks) .. "|r"); -- Save untranslated books
  WOWTR_CheckButton55.Text:SetFont(WOWTR_Font2, 15);
  WOWTR_CheckButton55:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
    GameTooltip:ClearLines();
    GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedBooks) .. NONBREAKINGSPACE, false); -- red color, no wrap
    getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
    GameTooltip:AddLine(
      QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveUntranslatedBooksDESC, false, getglobal("GameTooltipTextLeft1"),
        WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
    getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
    GameTooltip:Show()
  end);
  WOWTR_CheckButton55:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end);

  local WOWTR_Panel5Header3 = parent:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel5Header3:SetFontObject(GameFontNormal);
  WOWTR_Panel5Header3:SetJustifyH("LEFT");
  WOWTR_Panel5Header3:SetJustifyV("TOP");
  WOWTR_Panel5Header3:ClearAllPoints();
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_Panel5Header3:SetPoint("TOPLEFT", parent, "TOPLEFT", 605, -270);
  else
    WOWTR_Panel5Header3:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, -270);
  end
  WOWTR_Panel5Header3:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontSizeHeader)); -- Font size of books
  WOWTR_Panel5Header3:SetFont(WOWTR_Font2, 14);

  local WOWTR_CheckButton58 = CreateFrame("CheckButton", "WOWTR_CheckButton58", parent,
    "UICheckButtonTemplate");
  WOWTR_CheckButton58:SetScript("OnClick",
    function(self) if (BT_PM["setsize"] == "1") then BT_PM["setsize"] = "0" else BT_PM["setsize"] = "1" end; end);
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_CheckButton58:SetPoint("TOPLEFT", WOWTR_Panel5Header3, "TOPLEFT", 30, -20);
    WOWTR_CheckButton58.Text:SetPoint("TOPLEFT", WOWTR_Panel5Header3, "TOPLEFT", -105, -30);
  else
    WOWTR_CheckButton58:SetPoint("TOPLEFT", WOWTR_Panel5Header3, "TOPLEFT", 10, -20);
  end
  WOWTR_CheckButton58.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.setFontActivate) .. "|r"); -- Activate font size changes
  WOWTR_CheckButton58.Text:SetFont(WOWTR_Font2, 15);
  WOWTR_CheckButton58:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
    GameTooltip:ClearLines();
    GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.setFontActivate) .. NONBREAKINGSPACE, false); -- red color, no wrap
    getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
    GameTooltip:AddLine(
      QTR_ExpandUnitInfo(WoWTR_Config_Interface.setFontActivateDESC, false, getglobal("GameTooltipTextLeft1"),
        WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
    getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
    GameTooltip:Show()
  end);
  WOWTR_CheckButton58:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end);

  local WOWTR_slider2 = CreateFrame("Slider", "WOWTR_slider2", parent, "OptionsSliderTemplate");
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_slider2:SetPoint("TOPLEFT", WOWTR_CheckButton58, "BOTTOMLEFT", -150, -50);
  else
    WOWTR_slider2:SetPoint("TOPLEFT", WOWTR_CheckButton58, "BOTTOMLEFT", 20, -30);
  end
  WOWTR_slider2:SetMinMaxValues(10, 20);
  WOWTR_slider2.minValue, WOWTR_slider2.maxValue = WOWTR_slider2:GetMinMaxValues();
  WOWTR_slider2.Low:SetText(WOWTR_slider2.minValue);
  WOWTR_slider2.High:SetText(WOWTR_slider2.maxValue);
  getglobal(WOWTR_slider2:GetName() .. 'Text'):SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontsizeBubbles));
  getglobal(WOWTR_slider2:GetName() .. 'Text'):SetFont(WOWTR_Font2, 11);
  WOWTR_slider2:SetValue(tonumber(BT_PM["fontsize"]));
  WOWTR_slider2:SetValueStep(1);
  WOWTR_slider2:SetScript("OnValueChanged", function(self, event, arg1)
    BT_PM["fontsize"] = string.format("%d", event);
    WOWTR_sliderVal2:SetText(BT_PM["fontsize"]);
    WOWTR_Opis2:SetFont(WOWTR_Font2, event);
  end);
  WOWTR_sliderVal2 = parent:CreateFontString(nil, "ARTWORK");
  WOWTR_sliderVal2:SetFontObject(GameFontNormal);
  WOWTR_sliderVal2:SetJustifyH("CENTER");
  WOWTR_sliderVal2:SetJustifyV("TOP");
  WOWTR_sliderVal2:ClearAllPoints();
  WOWTR_sliderVal2:SetPoint("CENTER", WOWTR_slider2, "CENTER", 0, -12);
  WOWTR_sliderVal2:SetText(BT_PM["fontsize"]);
  WOWTR_sliderVal2:SetFont(WOWTR_Font2, 13);

  WOWTR_Opis2 = parent:CreateFontString(nil, "ARTWORK");
  WOWTR_Opis2:SetFontObject(GameFontNormalLarge);
  WOWTR_Opis2:SetJustifyH("LEFT");
  WOWTR_Opis2:SetJustifyV("TOP");
  WOWTR_Opis2:ClearAllPoints();
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_Opis2:SetPoint("TOPLEFT", WOWTR_slider2, "BOTTOMLEFT", -230, 30);
  else
    WOWTR_Opis2:SetPoint("TOPLEFT", WOWTR_slider2, "BOTTOMLEFT", 200, 30);
  end
  local fontsize = tonumber(BT_PM["fontsize"]);
  if (BT_PM["setsize"] == "1") then
    WOWTR_Opis2:SetFont(WOWTR_Font2, fontsize);
  else
    WOWTR_Opis2:SetFont(WOWTR_Font2, 13);
  end
  WOWTR_Opis2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.sampleText));
end

function WOWTR_UpdateBooksTab()
  WOWTR_CheckButton51:SetChecked(BT_PM["active"] == "1");
  WOWTR_CheckButton52:SetChecked(BT_PM["title"] == "1");
  WOWTR_CheckButton53:SetChecked(BT_PM["showID"] == "1");
  WOWTR_CheckButton55:SetChecked(BT_PM["saveNW"] == "1");
  WOWTR_CheckButton58:SetChecked(BT_PM["setsize"] == "1");
  local fontsize2 = tonumber(BT_PM["fontsize"]) or 13;
  if WOWTR_Opis2 then
    WOWTR_Opis2:SetFont(WOWTR_Font2, fontsize2);
  end
  if WOWTR_slider2 then
    WOWTR_slider2:SetValue(tonumber(BT_PM["fontsize"]));
  end
end
