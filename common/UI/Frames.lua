local addonName, ns = ...

ns = ns or {}
ns.UI = ns.UI or {}
ns.UI.Frames = ns.UI.Frames or {}
local M = ns.UI.Frames

-- Misc UI frames module (migrated from WoW_Tooltips.lua)

local isMountButtonCreated = false
local mountUpdateVisibility

-- SpellBook Frame
function M.UpdateSpellBookFrame()
  if (TT_PS and TT_PS["ui1"] == "1") then
    local ST_titleTextFontString = SpellBookFrame:GetTitleText()
    if (ST_titleTextFontString and ST_titleTextFontString:GetText()) then
      local str_ID = StringHash(ST_UsunZbedneZnaki(ST_titleTextFontString:GetText()))
      if (ST_TooltipsHS and ST_TooltipsHS[str_ID]) then
        local text0 = QTR_ReverseIfAR(ST_titleTextFontString:GetText())
        ST_titleTextFontString:SetText(ST_SetText(text0))
      end
    end

    if (SpellBookFrameTabButton1 and SpellBookFrameTabButton1:GetText()) then
      local str_ID = StringHash(ST_UsunZbedneZnaki(SpellBookFrameTabButton1:GetText()))
      if (ST_TooltipsHS and ST_TooltipsHS[str_ID]) then
        local text1 = QTR_ReverseIfAR(ST_SetText(SpellBookFrameTabButton1:GetText()))
        local fo = SpellBookFrameTabButton1:CreateFontString()
        fo:SetFont(WOWTR_Font2, 11)
        fo:SetText(text1)
        SpellBookFrameTabButton1:SetFontString(fo)
        SpellBookFrameTabButton1:SetText(text1)
      end
    end

    if (SpellBookFrameTabButton2 and SpellBookFrameTabButton2:GetText()) then
      local str_ID = StringHash(ST_UsunZbedneZnaki(SpellBookFrameTabButton2:GetText()))
      if (ST_TooltipsHS and ST_TooltipsHS[str_ID]) then
        local text1 = QTR_ReverseIfAR(ST_SetText(SpellBookFrameTabButton2:GetText()))
        local fo = SpellBookFrameTabButton2:CreateFontString()
        fo:SetFont(WOWTR_Font2, 11)
        fo:SetText(text1)
        SpellBookFrameTabButton2:SetFontString(fo)
        SpellBookFrameTabButton2:SetText(text1)
      end
    end

    if (SpellBookFrameTabButton3 and SpellBookFrameTabButton3:GetText()) then
      local str_ID = StringHash(ST_UsunZbedneZnaki(SpellBookFrameTabButton3:GetText()))
      if (ST_TooltipsHS and ST_TooltipsHS[str_ID]) then
        local text1 = QTR_ReverseIfAR(ST_SetText(SpellBookFrameTabButton3:GetText()))
        local fo = SpellBookFrameTabButton3:CreateFontString()
        fo:SetFont(WOWTR_Font2, 11)
        fo:SetText(text1)
        SpellBookFrameTabButton3:SetFontString(fo)
        SpellBookFrameTabButton3:SetText(text1)
      end
    end

    local SBPageText = SpellBookPageText
    ST_CheckAndReplaceTranslationText(SBPageText, true, "ui")
  end
end

