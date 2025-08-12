local addonName, addon = ...
local C = addon.C
local U = addon.U
local T = addon.T
local MF = addon.MF
local EJ = addon.EJ

local E = {}

function E.WOWSTR_onEvent(_, event, addonName)
   --print(addonName);
   --QTR_PS["Test"] = Frame; -- search data
   if (QTR_PS) then
      C_Timer.After(1, function()
         QTR_ObjectiveTrackerFrame_Titles() -- Addon adds translations when it starts
      end)
   end
   if (addonName == 'Blizzard_PlayerSpells') then
      C.ST_load1 = true;

      -- Existing OnShow hooks (keep these)
      if PlayerSpellsFrame and PlayerSpellsFrame.SpecFrame then
         PlayerSpellsFrame.SpecFrame:HookScript("OnShow", MF.ST_updateSpecContentsHook);
      end
      if PlayerSpellsFrame and PlayerSpellsFrame.TalentsFrame then
         PlayerSpellsFrame.TalentsFrame:HookScript("OnShow", MF.ST_TalentsTranslate);
      end
      if HeroTalentsSelectionDialog and HeroTalentsSelectionDialog.SpecOptionsContainer then
         HeroTalentsSelectionDialog.SpecOptionsContainer:HookScript("OnShow", MF.ST_updateHeroTalentHook);
      end

      -- ADDED: Attempt hooksecurefunc here, after the addon is loaded
      if PlayerSpellsFrame and PlayerSpellsFrame.SpecFrame then
         local success, err = pcall(hooksecurefunc, PlayerSpellsFrame.SpecFrame, "UpdateSpecContents",
            MF.ST_updateSpecContentsHook)
         if not success then
            --print("WoWTR Tooltips: Failed to hook PlayerSpellsFrame.SpecFrame.UpdateSpecContents:", tostring(err))
         else
            --print("WoWTR Tooltips: Successfully hooked PlayerSpellsFrame.SpecFrame.UpdateSpecContents.")

            -- <<< ADDED: Trigger Talents.lua check/timer >>>
            if _G.StartPlayerSpellsFrameCheck then -- <<< CHANGED function name
               --print("WoWTR Tooltips: Triggering PlayerSpellsFrame check from Talents.lua.")
               _G.StartPlayerSpellsFrameCheck()    -- <<< CHANGED function name
            else
               --print("WoWTR Tooltips: ERROR - StartPlayerSpellsFrameCheck function not found in global scope!")
            end
            -- <<< END ADDED >>>
         end
      else
         --print("WoWTR Tooltips: PlayerSpellsFrame.SpecFrame not found when attempting hooksecurefunc.")
      end

   elseif (addonName == 'Blizzard_EncounterJournal') then
      C.ST_load2 = true;
      EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription:HookScript("OnShow", EJ.ST_clickBosses)
      EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription:HookScript("OnShow",
         function()
            StartTicker(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription,
               EJ.ST_ShowAbility, 0.1)
         end)
      EncounterJournal:HookScript("OnShow", function() StartTicker(EncounterJournal, EJ.ST_SuggestTabClick, 0) end)
      EncounterJournal:HookScript("OnShow", EJ.ST_AdventureGuidebutton)
      EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont:HookScript("OnShow", EJ.ST_showLoreDescription)

   elseif (addonName == 'Blizzard_Collections') then
      C.ST_load4 = true;
      CollectionsJournalTitleText:HookScript("OnShow",
         function() StartTicker(CollectionsJournalTitleText, MF.ST_MountJournal, 0.1) end)
      WardrobeCollectionFrame:HookScript("OnShow",
         function() StartTicker(WardrobeCollectionFrame, MF.ST_HelpPlateTooltip, 0.2) end)
      MountJournalName:HookScript("OnShow", MF.ST_MountJournalbutton)
   elseif (addonName == 'Blizzard_PVPUI') then
      C.ST_load5 = true;
      PVPQueueFrameCategoryButton1:HookScript("OnShow",
         function() StartTicker(PVPQueueFrameCategoryButton1, MF.ST_GroupPVPFinder, 0.02) end)
   elseif (addonName == 'Blizzard_ChallengesUI') then
      C.ST_load6 = true;
      ChallengesFrame:HookScript("OnShow", function() StartTicker(ChallengesFrame, MF.ST_GroupMplusFinder, 0) end)
   elseif (addonName == 'Blizzard_DelvesDifficultyPicker') then
      C.ST_load7 = true;
      DelvesDifficultyPickerFrame:HookScript("OnShow",
         function() StartTicker(DelvesDifficultyPickerFrame, MF.ST_showDelveDifficultFrame, 0.2) end)
   elseif (addonName == 'Blizzard_ItemUpgradeUI') then
      C.ST_load8 = true;
      ItemUpgradeFrame:HookScript("OnShow", function() StartTicker(ItemUpgradeFrame, MF.ST_ItemUpgradeFrm, 0.2) end)
   elseif (addonName == 'Blizzard_WeeklyRewards') then
      C.ST_load9 = true;
      WeeklyRewardsFrame:HookScript("OnShow", function() StartTicker(WeeklyRewardsFrame, MF.ST_WeeklyRewardsFrame, 0.2) end)
   elseif (addonName == 'Blizzard_AdventureMap') then
      C.ST_load10 = true;
      AdventureMapQuestChoiceDialog.Details.Child.DescriptionText:HookScript("OnShow",
         function() StartTicker(AdventureMapQuestChoiceDialog.Details.Child.DescriptionText, MF.ST_AdvantureMapFrm, 0.2) end)
   end

   -- Updated condition to remove ST_load3 and ST_load11
   if (C.ST_load1 and C.ST_load2 and C.ST_load4 and C.ST_load5 and C.ST_load6 and C.ST_load7 and C.ST_load8 and C.ST_load9 and C.ST_load10) then -- otworzono wszystkie inne dodatki Blizzarda
      WOWSTR:UnregisterEvent("ADDON_LOADED");                                                                                  -- wyłącz nasłuchiwanie
   end
end

function E.Initialize()
    WOWSTR = CreateFrame("Frame"); -- ramka czekająca na załadowanie modułu ClassTalentFrame
    WOWSTR:SetScript("OnEvent", E.WOWSTR_onEvent);
    WOWSTR:RegisterEvent("ADDON_LOADED");
end

addon.E = E
