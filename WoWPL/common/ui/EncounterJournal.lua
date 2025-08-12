local addonName, addon = ...
local C = addon.C
local U = addon.U
local T = addon.T

local EJ = {}

function EJ.ST_SuggestTabClick()
   --print("SuggestTab clicked");
   if (TT_PS["ui5"] == "1") then
      local obj0 = EncounterJournalInstanceSelect.Title;
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj0, true, "Dungeon&Raid:Suggest:SuggestTittle", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj0, true, "Dungeon&Raid:Suggest:SuggestTittle", false);
      end

      local obj1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.description.text;
      local title1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.title.text:GetText() or "?";
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj1, true, "Dungeon&Raid:Suggest:" .. title1, WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj1, true, "Dungeon&Raid:Suggest:" .. title1, false);
      end

      local obj2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.description.text;
      local title2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.title.text:GetText() or "?";
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj2, true, "Dungeon&Raid:Suggest:" .. title2, WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj2, true, "Dungeon&Raid:Suggest:" .. title2, false);
      end

      local obj3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.description.text;
      local title3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.title.text:GetText() or "?";
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj3, true, "Dungeon&Raid:Suggest:" .. title3, WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj3, true, "Dungeon&Raid:Suggest:" .. title3, false);
      end

      local obj4 = EncounterJournalMonthlyActivitiesFrame.BarComplete.AllRewardsCollectedText; -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj4, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj4, true, "ui", false);
      end

      local obj5 = EncounterJournalTitleText; -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj5, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj5, true, "ui", false);
      end

      local obj6 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Month; -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj6, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj6, true, "ui", false);
      end

      local obj7 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Title; -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj7, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj7, true, "ui", false);
      end

      local obj8 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.TimeLeft; -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj8, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj8, true, "ui", false);
      end

      local obj9 = EncounterJournalSuggestFrame.Suggestion1.button.Text; -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj9, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj9, true, "ui", false);
      end

      local obj10 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.button.Text; -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj10, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj10, true, "ui", false);
      end

      local obj11 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.button.Text; -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj11, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj11, true, "ui", false);
      end

      local obj12 = EncounterJournalSuggestFrame.Suggestion1.reward.text; -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj12, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj12, true, "ui", false);
      end

      local obj13 = EncounterJournalMonthlyActivitiesFrame.BarComplete.PendingRewardsText; -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj13, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj13, true, "ui", false);
      end

      local obj14 = EncounterJournalMonthlyActivitiesTab.Text; -- Tab: Traveler's Log
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj14, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj14, true, "ui", false);
      end

      local obj15 = EncounterJournalSuggestTab.Text; -- Tab: Suggested Content
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj15, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj15, true, "ui", false);
      end

      local obj16 = EncounterJournalDungeonTab.Text; -- Tab: Dungeons
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj16, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj16, true, "ui", false);
      end

      local obj17 = EncounterJournalRaidTab.Text; -- Tab: Raids
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj17, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj17, true, "ui", false);
      end

      local obj18 = EncounterJournalLootJournalTab.Text; -- Tab: Item Sets
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(obj18, true, "ui", WOWTR_Font1);
      else
         T.ST_CheckAndReplaceTranslationTextUI(obj18, true, "ui", false);
      end
   end
end

function EJ.ST_showLoreDescription()
   --print("show LoreDescription");
   if (TT_PS["ui5"] == "1") then
      local ST_Dungeon_Raid_zone = EncounterJournalEncounterFrameInstanceFrame.title:GetText() or "?";
      local ST_loreDescription = EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox
          .FontStringContainer.FontString;
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationText(ST_loreDescription, true, "Dungeon&Raid:Zone:" .. ST_Dungeon_Raid_zone, false,
            false, -5, "RIGHT");
      else
         T.ST_CheckAndReplaceTranslationText(ST_loreDescription, true, "Dungeon&Raid:Zone:" .. ST_Dungeon_Raid_zone);
      end
      local ST_loreShowmap = EncounterJournalEncounterFrameInstanceFrameMapButtonText;
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationText(ST_loreShowmap, true, "ui");
      else
         T.ST_CheckAndReplaceTranslationText(ST_loreShowmap, true, "ui");
      end
   end
end

function EJ.ST_UpdateBossDescriptionFont(descText)
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

function EJ.ST_SaveOriginalText(bossName, text)
   if not ST_OriginalTexts then
      ST_OriginalTexts = {}
   end
   ST_OriginalTexts[bossName] = text
   -- Here you can save the text permanently, for example, to a file or database
end

