-- Description: The AddOn displays the translated text information in chosen language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
-------------------------------------------------------------------------------------------------------

-- local WOWTR_ConfigFirstTime = true;

-----------------------------------------------------------------------------------------------------------------

function WOWTR_SetCheckButtonState()
   WOWTR_CheckButton00:SetChecked(QTR_PS["icon"] == "1");
   WOWTR_CheckButton11:SetChecked(QTR_PS["active"] == "1");
   WOWTR_CheckButton12:SetChecked(QTR_PS["transtitle"] == "1");
   WOWTR_CheckButton13:SetChecked(QTR_PS["gossip"] == "1");
   WOWTR_CheckButton14:SetChecked(QTR_PS["tracker"] == "1");
   WOWTR_CheckButton15:SetChecked(QTR_PS["saveQS"] == "1");
   WOWTR_CheckButton16:SetChecked(QTR_PS["saveGS"] == "1");
   WOWTR_CheckButton17:SetChecked(QTR_PS["immersion"] == "1");
   WOWTR_CheckButton18:SetChecked(QTR_PS["storyline"] == "1");
   WOWTR_CheckButton19:SetChecked(QTR_PS["questlog"] == "1");
   WOWTR_CheckButton1a:SetChecked(QTR_PS["ownnames"] == "1");
   WOWTR_CheckButton1b:SetChecked(QTR_PS["dialogueui"] == "1");
   WOWTR_CheckButton1c:SetChecked(QTR_PS["en_first"] == "1");

   WOWTR_CheckButton21:SetChecked(BB_PM["active"] == "1");
   WOWTR_CheckButton22:SetChecked(BB_PM["chat-en"] == "1");
   WOWTR_CheckButton23:SetChecked(BB_PM["chat-tr"] == "1");
   WOWTR_CheckButton24:SetChecked(BB_PM["sex"] == "2");
   WOWTR_CheckButton25:SetChecked(BB_PM["sex"] == "3");
   WOWTR_CheckButton26:SetChecked(BB_PM["sex"] == "4");
   WOWTR_CheckButton27:SetChecked(BB_PM["saveNB"] == "1");
   WOWTR_CheckButton28:SetChecked(BB_PM["setsize"] == "1");
   WOWTR_CheckButton2d1:SetChecked(BB_PM["dungeon"] == "1");
   WOWTR_CheckButton2d2:SetChecked(false);
   BB_PM["dungeonF"] = "0"; -- setting dungeon frames

   WOWTR_CheckButton31:SetChecked(MF_PM["active"] == "1");
   WOWTR_CheckButton32:SetChecked(MF_PM["intro"] == "1");
   WOWTR_CheckButton33:SetChecked(MF_PM["movie"] == "1");
   WOWTR_CheckButton34:SetChecked(MF_PM["cinematic"] == "1");
   WOWTR_CheckButton35:SetChecked(MF_PM["save"] == "1");

   if (WoWTR_Localization.lang == 'AR') then -- part: Chat
      WOWTR_CheckButton36:SetChecked(CH_PM["active"] == "1");
      WOWTR_CheckButton37:SetChecked(CH_PM["setsize"] == "1");
      WOWTR_slider6:SetValue(tonumber(CH_PM["fontsize"]));
   end

   WOWTR_CheckButton40:SetChecked(TT_PS["ui8"] == "1");
   WOWTR_CheckButton41:SetChecked(TT_PS["active"] == "1");
   WOWTR_CheckButton42:SetChecked(TT_PS["save"] == "1");
   WOWTR_CheckButton43:SetChecked(TT_PS["ui1"] == "1");
   WOWTR_CheckButton44:SetChecked(TT_PS["saveui"] == "1");
   WOWTR_CheckButton45:SetChecked(TT_PS["ui2"] == "1");
   WOWTR_CheckButton46:SetChecked(TT_PS["ui3"] == "1");
   WOWTR_CheckButton47:SetChecked(TT_PS["ui4"] == "1");
   WOWTR_CheckButton48:SetChecked(TT_PS["ui5"] == "1");
   WOWTR_CheckButton49:SetChecked(TT_PS["ui6"] == "1");
   WOWTR_CheckButton50:SetChecked(TT_PS["ui7"] == "1");

   WOWTR_CheckButton51:SetChecked(BT_PM["active"] == "1");
   WOWTR_CheckButton52:SetChecked(BT_PM["title"] == "1");
   WOWTR_CheckButton53:SetChecked(BT_PM["showID"] == "1");
   WOWTR_CheckButton55:SetChecked(BT_PM["saveNW"] == "1");
   WOWTR_CheckButton58:SetChecked(BT_PM["setsize"] == "1");

   WOWTR_CheckButton61:SetChecked(ST_PM["active"] == "1");
   WOWTR_CheckButton62:SetChecked(ST_PM["item"] == "1");
   WOWTR_CheckButton63:SetChecked(ST_PM["spell"] == "1");
   WOWTR_CheckButton64:SetChecked(ST_PM["talent"] == "1");
   WOWTR_CheckButton65:SetChecked(ST_PM["showID"] == "1");
   WOWTR_CheckButton66:SetChecked(ST_PM["showHS"] == "1");
   WOWTR_CheckButton67:SetChecked(ST_PM["sellprice"] == "1");
   WOWTR_CheckButton68:SetChecked(ST_PM["constantly"] == "1");
   WOWTR_CheckButton69:SetChecked(ST_PM["saveNW"] == "1");
   if (ST_TooltipsID) then
      WOWTR_CheckButton6A:SetChecked(ST_PM["transtitle"] == "1");
   end

   local fontsize1 = tonumber(BB_PM["fontsize"]) or 13;
   WOWTR_Opis1:SetFont(WOWTR_Font2, fontsize1);

   local fontsize2 = tonumber(BT_PM["fontsize"]) or 13;
   WOWTR_Opis2:SetFont(WOWTR_Font2, fontsize2);

   local fontsize4 = tonumber(QTR_PS["fontsize"]) or 13; -- gossip font size
   WOWTR_Opis4:SetFont(WOWTR_Font2, fontsize4);

   WOWTR_slider1:SetValue(tonumber(BB_PM["fontsize"]));
   WOWTR_slider2:SetValue(tonumber(BT_PM["fontsize"]));
   WOWTR_slider3:SetValue(tonumber(ST_PM["timer"]));
   WOWTR_slider4:SetValue(tonumber(QTR_PS["fontsize"]));
   WOWTR_slider5:SetValue(tonumber(BB_PM["timeDisplay"]));
