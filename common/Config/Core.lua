function WOWTR_BlizzardOptions()
  -- Create main settings frame
  local WOWTR_Options = CreateFrame("FRAME", "WOWTR_Options", SettingsPanel);
  WOWTR_Options:SetScript("OnHide", WOWTR_HideOptionsFrame);
  WOWTR_Options.name = WoWTR_Localization.optionName;
  WOWTR_Options.refresh = function(self) WOWTR_UpdateAllTabs() end;
  local category = Settings.RegisterCanvasLayoutCategory(WOWTR_Options, WoWTR_Localization.optionName);
  Settings.RegisterAddOnCategory(category);
  WOWTR.CategoryID = category:GetID();
  WOWTR_Options:SetScript("OnShow", function(self) WOWTR_UpdateAllTabs() end);

  -- Header
  local WOWTR_OptionsHeader = WOWTR_Options:CreateFontString(nil, "ARTWORK");
  WOWTR_OptionsHeader:SetFontObject(GameFontNormalLarge);
  WOWTR_OptionsHeader:SetJustifyH("LEFT");
  WOWTR_OptionsHeader:SetJustifyV("TOP");
  WOWTR_OptionsHeader:ClearAllPoints();
  WOWTR_OptionsHeader:SetPoint("TOPLEFT", 8, -8);

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
    WOWTR_CheckButton00.Text:SetText("|cffffffff" .. AS_UTF8reverse(WoWTR_Config_Interface.showMinimapIcon) .. "|r");
    WOWTR_CheckButton00.Text:SetPoint("TOPLEFT", WOWTR_OptionsHeaderText, "TOPLEFT", 265, -30);
  else
    WOWTR_CheckButton00:SetPoint("TOPLEFT", WOWTR_OptionsHeaderText, "TOPLEFT", 20, -20);
    WOWTR_CheckButton00.Text:SetText("|cffffffff" .. WoWTR_Config_Interface.showMinimapIcon .. "|r");
  end
  WOWTR_CheckButton00.Text:SetFont(WOWTR_Font2, 13);
  WOWTR_CheckButton00:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT");
    GameTooltip:ClearLines();
    GameTooltip:AddLine(QTR_ReverseIfAR(WoWTR_Config_Interface.showMinimapIcon) .. NONBREAKINGSPACE, false);
    getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13);
    GameTooltip:AddLine(
      QTR_ExpandUnitInfo(WoWTR_Config_Interface.showMinimapIconDESC, false, getglobal("GameTooltipTextLeft1"),
        WOWTR_Font2) .. NONBREAKINGSPACE, 1, 1, 1, true);
    getglobal("GameTooltipTextLeft2"):SetFont(WOWTR_Font2, 13);
    GameTooltip:Show()
  end);
  WOWTR_CheckButton00:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end);

  -- Tabs
  local tabInfo = {
    { id = 1, title = WoWTR_Config_Interface.titleTab1 },
    { id = 2, title = WoWTR_Config_Interface.titleTab2 },
    { id = 3, title = WoWTR_Config_Interface.titleTab3 },
    { id = 4, title = WoWTR_Config_Interface.titleTab4 },
    { id = 5, title = WoWTR_Config_Interface.titleTab5 },
    { id = 6, title = WoWTR_Config_Interface.titleTab6 },
    { id = 9, title = WoWTR_Config_Interface.titleTab9 },
  }

  local tabs = {}
  local panels = {}

  for i, info in ipairs(tabInfo) do
    local tabA = CreateFrame("BUTTON", "WOWTR_Tab" .. info.id .. "TitleA", WOWTR_Options, "GameMenuButtonTemplate")
    tabA:SetWidth(100)
    tabA:SetHeight(20)
    if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP') or (WoWTR_Localization.lang == 'PL' and info.id == 5)) then
      local fo = tabA:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(info.title));
      tabA:SetFontString(fo);
    end
    tabA:SetText(QTR_ReverseIfAR(info.title))
    tabA:ClearAllPoints()
    if i == 1 then
      tabA:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -10, -60)
    else
      tabA:SetPoint("TOPLEFT", tabs[i-1].A, "TOPRIGHT", -4, 0)
    end
    tabA:Hide()

    local tabB = CreateFrame("BUTTON", "WOWTR_Tab" .. info.id .. "TitleB", WOWTR_Options, "UIPanelButtonGrayTemplate")
    tabB:SetWidth(100)
    tabB:SetHeight(20)
    if ((WoWTR_Localization.lang == 'AR') or (WoWTR_Localization.lang == 'JP') or (WoWTR_Localization.lang == 'PL' and info.id == 5)) then
      local fo = tabB:CreateFontString();
      fo:SetFont(WOWTR_Font2, 12);
      fo:SetText(QTR_ReverseIfAR(info.title));
      tabB:SetFontString(fo);
    end
    tabB:SetText(QTR_ReverseIfAR(info.title))
    tabB:ClearAllPoints()
    if i == 1 then
      tabB:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -10, -60)
    else
      tabB:SetPoint("TOPLEFT", tabs[i-1].B, "TOPRIGHT", -4, 0)
    end
    tabB:Show()
    tabB:SetScript("OnClick", function() WOWTR_ChangePanel(info.id) end)

    tabs[i] = { A = tabA, B = tabB }

    local panel = CreateFrame("FRAME", "WOWTR_OptionPanel" .. info.id, WOWTR_Options, "BackdropTemplate")
    panel:SetMovable(false)
    panel:SetWidth(682)
    panel:SetHeight(530)
    panel:ClearAllPoints()
    panel:SetPoint("TOPLEFT", WOWTR_Options, "TOPLEFT", -15, -73)
    panel:Hide()
    panels[info.id] = panel
  end

  function WOWTR_ChangePanel(panelId)
    for i, t in ipairs(tabs) do
      if tabInfo[i].id == panelId then
        t.A:Show()
        t.B:Hide()
        panels[tabInfo[i].id]:Show()
      else
        t.A:Hide()
        t.B:Show()
        panels[tabInfo[i].id]:Hide()
      end
    end
  end

  WOWTR_CreateQuestsTab(panels[1])
  WOWTR_CreateBubblesTab(panels[2])
  WOWTR_CreateSubtitlesTab(panels[3])
  WOWTR_CreateTutorialsTab(panels[4])
  WOWTR_CreateBooksTab(panels[5])
  WOWTR_CreateTooltipsTab(panels[6])
  WOWTR_CreateAboutTab(panels[9])

  WOWTR_ChangePanel(1) -- Show first tab by default
