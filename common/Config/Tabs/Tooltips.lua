-- Tab 6: Tooltips
-------------------------------------------------------------------------------------------------------

function WOWTR_BuildTab6()
  local WOWTR_OptionsHeaderIcon7 = WOWTR_OptionPanel6:CreateTexture(nil, "OVERLAY");
  WOWTR_OptionsHeaderIcon7:SetWidth(200); WOWTR_OptionsHeaderIcon7:SetHeight(200);
  WOWTR_OptionsHeaderIcon7:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\tooltips_mini.jpg");
  if (WoWTR_Localization.lang == 'AR') then WOWTR_OptionsHeaderIcon7:SetPoint("CENTER", -230, 150) else WOWTR_OptionsHeaderIcon7:SetPoint("CENTER", 230, 150) end

  local WOWTR_Panel6Header1 = WOWTR_OptionPanel6:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel6Header1:SetFontObject(GameFontNormal); WOWTR_Panel6Header1:SetJustifyH("LEFT"); WOWTR_Panel6Header1:SetJustifyV("TOP");
  WOWTR_Panel6Header1:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel6Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 492, -25) else WOWTR_Panel6Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 20, -25) end
  WOWTR_Panel6Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.generalMainHeaderST)); WOWTR_Panel6Header1:SetFont(WOWTR_Font2, 15)

  local function makeCheck(id, textKey, offAR, offEN, setter)
    local name = "WOWTR_CheckButton" .. id
    local btn = CreateFrame("CheckButton", name, WOWTR_OptionPanel6, "UICheckButtonTemplate")
    btn:SetScript("OnClick", setter)
    if (WoWTR_Localization.lang == 'AR') then btn:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 143, offAR); btn.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", offAR + 85, offAR - 10) else btn:SetPoint("TOPLEFT", WOWTR_Panel6Header1, "TOPLEFT", 10, offEN) end
    btn.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface[textKey]) .. "|r"); btn.Text:SetFont(WOWTR_Font2, 15)
    btn:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT"); GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface[textKey]) .. NONBREAKINGSPACE, false)
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13)
      local desc = WoWTR_Config_Interface[textKey .. "DESC"]
      if desc then GameTooltip:AddLine(QTR_ExpandUnitInfo(desc, false, getglobal("GameTooltipTextLeft1"), WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true) end
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13); GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
    return btn
  end

  makeCheck(61, "activateTooltipTranslations", -20, -20, function(self) if (ST_PM["active"] == "1") then ST_PM["active"] = "0" else ST_PM["active"] = "1" end end)
  makeCheck(62, "translateItems", -50, -40, function(self) if (ST_PM["item"] == "1") then ST_PM["item"] = "0" else ST_PM["item"] = "1" end end)
  makeCheck(63, "translateSpells", -80, -60, function(self) if (ST_PM["spell"] == "1") then ST_PM["spell"] = "0" else ST_PM["spell"] = "1" end end)
  makeCheck(64, "translateTalents", -110, -80, function(self) if (ST_PM["talent"] == "1") then ST_PM["talent"] = "0" else ST_PM["talent"] = "1" end end)

  if (ST_TooltipsID) then
    makeCheck("6A", "translateTooltipTitle", -140, -100, function(self) if (ST_PM["transtitle"] == "1") then ST_PM["transtitle"] = "0" else ST_PM["transtitle"] = "1" end end)
  end

  makeCheck(65, "showTooltipID", -170, -128, function(self) if (ST_PM["showID"] == "1") then ST_PM["showID"] = "0" else ST_PM["showID"] = "1" end end)
  makeCheck(66, "showTooltipHash", -200, -148, function(self) if (ST_PM["showHS"] == "1") then ST_PM["showHS"] = "0" else ST_PM["showHS"] = "1" end end)
  makeCheck(67, "hideSellPrice", -230, -168, function(self) if (ST_PM["sellprice"] == "1") then ST_PM["sellprice"] = "0" else ST_PM["sellprice"] = "1" end end)

  local WOWTR_Panel6Header2 = WOWTR_OptionPanel6:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel6Header2:SetFontObject(GameFontNormal); WOWTR_Panel6Header2:SetJustifyH("LEFT"); WOWTR_Panel6Header2:SetJustifyV("TOP");
  WOWTR_Panel6Header2:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel6Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 560, -330) else WOWTR_Panel6Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 20, -330) end
  WOWTR_Panel6Header2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.timerHoldTranslation)); WOWTR_Panel6Header2:SetFont(WOWTR_Font2, 14)

  local WOWTR_CheckButton68 = CreateFrame("CheckButton", "WOWTR_CheckButton68", WOWTR_OptionPanel6, "UICheckButtonTemplate");
  WOWTR_CheckButton68:SetScript("OnClick", function(self) if (ST_PM["constantly"] == "1") then ST_PM["constantly"] = "0" else ST_PM["constantly"] = "1" end end)
  if (WoWTR_Localization.lang == 'AR') then WOWTR_CheckButton68:SetPoint("TOPLEFT", WOWTR_Panel6Header2, "TOPLEFT", 75, -20); WOWTR_CheckButton68.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header2, "TOPLEFT", -82, -30) else WOWTR_CheckButton68:SetPoint("TOPLEFT", WOWTR_Panel6Header2, "TOPLEFT", 10, -20) end
  WOWTR_CheckButton68.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationConstantly) .. "|r"); WOWTR_CheckButton68.Text:SetFont(WOWTR_Font2, 15)

  local WOWTR_slider3 = CreateFrame("Slider", "WOWTR_slider3", WOWTR_OptionPanel6, "OptionsSliderTemplate");
  if (WoWTR_Localization.lang == 'AR') then WOWTR_slider3:SetPoint("TOPLEFT", WOWTR_CheckButton68, "BOTTOMLEFT", -150, -30) else WOWTR_slider3:SetPoint("TOPLEFT", WOWTR_CheckButton68, "BOTTOMLEFT", 5, -30) end
  WOWTR_slider3:SetMinMaxValues(5, 30); WOWTR_slider3.minValue, WOWTR_slider3.maxValue = WOWTR_slider3:GetMinMaxValues();
  WOWTR_slider3.Low:SetText(WOWTR_slider3.minValue); WOWTR_slider3.High:SetText(WOWTR_slider3.maxValue)
  getglobal(WOWTR_slider3:GetName() .. 'Text'):SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.timerLimitSeconds)); getglobal(WOWTR_slider3:GetName() .. 'Text'):SetFont(WOWTR_Font2, 11)
  WOWTR_slider3:SetValue(tonumber(ST_PM["timer"])); WOWTR_slider3:SetValueStep(1)
  WOWTR_slider3:SetScript("OnValueChanged", function(self, event, arg1) ST_PM["timer"] = string.format("%d", event); WOWTR_sliderVal3:SetText(ST_PM["timer"]) end)
  WOWTR_sliderVal3 = WOWTR_OptionPanel6:CreateFontString(nil, "ARTWORK"); WOWTR_sliderVal3:SetFontObject(GameFontNormal); WOWTR_sliderVal3:SetJustifyH("CENTER"); WOWTR_sliderVal3:SetJustifyV("TOP");
  WOWTR_sliderVal3:ClearAllPoints(); WOWTR_sliderVal3:SetPoint("CENTER", WOWTR_slider3, "CENTER", 0, -12); WOWTR_sliderVal3:SetText(ST_PM["timer"]); WOWTR_sliderVal3:SetFont(WOWTR_Font2, 13)

  local WOWTR_Panel6Header3 = WOWTR_OptionPanel6:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel6Header3:SetFontObject(GameFontNormal); WOWTR_Panel6Header3:SetJustifyH("LEFT"); WOWTR_Panel6Header3:SetJustifyV("TOP");
  WOWTR_Panel6Header3:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel6Header3:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 587, -460) else WOWTR_Panel6Header3:SetPoint("TOPLEFT", WOWTR_OptionPanel6, "TOPLEFT", 20, -460) end
  WOWTR_Panel6Header3:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.savingUntranslatedTooltips)); WOWTR_Panel6Header3:SetFont(WOWTR_Font2, 14)

  local WOWTR_CheckButton69 = CreateFrame("CheckButton", "WOWTR_CheckButton69", WOWTR_OptionPanel6, "UICheckButtonTemplate");
  WOWTR_CheckButton69:SetScript("OnClick", function(self) if (ST_PM["saveNW"] == "1") then ST_PM["saveNW"] = "0" else ST_PM["saveNW"] = "1" end end)
  if (WoWTR_Localization.lang == 'AR') then WOWTR_CheckButton69:SetPoint("TOPLEFT", WOWTR_Panel6Header3, "TOPLEFT", 45, -20); WOWTR_CheckButton69.Text:SetPoint("TOPLEFT", WOWTR_Panel6Header3, "TOPLEFT", -125, -30) else WOWTR_CheckButton69:SetPoint("TOPLEFT", WOWTR_Panel6Header3, "TOPLEFT", 10, -20) end
  WOWTR_CheckButton69.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedTooltips) .. "|r"); WOWTR_CheckButton69.Text:SetFont(WOWTR_Font2, 15)
  WOWTR_CheckButton69:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT"); GameTooltip:ClearLines();
    GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedTooltips) .. NONBREAKINGSPACE, false);
    GameTooltip:AddLine(QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveUntranslatedTooltipsDESC, false, getglobal("GameTooltipTextLeft1"), WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true);
    getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
    getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
    GameTooltip:Show()
  end)
  WOWTR_CheckButton69:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
end


