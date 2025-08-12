local addonName, addon = ...
local C = addon.C
local U = addon.U
local T = addon.T

local MF = {}

function MF.ST_showDelveDifficultFrame()
   --print("show DelveDifficultFrame");
   -- if (TT_PS["ui7"] == "1") then
   local DelveDF01 = DelvesDifficultyPickerFrame.Description;                                            -- https://imgur.com/a/SAyXuiR
   if (WoWTR_Localization.lang == 'AR') then
      T.ST_CheckAndReplaceTranslationText(DelveDF01, true, "Dungeon&Raid:Zone:DelvesFrame", false, false); -- save untranslated text
   else
      T.ST_CheckAndReplaceTranslationTextUI(DelveDF01, true, "Dungeon&Raid:Zone:DelvesFrame");             -- save untranslated text
   end

   local DelveDF02 = DelvesDifficultyPickerFrame.EnterDelveButton.Text;                   -- https://imgur.com/a/SAyXuiR
   T.ST_CheckAndReplaceTranslationTextUI(DelveDF02, false, "ui");                           -- dont save untranslated text

   local DelveDF03 = DelvesDifficultyPickerFrame.DelveRewardsContainerFrame.RewardText;   -- https://imgur.com/a/SAyXuiR
   T.ST_CheckAndReplaceTranslationTextUI(DelveDF03, false, "ui");                           -- dont save untranslated text

   local DelveDF04 = DelvesDifficultyPickerFrame.ScenarioLabel;                           -- https://imgur.com/a/SAyXuiR
   T.ST_CheckAndReplaceTranslationTextUI(DelveDF04, false, "ui");                           -- dont save untranslated text

   local DelveDF05 = DelvesDifficultyPickerFrame.Title;                                   -- https://imgur.com/a/SAyXuiR
   T.ST_CheckAndReplaceTranslationTextUI(DelveDF05, true, "Dungeon&Raid:Zone:DelvesFrame"); -- dont save untranslated text
   -- end
end

