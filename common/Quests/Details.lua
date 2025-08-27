-- Quests/Details.lua
-- Facade for quest detail handling and translate on/off

local addonName, ns = ...
ns = ns or {}
ns.Quests = ns.Quests or {}
local Quests = ns.Quests

Quests.Details = Quests.Details or {}

-- Display translation
function Quests.Details.TranslateOn(typ,event)
   QTR_display_constants(1)
   if (QuestNPCModelText:IsVisible() and (QTR_ModelTextHash>0)) then
      QuestNPCModelText:SetText(QTR_ExpandUnitInfo(QTR_ModelText_PL..NONBREAKINGSPACE,false,QuestNPCModelText,WOWTR_Font2,-15))
      QuestNPCModelText:SetFont(WOWTR_Font2, 13)
   end

   if (typ==1) then
      local numer_ID = QTR_quest_ID
      str_ID = tostring(numer_ID)
      if (numer_ID>0 and QTR_QuestData[str_ID]) then
         QTR_ToggleButton0:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")")
         QTR_ToggleButton1:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")")
         QTR_ToggleButton2:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")")
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")")
         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")")
            if (not WOWTR_wait(0.2,QTR_Immersion)) then end
         end
         if (isStoryline() and Storyline_NPCFrame:IsVisible()) then
            QTR_ToggleButton5:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")")
            QTR_Storyline(1)
         end
         if (IsDUIQuestFrame()) then
            QTR_ToggleButton7:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")")
            QTR_ToggleButton7:Enable()
         end

         local WOW_width = 280
         local rtl = (Quests.Utils and Quests.Utils.IsRTL and Quests.Utils.IsRTL()) or false
         if rtl then WOW_width = 320 end
         if (QuestInfoRewardsFrame:IsVisible() and not rtl) then WOW_width = 280 end

         if (QTR_PS["transtitle"] == "1") then
            QuestInfoTitleHeader:SetWidth(WOW_width)
            QuestProgressTitleText:SetWidth(WOW_width)
            QuestInfoTitleHeader:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18)
            QuestProgressTitleText:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18)
            if (WorldMapFrame:IsVisible()) then
               if rtl then
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50, "RIGHT"))
               else
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50))
               end
            else
               if rtl then
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50, "RIGHT"))
               else
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50))
               end
            end
            if rtl then
               QuestProgressTitleText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestProgressTitleText, WOWTR_Font1, -50, "RIGHT"))
            else
               QuestProgressTitleText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestProgressTitleText, WOWTR_Font1, -50))
            end
         end

         if rtl then
            QuestInfoDescriptionText:SetWidth(WOW_width - 50)
            QuestInfoObjectivesText:SetWidth(WOW_width - 50)
            QuestProgressText:SetWidth(WOW_width - 50)
            QuestInfoRewardText:SetWidth(WOW_width - 45)
         else
            QuestInfoDescriptionText:SetWidth(WOW_width - 1)
            QuestInfoObjectivesText:SetWidth(WOW_width - 1)
            QuestProgressText:SetWidth(WOW_width - 1)
            QuestInfoRewardText:SetWidth(WOW_width)
         end

         local sz = C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"])
         QuestInfoDescriptionText:SetFont(WOWTR_Font2, sz)
         QuestInfoObjectivesText:SetFont(WOWTR_Font2, sz)
         QuestProgressText:SetFont(WOWTR_Font2, sz)
         QuestInfoRewardText:SetFont(WOWTR_Font2, sz)
         QuestInfoDescriptionText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].details, false, QuestInfoDescriptionText, WOWTR_Font2, -5))
         if rtl then QuestInfoDescriptionText:SetJustifyH("RIGHT") else QuestInfoDescriptionText:SetJustifyH("LEFT") end
         QuestInfoObjectivesText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].objectives,true,QuestInfoObjectivesText,WOWTR_Font2,-10))
         if rtl then QuestInfoObjectivesText:SetJustifyH("RIGHT") else QuestInfoObjectivesText:SetJustifyH("LEFT") end
         QuestProgressText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].progress,false,QuestProgressText,WOWTR_Font2))
         if rtl then QuestProgressText:SetJustifyH("RIGHT") else QuestProgressText:SetJustifyH("LEFT") end
         if rtl then
            QuestInfoRewardText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].completion,false,QuestInfoRewardText,WOWTR_Font2,-5,"RIGHT"))
         else
            QuestInfoRewardText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].completion,false,QuestInfoRewardText,WOWTR_Font2,-5))
         end
      end
      if (IsDUIQuestFrame()) then
         QTR_DUIQuestFrame(event)
         if ( QTR_PS["en_first"]=="1" ) then DUI_ON_OFF() end
      end
   else
      if (QTR_curr_trans == "1") then
         if ((ImmersionFrame ~= nil ) and (ImmersionFrame.TalkBox:IsVisible() )) then
            if (not WOWTR_wait(0.2,QTR_Immersion_Static)) then end
         end
      end
   end
end

