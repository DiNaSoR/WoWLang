

function ST_revertJournalEncounterTranslations()
    local elementsToRevert = {
        EncounterJournalInstanceSelect and EncounterJournalInstanceSelect.Title,
        EncounterJournalTitleText,
        EncounterJournalMonthlyActivitiesTab and EncounterJournalMonthlyActivitiesTab.Text,
        EncounterJournalSuggestTab and EncounterJournalSuggestTab.Text,
        EncounterJournalDungeonTab and EncounterJournalDungeonTab.Text,
        EncounterJournalRaidTab and EncounterJournalRaidTab.Text,
        EncounterJournalLootJournalTab and EncounterJournalLootJournalTab.Text,
        
        EncounterJournalMonthlyActivitiesFrame and EncounterJournalMonthlyActivitiesFrame.HeaderContainer and EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Month,
        EncounterJournalMonthlyActivitiesFrame and EncounterJournalMonthlyActivitiesFrame.HeaderContainer and EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Title,
        EncounterJournalMonthlyActivitiesFrame and EncounterJournalMonthlyActivitiesFrame.HeaderContainer and EncounterJournalMonthlyActivitiesFrame.HeaderContainer.TimeLeft,
        EncounterJournalMonthlyActivitiesFrame and EncounterJournalMonthlyActivitiesFrame.BarComplete and EncounterJournalMonthlyActivitiesFrame.BarComplete.AllRewardsCollectedText,
        EncounterJournalMonthlyActivitiesFrame and EncounterJournalMonthlyActivitiesFrame.BarComplete and EncounterJournalMonthlyActivitiesFrame.BarComplete.PendingRewardsText,
        
        EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription,
        EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription,
        EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildTitle,
        EncounterJournalEncounterFrameInstanceFrame and EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont and EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox and EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox.FontStringContainer and EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox.FontStringContainer.FontString,
        EncounterJournalEncounterFrameInstanceFrameMapButtonText,
        EncounterJournalEncounterFrameInfoEncounterTitle,
        
        EncounterJournalEncounterFrameInfoOverviewTab,
        EncounterJournalEncounterFrameInfoLootTab,
        EncounterJournalEncounterFrameInfoBossTab,
        EncounterJournalEncounterFrameInfoModelTab,
        
        EncounterJournalOverviewInfoHeader1 and EncounterJournalOverviewInfoHeader1HeaderButtonTitle,
        EncounterJournalOverviewInfoHeader2 and EncounterJournalOverviewInfoHeader2HeaderButtonTitle,
        EncounterJournalOverviewInfoHeader3 and EncounterJournalOverviewInfoHeader3HeaderButtonTitle
    }
    
    for i = 1, 99 do
        if _G["EncounterJournalInfoHeader"..i.."Description"] then
            table.insert(elementsToRevert, _G["EncounterJournalInfoHeader"..i.."Description"])
        end
    end

    for _, element in ipairs(elementsToRevert) do
        if element and element.GetText and element.SetText then
            local currentText = element:GetText()
            if currentText and (string.find(currentText, NONBREAKINGSPACE) or ST_OriginalTextCache[element]) then
                local originalText = ST_OriginalTextCache[element]
                local originalFontInfo = ST_OriginalFontCache[element]
                local originalJustifyH = ST_OriginalJustifyCache[element]

                if originalText then
                    element:SetText(originalText)
                    if element.SetFont and originalFontInfo then
                       pcall(element.SetFont, element, unpack(originalFontInfo))
                    end
                    if element.SetJustifyH and originalJustifyH then
                        pcall(element.SetJustifyH, element, originalJustifyH)
                    end
                end
            end
        end
    end
    
    local overviewDesc = EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChild and EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChild.overviewDescription
    if overviewDesc and overviewDesc.Text then
        local descText = overviewDesc.Text
        if ST_OriginalTextCache[descText] then
            descText:SetText(ST_OriginalTextCache[descText])
            if descText.SetFont and ST_OriginalFontCache[descText] then
                pcall(function() 
                    local fontInfo = ST_OriginalFontCache[descText]
                    descText:SetFont("p", fontInfo[1], fontInfo[2], fontInfo[3])
                end)
            end
            if descText.SetJustifyH and ST_OriginalJustifyCache[descText] then
                pcall(function()
                    local textTypes = {"p", "h1", "h2", "h3"}
                    for _, textType in ipairs(textTypes) do
                        descText:SetJustifyH(textType, ST_OriginalJustifyCache[descText])
                    end
                end)
            end
        end
    end
