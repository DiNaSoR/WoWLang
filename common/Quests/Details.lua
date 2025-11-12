-- Quests/Details.lua
-- Facade for quest detail handling and translate on/off

local addonName, ns = ...
ns = ns or {}
ns.Quests = ns.Quests or {}
local Quests = ns.Quests

Quests.Details = Quests.Details or {}
-- Debounce state for rapid QuestPrepare calls from QuestMapFrame_ShowQuestDetails
local _lastPrepareQuestID = 0
local _lastPrepareAt = 0
local _postLayoutTicker

local function CancelPostLayoutTicker()
  if _postLayoutTicker then
    _postLayoutTicker:Cancel()
    _postLayoutTicker = nil
  end
end

function Quests.Details.SchedulePostLayoutRefresh()
  CancelPostLayoutTicker()
  if not (QuestMapFrame and QuestMapFrame:IsVisible()) then return end
  -- Don't schedule if we just processed this quest (avoid redundant refreshes)
  if QTR_quest_ID > 0 then
    local now = GetTime()
    if _lastProcessedQuestID == QTR_quest_ID and (now - _lastProcessedQuestTime) < 0.2 then
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "SchedulePostLayoutRefresh: Just processed quest", QTR_quest_ID, ", skipping post-layout refresh")
      end
      return
    end
  end
  local runs = 0
  _postLayoutTicker = C_Timer.NewTicker(0.08, function()
    runs = runs + 1
    if QTR_curr_trans == "1" then
      -- Pass "__post__" event to prevent duplicate processing
      QTR_Translate_On(1, "__post__")
    end
    local shouldStop = (runs >= 4) or not (QuestMapFrame and QuestMapFrame:IsVisible()) or (QTR_curr_trans ~= "1")
    if shouldStop then
      CancelPostLayoutTicker()
    end
  end)
end

function Quests.Details.CancelPostLayoutRefresh()
  CancelPostLayoutTicker()
end