function MF.ST_StaticPopup1()
   --print(StaticPopup1Text:GetText());
   if (TT_PS["ui1"] == "1") then
      local SPobj01 = StaticPopup1Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj01, true, "h@popuptext-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj02 = StaticPopup1Button1Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj02, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj03 = StaticPopup1Button2Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj03, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj04 = StaticPopup1Button3Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj04, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj05 = StaticPopup1Button4Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj05, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj06 = StaticPopup2Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj06, true, "h@popuptext-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj07 = StaticPopup2Button1Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj07, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj08 = StaticPopup2Button2Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj08, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj09 = StaticPopup2Button3Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj09, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj10 = StaticPopup2Button4Text;
      T.ST_CheckAndReplaceTranslationTextUI(SPobj10, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.
   end
end

function MF.ST_WorldMapFunc()
   --print("ST_WorldMapFunc");
   local wmframe01 = WorldMapFrameTitleText;
   T.ST_CheckAndReplaceTranslationText(wmframe01, true, "ui", false, 1);

   local wmframe02 = WorldMapFrameHomeButtonText;
   T.ST_CheckAndReplaceTranslationText(wmframe02, true, "ui");
end

function MF.ST_GroupFinder()
   --print("ST_GroupFinder");
   -- Dungeons & Raids
   if (TT_PS["ui3"] == "1") then
      local GFobj01 = PVEFrameTitleText;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj01, true, "ui");

      local GFobj02 = PVEFrameTab1.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj02, true, "ui");

      local GFobj03 = PVEFrameTab2.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj03, true, "ui");

      local GFobj04 = PVEFrameTab3.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj04, true, "ui");

      local GFobj05 = GroupFinderFrameGroupButton1Name;
      T.ST_CheckAndReplaceTranslationText(GFobj05, true, "ui", false, true);

      local GFobj06 = GroupFinderFrameGroupButton2Name;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj06, true, "ui");

      local GFobj07 = GroupFinderFrameGroupButton3Name;
      T.ST_CheckAndReplaceTranslationText(GFobj07, true, "ui", false, true);

      local GFobj08 = LFDQueueFrameTypeDropDownName;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj08, true, "ui");

      local GFobj09 = LFDQueueFrameRandomScrollFrameChildFrameTitle;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj09, true, "ui", WOWTR_Font1);

      local GFobj10 = LFDQueueFrameRandomScrollFrameChildFrameDescription;
      T.ST_CheckAndReplaceTranslationText(GFobj10, true, "ui", false, false);

      local GFobj11 = LFDQueueFrameRandomScrollFrameChildFrameRewardsLabel;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj11, true, "ui", WOWTR_Font1);

      local GFobj12 = LFDQueueFrameRandomScrollFrameChildFrameRewardsDescription;
      T.ST_CheckAndReplaceTranslationText(GFobj12, true, "ui", false, false, -10);

      local GFobj13 = LFDQueueFrameFindGroupButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj13, true, "ui");

      local GFobj14 = RaidFinderQueueFrameScrollFrameChildFrameDescription;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj14, true, "ui");

      local GFobj15 = RaidFinderQueueFrameScrollFrameChildFrameRewardsLabel;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj15, true, "ui", WOWTR_Font1);

      local GFobj16 = RaidFinderQueueFrameScrollFrameChildFrameRewardsDescription;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj16, true, "ui");

      local GFobj17 = RaidFinderFrameFindRaidButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj17, true, "ui");

      local GFobj18 = LFGListFrame.CategorySelection.StartGroupButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj18, true, "ui");

      local GFobj19 = LFGListFrame.CategorySelection.FindGroupButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj19, true, "ui");

      local GFobj20 = LFGListFrame.CategorySelection.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj20, true, "ui", WOWTR_Font1);

      local GFobj21 = LFGListApplicationDialog.Label; -- Choose your Roles
      T.ST_CheckAndReplaceTranslationTextUI(GFobj21, true, "ui");

      local GFobj22 = LFGListApplicationDialog.SignUpButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj22, true, "ui");

      local GFobj23 = LFGListApplicationDialog.CancelButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj23, true, "ui");

      local GFobj24 = LFGListFrame.SearchPanel.SignUpButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj24, true, "ui");

      local GFobj25 = LFGListFrame.SearchPanel.BackButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj25, true, "ui");

      local GFobj26 = LFGListFrame.SearchPanel.CategoryName;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj26, true, "ui");

      local GFobj27 = LFGListFrame.EntryCreation.NameLabel;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj27, true, "ui");

      local GFobj28 = LFGListFrame.EntryCreation.DescriptionLabel;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj28, true, "ui");

      local GFobj29 = LFGListFrame.EntryCreation.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj29, true, "ui", WOWTR_Font1);

      local GFobj30 = LFGListInviteDialog.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj30, true, "ui");

      local GFobj31 = LFGListInviteDialog.RoleDescription;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj31, true, "ui");

      local GFobj32 = LFGListInviteDialog.AcceptButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj32, true, "ui");

      local GFobj33 = LFGListInviteDialog.DeclineButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj33, true, "ui");

      local GFobj34 = LFGListInviteDialog.AcknowledgeButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj34, true, "ui");

      local GFobj35 = LFDQueueFrameFollowerTitle;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj35, true, "ui", WOWTR_Font1);

      local GFobj36 = LFDQueueFrameFollowerDescription;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj36, true, "ui");

      local GFobj37 = LFGListFrame.EntryCreation.ListGroupButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj37, true, "ui");

      local GFobj38 = LFGListFrame.SearchPanel.ScrollBox.StartGroupButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj38, true, "ui");

      local GFobj39 = LFGListFrame.SearchPanel.SearchBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj39, true, "ui");

      local GFobj40 = LFGListFrame.SearchPanel.ScrollBox.NoResultsFound;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj40, true, "ui");

      local GFobj41 = LFGListFrame.EntryCreation.PlayStyleLabel;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj41, true, "ui");

      local GFobj42 = LFGListCreationDescription.EditBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj42, true, "ui");

      local GFobj43 = LFGListFrame.EntryCreation.MythicPlusRating.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj43, true, "ui");

      local GFobj44 = LFGListFrame.EntryCreation.ItemLevel.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj44, true, "ui");

      local GFobj45 = LFGListFrame.EntryCreation.VoiceChat.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj45, true, "ui");

      local GFobj46 = LFGListFrame.EntryCreation.PrivateGroup.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj46, true, "ui");

      local GFobj47 = LFGListFrame.EntryCreation.CrossFactionGroup.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj47, true, "ui");

      local GFobj48 = LFGListFrame.EntryCreation.Name.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj48, true, "ui");

      local GFobj49 = LFGListFrame.EntryCreation.ItemLevel.EditBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj49, true, "ui");

      local GFobj50 = LFGListFrame.EntryCreation.VoiceChat.EditBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj50, true, "ui");

      local GFobj51 = LFGListFrame.EntryCreation.CancelButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj51, true, "ui");

      local GFobj52 = LFGListApplicationDialogDescription.EditBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj52, true, "ui");

      local GFobj53 = LFGListFrame.ApplicationViewer.ScrollBox.NoApplicants;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj53, true, "ui");

      local GFobj54 = LFGListFrame.ApplicationViewer.BrowseGroupsButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj54, true, "ui");

      local GFobj55 = LFGListFrame.ApplicationViewer.RemoveEntryButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj55, true, "ui");

      local GFobj56 = LFGListFrame.ApplicationViewer.EditButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj56, true, "ui");

      local GFobj57 = LFGListFrame.SearchPanel.BackToGroupButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj57, true, "ui");

      local GFobj58 = LFGListFrame.ApplicationViewer.NameColumnHeader.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj58, true, "ui");

      local GFobj59 = LFGListFrame.ApplicationViewer.RoleColumnHeader.Label;
      T.ST_CheckAndReplaceTranslationTextUI(GFobj59, true, "ui");


      -- Utility function for applying translations to UI elements with custom font
      local function ApplyTranslationToElement(element, alignment)
         -- Check if the element is valid and has the necessary text methods
         if element and element.GetText and element.SetText then
            local originalText = element:GetText() -- Get the current text

            if originalText then
               -- --- START: Debug code to print font information ---
               if element.GetFont then                                                     -- Check if the element supports getting font info
                  local fontFile, fontHeight, fontFlags = element:GetFont()
                  local elementName = element:GetName()                                    -- Try to get the element's name for context
                  local parentName = element:GetParent() and element:GetParent():GetName() -- Get parent name too

                  --print("--- ApplyTranslationToElement Debug ---")
                  if elementName then
                     --print("Element Name:", elementName)
                  end
                  if parentName then
                     --print("Parent Name:", parentName)
                  end
                  -- If no name, maybe show the first few chars of text for context
                  if not elementName then
                     --print("Element (no name): Text starts with ->", string.sub(originalText, 1, 30))
                  end
                  --print("Original Font File:", fontFile or "N/A")
                  --print("Original Font Size:", fontHeight or "N/A")
                  -- print("Original Font Flags:", fontFlags or "N/A") -- Optional: Uncomment if you need flags
                  --print("---------------------------------------")
               else
                  -- Optionally print if GetFont isn't supported
                  local elementName = element:GetName()
                  --print("ApplyTranslationToElement:", elementName or "Unnamed Element", "does not support GetFont()")
               end
               -- --- END: Debug code ---

               local hash = StringHash(U.ST_UsunZbedneZnaki(originalText)) -- Calculate the hash

               -- If a translation exists, update the text and font
               if ST_TooltipsHS[hash] then
                  local translatedText = QTR_ReverseIfAR(ST_TooltipsHS[hash])
                  element:SetText(translatedText) -- Set the translated text

                  if element.SetFont then
                     -- Use select(2,...) which is safer if GetFont returns nil
                     if WoWTR_Localization.lang == 'AR' then
                        element:SetFont(WOWTR_Font1, select(2, element:GetFont()))
                     else
                        element:SetFont(WOWTR_Font2, select(2, element:GetFont()))
                     end
                  end
                  -- else -- No translation found
                  -- Ensure original font remains if needed (usually not necessary unless something else modified it)
                  -- if element.SetFont and fontFile and fontHeight then
                  --    element:SetFont(fontFile, fontHeight, fontFlags)
                  -- end
               end

               -- Adjust text alignment if specified
               if alignment and element.SetJustifyH then
                  element:SetJustifyH(alignment)
               end
            end
         end
      end

      -- Iterate through the category buttons and apply translations
      local categoryButtons = {
         LFGListFrame.CategorySelection.CategoryButtons[1],
         LFGListFrame.CategorySelection.CategoryButtons[2],
         LFGListFrame.CategorySelection.CategoryButtons[3],
         LFGListFrame.CategorySelection.CategoryButtons[4],
         LFGListFrame.CategorySelection.CategoryButtons[5],
         LFGListFrame.CategorySelection.CategoryButtons[6]
      }

      for _, button in ipairs(categoryButtons) do
         -- MODIFICATION: Check for the .Label child and pass THAT to the function
         if button and button.Label then
            -- Pass the actual Label element which holds the text and font info
            ApplyTranslationToElement(button.Label)
         elseif button then
            -- Fallback: If no Label child, try applying to the button itself (might not work for font)
            --print("Warning: Button", button:GetName(), "does not have a .Label child. Applying to button itself.")
            ApplyTranslationToElement(button)
         end
      end
   end
end