end

function ST_SuggestTabClick()
    TT_PS = TT_PS or {}
    TT_PS.ui5 = TT_PS.ui5 or "1" -- Default to translated if setting doesn't exist
    
    if (TT_PS["ui5"] == "1") then
        local obj0 = EncounterJournalInstanceSelect.Title;
        if (WoWTR_Localization.lang == 'AR') then
            ST_CheckAndReplaceTranslationTextUI(obj0, true, "Dungeon&Raid:Suggest:SuggestTittle", WOWTR_Font1);
        else
            ST_CheckAndReplaceTranslationTextUI(obj0, true, "Dungeon&Raid:Suggest:SuggestTittle", false);
        end
        
        local obj1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.description.text;
        local title1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.title.text:GetText() or "?";
        if (WoWTR_Localization.lang == 'AR') then
            ST_CheckAndReplaceTranslationTextUI(obj1, true, "Dungeon&Raid:Suggest:"..title1, WOWTR_Font1);
        else
            ST_CheckAndReplaceTranslationTextUI(obj1, true, "Dungeon&Raid:Suggest:"..title1, false);
        end
        
        local obj2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.description.text;
        local title2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.title.text:GetText() or "?";
        if (WoWTR_Localization.lang == 'AR') then
            ST_CheckAndReplaceTranslationTextUI(obj2, true, "Dungeon&Raid:Suggest:"..title2, WOWTR_Font1);
        else
            ST_CheckAndReplaceTranslationTextUI(obj2, true, "Dungeon&Raid:Suggest:"..title2, false);
        end

        local obj3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.description.text;
        local title3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.title.text:GetText() or "?";
        if (WoWTR_Localization.lang == 'AR') then
            ST_CheckAndReplaceTranslationTextUI(obj3, true, "Dungeon&Raid:Suggest:"..title3, WOWTR_Font1);
        else
            ST_CheckAndReplaceTranslationTextUI(obj3, true, "Dungeon&Raid:Suggest:"..title3, false);
        end

        local uiElements = {
            EncounterJournalMonthlyActivitiesFrame.BarComplete.AllRewardsCollectedText,
            EncounterJournalTitleText,
            EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Month,
            EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Title,
            EncounterJournalMonthlyActivitiesFrame.HeaderContainer.TimeLeft,
            EncounterJournalSuggestFrame.Suggestion1.button.Text,
            EncounterJournalSuggestFrame.Suggestion2.centerDisplay.button.Text,
            EncounterJournalSuggestFrame.Suggestion3.centerDisplay.button.Text,
            EncounterJournalSuggestFrame.Suggestion1.reward.text,
            EncounterJournalMonthlyActivitiesFrame.BarComplete.PendingRewardsText,
            EncounterJournalMonthlyActivitiesTab.Text,
            EncounterJournalSuggestTab.Text,
            EncounterJournalDungeonTab.Text,
            EncounterJournalRaidTab.Text,
            EncounterJournalLootJournalTab.Text
        }
        
        for _, element in ipairs(uiElements) do
            if element then
                if (WoWTR_Localization.lang == 'AR') then
                    ST_CheckAndReplaceTranslationTextUI(element, true, "ui", WOWTR_Font1);
                else
                    ST_CheckAndReplaceTranslationTextUI(element, true, "ui", false);
                end
            end
        end
    else
        ST_revertJournalEncounterTranslations()
    end
end