-- Display original English text
function Quests.Details.TranslateOff(typ,event)
   QTR_display_constants(0)
   if (QuestNPCModelText:IsVisible() and (QTR_ModelTextHash>0)) then
      QuestNPCModelText:SetText(QTR_ModelText_EN)
      QuestNPCModelText:SetFont(Original_Font2, 13)
   end
   if (typ==1) then
      local numer_ID = QTR_quest_ID
      str_ID = tostring(numer_ID)
      if (numer_ID>0 and QTR_QuestData[str_ID]) then
         QTR_ToggleButton0:SetText("QID="..QTR_quest_ID.." (EN)")
         QTR_ToggleButton1:SetText("QID="..QTR_quest_ID.." (EN)")
         QTR_ToggleButton2:SetText("QID="..QTR_quest_ID.." (EN)")
         if (isClassicQuestLog()) then QTR_ToggleButton3:SetText("QID="..QTR_quest_ID.." (EN)") end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("QID="..QTR_quest_ID.." (EN)")
            QTR_Immersion_OFF()
            ImmersionFrame.TalkBox.TextFrame.Text:RepeatTexts()
         end
         if (isStoryline() and Storyline_NPCFrame:IsVisible()) then
            QTR_ToggleButton5:SetText("QID="..QTR_quest_ID.." (EN)")
            QTR_Storyline_OFF(1)
         end
         local WOW_width = 280
         if (QuestInfoRewardsFrame:IsVisible()) then WOW_width = 280 end
         QuestInfoTitleHeader:SetFont(Original_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18)
         QuestProgressTitleText:SetFont(Original_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18)
         QuestInfoTitleHeader:SetText(QTR_quest_EN[QTR_quest_ID].title)
         QuestProgressTitleText:SetText(QTR_quest_EN[QTR_quest_ID].title)
         QuestInfoDescriptionText:SetWidth(WOW_width - 1)
         QuestInfoObjectivesText:SetWidth(WOW_width - 1)
         QuestProgressText:SetWidth(WOW_width - 1)
         QuestInfoRewardText:SetWidth(WOW_width)
         local sz = C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"])
         QuestInfoDescriptionText:SetFont(Original_Font2, sz)
         QuestInfoObjectivesText:SetFont(Original_Font2, sz)
         QuestProgressText:SetFont(Original_Font2, sz)
         QuestInfoRewardText:SetFont(Original_Font2, sz)
         QuestInfoDescriptionText:SetText(QTR_quest_EN[QTR_quest_ID].details)
         QuestInfoObjectivesText:SetText(QTR_quest_EN[QTR_quest_ID].objectives)
         QuestProgressText:SetText(QTR_quest_EN[QTR_quest_ID].progress)
         QuestInfoRewardText:SetText(QTR_quest_EN[QTR_quest_ID].completion)
         QuestInfoDescriptionText:SetJustifyH("LEFT")
         QuestInfoObjectivesText:SetJustifyH("LEFT")
         QuestProgressText:SetJustifyH("LEFT")
         QuestInfoRewardText:SetJustifyH("LEFT")
         QuestInfoTitleHeader:SetJustifyH("LEFT")
         QuestProgressTitleText:SetJustifyH("LEFT")
         QuestInfoXPFrame.ReceiveText:SetText(EXPERIENCE_COLON)
         QuestInfoXPFrame.ReceiveText:SetFont(Original_Font2, 13)
         QuestInfoXPFrame.ReceiveText:SetJustifyH("LEFT")
         QuestInfoRewardsFrame.ItemChooseText:SetText(QTR_quest_EN[QTR_quest_ID].itemchoose)
         QuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_quest_EN[QTR_quest_ID].itemreceive)
         QuestInfoRewardsFrame.ItemChooseText:SetFont(Original_Font2, 13)
         QuestInfoRewardsFrame.ItemReceiveText:SetFont(Original_Font2, 13)
         QuestInfoRewardsFrame.ItemChooseText:SetJustifyH("LEFT")
         QuestInfoRewardsFrame.ItemReceiveText:SetJustifyH("LEFT")
         if QTR_QuestDetail_ItemReceiveText then QTR_QuestDetail_ItemReceiveText:Hide() end
         if QTR_QuestReward_ItemReceiveText then QTR_QuestReward_ItemReceiveText:Hide() end
         if QTR_QuestDetail_InfoXP then QTR_QuestDetail_InfoXP:Hide() end
         if QTR_QuestReward_InfoXP then QTR_QuestReward_InfoXP:Hide() end

         local rewardHeaders = {
            REWARD_CHOICES = "ItemChooseText",
            REWARD_ITEMS = "ItemReceiveText",
            REWARD_AURA = "rewardAura",
            REWARD_SPELL = "rewardSpell",
            REWARD_COMPANION = "rewardCompanion",
            REWARD_FOLLOWER = "rewardFollower",
            REWARD_REPUTATION = "rewardReputation",
            REWARD_TITLE = "rewardTitle",
            REWARD_TRADESKILL = "rewardTradeskill",
            REWARD_UNLOCK = "rewardUnlock",
            REWARD_BONUS = "rewardBonus"
         }
         for constant, property in pairs(rewardHeaders) do
            if QuestInfoRewardsFrame[property] then
               QuestInfoRewardsFrame[property]:SetText(_G[constant])
               QuestInfoRewardsFrame[property]:SetFont(Original_Font2, 13)
               QuestInfoRewardsFrame[property]:SetJustifyH("LEFT")
            end
         end
         for fontString in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
            for constant, _ in pairs(rewardHeaders) do
               if fontString:GetText() == QTR_Messages[string.lower(constant)] then
                  fontString:SetText(_G[constant])
                  fontString:SetFont(Original_Font2, 13)
                  fontString:SetJustifyH("LEFT")
               end
            end
         end
      end
   else
      if (QTR_curr_trans == "0") then
         if ((ImmersionFrame ~= nil ) and (ImmersionFrame.TalkBox:IsVisible() )) then
            if (not WOWTR_wait(0.2,QTR_Immersion_OFF_Static)) then end
         end
      end
   end