end

---------------------------------------------------------------------------------------------------------------

function WOWTR_SetDungeonFrames(obj, tryb, horiz)
   if (tryb) then -- show
      obj:SetOwner(UIParent, "ANCHOR_NONE");
      obj:ClearAllPoints();
      obj:SetPoint("CENTER", horiz, obj.vertical);
      obj:ClearLines();
      obj:AddLine(QTR_ReverseIfAR(WoWTR_Localization.moveFrameUpDown), 1, 1, 1, true);
      if (BB_PM["setsize"] == "1") then                                                      -- jest włączona wielkość czcionki dymku
         _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, tonumber(BB_PM["fontsize"])); -- wielkość czcionki
      else
         _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, 13);                          -- ustaw turecką czcionkę oraz niezmienioną wielkość (13)
      end
      obj:Show();
      obj:SetMovable(true);
      obj:SetScript("OnMouseDown", function() WOWBB_OnMouseDown(obj); end);
      obj:SetScript("OnMouseUp", function() WOWBB_OnMouseUp(obj); end);
   else -- hide
      obj:SetMovable(false);
      obj:SetScript("OnMouseDown", nil);
      obj:SetScript("OnMouseUp", nil);
      obj:Hide();
      BB_PM["dungeonF1"] = WOWBB1.vertical;
      BB_PM["dungeonF2"] = WOWBB2.vertical;
      BB_PM["dungeonF3"] = WOWBB3.vertical;
      BB_PM["dungeonF4"] = WOWBB4.vertical;
      BB_PM["dungeonF5"] = WOWBB5.vertical;
   end
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_HideOptionsFrame()
   WOWTR_SetDungeonFrames(WOWBB1, false);
   WOWTR_SetDungeonFrames(WOWBB2, false);
   WOWTR_SetDungeonFrames(WOWBB3, false);
   WOWTR_SetDungeonFrames(WOWBB4, false);
   WOWTR_SetDungeonFrames(WOWBB5, false);
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_BlizzardOptions()
   -- Create main settings frame for information text and options of the addon
   local WOWTR_Options = CreateFrame("FRAME", "WOWTR_Options", SettingsPanel);
   WOWTR_Options:SetScript("OnHide", WOWTR_HideOptionsFrame);
   WOWTR_Options.name = WoWTR_Localization.optionName;
   WOWTR_Options.refresh = function(self) WOWTR_SetCheckButtonState() end;
   --InterfaceOptions_AddCategory(WOWTR_Options);
   local category = Settings.RegisterCanvasLayoutCategory(WOWTR_Options, WoWTR_Localization.optionName);
   Settings.RegisterAddOnCategory(category);
   WOWTR.CategoryID = category:GetID();
   WOWTR_Options:SetScript("OnShow", function(self) WOWTR_SetCheckButtonState() end);

   local WOWTR_OptionsHeader = WOWTR_Options:CreateFontString(nil, "ARTWORK");

   -- Adjust the size and position of the frame
   WOWTR_OptionsHeader:SetFontObject(GameFontNormalLarge);
   WOWTR_OptionsHeader:SetJustifyH("LEFT");
   WOWTR_OptionsHeader:SetJustifyV("TOP");
   WOWTR_OptionsHeader:ClearAllPoints();
   WOWTR_OptionsHeader:SetPoint("TOPLEFT", 8, -8);

   -- There is an addon icon inside the config frame
   local WOWTR_OptionsHeaderIcon = WOWTR_Options:CreateTexture(nil, "OVERLAY");
   WOWTR_OptionsHeaderIcon:SetPoint("TOPLEFT", 0, 0);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderIcon:SetWidth(48);
      WOWTR_OptionsHeaderIcon:SetHeight(48);
   else
      WOWTR_OptionsHeaderIcon:SetWidth(32);
      WOWTR_OptionsHeaderIcon:SetHeight(32);
   end
   WOWTR_OptionsHeaderIcon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon.png");

   -- Main text inside the option frame
   local WOWTR_OptionsHeaderText = WOWTR_Options:CreateFontString(nil, "OVERLAY", "GameFontNormal");
   WOWTR_OptionsHeaderText:SetFont(WOWTR_Font2, 18);
   WOWTR_OptionsHeaderText:SetWidth(600);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_OptionsHeaderText:SetPoint("LEFT", WOWTR_OptionsHeaderIcon, "RIGHT", 50, 10);
      WOWTR_OptionsHeaderText:SetText(AS_UTF8reverse(WoWTR_Localization.optionTitleAR));
   else
      WOWTR_OptionsHeaderText:SetPoint("LEFT", WOWTR_OptionsHeaderIcon, "RIGHT", 0, 0);
      WOWTR_OptionsHeaderText:SetText(" " ..
         WoWTR_Localization.optionTitle .. " |cff8080ffv" .. WOWTR_version ..
         "|r                          by Platine © 2024");
   end

   local WOWTR_CheckButton00 = CreateFrame("CheckButton", "WOWTR_CheckButton00", WOWTR_Options, "UICheckButtonTemplate");
   WOWTR_CheckButton00:SetScript("OnClick",
      function(self)
         if (QTR_PS["icon"] == "1") then
            QTR_PS["icon"] = "0"; WOWTR.db.profile.minimap.hide = true; LibDBIcon10_WOWTR_LDB:Hide();
         else
            QTR_PS["icon"] = "1"; WOWTR.db.profile.minimap.hide = false; LibDBIcon10_WOWTR_LDB:Show();
         end;
      end);
   if (WoWTR_Localization.lang == 'AR') then
      WOWTR_CheckButton00:SetPoint("TOPLEFT", WOWTR_OptionsHeaderText, "TOPLEFT", 525, -20);
      WOWTR_CheckButton00.Text:SetText("|cffffffff" .. AS_UTF8reverse(WoWTR_Config_Interface.showMinimapIcon) .. "|r"); -- Show then addon setting icon next to the minimap
      WOWTR_CheckButton00.Text:SetPoint("TOPLEFT", WOWTR_OptionsHeaderText, "TOPLEFT", 265, -30);
      --   WOWTR_CheckButton00:SetWidth(260);
   else
      WOWTR_CheckButton00:SetPoint("TOPLEFT", WOWTR_OptionsHeaderText, "TOPLEFT", 20, -20);
      WOWTR_CheckButton00.Text:SetText("|cffffffff" .. WoWTR_Config_Interface.showMinimapIcon .. "|r"); -- Show then addon setting icon next to the minimap
      --   WOWTR_CheckButton00:SetWidth(340);
   end
   WOWTR_CheckButton00.Text:SetFont(WOWTR_Font2, 13);
   WOWTR_CheckButton00:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT");
      GameTooltip:ClearLines();
      GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.showMinimapIcon) .. NONBREAKINGSPACE, false); -- red color, no wrap
      getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
      GameTooltip:AddLine(
         QTR_ExpandUnitInfo(WoWTR_Config_Interface.showMinimapIconDESC, false, getglobal("GameTooltipTextLeft1"),
            WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true); -- white color, wrap
      getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
      GameTooltip:Show()                                      -- Show the tooltip
   end);
   WOWTR_CheckButton00:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end);


   local WOWTR_Tab1TitleA = CreateFrame("BUTTON", "WOWTR_Tab1TitleA", WOWTR_Options, "GameMenuButtonTemplate");
   WOWTR_Tab1TitleA:SetWidth(100);
   WOWTR_Tab1TitleA:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab1TitleA:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab1));
      WOWTR_Tab1TitleA:SetFontString(fo);
   end
   WOWTR_Tab1TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab1));
   WOWTR_Tab1TitleA:ClearAllPoints();
   WOWTR_Tab1TitleA:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -10, -60);
   WOWTR_Tab1TitleA:Show();

   local WOWTR_Tab1TitleB = CreateFrame("BUTTON", "WOWTR_Tab1TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate");
   WOWTR_Tab1TitleB:SetWidth(100);
   WOWTR_Tab1TitleB:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab1TitleB:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab1));
      WOWTR_Tab1TitleB:SetFontString(fo);
   end
   WOWTR_Tab1TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab1));
   WOWTR_Tab1TitleB:ClearAllPoints();
   WOWTR_Tab1TitleB:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -10, -60);
   WOWTR_Tab1TitleB:Hide();
   WOWTR_Tab1TitleB:SetScript("OnClick", WOWTR_ChangePanel1);

   local WOWTR_Tab2TitleA = CreateFrame("BUTTON", "WOWTR_Tab2TitleA", WOWTR_Options, "GameMenuButtonTemplate");
   WOWTR_Tab2TitleA:SetWidth(100);
   WOWTR_Tab2TitleA:SetHeight(20);
   if (WoWTR_Localization.lang == 'AR') then
      local fo = WOWTR_Tab2TitleA:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab2));
      WOWTR_Tab2TitleA:SetFontString(fo);
   end
   WOWTR_Tab2TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab2));
   WOWTR_Tab2TitleA:ClearAllPoints();
   WOWTR_Tab2TitleA:SetPoint("TOPLEFT", WOWTR_Tab1TitleA, "TOPRIGHT", -4, 0);
   WOWTR_Tab2TitleA:Hide();

   local WOWTR_Tab2TitleB = CreateFrame("BUTTON", "WOWTR_Tab2TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate");
   WOWTR_Tab2TitleB:SetWidth(100);
   WOWTR_Tab2TitleB:SetHeight(20);
   if (WoWTR_Localization.lang == 'AR') then
      local fo = WOWTR_Tab2TitleB:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab2));
      WOWTR_Tab2TitleB:SetFontString(fo);
   end
   WOWTR_Tab2TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab2));
   WOWTR_Tab2TitleB:ClearAllPoints();
   WOWTR_Tab2TitleB:SetPoint("TOPLEFT", WOWTR_Tab1TitleB, "TOPRIGHT", -4, 0);
   WOWTR_Tab2TitleB:Show();
   WOWTR_Tab2TitleB:SetScript("OnClick", WOWTR_ChangePanel2);

   local WOWTR_Tab3TitleA = CreateFrame("BUTTON", "WOWTR_Tab3TitleA", WOWTR_Options, "GameMenuButtonTemplate");
   WOWTR_Tab3TitleA:SetWidth(100);
   WOWTR_Tab3TitleA:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab3TitleA:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab3));
      WOWTR_Tab3TitleA:SetFontString(fo);
   end
   WOWTR_Tab3TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab3));
   WOWTR_Tab3TitleA:ClearAllPoints();
   WOWTR_Tab3TitleA:SetPoint("TOPLEFT", WOWTR_Tab2TitleA, "TOPRIGHT", -4, 0);
   WOWTR_Tab3TitleA:Hide();

   local WOWTR_Tab3TitleB = CreateFrame("BUTTON", "WOWTR_Tab3TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate");
   WOWTR_Tab3TitleB:SetWidth(100);
   WOWTR_Tab3TitleB:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab3TitleB:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab3));
      WOWTR_Tab3TitleB:SetFontString(fo);
   end
   WOWTR_Tab3TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab3));
   WOWTR_Tab3TitleB:ClearAllPoints();
   WOWTR_Tab3TitleB:SetPoint("TOPLEFT", WOWTR_Tab2TitleB, "TOPRIGHT", -4, 0);
   WOWTR_Tab3TitleB:Show();
   WOWTR_Tab3TitleB:SetScript("OnClick", WOWTR_ChangePanel3);

   local WOWTR_Tab4TitleA = CreateFrame("BUTTON", "WOWTR_Tab4TitleA", WOWTR_Options, "GameMenuButtonTemplate");
   WOWTR_Tab4TitleA:SetWidth(100);
   WOWTR_Tab4TitleA:SetHeight(20);
   if (WoWTR_Localization.lang == 'AR') then
      local fo = WOWTR_Tab4TitleA:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab4));
      WOWTR_Tab4TitleA:SetFontString(fo);
   end
   WOWTR_Tab4TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab4));
   WOWTR_Tab4TitleA:ClearAllPoints();
   WOWTR_Tab4TitleA:SetPoint("TOPLEFT", WOWTR_Tab3TitleA, "TOPRIGHT", -4, 0);
   WOWTR_Tab4TitleA:Hide();

   local WOWTR_Tab4TitleB = CreateFrame("BUTTON", "WOWTR_Tab4TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate");
   WOWTR_Tab4TitleB:SetWidth(100);
   WOWTR_Tab4TitleB:SetHeight(20);
   if (WoWTR_Localization.lang == 'AR') then
      local fo = WOWTR_Tab4TitleB:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab4));
      WOWTR_Tab4TitleB:SetFontString(fo);
   end
   WOWTR_Tab4TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab4));
   WOWTR_Tab4TitleB:ClearAllPoints();
   WOWTR_Tab4TitleB:SetPoint("TOPLEFT", WOWTR_Tab3TitleB, "TOPRIGHT", -4, 0);
   WOWTR_Tab4TitleB:Show();
   WOWTR_Tab4TitleB:SetScript("OnClick", WOWTR_ChangePanel4);

   local WOWTR_Tab5TitleA = CreateFrame("BUTTON", "WOWTR_Tab5TitleA", WOWTR_Options, "GameMenuButtonTemplate");
   WOWTR_Tab5TitleA:SetWidth(100);
   WOWTR_Tab5TitleA:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP') or (WoWTR_Localization.lang == 'PL')) then
      local fo = WOWTR_Tab5TitleA:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab5));
      WOWTR_Tab5TitleA:SetFontString(fo);
   end
   WOWTR_Tab5TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab5));
   WOWTR_Tab5TitleA:ClearAllPoints();
   WOWTR_Tab5TitleA:SetPoint("TOPLEFT", WOWTR_Tab4TitleA, "TOPRIGHT", -4, 0);
   WOWTR_Tab5TitleA:Hide();

   local WOWTR_Tab5TitleB = CreateFrame("BUTTON", "WOWTR_Tab5TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate");
   WOWTR_Tab5TitleB:SetWidth(100);
   WOWTR_Tab5TitleB:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP') or (WoWTR_Localization.lang == 'PL')) then
      local fo = WOWTR_Tab5TitleB:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab5));
      WOWTR_Tab5TitleB:SetFontString(fo);
   end
   WOWTR_Tab5TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab5));
   WOWTR_Tab5TitleB:ClearAllPoints();
   WOWTR_Tab5TitleB:SetPoint("TOPLEFT", WOWTR_Tab4TitleB, "TOPRIGHT", -4, 0);
   WOWTR_Tab5TitleB:Show();
   WOWTR_Tab5TitleB:SetScript("OnClick", WOWTR_ChangePanel5);

   local WOWTR_Tab6TitleA = CreateFrame("BUTTON", "WOWTR_Tab6TitleA", WOWTR_Options, "GameMenuButtonTemplate");
   WOWTR_Tab6TitleA:SetWidth(100);
   WOWTR_Tab6TitleA:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab6TitleA:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab6));
      WOWTR_Tab6TitleA:SetFontString(fo);
   end
   WOWTR_Tab6TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab6));
   WOWTR_Tab6TitleA:ClearAllPoints();
   WOWTR_Tab6TitleA:SetPoint("TOPLEFT", WOWTR_Tab5TitleA, "TOPRIGHT", -4, 0);
   WOWTR_Tab6TitleA:Hide();

   local WOWTR_Tab6TitleB = CreateFrame("BUTTON", "WOWTR_Tab6TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate");
   WOWTR_Tab6TitleB:SetWidth(100);
   WOWTR_Tab6TitleB:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab6TitleB:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab6));
      WOWTR_Tab6TitleB:SetFontString(fo);
   end
   WOWTR_Tab6TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab6));
   WOWTR_Tab6TitleB:ClearAllPoints();
   WOWTR_Tab6TitleB:SetPoint("TOPLEFT", WOWTR_Tab5TitleB, "TOPRIGHT", -4, 0);
   WOWTR_Tab6TitleB:Show();
   WOWTR_Tab6TitleB:SetScript("OnClick", WOWTR_ChangePanel6);

   local WOWTR_Tab9TitleA = CreateFrame("BUTTON", "WOWTR_Tab9TitleA", WOWTR_Options, "GameMenuButtonTemplate");
   WOWTR_Tab9TitleA:SetWidth(100);
   WOWTR_Tab9TitleA:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab9TitleA:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab9));
      WOWTR_Tab9TitleA:SetFontString(fo);
   end
   WOWTR_Tab9TitleA:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab9));
   WOWTR_Tab9TitleA:ClearAllPoints();
   WOWTR_Tab9TitleA:SetPoint("TOPLEFT", WOWTR_Tab6TitleA, "TOPRIGHT", -4, 0);
   WOWTR_Tab9TitleA:Hide();

   local WOWTR_Tab9TitleB = CreateFrame("BUTTON", "WOWTR_Tab9TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate");
   WOWTR_Tab9TitleB:SetWidth(100);
   WOWTR_Tab9TitleB:SetHeight(20);
   if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP')) then
      local fo = WOWTR_Tab9TitleB:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab9));
      WOWTR_Tab9TitleB:SetFontString(fo);
   end
   WOWTR_Tab9TitleB:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.titleTab9));
   WOWTR_Tab9TitleB:ClearAllPoints();
   WOWTR_Tab9TitleB:SetPoint("TOPLEFT", WOWTR_Tab6TitleB, "TOPRIGHT", -4, 0);
   WOWTR_Tab9TitleB:Show();
   WOWTR_Tab9TitleB:SetScript("OnClick", WOWTR_ChangePanel9);

   ----- PANELS

   local WOWTR_OptionPanel1 = CreateFrame("FRAME", "WOWTR_OptionPanel1", WOWTR_Options, "BackdropTemplate");
   WOWTR_OptionPanel1:SetMovable(false);
   WOWTR_OptionPanel1:SetWidth(682);
   WOWTR_OptionPanel1:SetHeight(530);
   WOWTR_OptionPanel1:ClearAllPoints();
   WOWTR_OptionPanel1:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73);
   WOWTR_OptionPanel1:Show();

   local WOWTR_OptionPanel2 = CreateFrame("FRAME", "WOWTR_OptionPanel2", WOWTR_Options, "BackdropTemplate");
   WOWTR_OptionPanel2:SetMovable(false);
   WOWTR_OptionPanel2:SetWidth(682);
   WOWTR_OptionPanel2:SetHeight(530);
   WOWTR_OptionPanel2:ClearAllPoints();
   WOWTR_OptionPanel2:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73);
   WOWTR_OptionPanel2:Hide();

   local WOWTR_OptionPanel3 = CreateFrame("FRAME", "WOWTR_OptionPanel3", WOWTR_Options, "BackdropTemplate");
   WOWTR_OptionPanel3:SetMovable(false);
   WOWTR_OptionPanel3:SetWidth(682);
   WOWTR_OptionPanel3:SetHeight(530);
   WOWTR_OptionPanel3:ClearAllPoints();
   WOWTR_OptionPanel3:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73);
   WOWTR_OptionPanel3:Hide();

   local WOWTR_OptionPanel4 = CreateFrame("FRAME", "WOWTR_OptionPanel4", WOWTR_Options, "BackdropTemplate");
   WOWTR_OptionPanel4:SetMovable(false);
   WOWTR_OptionPanel4:SetWidth(682);
   WOWTR_OptionPanel4:SetHeight(530);
   WOWTR_OptionPanel4:ClearAllPoints();
   WOWTR_OptionPanel4:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73);
   WOWTR_OptionPanel4:Hide();

   local WOWTR_OptionPanel5 = CreateFrame("FRAME", "WOWTR_OptionPanel5", WOWTR_Options, "BackdropTemplate");
   WOWTR_OptionPanel5:SetMovable(false);
   WOWTR_OptionPanel5:SetWidth(682);
   WOWTR_OptionPanel5:SetHeight(530);
   WOWTR_OptionPanel5:ClearAllPoints();
   WOWTR_OptionPanel5:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73);
   WOWTR_OptionPanel5:Hide();

   local WOWTR_OptionPanel6 = CreateFrame("FRAME", "WOWTR_OptionPanel6", WOWTR_Options, "BackdropTemplate");
   WOWTR_OptionPanel6:SetMovable(false);
   WOWTR_OptionPanel6:SetWidth(682);
   WOWTR_OptionPanel6:SetHeight(530);
   WOWTR_OptionPanel6:ClearAllPoints();
   WOWTR_OptionPanel6:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73);
   WOWTR_OptionPanel6:Hide();

   local WOWTR_OptionPanel9 = CreateFrame("FRAME", "WOWTR_OptionPanel9", WOWTR_Options, "BackdropTemplate");
   WOWTR_OptionPanel9:SetMovable(false);
   WOWTR_OptionPanel9:SetWidth(682);
   WOWTR_OptionPanel9:SetHeight(530);
   WOWTR_OptionPanel9:ClearAllPoints();
   WOWTR_OptionPanel9:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73);
   WOWTR_OptionPanel9:Hide();

   WOWTR_CreateOptionPanel1(WOWTR_OptionPanel1);
   WOWTR_CreateOptionPanel2(WOWTR_OptionPanel2);
   WOWTR_CreateOptionPanel3(WOWTR_OptionPanel3);
   WOWTR_CreateOptionPanel4(WOWTR_OptionPanel4);
   WOWTR_CreateOptionPanel5(WOWTR_OptionPanel5);
   WOWTR_CreateOptionPanel6(WOWTR_OptionPanel6);
   WOWTR_CreateOptionPanel9(WOWTR_OptionPanel9);
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_ResetVariables(nr)
   if (nr == 1) then -- wyczyść zapisane dane
      QTR_SAVED = nil;
      QTR_MISSING = nil;
      QTR_GOSSIP = nil;
      BB_PS = nil;
      BB_TR = nil;
      MF_PS = nil;
      TT_TUTORIALS = nil;
      BT_SAVED = nil;
      ST_PS = nil;
      ST_PH = nil;
      if (WOWTR_ResetButton1) then
         WOWTR_ResetButton1:SetText(WoWTR_Localization.resultButton1); -- Wyczyszczono zapisane teksty
         WOWTR_Confirmation1:Hide();
      end
   else
      QTR_PS = nil;
      BB_PM = nil;
      MF_PM = nil;
      TT_PS = nil;
      BT_PM = nil;
      ST_PM = nil;
      WOWTR_Confirmation2:Hide();
   end
   WOWTR_CheckVars();
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_ReloadUI()
   ReloadUI()
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_ChangePanel1()
   WOWTR_Tab1TitleB:Hide();
   WOWTR_Tab2TitleA:Hide();
   WOWTR_Tab3TitleA:Hide();
   WOWTR_Tab4TitleA:Hide();
   WOWTR_Tab5TitleA:Hide();
   WOWTR_Tab6TitleA:Hide();
   WOWTR_Tab9TitleA:Hide();
   WOWTR_Tab1TitleA:Show();
   WOWTR_Tab2TitleB:Show();
   WOWTR_Tab3TitleB:Show();
   WOWTR_Tab4TitleB:Show();
   WOWTR_Tab5TitleB:Show();
   WOWTR_Tab6TitleB:Show();
   WOWTR_Tab9TitleB:Show();
   WOWTR_OptionPanel1:Show();
   WOWTR_OptionPanel2:Hide();
   WOWTR_OptionPanel3:Hide();
   WOWTR_OptionPanel4:Hide();
   WOWTR_OptionPanel5:Hide();
   WOWTR_OptionPanel6:Hide();
   WOWTR_OptionPanel9:Hide();
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_ChangePanel2()
   WOWTR_Tab1TitleA:Hide();
   WOWTR_Tab2TitleB:Hide();
   WOWTR_Tab3TitleA:Hide();
   WOWTR_Tab4TitleA:Hide();
   WOWTR_Tab5TitleA:Hide();
   WOWTR_Tab6TitleA:Hide();
   WOWTR_Tab9TitleA:Hide();
   WOWTR_Tab1TitleB:Show();
   WOWTR_Tab2TitleA:Show();
   WOWTR_Tab3TitleB:Show();
   WOWTR_Tab4TitleB:Show();
   WOWTR_Tab5TitleB:Show();
   WOWTR_Tab6TitleB:Show();
   WOWTR_Tab9TitleB:Show();
   WOWTR_OptionPanel1:Hide();
   WOWTR_OptionPanel2:Show();
   WOWTR_OptionPanel3:Hide();
   WOWTR_OptionPanel4:Hide();
   WOWTR_OptionPanel5:Hide();
   WOWTR_OptionPanel6:Hide();
   WOWTR_OptionPanel9:Hide();
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_ChangePanel3()
   WOWTR_Tab1TitleA:Hide();
   WOWTR_Tab2TitleA:Hide();
   WOWTR_Tab3TitleB:Hide();
   WOWTR_Tab4TitleA:Hide();
   WOWTR_Tab5TitleA:Hide();
   WOWTR_Tab6TitleA:Hide();
   WOWTR_Tab9TitleA:Hide();
   WOWTR_Tab1TitleB:Show();
   WOWTR_Tab2TitleB:Show();
   WOWTR_Tab3TitleA:Show();
   WOWTR_Tab4TitleB:Show();
   WOWTR_Tab5TitleB:Show();
   WOWTR_Tab6TitleB:Show();
   WOWTR_Tab9TitleB:Show();
   WOWTR_OptionPanel1:Hide();
   WOWTR_OptionPanel2:Hide();
   WOWTR_OptionPanel3:Show();
   WOWTR_OptionPanel4:Hide();
   WOWTR_OptionPanel5:Hide();
   WOWTR_OptionPanel6:Hide();
   WOWTR_OptionPanel9:Hide();
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_ChangePanel4()
   WOWTR_Tab1TitleA:Hide();
   WOWTR_Tab2TitleA:Hide();
   WOWTR_Tab3TitleA:Hide();
   WOWTR_Tab4TitleB:Hide();
   WOWTR_Tab5TitleA:Hide();
   WOWTR_Tab6TitleA:Hide();
   WOWTR_Tab9TitleA:Hide();
   WOWTR_Tab1TitleB:Show();
   WOWTR_Tab2TitleB:Show();
   WOWTR_Tab3TitleB:Show();
   WOWTR_Tab4TitleA:Show();
   WOWTR_Tab5TitleB:Show();
   WOWTR_Tab6TitleB:Show();
   WOWTR_Tab9TitleB:Show();
   WOWTR_OptionPanel1:Hide();
   WOWTR_OptionPanel2:Hide();
   WOWTR_OptionPanel3:Hide();
   WOWTR_OptionPanel4:Show();
   WOWTR_OptionPanel5:Hide();
   WOWTR_OptionPanel6:Hide();
   WOWTR_OptionPanel9:Hide();
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_ChangePanel5()
   WOWTR_Tab1TitleA:Hide();
   WOWTR_Tab2TitleA:Hide();
   WOWTR_Tab3TitleA:Hide();
   WOWTR_Tab4TitleA:Hide();
   WOWTR_Tab5TitleB:Hide();
   WOWTR_Tab6TitleA:Hide();
   WOWTR_Tab9TitleA:Hide();
   WOWTR_Tab1TitleB:Show();
   WOWTR_Tab2TitleB:Show();
   WOWTR_Tab3TitleB:Show();
   WOWTR_Tab4TitleB:Show();
   WOWTR_Tab5TitleA:Show();
   WOWTR_Tab6TitleB:Show();
   WOWTR_Tab9TitleB:Show();
   WOWTR_OptionPanel1:Hide();
   WOWTR_OptionPanel2:Hide();
   WOWTR_OptionPanel3:Hide();
   WOWTR_OptionPanel4:Hide();
   WOWTR_OptionPanel5:Show();
   WOWTR_OptionPanel6:Hide();
   WOWTR_OptionPanel9:Hide();
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_ChangePanel6()
   WOWTR_Tab1TitleA:Hide();
   WOWTR_Tab2TitleA:Hide();
   WOWTR_Tab3TitleA:Hide();
   WOWTR_Tab4TitleA:Hide();
   WOWTR_Tab5TitleA:Hide();
   WOWTR_Tab6TitleB:Hide();
   WOWTR_Tab9TitleA:Hide();
   WOWTR_Tab1TitleB:Show();
   WOWTR_Tab2TitleB:Show();
   WOWTR_Tab3TitleB:Show();
   WOWTR_Tab4TitleB:Show();
   WOWTR_Tab5TitleB:Show();
   WOWTR_Tab6TitleA:Show();
   WOWTR_Tab9TitleB:Show();
   WOWTR_OptionPanel1:Hide();
   WOWTR_OptionPanel2:Hide();
   WOWTR_OptionPanel3:Hide();
   WOWTR_OptionPanel4:Hide();
   WOWTR_OptionPanel5:Hide();
   WOWTR_OptionPanel6:Show();
   WOWTR_OptionPanel9:Hide();
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_ChangePanel9()
   WOWTR_Tab1TitleA:Hide();
   WOWTR_Tab2TitleA:Hide();
   WOWTR_Tab3TitleA:Hide();
   WOWTR_Tab4TitleA:Hide();
   WOWTR_Tab5TitleA:Hide();
   WOWTR_Tab6TitleA:Hide();
   WOWTR_Tab9TitleB:Hide();
   WOWTR_Tab1TitleB:Show();
   WOWTR_Tab2TitleB:Show();
   WOWTR_Tab3TitleB:Show();
   WOWTR_Tab4TitleB:Show();
   WOWTR_Tab5TitleB:Show();
   WOWTR_Tab6TitleB:Show();
   WOWTR_Tab9TitleA:Show();
   WOWTR_OptionPanel1:Hide();
   WOWTR_OptionPanel2:Hide();
   WOWTR_OptionPanel3:Hide();
   WOWTR_OptionPanel4:Hide();
   WOWTR_OptionPanel5:Hide();
   WOWTR_OptionPanel6:Hide();
   WOWTR_OptionPanel9:Show();