function ST_showLoreDescription()
    TT_PS = TT_PS or {}
    TT_PS.ui5 = TT_PS.ui5 or "1" -- Default to translated if setting doesn't exist
    
    if (TT_PS["ui5"] == "1") then
        local ST_Dungeon_Raid_zone = EncounterJournalEncounterFrameInstanceFrame.title:GetText() or "?";
        local ST_loreDescription = EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox.FontStringContainer.FontString;
        if (WoWTR_Localization.lang == 'AR') then
            ST_CheckAndReplaceTranslationText(ST_loreDescription, true, "Dungeon&Raid:Zone:"..ST_Dungeon_Raid_zone, false, false, -5, "RIGHT");
        else
            ST_CheckAndReplaceTranslationText(ST_loreDescription, true, "Dungeon&Raid:Zone:"..ST_Dungeon_Raid_zone);
        end
        local ST_loreShowmap = EncounterJournalEncounterFrameInstanceFrameMapButtonText;
        if (WoWTR_Localization.lang == 'AR') then
            ST_CheckAndReplaceTranslationText(ST_loreShowmap, true, "ui");
        else
            ST_CheckAndReplaceTranslationText(ST_loreShowmap, true, "ui");
        end
    else
        ST_revertJournalEncounterTranslations()
    end
end

