

function ST_UpdateFrameTitle(classTalentFrame)
   local ST_titleText;
   if (classTalentFrame:GetTab() == classTalentFrame.specTabID) then
      titleText = _G["SPECIALIZATION"];
   else -- tabID == self.talentTabID
      titleText = _G["TALENTS"];
   end
   classTalentFrame:SetTitle(ST_SetText(titleText));
   local _font, _size, _ = classTalentFrame.TalentsTab.ApplyButton.Text:GetFont();    -- odczytaj aktualną czcionkę i rozmiar
   classTalentFrame.TalentsTab.ApplyButton.Text:SetText(QTR_ReverseIfAR(ST_SetText(classTalentFrame.TalentsTab.ApplyButton.Text:GetText())));   -- Apply Changes
   classTalentFrame.TalentsTab.ApplyButton.Text:SetFont(WOWTR_Font2, _size);

   classTalentFrame:GetTalentsTabButton():SetText(ST_SetText(_G["TALENT_FRAME_TAB_LABEL_TALENTS"]));
   classTalentFrame:GetTabButton(classTalentFrame.specTabID):SetText(QTR_ReverseIfAR(ST_SetText(_G["TALENT_FRAME_TAB_LABEL_SPEC"])));
   
   if ((ST_PM["active"] == "1") and (classTalentFrame:GetTab() ~= classTalentFrame.specTabID)) then
      WOWTR_ToggleButtonT:Show();
   else
      WOWTR_ToggleButtonT:Hide();
   end
end


function ST_TalentsTab_OnShow(talentsTab)
   local _font, _size, _ = talentsTab.ClassCurrencyDisplay.CurrencyLabel:GetFont();    -- odczytaj aktualną czcionkę i rozmiar
   talentsTab.ClassCurrencyDisplay.CurrencyLabel:SetText(QTR_ReverseIfAR(ST_SetText(talentsTab.ClassCurrencyDisplay.CurrencyLabel:GetText())));   -- Main Class Talent Title
   talentsTab.ClassCurrencyDisplay.CurrencyLabel:SetFont(WOWTR_Font2, _size);
   local _font, _size, _ = talentsTab.SpecCurrencyDisplay.CurrencyLabel:GetFont();
   talentsTab.SpecCurrencyDisplay.CurrencyLabel:SetText(QTR_ReverseIfAR(ST_SetText(talentsTab.SpecCurrencyDisplay.CurrencyLabel:GetText())));     -- Spec Class Talent Title
   talentsTab.SpecCurrencyDisplay.CurrencyLabel:SetFont(WOWTR_Font2, _size);
end


function ST_TalentsTranslate()
   local talentsFrame = PlayerSpellsFrame and PlayerSpellsFrame.TalentsFrame
   if not talentsFrame then return end

   local lockedLabel1 = talentsFrame.HeroTalentsContainer and talentsFrame.HeroTalentsContainer.LockedLabel1
   ST_CheckAndReplaceTranslationText(lockedLabel1, true, "ui")

   local lockedLabel2 = talentsFrame.HeroTalentsContainer and talentsFrame.HeroTalentsContainer.LockedLabel2
   ST_CheckAndReplaceTranslationText(lockedLabel2, true, "ui")

   local classCurrencyLabel = talentsFrame.ClassCurrencyDisplay and talentsFrame.ClassCurrencyDisplay.CurrencyLabel
   ST_CheckAndReplaceTranslationText(classCurrencyLabel, true, "ui")

   local specCurrencyLabel = talentsFrame.SpecCurrencyDisplay and talentsFrame.SpecCurrencyDisplay.CurrencyLabel
   ST_CheckAndReplaceTranslationText(specCurrencyLabel, true, "ui")
end


