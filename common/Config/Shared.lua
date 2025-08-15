function CreateToggleButton(parentFrame, settingsTable, settingKey, onText, offText, point, onClick)
   --print("CreateToggleButton: Creating toggle button for setting " .. settingKey)
   local buttonOFF = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
   local buttonON = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")

   local function SetupButton(button, text)
      --print("SetupButton: Setting up button with text: " .. tostring(text))
      button:SetSize(120, 22)
      if WoWTR_Localization.lang == 'AR' and text == WoWTR_Localization.WoWTR_trDESC then
         --print("SetupButton: Arabic text detected, reversing text")
         button:SetText(QTR_ReverseIfAR(text))
         button:GetFontString():SetFont(WOWTR_Font2, 13)
         --print("SetupButton: Set Arabic font WOWTR_Font2 with size 13")
      else
         button:SetText(text)
         local font, size = button:GetFontString():GetFont()
         --print("SetupButton: Original font: " .. tostring(font) .. ", size: " .. tostring(size))
         button:GetFontString():SetFont(font, 13)
         --print("SetupButton: Set font size to 13")
      end
      button:SetPoint(unpack(point))
      --print("SetupButton: Set button position to " .. tostring(point[1]) .. ", " .. tostring(point[2]))
      button:SetFrameStrata("TOOLTIP")
      --print("SetupButton: Set frame strata to TOOLTIP")
   end

   --print("CreateToggleButton: Setting up OFF button with text: " .. tostring(offText))
   SetupButton(buttonOFF, offText)
   --print("CreateToggleButton: Setting up ON button with text: " .. tostring(onText))
   SetupButton(buttonON, onText)

   local function UpdateVisibility()
      --print("UpdateVisibility: Current value of " .. settingKey .. " is " .. tostring(settingsTable[settingKey]))
      if settingsTable[settingKey] == "1" then
         --print("UpdateVisibility: Showing OFF button, hiding ON button")
         buttonOFF:Show(); buttonON:Hide()
      else
         --print("UpdateVisibility: Hiding OFF button, showing ON button")
         buttonOFF:Hide(); buttonON:Show()
      end
   end

   buttonOFF:SetScript("OnClick", function()
      --print("Button OFF clicked: Setting " .. settingKey .. " to 0")
      settingsTable[settingKey] = "0"
      UpdateVisibility()
      if onClick then
         --print("Executing onClick callback")
         onClick()
      end
   end)

   buttonON:SetScript("OnClick", function()
      --print("Button ON clicked: Setting " .. settingKey .. " to 1")
      settingsTable[settingKey] = "1"
      UpdateVisibility()
      if onClick then
         --print("Executing onClick callback")
         onClick()
      end
   end)

   --print("CreateToggleButton: Initial visibility update")
   UpdateVisibility()
   --print("CreateToggleButton: Returning UpdateVisibility function")
   return UpdateVisibility
end
