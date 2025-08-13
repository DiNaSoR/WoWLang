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

-------------------------------------------------------------------------------------------------------
-- Generic UI Helpers (Could potentially be moved to a shared UI utilities file later)
-------------------------------------------------------------------------------------------------------

function CreateToggleButton(parentFrame, settingsTable, settingKey, onText, offText, point, onClick)
   --print("CreateToggleButton: Creating toggle button for setting " .. settingKey)
   local buttonOFF = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
   local buttonON = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")

   local function SetupButton(button, text)
      --print("SetupButton: Setting up button with text: " .. tostring(text))
      button:SetSize(120, 22)
      if WoWTR_Localization.lang == 'AR' and text == WoWTR_Localization.WoWTR_trDESC then
         --print("SetupButton: Arabic text detected, reversing text")
         button:SetText(QTR_ReverseIfAR(text))
         button:GetFontString():SetFont(WOWTR_Font2, 13)
         --print("SetupButton: Set Arabic font WOWTR_Font2 with size 13")
      else
         button:SetText(text)
         local font, size = button:GetFontString():GetFont()
         --print("SetupButton: Original font: " .. tostring(font) .. ", size: " .. tostring(size))
         button:GetFontString():SetFont(font, 13)
         --print("SetupButton: Set font size to 13")
      end
      button:SetPoint(unpack(point))
      --print("SetupButton: Set button position to " .. tostring(point[1]) .. ", " .. tostring(point[2]))
      button:SetFrameStrata("TOOLTIP")
      --print("SetupButton: Set frame strata to TOOLTIP")
   end

   --print("CreateToggleButton: Setting up OFF button with text: " .. tostring(offText))
   SetupButton(buttonOFF, offText)
   --print("CreateToggleButton: Setting up ON button with text: " .. tostring(onText))
   SetupButton(buttonON, onText)

   local function UpdateVisibility()
      --print("UpdateVisibility: Current value of " .. settingKey .. " is " .. tostring(settingsTable[settingKey]))
      if settingsTable[settingKey] == "1" then
         --print("UpdateVisibility: Showing OFF button, hiding ON button")
         buttonOFF:Show(); buttonON:Hide()
      else
         --print("UpdateVisibility: Hiding OFF button, showing ON button")
         buttonOFF:Hide(); buttonON:Show()
      end
   end

   buttonOFF:SetScript("OnClick", function()
      --print("Button OFF clicked: Setting " .. settingKey .. " to 0")
      settingsTable[settingKey] = "0"
      UpdateVisibility()
      if onClick then
         --print("Executing onClick callback")
         onClick()
      end
   end)

   buttonON:SetScript("OnClick", function()
      --print("Button ON clicked: Setting " .. settingKey .. " to 1")
      settingsTable[settingKey] = "1"
      UpdateVisibility()
      if onClick then
         --print("Executing onClick callback")
         onClick()
      end
   end)

   --print("CreateToggleButton: Initial visibility update")
   UpdateVisibility()
   --print("CreateToggleButton: Returning UpdateVisibility function")
   return UpdateVisibility
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