function ST_UpdateJournalEncounterBossInfo(ST_bossName)
    TT_PS = TT_PS or {}
    TT_PS.ui5 = TT_PS.ui5 or "1" -- Default to translated if setting doesn't exist
    
    if not ST_bossName or TT_PS["ui5"] ~= "1" then 
        if TT_PS["ui5"] ~= "1" then
            ST_revertJournalEncounterTranslations()
        end
        return 
    end

    local function updateElement(element, prefix, ST_corr, justifyAlign)
        if not element or not element.GetText then return end
        
        ST_CheckAndReplaceTranslationText(element, true, prefix .. ST_bossName, WOWTR_Font2, false, ST_corr, justifyAlign)
    end

    local elementsToUpdate = {
        {EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription, "Dungeon&Raid:Boss:", -5, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil},
        {EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription, "Dungeon&Raid:Boss:", nil, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil},
        {EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildTitle, "ui", nil, nil}
    }

    for _, elementData in ipairs(elementsToUpdate) do
        updateElement(elementData[1], elementData[2], elementData[3], elementData[4])
    end

    local overviewDesc = EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChild.overviewDescription
    if overviewDesc then
        local descText = overviewDesc.Text -- The actual FontString or SimpleHTML object holding the text display
        local originalText = overviewDesc.textString -- SimpleHTML often stores the original string here

        if originalText and descText then
            if not ST_OriginalTextCache[descText] then
                ST_OriginalTextCache[descText] = originalText
                if descText.GetFont then
                    ST_OriginalFontCache[descText] = {descText:GetFont("p")}
                end
                if descText.GetJustifyH then
                    ST_OriginalJustifyCache[descText] = descText:GetJustifyH("p")
                end
            end
            
            local tempObj = {
                GetText = function() return originalText end,
                SetText = function(self, text)
                    descText:SetText(text)
                    if descText.SetFont then
                        pcall(function() descText:SetFont("p", WOWTR_Font2, select(2, descText:GetFont("p"))) end)
                    end
                end,
                GetFont = function()
                    return descText:GetFont("p")
                end,
                SetFont = function(self, font, size, flags)
                    pcall(function() descText:SetFont("p", font, size, flags) end)
                end,
                GetWidth = function() return descText:GetWidth() end,
                SetJustifyH = function(self, align)
                    local textTypes = {"p", "h1", "h2", "h3"}
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
end

function ST_BossHeaderTabText()
    TT_PS = TT_PS or {}
    TT_PS.ui5 = TT_PS.ui5 or "1" -- Default to translated if setting doesn't exist
    
    if (TT_PS["ui5"] == "1") then
        local tabs = {
            EncounterJournalEncounterFrameInfoOverviewTab,
            EncounterJournalEncounterFrameInfoLootTab,
            EncounterJournalEncounterFrameInfoBossTab,
            EncounterJournalEncounterFrameInfoModelTab
        }

        for _, tab in ipairs(tabs) do
            if tab and tab.GetText then
                local tabText = tab:GetText()
                if tabText then
                    if (WoWTR_Localization.lang == 'AR') then
                        ST_CheckAndReplaceTranslationTextUI(tab, true, "ui", WOWTR_Font1)
                    else
                        ST_CheckAndReplaceTranslationTextUI(tab, true, "ui", false)
                    end
                end
            end
        end
        
        local ST_bossName = EncounterJournalNavBarButton3Text:GetText()

        local headers = {
            EncounterJournalOverviewInfoHeader1,
            EncounterJournalOverviewInfoHeader2,
            EncounterJournalOverviewInfoHeader3
        }

        for index, header in ipairs(headers) do
            if header and header.HeaderButton and header.HeaderButton.Title then
                local headerTitle = header.HeaderButton.Title
                if headerTitle and headerTitle.GetText then
                    local titleText = headerTitle:GetText()
                    if titleText then
                        if (WoWTR_Localization.lang == 'AR') then
                            ST_CheckAndReplaceTranslationTextUI(headerTitle, true, "Dungeon&Raid:Boss:" .. ST_bossName .. ":Header" .. index, WOWTR_Font1)
                        else
                            ST_CheckAndReplaceTranslationTextUI(headerTitle, true, "Dungeon&Raid:Boss:" .. ST_bossName .. ":Header" .. index, false)
                        end
                    end
                end
            end
        end
        
        local HeaderTitle1 = EncounterJournalOverviewInfoHeader1HeaderButtonTitle;
        ST_CheckAndReplaceTranslationText(HeaderTitle1, true, "ui");
        local HeaderTitle2 = EncounterJournalOverviewInfoHeader2HeaderButtonTitle;
        ST_CheckAndReplaceTranslationText(HeaderTitle2, true, "ui");
        local HeaderTitle3 = EncounterJournalOverviewInfoHeader3HeaderButtonTitle;
        ST_CheckAndReplaceTranslationText(HeaderTitle3, true, "ui");
    else
        ST_revertJournalEncounterTranslations()
    end
end

function ST_clickBosses()
    TT_PS = TT_PS or {}
    TT_PS.ui5 = TT_PS.ui5 or "1" -- Default to translated if setting doesn't exist
    
    if (TT_PS["ui5"] == "1") then
        local ST_bossName = EncounterJournalEncounterFrameInfoEncounterTitle:GetText() or "?";
        ST_UpdateJournalEncounterBossInfo(ST_bossName);
        ST_BossHeaderTabText();
    else
        ST_revertJournalEncounterTranslations()
    end
end

function ST_ShowAbility()
    TT_PS = TT_PS or {}
    TT_PS.ui5 = TT_PS.ui5 or "1" -- Default to translated if setting doesn't exist
    
    if (TT_PS["ui5"] == "1") then
        for i = 1, 99 do
            local headerFrame = _G["EncounterJournalInfoHeader"..i]
            if headerFrame and headerFrame:IsVisible() then
                local descriptionFrame = _G["EncounterJournalInfoHeader"..i.."Description"]
                if descriptionFrame then
                    local ST_bossName = EncounterJournalEncounterFrameInfoEncounterTitle:GetText() or "?";
                    local ST_abilityName = _G["EncounterJournalInfoHeader"..i.."Title"]:GetText() or "?";
                    if (WoWTR_Localization.lang == 'AR') then
                        ST_CheckAndReplaceTranslationText(descriptionFrame, true, "Dungeon&Raid:Boss:"..ST_bossName..":"..ST_abilityName, false, false, -5, "RIGHT");
                    else
                        ST_CheckAndReplaceTranslationText(descriptionFrame, true, "Dungeon&Raid:Boss:"..ST_bossName..":"..ST_abilityName);
                    end
                end
            end
        end
    else
        ST_revertJournalEncounterTranslations()
    end
end

function ST_AdventureGuidebutton()
    local isJournalButtonCreated = false
    local JournalupdateVisibility -- Holds the function returned by CreateToggleButton

    if not isJournalButtonCreated then
        TT_PS = TT_PS or { ui5 = "1" } -- Initialize settings if they don't exist

        JournalupdateVisibility = CreateToggleButton(
           EncounterJournal,
           TT_PS,
           "ui5",
           WoWTR_Localization.WoWTR_enDESC,
           WoWTR_Localization.WoWTR_trDESC,
           {"TOPLEFT", EncounterJournal, "TOPRIGHT", -170, 0},
           function() -- OnClick handler
                if EncounterJournalSuggestFrame and EncounterJournalSuggestFrame:IsVisible() then
                    ST_SuggestTabClick()
                end
                
                if EncounterJournalEncounterFrameInstanceFrame and EncounterJournalEncounterFrameInstanceFrame:IsVisible() then
                    ST_showLoreDescription()
                end
                
                if EncounterJournalEncounterFrameInfoEncounterTitle and EncounterJournalEncounterFrameInfoEncounterTitle:IsVisible() then
                    ST_clickBosses()
                end
                
                C_Timer.After(0.01, function()
                    if EncounterJournal:IsVisible() then
                        local wasShown = EncounterJournal:IsShown()
                        if wasShown then
                            EncounterJournal:Hide()
                            EncounterJournal:Show()
                        end
                    end
                end)
           end
        )
        isJournalButtonCreated = true
    end

    if JournalupdateVisibility then
        JournalupdateVisibility()
    end
end


local journalFrameCheckTimer
local journalHooked = false -- Track if EncounterJournal hooks are set

local function CheckAndHookJournalFrame()
    if EncounterJournal and not EncounterJournal.hooked then
        EncounterJournal:HookScript("OnShow", function()
            if _G.StartTicker then
                _G.StartTicker(EncounterJournal, ST_AdventureGuidebutton, 0.1)
            end
        end)
        
        if EncounterJournalSuggestTab then
            EncounterJournalSuggestTab:HookScript("OnClick", function()
                if _G.StartTicker then
                    _G.StartTicker(EncounterJournalSuggestTab, ST_SuggestTabClick, 0.1)
                end
            end)
        end
        
        if EncounterJournalInstanceSelect then
            hooksecurefunc(EncounterJournalInstanceSelect, "UpdateInstanceButton", function()
                if _G.StartTicker then
                    _G.StartTicker(EncounterJournalInstanceSelect, ST_showLoreDescription, 0.1)
                end
            end)
        end
        
        if EncounterJournal.encounter and EncounterJournal.encounter.info then
            hooksecurefunc(EncounterJournal.encounter.info, "SetBossHeaderButtons", function()
                if _G.StartTicker then
                    _G.StartTicker(EncounterJournal.encounter.info, ST_clickBosses, 0.1)
                end
            end)
        end
        
        if EncounterJournal.encounter and EncounterJournal.encounter.info then
            hooksecurefunc(EncounterJournal.encounter.info, "UpdateButtons", function()
                if _G.StartTicker then
                    _G.StartTicker(EncounterJournal.encounter.info, ST_ShowAbility, 0.1)
                end
            end)
        end
        
        EncounterJournal.hooked = true
        journalHooked = true
        return true
    end
    return false
end

local function StartJournalFrameCheck()
    if not journalHooked and not journalFrameCheckTimer then
        journalFrameCheckTimer = C_Timer.NewTicker(1, function()
            if CheckAndHookJournalFrame() then
                if journalFrameCheckTimer then
                    journalFrameCheckTimer:Cancel()
                    journalFrameCheckTimer = nil
                end
            end
        end)
    end
end

local JournalLoaderFrame = CreateFrame("Frame")
JournalLoaderFrame:RegisterEvent("ADDON_LOADED")
JournalLoaderFrame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "Blizzard_EncounterJournal" then
        if not CheckAndHookJournalFrame() then
            StartJournalFrameCheck()
        end
        
        if journalHooked then
            self:UnregisterEvent("ADDON_LOADED")
            if journalFrameCheckTimer then
                journalFrameCheckTimer:Cancel()
                journalFrameCheckTimer = nil
            end
        end
    end
end)