-- Static Popup
function M.StaticPopup1()
  if (TT_PS and TT_PS["ui1"] == "1") then
    local SPobj01 = StaticPopup1Text
    ST_CheckAndReplaceTranslationTextUI(SPobj01, true, "h@popuptext-ui")

    local SPobj02 = StaticPopup1Button1Text
    ST_CheckAndReplaceTranslationTextUI(SPobj02, true, "h@popupbutton-ui")

    local SPobj03 = StaticPopup1Button2Text
    ST_CheckAndReplaceTranslationTextUI(SPobj03, true, "h@popupbutton-ui")

    local SPobj04 = StaticPopup1Button3Text
    ST_CheckAndReplaceTranslationTextUI(SPobj04, true, "h@popupbutton-ui")

    local SPobj05 = StaticPopup1Button4Text
    ST_CheckAndReplaceTranslationTextUI(SPobj05, true, "h@popupbutton-ui")

    local SPobj06 = StaticPopup2Text
    ST_CheckAndReplaceTranslationTextUI(SPobj06, true, "h@popuptext-ui")

    local SPobj07 = StaticPopup2Button1Text
    ST_CheckAndReplaceTranslationTextUI(SPobj07, true, "h@popupbutton-ui")

    local SPobj08 = StaticPopup2Button2Text
    ST_CheckAndReplaceTranslationTextUI(SPobj08, true, "h@popupbutton-ui")

    local SPobj09 = StaticPopup2Button3Text
    ST_CheckAndReplaceTranslationTextUI(SPobj09, true, "h@popupbutton-ui")

    local SPobj10 = StaticPopup2Button4Text
    ST_CheckAndReplaceTranslationTextUI(SPobj10, true, "h@popupbutton-ui")
  end
end

-- World Map
function M.WorldMapFunc()
  local wmframe01 = WorldMapFrameTitleText
  ST_CheckAndReplaceTranslationText(wmframe01, true, "ui", false, 1)

  local wmframe02 = WorldMapFrameHomeButtonText
  ST_CheckAndReplaceTranslationText(wmframe02, true, "ui")
end

-- Merchant
function M.MerchantFrame()
  if (TT_PS and TT_PS["ui1"] == "1") then
    local MercTab1 = MerchantFrameTab1.Text
    ST_CheckAndReplaceTranslationTextUI(MercTab1, true, "ui")

    local MercTab2 = MerchantFrameTab2.Text
    ST_CheckAndReplaceTranslationTextUI(MercTab2, true, "ui")
  end
end

-- Game Menu
function M.GameMenuTranslate()
  if not TT_PS or TT_PS["ui1"] ~= "1" then return end

  local function SafeUpdateText(textObject)
    if not textObject or not textObject.GetText then return end
    local originalText = textObject:GetText()
    if not originalText then return end

    local hash = StringHash(ST_UsunZbedneZnaki(originalText))
    if ST_TooltipsHS and ST_TooltipsHS[hash] then
      local translatedText = QTR_ReverseIfAR(ST_TooltipsHS[hash]) .. NONBREAKINGSPACE
      C_Timer.After(0.01, function()
        if textObject:GetText() == originalText then
          textObject:SetText(translatedText)
          if textObject.SetFont then
            textObject:SetFont(WOWTR_Font2, select(2, textObject:GetFont()))
          end
        end
      end)
    end
  end

  local function SafeUpdateButton(button)
    SafeUpdateText(button)

    local fontStates = { "Normal", "Highlight", "Disabled", "Pushed" }
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
    if GameMenuFrame.buttonPool then
      for buttonFrame in GameMenuFrame.buttonPool:EnumerateActive() do
        SafeUpdateButton(buttonFrame)
      end
    end
  end

  hooksecurefunc(GameMenuFrame, "InitButtons", SafeInitButtons)
  SafeInitButtons()
end