function ST_updateSpecContentsHook()
   for specContentFrame in PlayerSpellsFrame.SpecFrame.SpecContentFramePool:EnumerateActive() do
      local _, _, description, _, _, _ = GetSpecializationInfo(specContentFrame.specIndex, false, false, nil, WOWTR_player_sex)
      if description and not description:find(NONBREAKINGSPACE) then
         local ST_hash = StringHash(ST_UsunZbedneZnaki(description))
         if ST_TooltipsHS[ST_hash] then
            specContentFrame.Description:SetFont(WOWTR_Font2, select(2, specContentFrame.Description:GetFont()))
            local translatedText = QTR_ExpandUnitInfo(ST_TranslatePrepare(description, ST_TooltipsHS[ST_hash]), false, specContentFrame.Description, WOWTR_Font2)
            specContentFrame.Description:SetText(translatedText)
         elseif ST_PM["saveNW"] == "1" then
            ST_PH[ST_hash] = "SpecTab:" .. WOWTR_player_class .. ":" .. specContentFrame.SpecName:GetText() .. "@" .. ST_PrzedZapisem(description:gsub("(%d),(%d)", "%1%2"):gsub("\r", ""))
         end
      end

      local function updateText(element, key, translationType, alignment)
         local text = element:GetText()
         local hash = StringHash(ST_UsunZbedneZnaki(text))
         if ST_TooltipsHS[hash] then
            local translatedText
            if translationType == 2 then
               translatedText = QTR_ExpandUnitInfo(ST_TranslatePrepare(text, ST_TooltipsHS[hash]), false, element, WOWTR_Font2)
            else
               translatedText = QTR_ReverseIfAR(ST_SetText(text))
            end
            element:SetText(translatedText)
            element:SetFont(WOWTR_Font2, select(2, element:GetFont()))
            
            if alignment then
               element:SetJustifyH(alignment)
            end
         end
      end
      
      updateText(specContentFrame.RoleName, "RoleName", 1)
      updateText(specContentFrame.SampleAbilityText, "SampleAbilityText", 1)
      updateText(specContentFrame.ActivatedText, "ActivatedText", 1)
      updateText(specContentFrame.ActivateButton.Text, "ActivateButton.Text", 1)
      updateText(specContentFrame.Description, "Description", 2)
   end
end


function ST_updateHeroTalentHook()
    if not HeroTalentsSelectionDialog or not HeroTalentsSelectionDialog.SpecContentFramePool then
        print("HeroTalentsSelectionDialog veya SpecContentFramePool mevcut değil.")
        return
    end

    local activeFrameFunction = HeroTalentsSelectionDialog.SpecContentFramePool:EnumerateActive()
    if activeFrameFunction then
        for frame in activeFrameFunction do
            if frame and frame.Description then
                local description = frame.Description:GetText()
                if description and not description:find(NONBREAKINGSPACE) then
                    local ST_hash = StringHash(ST_UsunZbedneZnaki(description))
                    if ST_TooltipsHS[ST_hash] then
                        frame.Description:SetFont(WOWTR_Font2, select(2, frame.Description:GetFont()))
                        local translatedText = QTR_ExpandUnitInfo(ST_TranslatePrepare(description, ST_TooltipsHS[ST_hash]), false, frame.Description, WOWTR_Font2)
                        frame.Description:SetText(translatedText)
                    elseif ST_PM["saveNW"] == "1" then
                        ST_PH[ST_hash] = "SpecTab:" .. WOWTR_player_class .. ":" .. frame.SpecName:GetText() .. "@" .. ST_PrzedZapisem(description:gsub("(%d),(%d)", "%1%2"):gsub("\r", ""))
                    end
                end
            end
         local function updateText(element, key, translationType, alignment)
         local text = element:GetText()
         local hash = StringHash(ST_UsunZbedneZnaki(text))
         if ST_TooltipsHS[hash] then
            local translatedText
            if translationType == 2 then
               translatedText = QTR_ExpandUnitInfo(ST_TranslatePrepare(text, ST_TooltipsHS[hash]), false, element, WOWTR_Font2)
            else
               translatedText = QTR_ReverseIfAR(ST_SetText(text))
            end
            element:SetText(translatedText)
            element:SetFont(WOWTR_Font2, select(2, element:GetFont()))
            
            if alignment then
               element:SetJustifyH(alignment)
            end
         end
      end
      
      updateText(frame.CurrencyFrame.LabelText, "CurrencyFrame.LabelText", 1)
      updateText(frame.ActivatedText, "ActivatedText", 1)
      updateText(frame.ActivateButton.Text, "ActivateButton.Text", 1)
      updateText(frame.Description, "Description", 2)
      
        end
    end