function MF.ST_GroupPVPFinder()
   --print("ST_GroupPVPFinder");
   -- Player vs. Player
   if (TT_PS["ui3"] == "1") then
      local gfpvpobj01 = PVPQueueFrameCategoryButton1.Name;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj01, true, "ui");

      local gfpvpobj02 = PVPQueueFrameCategoryButton2.Name;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj02, true, "ui");

      local gfpvpobj03 = PVPQueueFrameCategoryButton3.Name;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj03, true, "ui");

      local gfpvpobj04 = PVPQueueFrame.NewSeasonPopup.NewSeason;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj04, true, "ui");

      local gfpvpobj05 = PVPQueueFrame.NewSeasonPopup.SeasonDescriptionHeader;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj05, true, "ui");

      local gfpvpobj06 = PVPQueueFrame.NewSeasonPopup.SeasonDescription;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj06, true, "ui");

      local gfpvpobj07 = PVPQueueFrame.NewSeasonPopup.SeasonRewardText;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj07, true, "ui");

      local gfpvpobj08 = PVPQueueFrame.NewSeasonPopup.Leave.Text;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj08, true, "ui");

      local gfpvpobj09 = PVPQueueFrame.HonorInset.CasualPanel.HKLabel;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj09, true, "ui");

      local gfpvpobj10 = PVPQueueFrame.HonorInset.CasualPanel.HonorLevelDisplay.LevelLabel;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj10, true, "ui");

      local gfpvpobj11 = HonorFrameQueueButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj11, true, "ui");

      local gfpvpobj12 = PVPQueueFrame.HonorInset.RatedPanel.Label; -- Great Vault
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj12, true, "ui");

      local gfpvpobj13 = PVPQueueFrame.HonorInset.RatedPanel.Tier.Title; -- Season High
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj13, true, "ui");

      local gfpvpobj14 = ConquestJoinButtonText; -- Join Battle
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj14, true, "ui");

      local gfpvpobj15 = LFGListFrame.CategorySelection.Label; -- Premade Groups
      T.ST_CheckAndReplaceTranslationTextUI(gfpvpobj15, true, "ui");
   end
end

function MF.ST_GroupMplusFinder()
   if TT_PS["ui3"] == "1" then
      local elements = {
         { ChallengesFrame.SeasonChangeNoticeFrame.NewSeason,          "ui" },
         { ChallengesFrame.SeasonChangeNoticeFrame.SeasonDescription,  "ui" },
         { ChallengesFrame.SeasonChangeNoticeFrame.SeasonDescription2, "ui" },
         { ChallengesFrame.WeeklyInfo.Child.Description,               "ui" },
         { ChallengesFrame.WeeklyInfo.Child.SeasonBest,                "ui" },
         { ChallengesFrame.WeeklyInfo.Child.ThisWeekLabel,             "ui" },
         { ChallengesFrame.WeeklyInfo.Child.WeeklyChest.RunStatus,     "ui" },
         { ChallengesFrame.WeeklyInfo.Child.DungeonScoreInfo.Title,    "ui" },
      };

      for _, elementData in ipairs(elements) do
         local element, prefix = unpack(elementData);
         if WoWTR_Localization.lang == 'AR' then
            T.ST_CheckAndReplaceTranslationText(element, true, prefix, false, false, -10);
         else
            T.ST_CheckAndReplaceTranslationTextUI(element, true, prefix);
         end
      end
   end
end

function MF.ST_MerchantFrame()
   --print("ST_MerchantFrame");
   if (TT_PS["ui1"] == "1") then
      local MercTab1 = MerchantFrameTab1.Text;
      T.ST_CheckAndReplaceTranslationTextUI(MercTab1, true, "ui");

      local MercTab2 = MerchantFrameTab2.Text;
      T.ST_CheckAndReplaceTranslationTextUI(MercTab2, true, "ui");
   end
end

function MF.ST_GameMenuTranslate()
   if TT_PS["ui1"] ~= "1" then return end

   local function SafeUpdateText(textObject)
      if not textObject or not textObject.GetText then return end
      local originalText = textObject:GetText()
      if not originalText then return end

      local hash = StringHash(U.ST_UsunZbedneZnaki(originalText))
      if ST_TooltipsHS[hash] then
         local translatedText = QTR_ReverseIfAR(ST_TooltipsHS[hash]) .. NONBREAKINGSPACE
         C_Timer.After(0.01, function()
            if textObject:GetText() == originalText then
               textObject:SetText(translatedText)
               if textObject.SetFont then
                  textObject:SetFont(WOWTR_Font2, select(2, textObject:GetFont()))
               end
            end
         end)
         -- elseif ST_PM["saveNW"] == "1" then
         -- ST_PH[hash] = "ui@" .. U.ST_PrzedZapisem(originalText)
      end
   end

   local function SafeUpdateButton(button)
      SafeUpdateText(button)

      local fontStates = {
         "Normal",
         "Highlight",
         "Disabled",
         "Pushed"
      }

      for _, state in ipairs(fontStates) do
         local getFontObject = button["Get" .. state .. "FontObject"]
         local setFontObject = button["Set" .. state .. "FontObject"]

         if getFontObject and setFontObject then
            local fontObject = getFontObject(button)
            if fontObject then
               fontObject:SetFont(WOWTR_Font2, select(2, fontObject:GetFont()))
               setFontObject(button, fontObject)
            end
         end
      end
   end

   SafeUpdateText(GameMenuFrame.Header.Text)

   local function SafeInitButtons()
      C_Timer.After(0.01, function()
         if GameMenuFrame.buttonPool then
            for buttonFrame in GameMenuFrame.buttonPool:EnumerateActive() do
               SafeUpdateButton(buttonFrame)
            end
         end
      end)
   end

   hooksecurefunc(GameMenuFrame, "InitButtons", SafeInitButtons)

   SafeInitButtons()
end

function MF.ST_MountJournal()
   --print(ST_MountJournal);
   if (TT_PS["ui4"] == "1") then
      local CJobj01 = MountJournalLore;
      local ST_MountName = MountJournalName:GetText();
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationText(CJobj01, true, "Collections:Mount:" .. (ST_MountName or ''), false, false, -10);
      else
         T.ST_CheckAndReplaceTranslationTextUI(CJobj01, true, "Collections:Mount:" .. (ST_MountName or '')); -- https://imgur.com/7INQmHh
      end

      local CJobj02 = MountJournalSummonRandomFavoriteButtonSpellName;
      T.ST_CheckAndReplaceTranslationText(CJobj02, false, "ui", false, false);

      local CJobj03 = MountJournal.BottomLeftInset.SlotLabel;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj03, false, "ui");

      local CJobj04 = MountJournal.MountDisplay.ModelScene.TogglePlayer.TogglePlayerText;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj04, false, "ui");

      local CJobj05 = MountJournal.MountCount.Label;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj05, false, "ui");

      local CJobj06 = CollectionsJournalTitleText;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj06, false, "ui");

      local CJobj07 = MountJournalMountButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj07, false, "ui");

      local CJobj13 = WardrobeCollectionFrameTab1.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj13, false, "ui");

      local CJobj14 = WardrobeCollectionFrameTab2.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj14, false, "ui");

      local CJobj15 = MountJournalSearchBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj15, false, "ui");

      local CJobj16 = PetJournalSearchBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj16, false, "ui");

      local CJobj17 = PetJournal.PetCount.Label;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj17, false, "ui");

      local CJobj18 = PetJournalSummonButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj18, false, "ui");

      local CJobj19 = PetJournalFindBattle.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj19, false, "ui");

      local CJobj20 = PetJournalSummonRandomFavoritePetButtonSpellName;
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationText(CJobj20, false, "ui", false, false);
      else
         T.ST_CheckAndReplaceTranslationTextUI(CJobj20, false, "ui");
      end

      local CJobj21 = PetJournalHealPetButtonSpellName;
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationText(CJobj21, false, "ui", false, false);
      else
         T.ST_CheckAndReplaceTranslationTextUI(CJobj21, false, "ui");
      end

      local CJobj22 = MountJournal.FilterDropdown.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj22, false, "ui");

      local CJobj23 = PetJournal.FilterDropdown.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj23, false, "ui");

      local CJobj24 = ToyBox.searchBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj24, false, "ui");

      local CJobj25 = ToyBox.FilterDropdown.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj25, false, "ui");

      local CJobj26 = ToyBox.PagingFrame.PageText;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj26, false, "ui");

      local CJobj27 = HeirloomsJournalSearchBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj27, false, "ui");

      local CJobj28 = HeirloomsJournal.FilterDropdown.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj28, false, "ui");

      local CJobj29 = HeirloomsJournal.PagingFrame.PageText;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj29, false, "ui");

      local CJobj30 = WardrobeCollectionFrameSearchBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj30, false, "ui");

      local CJobj31 = WardrobeCollectionFrame.FilterButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj31, false, "ui");

      local CJobj32 = WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.PageText;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj32, false, "ui");

      for i = 1, 18 do
         local CJToys = ToyBox.iconsFrame["spellButton" .. i].name;
         T.ST_CheckAndReplaceTranslationTextUI(CJToys, true, "toyname");
      end
   end

   if (TT_PS["ui5"] == "1") then
      local CJobj08 = CollectionsJournalTab1.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj08, false, "ui");

      local CJobj09 = CollectionsJournalTab2.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj09, false, "ui");

      local CJobj10 = CollectionsJournalTab3.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj10, false, "ui");

      local CJobj11 = CollectionsJournalTab4.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj11, false, "ui");

      local CJobj12 = CollectionsJournalTab5.Text;
      T.ST_CheckAndReplaceTranslationTextUI(CJobj12, false, "ui");
   end