-- Mount Journal
function M.MountJournal()
  if (TT_PS and TT_PS["ui4"] == "1") then
    local CJobj01 = MountJournalLore
    local ST_MountName = MountJournalName:GetText()
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(CJobj01, true, "Collections:Mount:" .. (ST_MountName or ''), false, false, -10)
    else
      ST_CheckAndReplaceTranslationTextUI(CJobj01, true, "Collections:Mount:" .. (ST_MountName or ''))
    end

    local CJobj02 = MountJournalSummonRandomFavoriteButtonSpellName
    ST_CheckAndReplaceTranslationText(CJobj02, false, "ui", false, false)

    local CJobj03 = MountJournal.BottomLeftInset.SlotLabel
    ST_CheckAndReplaceTranslationTextUI(CJobj03, false, "ui")

    local CJobj04 = MountJournal.MountDisplay.ModelScene.TogglePlayer.TogglePlayerText
    ST_CheckAndReplaceTranslationTextUI(CJobj04, false, "ui")

    local CJobj05 = MountJournal.MountCount.Label
    ST_CheckAndReplaceTranslationTextUI(CJobj05, false, "ui")

    local CJobj06 = CollectionsJournalTitleText
    ST_CheckAndReplaceTranslationTextUI(CJobj06, false, "ui")

    local CJobj07 = MountJournalMountButton.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj07, false, "ui")

    local CJobj13 = WardrobeCollectionFrameTab1.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj13, false, "ui")

    local CJobj14 = WardrobeCollectionFrameTab2.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj14, false, "ui")

    local CJobj15 = MountJournalSearchBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(CJobj15, false, "ui")

    local CJobj16 = PetJournalSearchBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(CJobj16, false, "ui")

    local CJobj17 = PetJournal.PetCount.Label
    ST_CheckAndReplaceTranslationTextUI(CJobj17, false, "ui")

    local CJobj18 = PetJournalSummonButton.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj18, false, "ui")

    local CJobj19 = PetJournalFindBattle.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj19, false, "ui")

    local CJobj20 = PetJournalSummonRandomFavoritePetButtonSpellName
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(CJobj20, false, "ui", false, false)
    else
      ST_CheckAndReplaceTranslationTextUI(CJobj20, false, "ui")
    end

    local CJobj21 = PetJournalHealPetButtonSpellName
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(CJobj21, false, "ui", false, false)
    else
      ST_CheckAndReplaceTranslationTextUI(CJobj21, false, "ui")
    end

    local CJobj22 = MountJournal.FilterDropdown.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj22, false, "ui")

    local CJobj23 = PetJournal.FilterDropdown.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj23, false, "ui")

    local CJobj24 = ToyBox.searchBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(CJobj24, false, "ui")

    local CJobj25 = ToyBox.FilterDropdown.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj25, false, "ui")

    local CJobj26 = ToyBox.PagingFrame.PageText
    ST_CheckAndReplaceTranslationTextUI(CJobj26, false, "ui")

    local CJobj27 = HeirloomsJournalSearchBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(CJobj27, false, "ui")

    local CJobj28 = HeirloomsJournal.FilterDropdown.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj28, false, "ui")

    local CJobj29 = HeirloomsJournal.PagingFrame.PageText
    ST_CheckAndReplaceTranslationTextUI(CJobj29, false, "ui")

    local CJobj30 = WardrobeCollectionFrameSearchBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(CJobj30, false, "ui")

    local CJobj31 = WardrobeCollectionFrame.FilterButton.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj31, false, "ui")

    local CJobj32 = WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.PageText
    ST_CheckAndReplaceTranslationTextUI(CJobj32, false, "ui")

    for i = 1, 18 do
      local CJToys = ToyBox.iconsFrame["spellButton" .. i].name
      ST_CheckAndReplaceTranslationTextUI(CJToys, true, "toyname")
    end
  end

  if (TT_PS and TT_PS["ui5"] == "1") then
    local CJobj08 = CollectionsJournalTab1.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj08, false, "ui")

    local CJobj09 = CollectionsJournalTab2.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj09, false, "ui")

    local CJobj10 = CollectionsJournalTab3.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj10, false, "ui")

    local CJobj11 = CollectionsJournalTab4.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj11, false, "ui")

    local CJobj12 = CollectionsJournalTab5.Text
    ST_CheckAndReplaceTranslationTextUI(CJobj12, false, "ui")
  end
end

function M.MountJournalButton()
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
        M.MountJournal()
      end
    )

    isMountButtonCreated = true
  end

  if mountUpdateVisibility then
    mountUpdateVisibility()
  end
end

