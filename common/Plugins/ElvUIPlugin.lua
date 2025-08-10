-- ElvUIPlugin.lua
-- Plugin to handle ElvUI font integrations

ElvUIPlugin = {}

-- Returns quest title font size, falling back to default if ElvUI is absent or disabled
function ElvUIPlugin:GetTitleFontSize(default)
   if C_AddOns and C_AddOns.IsAddOnLoaded and C_AddOns.IsAddOnLoaded("ElvUI") then
      local fonts = ElvUI[1] and ElvUI[1].db and ElvUI[1].db.general and ElvUI[1].db.general.fonts
      if fonts and fonts.questtext and fonts.questtext.enable then
         return fonts.questtitle.size
      end
   end
   return default
end

-- Returns quest text font size, falling back to default if ElvUI is absent or disabled
function ElvUIPlugin:GetTextFontSize(default)
   if C_AddOns and C_AddOns.IsAddOnLoaded and C_AddOns.IsAddOnLoaded("ElvUI") then
      local fonts = ElvUI[1] and ElvUI[1].db and ElvUI[1].db.general and ElvUI[1].db.general.fonts
      if fonts and fonts.questtext and fonts.questtext.enable then
         return fonts.questtext.size
      end
   end
   return default
end

