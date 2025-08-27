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
         if (WoWTR_Localization.lang == 'AR') then WOW_width = 320 end
         if (QuestInfoRewardsFrame:IsVisible() and WoWTR_Localization.lang ~= 'AR') then WOW_width = 280 end

         if (QTR_PS["transtitle"] == "1") then
            QuestInfoTitleHeader:SetWidth(WOW_width)
            QuestProgressTitleText:SetWidth(WOW_width)
            QuestInfoTitleHeader:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18)
            QuestProgressTitleText:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18)
            if (WorldMapFrame:IsVisible()) then
               if (WoWTR_Localization.lang == 'AR') then
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50, "RIGHT"))
               else
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50))
               end
            else
               if (WoWTR_Localization.lang == 'AR') then
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50, "RIGHT"))
               else
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50))
               end
            end
            if (WoWTR_Localization.lang == 'AR') then
               QuestProgressTitleText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestProgressTitleText, WOWTR_Font1, -50, "RIGHT"))
            else
               QuestProgressTitleText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestProgressTitleText, WOWTR_Font1, -50))
            end
         end

         if (WoWTR_Localization.lang == 'AR') then
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
         if (WoWTR_Localization.lang == 'AR') then QuestInfoDescriptionText:SetJustifyH("RIGHT") else QuestInfoDescriptionText:SetJustifyH("LEFT") end
         QuestInfoObjectivesText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].objectives,true,QuestInfoObjectivesText,WOWTR_Font2,-10))
         if (WoWTR_Localization.lang == 'AR') then QuestInfoObjectivesText:SetJustifyH("RIGHT") else QuestInfoObjectivesText:SetJustifyH("LEFT") end
         QuestProgressText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].progress,false,QuestProgressText,WOWTR_Font2))
         if (WoWTR_Localization.lang == 'AR') then QuestProgressText:SetJustifyH("RIGHT") else QuestProgressText:SetJustifyH("LEFT") end
         if (WoWTR_Localization.lang == 'AR') then
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
        local isArabic = (WoWTR_Localization.lang == 'AR')
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