end

local isMountButtonCreated = false
local mountUpdateVisibility

function MF.ST_MountJournalbutton()
   if not isMountButtonCreated then
      TT_PS = TT_PS or { ui4 = "1" }

      mountUpdateVisibility = CreateToggleButton(
         MountJournal,
         TT_PS,
         "ui4",
         WoWTR_Localization.WoWTR_enDESC,
         WoWTR_Localization.WoWTR_trDESC,
         { "TOPLEFT", MountJournal, "TOPRIGHT", -170, 0 },
         function()
            MF.ST_MountJournal()
            -- You can add any necessary refresh logic here for the mount journal.
         end
      )

      isMountButtonCreated = true -- Mark that the button has been created to avoid duplication.
   end

   -- Adjust visibility of the existing button
   if mountUpdateVisibility then
      mountUpdateVisibility()
   end
end

function MF.ST_CharacterFrame() -- https://imgur.com/FV5MXvb
   --print("ST_CharacterFrame");
   if (TT_PS["ui2"] == "1") then
      local ChFrame1 = CharacterStatsPane.ItemLevelCategory.Title; -- Item Level
      T.ST_CheckAndReplaceTranslationTextUI(ChFrame1, true, "ui");

      local ChFrame2 = CharacterStatsPane.AttributesCategory.Title; -- Attributes
      T.ST_CheckAndReplaceTranslationTextUI(ChFrame2, true, "ui");

      local ChFrame3 = CharacterStatsPane.EnhancementsCategory.Title; -- Enhancements
      T.ST_CheckAndReplaceTranslationTextUI(ChFrame3, true, "ui");

      local ChFrame4 = CharacterFrameTab1.Text; -- Character Tab
      T.ST_CheckAndReplaceTranslationTextUI(ChFrame4, true, "ui");

      local ChFrame5 = CharacterFrameTab2.Text; -- Reputation Tab
      T.ST_CheckAndReplaceTranslationTextUI(ChFrame5, true, "ui");

      local ChFrame6 = CharacterFrameTab3.Text; -- Currency Tab
      T.ST_CheckAndReplaceTranslationTextUI(ChFrame6, true, "ui");

      local ChFrame7 = ReputationFrame.ReputationDetailFrame.ScrollingDescription.ScrollBox.ScrollTarget; -- https://imgur.com/A77RwLM
      local childFrame = select(1, ChFrame7:GetChildren())                                                -- Get the first child frame
      if childFrame and childFrame.FontString and childFrame.FontString.GetText then
         local text = childFrame.FontString:GetText()                                                     -- Get the text
         --print("ChFrame7 text: " .. text)  -- Print the text to the console
         local RDFactionName = ReputationFrame.ReputationDetailFrame.Title:GetText();                     -- Get the Faction Name
         T.ST_CheckAndReplaceTranslationTextUI(childFrame.FontString, true, "Factions:" .. U.ST_RenkKoduSil(RDFactionName));
      else
         --print("ChFrame7 text not found.");
      end

      local ChFrame8 = ReputationDetailAtWarCheckBoxText; -- Check Box Text - At War
      T.ST_CheckAndReplaceTranslationTextUI(ChFrame8, true, "ui");

      local ChFrame9 = ReputationDetailInactiveCheckBoxText; -- Check Box Text - Move to Inactive
      T.ST_CheckAndReplaceTranslationTextUI(ChFrame9, true, "ui");

      local ChFrame10 = ReputationDetailMainScreenCheckBoxText; -- Check Box Text - Show as Experience Bar
      T.ST_CheckAndReplaceTranslationTextUI(ChFrame10, true, "ui");
   end
end

function MF.ST_FriendsFrame()
   --print("ST_FriendsFrame");
   if (TT_PS["ui6"] == "1") then
      local Friendsobj01 = FriendsFrameTitleText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj01, true, "ui");

      local Friendsobj02 = FriendsTabHeaderTab1.Text;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj02, true, "ui");

      local Friendsobj03 = FriendsTabHeaderTab2.Text;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj03, true, "ui");

      local Friendsobj04 = FriendsTabHeaderTab3.Text;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj04, true, "ui");

      local Friendsobj05 = FriendsFrameTab1.Text;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj05, true, "ui");

      local Friendsobj06 = FriendsFrameTab2.Text;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj06, true, "ui");

      local Friendsobj07 = FriendsFrameTab3.Text;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj07, true, "ui");

      local Friendsobj08 = FriendsFrameTab4.Text;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj08, true, "ui");

      local Friendsobj09 = FriendsFrameAddFriendButtonText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj09, true, "ui");

      local Friendsobj10 = FriendsFrameSendMessageButtonText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj10, true, "ui");

      local Friendsobj11 = FriendsFrameIgnorePlayerButtonText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj11, true, "ui");

      local Friendsobj12 = FriendsFrameUnsquelchButtonText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj12, true, "ui");

      local Friendsobj13 = WhoFrameWhoButtonText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj13, true, "ui");

      local Friendsobj14 = WhoFrameAddFriendButtonText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj14, true, "ui");

      local Friendsobj15 = WhoFrameGroupInviteButtonText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj15, true, "ui");

      local Friendsobj16 = WhoFrameTotals;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj16, true, "ui");

      local Friendsobj17 = RaidFrameConvertToRaidButtonText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj17, true, "ui");

      local Friendsobj18 = RaidFrameRaidInfoButtonText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj18, true, "ui");

      local Friendsobj19 = RaidFrameRaidDescription;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj19, true, "ui");

      local Friendsobj20 = RecruitAFriendRecruitmentFrame.Title;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj20, true, "ui");

      local Friendsobj21 = RecruitAFriendRecruitmentFrame.Description;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj21, true, "ui");

      local Friendsobj22 = RecruitAFriendRecruitmentFrame.FactionAndRealm;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj22, true, "ui");

      local Friendsobj23 = RecruitAFriendFrame.RecruitList.Header.RecruitedFriends;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj23, true, "ui");

      local Friendsobj24 = RecruitAFriendFrame.RecruitmentButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj24, true, "ui");



      local Friendsobj26 = RecruitAFriendFrame.RewardClaiming.MonthCount.Text;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj26, true, "ui");

      local Friendsobj27 = RecruitAFriendFrameText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj27, true, "ui");

      local Friendsobj28 = RecruitAFriendRecruitmentFrame.EditBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj28, true, "ui");

      local Friendsobj29 = RecruitAFriendRecruitmentFrameText;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj29, true, "ui");

      local Friendsobj30 = RecruitAFriendRecruitmentFrame.InfoText1;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj30, true, "ui");

      local Friendsobj31 = RecruitAFriendRecruitmentFrame.InfoText2;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj31, true, "ui");

      local Friendsobj32 = RecruitAFriendFrame.RewardClaiming.EarnInfo;
      T.ST_CheckAndReplaceTranslationTextUI(Friendsobj32, true, "ui");
   end