-- Character Frame
function M.CharacterFrame()
  if (TT_PS and TT_PS["ui2"] == "1") then
    local ChFrame1 = CharacterStatsPane.ItemLevelCategory.Title
    ST_CheckAndReplaceTranslationTextUI(ChFrame1, true, "ui")

    local ChFrame2 = CharacterStatsPane.AttributesCategory.Title
    ST_CheckAndReplaceTranslationTextUI(ChFrame2, true, "ui")

    local ChFrame3 = CharacterStatsPane.EnhancementsCategory.Title
    ST_CheckAndReplaceTranslationTextUI(ChFrame3, true, "ui")

    local ChFrame4 = CharacterFrameTab1.Text
    ST_CheckAndReplaceTranslationTextUI(ChFrame4, true, "ui")

    local ChFrame5 = CharacterFrameTab2.Text
    ST_CheckAndReplaceTranslationTextUI(ChFrame5, true, "ui")

    local ChFrame6 = CharacterFrameTab3.Text
    ST_CheckAndReplaceTranslationTextUI(ChFrame6, true, "ui")

    local ChFrame7 = ReputationFrame.ReputationDetailFrame.ScrollingDescription.ScrollBox.ScrollTarget
    local childFrame = select(1, ChFrame7:GetChildren())
    if childFrame and childFrame.FontString and childFrame.FontString.GetText then
      local text = childFrame.FontString:GetText()
      local RDFactionName = ReputationFrame.ReputationDetailFrame.Title:GetText()
      ST_CheckAndReplaceTranslationTextUI(childFrame.FontString, true, "Factions:" .. ST_RenkKoduSil(RDFactionName))
    end

    local ChFrame8 = ReputationDetailAtWarCheckBoxText
    ST_CheckAndReplaceTranslationTextUI(ChFrame8, true, "ui")

    local ChFrame9 = ReputationDetailInactiveCheckBoxText
    ST_CheckAndReplaceTranslationTextUI(ChFrame9, true, "ui")

    local ChFrame10 = ReputationDetailMainScreenCheckBoxText
    ST_CheckAndReplaceTranslationTextUI(ChFrame10, true, "ui")
  end
end

