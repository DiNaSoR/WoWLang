local addonName, ns = ...

ns = ns or {}
ns.UI = ns.UI or {}
ns.UI.AdventureGuide = ns.UI.AdventureGuide or {}
local M = ns.UI.AdventureGuide

-- Adventure Guide / Encounter Journal module (migrated from WoW_Tooltips.lua)

local isEJournalButtonCreated = false
local EncounterJournalupdateVisibility

function M.SuggestTabClick()
  if (TT_PS and TT_PS["ui5"] == "1") then
    local obj0 = EncounterJournalInstanceSelect.Title
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj0, true, "Dungeon&Raid:Suggest:SuggestTittle", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj0, true, "Dungeon&Raid:Suggest:SuggestTittle", false)
    end

    local obj1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.description.text
    local title1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.title.text:GetText() or "?"
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj1, true, "Dungeon&Raid:Suggest:" .. title1, WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj1, true, "Dungeon&Raid:Suggest:" .. title1, false)
    end

    local obj2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.description.text
    local title2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.title.text:GetText() or "?"
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj2, true, "Dungeon&Raid:Suggest:" .. title2, WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj2, true, "Dungeon&Raid:Suggest:" .. title2, false)
    end

    local obj3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.description.text
    local title3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.title.text:GetText() or "?"
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj3, true, "Dungeon&Raid:Suggest:" .. title3, WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj3, true, "Dungeon&Raid:Suggest:" .. title3, false)
    end

    local obj4 = EncounterJournalMonthlyActivitiesFrame.BarComplete.AllRewardsCollectedText
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj4, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj4, true, "ui", false)
    end

    local obj5 = EncounterJournalTitleText
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj5, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj5, true, "ui", false)
    end

    local obj6 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Month
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj6, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj6, true, "ui", false)
    end

    local obj7 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Title
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj7, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj7, true, "ui", false)
    end

    local obj8 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.TimeLeft
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj8, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj8, true, "ui", false)
    end

    local obj9 = EncounterJournalSuggestFrame.Suggestion1.button.Text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj9, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj9, true, "ui", false)
    end

    local obj10 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.button.Text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj10, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj10, true, "ui", false)
    end

    local obj11 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.button.Text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj11, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj11, true, "ui", false)
    end

    local obj12 = EncounterJournalSuggestFrame.Suggestion1.reward.text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj12, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj12, true, "ui", false)
    end

    local obj13 = EncounterJournalMonthlyActivitiesFrame.BarComplete.PendingRewardsText
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj13, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj13, true, "ui", false)
    end

    local obj14 = EncounterJournalMonthlyActivitiesTab.Text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj14, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj14, true, "ui", false)
    end

    local obj15 = EncounterJournalSuggestTab.Text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj15, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj15, true, "ui", false)
    end

    local obj16 = EncounterJournalDungeonTab.Text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj16, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj16, true, "ui", false)
    end

    local obj17 = EncounterJournalRaidTab.Text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj17, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj17, true, "ui", false)
    end

    local obj18 = EncounterJournalLootJournalTab.Text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(obj18, true, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(obj18, true, "ui", false)
    end
  end
end

function M.ShowLoreDescription()
  if (TT_PS and TT_PS["ui5"] == "1") then
    local ST_Dungeon_Raid_zone = EncounterJournalEncounterFrameInstanceFrame.title:GetText() or "?"
    local ST_loreDescription = EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox.FontStringContainer.FontString
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(ST_loreDescription, true, "Dungeon&Raid:Zone:" .. ST_Dungeon_Raid_zone, false, false, -5, "RIGHT")
    else
      ST_CheckAndReplaceTranslationText(ST_loreDescription, true, "Dungeon&Raid:Zone:" .. ST_Dungeon_Raid_zone)
    end
    local ST_loreShowmap = EncounterJournalEncounterFrameInstanceFrameMapButtonText
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(ST_loreShowmap, true, "ui")
    else
      ST_CheckAndReplaceTranslationText(ST_loreShowmap, true, "ui")
    end
  end
end

function M.ShowDelveDifficultFrame()
  local DelveDF01 = DelvesDifficultyPickerFrame.Description
  if (WoWTR_Localization.lang == 'AR') then
    ST_CheckAndReplaceTranslationText(DelveDF01, true, "Dungeon&Raid:Zone:DelvesFrame", false, false)
  else
    ST_CheckAndReplaceTranslationTextUI(DelveDF01, true, "Dungeon&Raid:Zone:DelvesFrame")
  end

  local DelveDF02 = DelvesDifficultyPickerFrame.EnterDelveButton.Text
  ST_CheckAndReplaceTranslationTextUI(DelveDF02, false, "ui")

  local DelveDF03 = DelvesDifficultyPickerFrame.DelveRewardsContainerFrame.RewardText
  ST_CheckAndReplaceTranslationTextUI(DelveDF03, false, "ui")

  local DelveDF04 = DelvesDifficultyPickerFrame.ScenarioLabel
  ST_CheckAndReplaceTranslationTextUI(DelveDF04, false, "ui")

  local DelveDF05 = DelvesDifficultyPickerFrame.Title
  ST_CheckAndReplaceTranslationTextUI(DelveDF05, true, "Dungeon&Raid:Zone:DelvesFrame")
end

function M.UpdateJournalEncounterBossInfo(ST_bossName)
  if not ST_bossName or (TT_PS and TT_PS["ui5"] ~= "1") then return end

  local function updateElement(element, prefix, ST_corr, justifyAlign)
    if not element or not element.GetText then return end
    ST_CheckAndReplaceTranslationText(element, true, prefix .. ST_bossName, WOWTR_Font2, false, ST_corr, justifyAlign)
  end

  local elementsToUpdate = {
    { EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription, "Dungeon&Raid:Boss:", -5, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil },
    { EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription, "Dungeon&Raid:Boss:", nil, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil },
    { EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildTitle, "ui", nil, nil }
  }

  for _, elementData in ipairs(elementsToUpdate) do
    updateElement(elementData[1], elementData[2], elementData[3], elementData[4])
  end

  local overviewDesc = EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChild.overviewDescription
  if overviewDesc then
    local descText = overviewDesc.Text
    local originalText = overviewDesc.textString

    if originalText and descText then
      M.SaveOriginalText(ST_bossName, originalText)

      local tempObj = {
        GetText = function() return originalText end,
        SetText = function(self, text)
          descText:SetText(text)
          M.UpdateBossDescriptionFont(descText)
        end,
        GetFont = function() return descText:GetFont("p") end,
        SetFont = function(self, font, size, flags)
          pcall(function() descText:SetFont("p", font, size, flags) end)
        end,
        GetWidth = function() return descText:GetWidth() end,
        SetJustifyH = function(self, align)
          local textTypes = { "p", "h1", "h2", "h3" }
          for _, textType in ipairs(textTypes) do
            pcall(function() descText:SetJustifyH(textType, align) end)
          end
        end
      }

      ST_CheckAndReplaceTranslationText(tempObj, true, "Dungeon&Raid:Boss:" .. ST_bossName, WOWTR_Font2, false, -120, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil)
    end
  end

  local rootButton = EncounterJournalEncounterFrameInfoRootButton
  if rootButton then
    rootButton:SetText(WoWTR_Localization.lang == 'AR' and ">" or "<")
  end

  M.BossHeaderTabText()
end

function M.SaveOriginalText(bossName, text)
  ST_OriginalTexts = ST_OriginalTexts or {}
  ST_OriginalTexts[bossName] = text
end

function M.BossHeaderTabText()
  if (TT_PS and TT_PS["ui5"] == "1") then
    local ST_bossName = EncounterJournalNavBarButton3Text:GetText()

    local headers = {
      EncounterJournalOverviewInfoHeader1,
      EncounterJournalOverviewInfoHeader2,
      EncounterJournalOverviewInfoHeader3
    }

    for index, header in ipairs(headers) do
      if header then
        local bulletsTable = header.Bullets
        if bulletsTable then
          for _, bulletData in ipairs(bulletsTable) do
            if bulletData.Text and bulletData.Text.GetTextData then
              local textData = bulletData.Text:GetTextData()
              if textData then
                for text_index, textInfo in ipairs(textData) do
                  if textInfo.text then
                    local metin = textInfo.text
                    local tempObj = {
                      GetText = function() return metin end,
                      SetText = function(self, text)
                        bulletData.Text:SetText(text)
                        M.UpdateBossDescriptionFont(bulletData.Text)
                      end
                    }
                    local prefix = "Dungeon&Raid:Boss:" .. ST_bossName
                    ST_CheckAndReplaceTranslationText(tempObj, true, prefix, nil, false, nil)
                  end
                end
              end
            end
          end
        end
      end
    end

    local HeaderTitle1 = EncounterJournalOverviewInfoHeader1HeaderButtonTitle
    ST_CheckAndReplaceTranslationText(HeaderTitle1, true, "ui")
    local HeaderTitle2 = EncounterJournalOverviewInfoHeader2HeaderButtonTitle
    ST_CheckAndReplaceTranslationText(HeaderTitle2, true, "ui")
    local HeaderTitle3 = EncounterJournalOverviewInfoHeader3HeaderButtonTitle
    ST_CheckAndReplaceTranslationText(HeaderTitle3, true, "ui")
  end
end

function M.UpdateBossDescriptionFont(descText)
  if not descText then return end
  local textTypes = { "p", "h1", "h2", "h3" }
  for _, textType in ipairs(textTypes) do
    local alignment = (WoWTR_Localization.lang == 'AR') and "RIGHT" or "LEFT"
    if descText.SetJustifyH then
      descText:SetJustifyH(textType, alignment)
    end
    if descText.SetFont then
      descText:SetFont(textType, WOWTR_Font2, 12, "")
    end
    if descText.SetFontObject then
      local fontName = "WOWTRBossDescFont_" .. textType
      local fontObj = CreateFont(fontName)
      fontObj:SetFont(WOWTR_Font2, 12, "")
      fontObj:SetJustifyH(alignment)
      descText:SetFontObject(textType, fontObj)
    end
  end
end

function M.ClickBosses()
  local previousText = ""
  local function OnUpdateHandler()
    local currentText = EncounterJournalEncounterFrameInfoEncounterTitle:GetText()
    if currentText and currentText ~= previousText then
      local ST_bossName = EncounterJournalNavBarButton3Text:GetText()
      M.UpdateJournalEncounterBossInfo(ST_bossName)
      previousText = currentText
      if not string.find(currentText, " $") then
        local modifiedText = currentText .. " "
        EncounterJournalEncounterFrameInfoEncounterTitle:SetText(modifiedText)
      end
    end
  end

  local frame = CreateFrame("Frame")
  frame:SetScript("OnUpdate", OnUpdateHandler)
end

function M.AdventureGuideButton()
  if not isEJournalButtonCreated then
    TT_PS = TT_PS or { ui5 = "1" }

    EncounterJournalupdateVisibility = CreateToggleButton(
      EncounterJournal,
      TT_PS,
      "ui5",
      WoWTR_Localization.WoWTR_enDESC,
      WoWTR_Localization.WoWTR_trDESC,
      { "TOPLEFT", EncounterJournal, "TOPRIGHT", -170, 0 },
      function()
        M.ClickBosses()
        if EncounterJournal then
          EncounterJournal:Hide()
          EncounterJournal:Show()
        end
      end
    )

    isEJournalButtonCreated = true
  end

  if EncounterJournalupdateVisibility then
    EncounterJournalupdateVisibility()
  end
end

function M.ShowAbility()
  if (TT_PS and TT_PS["ui5"] == "1") then
    for i = 1, 99, 1 do
      if (_G["EncounterJournalInfoHeader" .. i .. "Description"]) then
        local obj = _G["EncounterJournalInfoHeader" .. i .. "Description"]
        local obj1 = _G["EncounterJournalInfoHeader" .. i]
        local obj2 = _G["EncounterJournalInfoHeader" .. i .. "DescriptionBG"]
        local txt = obj:GetText()

        ST_CheckAndReplaceTranslationText(obj, true, "Dungeon&Raid:Ability:" .. _G["EncounterJournalInfoHeader" .. i .. "HeaderButton"].title:GetText())
        local ST_bossDescription2 = EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription
        ST_CheckAndReplaceTranslationText(ST_bossDescription2, false)
      end
    end
  end
end

-- Global wrappers for back-compat
_G.ST_SuggestTabClick = function() return M.SuggestTabClick() end
_G.ST_showLoreDescription = function() return M.ShowLoreDescription() end
_G.ST_showDelveDifficultFrame = function() return M.ShowDelveDifficultFrame() end
_G.ST_UpdateJournalEncounterBossInfo = function(n) return M.UpdateJournalEncounterBossInfo(n) end
_G.ST_SaveOriginalText = function(n, t) return M.SaveOriginalText(n, t) end
_G.ST_BossHeaderTabText = function() return M.BossHeaderTabText() end
_G.ST_UpdateBossDescriptionFont = function(a) return M.UpdateBossDescriptionFont(a) end
_G.ST_clickBosses = function() return M.ClickBosses() end
_G.ST_AdventureGuidebutton = function() return M.AdventureGuideButton() end
_G.ST_ShowAbility = function() return M.ShowAbility() end

return M