end

function MF.ST_HelpPlateTooltip() -- https://imgur.com/MkPVoFr
   --print("ST_HelpPlateTooltip");
   if (TT_PS["active"] == "1") then
      local HPT01 = HelpPlateTooltip.Text;
      T.ST_CheckAndReplaceTranslationTextUI(HPT01, true, "ui");
   end
end

function MF.ST_SplashFrame() -- https://imgur.com/80WLNbC       You can use FontFile: Original_Font1, Original_Font2
   --print("ST_SplashFrame");
   if (TT_PS["active"] == "1") then
      local SplashF01 = SplashFrame.Header;
      T.ST_CheckAndReplaceTranslationTextUI(SplashF01, true, "ui");

      local SplashF02 = SplashFrame.Label;
      T.ST_CheckAndReplaceTranslationTextUI(SplashF02, true, "ui");

      local SplashF03 = SplashFrame.TopLeftFeature.Description;
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationText(SplashF03, true, "ui", false, false, -10);
         SplashF03:SetJustifyH("RIGHT");
      else
         T.ST_CheckAndReplaceTranslationTextUI(SplashF03, true, "ui");
      end

      local SplashF04 = SplashFrame.BottomLeftFeature.Description;
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationText(SplashF04, true, "ui", false, false, -15);
         SplashF04:SetJustifyH("RIGHT");
      else
         T.ST_CheckAndReplaceTranslationTextUI(SplashF04, true, "ui");
      end

      local SplashF05 = SplashFrame.RightFeature.Description;
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationText(SplashF05, true, "ui", false, false, -10);
      else
         T.ST_CheckAndReplaceTranslationTextUI(SplashF05, true, "ui");
      end

      local SplashF06 = SplashFrame.BottomCloseButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(SplashF06, true, "ui");

      local SplashF07 = SplashFrame.TopLeftFeature.Title;
      T.ST_CheckAndReplaceTranslationTextUI(SplashF07, true, "ui");

      local SplashF08 = SplashFrame.BottomLeftFeature.Title;
      T.ST_CheckAndReplaceTranslationTextUI(SplashF08, true, "ui");

      local SplashF09 = SplashFrame.RightFeature.Title;
      T.ST_CheckAndReplaceTranslationTextUI(SplashF09, true, "ui");
   end
end

function MF.ST_PingSystemTutorial() -- https://imgur.com/tv61op7      You can use FontFile: Original_Font1, Original_Font2
   --print("ST_PingSystemTutorial");
   if (TT_PS["active"] == "1") then
      local PST01 = PingSystemTutorialTitleText;
      T.ST_CheckAndReplaceTranslationTextUI(PST01, true, "ui");

      local PST02 = PingSystemTutorial.Tutorial1.TutorialHeader;
      T.ST_CheckAndReplaceTranslationTextUI(PST02, true, "ui");

      local PST03 = PingSystemTutorial.Tutorial2.TutorialHeader;
      T.ST_CheckAndReplaceTranslationTextUI(PST03, true, "ui");

      local PST04 = PingSystemTutorial.Tutorial3.TutorialHeader;
      T.ST_CheckAndReplaceTranslationTextUI(PST04, true, "ui");

      local PST05 = PingSystemTutorial.Tutorial4.TutorialHeader;
      T.ST_CheckAndReplaceTranslationTextUI(PST05, true, "ui");

      local PST06 = PingSystemTutorial.Tutorial4.ImageBounds.TutorialBody1;
      T.ST_CheckAndReplaceTranslationTextUI(PST06, true, "ui");

      local PST07 = PingSystemTutorial.Tutorial4.ImageBounds.TutorialBody2;
      T.ST_CheckAndReplaceTranslationTextUI(PST07, true, "ui");

      local PST08 = PingSystemTutorial.Tutorial4.ImageBounds.TutorialBody3;
      T.ST_CheckAndReplaceTranslationTextUI(PST08, true, "ui");
   end
end

function MF.ST_WarbandBankFrm()
   --print("ST_WarbandBankFrm")
   if (TT_PS["active"] == "1") then
      local BANKFrame01 = AccountBankPanel.PurchasePrompt.Title;
      T.ST_CheckAndReplaceTranslationTextUI(BANKFrame01, false, "ui");

      local BANKFrame02 = AccountBankPanel.PurchasePrompt.PromptText;
      T.ST_CheckAndReplaceTranslationTextUI(BANKFrame02, false, "ui");

      local BANKFrame03 = AccountBankPanel.PurchasePrompt.TabCostFrame.PurchaseButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(BANKFrame03, false, "ui");

      local BANKFrame04 = AccountBankPanel.PurchasePrompt.TabCostFrame.TabCost;
      T.ST_CheckAndReplaceTranslationTextUI(BANKFrame04, false, "ui");

      local BANKFrame05 = AccountBankPanel.MoneyFrame.WithdrawButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(BANKFrame05, false, "ui");

      local BANKFrame06 = AccountBankPanel.MoneyFrame.DepositButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(BANKFrame06, false, "ui");

      local BANKFrame07 = AccountBankPanel.ItemDepositFrame.DepositButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(BANKFrame07, false, "ui");

      local BANKFrame08 = AccountBankPanel.ItemDepositFrame.IncludeReagentsCheckbox.Text;
      T.ST_CheckAndReplaceTranslationTextUI(BANKFrame08, false, "ui");

      local BANKFrame09 = BankItemSearchBox.Instructions;
      T.ST_CheckAndReplaceTranslationTextUI(BANKFrame09, false, "ui");
   end
end

local function shouldIgnore(text)
   for _, ignoreText in ipairs(C.ItemRefTooltipIgnoreList) do
      if text:find(ignoreText) then
         return true
      end
   end
   return false
end

