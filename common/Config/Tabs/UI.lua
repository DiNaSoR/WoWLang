-- Tab 4: Tutorials & UI translations and Font selection
-------------------------------------------------------------------------------------------------------

function WOWTR_BuildTab4()
  local WOWTR_OptionsHeaderIcon4 = WOWTR_OptionPanel4:CreateTexture(nil, "OVERLAY");
  WOWTR_OptionsHeaderIcon4:SetWidth(200); WOWTR_OptionsHeaderIcon4:SetHeight(200);
  WOWTR_OptionsHeaderIcon4:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\tutorials_mini.jpg");
  if (WoWTR_Localization.lang == 'AR') then WOWTR_OptionsHeaderIcon4:SetPoint("CENTER", -230, 150) else WOWTR_OptionsHeaderIcon4:SetPoint("CENTER", 230, 150) end

  local WOWTR_Panel4Header1 = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel4Header1:SetFontObject(GameFontNormal); WOWTR_Panel4Header1:SetJustifyH("LEFT"); WOWTR_Panel4Header1:SetJustifyV("TOP");
  WOWTR_Panel4Header1:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel4Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 445, -25) else WOWTR_Panel4Header1:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 20, -25) end
  WOWTR_Panel4Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.generalMainHeaderTT)); WOWTR_Panel4Header1:SetFont(WOWTR_Font2, 15)

  local WOWTR_CheckButton41 = CreateFrame("CheckButton", "WOWTR_CheckButton41", WOWTR_OptionPanel4, "UICheckButtonTemplate");
  WOWTR_CheckButton41:SetScript("OnClick", function(self) if (TT_PS["active"] == "1") then TT_PS["active"] = "0" else TT_PS["active"] = "1" end; end);
  if (WoWTR_Localization.lang == 'AR') then WOWTR_CheckButton41:SetPoint("TOPLEFT", WOWTR_Panel4Header1, "TOPLEFT", 190, -20); WOWTR_CheckButton41.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header1, "TOPLEFT", 5, -30) else WOWTR_CheckButton41:SetPoint("TOPLEFT", WOWTR_Panel4Header1, "TOPLEFT", 10, -20) end
  WOWTR_CheckButton41.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.activateTutorialTranslations) .. "|r"); WOWTR_CheckButton41.Text:SetFont(WOWTR_Font2, 15)
  WOWTR_CheckButton41:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT"); GameTooltip:ClearLines(); GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.activateTutorialTranslations), false); getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13); GameTooltip:AddLine(QTR_ExpandUnitInfo(WoWTR_Config_Interface.activateTutorialTranslationsDESC, false, getglobal("GameTooltipTextLeft1"), WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13); GameTooltip:Show(); end)
  WOWTR_CheckButton41:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

  local WOWTR_Panel4Header2 = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel4Header2:SetFontObject(GameFontNormal); WOWTR_Panel4Header2:SetJustifyH("LEFT"); WOWTR_Panel4Header2:SetJustifyV("TOP");
  WOWTR_Panel4Header2:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel4Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 580, -100) else WOWTR_Panel4Header2:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 20, -100) end
  WOWTR_Panel4Header2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.savingUntranslatedTutorials)); WOWTR_Panel4Header2:SetFont(WOWTR_Font2, 15)

  local WOWTR_CheckButton42 = CreateFrame("CheckButton", "WOWTR_CheckButton42", WOWTR_OptionPanel4, "UICheckButtonTemplate");
  WOWTR_CheckButton42:SetScript("OnClick", function(self) if (TT_PS["save"] == "1") then TT_PS["save"] = "0" else TT_PS["save"] = "1" end; end);
  if (WoWTR_Localization.lang == 'AR') then WOWTR_CheckButton42:SetPoint("TOPLEFT", WOWTR_Panel4Header2, "TOPLEFT", 55, -20); WOWTR_CheckButton42.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header2, "TOPLEFT", -155, -30) else WOWTR_CheckButton42:SetPoint("TOPLEFT", WOWTR_Panel4Header2, "TOPLEFT", 10, -20) end
  WOWTR_CheckButton42.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedTutorials) .. "|r"); WOWTR_CheckButton42.Text:SetFont(WOWTR_Font2, 15)
  WOWTR_CheckButton42:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT"); GameTooltip:ClearLines(); GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.saveUntranslatedTutorials) .. NONBREAKINGSPACE, false); getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13); GameTooltip:AddLine(QTR_ExpandUnitInfo(WoWTR_Config_Interface.saveUntranslatedTutorialsDESC, false, getglobal("GameTooltipTextLeft1"), WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13); GameTooltip:Show(); end)
  WOWTR_CheckButton42:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

  if (#WOWTR_Fonts > 1) then
    local WOWTR_Panel4Header2f = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
    WOWTR_Panel4Header2f:SetFontObject(GameFontNormal); WOWTR_Panel4Header2f:SetJustifyH("LEFT"); WOWTR_Panel4Header2f:SetJustifyV("TOP");
    WOWTR_Panel4Header2f:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel4Header2f:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 545, -170) else WOWTR_Panel4Header2f:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 20, -170) end
    WOWTR_Panel4Header2f:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontSelectingFontHeader)); WOWTR_Panel4Header2f:SetFont(WOWTR_Font2, 15)

    local WOWTR_Panel4Header2g = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
    WOWTR_Panel4Header2g:SetFontObject(GameFontNormal); WOWTR_Panel4Header2g:SetJustifyH("LEFT"); WOWTR_Panel4Header2g:SetJustifyV("TOP");
    WOWTR_Panel4Header2g:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel4Header2g:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 300, -170) else WOWTR_Panel4Header2g:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 290, -170) end
    WOWTR_Panel4Header2g:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.fontCurrentFont)); WOWTR_Panel4Header2g:SetFont(WOWTR_Font2, 15)

    local WOWTR_Panel4Header2h = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
    WOWTR_Panel4Header2h:SetFontObject(GameFontWhite); WOWTR_Panel4Header2h:SetJustifyH("LEFT"); WOWTR_Panel4Header2h:SetJustifyV("TOP");
    WOWTR_Panel4Header2h:ClearAllPoints(); WOWTR_Panel4Header2h:SetPoint("TOPLEFT", WOWTR_Panel4Header2g, "TOPLEFT", 0, -30)
    WOWTR_Panel4Header2h:SetText(QTR_PS["FontFile"]); WOWTR_Panel4Header2h:SetFont(WOWTR_Font2, 13)

    local WOWTR_Panel4SelectF = CreateFrame("Frame", "WOWTR_Panel4SelectF", WOWTR_OptionPanel4, "UIDropDownMenuTemplate");
    WOWTR_Panel4SelectF:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel4SelectF:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 460, -195) else WOWTR_Panel4SelectF:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 0, -195) end
    UIDropDownMenu_SetWidth(WOWTR_Panel4SelectF, 170); UIDropDownMenu_SetText(WOWTR_Panel4SelectF, WoWTR_Config_Interface.fontSelectFontFile)
    UIDropDownMenu_Initialize(WOWTR_Panel4SelectF, function(self, level, _)
      for i, font in ipairs(WOWTR_Fonts) do
        local info = UIDropDownMenu_CreateInfo(); info.text = font; info.value = font; info.func = function(self, arg1, arg2, checked)
          QTR_PS["FontFile"] = self.value; WOWTR_Panel4Header2h:SetText(self.value); WOWTR_Font2 = WoWTR_Localization.mainFolder .. "\\Fonts\\" .. self.value; WOWTR_Panel4Header2h:SetFont(WOWTR_Font2, 13); WOWTR_ReloadButtonUI:Show();
        end; UIDropDownMenu_AddButton(info);
      end
      UIDropDownMenu_SetSelectedValue(WOWTR_Panel4SelectF, QTR_PS["FontFile"]);
    end)
  end

  local WOWTR_Panel4Separator = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel4Separator:SetFontObject(GameFontWhite); WOWTR_Panel4Separator:SetJustifyH("LEFT"); WOWTR_Panel4Separator:SetJustifyV("TOP");
  WOWTR_Panel4Separator:ClearAllPoints(); WOWTR_Panel4Separator:SetPoint("TOPLEFT", WOWTR_OptionPanel4, "TOPLEFT", 20, -250)
  local frame = WOWTR_OptionPanel4:CreateTexture(nil, "BACKGROUND"); frame:SetSize(684, 1); frame:SetPoint("TOPLEFT", 0, -240); frame:SetColorTexture(0.2, 0.2, 0.2, 1)

  local WOWTR_OptionsHeaderIcon5 = WOWTR_OptionPanel4:CreateTexture(nil, "OVERLAY");
  WOWTR_OptionsHeaderIcon5:SetWidth(200); WOWTR_OptionsHeaderIcon5:SetHeight(200);
  WOWTR_OptionsHeaderIcon5:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\ui_mini.jpg");
  if (WoWTR_Localization.lang == 'AR') then WOWTR_OptionsHeaderIcon5:SetPoint("CENTER", -230, -100) else WOWTR_OptionsHeaderIcon5:SetPoint("CENTER", 230, -100) end

  local WOWTR_Panel4Header3 = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel4Header3:SetFontObject(GameFontNormal); WOWTR_Panel4Header3:SetJustifyH("LEFT"); WOWTR_Panel4Header3:SetJustifyV("TOP");
  WOWTR_Panel4Header3:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel4Header3:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 480, -10) else WOWTR_Panel4Header3:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 0, -10) end
  WOWTR_Panel4Header3:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.translationUI)); WOWTR_Panel4Header3:SetFont(WOWTR_Font2, 15)

  local WOWTR_Panel4Text1 = WOWTR_OptionPanel4:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel4Text1:SetFontObject(GameFontWhite); WOWTR_Panel4Text1:SetJustifyH("LEFT"); WOWTR_Panel4Text1:SetJustifyV("TOP");
  WOWTR_Panel4Text1:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel4Text1:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 480, -30) else WOWTR_Panel4Text1:SetPoint("TOPLEFT", WOWTR_Panel4Separator, "TOPLEFT", 0, -30) end
  WOWTR_Panel4Text1:SetWidth(640); WOWTR_Panel4Text1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.displayTranslationtxt)); WOWTR_Panel4Text1:SetFont(WOWTR_Font2, 12)

  local function addUIOption(id, yOffAR, yOffEN, label, desc)
    local name = "WOWTR_CheckButton" .. id
    local btn = CreateFrame("CheckButton", name, WOWTR_OptionPanel4, "UICheckButtonTemplate")
    btn:SetScript("OnClick", function(self) if (TT_PS[label] == "1") then TT_PS[label] = "0" else TT_PS[label] = "1" end; end)
    if (WoWTR_Localization.lang == 'AR') then btn:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 135, yOffAR); btn.Text:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", yOffAR + 200, yOffAR - 10) else btn:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", yOffEN, yOffEN) end
    btn.Text:SetText("|cffffffff" .. QTR_ReverseIfAR(desc) .. "|r"); btn.Text:SetFont(WOWTR_Font2, 15)
    btn:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT"); GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(desc) .. NONBREAKINGSPACE, false);
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13); if (WoWTR_Localization.lang == 'AR') then getglobal("GameTooltipTextLeft1"):SetWidth(150); getglobal("GameTooltipTextLeft1"):SetJustifyH("RIGHT") end
      GameTooltip:AddLine(QTR_ExpandUnitInfo(WoWTR_Config_Interface[desc .. "DESC"], false, getglobal("GameTooltipTextLeft1"), WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true)
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13); GameTooltip:Show();
    end)
    btn:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
    return btn
  end

  -- Keep the existing explicit set of options for fidelity
  -- Buttons 43..50 are rebuilt in Init.lua; here we only keep textual content consistent if reused

  WOWTR_ReloadButtonUI = CreateFrame("BUTTON", nil, WOWTR_OptionPanel4, "UIPanelButtonTemplate");
  WOWTR_ReloadButtonUI:SetWidth(350); WOWTR_ReloadButtonUI:SetHeight(32)
  if (WoWTR_Localization.lang == 'AR') then local fo = WOWTR_ReloadButtonUI:CreateFontString(); fo:SetFont(WOWTR_Font2, 13); fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.ReloadButtonUI)); WOWTR_ReloadButtonUI:SetFontString(fo) end
  WOWTR_ReloadButtonUI:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.ReloadButtonUI))
  WOWTR_ReloadButtonUI:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_ReloadButtonUI:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", -320, -60) else WOWTR_ReloadButtonUI:SetPoint("TOPLEFT", WOWTR_Panel4Header3, "TOPLEFT", 0, -60) end
  WOWTR_ReloadButtonUI:Hide(); WOWTR_ReloadButtonUI:SetScript("OnClick", function() ReloadUI() end)
end


