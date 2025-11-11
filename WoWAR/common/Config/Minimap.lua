-- Minimap button setup using Ace/LDB
-------------------------------------------------------------------------------------------------------

local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LibStub("LibDBIcon-1.0", true)

if LDB and LDBIcon then
  WOWTR_minimapButton = LDB:NewDataObject("WOWTR_LDB", {
    type = "data source",
    text = "WOWTR_LDB",
    icon = WoWTR_Localization.mainFolder .. "\\Images\\icon.png",
    OnClick = function()
      if LibStub("AceConfigDialog-3.0", true) then
        LibStub("AceConfigDialog-3.0"):Open("WOWTR")
      elseif Settings and WOWTR and WOWTR.CategoryID then
        Settings.OpenToCategory(WOWTR.CategoryID)
      end
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

  -- Register icon using unified AceDB when available (set in Config/Main.lua)
  local function TryRegisterIcon()
    if WOWTR and WOWTR.db and WOWTR.db.profile and WOWTR.db.profile.minimap then
      LDBIcon:Register("WOWTR_LDB", WOWTR_minimapButton, WOWTR.db.profile.minimap)
      if WOWTR.db.profile.minimap.hide then
        LDBIcon:Hide("WOWTR_LDB")
      else
        LDBIcon:Show("WOWTR_LDB")
      end
      return true
    end
    return false
  end

  -- Attempt now; if DB not ready yet, retry shortly after ADDON_LOADED
  if not TryRegisterIcon() then
    local f = CreateFrame("Frame")
    f:RegisterEvent("ADDON_LOADED")
    f:SetScript("OnEvent", function(self, event, name)
      if TryRegisterIcon() then
        self:UnregisterEvent("ADDON_LOADED")
      end
    end)
  end
end