end

-----------------------------------------------------------------------------------------------------------------

function Config_OnEnable()
   -- Create main frame for setting options
   WOWTR_BlizzardOptions();
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_SlashCommand(msg)
   if not msg or msg:trim() == "" then
      InterfaceOptionsFrame_OpenToCategory(WOWTR.CategoryID); -- open Settings of the addon
   end
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_WelcomePanel()
   if (not WOWTR.WelcomePanel) then
      QTR_PS["welcome"] = "1";
      WOWTR.WelcomePanel = CreateFrame("Frame", nil, UIParent, "UIPanelDialogTemplate");
      WOWTR.WelcomePanel:SetWidth(800);
      WOWTR.WelcomePanel:SetHeight(400);
      WOWTR.WelcomePanel:ClearAllPoints();
      WOWTR.WelcomePanel:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
      WOWTR.WelcomePanel:SetFrameStrata("TOOLTIP");
      WOWTR.WelcomePanel.Title:SetText(QTR_ReverseIfAR(WoWTR_Localization.optionTitle));
      WOWTR.WelcomePanel.Title:SetFont(WOWTR_Font2, 15);
      if (WoWTR_Localization.welcomeIconPos > 0) then
         WOWTR.Icon = WOWTR.WelcomePanel:CreateTexture(nil, "OVERLAY");
         WOWTR.Icon:ClearAllPoints();
         WOWTR.Icon:SetPoint("BOTTOMRIGHT", WOWTR.WelcomePanel, -10, 10, -WoWTR_Localization.welcomeIconPos);
         WOWTR.Icon:SetWidth(32);
         WOWTR.Icon:SetHeight(32);
         WOWTR.Icon:SetTexture(WoWTR_Localization.mainFolder .. "\\Images\\icon.png");
      end
      WOWTR.WelcomePanel.Text = WOWTR.WelcomePanel:CreateFontString(nil, "ARTWORK");
      WOWTR.WelcomePanel.Text:SetFontObject(GameFontWhite);
      WOWTR.WelcomePanel.Text:SetJustifyH("LEFT");
      WOWTR.WelcomePanel.Text:SetJustifyV("TOP");
      WOWTR.WelcomePanel.Text:ClearAllPoints();
      WOWTR.WelcomePanel.Text:SetPoint("TOPLEFT", WOWTR.WelcomePanel, "TOPLEFT", 20, -40);
      WOWTR.WelcomePanel.Text:SetWidth(770);
      WOWTR.WelcomePanel.Text:SetText(QTR_ExpandUnitInfo(WoWTR_Config_Interface.welcomeText, false,
         WOWTR.WelcomePanel.Text, WOWTR_Font2, -140, "RIGHT")); -- welcome text when the addon is launched for the first time
      WOWTR.WelcomePanel.Text:SetFont(WOWTR_Font2, 14);
      WOWTR.WelcomePanel.Button = CreateFrame("Button", nil, WOWTR.WelcomePanel, "UIPanelButtonTemplate");
      WOWTR.WelcomePanel.Button:SetWidth(160);
      WOWTR.WelcomePanel.Button:SetHeight(20);
      local fo = WOWTR.WelcomePanel.Button:CreateFontString();
      fo:SetFont(WOWTR_Font2, 13);
      fo:SetText(QTR_ReverseIfAR(QTR_ReverseIfAR(WoWTR_Config_Interface.welcomeButton)));
      WOWTR.WelcomePanel.Button:SetFontString(fo);
      WOWTR.WelcomePanel.Button:SetText(QTR_ReverseIfAR(WoWTR_Config_Interface.welcomeButton));
      WOWTR.WelcomePanel.Button:ClearAllPoints();
      WOWTR.WelcomePanel.Button:SetPoint("BOTTOMLEFT", WOWTR.WelcomePanel, "BOTTOMLEFT",
         WOWTR.WelcomePanel:GetWidth() / 2 - WOWTR.WelcomePanel.Button:GetWidth() / 2, 10);
      WOWTR.WelcomePanel.Button:Show();
      WOWTR.WelcomePanel.Button:SetScript("OnClick", function() WOWTR.WelcomePanel:Hide(); end);
   end
   WOWTR.WelcomePanel:Show();
