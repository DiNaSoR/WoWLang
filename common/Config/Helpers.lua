-- Config UI helper functions
-------------------------------------------------------------------------------------------------------

function CreateToggleButton(parentFrame, settingsTable, settingKey, onText, offText, point, onClick)
   local buttonOFF = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
   local buttonON = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")

   local function SetupButton(button, text)
      button:SetSize(120, 22)
      if WoWTR_Localization.lang == 'AR' and text == WoWTR_Localization.WoWTR_trDESC then
         button:SetText(QTR_ReverseIfAR(text))
         button:GetFontString():SetFont(WOWTR_Font2, 13)
      else
         button:SetText(text)
         local font, size = button:GetFontString():GetFont()
         button:GetFontString():SetFont(font, 13)
      end
      button:SetPoint(unpack(point))
      button:SetFrameStrata("TOOLTIP")
   end

   SetupButton(buttonOFF, offText)
   SetupButton(buttonON, onText)

   local function UpdateVisibility()
      if settingsTable[settingKey] == "1" then
         buttonOFF:Show(); buttonON:Hide()
      else
         buttonOFF:Hide(); buttonON:Show()
      end
   end

   buttonOFF:SetScript("OnClick", function()
      settingsTable[settingKey] = "0"
      UpdateVisibility()
      if onClick then onClick() end
   end)

   buttonON:SetScript("OnClick", function()
      settingsTable[settingKey] = "1"
      UpdateVisibility()
      if onClick then onClick() end
   end)

   UpdateVisibility()
   return UpdateVisibility
end