end

function WOWTR_UpdateAllTabs()
  WOWTR_CheckButton00:SetChecked(QTR_PS["icon"] == "1");
  WOWTR_UpdateQuestsTab()
  WOWTR_UpdateBubblesTab()
  WOWTR_UpdateSubtitlesTab()
  WOWTR_UpdateTutorialsTab()
  WOWTR_UpdateBooksTab()
  WOWTR_UpdateTooltipsTab()
end

function WOWTR_SetDungeonFrames(obj, tryb, horiz)
  if (tryb) then -- show
    obj:SetOwner(UIParent, "ANCHOR_NONE");
    obj:ClearAllPoints();
    obj:SetPoint("CENTER", horiz, obj.vertical);
    obj:ClearLines();
    obj:AddLine(QTR_ReverseIfAR(WoWTR_Localization.moveFrameUpDown), 1, 1, 1, true);
    if (BB_PM["setsize"] == "1") then
      _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, tonumber(BB_PM["fontsize"]));
    else
      _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, 13);
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

function WOWTR_HideOptionsFrame()
  WOWTR_SetDungeonFrames(WOWBB1, false);
  WOWTR_SetDungeonFrames(WOWBB2, false);
  WOWTR_SetDungeonFrames(WOWBB3, false);
  WOWTR_SetDungeonFrames(WOWBB4, false);
  WOWTR_SetDungeonFrames(WOWBB5, false);
end

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

function WOWTR_ReloadUI()
  ReloadUI()
end

function Config_OnEnable()
  WOWTR_BlizzardOptions();
end

function WOWTR_SlashCommand(msg)
  if not msg or msg:trim() == "" then
    InterfaceOptionsFrame_OpenToCategory(WOWTR.CategoryID);
  end
end

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
      WOWTR.WelcomePanel.Text, WOWTR_Font2, -140, "RIGHT"));
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

function CreateToggleButton(parentFrame, settingsTable, settingKey, onText, offText, point, onClick)
  local buttonOFF = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
  local buttonON = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")

  local function SetupButton(button, text)
    button:SetSize(120, 22)
    if WoWTR_Localization.lang == 'AR' and text == WoWTR_Localization.WoWTR_trDESC then
      button:SetText(QTR_ReverseIfAR(text))
      button:GetFontString():SetFont(WOWTR_Font2, 13)
    else
      button:SetText(text)
      local font, size = button:GetFontString():GetFont()
      button:GetFontString():SetFont(font, 13)
    end
    button:SetPoint(unpack(point))
    button:SetFrameStrata("TOOLTIP")
  end

  SetupButton(buttonOFF, offText)
  SetupButton(buttonON, onText)

  local function UpdateVisibility()
    if settingsTable[settingKey] == "1" then
      buttonOFF:Show(); buttonON:Hide()
    else
      buttonOFF:Hide(); buttonON:Show()
    end
  end

  buttonOFF:SetScript("OnClick", function()
    settingsTable[settingKey] = "0"
    UpdateVisibility()
    if onClick then
      onClick()
    end
  end)

  buttonON:SetScript("OnClick", function()
    settingsTable[settingKey] = "1"
    UpdateVisibility()
    if onClick then
      onClick()
    end
  end)

  UpdateVisibility()
  return UpdateVisibility
end

if ((GetLocale() == "enUS") or (GetLocale() == "enGB")) then
  local addon = LibStub("AceAddon-3.0"):NewAddon(WoWTR_Localization.addonName, "AceConsole-3.0")
  WOWTR_icon = LibStub("LibDBIcon-1.0");
  WOWTR_minimapButton = LibStub("LibDataBroker-1.1"):NewDataObject("WOWTR_LDB", {
    type = "data source",
    text = "WOWTR_LDB",
    icon = WoWTR_Localization.mainFolder .. "\\Images\\icon.png",
    OnClick = function()
      Settings.OpenToCategory(WOWTR.CategoryID);
    end,
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

  function addon:OnInitialize()
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