-- Friends Frame
function M.FriendsFrame()
  if (TT_PS and TT_PS["ui6"] == "1") then
    local Friendsobj01 = FriendsFrameTitleText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj01, true, "ui")

    local Friendsobj02 = FriendsTabHeaderTab1.Text
    ST_CheckAndReplaceTranslationTextUI(Friendsobj02, true, "ui")

    local Friendsobj03 = FriendsTabHeaderTab2.Text
    ST_CheckAndReplaceTranslationTextUI(Friendsobj03, true, "ui")

    local Friendsobj04 = FriendsTabHeaderTab3.Text
    ST_CheckAndReplaceTranslationTextUI(Friendsobj04, true, "ui")

    local Friendsobj05 = FriendsFrameTab1.Text
    ST_CheckAndReplaceTranslationTextUI(Friendsobj05, true, "ui")

    local Friendsobj06 = FriendsFrameTab2.Text
    ST_CheckAndReplaceTranslationTextUI(Friendsobj06, true, "ui")

    local Friendsobj07 = FriendsFrameTab3.Text
    ST_CheckAndReplaceTranslationTextUI(Friendsobj07, true, "ui")

    local Friendsobj08 = FriendsFrameTab4.Text
    ST_CheckAndReplaceTranslationTextUI(Friendsobj08, true, "ui")

    local Friendsobj09 = FriendsFrameAddFriendButtonText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj09, true, "ui")

    local Friendsobj10 = FriendsFrameSendMessageButtonText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj10, true, "ui")

    local Friendsobj11 = FriendsFrameIgnorePlayerButtonText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj11, true, "ui")

    local Friendsobj12 = FriendsFrameUnsquelchButtonText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj12, true, "ui")

    local Friendsobj13 = WhoFrameWhoButtonText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj13, true, "ui")

    local Friendsobj14 = WhoFrameAddFriendButtonText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj14, true, "ui")

    local Friendsobj15 = WhoFrameGroupInviteButtonText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj15, true, "ui")

    local Friendsobj16 = WhoFrameTotals
    ST_CheckAndReplaceTranslationTextUI(Friendsobj16, true, "ui")

    local Friendsobj17 = RaidFrameConvertToRaidButtonText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj17, true, "ui")

    local Friendsobj18 = RaidFrameRaidInfoButtonText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj18, true, "ui")

    local Friendsobj19 = RaidFrameRaidDescription
    ST_CheckAndReplaceTranslationTextUI(Friendsobj19, true, "ui")

    local Friendsobj20 = RecruitAFriendRecruitmentFrame.Title
    ST_CheckAndReplaceTranslationTextUI(Friendsobj20, true, "ui")

    local Friendsobj21 = RecruitAFriendRecruitmentFrame.Description
    ST_CheckAndReplaceTranslationTextUI(Friendsobj21, true, "ui")

    local Friendsobj22 = RecruitAFriendRecruitmentFrame.FactionAndRealm
    ST_CheckAndReplaceTranslationTextUI(Friendsobj22, true, "ui")

    local Friendsobj23 = RecruitAFriendFrame.RecruitList.Header.RecruitedFriends
    ST_CheckAndReplaceTranslationTextUI(Friendsobj23, true, "ui")

    local Friendsobj24 = RecruitAFriendFrame.RecruitmentButton.Text
    ST_CheckAndReplaceTranslationTextUI(Friendsobj24, true, "ui")

    local Friendsobj26 = RecruitAFriendFrame.RewardClaiming.MonthCount.Text
    ST_CheckAndReplaceTranslationTextUI(Friendsobj26, true, "ui")

    local Friendsobj27 = RecruitAFriendFrameText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj27, true, "ui")

    local Friendsobj28 = RecruitAFriendRecruitmentFrame.EditBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(Friendsobj28, true, "ui")

    local Friendsobj29 = RecruitAFriendRecruitmentFrameText
    ST_CheckAndReplaceTranslationTextUI(Friendsobj29, true, "ui")

    local Friendsobj30 = RecruitAFriendRecruitmentFrame.InfoText1
    ST_CheckAndReplaceTranslationTextUI(Friendsobj30, true, "ui")

    local Friendsobj31 = RecruitAFriendRecruitmentFrame.InfoText2
    ST_CheckAndReplaceTranslationTextUI(Friendsobj31, true, "ui")

    local Friendsobj32 = RecruitAFriendFrame.RewardClaiming.EarnInfo
    ST_CheckAndReplaceTranslationTextUI(Friendsobj32, true, "ui")
  end
end

-- Help Plate Tooltip
function M.HelpPlateTooltip()
  if (TT_PS and TT_PS["active"] == "1") then
    local HPT01 = HelpPlateTooltip.Text
    ST_CheckAndReplaceTranslationTextUI(HPT01, true, "ui")
  end
end

-- Splash Frame
function M.SplashFrame()
  if (TT_PS and TT_PS["active"] == "1") then
    local SplashF01 = SplashFrame.Header
    ST_CheckAndReplaceTranslationTextUI(SplashF01, true, "ui")

    local SplashF02 = SplashFrame.Label
    ST_CheckAndReplaceTranslationTextUI(SplashF02, true, "ui")

    local SplashF03 = SplashFrame.TopLeftFeature.Description
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(SplashF03, true, "ui", false, false, -10)
      SplashF03:SetJustifyH("RIGHT")
    else
      ST_CheckAndReplaceTranslationTextUI(SplashF03, true, "ui")
    end

    local SplashF04 = SplashFrame.BottomLeftFeature.Description
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(SplashF04, true, "ui", false, false, -15)
      SplashF04:SetJustifyH("RIGHT")
    else
      ST_CheckAndReplaceTranslationTextUI(SplashF04, true, "ui")
    end

    local SplashF05 = SplashFrame.RightFeature.Description
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(SplashF05, true, "ui", false, false, -10)
    else
      ST_CheckAndReplaceTranslationTextUI(SplashF05, true, "ui")
    end

    local SplashF06 = SplashFrame.BottomCloseButton.Text
    ST_CheckAndReplaceTranslationTextUI(SplashF06, true, "ui")

    local SplashF07 = SplashFrame.TopLeftFeature.Title
    ST_CheckAndReplaceTranslationTextUI(SplashF07, true, "ui")

    local SplashF08 = SplashFrame.BottomLeftFeature.Title
    ST_CheckAndReplaceTranslationTextUI(SplashF08, true, "ui")

    local SplashF09 = SplashFrame.RightFeature.Title
    ST_CheckAndReplaceTranslationTextUI(SplashF09, true, "ui")
  end
