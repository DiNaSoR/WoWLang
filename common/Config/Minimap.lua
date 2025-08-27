-- Minimap button setup using Ace/LDB
-------------------------------------------------------------------------------------------------------

if ((GetLocale() == "enUS") or (GetLocale() == "enGB")) then
  local addon = LibStub("AceAddon-3.0"):NewAddon(WoWTR_Localization.addonName, "AceConsole-3.0")
  WOWTR_icon = LibStub("LibDBIcon-1.0");
  WOWTR_minimapButton = LibStub("LibDataBroker-1.1"):NewDataObject("WOWTR_LDB", {
    type = "data source",
    text = "WOWTR_LDB",
    icon = WoWTR_Localization.mainFolder .. "\\Images\\icon.png",
    OnClick = function()
      Settings.OpenToCategory(WOWTR.CategoryID);
    end,
    OnTooltipShow = function(tooltip)
      if (WoWTR_Localization.lang == 'AR') then
        tooltip:SetText("|cff8080ff" .. WOWTR_version .. "|r " .. QTR_ReverseIfAR(WoWTR_Localization.optionTitle));
      else
        tooltip:SetText(QTR_ReverseIfAR(WoWTR_Localization.optionTitle) .. " |cff8080ff" .. WOWTR_version .. "|r");
      end
      tooltip:AddLine("|cffffffff" .. QTR_ReverseIfAR(WoWTR_Localization.addonIconDesc) .. "|r");
      _G[tooltip:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, 15);
      _G[tooltip:GetName() .. "TextLeft2"]:SetFont(WOWTR_Font2, 13);
      tooltip:Show();
    end,
  })

  function addon:OnInitialize()
    WOWTR.db = LibStub("AceDB-3.0"):New("WoWTR_minimapDB", { profile = { minimap = { hide = false, minimapPos = 238, }, }, });
    WOWTR_icon:Register("WOWTR_LDB", WOWTR_minimapButton, WOWTR.db.profile.minimap);
  end
end