-- Display translation
function Quests.Details.TranslateOn(typ,event)
   -- Skip if we just processed this quest recently (avoid duplicate processing)
   if event == "__post__" and QTR_quest_ID > 0 then
      local now = GetTime()
      if _lastProcessedQuestID == QTR_quest_ID and (now - _lastProcessedQuestTime) < 0.3 then
         if WOWTR and WOWTR.Debug then
           WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Already processed quest", QTR_quest_ID, "recently (__post__), skipping to avoid duplicate")
         end
         return
      end
   end
   
   if WOWTR and WOWTR.Debug then
     WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn called with typ:", typ, "event:", event or "nil")
     WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QTR_quest_ID:", QTR_quest_ID)
   end
   QTR_display_constants(1)
   QTR_curr_trans = "1"
   if (QuestNPCModelText:IsVisible() and (QTR_ModelTextHash>0)) then
      QuestNPCModelText:SetText(QTR_ExpandUnitInfo(QTR_ModelText_PL..NONBREAKINGSPACE,false,QuestNPCModelText,WOWTR_Font2,-15))
      QuestNPCModelText:SetFont(WOWTR_Font2, 13)
   end

   if (typ==1) then
      local numer_ID = QTR_quest_ID
      str_ID = tostring(numer_ID)
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Checking quest data for ID:", str_ID)
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QTR_QuestData[str_ID] exists:", QTR_QuestData and QTR_QuestData[str_ID] ~= nil)
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QTR_quest_EN[numer_ID] exists:", QTR_quest_EN and QTR_quest_EN[numer_ID] ~= nil)
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QTR_quest_LG[numer_ID] exists:", QTR_quest_LG and QTR_quest_LG[numer_ID] ~= nil)
      end
      
      if (numer_ID>0 and QTR_QuestData[str_ID]) then
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Quest data found, setting button text...")
        end
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
         local storylineFrame = GetStorylineFrame()
         if (isStoryline() and storylineFrame and storylineFrame:IsVisible()) then
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
         
         if WOWTR and WOWTR.Debug then
           WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: About to set quest text...")
           WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QTR_quest_LG[numer_ID].details:", QTR_quest_LG[numer_ID] and QTR_quest_LG[numer_ID].details and string.len(QTR_quest_LG[numer_ID].details) or "nil", "chars")
           WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QTR_quest_LG[numer_ID].objectives:", QTR_quest_LG[numer_ID] and QTR_quest_LG[numer_ID].objectives and string.len(QTR_quest_LG[numer_ID].objectives) or "nil", "chars")
           WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoDescriptionText exists:", QuestInfoDescriptionText ~= nil)
           WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoObjectivesText exists:", QuestInfoObjectivesText ~= nil)
         end
         
         -- Check which panels are visible
         if QuestFrame then
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestFrame visible:", QuestFrame:IsVisible())
              if QuestFrame.DetailPanel then
                WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestFrame.DetailPanel visible:", QuestFrame.DetailPanel:IsVisible())
              end
              if QuestFrame.ProgressPanel then
                WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestFrame.ProgressPanel visible:", QuestFrame.ProgressPanel:IsVisible())
              end
              if QuestFrame.RewardPanel then
                WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestFrame.RewardPanel visible:", QuestFrame.RewardPanel:IsVisible())
              end
            else
              WOWTR.DebugPrint("TranslateOn: QuestFrame visible:", QuestFrame:IsVisible())
              if QuestFrame.DetailPanel then
                WOWTR.DebugPrint("TranslateOn: QuestFrame.DetailPanel visible:", QuestFrame.DetailPanel:IsVisible())
              end
              if QuestFrame.ProgressPanel then
                WOWTR.DebugPrint("TranslateOn: QuestFrame.ProgressPanel visible:", QuestFrame.ProgressPanel:IsVisible())
              end
              if QuestFrame.RewardPanel then
                WOWTR.DebugPrint("TranslateOn: QuestFrame.RewardPanel visible:", QuestFrame.RewardPanel:IsVisible())
              end
            end
         end
         
         -- Check if text fields are visible and show them if needed
         if QuestInfoDescriptionText then
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoDescriptionText visible:", QuestInfoDescriptionText:IsVisible())
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoDescriptionText parent visible:", QuestInfoDescriptionText:GetParent() and QuestInfoDescriptionText:GetParent():IsVisible())
            else
              WOWTR.DebugPrint("TranslateOn: QuestInfoDescriptionText visible:", QuestInfoDescriptionText:IsVisible())
              WOWTR.DebugPrint("TranslateOn: QuestInfoDescriptionText parent visible:", QuestInfoDescriptionText:GetParent() and QuestInfoDescriptionText:GetParent():IsVisible())
            end
            local currentText = QuestInfoDescriptionText:GetText()
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoDescriptionText current text length:", currentText and string.len(currentText) or 0)
            else
              WOWTR.DebugPrint("TranslateOn: QuestInfoDescriptionText current text length:", currentText and string.len(currentText) or 0)
            end
            
            -- If text field is hidden, try to show it and its parent
            if not QuestInfoDescriptionText:IsVisible() then
               if WOWTR and WOWTR.Debug then
                 WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoDescriptionText is hidden, attempting to show...")
               else
                 WOWTR.DebugPrint("TranslateOn: QuestInfoDescriptionText is hidden, attempting to show...")
               end
               if QuestInfoDescriptionText.Show then QuestInfoDescriptionText:Show() end
               local parent = QuestInfoDescriptionText:GetParent()
               if parent and parent.Show and not parent:IsVisible() then
                  parent:Show()
                  if WOWTR and WOWTR.Debug then
                    WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Showed parent of QuestInfoDescriptionText")
                  else
                    WOWTR.DebugPrint("TranslateOn: Showed parent of QuestInfoDescriptionText")
                  end
               end
               -- Try showing DetailPanel if it exists
               if QuestFrame and QuestFrame.DetailPanel and QuestFrame.DetailPanel.Show then
                  QuestFrame.DetailPanel:Show()
                  if WOWTR and WOWTR.Debug then
                    WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Showed QuestFrame.DetailPanel")
                  else
                    WOWTR.DebugPrint("TranslateOn: Showed QuestFrame.DetailPanel")
                  end
               end
            end
         end
         if QuestInfoObjectivesText then
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoObjectivesText visible:", QuestInfoObjectivesText:IsVisible())
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoObjectivesText parent visible:", QuestInfoObjectivesText:GetParent() and QuestInfoObjectivesText:GetParent():IsVisible())
            else
              WOWTR.DebugPrint("TranslateOn: QuestInfoObjectivesText visible:", QuestInfoObjectivesText:IsVisible())
              WOWTR.DebugPrint("TranslateOn: QuestInfoObjectivesText parent visible:", QuestInfoObjectivesText:GetParent() and QuestInfoObjectivesText:GetParent():IsVisible())
            end
            local currentText = QuestInfoObjectivesText:GetText()
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoObjectivesText current text length:", currentText and string.len(currentText) or 0)
            else
              WOWTR.DebugPrint("TranslateOn: QuestInfoObjectivesText current text length:", currentText and string.len(currentText) or 0)
            end
            
            -- If text field is hidden, try to show it
            if not QuestInfoObjectivesText:IsVisible() then
               if WOWTR and WOWTR.Debug then
                 WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoObjectivesText is hidden, attempting to show...")
               else
                 WOWTR.DebugPrint("TranslateOn: QuestInfoObjectivesText is hidden, attempting to show...")
               end
               if QuestInfoObjectivesText.Show then QuestInfoObjectivesText:Show() end
               local parent = QuestInfoObjectivesText:GetParent()
               if parent and parent.Show and not parent:IsVisible() then
                  parent:Show()
                  if WOWTR and WOWTR.Debug then
                    WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Showed parent of QuestInfoObjectivesText")
                  else
                    WOWTR.DebugPrint("TranslateOn: Showed parent of QuestInfoObjectivesText")
                  end
               end
            end
         end
         
         -- Set the text immediately (Blizzard should have finished by now)
         -- Ensure text fields are visible before setting text
         if QuestInfoDescriptionText and not QuestInfoDescriptionText:IsVisible() then
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoDescriptionText is hidden, showing it...")
            else
              WOWTR.DebugPrint("TranslateOn: QuestInfoDescriptionText is hidden, showing it...")
            end
            if QuestInfoDescriptionText.Show then QuestInfoDescriptionText:Show() end
            local parent = QuestInfoDescriptionText:GetParent()
            if parent and parent.Show then parent:Show() end
            -- Try showing DetailPanel if it exists
            if QuestFrame and QuestFrame.DetailPanel and QuestFrame.DetailPanel.Show then
               QuestFrame.DetailPanel:Show()
            end
         end
         if QuestInfoObjectivesText and not QuestInfoObjectivesText:IsVisible() then
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: QuestInfoObjectivesText is hidden, showing it...")
            else
              WOWTR.DebugPrint("TranslateOn: QuestInfoObjectivesText is hidden, showing it...")
            end
            if QuestInfoObjectivesText.Show then QuestInfoObjectivesText:Show() end
            local parent = QuestInfoObjectivesText:GetParent()
            if parent and parent.Show then parent:Show() end
         end
         
         if QuestInfoDescriptionText and QTR_quest_LG[QTR_quest_ID] and QTR_quest_LG[QTR_quest_ID].details then
            QuestInfoDescriptionText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].details, false, QuestInfoDescriptionText, WOWTR_Font2, -5))
            if rtl then QuestInfoDescriptionText:SetJustifyH("RIGHT") else QuestInfoDescriptionText:SetJustifyH("LEFT") end
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Description text set")
            else
              WOWTR.DebugPrint("TranslateOn: Description text set")
            end
         end
         if QuestInfoObjectivesText and QTR_quest_LG[QTR_quest_ID] and QTR_quest_LG[QTR_quest_ID].objectives then
            QuestInfoObjectivesText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].objectives,true,QuestInfoObjectivesText,WOWTR_Font2,-10))
            if rtl then QuestInfoObjectivesText:SetJustifyH("RIGHT") else QuestInfoObjectivesText:SetJustifyH("LEFT") end
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Objectives text set")
            else
              WOWTR.DebugPrint("TranslateOn: Objectives text set")
            end
         end
         if QuestProgressText and QTR_quest_LG[QTR_quest_ID] and QTR_quest_LG[QTR_quest_ID].progress then
            QuestProgressText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].progress,false,QuestProgressText,WOWTR_Font2))
            if rtl then QuestProgressText:SetJustifyH("RIGHT") else QuestProgressText:SetJustifyH("LEFT") end
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Progress text set")
            else
              WOWTR.DebugPrint("TranslateOn: Progress text set")
            end
         end
         if QuestInfoRewardText and QTR_quest_LG[QTR_quest_ID] and QTR_quest_LG[QTR_quest_ID].completion then
            if rtl then
               QuestInfoRewardText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].completion,false,QuestInfoRewardText,WOWTR_Font2,-5,"RIGHT"))
            else
               QuestInfoRewardText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].completion,false,QuestInfoRewardText,WOWTR_Font2,-5))
            end
            if WOWTR and WOWTR.Debug then
              WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: Reward text set")
            else
              WOWTR.DebugPrint("TranslateOn: Reward text set")
            end
         end
         if WOWTR and WOWTR.Debug then
           WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "TranslateOn: All quest text set successfully")
         else
           WOWTR.DebugPrint("TranslateOn: All quest text set successfully")
         end
         
         -- Set fonts immediately (these shouldn't conflict)
         QuestInfoDescriptionText:SetFont(WOWTR_Font2, sz)
         QuestInfoObjectivesText:SetFont(WOWTR_Font2, sz)
         QuestProgressText:SetFont(WOWTR_Font2, sz)
         QuestInfoRewardText:SetFont(WOWTR_Font2, sz)
      end
      if (IsDUIQuestFrame()) then
         QTR_DUIQuestFrame(event)
         if ( QTR_PS["en_first"]=="1" ) then DUI_ON_OFF() end
      end
   else
      if (QTR_curr_trans == "1") then
         local immersionFrame = GetImmersionFrame()
         if (immersionFrame and immersionFrame.TalkBox and immersionFrame.TalkBox:IsVisible()) then
            if (not WOWTR_wait(0.2,QTR_Immersion_Static)) then end
         end
      end
   end
   if event ~= "__post__" then
      Quests.Details.SchedulePostLayoutRefresh()
   end
end

-- Display original English text
function Quests.Details.TranslateOff(typ,event)
   Quests.Details.CancelPostLayoutRefresh()
   QTR_display_constants(0)
   QTR_curr_trans = "0"
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
            local immersionFrame = GetImmersionFrame()
            if immersionFrame and immersionFrame.TalkBox and immersionFrame.TalkBox.TextFrame and immersionFrame.TalkBox.TextFrame.Text and immersionFrame.TalkBox.TextFrame.Text.RepeatTexts then
              immersionFrame.TalkBox.TextFrame.Text:RepeatTexts()
            end
         end
         local storylineFrame = GetStorylineFrame()
         if (isStoryline() and storylineFrame and storylineFrame:IsVisible()) then
            QTR_ToggleButton5:SetText("QID="..QTR_quest_ID.." (EN)")
            QTR_Storyline_OFF(1)
         end
         local WOW_width = 280
         if (QuestInfoRewardsFrame:IsVisible()) then WOW_width = 280 end
         if QuestInfoDescriptionHeader then
           QuestInfoDescriptionHeader:SetWidth(WOW_width + 40)
           QuestInfoDescriptionHeader:SetFont(Original_Font1, 18)
           QuestInfoDescriptionHeader:SetText(QTR_MessOrig.details)
           QuestInfoDescriptionHeader:SetJustifyH("LEFT")
         end
         if QuestInfoObjectivesHeader then
           QuestInfoObjectivesHeader:SetWidth(WOW_width + 10)
           QuestInfoObjectivesHeader:SetFont(Original_Font1, 18)
           QuestInfoObjectivesHeader:SetText(QTR_MessOrig.objectives)
           QuestInfoObjectivesHeader:SetJustifyH("LEFT")
         end
         if QuestInfoRewardsFrame and QuestInfoRewardsFrame.Header then
           QuestInfoRewardsFrame.Header:SetWidth(WOW_width + 10)
           QuestInfoRewardsFrame.Header:SetFont(Original_Font1, 18)
           QuestInfoRewardsFrame.Header:SetText(QTR_MessOrig.rewards)
           QuestInfoRewardsFrame.Header:SetJustifyH("LEFT")
         end
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
function QTR_QuestPrepare(event) return Quests.Details.QuestPrepare(event) end
function QTR_PrepareReload() return Quests.Details.QuestPrepare() end

-- Prepare quest data and switch translated view on
function Quests.Details.QuestPrepare(event)
  local startTime = GetTime()
  if WOWTR and WOWTR.Debug then
    WOWTR.Debug.Enter("QuestPrepare", WOWTR.Debug.Categories.QUESTS, "Event:", event or "nil", "| Time:", startTime)
  end
  QTR_PrepareTime = time()
  if QTR_IconAI then QTR_IconAI:Hide() end
  if GoQ_IconAI then GoQ_IconAI:Hide() end

  local q_ID = Quests.GetQuestID and Quests.GetQuestID() or 0
  if WOWTR and WOWTR.Debug then
    WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "Quest ID:", q_ID, "| Active frames:", 
      (QuestFrame and QuestFrame:IsVisible() and "QuestFrame") or 
      (QuestLogPopupDetailFrame and QuestLogPopupDetailFrame:IsVisible() and "QuestLogPopup") or
      (QuestMapFrame and QuestMapFrame:IsVisible() and "QuestMapFrame") or "None")
  end
  
  -- Check if we just processed this quest (avoid double processing)
  -- But allow reprocessing if the text isn't actually translated (Blizzard might have overwritten it)
  if q_ID > 0 then
    local now = GetTime()
    if _lastProcessedQuestID == q_ID and (now - _lastProcessedQuestTime) < 0.5 then
      -- Check if text is actually translated - if not, allow reprocessing
      -- But only allow ONE reprocessing attempt to avoid infinite loops
      local isActuallyTranslated = false
      local shouldReprocess = false
      
      if QuestInfoDescriptionText and QuestInfoDescriptionText:IsVisible() then
        local currentText = QuestInfoDescriptionText:GetText() or ""
        local expectedText = QTR_quest_LG[q_ID] and QTR_quest_LG[q_ID].details or ""
        -- If we have translation data and the current text doesn't match the English text, assume it's translated
        if expectedText ~= "" and QTR_quest_EN[q_ID] and QTR_quest_EN[q_ID].details then
          local englishText = QTR_quest_EN[q_ID].details or ""
          local currentLen = string.len(currentText)
          local englishLen = string.len(englishText)
          local translatedLen = string.len(expectedText)
          
          -- If current text is different from English and similar length to translated, assume translated
          if currentText ~= englishText and math.abs(currentLen - translatedLen) < 100 then
            isActuallyTranslated = true
          -- If current text matches English length but we have translation, check if we've already tried reprocessing
          elseif currentLen == englishLen and currentText == englishText then
            -- Check if we've already attempted reprocessing for this quest
            local reprocessKey = "_reprocess_" .. q_ID
            if not _G[reprocessKey] then
              -- First time seeing English text after processing - allow one reprocessing attempt
              _G[reprocessKey] = true
              shouldReprocess = true
            else
              -- Already tried reprocessing, don't allow again (to prevent infinite loop)
              isActuallyTranslated = false -- Treat as translated to stop reprocessing
            end
          end
        end
      end
      
      if isActuallyTranslated then
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "SKIP | Quest", q_ID, "already processed | Text is translated | Time since last:", string.format("%.2f", now - _lastProcessedQuestTime), "s")
        end
        return
      elseif shouldReprocess then
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "REPROCESS | Quest", q_ID, "was processed but text appears untranslated | Allowing ONE reprocessing attempt")
        end
        -- Reset the timestamp so we can process it again, but mark that we've tried reprocessing
        _lastProcessedQuestTime = 0
      else
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "SKIP | Quest", q_ID, "already processed recently | Time since last:", string.format("%.2f", now - _lastProcessedQuestTime), "s")
        end
        return
      end
    end
    -- Mark that we're processing this quest now
    _lastProcessedQuestID = q_ID
    _lastProcessedQuestTime = now
    -- Clear reprocess flag when starting fresh processing
    local reprocessKey = "_reprocess_" .. q_ID
    _G[reprocessKey] = nil
  end
  
  if (q_ID == 0) then 
    if WOWTR and WOWTR.Debug then
      WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "SKIP | Quest ID is 0 (invalid)")
    end
    return 
  end
  
  if isClassicQuestLog and isClassicQuestLog() then
    if (QTR_PS["questlog"] == "0") then
      if QTR_ToggleButton3 then QTR_ToggleButton3:Hide() end
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "SKIP | Classic quest log disabled")
      end
      return
    else
      if QTR_ToggleButton3 then QTR_ToggleButton3:Show() end
      local classicQuestLogFrame = GetClassicQuestLogFrame()
      if (classicQuestLogFrame and classicQuestLogFrame:IsVisible() and (QTR_curr_trans == "0")) then
        QTR_Translate_Off(1)
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "SKIP | Classic quest log | Translate off | QTR_curr_trans:", QTR_curr_trans)
        end
        return
      end
    end
  end
  if isImmersion and isImmersion() then
    local immersionContentFrame = GetImmersionContentFrame()
    if (immersionContentFrame and immersionContentFrame:IsVisible() and (QTR_curr_trans == "0")) then
      QTR_Translate_Off(1)
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "SKIP | Immersion frame | Translate off | QTR_curr_trans:", QTR_curr_trans)
      end
      return
    end
  end
  
  do
    local now = GetTime()
    local isForced = (event == "__force__")
    if (not isForced) and (_lastPrepareQuestID == q_ID and (now - (_lastPrepareAt or 0)) < 0.05) then
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "SKIP | Throttled duplicate call | Quest:", q_ID, "| Time since last:", string.format("%.3f", now - (_lastPrepareAt or 0)), "s")
      end
      return
    end
    _lastPrepareQuestID = q_ID
    _lastPrepareAt = now
  end
  QTR_quest_ID = q_ID
  local str_ID = tostring(q_ID)

  QTR_quest_EN[QTR_quest_ID] = QTR_quest_EN[QTR_quest_ID] or {}
  QTR_quest_LG[QTR_quest_ID] = QTR_quest_LG[QTR_quest_ID] or {}

  if QTR_ToggleButton0 then QTR_ToggleButton0:SetWidth(150); QTR_ToggleButton0:SetScript("OnClick", QTR_ON_OFF) end

  if WOWTR and WOWTR.Debug then
    WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "Config | QTR_PS active:", QTR_PS and QTR_PS["active"], "| QTR_curr_trans:", QTR_curr_trans)
  end
  if (QTR_PS["active"] == "1") then
    if WOWTR and WOWTR.Debug then
      WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "Processing translation for quest", q_ID, "| Event:", event or "nil")
    end
    -- Don't enable buttons yet - wait to see if translation data exists
    -- Buttons will be enabled only if translation data is found

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

    QTR_curr_trans = QTR_curr_trans or "1"
    QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose0
    QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv0

    if WOWTR and WOWTR.Debug then
      WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "Translation data check | QTR_QuestData:", QTR_QuestData ~= nil, "| Quest ID:", str_ID, "| Has data:", QTR_QuestData and QTR_QuestData[str_ID] ~= nil)
    end
    
    if (QTR_QuestData and QTR_QuestData[str_ID]) then
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "[OK] Translation data FOUND for quest", str_ID, "| Loading translation...")
      end
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
        -- Map quest panel path: when event is nil, read visible EN texts if frames are ready
        if (not QTR_quest_EN[QTR_quest_ID].details and QuestInfoDescriptionText and QuestInfoDescriptionText.GetText) then
          QTR_quest_EN[QTR_quest_ID].details = QuestInfoDescriptionText:GetText()
        end
        if (not QTR_quest_EN[QTR_quest_ID].objectives and QuestInfoObjectivesText and QuestInfoObjectivesText.GetText) then
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
      do
        local storylineFrame = GetStorylineFrame()
        if (isStoryline and isStoryline() and storylineFrame and storylineFrame:IsVisible() and QTR_ToggleButton5) then QTR_ToggleButton5:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")") end
      end

      -- Determine if we actually have localized text; if not, keep EN view
      local hasTrans = false
      do
        local lg = QTR_quest_LG and QTR_quest_LG[QTR_quest_ID]
        if lg then
          local d = lg.details; local o = lg.objectives; local p = lg.progress; local c = lg.completion
          hasTrans = ((d and d ~= "") or (o and o ~= "") or (p and p ~= "") or (c and c ~= "")) and true or false
        end
      end
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "Translation check | hasTrans:", hasTrans, "| QTR_curr_trans:", QTR_curr_trans, 
          "| Details:", (QTR_quest_LG[q_ID] and QTR_quest_LG[q_ID].details and string.len(QTR_quest_LG[q_ID].details) or 0) .. " chars",
          "| Objectives:", (QTR_quest_LG[q_ID] and QTR_quest_LG[q_ID].objectives and string.len(QTR_quest_LG[q_ID].objectives) or 0) .. " chars")
      end
      
      -- Enable toggle buttons only if we have translation data
      if hasTrans then
        if QTR_ToggleButton0 then QTR_ToggleButton0:Enable() end
        if QTR_ToggleButton1 then QTR_ToggleButton1:Enable() end
        if QTR_ToggleButton2 then QTR_ToggleButton2:Enable() end
        if isImmersion and isImmersion() and QTR_ToggleButton4 then QTR_ToggleButton4:Enable() end
        if isStoryline and isStoryline() and QTR_ToggleButton5 then QTR_ToggleButton5:Enable() end
        if IsDUIQuestFrame and IsDUIQuestFrame() and QTR_ToggleButton7 then QTR_ToggleButton7:Enable() end
      else
        -- No translation available, disable buttons
        if QTR_ToggleButton0 then QTR_ToggleButton0:Disable() end
        if QTR_ToggleButton1 then QTR_ToggleButton1:Disable() end
        if QTR_ToggleButton2 then QTR_ToggleButton2:Disable() end
        if isImmersion and isImmersion() and QTR_ToggleButton4 then QTR_ToggleButton4:Disable() end
        if isStoryline and isStoryline() and QTR_ToggleButton5 then QTR_ToggleButton5:Disable() end
        if IsDUIQuestFrame and IsDUIQuestFrame() and QTR_ToggleButton7 then QTR_ToggleButton7:Disable() end
      end
      
      if not hasTrans then
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "|cFFFF0000[X] No localized text available|r | Falling back to English | Quest:", q_ID)
        end
        if Quests and Quests.Utils and Quests.Utils.DebugPrint then
          Quests.Utils.DebugPrint("QuestPrepare: no LG text, fallback to EN", "qid=", tostring(QTR_quest_ID))
        end
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "Calling QTR_Translate_Off (no translation)...")
        end
        QTR_Translate_Off(1, event)
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "[OK] QTR_Translate_Off completed")
        end
      else
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "[OK] Has translation | Setting QTR_curr_trans=1 | Calling QTR_Translate_On...")
        end
        -- Reset QTR_curr_trans to "1" if we have translation (so it always shows translated)
        -- This ensures that if a previous quest without translation set it to "0", we restore it
        QTR_curr_trans = "1"
        QTR_Translate_On(1, event)
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "[OK] QTR_Translate_On completed")
        end
      end
      if (QTR_PS["en_first"] == "1" and QTR_curr_trans == "1") then 
        if WOWTR and WOWTR.Debug then
          WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "en_first enabled | Scheduling QTR_ON_OFF toggle in 0.1s...")
        end
        -- Use a small delay to ensure translation is fully applied before toggling
        -- This prevents the toggle from interfering with the current processing
        C_Timer.After(0.1, function()
          if QTR_ON_OFF then QTR_ON_OFF() end
        end)
      end
    else
      -- No translation data available; leave view as EN but disable toggles
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "|cFFFF0000[X] No translation data found|r | Quest:", str_ID, "| Displaying English | Saving quest data...")
      end
      -- Disable all toggle buttons since there's no translation available
      if QTR_ToggleButton0 then QTR_ToggleButton0:Disable() end
      if QTR_ToggleButton1 then QTR_ToggleButton1:Disable() end
      if QTR_ToggleButton2 then QTR_ToggleButton2:Disable() end
      if isImmersion and isImmersion() and QTR_ToggleButton4 then QTR_ToggleButton4:Disable() end
      if isStoryline and isStoryline() and QTR_ToggleButton5 then QTR_ToggleButton5:Disable() end
      if IsDUIQuestFrame and IsDUIQuestFrame() and QTR_ToggleButton7 then QTR_ToggleButton7:Disable() end
      
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "QuestPrepare: Calling QTR_Translate_Off (no data)...")
      end
      QTR_Translate_Off(1, event)
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "QuestPrepare: Saving quest data...")
      end
      QTR_SaveQuest(event)
      if WOWTR and WOWTR.Debug then
        WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "QuestPrepare: QTR_SaveQuest completed")
      end
    end

    if (IsDUIQuestFrame and IsDUIQuestFrame()) then
      QTR_DUIQuestFrame(event)
      if (QTR_PS["en_first"] == "1") then DUI_ON_OFF() end
    end
  else
    -- Active is OFF - still need to save quest data and display in English
    if WOWTR and WOWTR.Debug then
      WOWTR.Debug.Verbose(WOWTR.Debug.Categories.QUESTS, "Active is OFF | Processing English display | Quest:", q_ID)
    end
    -- Disable all toggle buttons
    if QTR_ToggleButton0 then QTR_ToggleButton0:Disable() end
    if QTR_ToggleButton1 then QTR_ToggleButton1:Disable() end
    if QTR_ToggleButton2 then QTR_ToggleButton2:Disable() end
    if isImmersion and isImmersion() and QTR_ToggleButton4 then QTR_ToggleButton4:Disable() end
    if isStoryline and isStoryline() and QTR_ToggleButton5 then QTR_ToggleButton5:Disable() end
    if IsDUIQuestFrame and IsDUIQuestFrame() and QTR_ToggleButton7 then QTR_ToggleButton7:Disable() end
    
    -- Capture quest text data even when active is off (needed for display)
    WOWTR.DebugPrint("QuestPrepare: Capturing quest text...")
    if (not QTR_quest_EN[QTR_quest_ID].title) then
      QTR_quest_EN[QTR_quest_ID].title = GetTitleText() ~= "" and GetTitleText() or (QuestInfoTitleHeader and QuestInfoTitleHeader:GetText()) or ""
      WOWTR.DebugPrint("QuestPrepare: Captured title:", QTR_quest_EN[QTR_quest_ID].title and string.len(QTR_quest_EN[QTR_quest_ID].title) or 0, "chars")
    end
    
    if (event == "QUEST_DETAIL") then
      if (not QTR_quest_EN[QTR_quest_ID].details) then
        QTR_quest_EN[QTR_quest_ID].details = GetQuestText() or ""
        QTR_quest_EN[QTR_quest_ID].objectives = GetObjectiveText() or ""
        WOWTR.DebugPrint("QuestPrepare: Captured details:", QTR_quest_EN[QTR_quest_ID].details and string.len(QTR_quest_EN[QTR_quest_ID].details) or 0, "chars")
        WOWTR.DebugPrint("QuestPrepare: Captured objectives:", QTR_quest_EN[QTR_quest_ID].objectives and string.len(QTR_quest_EN[QTR_quest_ID].objectives) or 0, "chars")
      end
    elseif QuestInfoDescriptionText and QuestInfoDescriptionText.GetText then
      -- For map quest panel or other events, read from visible frames
      if (not QTR_quest_EN[QTR_quest_ID].details) then
        QTR_quest_EN[QTR_quest_ID].details = QuestInfoDescriptionText:GetText() or ""
        WOWTR.DebugPrint("QuestPrepare: Captured details from frame:", QTR_quest_EN[QTR_quest_ID].details and string.len(QTR_quest_EN[QTR_quest_ID].details) or 0, "chars")
      end
      if (not QTR_quest_EN[QTR_quest_ID].objectives and QuestInfoObjectivesText and QuestInfoObjectivesText.GetText) then
        QTR_quest_EN[QTR_quest_ID].objectives = QuestInfoObjectivesText:GetText() or ""
        WOWTR.DebugPrint("QuestPrepare: Captured objectives from frame:", QTR_quest_EN[QTR_quest_ID].objectives and string.len(QTR_quest_EN[QTR_quest_ID].objectives) or 0, "chars")
      end
    end
    
    -- Set default item text
    QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_quest_EN[QTR_quest_ID].itemchoose or QTR_MessOrig.itemchoose0
    QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_quest_EN[QTR_quest_ID].itemreceive or QTR_MessOrig.itemreceiv0
    
    -- Save quest data even when active is off (so we have it if user re-enables)
    WOWTR.DebugPrint("QuestPrepare: Saving quest data...")
    QTR_SaveQuest(event)
    
    -- Ensure quest is displayed in English (not translated)
    WOWTR.DebugPrint("QuestPrepare: Calling QTR_Translate_Off...")
    if QTR_Translate_Off then
      QTR_Translate_Off(1, event)
      WOWTR.DebugPrint("QuestPrepare: QTR_Translate_Off completed")
    else
      WOWTR.DebugPrint("QuestPrepare: ERROR - QTR_Translate_Off is nil!")
    end
    
    -- Handle Immersion frame if visible
    if (QTR_curr_trans == "1") then
      local immersionFrame = GetImmersionFrame()
      if (immersionFrame and immersionFrame.TalkBox and immersionFrame.TalkBox:IsVisible()) then
        if (not WOWTR_wait(0.2, QTR_Immersion_Static)) then end
      end
    end
  end
  if WOWTR and WOWTR.Debug then
    WOWTR.Debug.Exit("QuestPrepare", WOWTR.Debug.Categories.QUESTS, "Quest:", q_ID, "| Event:", event or "nil", "| Duration:", string.format("%.3f", GetTime() - startTime), "s")
  end