end

-- Ping System Tutorial
function M.PingSystemTutorial()
  if (TT_PS and TT_PS["active"] == "1") then
    local PST01 = PingSystemTutorialTitleText
    ST_CheckAndReplaceTranslationTextUI(PST01, true, "ui")

    local PST02 = PingSystemTutorial.Tutorial1.TutorialHeader
    ST_CheckAndReplaceTranslationTextUI(PST02, true, "ui")

    local PST03 = PingSystemTutorial.Tutorial2.TutorialHeader
    ST_CheckAndReplaceTranslationTextUI(PST03, true, "ui")

    local PST04 = PingSystemTutorial.Tutorial3.TutorialHeader
    ST_CheckAndReplaceTranslationTextUI(PST04, true, "ui")

    local PST05 = PingSystemTutorial.Tutorial4.TutorialHeader
    ST_CheckAndReplaceTranslationTextUI(PST05, true, "ui")

    local PST06 = PingSystemTutorial.Tutorial4.ImageBounds.TutorialBody1
    ST_CheckAndReplaceTranslationTextUI(PST06, true, "ui")

    local PST07 = PingSystemTutorial.Tutorial4.ImageBounds.TutorialBody2
    ST_CheckAndReplaceTranslationTextUI(PST07, true, "ui")

    local PST08 = PingSystemTutorial.Tutorial4.ImageBounds.TutorialBody3
    ST_CheckAndReplaceTranslationTextUI(PST08, true, "ui")
  end
end

-- Warband Bank
function M.WarbandBankFrame()
  if (TT_PS and TT_PS["active"] == "1") then
    local BANKFrame01 = AccountBankPanel.PurchasePrompt.Title
    ST_CheckAndReplaceTranslationTextUI(BANKFrame01, false, "ui")

    local BANKFrame02 = AccountBankPanel.PurchasePrompt.PromptText
    ST_CheckAndReplaceTranslationTextUI(BANKFrame02, false, "ui")

    local BANKFrame03 = AccountBankPanel.PurchasePrompt.TabCostFrame.PurchaseButton.Text
    ST_CheckAndReplaceTranslationTextUI(BANKFrame03, false, "ui")

    local BANKFrame04 = AccountBankPanel.PurchasePrompt.TabCostFrame.TabCost
    ST_CheckAndReplaceTranslationTextUI(BANKFrame04, false, "ui")

    local BANKFrame05 = AccountBankPanel.MoneyFrame.WithdrawButton.Text
    ST_CheckAndReplaceTranslationTextUI(BANKFrame05, false, "ui")

    local BANKFrame06 = AccountBankPanel.MoneyFrame.DepositButton.Text
    ST_CheckAndReplaceTranslationTextUI(BANKFrame06, false, "ui")

    local BANKFrame07 = AccountBankPanel.ItemDepositFrame.DepositButton.Text
    ST_CheckAndReplaceTranslationTextUI(BANKFrame07, false, "ui")

    local BANKFrame08 = AccountBankPanel.ItemDepositFrame.IncludeReagentsCheckbox.Text
    ST_CheckAndReplaceTranslationTextUI(BANKFrame08, false, "ui")

    local BANKFrame09 = BankItemSearchBox.Instructions
    ST_CheckAndReplaceTranslationTextUI(BANKFrame09, false, "ui")
  end
end

-- ItemRef Tooltip
local ignoreList = {}
if WoWTR_Localization.lang == 'TR' then
  ignoreList = {
    "Head", "Neck", "Shoulder", "Back", "Chest", "Tabard", "Wrist", "Hands", "Waist", "Legs", "Feet", "Finger", "Trinket"
  }
