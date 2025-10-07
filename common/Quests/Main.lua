-- Quests/Main.lua
-- Core quest functions: start, toggle, save, id helpers

local addonName, ns = ...
ns = ns or {}
ns.Quests = ns.Quests or {}
local Quests = ns.Quests
local S = ns.Quests.State or {}

-- Toggle quest translation on/off (keeps globals in sync)
function Quests.ToggleTranslation()
   if (QTR_curr_trans=="1") then
      QTR_curr_trans="0"
      if QTR_Translate_Off then QTR_Translate_Off(1) end
   else
      QTR_curr_trans="1"
      if QTR_Translate_On then QTR_Translate_On(1) end
   end
   if WorldMapFrame and WorldMapFrame:IsVisible() then
      local questID = (QuestMapFrame and QuestMapFrame.DetailsFrame and QuestMapFrame.DetailsFrame.questID) or (Quests.GetQuestID and Quests.GetQuestID())
      if questID and QuestMapFrame_ShowQuestDetails then
         QuestMapFrame_ShowQuestDetails(questID)
      elseif QTR_PrepareReload then
         QTR_PrepareReload()
      end
   end
end

-- Save quest original texts for translation
function Quests.SaveQuest(event)
   if (event=="QUEST_DETAIL") then
      QTR_SAVED[QTR_quest_ID.." TITLE"]=C_QuestLog.GetTitleForQuestID(QTR_quest_ID)
      QTR_SAVED[QTR_quest_ID.." DESCRIPTION"]=WOWTR_DetectAndReplacePlayerName(QuestInfoDescriptionText:GetText())
      QTR_SAVED[QTR_quest_ID.." OBJECTIVE"]=WOWTR_DetectAndReplacePlayerName(QuestInfoObjectivesText:GetText())
      local QTR_mapID = C_Map.GetBestMapForUnit("player")
      if (QTR_mapID) then
         local QTR_mapINFO = C_Map.GetMapInfo(QTR_mapID)
         QTR_SAVED[QTR_quest_ID.." MAPID"]=QTR_mapID.."@"..QTR_mapINFO.name.."@"..QTR_mapINFO.mapType.."@"..QTR_mapINFO.parentMapID
      end
   end
   if (event=="QUEST_PROGRESS") then
      QTR_SAVED[QTR_quest_ID.." PROGRESS"]=WOWTR_DetectAndReplacePlayerName(GetProgressText())
   end
   if (event=="QUEST_COMPLETE") then
      QTR_SAVED[QTR_quest_ID.." COMPLETE"]=WOWTR_DetectAndReplacePlayerName(QuestInfoRewardText:GetText())
   end
   if (QTR_SAVED[QTR_quest_ID.." TITLE"]==nil) then
      QTR_SAVED[QTR_quest_ID.." TITLE"]=C_QuestLog.GetTitleForQuestID(QTR_quest_ID)
   end
   QTR_SAVED[QTR_quest_ID.." PLAYER"]=WOWTR_player_name..'@'..WOWTR_player_race..'@'..WOWTR_player_class
end

-- Determine current quest ID from visible sources
function Quests.GetQuestID()
   local quest_ID

   if (QuestFrame:IsVisible() or (isStoryline and isStoryline()) or (isImmersion and isImmersion()) or (IsDUIQuestFrame and IsDUIQuestFrame())) then
      quest_ID = GetQuestID()
   end

   if (((quest_ID==nil) or (quest_ID==0)) and QuestMapDetailsScrollFrame:IsVisible()) then
      quest_ID = QuestMapFrame.DetailsFrame.questID
   end

   if (((quest_ID==nil) or (quest_ID==0)) and QuestLogPopupDetailFrame:IsVisible()) then
      quest_ID = QuestLogPopupDetailFrame.questID
   end

   if (((quest_ID==nil) or (quest_ID==0)) and isClassicQuestLog and isClassicQuestLog()) then
      quest_ID = C_QuestLog.GetSelectedQuest()
   end

   if (quest_ID==nil) then
      quest_ID=0
   end

   return quest_ID