end

-- Back-compat global wrappers to ensure monolith calls delegate to module
function QTR_Translate_On(typ, event) return Quests.Details.TranslateOn(typ, event) end
function QTR_Translate_Off(typ, event) return Quests.Details.TranslateOff(typ, event) end
function QTR_display_constants(lg) return Quests.Details.DisplayConstants(lg) end

-- Prepare quest data and switch translated view on
function Quests.Details.QuestPrepare(event)
  QTR_PrepareTime = time()
  if QTR_IconAI then QTR_IconAI:Hide() end
  if GoQ_IconAI then GoQ_IconAI:Hide() end

  if isClassicQuestLog and isClassicQuestLog() then
    if (QTR_PS["questlog"] == "0") then
      if QTR_ToggleButton3 then QTR_ToggleButton3:Hide() end
      return
    else
      if QTR_ToggleButton3 then QTR_ToggleButton3:Show() end
      if (ClassicQuestLog and ClassicQuestLog:IsVisible() and (QTR_curr_trans == "0")) then
        QTR_Translate_Off(1)
        return
      end
    end
  end
  if isImmersion and isImmersion() then
    if (ImmersionContentFrame and ImmersionContentFrame:IsVisible() and (QTR_curr_trans == "0")) then
      QTR_Translate_Off(1)
      return
    end
  end

  local q_ID = Quests.GetQuestID and Quests.GetQuestID() or 0
  if (q_ID == 0) then return end
  QTR_quest_ID = q_ID
  local str_ID = tostring(q_ID)

  QTR_quest_EN[QTR_quest_ID] = QTR_quest_EN[QTR_quest_ID] or {}
  QTR_quest_LG[QTR_quest_ID] = QTR_quest_LG[QTR_quest_ID] or {}

  if QTR_ToggleButton0 then QTR_ToggleButton0:SetWidth(150); QTR_ToggleButton0:SetScript("OnClick", QTR_ON_OFF) end

  if (QTR_PS["active"] == "1") then
    if QTR_ToggleButton0 then QTR_ToggleButton0:Enable() end
    if QTR_ToggleButton1 then QTR_ToggleButton1:Enable() end
    if QTR_ToggleButton2 then QTR_ToggleButton2:Enable() end
    if isImmersion and isImmersion() and QTR_ToggleButton4 then QTR_ToggleButton4:Enable() end
    if isStoryline and isStoryline() and QTR_ToggleButton5 then QTR_ToggleButton5:Enable() end
    if IsDUIQuestFrame and IsDUIQuestFrame() and QTR_ToggleButton7 then QTR_ToggleButton7:Enable() end

    -- Model text capture for translation (stored to GS tables for later use)
    if (QuestNPCModelText and QuestNPCModelText:IsVisible()) then
      local text = QuestNPCModelText:GetText()
      if (text and not string.find(text, NONBREAKINGSPACE)) then
        QTR_ModelTextHash = StringHash(text)
        if GS_Gossip and GS_Gossip[QTR_ModelTextHash] then
          QTR_ModelText_EN = text
          QTR_ModelText_PL = GS_Gossip[QTR_ModelTextHash]
        else
          local map = C_Map.GetBestMapForUnit and (C_Map.GetBestMapForUnit("player") or 0) or 0
          local npcName = (QuestNPCModelNameText and QuestNPCModelNameText:GetText()) or "Unknown Monster"
          QTR_GOSSIP[npcName.."@"..tostring(QTR_ModelTextHash).."@"..tostring(map)] = text.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class
          QTR_ModelTextHash = 0
        end
      end
    end

    QTR_curr_trans = "1"
    QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose0
    QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv0

    if (QTR_QuestData and QTR_QuestData[str_ID]) then
      if (not QTR_quest_EN[QTR_quest_ID].title) then
        QTR_quest_LG[QTR_quest_ID].title = QTR_QuestData[str_ID]["Title"]
        QTR_quest_EN[QTR_quest_ID].title = GetTitleText() ~= "" and GetTitleText() or (QuestInfoTitleHeader and QuestInfoTitleHeader:GetText())
      end
      if (not QTR_quest_LG[QTR_quest_ID].details) then
        QTR_quest_LG[QTR_quest_ID].details = QTR_QuestData[str_ID]["Description"]
        QTR_quest_LG[QTR_quest_ID].objectives = QTR_QuestData[str_ID]["Objectives"]
      end

      if (event == "QUEST_DETAIL") then
        if (not QTR_quest_EN[QTR_quest_ID].details) then
          QTR_quest_EN[QTR_quest_ID].details = GetQuestText()
          QTR_quest_EN[QTR_quest_ID].objectives = GetObjectiveText()
        end
        quest_numReward[str_ID] = GetNumQuestChoices()
        if (quest_numReward[str_ID] and quest_numReward[str_ID] > 1) then
          QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose1
          QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose1
        else
          QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose0
          QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose0
        end
        if (quest_numReward[str_ID] and quest_numReward[str_ID] > 0) then
          QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv1
          QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv1
        else
          QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv0
          QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv0
        end
        if (QTR_quest_EN[QTR_quest_ID].details and QTR_quest_LG[QTR_quest_ID].details == "") then
          QTR_MISSING[QTR_quest_ID.." DESCRIPTION"] = WOWTR_DetectAndReplacePlayerName(QTR_quest_EN[QTR_quest_ID].details)
        end
        if (QTR_quest_LG[QTR_quest_ID].details == "") then
          QTR_quest_LG[QTR_quest_ID].details = QTR_quest_EN[QTR_quest_ID].details
        end
        if (QTR_quest_EN[QTR_quest_ID].objectives and QTR_quest_LG[QTR_quest_ID].objectives == "") then
          QTR_MISSING[QTR_quest_ID.." OBJECTIVE"] = WOWTR_DetectAndReplacePlayerName(QTR_quest_EN[QTR_quest_ID].objectives)
        end
        if (QTR_quest_LG[QTR_quest_ID].objectives == "") then
          QTR_quest_LG[QTR_quest_ID].objectives = QTR_quest_EN[QTR_quest_ID].objectives
        end
      else
        if (not QTR_quest_EN[QTR_quest_ID].details and QuestInfoDescriptionText) then
          QTR_quest_EN[QTR_quest_ID].details = QuestInfoDescriptionText:GetText()
        end
        if (not QTR_quest_EN[QTR_quest_ID].objectives and QuestInfoObjectivesText) then
          QTR_quest_EN[QTR_quest_ID].objectives = QuestInfoObjectivesText:GetText()
        end
        if (not quest_numReward[str_ID]) then
          QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose0
          QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose0
          if (MapQuestInfoRewardsFrame and MapQuestInfoRewardsFrame.ItemChooseText and MapQuestInfoRewardsFrame.ItemChooseText:IsVisible()) then
            QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv1
            QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv1
          else
            QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv0
            QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv0
          end
        else
          if (quest_numReward[str_ID] > 1) then
            QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose1
            QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose1
          else
            QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose0
            QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose0
          end
          if (quest_numReward[str_ID] > 0) then
            QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv1
            QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv1
          else
            QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv0
            QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv0
          end
        end
      end

      if (event == "QUEST_PROGRESS") then
        if (not QTR_quest_EN[QTR_quest_ID].progress) then
          QTR_quest_EN[QTR_quest_ID].progress = GetProgressText()
          QTR_quest_LG[QTR_quest_ID].progress = QTR_QuestData[str_ID]["Progress"]
        end
        if (QTR_quest_EN[QTR_quest_ID].progress and QTR_quest_LG[QTR_quest_ID].progress == "") then
          QTR_MISSING[QTR_quest_ID.." PROGRESS"] = WOWTR_DetectAndReplacePlayerName(QTR_quest_EN[QTR_quest_ID].progress)
        end
        if (QTR_quest_LG[QTR_quest_ID].progress == "") then
          QTR_quest_LG[QTR_quest_ID].progress = QTR_quest_EN[QTR_quest_ID].progress
        end
      end
      if (event == "QUEST_COMPLETE") then
        if (not QTR_quest_EN[QTR_quest_ID].completion) then
          QTR_quest_EN[QTR_quest_ID].completion = GetRewardText()
          QTR_quest_LG[QTR_quest_ID].completion = QTR_QuestData[str_ID]["Completion"]
        end
        if (not quest_numReward[str_ID]) then quest_numReward[str_ID] = GetNumQuestChoices() end
        if (quest_numReward[str_ID] > 1) then
          QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose2
          QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose2
        else
          QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose3
          QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose3
        end
        if (quest_numReward[str_ID] > 0) then
          QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv3
          QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv3
        else
          QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv2
          QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv2
        end
        if (QTR_quest_EN[QTR_quest_ID].completion and QTR_quest_LG[QTR_quest_ID].completion == "") then
          QTR_MISSING[QTR_quest_ID.." COMPLETE"] = WOWTR_DetectAndReplacePlayerName(QTR_quest_EN[QTR_quest_ID].completion)
        end
        if (QTR_quest_LG[QTR_quest_ID].completion == "") then
          QTR_quest_LG[QTR_quest_ID].completion = QTR_quest_EN[QTR_quest_ID].completion
        end
      end

      if QTR_ToggleButton0 then QTR_ToggleButton0:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")") end
      if QTR_ToggleButton1 then QTR_ToggleButton1:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")") end
      if QTR_ToggleButton2 then QTR_ToggleButton2:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")") end
      if (isImmersion and isImmersion() and QTR_ToggleButton4) then QTR_ToggleButton4:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")") end
      if (isStoryline and isStoryline() and Storyline_NPCFrame and Storyline_NPCFrame:IsVisible() and QTR_ToggleButton5) then QTR_ToggleButton5:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")") end

      QTR_Translate_On(1, event)
      if (QTR_PS["en_first"] == "1") then QTR_ON_OFF() end
    else
      -- No translation data available; leave view as EN but keep toggles consistent
      QTR_Translate_Off(1, event)
      QTR_SaveQuest(event)
    end

    if (IsDUIQuestFrame and IsDUIQuestFrame()) then
      QTR_DUIQuestFrame(event)
      if (QTR_PS["en_first"] == "1") then DUI_ON_OFF() end
    end
  else
    if (QTR_curr_trans == "1") then
      if (ImmersionFrame and ImmersionFrame.TalkBox and ImmersionFrame.TalkBox:IsVisible()) then
        if (not WOWTR_wait(0.2, QTR_Immersion_Static)) then end
      end
    end
  end