function EJ.ST_BossHeaderTabText()
   local tabs = {
      EncounterJournalEncounterFrameInfoOverviewTab,
      EncounterJournalEncounterFrameInfoLootTab,
      EncounterJournalEncounterFrameInfoBossTab,
      EncounterJournalEncounterFrameInfoModelTab
   }

   for _, tab in ipairs(tabs) do
      T.ST_CheckAndReplaceTranslationText(tab, false, "ui", WOWTR_Font2, false, 0)
   end
end

function EJ.ST_UpdateJournalEncounterBossInfo(ST_bossName)
   -- Exit early if no boss name or translation for this section is disabled
   if not ST_bossName or TT_PS["ui5"] ~= "1" then return end

   -- Simplified helper function: Calls T.ST_CheckAndReplaceTranslationText with appropriate params
   -- Relies on T.ST_CheckAndReplaceTranslationText to handle font and justification.
   local function updateElement(element, prefix, ST_corr, justifyAlign)
      -- Ensure element exists and has GetText method before proceeding
      if not element or not element.GetText then return end

      -- Pass parameters directly to the main translation function
      -- 'true' for saving, WOWTR_Font2 as default font (can be overridden by font1 if needed), 'false' for onlyReverse
      T.ST_CheckAndReplaceTranslationText(element, true, prefix .. ST_bossName, WOWTR_Font2, false, ST_corr, justifyAlign)
   end

   -- Define elements and their specific parameters, including conditional justification
   local elementsToUpdate = {
      -- Apply RIGHT align only if language is AR, otherwise pass nil (use default)
      { EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription, "Dungeon&Raid:Boss:", -5,  (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil },
      -- Handling the overview description separately below using tempObj
      -- {EncounterJournalEncounterFrameInfo.overviewScroll.child.overviewDescription, "Dungeon&Raid:Boss:", nil, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil},
      { EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription,      "Dungeon&Raid:Boss:", nil, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil },
      { EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildTitle,           "ui",                 nil, nil } -- Titles usually default to LEFT
   }

   -- Process the standard elements defined above
   for _, elementData in ipairs(elementsToUpdate) do
      -- Unpack all four values and pass them to updateElement
      updateElement(elementData[1], elementData[2], elementData[3], elementData[4])
   end

   -- Special handling for the main overview description (often a SimpleHTML object)
   local overviewDesc = EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChild.overviewDescription
   if overviewDesc then
      local descText = overviewDesc
      .Text                                        -- The actual FontString or SimpleHTML object holding the text display
      local originalText = overviewDesc.textString -- SimpleHTML often stores the original string here

      if originalText and descText then
         EJ.ST_SaveOriginalText(ST_bossName, originalText) -- Save original if needed

         -- Create a temporary object wrapper conforming to T.ST_CheckAndReplaceTranslationText's expected interface
         local tempObj = {
            GetText = function() return originalText end,
            -- SetText in the wrapper now ONLY sets the text and updates font visuals
            SetText = function(self, text)
               descText:SetText(text)
               EJ.ST_UpdateBossDescriptionFont(descText) -- Update font styles if necessary for SimpleHTML
               -- NO justification logic here anymore - handled by T.ST_CheckAndReplaceTranslationText
            end,
            -- Provide GetFont and GetWidth for T.ST_CheckAndReplaceTranslationText
            GetFont = function()
               -- *** FIX: Call GetFont with "p" for SimpleHTML ***
               -- Get font details specifically for the paragraph tag ("p")
               -- as a reasonable default base size for SimpleHTML objects.
               -- Returns fontFile, height, flags for the "p" tag.
               return descText:GetFont("p")
            end,
            SetFont = function(self, font, size, flags)
               -- This might be less effective for SimpleHTML than SetFontObject,
               -- but EJ.ST_UpdateBossDescriptionFont likely handles detailed styling.
               -- We keep it for interface compatibility with T.ST_CheckAndReplaceTranslationText.
               -- Note: SimpleHTML SetFont might need a textType argument too,
               -- but T.ST_CheckAndReplaceTranslationText calls it without one.
               -- We rely on EJ.ST_UpdateBossDescriptionFont for the main styling.
               pcall(function() descText:SetFont("p", font, size, flags) end)
            end,
            GetWidth = function() return descText:GetWidth() end,
            SetJustifyH = function(self, align) -- Needed for T.ST_CheckAndReplaceTranslationText to call
               -- Handle justification for SimpleHTML potentially needing per-tag alignment
               local textTypes = { "p", "h1", "h2", "h3" }
               for _, textType in ipairs(textTypes) do
                  pcall(function() descText:SetJustifyH(textType, align) end)
               end
            end
            -- GetRegions = function() return descText:GetRegions() end -- Might not be needed by the main function
         }

         -- Call the main function with the tempObj and conditional justification
         T.ST_CheckAndReplaceTranslationText(tempObj, true, "Dungeon&Raid:Boss:" .. ST_bossName, WOWTR_Font2, false, -120,
            (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil)
      end
   end

   -- Update the root button text based on language (existing logic)
   local rootButton = EncounterJournalEncounterFrameInfoRootButton
   if rootButton then
      rootButton:SetText(WoWTR_Localization.lang == 'AR' and ">" or "<")
   end

   -- Update header tab text (existing logic)
   EJ.ST_BossHeaderTabText()
end

function EJ.ST_clickBosses()
   local previousText = ""
   local function OnUpdateHandler()
      local currentText = EncounterJournalEncounterFrameInfoEncounterTitle:GetText()
      if currentText and currentText ~= previousText then
         -- Get the boss name from the navigation bar
         local ST_bossName = EncounterJournalNavBarButton3Text:GetText()
         -- Update boss info
         EJ.ST_UpdateJournalEncounterBossInfo(ST_bossName)
         -- Update previousText
         previousText = currentText

         -- Add " " at the end of the text (only once)
         if not string.find(currentText, " $") then
            local modifiedText = currentText .. " "
            EncounterJournalEncounterFrameInfoEncounterTitle:SetText(modifiedText)
         end
      end
   end

   local frame = CreateFrame("Frame")
   frame:SetScript("OnUpdate", OnUpdateHandler)
end

local isEJournalButtonCreated = false
local EncounterJournalupdateVisibility
function EJ.ST_AdventureGuidebutton()
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
            EJ.ST_clickBosses()
            if EncounterJournal then
               EncounterJournal:Hide()
               EncounterJournal:Show()
               -- Butonun temizlenmesi için burada gerekli işlemleri yapabilirsiniz
            end
         end
      )

      isEJournalButtonCreated = true -- Butonlar ilk kez oluşturulunca işaretleyin
   end

   if EncounterJournalupdateVisibility then
      EncounterJournalupdateVisibility()
   end
end

function EJ.ST_ShowAbility() -- sprawdzanie tekstów Ability
   if (TT_PS["ui5"] == "1") then
      for i = 1, 99, 1 do
         if (_G["EncounterJournalInfoHeader" .. i .. "Description"]) then
            local obj = _G["EncounterJournalInfoHeader" .. i .. "Description"];
            local obj1 = _G["EncounterJournalInfoHeader" .. i];
            local obj2 = _G["EncounterJournalInfoHeader" .. i .. "DescriptionBG"];
            local txt = obj:GetText();

            T.ST_CheckAndReplaceTranslationText(obj, true,
               "Dungeon&Raid:Ability:" .. _G["EncounterJournalInfoHeader" .. i .. "HeaderButton"].title:GetText());
            local ST_bossDescription2 = EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription;
            T.ST_CheckAndReplaceTranslationText(ST_bossDescription2, false);
         end
      end
   end
end

function EJ.ST_BossHeaderTabText()
   if (TT_PS["ui5"] == "1") then
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

                              -- Create a temporary object to handle text replacement
                              local tempObj = {
                                 GetText = function() return metin end,
                                 SetText = function(self, text)
                                    bulletData.Text:SetText(text)
                                    -- Update font/style if needed
                                    EJ.ST_UpdateBossDescriptionFont(bulletData.Text)
                                 end
                              }

                              local prefix = "Dungeon&Raid:Boss:" .. ST_bossName
                              T.ST_CheckAndReplaceTranslationText(tempObj, true, prefix, nil, false, nil)
                           end
                        end
                     end
                  end
               end
            else
               -- Uncomment for debugging: print("Bullets table not found for Header " .. index)
            end
         else
            -- Uncomment for debugging: print("Header " .. index .. " not found.")
         end
      end
      local HeaderTitle1 = EncounterJournalOverviewInfoHeader1HeaderButtonTitle;
      T.ST_CheckAndReplaceTranslationText(HeaderTitle1, true, "ui");
      local HeaderTitle2 = EncounterJournalOverviewInfoHeader2HeaderButtonTitle;
      T.ST_CheckAndReplaceTranslationText(HeaderTitle2, true, "ui");
      local HeaderTitle3 = EncounterJournalOverviewInfoHeader3HeaderButtonTitle;
      T.ST_CheckAndReplaceTranslationText(HeaderTitle3, true, "ui");
   end
end

addon.EJ = EJ
