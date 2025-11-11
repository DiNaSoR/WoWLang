local addonName, ns = ...

ns = ns or {}
ns.UI = ns.UI or {}
ns.UI.GroupFinder = ns.UI.GroupFinder or {}
local M = ns.UI.GroupFinder

-- Group Finder module (migrated from WoW_Tooltips.lua)

function M.GroupFinder()
  if (TT_PS and TT_PS["ui3"] == "1") then
    local GFobj01 = PVEFrameTitleText
    ST_CheckAndReplaceTranslationTextUI(GFobj01, true, "ui")

    local GFobj02 = PVEFrameTab1.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj02, true, "ui")

    local GFobj03 = PVEFrameTab2.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj03, true, "ui")

    local GFobj04 = PVEFrameTab3.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj04, true, "ui")

    local GFobj05 = GroupFinderFrameGroupButton1Name
    ST_CheckAndReplaceTranslationText(GFobj05, true, "ui", false, true)

    local GFobj06 = GroupFinderFrameGroupButton2Name
    ST_CheckAndReplaceTranslationTextUI(GFobj06, true, "ui")

    local GFobj07 = GroupFinderFrameGroupButton3Name
    ST_CheckAndReplaceTranslationText(GFobj07, true, "ui", false, true)

    local GFobj08 = LFDQueueFrameTypeDropDownName
    ST_CheckAndReplaceTranslationTextUI(GFobj08, true, "ui")

    local GFobj09 = LFDQueueFrameRandomScrollFrameChildFrameTitle
    ST_CheckAndReplaceTranslationTextUI(GFobj09, true, "ui", WOWTR_Font1)

    local GFobj10 = LFDQueueFrameRandomScrollFrameChildFrameDescription
    ST_CheckAndReplaceTranslationText(GFobj10, true, "ui", false, false)

    local GFobj11 = LFDQueueFrameRandomScrollFrameChildFrameRewardsLabel
    ST_CheckAndReplaceTranslationTextUI(GFobj11, true, "ui", WOWTR_Font1)

    local GFobj12 = LFDQueueFrameRandomScrollFrameChildFrameRewardsDescription
    ST_CheckAndReplaceTranslationText(GFobj12, true, "ui", false, false, -10)

    local GFobj13 = LFDQueueFrameFindGroupButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj13, true, "ui")

    local GFobj14 = RaidFinderQueueFrameScrollFrameChildFrameDescription
    ST_CheckAndReplaceTranslationTextUI(GFobj14, true, "ui")

    local GFobj15 = RaidFinderQueueFrameScrollFrameChildFrameRewardsLabel
    ST_CheckAndReplaceTranslationTextUI(GFobj15, true, "ui", WOWTR_Font1)

    local GFobj16 = RaidFinderQueueFrameScrollFrameChildFrameRewardsDescription
    ST_CheckAndReplaceTranslationTextUI(GFobj16, true, "ui")

    local GFobj17 = RaidFinderFrameFindRaidButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj17, true, "ui")

    local GFobj18 = LFGListFrame.CategorySelection.StartGroupButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj18, true, "ui")

    local GFobj19 = LFGListFrame.CategorySelection.FindGroupButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj19, true, "ui")

    local GFobj20 = LFGListFrame.CategorySelection.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj20, true, "ui", WOWTR_Font1)

    local GFobj21 = LFGListApplicationDialog.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj21, true, "ui")

    local GFobj22 = LFGListApplicationDialog.SignUpButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj22, true, "ui")

    local GFobj23 = LFGListApplicationDialog.CancelButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj23, true, "ui")

    local GFobj24 = LFGListFrame.SearchPanel.SignUpButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj24, true, "ui")

    local GFobj25 = LFGListFrame.SearchPanel.BackButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj25, true, "ui")

    local GFobj26 = LFGListFrame.SearchPanel.CategoryName
    ST_CheckAndReplaceTranslationTextUI(GFobj26, true, "ui")

    local GFobj27 = LFGListFrame.EntryCreation.NameLabel
    ST_CheckAndReplaceTranslationTextUI(GFobj27, true, "ui")

    local GFobj28 = LFGListFrame.EntryCreation.DescriptionLabel
    ST_CheckAndReplaceTranslationTextUI(GFobj28, true, "ui")

    local GFobj29 = LFGListFrame.EntryCreation.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj29, true, "ui", WOWTR_Font1)

    local GFobj30 = LFGListInviteDialog.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj30, true, "ui")

    local GFobj31 = LFGListInviteDialog.RoleDescription
    ST_CheckAndReplaceTranslationTextUI(GFobj31, true, "ui")

    local GFobj32 = LFGListInviteDialog.AcceptButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj32, true, "ui")

    local GFobj33 = LFGListInviteDialog.DeclineButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj33, true, "ui")

    local GFobj34 = LFGListInviteDialog.AcknowledgeButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj34, true, "ui")

    local GFobj35 = LFDQueueFrameFollowerTitle
    ST_CheckAndReplaceTranslationTextUI(GFobj35, true, "ui", WOWTR_Font1)

    local GFobj36 = LFDQueueFrameFollowerDescription
    ST_CheckAndReplaceTranslationTextUI(GFobj36, true, "ui")

    local GFobj37 = LFGListFrame.EntryCreation.ListGroupButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj37, true, "ui")

    local GFobj38 = LFGListFrame.SearchPanel.ScrollBox.StartGroupButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj38, true, "ui")

    local GFobj39 = LFGListFrame.SearchPanel.SearchBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(GFobj39, true, "ui")

    local GFobj40 = LFGListFrame.SearchPanel.ScrollBox.NoResultsFound
    ST_CheckAndReplaceTranslationTextUI(GFobj40, true, "ui")

    local GFobj41 = LFGListFrame.EntryCreation.PlayStyleLabel
    ST_CheckAndReplaceTranslationTextUI(GFobj41, true, "ui")

    local GFobj42 = LFGListCreationDescription.EditBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(GFobj42, true, "ui")

    local GFobj43 = LFGListFrame.EntryCreation.MythicPlusRating.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj43, true, "ui")

    local GFobj44 = LFGListFrame.EntryCreation.ItemLevel.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj44, true, "ui")

    local GFobj45 = LFGListFrame.EntryCreation.VoiceChat.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj45, true, "ui")

    local GFobj46 = LFGListFrame.EntryCreation.PrivateGroup.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj46, true, "ui")

    local GFobj47 = LFGListFrame.EntryCreation.CrossFactionGroup.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj47, true, "ui")

    local GFobj48 = LFGListFrame.EntryCreation.Name.Instructions
    ST_CheckAndReplaceTranslationTextUI(GFobj48, true, "ui")

    local GFobj49 = LFGListFrame.EntryCreation.ItemLevel.EditBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(GFobj49, true, "ui")

    local GFobj50 = LFGListFrame.EntryCreation.VoiceChat.EditBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(GFobj50, true, "ui")

    local GFobj51 = LFGListFrame.EntryCreation.CancelButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj51, true, "ui")

    local GFobj52 = LFGListApplicationDialogDescription.EditBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(GFobj52, true, "ui")

    local GFobj53 = LFGListFrame.ApplicationViewer.ScrollBox.NoApplicants
    ST_CheckAndReplaceTranslationTextUI(GFobj53, true, "ui")

    local GFobj54 = LFGListFrame.ApplicationViewer.BrowseGroupsButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj54, true, "ui")

    local GFobj55 = LFGListFrame.ApplicationViewer.RemoveEntryButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj55, true, "ui")

    local GFobj56 = LFGListFrame.ApplicationViewer.EditButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj56, true, "ui")

    local GFobj57 = LFGListFrame.SearchPanel.BackToGroupButton.Text
    ST_CheckAndReplaceTranslationTextUI(GFobj57, true, "ui")

    local GFobj58 = LFGListFrame.ApplicationViewer.NameColumnHeader.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj58, true, "ui")

    local GFobj59 = LFGListFrame.ApplicationViewer.RoleColumnHeader.Label
    ST_CheckAndReplaceTranslationTextUI(GFobj59, true, "ui")

    local function ApplyTranslationToElement(element, alignment)
      if element and element.GetText and element.SetText then
        local originalText = element:GetText()
        if originalText then
          local hash = StringHash(ST_UsunZbedneZnaki(originalText))
          if ST_TooltipsHS and ST_TooltipsHS[hash] then
            local translatedText = QTR_ReverseIfAR(ST_TooltipsHS[hash])
            element:SetText(translatedText)
            if element.SetFont then
              if WoWTR_Localization.lang == 'AR' then
                element:SetFont(WOWTR_Font1, select(2, element:GetFont()))
              else
                element:SetFont(WOWTR_Font2, select(2, element:GetFont()))
              end
            end
          end
          if alignment and element.SetJustifyH then
            element:SetJustifyH(alignment)
          end
        end
      end
    end

    local categoryButtons = {
      LFGListFrame.CategorySelection.CategoryButtons[1],
      LFGListFrame.CategorySelection.CategoryButtons[2],
      LFGListFrame.CategorySelection.CategoryButtons[3],
      LFGListFrame.CategorySelection.CategoryButtons[4],
      LFGListFrame.CategorySelection.CategoryButtons[5],
      LFGListFrame.CategorySelection.CategoryButtons[6]
    }

    for _, button in ipairs(categoryButtons) do
      if button and button.Label then
        ApplyTranslationToElement(button.Label)
      elseif button then
        ApplyTranslationToElement(button)
      end
    end
  end
