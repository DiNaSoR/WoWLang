local addonName, ns = ...

ns.Core = ns.Core or {}
local Core = ns.Core

-- Hash function used across modules
function Core.StringHash(text)
  if (not text or (#text == 0)) then return 0 end
  local counter = 1
  local pomoc = 0
  local dlug = string.len(text)
  for i = 1, dlug, 3 do
    counter = math.fmod(counter * 8161, 4294967279)
    pomoc = (string.byte(text, i) * 16776193)
    counter = counter + pomoc
    pomoc = ((string.byte(text, i + 1) or (dlug - i + 256)) * 8372226)
    counter = counter + pomoc
    pomoc = ((string.byte(text, i + 2) or (dlug - i + 256)) * 3932164)
    counter = counter + pomoc
  end
  return math.fmod(counter, 4294967291)
end

-- Repetitive function and delay utilities
function Core.Wait(delay, func, ...)
  if (type(delay) ~= "number" or type(func) ~= "function") then
    return false
  end
  if (WOWTR_waitFrame == nil) then
    WOWTR_waitFrame = CreateFrame("Frame", "WOWTR_WaitFrame", UIParent)
    WOWTR_waitFrame:SetScript("onUpdate", function(self, elapse)
      local count = #WOWTR_waitTable
      local i = 1
      while (i <= count) do
        local waitRecord = tremove(WOWTR_waitTable, i)
        local d = tremove(waitRecord, 1)
        local f = tremove(waitRecord, 1)
        local p = tremove(waitRecord, 1)
        if (d > elapse) then
          tinsert(WOWTR_waitTable, i, { d - elapse, f, p })
          i = i + 1
        else
          count = count - 1
          f(unpack(p))
        end
      end
    end)
  end
  tinsert(WOWTR_waitTable, { delay, func, { ... } })
  return true
end

local tickers = {}
function Core.StartTicker(frame, func, interval)
  if not frame or not func or not interval then return end
  if not tickers[frame] then
    func()
    tickers[frame] = C_Timer.NewTicker(interval, function()
      if frame:IsVisible() then
        func()
      else
        tickers[frame]:Cancel()
        tickers[frame] = nil
      end
    end)
  end
end

function Core.StartDelayedFunction(func, delay)
  if not func or not delay then return end
  C_Timer.After(delay, func)
end

-- SavedVariables initialization and migration shim (legacy globals preserved)
function Core.CheckVars()
  QTR_PS = QTR_PS or {}
  QTR_SAVED = QTR_SAVED or {}
  QTR_MISSING = QTR_MISSING or {}
  QTR_GOSSIP = QTR_GOSSIP or {}

  BB_PM = BB_PM or {}
  BB_PS = BB_PS or {}
  BB_TR = BB_TR or {}

  MF_PM = MF_PM or {}
  MF_PS = MF_PS or {}

  QTR_GS = {}

  if (not QTR_PS["icon"]) then QTR_PS["icon"] = "1" end
  if (not QTR_PS["active"]) then QTR_PS["active"] = "1" end
  if (not QTR_PS["transtitle"]) then QTR_PS["transtitle"] = "1" end
  if (not QTR_PS["gossip"]) then QTR_PS["gossip"] = "1" end
  if (not QTR_PS["fontsize"]) then QTR_PS["fontsize"] = "13" end
  if (not QTR_PS["ownnames"]) then QTR_PS["ownnames"] = "0" end
  if (not QTR_PS["tracker"]) then QTR_PS["tracker"] = "1" end
  if (not QTR_PS["saveQS"]) then QTR_PS["saveQS"] = "1" end
  if (not QTR_PS["saveGS"]) then QTR_PS["saveGS"] = "1" end
  if (not QTR_PS["questlog"]) then QTR_PS["questlog"] = "1" end
  if (not QTR_PS["immersion"]) then QTR_PS["immersion"] = "1" end
  if (not QTR_PS["storyline"]) then QTR_PS["storyline"] = "1" end
  if (not QTR_PS["dialogueui"]) then QTR_PS["dialogueui"] = "1" end
  if (not QTR_PS["en_first"]) then QTR_PS["en_first"] = "0" end
  if (not QTR_PS["FontFile"]) then QTR_PS["FontFile"] = WOWTR_Fonts and WOWTR_Fonts[1] or QTR_PS["FontFile"] end
  if (WOWTR_Fonts and #WOWTR_Fonts > 1) then
    WOWTR_Font2 = WoWTR_Localization.mainFolder .. "\\Fonts\\" .. QTR_PS["FontFile"]
  end

  if (not QTR_PS.firstTimeLoaded) then
    QTR_PS.firstTimeLoaded = true
    WOWTR_ResetVariables(1)
  end

  if (not BB_PM["active"]) then BB_PM["active"] = "1" end
  if (not BB_PM["chat-en"]) then BB_PM["chat-en"] = "0" end
  if (not BB_PM["chat-tr"]) then BB_PM["chat-tr"] = "1" end
  if (not BB_PM["saveNB"]) then BB_PM["saveNB"] = "1" end
  if (not BB_PM["TRonline"]) then BB_PM["TRonline"] = "0" end
  if (not BB_PM["setsize"]) then BB_PM["setsize"] = "0" end
  if (not BB_PM["fontsize"]) then BB_PM["fontsize"] = "13" end
  if (not BB_PM["sex"]) then BB_PM["sex"] = "4" end
  if (not BB_PM["dungeon"]) then BB_PM["dungeon"] = "0" end
  BB_PM["dungeonF"] = "0"
  if (not BB_PM["dungeonF1"]) then BB_PM["dungeonF1"] = 270 end
  if (not BB_PM["dungeonF2"]) then BB_PM["dungeonF2"] = 270 end
  if (not BB_PM["dungeonF3"]) then BB_PM["dungeonF3"] = 270 end
  if (not BB_PM["dungeonF4"]) then BB_PM["dungeonF4"] = 270 end
  if (not BB_PM["dungeonF5"]) then BB_PM["dungeonF5"] = 270 end
  if (not BB_PM["timeDisplay"]) then BB_PM["timeDisplay"] = "5" end
  if (WOWBB1) then
    WOWBB1.vertical = BB_PM["dungeonF1"]
    WOWBB2.vertical = BB_PM["dungeonF2"]
    WOWBB3.vertical = BB_PM["dungeonF3"]
    WOWBB4.vertical = BB_PM["dungeonF4"]
    WOWBB5.vertical = BB_PM["dungeonF5"]
  end

  if (not MF_PM["active"]) then MF_PM["active"] = "1" end
  if (not MF_PM["intro"]) then MF_PM["intro"] = "1" end
  if (not MF_PM["movie"]) then MF_PM["movie"] = "1" end
  if (not MF_PM["cinematic"]) then MF_PM["cinematic"] = "1" end
  if (not MF_PM["save"]) then MF_PM["save"] = "1" end

  TT_PS = TT_PS or {}
  if (not TT_PS["active"]) then TT_PS["active"] = "1" end
  if (not TT_PS["save"]) then TT_PS["save"] = "1" end
  if (not TT_PS["saveui"]) then TT_PS["saveui"] = "1" end
  for i=1,8 do if (not TT_PS["ui"..i]) then TT_PS["ui"..i] = "1" end end
  if (not TT_PS["ui_talents"]) then TT_PS["ui_talents"] = "1" end
  TT_TUTORIALS = TT_TUTORIALS or {}

  BT_PM = BT_PM or {}
  if (not BT_PM["active"]) then BT_PM["active"] = "1" end
  if (not BT_PM["title"]) then BT_PM["title"] = "1" end
  if (not BT_PM["showID"]) then BT_PM["showID"] = "1" end
  if (not BT_PM["setsize"]) then BT_PM["setsize"] = "0" end
  if (not BT_PM["fontsize"]) then BT_PM["fontsize"] = 15 end
  if (not BT_PM["saveNW"]) then BT_PM["saveNW"] = "1" end
  BT_SAVED = BT_SAVED or {}

  ST_PM = ST_PM or {}
  ST_PS = ST_PS or {}
  ST_PH = ST_PH or {}
  if (not ST_PM["active"]) then ST_PM["active"] = "1" end
  if (not ST_PM["item"]) then ST_PM["item"] = "1" end
  if (not ST_PM["spell"]) then ST_PM["spell"] = "1" end
  if (not ST_PM["talent"]) then ST_PM["talent"] = "1" end
  if (not ST_PM["transtitle"]) then ST_PM["transtitle"] = "0" end
  if (not ST_PM["showID"]) then ST_PM["showID"] = "0" end
  if (not ST_PM["showHS"]) then ST_PM["showHS"] = "0" end
  if (not ST_PM["saveNW"]) then ST_PM["saveNW"] = "1" end
  if (not ST_PM["sellprice"]) then ST_PM["sellprice"] = "0" end
  if (not ST_PM["constantly"]) then ST_PM["constantly"] = "1" end
  if (not ST_PM["timer"]) then ST_PM["timer"] = "10" end

  if (WoWTR_Localization and WoWTR_Localization.lang == 'AR') then
    CH_PM = CH_PM or {}
    if (not CH_PM["active"]) then CH_PM["active"] = "1" end
    if (not CH_PM["fontsize"]) then CH_PM["fontsize"] = "13" end
  end

  WoWTR_minimapDB = WoWTR_minimapDB or {}

  QTR_PS["patch"] = GetBuildInfo()
  QTR_PS["locale"] = GetLocale()
end

-- Version ping helpers
function Core.SendVersion()
  local now = GetTime()
  if (WOWTR_time_ver + 15 * 60 < now) then
    if (IsInGuild()) then C_ChatInfo.SendAddonMessage(WOWTR_ADDON_PREFIX, WOWTR_version, "GUILD") end
    if (IsInRaid()) then C_ChatInfo.SendAddonMessage(WOWTR_ADDON_PREFIX, WOWTR_version, "RAID") end
    WOWTR_time_ver = now
  end
end

function Core.OnChatMsgAddon(who, msg)
  if (tonumber(msg) > tonumber(WOWTR_version)) then
    local currentTime = GetTime()
    if (currentTime - WOWTR_lastNotificationTime) > WOWTR_notificationCooldown then
      print("|cffffff00" .. WoWTR_Localization.addonName .. "|r - " .. WoWTR_Localization.newVersionAvailable .. " |cffffff00" .. msg .. "|r")
      UIErrorsFrame:SetTimeVisible(10)
      if (WoWTR_Localization and WoWTR_Localization.lang == 'AR') then
        UIErrorsFrame:AddMessage(QTR_ReverseIfAR(WoWTR_Localization.addonName .. " - " .. WoWTR_Localization.newVersionAvailable .. WOWTR_AnsiReverse(msg)), 1, 0.5, 1)
      else
        UIErrorsFrame:AddMessage(WoWTR_Localization.addonName .. " - " .. WoWTR_Localization.newVersionAvailable .. msg, 1, 0.5, 1)
      end
      WOWTR_lastNotificationTime = currentTime
    end
  end
end

-- Event dispatcher
function Core.OnEvent(self, event, name, ...)
  if (event == "ADDON_LOADED" and WoWTR_Localization and name == WoWTR_Localization.addonFolder) then
    self:UnregisterEvent("ADDON_LOADED")
    self:RegisterEvent("QUEST_ACCEPTED")
    self:RegisterEvent("QUEST_DETAIL")
    self:RegisterEvent("QUEST_PROGRESS")
    self:RegisterEvent("QUEST_COMPLETE")
    self:RegisterEvent("GOSSIP_SHOW")
    self:RegisterEvent("QUEST_GREETING")
    self:RegisterEvent("PLAY_MOVIE")
    self:RegisterEvent("CINEMATIC_START")
    self:RegisterEvent("CINEMATIC_STOP")
    self:RegisterEvent("TUTORIAL_TRIGGER")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("MODIFIER_STATE_CHANGED")

    ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", BB_ChatFilter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_PARTY", BB_ChatFilter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", BB_ChatFilter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_WHISPER", BB_ChatFilter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_EMOTE", BB_ChatFilter)

    SlashCmdList["WOWTR"] = function(msg) WOWTR_SlashCommand(msg) end
    SLASH_WOWTR_BUBBLES1 = "/wowtr"
    SLASH_WOWTR_BUBBLES2 = "/qtr"
    SLASH_WOWTR_BUBBLES3 = "/bbtr"
    SLASH_WOWTR_BUBBLES4 = "/mtr"
    SLASH_WOWTR_BUBBLES5 = "/btr"
    SLASH_WOWTR_BUBBLES6 = "/str"

    Core.CheckVars()
    if QTR_START then QTR_START() end
    if Config_OnEnable then Config_OnEnable() end
    if (WoWTR_Localization and WoWTR_Localization.lang == 'AR' and CHAT_START) then CHAT_START() end

    if TutorialFrame and TT_onTutorialShow then TutorialFrame:HookScript("OnShow", TT_onTutorialShow) end
    if (not PlayerChoiceFrame) then PlayerChoice_LoadUI() end
    if PlayerChoiceFrame and TT_onChoiceDelay then PlayerChoiceFrame:HookScript("OnShow", TT_onChoiceDelay) end

    if ItemTextFrame and BookTranslator_ShowTranslation then
      ItemTextFrame:HookScript("OnShow", function() BookTranslator_ShowTranslation() end)
      if ItemTextNextPageButton then ItemTextNextPageButton:HookScript("OnClick", function() BookTranslator_ShowTranslation() end) end
      if ItemTextPrevPageButton then ItemTextPrevPageButton:HookScript("OnClick", function() BookTranslator_ShowTranslation() end) end
      BT_ToggleButton0 = CreateFrame("Button", nil, ItemTextFrame, "UIPanelButtonTemplate")
      BT_ToggleButton0:SetWidth(40)
      BT_ToggleButton0:SetHeight(20)
      BT_ToggleButton0:SetText("EN")
      BT_ToggleButton0:Show()
      BT_ToggleButton0:ClearAllPoints()
      BT_ToggleButton0:SetPoint("BOTTOMRIGHT", ItemTextFrame, "BOTTOMRIGHT", -29, 5)
      BT_ToggleButton0:SetScript("OnClick", BT_ON_OFF)
    end

    if (_G.ElvUI and ST_ElvSpellBookTooltipOnShow) then
      local E = unpack(ElvUI)
      if E and E.SpellBookTooltip then
        E.SpellBookTooltip:HookScript("OnShow", function(self, ...)
          Core.Wait(0.02, ST_ElvSpellBookTooltipOnShow)
        end)
      end
    end

    if StaticPopup1 and ST_StaticPopup1 then StaticPopup1:HookScript("OnShow", ST_StaticPopup1) end
    if StaticPopup2 and ST_StaticPopup1 then StaticPopup2:HookScript("OnShow", ST_StaticPopup1) end
    if GameMenuFrame and ST_GameMenuTranslate then GameMenuFrame:HookScript("OnShow", ST_GameMenuTranslate) end
    if MerchantFrame and ST_MerchantFrame then MerchantFrame:HookScript("OnShow", ST_MerchantFrame) end
    if PVEFrame and ST_GroupFinder then PVEFrame:HookScript("OnShow", function() Core.StartTicker(PVEFrame, ST_GroupFinder, 0) end) end
    if WorldMapFrame and ST_WorldMapFunc then WorldMapFrame:HookScript("OnShow", function() Core.StartTicker(WorldMapFrame, ST_WorldMapFunc, 0.1) end) end
    if QuestScrollFrame and QTR_Quest_Next then QuestScrollFrame:HookScript("OnShow", function() Core.StartTicker(QuestScrollFrame, QTR_Quest_Next, 0.02) end) end
    if CharacterFrame and ST_CharacterFrame then CharacterFrame:HookScript("OnShow", ST_CharacterFrame) end
    if FriendsFrame and ST_FriendsFrame then FriendsFrame:HookScript("OnShow", function() Core.StartTicker(FriendsFrame, ST_FriendsFrame, 0.1) end) end
    if HelpPlateTooltip and ST_HelpPlateTooltip then HelpPlateTooltip:HookScript("OnShow", function() Core.StartTicker(HelpPlateTooltip, ST_HelpPlateTooltip, 0.1) end) end
    if SplashFrame and ST_SplashFrame then SplashFrame:HookScript("OnShow", function() Core.StartTicker(SplashFrame, ST_SplashFrame, 0.1) end) end
    if PingSystemTutorialTitleText and ST_PingSystemTutorial then PingSystemTutorialTitleText:HookScript("OnShow", function() Core.StartTicker(PingSystemTutorialTitleText, ST_PingSystemTutorial, 0.1) end) end
    if BankFrame and ST_WarbandBankFrm then BankFrame:HookScript("OnShow", function() Core.StartTicker(BankFrame, ST_WarbandBankFrm, 0.1) end) end
    if ItemRefTooltip and ST_ItemRefTooltip then ItemRefTooltip:HookScript("OnShow", function() Core.StartTicker(ItemRefTooltip, ST_ItemRefTooltip, 0.02) end) end
    if EventToastManagerFrame and ST_EventToastManagerFrame then EventToastManagerFrame:HookScript("OnShow", function() Core.StartTicker(EventToastManagerFrame, ST_EventToastManagerFrame, 0.1) end) end
    if RaidBossEmoteFrame and ST_RaidBossEmoteFrame then RaidBossEmoteFrame:HookScript("OnShow", function() Core.StartTicker(RaidBossEmoteFrame, ST_RaidBossEmoteFrame, 0.1) end) end
    if ReputationFrame and ReputationFrame.ReputationDetailFrame and ST_CharacterFrame then ReputationFrame.ReputationDetailFrame:HookScript("OnShow", function() Core.StartTicker(ReputationFrame.ReputationDetailFrame, ST_CharacterFrame, 0.1) end) end
    if PlayerChoiceFrame and TT_onChoiceShow then PlayerChoiceFrame:HookScript("OnShow", function() Core.StartTicker(PlayerChoiceFrame, TT_onChoiceShow, 0.1) end) end

    if BB_OknoTRonline then BB_OknoTRonline() end

    WOWTR_ADDON_PREFIX = WoWTR_Localization.addonName .. "_ver"
    if WOWTR and WOWTR.RegisterEvent then
      WOWTR:RegisterEvent("CHAT_MSG_ADDON")
    else
      WOWTR = WOWTR or CreateFrame("Frame")
      WOWTR:RegisterEvent("CHAT_MSG_ADDON")
    end
    C_ChatInfo.RegisterAddonMessagePrefix(WOWTR_ADDON_PREFIX)

    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00" .. WoWTR_Localization.addonName .. "  ver. " .. WOWTR_version .. " - " .. WoWTR_Localization.started)
    if ((not QTR_PS["welcome"]) and WoWTR_Config_Interface and (string.len(WoWTR_Config_Interface.welcomeText or "") > 1)) then
      if WOWTR_WelcomePanel then WOWTR_WelcomePanel() end
    end
  elseif (event == "PLAYER_ENTERING_WORLD") then
    if TT_onTutorialShow then TT_onTutorialShow() end
  elseif (event == "QUEST_DETAIL" or event == "QUEST_PROGRESS" or event == "QUEST_COMPLETE") then
    if (event == "QUEST_DETAIL" and QTR_quest_ID and QTR_quest_ID > 0) then
      local QTR_mapID = C_Map.GetBestMapForUnit("player")
      if (QTR_mapID) then
        local QTR_mapINFO = C_Map.GetMapInfo(QTR_mapID)
        if QTR_mapINFO then
          QTR_SAVED[QTR_quest_ID .. " MAPID"] = QTR_mapID .. "@" .. QTR_mapINFO.name .. "@" .. QTR_mapINFO.mapType .. "@" .. QTR_mapINFO.parentMapID
        end
      end
    end
    if ((QuestFrame and QuestFrame:IsVisible()) or (isImmersion and isImmersion()) or (IsDUIQuestFrame and IsDUIQuestFrame())) then
      if QTR_QuestPrepare then QTR_QuestPrepare(event) end
    elseif (isStoryline and isStoryline()) then
      if QTR_Storyline_Quest then Core.Wait(1, QTR_Storyline_Quest) end
    end
    if QTR_ObjectiveTracker_Check then Core.Wait(1, QTR_ObjectiveTracker_Check) end
  elseif (event == "GOSSIP_SHOW") then
    if (QTR_PS and QTR_PS["gossip"] == "1") then
      if DUIPlugin and IsDUIQuestFrame and IsDUIQuestFrame() then
        if QTR_DUIGossipFrame then QTR_DUIGossipFrame() end
      else
        if (ElvUI and QTR_Gossip_Show) then
          Core.Wait(0.02, QTR_Gossip_Show)
        elseif QTR_Gossip_Show then
          QTR_Gossip_Show()
        end
      end
    end
  elseif (event == "PLAY_MOVIE") then
    local WOWTR_movieID = name
    if (WOWTR_movieID and MF_PM and (MF_PM["active"] == "1") and (MF_PM["movie"] == "1") and MF_PlayMovie) then
      MF_PlayMovie(WOWTR_movieID)
    end
  elseif (event == "CINEMATIC_START") then
    if MF_CinematicStart then MF_CinematicStart() end
  elseif (event == "CINEMATIC_STOP") then
    if MF_CinematicStop then MF_CinematicStop() end
  elseif (event == "TUTORIAL_TRIGGER") then
    if TT_onTutorialShow then TT_onTutorialShow() end
  elseif (isImmersion and isImmersion() and event == "QUEST_ACCEPTED") then
    if QTR_delayed3 then QTR_delayed3() end
  elseif (event == "CHAT_MSG_ADDON") then
    local msg, method, who = select(1, ...)
    if (name == WOWTR_ADDON_PREFIX) then Core.OnChatMsgAddon(who, msg) end
  elseif (GameTooltip and GameTooltip.IsShown and GameTooltip:IsShown() and event == "MODIFIER_STATE_CHANGED" and (name == "LSHIFT" or name == "RSHIFT") and ST_PM and (ST_PM["active"] == "1")) then
    if (GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData and GameTooltip.processingInfo.tooltipData.id and (ST_PM["item"] == "1")) then
      if (GameTooltip.processingInfo.tooltipData.type == 0) then -- items
        if (ShoppingTooltip1 and ShoppingTooltip1:IsVisible()) then
          ShoppingTooltip1:Hide()
          if (ShoppingTooltip2 and ShoppingTooltip2:IsVisible()) then
            ShoppingTooltip2:Hide()
          end
        else
          GameTooltip_ShowCompareItem()
        end
      end
    end
  end

  if (TT_onTutorialShow) then TT_onTutorialShow() end
  Core.SendVersion()
end

-- Global wrappers for backward compatibility
function StringHash(text) return Core.StringHash(text) end
function WOWTR_wait(delay, func, ...) return Core.Wait(delay, func, ...) end
function StartTicker(frame, func, interval) return Core.StartTicker(frame, func, interval) end
function StartDelayedFunction(func, delay) return Core.StartDelayedFunction(func, delay) end
function WOWTR_CheckVars() return Core.CheckVars() end
function WOWTR_onEvent(self, event, name, ...) return Core.OnEvent(self, event, name, ...) end
function WOWTR_SendVersion() return Core.SendVersion() end
function WOWTR_onChatMsgAddon(who, msg) return Core.OnChatMsgAddon(who, msg) end

-- Bootstrap the root frame and events similar to legacy behavior
if ((GetLocale() == "enUS") or (GetLocale() == "enGB")) then
  WOWTR = WOWTR or CreateFrame("Frame")
  WOWTR:SetScript("OnEvent", WOWTR_onEvent)
  WOWTR:RegisterEvent("ADDON_LOADED")
else
  DEFAULT_CHAT_FRAME:AddMessage("|cffffff00" .. (WoWTR_Localization and WoWTR_Localization.addonName or addonName) .. "|r  ver. " .. (WOWTR_version or "") .. " - add-on is not active because it was run in Locale |cffffff00" .. GetLocale())
end