end


function ST_IsTalentTooltip(tooltipData)
    if not tooltipData or not tooltipData.type then
        return false
    end
    
    if tooltipData.type == 1 then -- spell or talent
        if ClassTalentFrame and ClassTalentFrame:IsVisible() and (ClassTalentFrame:GetTab()==2) then -- otwarta zakładka Talents
            local PTFleft = ClassTalentFrame:GetLeft()
            local PTFright = ClassTalentFrame:GetRight()
            local PTFbootom = ClassTalentFrame:GetBottom()
            local PTFtop = ClassTalentFrame:GetTop()
            local x, y = GetCursorPosition()
            if x > PTFleft and x < PTFright and y > PTFbootom and y < PTFtop then
                return true
            end
        end
    end
    
    return false
end


local talentFrameCheckTimer
local talentsHooked = false -- Track if talent hooks are set

local function CheckAndHookTalentFrame()
    if ClassTalentFrame and not ClassTalentFrame.hooked then
        ClassTalentFrame:HookScript("OnShow", function()
            if _G.StartTicker then
                _G.StartTicker(ClassTalentFrame, ST_UpdateFrameTitle, 0.1, ClassTalentFrame)
            end
        end)
        
        if ClassTalentFrame.TalentsTab then
            ClassTalentFrame.TalentsTab:HookScript("OnShow", function()
                if _G.StartTicker then
                    _G.StartTicker(ClassTalentFrame.TalentsTab, ST_TalentsTab_OnShow, 0.1, ClassTalentFrame.TalentsTab)
                end
            end)
        end
        
        ClassTalentFrame.hooked = true
        talentsHooked = true
        return true
    end
    return false
end

local function StartTalentFrameCheck()
    if not talentsHooked and not talentFrameCheckTimer then
        talentFrameCheckTimer = C_Timer.NewTicker(1, function()
            if CheckAndHookTalentFrame() then
                if talentFrameCheckTimer then
                    talentFrameCheckTimer:Cancel()
                    talentFrameCheckTimer = nil
                end
            end
        end)
    end
end

local function HookPlayerSpellsFrame()
    if PlayerSpellsFrame then
        hooksecurefunc(PlayerSpellsFrame.SpecFrame, "UpdateSpecContents", ST_updateSpecContentsHook)
        
        if PlayerSpellsFrame.TalentsFrame then
            PlayerSpellsFrame.TalentsFrame:HookScript("OnShow", function()
                if _G.StartTicker then
                    _G.StartTicker(PlayerSpellsFrame.TalentsFrame, ST_TalentsTranslate, 0.1)
                end
            end)
        end
    end
end

local function HookHeroTalentsDialog()
    if HeroTalentsSelectionDialog then
        hooksecurefunc(HeroTalentsSelectionDialog, "UpdateSpecContents", ST_updateHeroTalentHook)
    end
end

local TalentsLoaderFrame = CreateFrame("Frame")
TalentsLoaderFrame:RegisterEvent("ADDON_LOADED")
TalentsLoaderFrame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "Blizzard_ClassTalentUI" then
        if not CheckAndHookTalentFrame() then
            StartTalentFrameCheck()
        end
        HookPlayerSpellsFrame()
        HookHeroTalentsDialog()
        
        if talentsHooked then
            self:UnregisterEvent("ADDON_LOADED")
            if talentFrameCheckTimer then
                talentFrameCheckTimer:Cancel()
                talentFrameCheckTimer = nil
            end
        end
    end
end)