end

local function shouldIgnore(text)
  for _, ignoreText in ipairs(ignoreList) do
    if text:find(ignoreText) then
      return true
    end
  end
  return false
end

function M.ItemRefTooltip()
  for i = 2, 30 do
    local itemRefLeft = _G["ItemRefTooltipTextLeft" .. i]
    if itemRefLeft and itemRefLeft:GetText() then
      local text = itemRefLeft:GetText()
      if not shouldIgnore(text) then
        ST_CheckAndReplaceTranslationTextUI(itemRefLeft, true, "other")
      end
    end

    local itemRefRight = _G["ItemRefTooltipTextRight" .. i]
    if itemRefRight and itemRefRight:GetText() then
      local text = itemRefRight:GetText()
      if not shouldIgnore(text) then
        ST_CheckAndReplaceTranslationTextUI(itemRefRight, true, "other")
      end
    end
  end
end

-- Item Upgrade Frame
function M.ItemUpgradeFrame()
  if (TT_PS and TT_PS["ui1"] == "1") then
    local ItemUpFrm01 = ItemUpgradeFrameTitleText
    ST_CheckAndReplaceTranslationTextUI(ItemUpFrm01, false, "ui")
    local ItemUpFrm02 = ItemUpgradeFrame.ItemInfo.MissingItemText
    ST_CheckAndReplaceTranslationTextUI(ItemUpFrm02, false, "ui")
    local ItemUpFrm03 = ItemUpgradeFrame.MissingDescription
    ST_CheckAndReplaceTranslationTextUI(ItemUpFrm03, false, "ui")
    local ItemUpFrm04 = ItemUpgradeFrame.UpgradeButton.Text
    ST_CheckAndReplaceTranslationTextUI(ItemUpFrm04, false, "ui")
    local ItemUpFrm05 = ItemUpgradeFrame.UpgradeCostFrame.Label
    ST_CheckAndReplaceTranslationTextUI(ItemUpFrm05, false, "ui")
    local ItemUpFrm06 = ItemUpgradeFrame.ItemInfo.UpgradeTo
    ST_CheckAndReplaceTranslationTextUI(ItemUpFrm06, false, "ui")
    local ItemUpFrm07 = ItemUpgradeFrameLeftItemPreviewFrameTextLeft1
    ST_CheckAndReplaceTranslationTextUI(ItemUpFrm07, false, "ui")
    local ItemUpFrm08 = ItemUpgradeFrameRightItemPreviewFrameTextLeft1
    ST_CheckAndReplaceTranslationTextUI(ItemUpFrm08, false, "ui")
  end
end

-- Weekly Rewards Frame
function M.WeeklyRewardsFrame()
  if (TT_PS and TT_PS["ui1"] == "1") then
    local WeeklyRFrm01 = WeeklyRewardsFrame.HeaderFrame.Text
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(WeeklyRFrm01, false, "ui", WOWTR_Font1, false, 5)
    else
      ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm01, false, "ui")
    end
    local WeeklyRFrm02 = WeeklyRewardsFrame.RaidFrame.Name
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm02, false, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm02, false, "ui")
    end
    local WeeklyRFrm03 = WeeklyRewardsFrame.MythicFrame.Name
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm03, false, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm03, false, "ui")
    end
    local WeeklyRFrm04 = WeeklyRewardsFrame.WorldFrame.Name
    if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm04, false, "ui", WOWTR_Font1)
    else
      ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm04, false, "ui")
    end
    if WeeklyRewardsFrame.Overlay and WeeklyRewardsFrame.Overlay.Title then
      local WeeklyRFrm05 = WeeklyRewardsFrame.Overlay.Title
      if (WoWTR_Localization.lang == 'AR') then
        ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm05, true, "ui", WOWTR_Font1)
      else
        ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm05, true, "ui")
      end
    end
    if WeeklyRewardsFrame.Overlay and WeeklyRewardsFrame.Overlay.Text then
      local WeeklyRFrm06 = WeeklyRewardsFrame.Overlay.Text
      if (WoWTR_Localization.lang == 'AR') then
        ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm06, true, "ui", WOWTR_Font1)
      else
        ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm06, true, "ui")
      end
    end
  end