end

---------------------------------------------------------------------------------------------------------------

if ((GetLocale() == "enUS") or (GetLocale() == "enGB")) then
   -- Create minimap button with Ace-3.0 library
   -- Required Libraries: LibStub, AceAddon-3.0, AceConsole-3.0, AceDB-3.0, CallbackHandler-1.0, LibDataBroker-1.1, LibDBIcon-1.0

   -- We report to Ace the name of our addon
   local addon = LibStub("AceAddon-3.0"):NewAddon(WoWTR_Localization.addonName, "AceConsole-3.0")
   -- Let's fetch the icon reference
   WOWTR_icon = LibStub("LibDBIcon-1.0");
   -- We create an LDB object
   WOWTR_minimapButton = LibStub("LibDataBroker-1.1"):NewDataObject("WOWTR_LDB", {
      type = "data source",
      text = "WOWTR_LDB",
      icon = WoWTR_Localization.mainFolder .. "\\Images\\icon.png", -- icon file

      -- We open the addon settings window by clicking on the icon
      OnClick = function()
         Settings.OpenToCategory(WOWTR.CategoryID); -- open Settings of the addon
      end,

      -- Here we add a description of the addon to the tooltip object
      OnTooltipShow = function(tooltip)
         if (WoWTR_Localization.lang == 'AR') then
            tooltip:SetText("|cff8080ff" .. WOWTR_version .. "|r " .. QTR_ReverseIfAR(WoWTR_Localization.optionTitle));
         else
            tooltip:SetText(QTR_ReverseIfAR(WoWTR_Localization.optionTitle) .. " |cff8080ff" .. WOWTR_version .. "|r");
         end
         tooltip:AddLine("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Localization.addonIconDesc) .. "|r");
         _G[tooltip:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, 15);
         _G[tooltip:GetName() .. "TextLeft2"]:SetFont(WOWTR_Font2, 13);
         tooltip:Show();
      end,
   });


   -- Let's save the icon when our addon is loaded for the first time
   function addon:OnInitialize()
      -- Don't forget to add the SavedVariables line to your TOC file! (WoWTR_minimapDB)
      WOWTR.db = LibStub("AceDB-3.0"):New("WoWTR_minimapDB", {
         profile = {
            minimap = {
               hide = false,
               minimapPos = 238,
            },
         },
      });
      WOWTR_icon:Register("WOWTR_LDB", WOWTR_minimapButton, WOWTR.db.profile.minimap);
   end
end
