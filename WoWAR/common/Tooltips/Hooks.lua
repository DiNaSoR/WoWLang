local addonName, ns = ...

ns = ns or {}
ns.Tooltips = ns.Tooltips or {}
local Tooltips = ns.Tooltips
local State = (Tooltips and Tooltips.State) or {}

Tooltips.Hooks = Tooltips.Hooks or {}
local Hooks = Tooltips.Hooks

function Hooks.OnEvent(_, event, addonName)
  if (QTR_PS) then
    C_Timer.After(1, function()
      if QTR_ObjectiveTrackerFrame_Titles then
        QTR_ObjectiveTrackerFrame_Titles()
      end
    end)
  end

  if (addonName == 'Blizzard_PlayerSpells') then
    ST_load1 = true
    if PlayerSpellsFrame and PlayerSpellsFrame.SpecFrame then
      PlayerSpellsFrame.SpecFrame:HookScript("OnShow", ST_updateSpecContentsHook)
    end
    if PlayerSpellsFrame and PlayerSpellsFrame.TalentsFrame then
      PlayerSpellsFrame.TalentsFrame:HookScript("OnShow", ST_TalentsTranslate)
    end
    if HeroTalentsSelectionDialog and HeroTalentsSelectionDialog.SpecOptionsContainer then
      HeroTalentsSelectionDialog.SpecOptionsContainer:HookScript("OnShow", ST_updateHeroTalentHook)
    end
    if PlayerSpellsFrame and PlayerSpellsFrame.SpecFrame then
      local success, err = pcall(hooksecurefunc, PlayerSpellsFrame.SpecFrame, "UpdateSpecContents", ST_updateSpecContentsHook)
      if success and _G.StartPlayerSpellsFrameCheck then
        _G.StartPlayerSpellsFrameCheck()
      end
    end
  elseif (addonName == 'Blizzard_EncounterJournal') then
    ST_load2 = true
    EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription:HookScript("OnShow", ST_clickBosses)
    EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription:HookScript("OnShow", function()
      StartTicker(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription, ST_ShowAbility, 0.1)
    end)
    EncounterJournal:HookScript("OnShow", function() StartTicker(EncounterJournal, ST_SuggestTabClick, 0) end)
    EncounterJournal:HookScript("OnShow", ST_AdventureGuidebutton)
    EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont:HookScript("OnShow", ST_showLoreDescription)
  elseif (addonName == 'Blizzard_Collections') then
    ST_load4 = true
    CollectionsJournalTitleText:HookScript("OnShow", function() StartTicker(CollectionsJournalTitleText, ST_MountJournal, 0.1) end)
    WardrobeCollectionFrame:HookScript("OnShow", function() StartTicker(WardrobeCollectionFrame, ST_HelpPlateTooltip, 0.2) end)
    MountJournalName:HookScript("OnShow", ST_MountJournalbutton)
  elseif (addonName == 'Blizzard_PVPUI') then
    ST_load5 = true
    PVPQueueFrameCategoryButton1:HookScript("OnShow", function() StartTicker(PVPQueueFrameCategoryButton1, ST_GroupPVPFinder, 0.02) end)
  elseif (addonName == 'Blizzard_ChallengesUI') then
    ST_load6 = true
    ChallengesFrame:HookScript("OnShow", function() StartTicker(ChallengesFrame, ST_GroupMplusFinder, 0) end)
  elseif (addonName == 'Blizzard_DelvesDifficultyPicker') then
    ST_load7 = true
    DelvesDifficultyPickerFrame:HookScript("OnShow", function() StartTicker(DelvesDifficultyPickerFrame, ST_showDelveDifficultFrame, 0.2) end)
  elseif (addonName == 'Blizzard_ItemUpgradeUI') then
    ST_load8 = true
    ItemUpgradeFrame:HookScript("OnShow", function() StartTicker(ItemUpgradeFrame, ST_ItemUpgradeFrm, 0.2) end)
  elseif (addonName == 'Blizzard_WeeklyRewards') then
    ST_load9 = true
    WeeklyRewardsFrame:HookScript("OnShow", function() StartTicker(WeeklyRewardsFrame, ST_WeeklyRewardsFrame, 0.2) end)
  elseif (addonName == 'Blizzard_AdventureMap') then
    ST_load10 = true
    if AdventureMapQuestChoiceDialog and AdventureMapQuestChoiceDialog.Details and AdventureMapQuestChoiceDialog.Details.Child and AdventureMapQuestChoiceDialog.Details.Child.DescriptionText then
      AdventureMapQuestChoiceDialog.Details.Child.DescriptionText:HookScript("OnShow", function()
        if ST_AdvantureMapFrm then
          StartTicker(AdventureMapQuestChoiceDialog.Details.Child.DescriptionText, ST_AdvantureMapFrm, 0.2)
        end
      end)
    end
  end

  if (ST_load1 and ST_load2 and ST_load4 and ST_load5 and ST_load6 and ST_load7 and ST_load8 and ST_load9 and ST_load10) then
    if WOWSTR and WOWSTR.UnregisterEvent then
      WOWSTR:UnregisterEvent("ADDON_LOADED")
    end
  end
end

function Hooks.Enable()
  -- Hook GameTooltip updates to namespaced handler if legacy global is absent
  if _G.GameTooltip and _G.GameTooltip.HookScript then
    if not _G.ST_GameTooltipOnShow then
      _G.GameTooltip:HookScript("OnUpdate", function()
        if ns.Tooltips and ns.Tooltips.GameTooltip and ns.Tooltips.GameTooltip.OnShow then
          ns.Tooltips.GameTooltip.OnShow()
        end
      end)
    end
  end

  -- Compare item tooltips
  local compareFunc = rawget(_G, "GameTooltip_ShowCompareItem")
  if type(compareFunc) == "function" and hooksecurefunc and ns.Tooltips and ns.Tooltips.GameTooltip and ns.Tooltips.GameTooltip.CurrentEquipped then
    hooksecurefunc("GameTooltip_ShowCompareItem", function(self)
      if (ShoppingTooltip1 and ShoppingTooltip1:IsVisible()) then
        ns.Tooltips.GameTooltip.CurrentEquipped(ShoppingTooltip1)
      end
      if (ShoppingTooltip2 and ShoppingTooltip2:IsVisible()) then
        ns.Tooltips.GameTooltip.CurrentEquipped(ShoppingTooltip2)
      end
    end)
  end

  -- SpellBookFrame_Update hook
  if SpellBookFrame_Update and hooksecurefunc then
    hooksecurefunc("SpellBookFrame_Update", ST_updateSpellBookFrame)
  end

  -- Create event frame for ADDON_LOADED
  if ((GetLocale() == "enUS") or (GetLocale() == "enGB")) then
    WOWSTR = CreateFrame("Frame")
    WOWSTR:SetScript("OnEvent", Hooks.OnEvent)
    WOWSTR:RegisterEvent("ADDON_LOADED")
  end
end

-- Global wrapper
_G.WOWSTR_onEvent = function(...) return Hooks.OnEvent(...) end

return Hooks