end

-- Apply/reset constant labels and headers in quest UI
function Quests.Details.DisplayConstants(lg)
  local str_ID = QTR_quest_ID and tostring(QTR_quest_ID) or nil
  local questDataExists = str_ID and QTR_QuestData and QTR_QuestData[str_ID]
  local questLGData = questDataExists and QTR_quest_LG and QTR_quest_LG[QTR_quest_ID]

  if lg == 1 then
    local isRTL = Quests.Utils and Quests.Utils.IsRTL and Quests.Utils.IsRTL() or false
    local WOW_width = WorldMapFrame and WorldMapFrame:IsVisible() and 245 or 265
    local elvuiFontSize = C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18

    if QuestInfoObjectivesHeader then
      QuestInfoObjectivesHeader:SetWidth(WOW_width+10)
      QuestInfoObjectivesHeader:SetFont(WOWTR_Font1, elvuiFontSize)
      QuestInfoObjectivesHeader:SetText(QTR_ExpandUnitInfo(QTR_Messages.objectives,false,QuestInfoObjectivesHeader,WOWTR_Font1,-10))
      Quests.Utils.IsRTL() and QuestInfoObjectivesHeader:SetJustifyH("RIGHT") or QuestInfoObjectivesHeader:SetJustifyH("LEFT")
    end
    if QuestInfoDescriptionHeader then
      QuestInfoDescriptionHeader:SetWidth(WOW_width+40)
      QuestInfoDescriptionHeader:SetFont(WOWTR_Font1, elvuiFontSize)
      QuestInfoDescriptionHeader:SetText(QTR_ExpandUnitInfo(QTR_Messages.details,false,QuestInfoDescriptionHeader,WOWTR_Font1,-10))
      Quests.Utils.IsRTL() and QuestInfoDescriptionHeader:SetJustifyH("RIGHT") or QuestInfoDescriptionHeader:SetJustifyH("LEFT")
    end
    if QuestInfoRewardsFrame and QuestInfoRewardsFrame.Header then
      QuestInfoRewardsFrame.Header:SetWidth(WOW_width+10)
      QuestInfoRewardsFrame.Header:SetFont(WOWTR_Font1, elvuiFontSize)
      QuestInfoRewardsFrame.Header:SetText(QTR_ExpandUnitInfo(QTR_Messages.rewards,false,QuestInfoRewardsFrame.Header,WOWTR_Font1,-12))
      Quests.Utils.IsRTL() and QuestInfoRewardsFrame.Header:SetJustifyH("RIGHT") or QuestInfoRewardsFrame.Header:SetJustifyH("LEFT")
    end
    if QuestProgressRequiredItemsText then
      QuestProgressRequiredItemsText:SetWidth(WOW_width+7)
      QuestProgressRequiredItemsText:SetFont(WOWTR_Font1, elvuiFontSize)
      QuestProgressRequiredItemsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.reqitems,false,QuestProgressRequiredItemsText,WOWTR_Font1,-10))
      Quests.Utils.IsRTL() and QuestProgressRequiredItemsText:SetJustifyH("RIGHT") or QuestProgressRequiredItemsText:SetJustifyH("LEFT")
    end
    if CurrentQuestsText then
      CurrentQuestsText:SetFont(WOWTR_Font1, elvuiFontSize)
      CurrentQuestsText:SetWidth(WOW_width)
      CurrentQuestsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.currquests,false,CurrentQuestsText,WOWTR_Font1,-30))
      Quests.Utils.IsRTL() and CurrentQuestsText:SetJustifyH("RIGHT") or CurrentQuestsText:SetJustifyH("LEFT")
    end
    if AvailableQuestsText then
      AvailableQuestsText:SetFont(WOWTR_Font1, elvuiFontSize)
      AvailableQuestsText:SetText(QTR_ReverseIfAR(QTR_Messages.avaiquests))
      AvailableQuestsText:SetWidth(WOW_width)
      Quests.Utils.IsRTL() and AvailableQuestsText:SetJustifyH("RIGHT") or AvailableQuestsText:SetJustifyH("LEFT")
    end
  else
    -- Reset to original Blizzard constants
    if QuestInfoObjectivesHeader then
      QuestInfoObjectivesHeader:SetFont(Original_Font1, 18)
      QuestInfoObjectivesHeader:SetText(QTR_MessOrig.objectives)
      QuestInfoObjectivesHeader:SetJustifyH("LEFT")
    end
    if QuestInfoDescriptionHeader then
      QuestInfoDescriptionHeader:SetFont(Original_Font1, 18)
      QuestInfoDescriptionHeader:SetText(QTR_MessOrig.details)
      QuestInfoDescriptionHeader:SetJustifyH("LEFT")
    end
    if QuestInfoRewardsFrame and QuestInfoRewardsFrame.Header then
      QuestInfoRewardsFrame.Header:SetFont(Original_Font1, 18)
      QuestInfoRewardsFrame.Header:SetText(QTR_MessOrig.rewards)
      QuestInfoRewardsFrame.Header:SetJustifyH("LEFT")
    end
    if QuestProgressRequiredItemsText then
      QuestProgressRequiredItemsText:SetFont(Original_Font1, 18)
      QuestProgressRequiredItemsText:SetText(QTR_MessOrig.reqitems)
      QuestProgressRequiredItemsText:SetJustifyH("LEFT")
    end
    if CurrentQuestsText then
      CurrentQuestsText:SetFont(Original_Font1, 18)
      CurrentQuestsText:SetText(QTR_MessOrig.currquests)
      CurrentQuestsText:SetJustifyH("LEFT")
    end
    if AvailableQuestsText then
      AvailableQuestsText:SetFont(Original_Font1, 18)
      AvailableQuestsText:SetText(QTR_MessOrig.avaiquests)
      AvailableQuestsText:SetJustifyH("LEFT")
    end
  end
