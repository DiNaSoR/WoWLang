-- Tab 9: About / Links / Reset panels
-------------------------------------------------------------------------------------------------------

function WOWTR_BuildTab9()
  local WOWTR_Panel9Text = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel9Text:SetFontObject(GameFontWhite); WOWTR_Panel9Text:SetJustifyH("LEFT"); WOWTR_Panel9Text:SetJustifyV("TOP");
  WOWTR_Panel9Text:ClearAllPoints(); WOWTR_Panel9Text:SetPoint("TOPLEFT", WOWTR_OptionPanel9, "TOPLEFT", 25, -10);
  WOWTR_Panel9Text:SetWidth(640); WOWTR_Panel9Text:SetFont(WOWTR_Font2, 14);
  if (WoWTR_Localization.lang == 'AR') then
    WOWTR_Panel9Text:SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.generalText, false, WOWTR_Panel9Text, WOWTR_Font2, -80));
  else
    WOWTR_Panel9Text:SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.generalText, false, WOWTR_Panel9Text, WOWTR_Font2, -50));
  end

  local WOWTR_Panel9Header1 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
  WOWTR_Panel9Header1:SetFontObject(GameFontNormal); WOWTR_Panel9Header1:SetJustifyH("LEFT"); WOWTR_Panel9Header1:SetJustifyV("TOP");
  WOWTR_Panel9Header1:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel9Header1:SetPoint("TOPLEFT", WOWTR_Panel9Text, "BOTTOMLEFT", 500, -70) else WOWTR_Panel9Header1:SetPoint("TOPLEFT", WOWTR_Panel9Text, "BOTTOMLEFT", -10, -25) end
  WOWTR_Panel9Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.authorHeader)); WOWTR_Panel9Header1:SetFont(WOWTR_Font2, 15)

  local WOWTR_Panel9Author1 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK"); WOWTR_Panel9Author1:SetFontObject(GameFontWhite); WOWTR_Panel9Author1:SetJustifyH("LEFT"); WOWTR_Panel9Author1:SetJustifyV("TOP");
  WOWTR_Panel9Author1:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel9Author1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 55, -15) else WOWTR_Panel9Author1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 20, -15) end
  WOWTR_Panel9Author1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.author)); WOWTR_Panel9Author1:SetFont(WOWTR_Font2, 13)

  local WOWTR_Panel9Author2 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK"); WOWTR_Panel9Author2:SetFontObject(GameFontWhite); WOWTR_Panel9Author2:SetJustifyV("TOP");
  WOWTR_Panel9Author2:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel9Author2:SetJustifyH("RIGHT"); WOWTR_Panel9Author2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", -51, -15) else WOWTR_Panel9Author2:SetJustifyH("LEFT"); WOWTR_Panel9Author2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 120, -15) end
  WOWTR_Panel9Author2:SetText("Platine"); WOWTR_Panel9Author2:SetFont(WOWTR_Font2, 13)

  local WOWTR_Panel9Email1 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK"); WOWTR_Panel9Email1:SetFontObject(GameFontWhite); WOWTR_Panel9Email1:SetJustifyH("LEFT"); WOWTR_Panel9Email1:SetJustifyV("TOP");
  WOWTR_Panel9Email1:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel9Email1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 12, -35) else WOWTR_Panel9Email1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 20, -35) end
  WOWTR_Panel9Email1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.email)); WOWTR_Panel9Email1:SetFont(WOWTR_Font2, 13)

  local WOWTR_Panel9Email2 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK"); WOWTR_Panel9Email2:SetFontObject(GameFontWhite); WOWTR_Panel9Email2:SetJustifyH("LEFT"); WOWTR_Panel9Email2:SetJustifyV("TOP");
  WOWTR_Panel9Email2:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_Panel9Email2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", -150, -35) else WOWTR_Panel9Email2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 120, -35) end
  WOWTR_Panel9Email2:SetText("platine.wow@gmail.com"); WOWTR_Panel9Email2:SetFont(WOWTR_Font2, 13)

  WOWTR_ResetButton1 = CreateFrame("BUTTON", nil, WOWTR_OptionPanel9, "UIPanelButtonTemplate"); WOWTR_ResetButton1:SetWidth(300); WOWTR_ResetButton1:SetHeight(32)
  WOWTR_ResetButton1:SetText(QTR_ReverseIfAR(WoWTR_Localization.resetButton1)); WOWTR_ResetButton1:ClearAllPoints(); if (WoWTR_Localization.lang == 'AR') then WOWTR_ResetButton1:SetPoint("BOTTOMRIGHT", WOWTR_Panel9Header1, "TOPRIGHT", 5, 15) else WOWTR_ResetButton1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "TOPLEFT", 360, 5) end
  WOWTR_ResetButton1:SetScript("OnClick", function() WOWTR_Confirmation2:Hide(); WOWTR_Confirmation1:Show() end)

  WOWTR_Confirmation1 = CreateFrame("Frame", nil, WOWTR_OptionPanel9, "UIPanelDialogTemplate");
  WOWTR_Confirmation1:SetWidth(305); WOWTR_Confirmation1:SetHeight(120); WOWTR_Confirmation1:ClearAllPoints();
  WOWTR_Confirmation1:SetPoint("CENTER", WOWTR_OptionPanel9, "CENTER", 0, 108); WOWTR_Confirmation1:SetFrameStrata("TOOLTIP");
  WOWTR_Confirmation1.Title:SetText(WoWTR_Localization.confirmationHeader); WOWTR_Confirmation1.Title:SetFont(WOWTR_Font2, 13);
  WOWTR_Confirmation1.Text = WOWTR_Confirmation1:CreateFontString(nil, "ARTWORK"); WOWTR_Confirmation1.Text:SetFontObject(GameFontWhite); WOWTR_Confirmation1.Text:SetJustifyH("CENTER"); WOWTR_Confirmation1.Text:SetJustifyV("TOP");
  WOWTR_Confirmation1.Text:ClearAllPoints(); WOWTR_Confirmation1.Text:SetPoint("TOPLEFT", WOWTR_Confirmation1, "TOPLEFT", 20, -40); WOWTR_Confirmation1.Text:SetWidth(280);
  WOWTR_Confirmation1.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.confirmationText1)); WOWTR_Confirmation1.Text:SetFont(WOWTR_Font2, 14);
  WOWTR_Confirmation1.ButtonYES = CreateFrame("Button", nil, WOWTR_Confirmation1, "UIPanelButtonTemplate"); WOWTR_Confirmation1.ButtonYES:SetWidth(75); WOWTR_Confirmation1.ButtonYES:SetHeight(20);
  local fo = WOWTR_Confirmation1.ButtonYES:CreateFontString(); fo:SetFont(WOWTR_Font2, 13); fo:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieYes))); WOWTR_Confirmation1.ButtonYES:SetFontString(fo);
  WOWTR_Confirmation1.ButtonYES:SetText(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieYes)); WOWTR_Confirmation1.ButtonYES:ClearAllPoints(); WOWTR_Confirmation1.ButtonYES:SetPoint("BOTTOMLEFT", WOWTR_Confirmation1, "BOTTOMLEFT", 20, 15); WOWTR_Confirmation1.ButtonYES:Show();
  WOWTR_Confirmation1.ButtonYES:SetScript("OnClick", function() WOWTR_ResetVariables(1) end)
  WOWTR_Confirmation1.ButtonNO = CreateFrame("Button", nil, WOWTR_Confirmation1, "UIPanelButtonTemplate"); WOWTR_Confirmation1.ButtonNO:SetWidth(75); WOWTR_Confirmation1.ButtonNO:SetHeight(20);
  local fo2 = WOWTR_Confirmation1.ButtonNO:CreateFontString(); fo2:SetFont(WOWTR_Font2, 13); fo2:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieNo))); WOWTR_Confirmation1.ButtonNO:SetFontString(fo2);
  WOWTR_Confirmation1.ButtonNO:SetText(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieNo)); WOWTR_Confirmation1.ButtonNO:ClearAllPoints(); WOWTR_Confirmation1.ButtonNO:SetPoint("BOTTOMRIGHT", WOWTR_Confirmation1, "BOTTOMRIGHT", -15, 15); WOWTR_Confirmation1.ButtonNO:Show();
  WOWTR_Confirmation1.ButtonNO:SetScript("OnClick", function() WOWTR_Confirmation1:Hide() end)
  WOWTR_Confirmation1:Hide()

  WOWTR_Confirmation2 = CreateFrame("Frame", nil, WOWTR_OptionPanel4, "UIPanelDialogTemplate");
  WOWTR_Confirmation2:SetWidth(305); WOWTR_Confirmation2:SetHeight(120); WOWTR_Confirmation2:ClearAllPoints();
  WOWTR_Confirmation2:SetPoint("BOTTOMLEFT", WOWTR_Panel4Header1, "BOTTOMLEFT", -30, -395); WOWTR_Confirmation2:SetFrameStrata("TOOLTIP");
  WOWTR_Confirmation2.Title:SetText(QTR_ReverseIfAR(WoWTR_Localization.confirmationHeader)); WOWTR_Confirmation2.Title:SetFont(WOWTR_Font2, 13)
  WOWTR_Confirmation2.Text = WOWTR_Confirmation2:CreateFontString(nil, "ARTWORK"); WOWTR_Confirmation2.Text:SetFontObject(GameFontWhite); WOWTR_Confirmation2.Text:SetJustifyH("CENTER"); WOWTR_Confirmation2.Text:SetJustifyV("TOP");
  WOWTR_Confirmation2.Text:ClearAllPoints(); WOWTR_Confirmation2.Text:SetPoint("TOPLEFT", WOWTR_Confirmation2, "TOPLEFT", 20, -40); WOWTR_Confirmation2.Text:SetWidth(280);
  WOWTR_Confirmation2.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.confirmationText2)); WOWTR_Confirmation2.Text:SetFont(WOWTR_Font2, 14)
  WOWTR_Confirmation2.ButtonYES = CreateFrame("Button", nil, WOWTR_Confirmation2, "UIPanelButtonTemplate"); WOWTR_Confirmation2.ButtonYES:SetWidth(75); WOWTR_Confirmation2.ButtonYES:SetHeight(20);
  local fo3 = WOWTR_Confirmation2.ButtonYES:CreateFontString(); fo3:SetFont(WOWTR_Font2, 13); fo3:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieYes))); WOWTR_Confirmation2.ButtonYES:SetFontString(fo3);
  WOWTR_Confirmation2.ButtonYES:SetText(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieYes)); WOWTR_Confirmation2.ButtonYES:ClearAllPoints(); WOWTR_Confirmation2.ButtonYES:SetPoint("BOTTOMLEFT", WOWTR_Confirmation2, "BOTTOMLEFT", 20, 15); WOWTR_Confirmation2.ButtonYES:Show();
  WOWTR_Confirmation2.ButtonYES:SetScript("OnClick", function() WOWTR_ResetVariables(2); WOWTR_ReloadUI() end)
  WOWTR_Confirmation2.ButtonNO = CreateFrame("Button", nil, WOWTR_Confirmation2, "UIPanelButtonTemplate"); WOWTR_Confirmation2.ButtonNO:SetWidth(75); WOWTR_Confirmation2.ButtonNO:SetHeight(20);
  local fo4 = WOWTR_Confirmation2.ButtonNO:CreateFontString(); fo4:SetFont(WOWTR_Font2, 13); fo4:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieNo))); WOWTR_Confirmation2.ButtonNO:SetFontString(fo4);
  WOWTR_Confirmation2.ButtonNO:SetText(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieNo)); WOWTR_Confirmation2.ButtonNO:ClearAllPoints(); WOWTR_Confirmation2.ButtonNO:SetPoint("BOTTOMRIGHT", WOWTR_Confirmation2, "BOTTOMRIGHT", -15, 15); WOWTR_Confirmation2.ButtonNO:Show();
  WOWTR_Confirmation2.ButtonNO:SetScript("OnClick", function() WOWTR_Confirmation2:Hide() end)
  WOWTR_Confirmation2:Hide()
end