end

-- Initialize buttons, hooks, and tracker headers
function Quests.Start()
   -- Button in QuestFrame (NPC)
   QTR_ToggleButton0 = Quests.Utils.CreateButton(QuestFrame, 150, 20, "QID?", "TOPLEFT", QuestFrame, "TOPLEFT", 55, -20, Quests.ToggleTranslation)
   if QTR_ToggleButton0 then QTR_ToggleButton0:Show(); if S and S.ui and S.ui.quest then S.ui.quest.toggleEN = QTR_ToggleButton0 end end

   -- Button in QuestLogPopupDetailFrame
   QTR_ToggleButton1 = Quests.Utils.CreateButton(QuestLogPopupDetailFrame, 150, 20, "QID?", "TOPLEFT", QuestLogPopupDetailFrame, "TOPLEFT", 45, -31, Quests.ToggleTranslation)
   if QTR_ToggleButton1 then QTR_ToggleButton1:Show() end

   -- Button in QuestMapDetailsScrollFrame
   QTR_ToggleButton2 = Quests.Utils.CreateButton(QuestMapDetailsScrollFrame, 110, 21, "QID?", "TOPLEFT", QuestMapDetailsScrollFrame, "TOPLEFT", 96, 32, Quests.ToggleTranslation)
   if QTR_ToggleButton2 then QTR_ToggleButton2:Show() end

   -- Button in GossipFrame
   QTR_ToggleButtonGS1 = Quests.Utils.CreateButton(GossipFrame, 220, 20, "GH?", "TOPLEFT", GossipFrame, "TOPLEFT", 75, -20, GS_ON_OFF)
   if QTR_ToggleButtonGS1 then QTR_ToggleButtonGS1:Disable(); QTR_ToggleButtonGS1:Show(); if S and S.ui and S.ui.gossip then S.ui.gossip.toggleGS = QTR_ToggleButtonGS1 end end

   QTR_IconAI = GossipFrame:CreateTexture(nil, "OVERLAY")
   QTR_IconAI:ClearAllPoints()
   QTR_IconAI:SetPoint("TOPRIGHT", QTR_ToggleButtonGS1, "TOPRIGHT", 40, 0)
   QTR_IconAI:SetWidth(24)
   QTR_IconAI:SetHeight(24)
   QTR_IconAI:SetTexture(WoWTR_Localization.mainFolder.."\\Images\\icon_ai.png")
   QTR_IconAI:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines()
      if (GS_Gossip and GS_Gossip[1975795450]) then
         GameTooltip:AddLine(QTR_ExpandUnitInfo(GS_Gossip[1975795450], false, GameTooltip, WOWTR_Font2)..NONBREAKINGSPACE, 1, 1, 1, true)
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13)
      end
      GameTooltip:Show()
   end)
   QTR_IconAI:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
   QTR_IconAI:Hide(); if S and S.ui and S.ui.gossip then S.ui.gossip.iconAI = QTR_IconAI end

   GoQ_IconAI = QuestFrame:CreateTexture(nil, "OVERLAY")
   GoQ_IconAI:ClearAllPoints()
   GoQ_IconAI:SetPoint("TOPRIGHT", QTR_ToggleButton0, "TOPRIGHT", 72, 0)
   GoQ_IconAI:SetWidth(24)
   GoQ_IconAI:SetHeight(24)
   GoQ_IconAI:SetTexture(WoWTR_Localization.mainFolder.."\\Images\\icon_ai.png")
   GoQ_IconAI:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines()
      if (GS_Gossip and GS_Gossip[1975795450]) then
         GameTooltip:AddLine(QTR_ExpandUnitInfo(GS_Gossip[1975795450], false, GameTooltip, WOWTR_Font2)..NONBREAKINGSPACE, 1, 1, 1, true)
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13)
      end
      GameTooltip:Show()
   end)
   GoQ_IconAI:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
   GoQ_IconAI:Hide(); if S and S.ui and S.ui.quest then S.ui.quest.iconAI = GoQ_IconAI end

   -- Hooks and trackers
   WorldMapFrame:HookScript("OnHide", function()
      if (not WOWTR_wait(0.01, QTR_ObjectiveTrackerFrame_Titles)) then end
   end)
   WorldMapFrame:HookScript("OnShow", function()
      if (not WOWTR_wait(0.2, QTR_QuestScrollFrame_OnShow)) then end
      WOWTR_wait(0.01, QTR_ObjectiveTrackerFrame_Titles)
   end)

   hooksecurefunc("QuestLogQuests_Update", function()
      if QTR_QuestLogQuests_Update then
         return QTR_QuestLogQuests_Update()
      end
   end)
   hooksecurefunc("QuestMapFrame_ShowQuestDetails", function()
      StartDelayedFunction(function()
         if QTR_PrepareReload then
            QTR_PrepareReload()
         elseif Quests and Quests.Details and Quests.Details.QuestPrepare then
            Quests.Details.QuestPrepare()
         end
      end, 0.02)
   end)

   QuestFrame:HookScript("OnShow", GossipOnQuestFrame)
   QuestFrameAcceptButton:HookScript("OnClick", QTR_QuestFrameButton_OnClick)
   QuestFrameCompleteQuestButton:HookScript("OnClick", QTR_QuestFrameButton_OnClick)
   QuestLogPopupDetailFrame:HookScript("OnShow", QTR_QuestLogPopupShow)

   local versionString = select(4, GetBuildInfo())
   local versionNumber = tonumber(versionString)
   if versionNumber then
      if versionNumber <= 110007 then
         QuestMapFrame.CampaignOverview:HookScript("OnShow", function() StartDelayedFunction(TT_CampaignOverview, 0.5) end)
      else
         QuestMapFrame.QuestsFrame.CampaignOverview:HookScript("OnShow", function() StartDelayedFunction(TT_CampaignOverview, 0.5) end)
      end
   end

   if hooksecurefunc then
      hooksecurefunc(QuestObjectiveTracker, "UpdateSingle", function(self, quest)
         QTR_OverrideObjectiveTrackerHeader(self, quest)
      end)
      local function ProcessTrackerBlockUpdates(tracker)
         local template = tracker.blockTemplate or "ObjectiveTrackerBlockTemplate"
         local questBlocks = tracker.usedBlocks and tracker.usedBlocks[template]
         if questBlocks then
            for questID, block in pairs(questBlocks) do
               if block and block:IsVisible() and block.HeaderText then
                  QTR_OverrideObjectiveTrackerHeader(tracker, questID, true)
               end
            end
         end
      end
      hooksecurefunc(CampaignQuestObjectiveTracker, "Update", function(self) ProcessTrackerBlockUpdates(self) end)
      hooksecurefunc(WorldQuestObjectiveTracker, "Update", function(self) ProcessTrackerBlockUpdates(self) end)
      hooksecurefunc(BonusObjectiveTracker, "Update", function(self) ProcessTrackerBlockUpdates(self) end)
      hooksecurefunc(MonthlyActivitiesObjectiveTracker, "Update", function(self) ProcessTrackerBlockUpdates(self) end)
      hooksecurefunc(ScenarioObjectiveTracker, "Update", function(self) ProcessTrackerBlockUpdates(self) end)
      hooksecurefunc(ObjectiveTrackerFrame, "Update", function(self)
         QTR_ObjectiveTrackerFrame_Titles()
      end)
   end

   WorldMapFrame:HookScript("OnShow", function()
      if (not WOWTR_wait(0.2, QTR_QuestScrollFrame_OnShow)) then end
   end)
end

-- Back-compat global wrappers
function QTR_ON_OFF() return Quests.ToggleTranslation() end
function QTR_SaveQuest(event) return Quests.SaveQuest(event) end
function QTR_GetQuestID() return Quests.GetQuestID() end
function QTR_START() return Quests.Start() end