function MF.ST_ItemRefTooltip() -- https://imgur.com/a/5Ooqnb2
   for i = 2, 30 do
      local itemRefLeft = _G["ItemRefTooltipTextLeft" .. i]
      if itemRefLeft and itemRefLeft:GetText() then
         local text = itemRefLeft:GetText()
         if not shouldIgnore(text) then
            T.ST_CheckAndReplaceTranslationTextUI(itemRefLeft, true, "other")
         end
      end

      local itemRefRight = _G["ItemRefTooltipTextRight" .. i]
      if itemRefRight and itemRefRight:GetText() then
         local text = itemRefRight:GetText()
         if not shouldIgnore(text) then
            T.ST_CheckAndReplaceTranslationTextUI(itemRefRight, true, "other")
         end
      end
   end
end

function MF.ST_ItemUpgradeFrm() -- https://imgur.com/a/Vy6wNjO
   if (TT_PS["ui1"] == "1") then
      local ItemUpFrm01 = ItemUpgradeFrameTitleText;
      T.ST_CheckAndReplaceTranslationTextUI(ItemUpFrm01, false, "ui");
      local ItemUpFrm02 = ItemUpgradeFrame.ItemInfo.MissingItemText;
      T.ST_CheckAndReplaceTranslationTextUI(ItemUpFrm02, false, "ui");
      local ItemUpFrm03 = ItemUpgradeFrame.MissingDescription;
      T.ST_CheckAndReplaceTranslationTextUI(ItemUpFrm03, false, "ui");
      local ItemUpFrm04 = ItemUpgradeFrame.UpgradeButton.Text;
      T.ST_CheckAndReplaceTranslationTextUI(ItemUpFrm04, false, "ui");
      local ItemUpFrm05 = ItemUpgradeFrame.UpgradeCostFrame.Label;
      T.ST_CheckAndReplaceTranslationTextUI(ItemUpFrm05, false, "ui");
      local ItemUpFrm06 = ItemUpgradeFrame.ItemInfo.UpgradeTo;
      T.ST_CheckAndReplaceTranslationTextUI(ItemUpFrm06, false, "ui");
      local ItemUpFrm07 = ItemUpgradeFrameLeftItemPreviewFrameTextLeft1;
      T.ST_CheckAndReplaceTranslationTextUI(ItemUpFrm07, false, "ui");
      local ItemUpFrm08 = ItemUpgradeFrameRightItemPreviewFrameTextLeft1;
      T.ST_CheckAndReplaceTranslationTextUI(ItemUpFrm08, false, "ui");
   end
end

function MF.ST_WeeklyRewardsFrame()
   if (TT_PS["ui1"] == "1") then
      local WeeklyRFrm01 = WeeklyRewardsFrame.HeaderFrame.Text
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationText(WeeklyRFrm01, false, "ui", WOWTR_Font1, false, 5)
      else
         T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm01, false, "ui")
      end
      local WeeklyRFrm02 = WeeklyRewardsFrame.RaidFrame.Name
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm02, false, "ui", WOWTR_Font1)
      else
         T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm02, false, "ui")
      end
      local WeeklyRFrm03 = WeeklyRewardsFrame.MythicFrame.Name
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm03, false, "ui", WOWTR_Font1)
      else
         T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm03, false, "ui")
      end
      local WeeklyRFrm04 = WeeklyRewardsFrame.WorldFrame.Name
      if (WoWTR_Localization.lang == 'AR') then
         T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm04, false, "ui", WOWTR_Font1)
      else
         T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm04, false, "ui")
      end
      if WeeklyRewardsFrame.Overlay and WeeklyRewardsFrame.Overlay.Title then
         local WeeklyRFrm05 = WeeklyRewardsFrame.Overlay.Title
         if (WoWTR_Localization.lang == 'AR') then
            T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm05, true, "ui", WOWTR_Font1)
         else
            T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm05, true, "ui")
         end
      end
      if WeeklyRewardsFrame.Overlay and WeeklyRewardsFrame.Overlay.Text then
         local WeeklyRFrm06 = WeeklyRewardsFrame.Overlay.Text
         if (WoWTR_Localization.lang == 'AR') then
            T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm06, true, "ui", WOWTR_Font1)
         else
            T.ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm06, true, "ui")
         end
      end
   end
end

function MF.ST_EventToastManagerFrame()
   if (TT_PS["ui1"] == "1") then
      local toast = EventToastManagerFrame.currentDisplayingToast
      if toast then
         local EventTextScreen01 = toast.Title
         T.ST_CheckAndReplaceTranslationTextUI(EventTextScreen01, true, "Collections:TextEvent", WOWTR_Font1)

         local EventTextScreen02 = toast.SubTitle
         T.ST_CheckAndReplaceTranslationTextUI(EventTextScreen02, true, "Collections:TextEvent")

         local EventTextScreen03 = toast.Description
         T.ST_CheckAndReplaceTranslationTextUI(EventTextScreen03, true, "Collections:TextEvent")

         if toast.Contents then
            local EventTextScreen04 = toast.Contents.Title
            T.ST_CheckAndReplaceTranslationTextUI(EventTextScreen04, true, "Collections:TextEvent", WOWTR_Font1)

            local EventTextScreen05 = toast.Contents.SubTitle
            T.ST_CheckAndReplaceTranslationTextUI(EventTextScreen05, true, "Collections:TextEvent")

            local EventTextScreen06 = toast.Contents.Description
            T.ST_CheckAndReplaceTranslationTextUI(EventTextScreen06, true, "Collections:TextEvent")
         end
      end
   end
end

function MF.ST_RaidBossEmoteFrame()
   if (TT_PS["ui1"] == "1") then
      local RBossEmoteFrm04 = RaidBossEmoteFrame.slot1Text
      T.ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm04, false, "Collections:Emote")
      local RBossEmoteFrm05 = RaidBossEmoteFrame.slot2Text
      T.ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm05, false, "Collections:Emote")
      local RBossEmoteFrm06 = RaidBossEmoteFrame.slot3Text
      T.ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm06, false, "Collections:Emote")
      local RBossEmoteFrm01 = RaidBossEmoteFrame.slot1
      T.ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm01, true, "Collections:Emote")
      local RBossEmoteFrm02 = RaidBossEmoteFrame.slot2
      T.ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm02, true, "Collections:Emote")
      local RBossEmoteFrm03 = RaidBossEmoteFrame.slot3
      T.ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm03, true, "Collections:Emote")
   end
end