end

-- (removed duplicate DisplayConstants; keep the full implementation below)

-- Popup quest details show handler
function QTR_QuestLogPopupShow()
  if (QuestLogPopupDetailFrame and QuestLogPopupDetailFrame:IsVisible()) then
    return Quests.Details.QuestPrepare("QUEST_DETAIL")
  end
end

-- Remove delegator stubs that would override real implementations

function Quests.Details.DisplayConstants(lg)
   local str_ID = QTR_quest_ID and tostring(QTR_quest_ID) or nil
   local questDataExists = str_ID and QTR_QuestData and QTR_QuestData[str_ID]
   local questLGData = questDataExists and QTR_quest_LG and QTR_quest_LG[QTR_quest_ID]

  -- Reposition the destination map button for RTL when translation is ON
  do
    local df = QuestMapFrame and QuestMapFrame.QuestsFrame and QuestMapFrame.QuestsFrame.DetailsFrame
    local btn = df and df.DestinationMapButton
    if btn and btn.ClearAllPoints and btn.SetPoint then
      local rtl = (lg == 1) and (Quests.Utils and Quests.Utils.IsRTL and Quests.Utils.IsRTL()) or false
      btn:ClearAllPoints()
      if rtl then
        btn:SetPoint("TOPLEFT", df, "TOPLEFT", 10, -50)
      else
        btn:SetPoint("TOPRIGHT", df, "TOPRIGHT", -10, -50)
      end
    end
  end

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

