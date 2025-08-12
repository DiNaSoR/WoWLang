local addonName, addon = ...

-- Global function for login message
local function firstloginframe()
    local firstloginframe = CreateFrame("Frame", nil, UIParent);
    firstloginframe:SetSize(100, 50);
    firstloginframe:SetPoint("BOTTOMLEFT", 12, 5);
    local addonlogintext = firstloginframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    addonlogintext:SetPoint("LEFT");
    addonlogintext:SetText(WoWTR_Localization.addonName);
    addonlogintext:SetTextColor(1, 1, 1, 0.1);
    addonlogintext:SetFont(WOWTR_Font1, 20);
    local addonlogintext2 = firstloginframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    addonlogintext2:SetPoint("LEFT", 0, -15);
    addonlogintext2:SetText("ver. " .. WOWTR_version);
    addonlogintext2:SetTextColor(1, 1, 1, 0.1);
    addonlogintext2:SetFont(WOWTR_Font2, 15);
    local function OnLogin()
       firstloginframe:Show();
       C_Timer.After(15, function() firstloginframe:Hide() end);
    end
    firstloginframe:RegisterEvent("PLAYER_LOGIN");
    firstloginframe:SetScript("OnEvent", OnLogin);
end

-- Initialize modules
function addon:OnInitialize()
    -- Create the custom tooltip frame
    ST_MyGameTooltip = CreateFrame("GameTooltip", "ST_MyGameTooltip", UIParent, "GameTooltipTemplate");
    ST_MyGameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");

    -- Initialize event handler
    if addon.E and addon.E.Initialize then
        addon.E.Initialize()
    end

    -- Initialize GameTooltip hooks
    if addon.GT and addon.GT.Initialize then
        addon.GT.Initialize()
    end

    -- Hook other frames
    if ((GetLocale() == "enUS") or (GetLocale() == "enGB")) then
        if SpellBookFrame_Update and addon.MF and addon.MF.ST_updateSpellBookFrame then
            hooksecurefunc("SpellBookFrame_Update", addon.MF.ST_updateSpellBookFrame);
        end
    end

    -- Show login message
    firstloginframe()
end

-- Hook for initialization
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        addon:OnInitialize()
        self:UnregisterEvent("PLAYER_LOGIN")
    end
end)