function MF.ST_ElvSpellBookTooltipOnShow()
   local E, L, V, P, G = unpack(ElvUI);
   local ElvUISpellBookTooltip = E.SpellBookTooltip;
   local numLines = ElvUISpellBookTooltip:NumLines();

   if (numLines == 1) then -- ElvUISpellBookTooltip zawiera tylko 1 linijkę opisu i jest to tytuł spella
      return;
   end

   if (ST_PM["spell"] == "0") then
      return;
   end

   local ST_kodKoloru;
   local ST_leftText, ST_rightText, ST_tlumaczenie, ST_hash, ST_hash2;
   local _font1, _size1, _1;

   local ST_prefix = "s";
   if (ElvUISpellBookTooltip.processingInfo and ElvUISpellBookTooltip.processingInfo.tooltipData.id) then
      ST_prefix = ST_prefix .. ElvUISpellBookTooltip.processingInfo.tooltipData.id;
   end
   ElvUISpellBookTooltip:HookScript("OnHide", function() ST_MyGameTooltip:Hide(); end);
   ST_MyGameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
   ST_MyGameTooltip:ClearAllPoints();
   ST_MyGameTooltip:SetPoint("TOPLEFT", ElvUISpellBookTooltip, "BOTTOMLEFT", 0, 0); -- pod przyciskiem od lewej strony
   ST_MyGameTooltip:ClearLines();
   for i = 2, numLines - 1, 1 do
      ST_leftText = _G[ElvUISpellBookTooltip:GetName() .. "TextLeft" .. i]:GetText();
      leftColR, leftColG, leftColB = _G[ElvUISpellBookTooltip:GetName() .. "TextLeft" .. i]:GetTextColor();
      ST_kodKoloru = U.OkreslKodKoloru(leftColR, leftColG, leftColB);
      if (ST_leftText and (string.len(ST_leftText) > 15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText) > 30))) then
         ST_hash = StringHash(U.ST_UsunZbedneZnaki(ST_leftText));
         if (((ST_kodKoloru == "c7") or (string.len(ST_leftText) > 30)) and (not ST_hash2)) then
            ST_hash2 = ST_hash;
         end
         if (ST_TooltipsHS[ST_hash]) then -- mamy przetłumaczony ten Hash
            ST_tlumaczenie = ST_TooltipsHS[ST_hash];
            ST_tlumaczenie = U.ST_TranslatePrepare(ST_leftText, ST_tlumaczenie);
            ST_MyGameTooltip:AddLine(QTR_ReverseIfAR(ST_tlumaczenie), leftColR, leftColG, leftColB, true);
            numLines = ST_MyGameTooltip:NumLines();                                                -- aktualna liczba linii
            _font1, _size1, _1 = _G[ElvUISpellBookTooltip:GetName() .. "TextLeft" .. i]:GetFont(); -- odczytaj aktualną czcionkę i rozmiar
            _G["ST_MyGameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 11);                   -- ustawiamy własną czcionkę
         end
      end
   end

   if (((ST_PM["showID"] == "1") and (string.len(ST_prefix) > 1)) or ((ST_PM["showHS"] == "1") and ST_hash2)) then -- czy dodawać ID i Hash ?
      numLines = ST_MyGameTooltip:NumLines();                                                                      -- aktualna liczba linii
      if (numLines == 0) then
         ST_MyGameTooltip:AddLine(QTR_Messages.missing, 1, 1, 0.5);
         _G["ST_MyGameTooltipTextLeft1"]:SetFont(WOWTR_Font2, 11); -- ustawiamy czcionkę turecką
      end
      ST_MyGameTooltip:AddLine(" ", 0, 0, 0);                      -- dodaj odstęp przed linią z ID
      typName = "Spell";
      ST_ID = string.sub(ST_prefix, 2);
      if ((ST_PM["showID"] == "1") and ST_ID) then
         ST_MyGameTooltip:AddLine(typName .. " ID: " .. tostring(ST_ID), 0, 1, 1);
         numLines = ST_MyGameTooltip:NumLines();                              -- Aktualna liczba linii w ST_MyGameTooltip
         _G["ST_MyGameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 10); -- wielkość 12
      end
      if ((ST_PM["showHS"] == "1") and ST_hash2) then
         ST_MyGameTooltip:AddLine("Hash: " .. tostring(ST_hash2), 0, 1, 1);
         numLines = ST_MyGameTooltip:NumLines();                              -- Aktualna liczba linii w ST_MyGameTooltip
         _G["ST_MyGameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 10); -- wielkość 12
      end
   end

   ST_MyGameTooltip:Show(); -- wyświetla ramkę w tłumaczeniem (zrobi także resize)
end

function MF.ST_updateSpellBookFrame()
   if (TT_PS["ui1"] == "1") then --Game Option UI
      local ST_titleTextFontString = SpellBookFrame:GetTitleText();
      if (ST_titleTextFontString and ST_titleTextFontString:GetText()) then
         local str_ID = StringHash(U.ST_UsunZbedneZnaki(ST_titleTextFontString:GetText()));
         if (ST_TooltipsHS[str_ID]) then
            local text0 = QTR_ReverseIfAR(ST_titleTextFontString:GetText());
            ST_titleTextFontString:SetText(U.ST_SetText(text0));
         end
      end

      if (SpellBookFrameTabButton1 and SpellBookFrameTabButton1:GetText()) then
         local str_ID = StringHash(U.ST_UsunZbedneZnaki(SpellBookFrameTabButton1:GetText()));
         if (ST_TooltipsHS[str_ID]) then
            local text1 = QTR_ReverseIfAR(U.ST_SetText(SpellBookFrameTabButton1:GetText()));
            local fo = SpellBookFrameTabButton1:CreateFontString();
            fo:SetFont(WOWTR_Font2, 11);
            fo:SetText(text1);
            SpellBookFrameTabButton1:SetFontString(fo);
            SpellBookFrameTabButton1:SetText(text1);
         end
      end

      if (SpellBookFrameTabButton2 and SpellBookFrameTabButton2:GetText()) then
         local str_ID = StringHash(U.ST_UsunZbedneZnaki(SpellBookFrameTabButton2:GetText()));
         if (ST_TooltipsHS[str_ID]) then
            local text1 = QTR_ReverseIfAR(U.ST_SetText(SpellBookFrameTabButton2:GetText()));
            local fo = SpellBookFrameTabButton2:CreateFontString();
            fo:SetFont(WOWTR_Font2, 11);
            fo:SetText(text1);
            SpellBookFrameTabButton2:SetFontString(fo);
            SpellBookFrameTabButton2:SetText(text1);
         end
      end

      if (SpellBookFrameTabButton3 and SpellBookFrameTabButton3:GetText()) then
         local str_ID = StringHash(U.ST_UsunZbedneZnaki(SpellBookFrameTabButton3:GetText()));
         if (ST_TooltipsHS[str_ID]) then
            local text1 = QTR_ReverseIfAR(U.ST_SetText(SpellBookFrameTabButton3:GetText()));
            local fo = SpellBookFrameTabButton3:CreateFontString();
            fo:SetFont(WOWTR_Font2, 11);
            fo:SetText(text1);
            SpellBookFrameTabButton3:SetFontString(fo);
            SpellBookFrameTabButton3:SetText(text1);
         end
      end

      local SBPageText = SpellBookPageText;
      T.ST_CheckAndReplaceTranslationText(SBPageText, true, "ui");
   end
end

function MF.ST_AdvantureMapFrm()			-- https://imgur.com/a/uQElPgm
   if (QTR_PS["active"] == "1") then
	local AdvMapFrm01 = AdventureMapQuestChoiceDialog.Details.Child.TitleHeader;
	T.ST_CheckAndReplaceTranslationTextUI(AdvMapFrm01, true, "Collections:Quest", WOWTR_Font1);
	local AdvMapFrm02 = AdventureMapQuestChoiceDialog.Details.Child.DescriptionText;
	T.ST_CheckAndReplaceTranslationTextUI(AdvMapFrm02, true, "Collections:Quest");
	local AdvMapFrm04 = AdventureMapQuestChoiceDialog.Details.Child.ObjectivesText;
	T.ST_CheckAndReplaceTranslationTextUI(AdvMapFrm04, true, "Collections:Quest");
   end
   if (TT_PS["ui1"] == "1") then
	local AdvMapFrm03 = AdventureMapQuestChoiceDialog.Details.Child.ObjectivesHeader;
	T.ST_CheckAndReplaceTranslationTextUI(AdvMapFrm03, false, "ui", WOWTR_Font1);
	local AdvMapFrm05 = AdventureMapQuestChoiceDialog.RewardsHeader;
	T.ST_CheckAndReplaceTranslationTextUI(AdvMapFrm05, false, "ui", WOWTR_Font1);
	local AdvMapFrm06 = AdventureMapQuestChoiceDialog.AcceptButton.Text;
	T.ST_CheckAndReplaceTranslationTextUI(AdvMapFrm06, false, "ui");
	local AdvMapFrm07 = AdventureMapQuestChoiceDialog.DeclineButton.Text;
	T.ST_CheckAndReplaceTranslationTextUI(AdvMapFrm07, false, "ui");
   end
end

function MF.ST_TalentsTranslate()
    local talentsFrame = PlayerSpellsFrame and PlayerSpellsFrame.TalentsFrame
    if not talentsFrame then return end

    T.HandleElementUpdate(talentsFrame.HeroTalentsContainer and talentsFrame.HeroTalentsContainer.LockedLabel1, false)
    T.HandleElementUpdate(talentsFrame.HeroTalentsContainer and talentsFrame.HeroTalentsContainer.LockedLabel2, false)
end

function MF.ST_updateSpecContentsHook()
    if not PlayerSpellsFrame or not PlayerSpellsFrame.SpecFrame or not PlayerSpellsFrame.SpecFrame.SpecContentFramePool then
        return
    end

    for specContentFrame in PlayerSpellsFrame.SpecFrame.SpecContentFramePool:EnumerateActive() do
        -- Update standard text elements
        T.HandleElementUpdate(specContentFrame.RoleName, false)
        T.HandleElementUpdate(specContentFrame.SampleAbilityText, false)
        T.HandleElementUpdate(specContentFrame.ActivatedText, false)
        T.HandleElementUpdate(specContentFrame.ActivateButton and specContentFrame.ActivateButton.Text, false)

        -- Update description (handled as 'description' type by the helper)
        T.HandleElementUpdate(specContentFrame.Description, true)

        -- <<< ADDED: Specific SaveNW Logic for Spec Description (if toggle ON and translation failed) >>>
        if TT_PS["ui_talents"] == "1" and ST_PM and ST_PM["saveNW"] == "1" then
            local descriptionElement = specContentFrame.Description
            if descriptionElement then
                local successGetText, originalText = pcall(descriptionElement.GetText, descriptionElement)
                -- Check if text exists and wasn't translated (no NBSP added by HandleElementUpdate/ApplyTranslationIfFound)
                if successGetText and originalText and #originalText > 0 and not string.find(originalText, NONBREAKINGSPACE) then
                    local textForHash = U.ST_UsunZbedneZnaki(originalText)
                    local ST_hash = StringHash(textForHash)
                    -- Double-check if it's really not in the table (HandleElementUpdate->ApplyTranslationIfFound already checked)
                    if not ST_TooltipsHS[ST_hash] then
                        -- Get spec name safely (Prioritize SpecName for actual specialization)
                        local specName = "UnknownSpec"
                        if specContentFrame.SpecName then -- <<<< PRIORITIZE THIS
                             local successGetName, nameResult = pcall(specContentFrame.SpecName.GetText, specContentFrame.SpecName)
                             if successGetName and nameResult then specName = nameResult end
                        -- Fallback: Try RoleName if SpecName failed or wasn't present
                        elseif specContentFrame.RoleName then -- <<<< FALLBACK
                            local successGetName, nameResult = pcall(specContentFrame.RoleName.GetText, specContentFrame.RoleName)
                            if successGetName and nameResult then specName = nameResult end
                        end
                        -- Construct placeholder string
                        local placeholder = "SpecTab:" ..
                            (WOWTR_player_class or "UnknownClass") .. ":" .. specName ..
                            "@" ..
                            U.ST_PrzedZapisem(originalText:gsub("(%%d),(%%d)", "%%1%%2"):gsub("\r", "")) -- Escaped % for gsub
                        ST_PH = ST_PH or {} -- Ensure placeholder table exists
                        ST_PH[ST_hash] = placeholder
                    end
                end
            end
        end
        -- <<< END ADDED >>>
    end
end

function MF.ST_updateHeroTalentHook()
    if not HeroTalentsSelectionDialog or not HeroTalentsSelectionDialog.SpecContentFramePool then
        return
    end

    local activeFrameFunction = HeroTalentsSelectionDialog.SpecContentFramePool:EnumerateActive()
    if activeFrameFunction then
        for frame in activeFrameFunction do
            -- Update elements using the helper
            T.HandleElementUpdate(frame.CurrencyFrame and frame.CurrencyFrame.LabelText, false)
            T.HandleElementUpdate(frame.ActivatedText, false)
            T.HandleElementUpdate(frame.ActivateButton and frame.ActivateButton.Text, false)
            T.HandleElementUpdate(frame.Description, true) -- Handles translation/revert

            -- <<< Specific SaveNW Logic for Description (if toggle ON and translation failed) >>>
            if TT_PS["ui_talents"] == "1" and ST_PM and ST_PM["saveNW"] == "1" then
                local descriptionElement = frame.Description
                if descriptionElement then
                    local successGetText, originalText = pcall(descriptionElement.GetText, descriptionElement)
                    -- Check if text exists and wasn't translated (no NBSP added by HandleElementUpdate/ApplyTranslationIfFound)
                    if successGetText and originalText and #originalText > 0 and not string.find(originalText, NONBREAKINGSPACE) then
                        local textForHash = U.ST_UsunZbedneZnaki(originalText)
                        local ST_hash = StringHash(textForHash)
                        -- Double-check if it's really not in the table (HandleElementUpdate already checked via ApplyTranslationIfFound)
                        if not ST_TooltipsHS[ST_hash] then
                            -- Get spec name safely
                            local specName = "UnknownSpec"
                            if frame.SpecName then -- Use SpecName here as it's likely correct for Hero Talents dialog
                                local successGetName, nameResult = pcall(frame.SpecName.GetText, frame.SpecName)
                                if successGetName and nameResult then specName = nameResult end
                            end
                            -- Construct placeholder string
                            local placeholder = "SpecTab:" ..
                                (WOWTR_player_class or "UnknownClass") .. ":" .. specName ..
                                "@" ..
                                U.ST_PrzedZapisem(originalText:gsub("(%%d),(%%d)", "%%1%%2"):gsub("\r", "")) -- Escaped % for gsub
                            ST_PH = ST_PH or
                                {}                                                                         -- Ensure placeholder table exists
                            ST_PH[ST_hash] = placeholder
                        end
                    end
                end
            end
        end
    end
end

addon.MF = MF