end

-- Event Toast Manager Frame
function M.EventToastManagerFrame()
  if (TT_PS and TT_PS["ui1"] == "1") then
    local toast = EventToastManagerFrame.currentDisplayingToast
    if toast then
      local EventTextScreen01 = toast.Title
      ST_CheckAndReplaceTranslationTextUI(EventTextScreen01, true, "Collections:TextEvent", WOWTR_Font1)

      local EventTextScreen02 = toast.SubTitle
      ST_CheckAndReplaceTranslationTextUI(EventTextScreen02, true, "Collections:TextEvent")

      local EventTextScreen03 = toast.Description
      ST_CheckAndReplaceTranslationTextUI(EventTextScreen03, true, "Collections:TextEvent")

      if toast.Contents then
        local EventTextScreen04 = toast.Contents.Title
        ST_CheckAndReplaceTranslationTextUI(EventTextScreen04, true, "Collections:TextEvent", WOWTR_Font1)

        local EventTextScreen05 = toast.Contents.SubTitle
        ST_CheckAndReplaceTranslationTextUI(EventTextScreen05, true, "Collections:TextEvent")

        local EventTextScreen06 = toast.Contents.Description
        ST_CheckAndReplaceTranslationTextUI(EventTextScreen06, true, "Collections:TextEvent")
      end
    end
  end
end

-- Raid Boss Emote Frame
function M.RaidBossEmoteFrame()
  if (TT_PS and TT_PS["ui1"] == "1") then
    local RBossEmoteFrm04 = RaidBossEmoteFrame.slot1Text
    ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm04, false, "Collections:Emote")
    local RBossEmoteFrm05 = RaidBossEmoteFrame.slot2Text
    ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm05, false, "Collections:Emote")
    local RBossEmoteFrm06 = RaidBossEmoteFrame.slot3Text
    ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm06, false, "Collections:Emote")
    local RBossEmoteFrm01 = RaidBossEmoteFrame.slot1
    ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm01, true, "Collections:Emote")
    local RBossEmoteFrm02 = RaidBossEmoteFrame.slot2
    ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm02, true, "Collections:Emote")
    local RBossEmoteFrm03 = RaidBossEmoteFrame.slot3
    ST_CheckAndReplaceTranslationTextUI(RBossEmoteFrm03, true, "Collections:Emote")
  end
end

-- Global wrappers for back-compat
_G.ST_updateSpellBookFrame = function() return M.UpdateSpellBookFrame() end
_G.ST_StaticPopup1 = function() return M.StaticPopup1() end
_G.ST_WorldMapFunc = function() return M.WorldMapFunc() end
_G.ST_MerchantFrame = function() return M.MerchantFrame() end
_G.ST_GameMenuTranslate = function() return M.GameMenuTranslate() end
_G.ST_MountJournal = function() return M.MountJournal() end
_G.ST_MountJournalbutton = function() return M.MountJournalButton() end
_G.ST_CharacterFrame = function() return M.CharacterFrame() end
_G.ST_FriendsFrame = function() return M.FriendsFrame() end
_G.ST_HelpPlateTooltip = function() return M.HelpPlateTooltip() end
_G.ST_SplashFrame = function() return M.SplashFrame() end
_G.ST_PingSystemTutorial = function() return M.PingSystemTutorial() end
_G.ST_WarbandBankFrm = function() return M.WarbandBankFrame() end
_G.ST_ItemRefTooltip = function() return M.ItemRefTooltip() end
_G.ST_ItemUpgradeFrm = function() return M.ItemUpgradeFrame() end
_G.ST_WeeklyRewardsFrame = function() return M.WeeklyRewardsFrame() end
_G.ST_EventToastManagerFrame = function() return M.EventToastManagerFrame() end
_G.ST_RaidBossEmoteFrame = function() return M.RaidBossEmoteFrame() end

return M