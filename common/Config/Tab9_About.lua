function WOWTR_CreateOptionPanel9(WOWTR_OptionPanel9)
   ----- TAB 9

   local WOWTR_Panel9Text = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9Text:SetFontObject(GameFontWhite);
   WOWTR_Panel9Text:SetJustifyH("LEFT");
   WOWTR_Panel9Text:SetJustifyV("TOP");
   WOWTR_Panel9Text:ClearAllPoints();
   WOWTR_Panel9Text:SetPoint("TOPLEFT", WOWTR_OptionPanel9, "TOPLEFT", 25, -10);
   WOWTR_Panel9Text:SetWidth(640);
   WOWTR_Panel9Text:SetFont(WOWTR_Font2, 14);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9Text:SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.generalText, false, WOWTR_Panel9Text,
         WOWTR_Font2, -80)); -- generalText
   else
      WOWTR_Panel9Text:SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.generalText, false, WOWTR_Panel9Text,
         WOWTR_Font2, -50)); -- generalText
   end

   local WOWTR_Panel9Header1 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9Header1:SetFontObject(GameFontNormal);
   WOWTR_Panel9Header1:SetJustifyH("LEFT");
   WOWTR_Panel9Header1:SetJustifyV("TOP");
   WOWTR_Panel9Header1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9Header1:SetPoint("TOPLEFT", WOWTR_Panel9Text, "BOTTOMLEFT", 500, -70);
   else
      WOWTR_Panel9Header1:SetPoint("TOPLEFT", WOWTR_Panel9Text, "BOTTOMLEFT", -10, -25);
   end
   WOWTR_Panel9Header1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.authorHeader)); -- Author info
   WOWTR_Panel9Header1:SetFont(WOWTR_Font2, 15);

   local WOWTR_Panel9Author1 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9Author1:SetFontObject(GameFontWhite);
   WOWTR_Panel9Author1:SetJustifyH("LEFT");
   WOWTR_Panel9Author1:SetJustifyV("TOP");
   WOWTR_Panel9Author1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9Author1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 55, -15);
   else
      WOWTR_Panel9Author1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 20, -15);
   end
   WOWTR_Panel9Author1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.author)); -- Author:
   WOWTR_Panel9Author1:SetFont(WOWTR_Font2, 13);

   local WOWTR_Panel9Author2 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9Author2:SetFontObject(GameFontWhite);
   WOWTR_Panel9Author2:SetJustifyV("TOP");
   WOWTR_Panel9Author2:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9Author2:SetJustifyH("RIGHT");
      WOWTR_Panel9Author2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", -51, -15);
   else
      WOWTR_Panel9Author2:SetJustifyH("LEFT");
      WOWTR_Panel9Author2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 120, -15);
   end
   WOWTR_Panel9Author2:SetText("Platine"); -- Platine
   WOWTR_Panel9Author2:SetFont(WOWTR_Font2, 13);

   local WOWTR_Panel9Email1 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9Email1:SetFontObject(GameFontWhite);
   WOWTR_Panel9Email1:SetJustifyH("LEFT");
   WOWTR_Panel9Email1:SetJustifyV("TOP");
   WOWTR_Panel9Email1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9Email1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 12, -35);
   else
      WOWTR_Panel9Email1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 20, -35);
   end
   WOWTR_Panel9Email1:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.email)); -- E-mail:
   WOWTR_Panel9Email1:SetFont(WOWTR_Font2, 13);

   local WOWTR_Panel9Email2 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9Email2:SetFontObject(GameFontWhite);
   WOWTR_Panel9Email2:SetJustifyH("LEFT");
   WOWTR_Panel9Email2:SetJustifyV("TOP");
   WOWTR_Panel9Email2:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9Email2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", -150, -35);
   else
      WOWTR_Panel9Email2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 120, -35);
   end
   WOWTR_Panel9Email2:SetText("platine.wow@gmail.com"); -- platine.wow@gmail.com
   WOWTR_Panel9Email2:SetFont(WOWTR_Font2, 13);

   if (WoWTR_Localization.lang == 'TR') then
      local WOWTR_Panel9Author2 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
      WOWTR_Panel9Author2:SetFontObject(GameFontWhite);
      WOWTR_Panel9Author2:SetJustifyV("TOP");
      WOWTR_Panel9Author2:ClearAllPoints();
      WOWTR_Panel9Author2:SetJustifyH("LEFT");
      WOWTR_Panel9Author2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 350, -15);
      WOWTR_Panel9Author2:SetText("Hakan YILMAZ"); -- hknylmz
      WOWTR_Panel9Author2:SetFont(WOWTR_Font2, 13);

      local WOWTR_Panel9Email3 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
      WOWTR_Panel9Email3:SetFontObject(GameFontWhite);
      WOWTR_Panel9Email3:SetJustifyH("LEFT");
      WOWTR_Panel9Email3:SetJustifyV("TOP");
      WOWTR_Panel9Email3:ClearAllPoints();
      WOWTR_Panel9Email3:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 350, -35);
      WOWTR_Panel9Email3:SetText("hknylmz@gmail.com"); -- hknylmz@gmail.com
      WOWTR_Panel9Email3:SetFont(WOWTR_Font2, 13);
   end

   WOWTR_ResetButton1 = CreateFrame("BUTTON", nil, WOWTR_OptionPanel9, "UIPanelButtonTemplate");
   WOWTR_ResetButton1:SetWidth(300);
   WOWTR_ResetButton1:SetHeight(32);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'PL')) then
      local fo = WOWTR_ResetButton1:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Localization.resetButton1));
      WOWTR_ResetButton1:SetFontString(fo);
   end
   WOWTR_ResetButton1:SetText(QTR_ReverseIfAR(WoWTR_Localization.resetButton1)); -- Wyczyść zapisane nieprzetłumaczone teksty
   WOWTR_ResetButton1:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_ResetButton1:SetPoint("BOTTOMRIGHT", WOWTR_Panel9Header1, "TOPRIGHT", 5, 15);
   else
      WOWTR_ResetButton1:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "TOPLEFT", 360, 5);
   end
   WOWTR_ResetButton1:Show();
   WOWTR_ResetButton1:SetScript("OnClick", function()
      WOWTR_Confirmation2:Hide(); WOWTR_Confirmation1:Show();
   end);
   WOWTR_ResetButton1:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Localization.resetButton1Opis) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Localization.resetButton1OpisDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) ..
         NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                   --Show the tooltip
   end);
   WOWTR_ResetButton1:SetScript("OnLeave", function(self)
      GameTooltip:Hide() --Hide the tooltip
   end);

   local WOWTR_Panel9Header2 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9Header2:SetFontObject(GameFontNormal);
   WOWTR_Panel9Header2:SetJustifyH("LEFT");
   WOWTR_Panel9Header2:SetJustifyV("TOP");
   WOWTR_Panel9Header2:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9Header2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 0, -75);
   else
      WOWTR_Panel9Header2:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 0, -75);
   end
   WOWTR_Panel9Header2:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.teamHeader)); -- WoWTR project team
   WOWTR_Panel9Header2:SetFont(WOWTR_Font2, 15);

   local WOWTR_Panel9TextContact = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9TextContact:SetFontObject(GameFontWhite);
   WOWTR_Panel9TextContact:SetJustifyH("LEFT");
   WOWTR_Panel9TextContact:SetJustifyV("TOP");
   WOWTR_Panel9TextContact:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9TextContact:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "TOPLEFT", -545, -20);
   else
      WOWTR_Panel9TextContact:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "TOPLEFT", 20, -20);
   end
   WOWTR_Panel9TextContact:SetWidth(640);
   WOWTR_Panel9TextContact:SetFont(WOWTR_Font2, 14);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9TextContact:SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.textContact, false,
         WOWTR_Panel9TextContact, WOWTR_Font2, -40)); -- TextContact
   else
      WOWTR_Panel9TextContact:SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.textContact, false,
         WOWTR_Panel9TextContact, WOWTR_Font2)); -- TextContact
   end

   WOWTR_LinkFrame = CreateFrame("Frame", nil, WOWTR_OptionPanel9, "UIPanelDialogTemplate");
   WOWTR_LinkFrame:SetWidth(305);
   WOWTR_LinkFrame:SetHeight(120);
   WOWTR_LinkFrame:ClearAllPoints();
   WOWTR_LinkFrame:SetPoint("CENTER", 0, 108);
   WOWTR_LinkFrame:SetFrameStrata("TOOLTIP");
   WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkWWWTitle)); -- Header of the link frame
   WOWTR_LinkFrame.Title:SetFont(WOWTR_Font2, 13);
   WOWTR_LinkFrame.Input = CreateFrame("EditBox", nil, WOWTR_LinkFrame, "InputBoxTemplate");
   WOWTR_LinkFrame.Input:ClearAllPoints();
   WOWTR_LinkFrame.Input:SetPoint("TOPLEFT", WOWTR_LinkFrame, "TOPLEFT", 20, -30);
   WOWTR_LinkFrame.Input:SetHeight(20);
   WOWTR_LinkFrame.Input:SetWidth(275);
   WOWTR_LinkFrame.Input:SetAutoFocus(true);
   WOWTR_LinkFrame.Input:SetFontObject(GameFontWhite);
   WOWTR_LinkFrame.Input:SetText(WoWTR_Localization.addressWWW);
   --WOWTR_LinkFrame.Input:SetCursorPosition(0);
   WOWTR_LinkFrame.Text = WOWTR_LinkFrame:CreateFontString(nil, "ARTWORK");
   WOWTR_LinkFrame.Text:SetFontObject(GameFontNormal);
   WOWTR_LinkFrame.Text:SetJustifyH("CENTER");
   WOWTR_LinkFrame.Text:SetJustifyV("TOP");
   WOWTR_LinkFrame.Text:ClearAllPoints();
   WOWTR_LinkFrame.Text:SetPoint("TOPLEFT", WOWTR_LinkFrame, "TOPLEFT", 15, -55);
   WOWTR_LinkFrame.Text:SetWidth(280);
   WOWTR_LinkFrame.Text:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkCopy)); -- Wciśnij CTRL+C aby skopiować link do schowka Windowsa
   WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
   WOWTR_LinkFrame.ButtonOK = CreateFrame("Button", nil, WOWTR_LinkFrame, "UIPanelButtonTemplate");
   WOWTR_LinkFrame.ButtonOK:SetWidth(150);
   WOWTR_LinkFrame.ButtonOK:SetHeight(20);
   local fo = WOWTR_LinkFrame.ButtonOK:CreateFontString();
   fo:SetFont(WOWTR_Font2, 13);
   fo:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Config_Interface.linkCloseFrame)));
   WOWTR_LinkFrame.ButtonOK:SetFontString(fo);
   WOWTR_LinkFrame.ButtonOK:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkCloseFrame));
   WOWTR_LinkFrame.ButtonOK:ClearAllPoints();
   WOWTR_LinkFrame.ButtonOK:SetPoint("CENTER", 0, -38);
   WOWTR_LinkFrame.ButtonOK:Show();
   WOWTR_LinkFrame.ButtonOK:SetScript("OnClick", function() WOWTR_LinkFrame:Hide(); end);
   WOWTR_LinkFrame:Hide();

   local WOW_interSpace = 70;
   local WOW_interPlace = 20;
   if (string.len(WoWTR_Localization.addressWWW) > 1) then
      local WOWTR_linkButtonWWW = CreateFrame("Button", nil, WOWTR_OptionPanel9)
      WOWTR_linkButtonWWW:SetSize(32, 32);
      if (WoWTR_Localization.lang == 'AR') then
         WOW_interPlace = 0;
         WOWTR_linkButtonWWW:SetPoint("TOPRIGHT", WOWTR_Panel9Header2, "BOTTOMRIGHT", WOW_interPlace, -35);
      else
         WOWTR_linkButtonWWW:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "BOTTOMLEFT", WOW_interPlace, -35);
      end
      WOWTR_linkButtonWWW.icon = WOWTR_linkButtonWWW:CreateTexture()
      WOWTR_linkButtonWWW.icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon_www.png")
      WOWTR_linkButtonWWW.icon:SetSize(32, 32);
      WOWTR_linkButtonWWW.icon:SetPoint("LEFT", 0, 0);

      WOWTR_linkButtonWWW:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.linkWWWShow), 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                                                       -- Show the tooltip
         if (WoWTR_Localization.lang == 'AR') then
            getglobal("GameTooltipTextLeft1"):SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.linkWWWShow, false,
               getglobal("GameTooltipTextLeft1"), WOWTR_Font2, -20)); -- white color, wrap
         else
            getglobal("GameTooltipTextLeft1"):SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.linkWWWShow, false,
               getglobal("GameTooltipTextLeft1"), WOWTR_Font2)); -- white color, wrap
         end
      end);
      WOWTR_linkButtonWWW:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);
      WOWTR_linkButtonWWW:SetScript("OnClick", function(self)
         WOWTR_LinkFrame:Hide();
         WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkWWWTitle));
         WOWTR_LinkFrame.Input:SetText(WoWTR_Localization.addressWWW);
         WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
         WOWTR_LinkFrame:Show();
      end);
   end

   if (string.len(WoWTR_Localization.addressDiscord) > 1) then
      local WOWTR_linkButtonDISC = CreateFrame("Button", nil, WOWTR_OptionPanel9)
      WOWTR_linkButtonDISC:SetSize(64, 32);
      WOW_interPlace = WOW_interPlace + WOW_interSpace;
      if (WoWTR_Localization.lang == 'AR') then
         WOW_interPlace = WOW_interPlace - 40;
         WOWTR_linkButtonDISC:SetPoint("TOPRIGHT", WOWTR_Panel9Header2, "BOTTOMRIGHT", -WOW_interPlace, -35);
         WOW_interPlace = WOW_interPlace + 10;
      else
         WOWTR_linkButtonDISC:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "BOTTOMLEFT", WOW_interPlace, -35);
      end
      WOW_interPlace = WOW_interPlace + 10;
      WOWTR_linkButtonDISC.icon = WOWTR_linkButtonDISC:CreateTexture()
      WOWTR_linkButtonDISC.icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon_discord.png")
      WOWTR_linkButtonDISC.icon:SetSize(64, 32);
      WOWTR_linkButtonDISC.icon:SetPoint("LEFT", 0, 0);

      WOWTR_linkButtonDISC:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.linkDISCShow), 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                                                        -- Show the tooltip
      end);
      WOWTR_linkButtonDISC:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);
      WOWTR_linkButtonDISC:SetScript("OnClick", function(self)
         WOWTR_LinkFrame:Hide();
         WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkDISCTitle));
         WOWTR_LinkFrame.Input:SetText(WoWTR_Localization.addressDiscord);
         WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
         WOWTR_LinkFrame:Show();
      end);
   end

   if (WoWTR_Localization.lang == 'AR') then
      if (string.len(WoWTR_Config_Interface.addressCOM) > 1) then
         local WOWTR_linkButtonDISC = CreateFrame("Button", nil, WOWTR_OptionPanel9)
         WOWTR_linkButtonDISC:SetSize(64, 32);
         WOW_interPlace = WOW_interPlace + WOW_interSpace;
         if (WoWTR_Localization.lang == 'AR') then
            WOW_interPlace = WOW_interPlace - 40;
            WOWTR_linkButtonDISC:SetPoint("TOPRIGHT", WOWTR_Panel9Header2, "BOTTOMRIGHT", -WOW_interPlace, -35);
            WOW_interPlace = WOW_interPlace + 10;
         else
            WOWTR_linkButtonDISC:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "BOTTOMLEFT", WOW_interPlace, -35);
         end
         WOW_interPlace = WOW_interPlace + 10;
         WOWTR_linkButtonDISC.icon = WOWTR_linkButtonDISC:CreateTexture()
         WOWTR_linkButtonDISC.icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\Abosarah.png")
         WOWTR_linkButtonDISC.icon:SetSize(32, 32);
         WOWTR_linkButtonDISC.icon:SetPoint("LEFT", 0, 0);

         WOWTR_linkButtonDISC:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
            GameTooltip:ClearLines();
            GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.linkDISCShowCOM), 1, 1, 1, true); -- white color, wrap
            getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
            GameTooltip:Show()                                                                           -- Show the tooltip
         end);
         WOWTR_linkButtonDISC:SetScript("OnLeave", function(self)
            GameTooltip:Hide() -- Hide the tooltip
         end);
         WOWTR_linkButtonDISC:SetScript("OnClick", function(self)
            WOWTR_LinkFrame:Hide();
            WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkCOM));
            WOWTR_LinkFrame.Input:SetText(WoWTR_Config_Interface.addressCOM);
            WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
            WOWTR_LinkFrame:Show();
         end);
      end
   end

   if (string.len(WoWTR_Localization.addressTwitch) > 1) then
      local WOWTR_linkButtonTWITCH = CreateFrame("Button", nil, WOWTR_OptionPanel9)
      WOWTR_linkButtonTWITCH:SetSize(32, 32);
      WOW_interPlace = WOW_interPlace + WOW_interSpace;
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_linkButtonTWITCH:SetPoint("TOPRIGHT", WOWTR_Panel9Header2, "BOTTOMRIGHT", -WOW_interPlace, -35);
      else
         WOWTR_linkButtonTWITCH:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "BOTTOMLEFT", WOW_interPlace, -35);
      end
      WOWTR_linkButtonTWITCH.icon = WOWTR_linkButtonTWITCH:CreateTexture()
      WOWTR_linkButtonTWITCH.icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon_twitch.png")
      WOWTR_linkButtonTWITCH.icon:SetSize(32, 32);
      WOWTR_linkButtonTWITCH.icon:SetPoint("LEFT", 0, 0);

      WOWTR_linkButtonTWITCH:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.linkTWITCHShow), 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                                                          -- Show the tooltip
      end);
      WOWTR_linkButtonTWITCH:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);
      WOWTR_linkButtonTWITCH:SetScript("OnClick", function(self)
         WOWTR_LinkFrame:Hide();
         WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkTWITCHTitle));
         WOWTR_LinkFrame.Input:SetText(WoWTR_Localization.addressTwitch);
         WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
         WOWTR_LinkFrame:Show();
      end);
   end

   if (string.len(WoWTR_Localization.addressFanPage) > 1) then
      local WOWTR_linkButtonFB = CreateFrame("Button", nil, WOWTR_OptionPanel9)
      WOWTR_linkButtonFB:SetSize(32, 32);
      WOW_interPlace = WOW_interPlace + WOW_interSpace;
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_linkButtonFB:SetPoint("TOPRIGHT", WOWTR_Panel9Header2, "BOTTOMRIGHT", -WOW_interPlace, -35);
      else
         WOWTR_linkButtonFB:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "BOTTOMLEFT", WOW_interPlace, -35);
      end
      WOWTR_linkButtonFB.icon = WOWTR_linkButtonFB:CreateTexture()
      WOWTR_linkButtonFB.icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon_fb.png")
      WOWTR_linkButtonFB.icon:SetSize(32, 32);
      WOWTR_linkButtonFB.icon:SetPoint("LEFT", 0, 0);

      WOWTR_linkButtonFB:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.linkFBShow), 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                                                      -- Show the tooltip
      end);
      WOWTR_linkButtonFB:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);
      WOWTR_linkButtonFB:SetScript("OnClick", function(self)
         WOWTR_LinkFrame:Hide();
         WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkFBTitle));
         WOWTR_LinkFrame.Input:SetText(WoWTR_Localization.addressFanPage);
         WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
         WOWTR_LinkFrame:Show();
      end);
   end

   if (string.len(WoWTR_Localization.addressEmail) > 1) then
      local WOWTR_linkButtonEMAIL = CreateFrame("Button", nil, WOWTR_OptionPanel9)
      WOWTR_linkButtonEMAIL:SetSize(32, 32);
      WOW_interPlace = WOW_interPlace + WOW_interSpace;
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_linkButtonEMAIL:SetPoint("TOPRIGHT", WOWTR_Panel9Header2, "BOTTOMRIGHT", -WOW_interPlace, -35);
      else
         WOWTR_linkButtonEMAIL:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "BOTTOMLEFT", WOW_interPlace, -35);
      end
      WOWTR_linkButtonEMAIL.icon = WOWTR_linkButtonEMAIL:CreateTexture()
      WOWTR_linkButtonEMAIL.icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon_email.png")
      WOWTR_linkButtonEMAIL.icon:SetSize(32, 32);
      WOWTR_linkButtonEMAIL.icon:SetPoint("LEFT", 0, 0);

      WOWTR_linkButtonEMAIL:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.linkEMAILShow), 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                                                         -- Show the tooltip
      end);
      WOWTR_linkButtonEMAIL:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);
      WOWTR_linkButtonEMAIL:SetScript("OnClick", function(self)
         WOWTR_LinkFrame:Hide();
         WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkEMAILTitle));
         WOWTR_LinkFrame.Input:SetText(WoWTR_Localization.addressEmail);
         WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
         WOWTR_LinkFrame:Show();
      end);
   end

   if (string.len(WoWTR_Localization.addressCurse) > 1) then
      local WOWTR_linkButtonCURSE = CreateFrame("Button", nil, WOWTR_OptionPanel9)
      WOWTR_linkButtonCURSE:SetSize(64, 32);
      WOW_interPlace = WOW_interPlace + WOW_interSpace;
      if (WoWTR_Localization.lang == 'AR') then
         WOW_interPlace = WOW_interPlace - 30;
         WOWTR_linkButtonCURSE:SetPoint("TOPRIGHT", WOWTR_Panel9Header2, "BOTTOMRIGHT", -WOW_interPlace, -35);
         WOW_interPlace = WOW_interPlace + 10;
      else
         WOWTR_linkButtonCURSE:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "BOTTOMLEFT", WOW_interPlace, -35);
      end
      WOW_interPlace = WOW_interPlace + 10;
      WOWTR_linkButtonCURSE.icon = WOWTR_linkButtonCURSE:CreateTexture()
      WOWTR_linkButtonCURSE.icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon_curseforge.png")
      WOWTR_linkButtonCURSE.icon:SetSize(64, 32);
      WOWTR_linkButtonCURSE.icon:SetPoint("LEFT", 0, 0);

      WOWTR_linkButtonCURSE:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.linkCURSEShow), 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                                                         -- Show the tooltip
      end);
      WOWTR_linkButtonCURSE:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);
      WOWTR_linkButtonCURSE:SetScript("OnClick", function(self)
         WOWTR_LinkFrame:Hide();
         WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkCURSETitle));
         WOWTR_LinkFrame.Input:SetText(WoWTR_Localization.addressCurse);
         WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
         WOWTR_LinkFrame:Show();
      end);
   end

   if (string.len(WoWTR_Localization.addressPayPal) > 1) then
      local WOWTR_linkButtonPP = CreateFrame("Button", nil, WOWTR_OptionPanel9)
      WOWTR_linkButtonPP:SetSize(32, 32);
      WOW_interPlace = WOW_interPlace + WOW_interSpace;
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_linkButtonPP:SetPoint("TOPRIGHT", WOWTR_Panel9Header2, "BOTTOMRIGHT", -WOW_interPlace, -35);
      else
         WOWTR_linkButtonPP:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "BOTTOMLEFT", WOW_interPlace, -35);
      end
      WOWTR_linkButtonPP.icon = WOWTR_linkButtonPP:CreateTexture()
      WOWTR_linkButtonPP.icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon_paypal.png")
      WOWTR_linkButtonPP.icon:SetSize(32, 32);
      WOWTR_linkButtonPP.icon:SetPoint("LEFT", 0, 0);

      WOWTR_linkButtonPP:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.linkPPShow), 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                                                      -- Show the tooltip
      end);
      WOWTR_linkButtonPP:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);
      WOWTR_linkButtonPP:SetScript("OnClick", function(self)
         WOWTR_LinkFrame:Hide();
         WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkPPTitle));
         WOWTR_LinkFrame.Input:SetText(WoWTR_Localization.addressPayPal);
         WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
         WOWTR_LinkFrame:Show();
      end);
   end

   if (string.len(WoWTR_Localization.addressBlik) > 1) then
      local WOWTR_linkButtonBLIK = CreateFrame("Button", nil, WOWTR_OptionPanel9)
      if (WoWTR_Localization.lang == 'TR') then
         WOWTR_linkButtonBLIK:SetSize(32, 32);
      else
         WOWTR_linkButtonBLIK:SetSize(64, 32);
      end
      WOW_interPlace = WOW_interPlace + WOW_interSpace - 10;
      if (WoWTR_Localization.lang == 'AR') then
         WOWTR_linkButtonBLIK:SetPoint("TOPRIGHT", WOWTR_Panel9Header2, "BOTTOMRIGHT", -WOW_interPlace, -35);
      else
         WOWTR_linkButtonBLIK:SetPoint("TOPLEFT", WOWTR_Panel9Header2, "BOTTOMLEFT", WOW_interPlace, -35);
      end
      WOWTR_linkButtonBLIK.icon = WOWTR_linkButtonBLIK:CreateTexture()
      WOWTR_linkButtonBLIK.icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon_blik.png")
      if (WoWTR_Localization.lang == 'TR') then
         WOWTR_linkButtonBLIK.icon:SetSize(32, 32);
      else
         WOWTR_linkButtonBLIK.icon:SetSize(64, 32);
      end
      WOWTR_linkButtonBLIK.icon:SetPoint("LEFT", 0, 0);

      WOWTR_linkButtonBLIK:SetScript("OnEnter", function(self)
         GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
         GameTooltip:ClearLines();
         GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.linkBLIKShow), 1, 1, 1, true); -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
         GameTooltip:Show()                                                                        -- Show the tooltip
      end);
      WOWTR_linkButtonBLIK:SetScript("OnLeave", function(self)
         GameTooltip:Hide() -- Hide the tooltip
      end);
      WOWTR_linkButtonBLIK:SetScript("OnClick", function(self)
         WOWTR_LinkFrame:Hide();
         WOWTR_LinkFrame.Title:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.linkBLIKTitle));
         WOWTR_LinkFrame.Input:SetText(WoWTR_Localization.addressBlik);
         WOWTR_LinkFrame.Text:SetFont(WOWTR_Font2, 12);
         WOWTR_LinkFrame:Show();
      end);
   end

   local WOWTR_Panel9Header3 = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9Header3:SetFontObject(GameFontNormal);
   WOWTR_Panel9Header3:SetJustifyH("LEFT");
   WOWTR_Panel9Header3:SetJustifyV("TOP");
   WOWTR_Panel9Header3:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9Header3:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 50, -185);
   else
      WOWTR_Panel9Header3:SetPoint("TOPLEFT", WOWTR_Panel9Header1, "BOTTOMLEFT", 0, -185);
   end
   WOWTR_Panel9Header3:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.betaTestersHeader)); -- Beta Testers:
   WOWTR_Panel9Header3:SetFont(WOWTR_Font2, 15);

   local WOWTR_Panel9Testers = WOWTR_OptionPanel9:CreateFontString(nil, "ARTWORK");
   WOWTR_Panel9Testers:SetFontObject(GameFontWhite);
   WOWTR_Panel9Testers:SetJustifyH("LEFT");
   WOWTR_Panel9Testers:SetJustifyV("TOP");
   WOWTR_Panel9Testers:ClearAllPoints();
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_Panel9Testers:SetPoint("TOPLEFT", WOWTR_Panel9Header3, "BOTTOMLEFT", 0, -10);
   else
      WOWTR_Panel9Testers:SetPoint("TOPLEFT", WOWTR_Panel9Header3, "BOTTOMLEFT", 20, -10);
   end
   WOWTR_Panel9Testers:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.betaTestersHeaderDESC));
   WOWTR_Panel9Testers:SetFont(WOWTR_Font2, 13);

   if (string.len(WoWTR_Config_Interface.welcomeText) > 1) then
      local WOWTR_ShowWelcomePanel = CreateFrame("BUTTON", nil, WOWTR_OptionPanel9, "UIPanelButtonTemplate");
      WOWTR_ShowWelcomePanel:SetWidth(200);
      WOWTR_ShowWelcomePanel:SetHeight(20);
      local fo = WOWTR_ShowWelcomePanel:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.showWelcome));
      WOWTR_ShowWelcomePanel:SetFontString(fo);
      WOWTR_ShowWelcomePanel:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.showWelcome));
      WOWTR_ShowWelcomePanel:ClearAllPoints();
      WOWTR_ShowWelcomePanel:SetPoint("BOTTOMLEFT", WOWTR_OptionPanel9, "BOTTOMLEFT", 20, 20);
      WOWTR_ShowWelcomePanel:Show();
      WOWTR_ShowWelcomePanel:SetScript("OnClick", function() WOWTR_WelcomePanel(); end);
   end

   WOWTR_Confirmation1 = CreateFrame("Frame", nil, WOWTR_OptionPanel9, "UIPanelDialogTemplate");
   WOWTR_Confirmation1:SetWidth(305);
   WOWTR_Confirmation1:SetHeight(120);
   WOWTR_Confirmation1:ClearAllPoints();
   WOWTR_Confirmation1:SetPoint("CENTER", WOWTR_OptionPanel9, "CENTER", 0, 108);
   WOWTR_Confirmation1:SetFrameStrata("TOOLTIP");
   WOWTR_Confirmation1.Title:SetText(WoWTR_Localization.confirmationHeader); -- Confirmation Header
   WOWTR_Confirmation1.Title:SetFont(WOWTR_Font2, 13);
   WOWTR_Confirmation1.Text = WOWTR_Confirmation1:CreateFontString(nil, "ARTWORK");
   WOWTR_Confirmation1.Text:SetFontObject(GameFontWhite);
   WOWTR_Confirmation1.Text:SetJustifyH("CENTER");
   WOWTR_Confirmation1.Text:SetJustifyV("TOP");
   WOWTR_Confirmation1.Text:ClearAllPoints();
   WOWTR_Confirmation1.Text:SetPoint("TOPLEFT", WOWTR_Confirmation1, "TOPLEFT", 20, -40);
   WOWTR_Confirmation1.Text:SetWidth(280);
   WOWTR_Confirmation1.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.confirmationText1)); -- Czy chcesz wyczyścić wszystkie zapisane, nieprzetłumaczone teksty?
   WOWTR_Confirmation1.Text:SetFont(WOWTR_Font2, 14);
   WOWTR_Confirmation1.ButtonYES = CreateFrame("Button", nil, WOWTR_Confirmation1, "UIPanelButtonTemplate");
   WOWTR_Confirmation1.ButtonYES:SetWidth(75);
   WOWTR_Confirmation1.ButtonYES:SetHeight(20);
   local fo = WOWTR_Confirmation1.ButtonYES:CreateFontString();
   fo:SetFont(WOWTR_Font2, 13);
   fo:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieYes)));
   WOWTR_Confirmation1.ButtonYES:SetFontString(fo);
   WOWTR_Confirmation1.ButtonYES:SetText(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieYes)); -- Yes
   WOWTR_Confirmation1.ButtonYES:ClearAllPoints();
   WOWTR_Confirmation1.ButtonYES:SetPoint("BOTTOMLEFT", WOWTR_Confirmation1, "BOTTOMLEFT", 20, 15);
   WOWTR_Confirmation1.ButtonYES:Show();
   WOWTR_Confirmation1.ButtonYES:SetScript("OnClick", function() WOWTR_ResetVariables(1); end);
   WOWTR_Confirmation1.ButtonNO = CreateFrame("Button", nil, WOWTR_Confirmation1, "UIPanelButtonTemplate");
   WOWTR_Confirmation1.ButtonNO:SetWidth(75);
   WOWTR_Confirmation1.ButtonNO:SetHeight(20);
   local fo = WOWTR_Confirmation1.ButtonNO:CreateFontString();
   fo:SetFont(WOWTR_Font2, 13);
   fo:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieNo)));
   WOWTR_Confirmation1.ButtonNO:SetFontString(fo);
   WOWTR_Confirmation1.ButtonNO:SetText(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieNo)); -- No
   WOWTR_Confirmation1.ButtonNO:ClearAllPoints();
   WOWTR_Confirmation1.ButtonNO:SetPoint("BOTTOMRIGHT", WOWTR_Confirmation1, "BOTTOMRIGHT", -15, 15);
   WOWTR_Confirmation1.ButtonNO:Show();
   WOWTR_Confirmation1.ButtonNO:SetScript("OnClick", function() WOWTR_Confirmation1:Hide(); end);
   WOWTR_Confirmation1:Hide();

   WOWTR_Confirmation2 = CreateFrame("Frame", nil, WOWTR_OptionPanel4, "UIPanelDialogTemplate");
   WOWTR_Confirmation2:SetWidth(305);
   WOWTR_Confirmation2:SetHeight(120);
   WOWTR_Confirmation2:ClearAllPoints();
   WOWTR_Confirmation2:SetPoint("BOTTOMLEFT", WOWTR_ResetButton2, "TOPLEFT", -30, 5);
   WOWTR_Confirmation2:SetFrameStrata("TOOLTIP");
   WOWTR_Confirmation2.Title:SetText(QTR_ReverseIfAR(WoWTR_Localization.confirmationHeader)); -- Confirmation Header
   WOWTR_Confirmation2.Text = WOWTR_Confirmation2:CreateFontString(nil, "ARTWORK");
   WOWTR_Confirmation2.Title:SetFont(WOWTR_Font2, 13);
   WOWTR_Confirmation2.Text:SetFontObject(GameFontWhite);
   WOWTR_Confirmation2.Text:SetJustifyH("CENTER");
   WOWTR_Confirmation2.Text:SetJustifyV("TOP");
   WOWTR_Confirmation2.Text:ClearAllPoints();
   WOWTR_Confirmation2.Text:SetPoint("TOPLEFT", WOWTR_Confirmation2, "TOPLEFT", 20, -40);
   WOWTR_Confirmation2.Text:SetWidth(280);
   WOWTR_Confirmation2.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.confirmationText2)); -- Czy chcesz przywrócić ustawienia domyślne dodatku?
   WOWTR_Confirmation2.Text:SetFont(WOWTR_Font2, 14);
   WOWTR_Confirmation2.ButtonYES = CreateFrame("Button", nil, WOWTR_Confirmation2, "UIPanelButtonTemplate");
   WOWTR_Confirmation2.ButtonYES:SetWidth(75);
   WOWTR_Confirmation2.ButtonYES:SetHeight(20);
   local fo = WOWTR_Confirmation2.ButtonYES:CreateFontString();
   fo:SetFont(WOWTR_Font2, 13);
   fo:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieYes)));
   WOWTR_Confirmation2.ButtonYES:SetFontString(fo);
   WOWTR_Confirmation2.ButtonYES:SetText(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieYes)); -- Yes
   WOWTR_Confirmation2.ButtonYES:ClearAllPoints();
   WOWTR_Confirmation2.ButtonYES:SetPoint("BOTTOMLEFT", WOWTR_Confirmation2, "BOTTOMLEFT", 20, 15);
   WOWTR_Confirmation2.ButtonYES:Show();
   WOWTR_Confirmation2.ButtonYES:SetScript("OnClick", function()
      WOWTR_ResetVariables(2);
      WOWTR_ReloadUI()
   end);
   WOWTR_Confirmation2.ButtonNO = CreateFrame("Button", nil, WOWTR_Confirmation2, "UIPanelButtonTemplate");
   WOWTR_Confirmation2.ButtonNO:SetWidth(75);
   WOWTR_Confirmation2.ButtonNO:SetHeight(20);
   local fo = WOWTR_Confirmation2.ButtonNO:CreateFontString();
   fo:SetFont(WOWTR_Font2, 13);
   fo:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieNo)));
   WOWTR_Confirmation2.ButtonNO:SetFontString(fo);
   WOWTR_Confirmation2.ButtonNO:SetText(QTR_ReverseIfAR(WoWTR_Localization.stopTheMovieNo)); -- No
   WOWTR_Confirmation2.ButtonNO:ClearAllPoints();
   WOWTR_Confirmation2.ButtonNO:SetPoint("BOTTOMRIGHT", WOWTR_Confirmation2, "BOTTOMRIGHT", -15, 15);
   WOWTR_Confirmation2.ButtonNO:Show();
   WOWTR_Confirmation2.ButtonNO:SetScript("OnClick", function() WOWTR_Confirmation2:Hide(); end);
   WOWTR_Confirmation2:Hide();
end