end

-- Popup quest details show handler
function QTR_QuestLogPopupShow()
  if (QuestLogPopupDetailFrame and QuestLogPopupDetailFrame:IsVisible()) then
    return Quests.Details.QuestPrepare("QUEST_DETAIL")
  end
end

function Quests.Details.QuestPrepare(event)
   if QTR_QuestPrepare_Impl then return QTR_QuestPrepare_Impl(event) end
end

function Quests.Details.QuestLogPopupShow()
   if QTR_QuestLogPopupShow then return QTR_QuestLogPopupShow() end
end

function Quests.Details.PrepareReload()
   if QTR_PrepareReload then return QTR_PrepareReload() end
end

function Quests.Details.DisplayConstants(lg)
   local str_ID = QTR_quest_ID and tostring(QTR_quest_ID) or nil
   local questDataExists = str_ID and QTR_QuestData and QTR_QuestData[str_ID]
   local questLGData = questDataExists and QTR_quest_LG and QTR_quest_LG[QTR_quest_ID]

   if lg == 1 then
        local isArabic = (Quests.Utils and Quests.Utils.IsRTL and Quests.Utils.IsRTL()) or false
        local WOW_width = 265
        if (WorldMapFrame:IsVisible()) then WOW_width = 245 end

        local elvuiFontSize = C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18

        QuestInfoObjectivesHeader:SetWidth(WOW_width+10)
        QuestInfoObjectivesHeader:SetFont(WOWTR_Font1, elvuiFontSize)
        QuestInfoObjectivesHeader:SetText(QTR_ExpandUnitInfo(QTR_Messages.objectives,false,QuestInfoObjectivesHeader,WOWTR_Font1,-10))
        if isArabic then QuestInfoObjectivesHeader:SetJustifyH("RIGHT") else QuestInfoObjectivesHeader:SetJustifyH("LEFT") end

        QuestInfoDescriptionHeader:SetWidth(WOW_width+40)
        QuestInfoDescriptionHeader:SetFont(WOWTR_Font1, elvuiFontSize)
        QuestInfoDescriptionHeader:SetText(QTR_ExpandUnitInfo(QTR_Messages.details,false,QuestInfoDescriptionHeader,WOWTR_Font1,-10))
        if isArabic then QuestInfoDescriptionHeader:SetJustifyH("RIGHT") else QuestInfoDescriptionHeader:SetJustifyH("LEFT") end

        QuestInfoRewardsFrame.Header:SetWidth(WOW_width+10)
        QuestInfoRewardsFrame.Header:SetFont(WOWTR_Font1, elvuiFontSize)
        QuestInfoRewardsFrame.Header:SetText(QTR_ExpandUnitInfo(QTR_Messages.rewards,false,QuestInfoRewardsFrame.Header,WOWTR_Font1,-12))
        if isArabic then QuestInfoRewardsFrame.Header:SetJustifyH("RIGHT") else QuestInfoRewardsFrame.Header:SetJustifyH("LEFT") end

        QuestProgressRequiredItemsText:SetWidth(WOW_width+7)
        QuestProgressRequiredItemsText:SetFont(WOWTR_Font1, elvuiFontSize)
        QuestProgressRequiredItemsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.reqitems,false,QuestProgressRequiredItemsText,WOWTR_Font1,-10))
        if isArabic then QuestProgressRequiredItemsText:SetJustifyH("RIGHT") else QuestProgressRequiredItemsText:SetJustifyH("LEFT") end

        CurrentQuestsText:SetFont(WOWTR_Font1, elvuiFontSize)
        CurrentQuestsText:SetWidth(WOW_width)
        CurrentQuestsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.currquests,false,CurrentQuestsText,WOWTR_Font1,-30))
        if isArabic then CurrentQuestsText:SetJustifyH("RIGHT") else CurrentQuestsText:SetJustifyH("LEFT") end

        AvailableQuestsText:SetFont(WOWTR_Font1, elvuiFontSize)
        AvailableQuestsText:SetText(QTR_ReverseIfAR(QTR_Messages.avaiquests))
        AvailableQuestsText:SetWidth(WOW_width)
        if isArabic then AvailableQuestsText:SetJustifyH("RIGHT") else AvailableQuestsText:SetJustifyH("LEFT") end

        local rewardsFrame = QuestMapFrame.DetailsFrame.RewardsFrameContainer and QuestMapFrame.DetailsFrame.RewardsFrameContainer.RewardsFrame
        if rewardsFrame then
            local regions = { rewardsFrame:GetRegions() }
            for index = 1, #regions do
               local region = regions[index]
               if ((region:GetObjectType() == "FontString") and (region:GetText() == QUEST_REWARDS)) then
                  region:SetText(QTR_ReverseIfAR(QTR_Messages.rewards))
                  region:SetFont(WOWTR_Font1, 18)
                  if isArabic then region:SetJustifyH("RIGHT") else region:SetJustifyH("LEFT") end
               end
            end
        end

        if questDataExists and questLGData then
            local itemChooseText = questLGData.itemchoose or QTR_Messages.itemchoose0
            local itemReceiveText = questLGData.itemreceive or QTR_Messages.itemreceiv0

            if isArabic then
               QuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 14)
               QuestInfoRewardsFrame.ItemChooseText:SetWidth(260)
               QuestInfoRewardsFrame.ItemChooseText:SetJustifyH("RIGHT")
               QuestInfoRewardsFrame.ItemChooseText:SetText(AS_UTF8reverse(itemChooseText))

               QuestInfoRewardsFrame.ItemReceiveText:SetText(" ")
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(" ")
               QuestInfoXPFrame.ReceiveText:SetText(" ")

               if (not QTR_QuestDetail_ItemReceiveText) then
                  QTR_QuestDetail_ItemReceiveText = QuestDetailScrollChildFrame:CreateFontString(nil, "ARTWORK")
                  QTR_QuestDetail_ItemReceiveText:SetFontObject(GameFontBlack)
                  QTR_QuestDetail_ItemReceiveText:SetJustifyH("RIGHT")
                  QTR_QuestDetail_ItemReceiveText:SetJustifyV("TOP")
                  QTR_QuestDetail_ItemReceiveText:ClearAllPoints()
                  QTR_QuestDetail_ItemReceiveText:SetPoint("TOPRIGHT", QuestInfoRewardsFrame.ItemReceiveText, "TOPLEFT", 260, 2)
                  QTR_QuestDetail_ItemReceiveText:SetFont(WOWTR_Font2, 13)
               end
               QTR_QuestDetail_ItemReceiveText:SetText(AS_UTF8reverse(itemReceiveText))
               QTR_QuestDetail_ItemReceiveText:Show()

               if (not QTR_QuestReward_ItemReceiveText) then 
                  QTR_QuestReward_ItemReceiveText = QuestRewardScrollChildFrame:CreateFontString(nil, "ARTWORK")
                  QTR_QuestReward_ItemReceiveText:SetFontObject(GameFontBlack)
                  QTR_QuestReward_ItemReceiveText:SetJustifyH("RIGHT")
                  QTR_QuestReward_ItemReceiveText:SetJustifyV("TOP")
                  QTR_QuestReward_ItemReceiveText:ClearAllPoints()
                  QTR_QuestReward_ItemReceiveText:SetPoint("TOPRIGHT", QuestInfoRewardsFrame.ItemReceiveText, "TOPLEFT", 260, 2)
                  QTR_QuestReward_ItemReceiveText:SetFont(WOWTR_Font2, 14)
               end
               QTR_QuestReward_ItemReceiveText:SetText(AS_UTF8reverse(itemReceiveText))
               QTR_QuestReward_ItemReceiveText:Show()

               if (not QTR_QuestDetail_InfoXP) then 
                  QTR_QuestDetail_InfoXP = QuestDetailScrollChildFrame:CreateFontString(nil, "ARTWORK")
                  QTR_QuestDetail_InfoXP:SetFontObject(GameFontBlack)
                  QTR_QuestDetail_InfoXP:SetJustifyH("RIGHT")
                  QTR_QuestDetail_InfoXP:SetJustifyV("TOP")
                  QTR_QuestDetail_InfoXP:ClearAllPoints()
                  QTR_QuestDetail_InfoXP:SetPoint("TOPRIGHT", QuestInfoRewardsFrame.XPFrame.ReceiveText, "TOPLEFT", 260, 2)
                  QTR_QuestDetail_InfoXP:SetFont(WOWTR_Font2, 14)
               end
               QTR_QuestDetail_InfoXP:SetText(AS_UTF8reverse(QTR_Messages.experience))
               QTR_QuestDetail_InfoXP:Show()

               if (not QTR_QuestReward_InfoXP) then 
                  QTR_QuestReward_InfoXP = QuestRewardScrollChildFrame:CreateFontString(nil, "ARTWORK")
                  QTR_QuestReward_InfoXP:SetFontObject(GameFontBlack)
                  QTR_QuestReward_InfoXP:SetJustifyH("RIGHT")
                  QTR_QuestReward_InfoXP:SetJustifyV("TOP")
                  QTR_QuestReward_InfoXP:ClearAllPoints()
                  QTR_QuestReward_InfoXP:SetPoint("TOPRIGHT", QuestInfoRewardsFrame.XPFrame.ReceiveText, "TOPLEFT", 260, 2)
                  QTR_QuestReward_InfoXP:SetFont(WOWTR_Font2, 14)
               end
               QTR_QuestReward_InfoXP:SetText(AS_UTF8reverse(QTR_Messages.experience))
               QTR_QuestReward_InfoXP:Show()

               if (QuestInfoMoneyFrame:IsVisible()) then
                  QuestInfoXPFrame.ValueText:ClearAllPoints()
                  QuestInfoXPFrame.ValueText:SetPoint("TOPRIGHT", QuestInfoMoneyFrame, "BOTTOMRIGHT", -10, 0)
               end

               local max_len = AS_UTF8len(QTR_QuestDetail_ItemReceiveText:GetText())
               local money_len = QuestInfoMoneyFrame:GetWidth()
               local spaces05 = "     "
               local spaces10 = "          "
               local spaces15 = "               "
               local spaces20 = "                    "
               if (max_len < 10) then
                  if (money_len < 70) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces20)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces20)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces20)
                  elseif (money_len < 90) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces15)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces15)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces15)
                  elseif (money_len < 110) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces10)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces10)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces10)
                  elseif (money_len < 130) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces05)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces05)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces05)
                  end
               elseif (max_len < 20) then
                  if (money_len < 70) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces15)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces15)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces15)
                  elseif (money_len < 90) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces10)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces10)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces10)
                  elseif (money_len < 110) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces05)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces05)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces05)
                  end
               elseif (max_len < 30) then
                  if (money_len < 70) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces10)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces10)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces10)
                  elseif (money_len < 90) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces05)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces05)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces05)
                  end
               elseif (max_len < 40) then
                  if (money_len < 70) then
                     QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces05)
                     QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces05)
                     QuestInfoXPFrame.ReceiveText:SetText(spaces05)
                  end
               end
            else
               QuestInfoRewardsFrame.ItemChooseText:SetText(itemChooseText)
               QuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 13)
               QuestInfoRewardsFrame.ItemChooseText:SetJustifyH("LEFT")

               QuestInfoRewardsFrame.ItemReceiveText:SetText(itemReceiveText)
               QuestInfoRewardsFrame.ItemReceiveText:SetFont(WOWTR_Font2, 13)
               QuestInfoRewardsFrame.ItemReceiveText:SetJustifyH("LEFT")

               QuestInfoXPFrame.ReceiveText:SetText(QTR_Messages.experience)
               QuestInfoXPFrame.ReceiveText:SetFont(WOWTR_Font2, 13)
               QuestInfoXPFrame.ReceiveText:SetJustifyH("LEFT")

               if QTR_QuestDetail_ItemReceiveText then QTR_QuestDetail_ItemReceiveText:Hide() end
               if QTR_QuestReward_ItemReceiveText then QTR_QuestReward_ItemReceiveText:Hide() end
               if QTR_QuestDetail_InfoXP then QTR_QuestDetail_InfoXP:Hide() end
               if QTR_QuestReward_InfoXP then QTR_QuestReward_InfoXP:Hide() end
            end
        end

        for fontString in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
           local txt = fontString:GetText()
           if (txt) then
              txt = string.gsub(txt, QTR_MessOrig.reward_aura, QTR_Messages.reward_aura)
              txt = string.gsub(txt, QTR_MessOrig.reward_spell, QTR_Messages.reward_spell)
              txt = string.gsub(txt, QTR_MessOrig.reward_companion, QTR_Messages.reward_companion)
              txt = string.gsub(txt, QTR_MessOrig.reward_follower, QTR_Messages.reward_follower)
              txt = string.gsub(txt, QTR_MessOrig.reward_reputation, QTR_Messages.reward_reputation)
              txt = string.gsub(txt, QTR_MessOrig.reward_title, QTR_Messages.reward_title)
              txt = string.gsub(txt, QTR_MessOrig.reward_tradeskill, QTR_Messages.reward_tradeskill)
              txt = string.gsub(txt, QTR_MessOrig.reward_unlock, QTR_Messages.reward_unlock)
              txt = string.gsub(txt, QTR_MessOrig.reward_bonus, QTR_Messages.reward_bonus)
              fontString:SetText(txt)
              fontString:SetFont(WOWTR_Font2, 13)
              if isArabic then fontString:SetJustifyH("RIGHT") else fontString:SetJustifyH("LEFT") end
           end
        end
   end
end