end

function M.GroupPVPFinder()
  if (TT_PS and TT_PS["ui3"] == "1") then
    local gfpvpobj01 = PVPQueueFrameCategoryButton1.Name
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj01, true, "ui")

    local gfpvpobj02 = PVPQueueFrameCategoryButton2.Name
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj02, true, "ui")

    local gfpvpobj03 = PVPQueueFrameCategoryButton3.Name
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj03, true, "ui")

    local gfpvpobj04 = PVPQueueFrame.NewSeasonPopup.NewSeason
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj04, true, "ui")

    local gfpvpobj05 = PVPQueueFrame.NewSeasonPopup.SeasonDescriptionHeader
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj05, true, "ui")

    local gfpvpobj06 = PVPQueueFrame.NewSeasonPopup.SeasonDescription
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj06, true, "ui")

    local gfpvpobj07 = PVPQueueFrame.NewSeasonPopup.SeasonRewardText
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj07, true, "ui")

    local gfpvpobj08 = PVPQueueFrame.NewSeasonPopup.Leave.Text
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj08, true, "ui")

    local gfpvpobj09 = PVPQueueFrame.HonorInset.CasualPanel.HKLabel
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj09, true, "ui")

    local gfpvpobj10 = PVPQueueFrame.HonorInset.CasualPanel.HonorLevelDisplay.LevelLabel
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj10, true, "ui")

    local gfpvpobj11 = HonorFrameQueueButton.Text
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj11, true, "ui")

    local gfpvpobj12 = PVPQueueFrame.HonorInset.RatedPanel.Label
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj12, true, "ui")

    local gfpvpobj13 = PVPQueueFrame.HonorInset.RatedPanel.Tier.Title
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj13, true, "ui")

    local gfpvpobj14 = ConquestJoinButtonText
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj14, true, "ui")

    local gfpvpobj15 = LFGListFrame.CategorySelection.Label
    ST_CheckAndReplaceTranslationTextUI(gfpvpobj15, true, "ui")
  end
end

function M.GroupMplusFinder()
  if TT_PS and TT_PS["ui3"] == "1" then
    local elements = {
      { ChallengesFrame.SeasonChangeNoticeFrame.NewSeason, "ui" },
      { ChallengesFrame.SeasonChangeNoticeFrame.SeasonDescription, "ui" },
      { ChallengesFrame.SeasonChangeNoticeFrame.SeasonDescription2, "ui" },
      { ChallengesFrame.WeeklyInfo.Child.Description, "ui" },
      { ChallengesFrame.WeeklyInfo.Child.SeasonBest, "ui" },
      { ChallengesFrame.WeeklyInfo.Child.ThisWeekLabel, "ui" },
      { ChallengesFrame.WeeklyInfo.Child.WeeklyChest.RunStatus, "ui" },
      { ChallengesFrame.WeeklyInfo.Child.DungeonScoreInfo.Title, "ui" },
    }

    for _, elementData in ipairs(elements) do
      local element, prefix = unpack(elementData)
      if WoWTR_Localization.lang == 'AR' then
        ST_CheckAndReplaceTranslationText(element, true, prefix, false, false, -10)
      else
        ST_CheckAndReplaceTranslationTextUI(element, true, prefix)
      end
    end
  end
end

-- Global wrappers for back-compat
_G.ST_GroupFinder = function() return M.GroupFinder() end
_G.ST_GroupPVPFinder = function() return M.GroupPVPFinder() end
_G.ST_GroupMplusFinder = function() return M.GroupMplusFinder() end

return M