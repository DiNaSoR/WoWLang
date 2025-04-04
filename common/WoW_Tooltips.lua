-- Description: The AddOn displays the translated text information in chosen language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-- Local Variables
local _G = _G;
local ST_miasto = "";      -- miejsce powrotu przedmiotu Heartstone
local ST_GameGossip_Show = false;
local ST_width2 = math.floor(UIParent:GetWidth() / 2 + 0.5);
local ST_height2 = math.floor(UIParent:GetHeight() / 2 + 0.5);
local ST_lastNumLines = 0;
local ST_load1 = false;
local ST_load2 = false;
--local ST_load3 = false;
local ST_load4 = false;
local ST_load5 = false;
local ST_load6 = false;
local ST_load7 = false;
local ST_load8 = false;
local ST_load9 = false;
local ST_load10 = false;
--local ST_load11 = false;
local ST_firstBoss = true;
local ST_nameBoss = { };
local ST_navBar1, ST_navBar2, ST_navBar3, ST_navBar4, ST_navBar5 = false;
ST_OriginalTextCache = {}
ST_OriginalFontCache = {}
ST_OriginalJustifyCache = {}

------------------------------------------------------------------------------------

--The plugin name and version number temporarily appear at the bottom left of the Chat Panel. WOWTR_Font1 and WOWTR_Font2 are triggered.
local firstloginframe = CreateFrame("Frame", nil, UIParent);
firstloginframe:SetSize(100, 50);
firstloginframe:SetPoint("BOTTOMLEFT", 12, 5);
local addonlogintext = firstloginframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
--local a1, a2, a3 = addonlogintext:GetFont();
addonlogintext:SetPoint("LEFT");
addonlogintext:SetText(WoWTR_Localization.addonName);
addonlogintext:SetTextColor(1, 1, 1, 0.1);
addonlogintext:SetFont(WOWTR_Font1, 20);
local addonlogintext2 = firstloginframe:CreateFontString(nil, "OVERLAY", "GameFontNormal");
--local a1, a2, a3 = addonlogintext2:GetFont();
addonlogintext2:SetPoint("LEFT", 0, -15);
addonlogintext2:SetText("ver. "..WOWTR_version);
addonlogintext2:SetTextColor(1, 1, 1, 0.1);
addonlogintext2:SetFont(WOWTR_Font2, 15);
local function OnLogin()
   firstloginframe:Show();
   C_Timer.After(15, function() firstloginframe:Hide() end);
end
firstloginframe:RegisterEvent("PLAYER_LOGIN");
firstloginframe:SetScript("OnEvent", OnLogin);

-------------------------------------------------------------------------------------------------------

function ST_UsunZbedneZnaki(txt)          -- przed obliczeniem kodu Hash
   if (not txt) then return ""; end
   text = string.gsub(txt,"|cFFFFFFFF","");
   text = string.gsub(text,"|r","");
   text = string.gsub(text,"\r","");
   text = string.gsub(text,"\n","");
   text = string.gsub(text,'%f[%a]'..WOWTR_player_name..'%f[%A]',"$N");
   text = string.gsub(text,"(%d),(%d)","%1%2");      -- usuń przecinek między cyframi (odstęp tysięczny)
   text = string.gsub(text,"0","");
   text = string.gsub(text,"1","");
   text = string.gsub(text,"2","");
   text = string.gsub(text,"3","");
   text = string.gsub(text,"4","");
   text = string.gsub(text,"5","");
   text = string.gsub(text,"6","");
   text = string.gsub(text,"7","");
   text = string.gsub(text,"8","");
   text = string.gsub(text,"9","");
   return text;
end

-------------------------------------------------------------------------------------------------------

function ST_PrzedZapisem(txt)
   local text = string.gsub(txt,"(%d),(%d)","%1%2");      -- usuń przecinek między cyframi (odstęp tysięczny)
   text = string.gsub(text,"\r","");
   text = string.gsub(text,'%f[%a]'..WOWTR_player_name..'%f[%A]',"$N");
   return text;
end

-------------------------------------------------------------------------------------------------------

function ST_RenkKoduSil(txt)
   if (not txt) then return ""; end
   local text = string.gsub(txt,"|r","");
   text = string.gsub(text,"Dragon Isles ","");
   text = string.gsub(text," Specializations","");
   text = string.gsub(text,"Classic ","");
   text = string.gsub(text,"|cffffd100","");
   text = string.gsub(text,"|cff0070dd","");
   text = string.gsub(text,"|cffffffff","");
   text = string.gsub(text,"|cff1eff00","");
   text = string.gsub(text,"|cffa335ee","");
   text = string.gsub(text,"|cffffd200","");
   return text;
end

-------------------------------------------------------------------------------------------------------

local ignoreSettings = {
    words = {
        "Seller: |cffffffff",
        "Sellers: |cffffffff",
        "Equipment Sets: |cFFFFFFFF",
        "|cff00ff00<Made by ",
        "Leader: |cffffffff",
        "Realm: |cffffffff",
        "Waiting on: |cff",
        "Reagents: |n",
        "  |A:raceicon128",
        "Achievement in progress by",
        "Achievement earned by",
        "You completed this on ",
        "AllTheThings",
        "|cffb4b4ffATT|r",
        "|cff0070dd",
        "|Hachievement:",
        "  |T",
        "   |c"
    },
    pattern = "[Яа-яĄ-Źą-źŻ-żЀ-ӿΑ-Ωα-ω]"
}

-- ST_CheckAndReplaceTranslationText(obj, sav, prefix, font1, onlyReverse, ST_corr)
function ST_CheckAndReplaceTranslationText(obj, sav, prefix, font1, onlyReverse, ST_corr, justifyAlign)
   if (obj and obj.GetText) then
      -- *** Store original justification ***
      local originalJustifyH = "LEFT" -- Default if GetJustifyH doesn't exist or fails
      if obj.GetJustifyH then
         local success, align = pcall(obj.GetJustifyH, obj)
         if success and align then
            originalJustifyH = align
         end
      end

      local txt = obj:GetText();
      local originalFont, originalSize, originalFlags -- Declare variables

      -- Try to get original font info early
      if obj.GetFont then
         originalFont, originalSize, originalFlags = obj:GetFont();
      end

      -- Cache original text, font, and justification if it's not already translated and not nil
      if txt and string.find(txt, NONBREAKINGSPACE) == nil then
         -- Only cache if it doesn't already look like our translated text
         ST_OriginalTextCache[obj] = txt
         if originalFont then
            ST_OriginalFontCache[obj] = {originalFont, originalSize, originalFlags}
         end
         ST_OriginalJustifyCache[obj] = originalJustifyH -- Cache justification
      end

      -- Proceed only if text exists and is not already translated (no NBSP)
      if (txt and string.find(txt, NONBREAKINGSPACE) == nil) then
         local ST_Hash = StringHash(ST_UsunZbedneZnaki(txt));

         if (ST_TooltipsHS[ST_Hash]) then
            -- *** Apply Translation ***
            local ST_tlumaczenie = ST_TooltipsHS[ST_Hash];
            ST_tlumaczenie = ST_TranslatePrepare(txt, ST_tlumaczenie);
            if not ST_corr then
               ST_corr = 0;
            end

            local processedText;
            if (onlyReverse) then
               processedText = QTR_ReverseIfAR(ST_tlumaczenie)..NONBREAKINGSPACE;
            else
               processedText = QTR_ExpandUnitInfo(ST_tlumaczenie, true, obj, WOWTR_Font2, ST_corr)..NONBREAKINGSPACE;
            end
            obj:SetText(processedText);

            -- Set Font
            if obj.SetFont then
               local success_size, size = pcall(select, 2, obj.GetFont(obj))
               -- Use cached size as fallback if current size fails, else default to 12
               if not success_size then size = originalSize or 12 end
               local chosen_font = font1 or WOWTR_Font2
               pcall(obj.SetFont, obj, chosen_font, size)
            end

            -- Set Justification (Apply passed 'justifyAlign' if valid)
            if justifyAlign and obj.SetJustifyH then
               if justifyAlign == "LEFT" or justifyAlign == "RIGHT" or justifyAlign == "CENTER" then
                   pcall(obj.SetJustifyH, obj, justifyAlign)
               else
                  -- If justifyAlign was provided but invalid, fall back to original
                  pcall(obj.SetJustifyH, obj, originalJustifyH)
               end
            elseif obj.SetJustifyH then
               -- Ensure original justification if justifyAlign was nil (though it was already cached)
               pcall(obj.SetJustifyH, obj, originalJustifyH)
            end

            return -- Return after successful translation/formatting
         else
            -- *** No Translation Found ***
            -- Revert font to original (using cached values if available)
            if obj.SetFont and originalFont then
               pcall(obj.SetFont, obj, originalFont, originalSize, originalFlags);
            end
            -- *** Restore original justification *** (Already done by default, but explicit doesn't hurt)
            if obj.SetJustifyH then
               pcall(obj.SetJustifyH, obj, originalJustifyH)
            end

            -- Save untranslated text if enabled
            if (sav and (ST_PM["saveNW"]=="1")) then
               ST_PH[ST_Hash] = prefix.."@"..ST_PrzedZapisem(txt);
            end
         end
      -- else -- Text was nil or already translated (had NBSP)
         -- Do nothing here - either no text or already handled.
         -- Reversion for already-translated text happens via ST_revertProfessionDescription
      end
   end
end



-------------------------------------------------------------------------------------------------------
-- obj=object with stingtext,  sav=permission to save untranstaled tekst (true/false)
-- prefix=text to save group,  font1=if present:SetFont to given font file
-- Font Files: WOWTR_Font1, Original_Font1, Original_Font2
-- ST_CheckAndReplaceTranslationTextUI(obj, sav, prefix, font1)

function ST_CheckAndReplaceTranslationTextUI(obj, sav, prefix, font1)
   if (obj and obj.GetText) then
       local txt = obj:GetText();
       local originalFont, originalSize, originalFlags -- Declare variables
       local originalJustifyH = "LEFT" -- Default

       -- Try to get original font info early
       if obj.GetFont then
           originalFont, originalSize, originalFlags = obj:GetFont();
       end
       -- *** Store original justification ***
       if obj.GetJustifyH then
           local success, align = pcall(obj.GetJustifyH, obj)
           if success and align then
               originalJustifyH = align
           end
       end

       -- Cache original text, font, and justification if it's not already translated and not nil
       if txt and string.find(txt, NONBREAKINGSPACE) == nil then
            ST_OriginalTextCache[obj] = txt
            if originalFont then
                 ST_OriginalFontCache[obj] = {originalFont, originalSize, originalFlags}
            end
            ST_OriginalJustifyCache[obj] = originalJustifyH -- Cache justification
       end

       -- Ignore specific patterns/words
       local function shouldIgnore(text)
           -- ... (keep existing shouldIgnore logic) ...
           -- ...
            return false
       end

       -- Proceed only if text exists, is not already translated (no NBSP), and not ignored
       if (txt and string.find(txt, NONBREAKINGSPACE) == nil and not shouldIgnore(txt)) then
           -- ... (existing hash calculation logic) ...
           local ST_Hash = StringHash(ST_UsunZbedneZnaki(txt));
           -- ...

           if (ST_TooltipsHS[ST_Hash]) then
               -- *** Apply Translation ***
               local a1, a2, a3 = obj:GetFont(); -- a2 is likely the size
               -- ... (translation application logic) ...
               obj:SetText(QTR_ReverseIfAR(ST_TranslatePrepare(txt, ST_TooltipsHS[ST_Hash]))..NONBREAKINGSPACE);

               -- Set Font
               if obj.SetFont then
                   local targetSize = a2 or originalSize or 12
                   local targetFont = font1 or WOWTR_Font2
                   pcall(obj.SetFont, obj, targetFont, targetSize); -- Use pcall for safety
               end
                -- Set Justification (UI usually doesn't change justification)
               -- If needed, apply logic similar to ST_CheckAndReplaceTranslationText

           elseif (sav and (TT_PS["saveui"] == "1")) then
               -- *** No Translation, Saving Enabled ***
               ST_PH[ST_Hash] = prefix.."@"..ST_PrzedZapisem(txt);
               -- Ensure original font and justification are restored
               if obj.SetFont and originalFont then
                   pcall(obj.SetFont, obj, originalFont, originalSize, originalFlags);
               end
               if obj.SetJustifyH then
                   pcall(obj.SetJustifyH, obj, originalJustifyH);
               end
           else
               -- *** No Translation, Saving Disabled ***
               -- Explicitly revert font and justification to original
               if obj.SetFont and originalFont then
                  pcall(obj.SetFont, obj, originalFont, originalSize, originalFlags);
               end
               if obj.SetJustifyH then
                   pcall(obj.SetJustifyH, obj, originalJustifyH);
               end
           end
       -- else -- Text was nil, already translated (had NBSP), or ignored
          -- Reversion happens via ST_revertProfessionDescription if needed.
          -- Still important to restore original justification if it was modified before
          -- and then the condition here became false (e.g., text became nil)
          if obj.SetJustifyH then
            local cachedJustify = ST_OriginalJustifyCache[obj]
            if cachedJustify then
                pcall(obj.SetJustifyH, obj, cachedJustify)
            -- else -- If nothing cached, maybe revert to default? Depends on desired behavior
            --    pcall(obj.SetJustifyH, obj, "LEFT")
            end
          end
       end
   end
end

-------------------------------------------------------------------------------------------------------

-- Przygotowuje tłumaczenie właściwe: zamienia $x w tłumaczeniu na odpowiednie liczby z oryginału
function ST_TranslatePrepare(ST_origin, ST_tlumacz)
   local tlumaczenie = WOW_ZmienKody(ST_tlumacz);
   if (not ST_miasto) then
      ST_miasto = WoWTR_Localization.your_home;
   end
   tlumaczenie = string.gsub(tlumaczenie, "$L", QTR_ReverseIfAR(ST_miasto));    -- miasto lokalizacji do Kamienia Powrotu
   local wartab = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};         -- max. 20 liczb całkowitych w tekście
   local arg0 = 0;
   ST_origin = string.gsub(ST_origin,"(%d),(%d)","%1%2");            -- usuń przecinek tysięczny przy liczbach
   for w in string.gmatch(ST_origin, "%d+") do
      arg0 = arg0 + 1;                                               -- formatowanie do postaci: 99.123.456
      if (WoWTR_Localization.lang == 'TR') then
         wartab[arg0] = w:gsub("(%d+)", function(num)
           if #num > 1 and num:sub(1,1) == "0" then
            return num
           else
            return tonumber(num)
           end
         end)
      elseif (WoWTR_Localization.lang == 'JP') then                      -- formatowanie do postaci: 99,123,456 (JP)
         if (math.floor(w)>999999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1,%2,"):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
         elseif (math.floor(w)>99999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1,%2"):gsub("(%-?)$", "%1"):reverse();    -- tu mamy kolejne cyfry z oryginału
         elseif (math.floor(w)>999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)", "%1,"):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
         else   
            wartab[arg0] = tostring(math.floor(w));
         end
      else                                                           -- formatowanie do postaci: 99.123.456 (Europe)
         if (math.floor(w)>999999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1,%2,"):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
         elseif (math.floor(w)>99999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1,%2"):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
         elseif (math.floor(w)>999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)", "%1,"):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
         else   
            wartab[arg0] = tostring(math.floor(w));
         end
      end
   end;
   if (WoWTR_Localization.lang == 'TR') then
      for i = 40, 1, -1 do
        local pattern = string.format("{%02d}", i)
        local dollarPattern = "$" .. i
        if arg0 >= i then
          tlumaczenie = string.gsub(tlumaczenie, pattern, WOWTR_AnsiReverse(wartab[i]))
          tlumaczenie = string.gsub(tlumaczenie, dollarPattern, WOWTR_AnsiReverse(wartab[i]))
        end
      end
   else
      for i = 1, 40 do
         if (arg0 >= i) then
            -- Reverse "i" to match the curly-brace pattern (e.g. 12 => "{21}")
            local reversedI = tostring(i):reverse()
            tlumaczenie = string.gsub(tlumaczenie, "{" .. reversedI .. "}", WOWTR_AnsiReverse(wartab[i]))
            tlumaczenie = string.gsub(tlumaczenie, "$"  .. i,           WOWTR_AnsiReverse(wartab[i]))
         end
      end
   end
   if (WoWTR_Localization.lang ~= 'AR') then
      tlumaczenie = string.gsub(tlumaczenie, "$o", "$O");
      local nr_1, nr_2, nr_3 = 0;
      local QTR_forma = "";
      local nr_poz = string.find(tlumaczenie, "$O");    -- gdy nie znalazł, jest: nil
      while (nr_poz and nr_poz>0) do
         nr_1 = nr_poz + 1;   
         while (string.sub(tlumaczenie, nr_1, nr_1) ~= "(") do
            nr_1 = nr_1 + 1;
         end
         if (string.sub(tlumaczenie, nr_1, nr_1) == "(") then
            nr_2 =  nr_1 + 1;
            while (string.sub(tlumaczenie, nr_2, nr_2) ~= ";") do
               nr_2 = nr_2 + 1;
            end
            if (string.sub(tlumaczenie, nr_2, nr_2) == ";") then
               nr_3 = nr_2 + 1;
               while (string.sub(tlumaczenie, nr_3, nr_3) ~= ")") do
                  nr_3 = nr_3 + 1;
               end
               if (string.sub(tlumaczenie, nr_3, nr_3) == ")") then
                  if (QTR_PS["ownname"] == "1") then        -- forma polska
                     QTR_forma = string.sub(tlumaczenie,nr_2+1,nr_3-1);
                  else                                      -- forma angielska
                     QTR_forma = QTR_ReverseIfAR(string.sub(tlumaczenie,nr_1+1,nr_2-1));
                  end
                  tlumaczenie = string.sub(tlumaczenie,1,nr_poz-1) .. QTR_forma .. string.sub(tlumaczenie,nr_3+1);
               end   
            end
         end
         nr_poz = string.find(tlumaczenie, "$O");
      end
   end

   return tlumaczenie;
end

-------------------------------------------------------------------------------------------------------

function OkreslKodKoloru(k1,k2,k3)
   local kol1=('%.0f'):format(k1);
   local kol2=('%.0f'):format(k2);
   local kol3=('%.0f'):format(k3);
   local c_out='c?';
   if (kol1=="0" and kol2=="0" and kol3=="0") then
      c_out='c1';
   elseif (kol1=="0" and kol2=="0" and kol3=="1") then
      c_out='c2';
   elseif (kol1=="0" and kol2=="1" and kol3=="0") then
      c_out='c3';
   elseif (kol1=="0" and kol2=="1" and kol3=="1") then
      c_out='c4';
   elseif (kol1=="1" and kol2=="0" and kol3=="0") then
      c_out='c5';
   elseif (kol1=="1" and kol2=="0" and kol3=="1") then
      c_out='c6';
   elseif (kol1=="1" and kol2=="1" and kol3=="0") then
      c_out='c7';
   else
      c_out='c8';
   end
   return c_out;   
end

-------------------------------------------------------------------------------------------------------

if ((GetLocale()=="enUS") or (GetLocale()=="enGB")) then

-- funkcja wywoływana po wyświetleniu się oryginalnego okienka Tooltip
   GameTooltip:HookScript('OnUpdate', function(self, ...)
      if (not WOWTR_wait(0, ST_GameTooltipOnShow)) then
      -- opóźnienie 0.01 sek
      end
   end );

-------------------------------------------------------------------------------------------------------

-- funkcja wywoływana po ukryciu oryginalnego okienka Tooltip
   GameTooltip:HookScript('OnHide', function(self, ...)
      ST_lastNumLines = 0;
   end );

-------------------------------------------------------------------------------------------------------

-- funkcja wywoływana po wyświetleniu się oryginalnego okienka Tooltip
   GameTooltip:HookScript('OnUpdate', function(self, ...)
      if ((ST_PM["active"]=="1") and (ST_lastNumLines > 0)) then                        -- dodatek aktywny
         if ((ST_PM["constantly"] == "1") and (UnitLevel("player") > 10)) then
            if ((ST_PM["showID"] == "1") or (ST_PM["showHS"] == "1")) then
               if (ST_lastNumLines ~= self:NumLines()) then
                  ST_GameTooltipOnShow();
               end
            elseif (_G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText() and (string.find(_G["GameTooltipTextLeft1"]:GetText(),NONBREAKINGSPACE)==nil)) then
               ST_GameTooltipOnShow();
            end
         elseif ((ST_PM["constantly"] == "1") and (self.updateTooltipTimer > 1)) then
            self.updateTooltipTimer = 2;
         end
      end
   end );
   
end

-------------------------------------------------------------------------------------------------------
-- Generic UI Helpers (Could potentially be moved to a shared UI utilities file later)
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
           button:GetFontString():SetFont(button:GetFontString():GetFont(), 13)
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
-------------------------------------------------------------------------------------------------------

function ST_ElvSpellBookTooltipOnShow()
   local E, L, V, P, G = unpack(ElvUI);
   local ElvUISpellBookTooltip = E.SpellBookTooltip;
   local numLines = ElvUISpellBookTooltip:NumLines();

   if (numLines == 1) then   -- ElvUISpellBookTooltip zawiera tylko 1 linijkę opisu i jest to tytuł spella
      return;
   end
   
   if (ST_PM["spell"] == "0") then
      return;
   end
   
   local ST_kodKoloru;
   local ST_leftText, ST_rightText, ST_tlumaczenie, ST_hash, ST_hash2;
   local _font1, _size1, _1;
   
   local ST_prefix = "s";
   if (ElvUISpellBookTooltip.processingInfo and ElvUISpellBookTooltip.processingInfo.tooltipData.id) then
      ST_prefix = ST_prefix..ElvUISpellBookTooltip.processingInfo.tooltipData.id;
   end
   ElvUISpellBookTooltip:HookScript("OnHide", function() ST_MyGameTooltip:Hide(); end);
   ST_MyGameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE" );
   ST_MyGameTooltip:ClearAllPoints();
   ST_MyGameTooltip:SetPoint("TOPLEFT", ElvUISpellBookTooltip, "BOTTOMLEFT", 0, 0);    -- pod przyciskiem od lewej strony
   ST_MyGameTooltip:ClearLines();
   for i = 2, numLines-1, 1 do
      ST_leftText = _G[ElvUISpellBookTooltip:GetName().."TextLeft"..i]:GetText();
      leftColR, leftColG, leftColB = _G[ElvUISpellBookTooltip:GetName().."TextLeft"..i]:GetTextColor();
      ST_kodKoloru = OkreslKodKoloru(leftColR, leftColG, leftColB);
      if (ST_leftText and (string.len(ST_leftText)>15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText)>30))) then
         ST_hash = StringHash(ST_UsunZbedneZnaki(ST_leftText));
         if (((ST_kodKoloru == "c7") or (string.len(ST_leftText)>30)) and (not ST_hash2)) then
            ST_hash2 = ST_hash;
         end
         if (ST_TooltipsHS[ST_hash]) then        -- mamy przetłumaczony ten Hash
            ST_tlumaczenie = ST_TooltipsHS[ST_hash];
            ST_tlumaczenie = ST_TranslatePrepare(ST_leftText, ST_tlumaczenie);
            ST_MyGameTooltip:AddLine(QTR_ReverseIfAR(ST_tlumaczenie), leftColR, leftColG, leftColB, true);
            numLines = ST_MyGameTooltip:NumLines();           -- aktualna liczba linii
            _font1, _size1, _1 = _G[ElvUISpellBookTooltip:GetName().."TextLeft"..i]:GetFont();    -- odczytaj aktualną czcionkę i rozmiar    
            _G["ST_MyGameTooltipTextLeft"..numLines]:SetFont(WOWTR_Font2, 11);        -- ustawiamy własną czcionkę 
         end
      end
   end
   
   if (((ST_PM["showID"]=="1") and (string.len(ST_prefix) > 1)) or ((ST_PM["showHS"]=="1") and ST_hash2)) then   -- czy dodawać ID i Hash ?
      numLines = ST_MyGameTooltip:NumLines();           -- aktualna liczba linii
      if (numLines == 0) then
         ST_MyGameTooltip:AddLine(QTR_Messages.missing, 1, 1, 0.5);
         _G["ST_MyGameTooltipTextLeft1"]:SetFont(WOWTR_Font2, 11);      -- ustawiamy czcionkę turecką
      end
      ST_MyGameTooltip:AddLine(" ",0,0,0);           -- dodaj odstęp przed linią z ID
      typName = "Spell";
      ST_ID = string.sub(ST_prefix,2);
      if ((ST_PM["showID"]=="1") and ST_ID) then
         ST_MyGameTooltip:AddLine(typName.." ID: "..tostring(ST_ID),0,1,1);
         numLines = ST_MyGameTooltip:NumLines();                -- Aktualna liczba linii w ST_MyGameTooltip
         _G["ST_MyGameTooltipTextLeft"..numLines]:SetFont(WOWTR_Font2, 10);      -- wielkość 12
      end
      if ((ST_PM["showHS"]=="1") and ST_hash2) then
         ST_MyGameTooltip:AddLine("Hash: "..tostring(ST_hash2),0,1,1);
         numLines = ST_MyGameTooltip:NumLines();                -- Aktualna liczba linii w ST_MyGameTooltip
         _G["ST_MyGameTooltipTextLeft"..numLines]:SetFont(WOWTR_Font2, 10);      -- wielkość 12
      end
   end

   ST_MyGameTooltip:Show();         -- wyświetla ramkę w tłumaczeniem (zrobi także resize)
end

-------------------------------------------------------------------------------------------------------

function ST_BuffOrDebuff()
   if (_G["GameTooltipTextLeft2"] and _G["GameTooltipTextLeft2"]:GetText()) then
      local ST_leftText2 = _G["GameTooltipTextLeft2"]:GetText();
      local ST_hash = StringHash(ST_UsunZbedneZnaki(ST_leftText2));
      if (ST_TooltipsHS[ST_hash]) then        -- mamy przetłumaczony ten Hash
         local ST_tlumaczenie = ST_TooltipsHS[ST_hash];
         ST_tlumaczenie = ST_TranslatePrepare(ST_leftText2, ST_tlumaczenie);
         local leftColR, leftColG, leftColB = _G["GameTooltipTextLeft2"]:GetTextColor();
         
         if not GameTooltip.OnHideHooked then
            GameTooltip:HookScript("OnHide", function() 
               C_Timer.After(0.01, function() 
                  ST_MyGameTooltip:Hide() 
               end)
            end)
            GameTooltip.OnHideHooked = true
         end

         ST_MyGameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE" );
         ST_MyGameTooltip:ClearAllPoints();
         ST_MyGameTooltip:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", 0, 0);    -- pod przyciskiem od prawej strony
         ST_MyGameTooltip:ClearLines();
         if (WoWTR_Localization.lang == 'AR') then
            ST_MyGameTooltip:AddLine(QTR_ExpandUnitInfo(ST_tlumaczenie,false,ST_MyGameTooltip,WOWTR_Font2), leftColR, leftColG, leftColB, true);
         else
            ST_MyGameTooltip:AddLine(QTR_ReverseIfAR(ST_tlumaczenie), leftColR, leftColG, leftColB, true);
         end
         _G["ST_MyGameTooltipTextLeft1"]:SetFont(WOWTR_Font2, 12);      -- wielkość 12
         if (ST_PM["showHS"]=="1") then            -- czy Hash ?
            ST_MyGameTooltip:AddLine(" ",0,0,0);   -- dodaj odstęp przed linią z Hash
            ST_MyGameTooltip:AddLine("Hash: "..tostring(ST_hash),0,1,1);
            _G["ST_MyGameTooltipTextLeft3"]:SetFont(WOWTR_Font2, 12);      -- wielkość 12
         end
         ST_MyGameTooltip:Show();         -- wyświetla ramkę w tłumaczeniem (zrobi także resize)
      elseif ((ST_PM["saveNW"]=="1") and GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id) then
         local ST_prefix = "s"..GameTooltip.processingInfo.tooltipData.id;
         ST_PH[ST_hash]=ST_prefix.."@"..ST_PrzedZapisem(ST_leftText2);
      end
   end
end

-------------------------------------------------------------------------------------------------------

function ST_GameTooltipOnShow()
--print("Jestem w OnShow");
   if (ST_PM["active"]=="1") then                        -- dodatek aktywny
   
      ST_lastNumLines = 0;
      -- tu jeszcze obsługa buffów i debuffów - tłumaczenie w oddzielnej ramce pod oryginałem
      local ST_BFisOver = BuffFrame:IsMouseOver() or (ElvUIPlayerBuffs and ElvUIPlayerBuffs:IsMouseOver());
      local ST_DFisOver = DebuffFrame:IsMouseOver() or (ElvUIPlayerDebuffs and ElvUIPlayerDebuffs:IsMouseOver());
      if (ST_BFisOver or ST_DFisOver) then               -- Buffy i Debuffy
         ST_BuffOrDebuff();
         return;
      end
      
      GameTooltip.updateTooltipTimer = tonumber(ST_PM["timer"]);   -- X sekund zatrzymania uaktualnienia GameTooltip
      if (_G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText()) then
         if (string.find(_G["GameTooltipTextLeft1"]:GetText(),NONBREAKINGSPACE)) then
             return;
         end
         _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(_G["GameTooltipTextLeft1"]:GetText(),WOWTR_Font2)..NONBREAKINGSPACE);   -- znacznik twardej spacji do tytułu
      end
      
      local ST_prefix = "h";
      if (GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id) then
         if (GameTooltip.processingInfo.tooltipData.type == 0) then           -- items
            ST_prefix = "i" .. GameTooltip.processingInfo.tooltipData.id;
            if (ST_PM["item"] == "0") then      -- nie ma zezwolenia tłumaczenia przedmiotów
               return;
            end
         elseif (GameTooltip.processingInfo.tooltipData.type == 1) then       -- spell or talent
            if ST_IsTalentTooltip and ST_IsTalentTooltip(GameTooltip.processingInfo.tooltipData) then
               ST_prefix = "t" .. GameTooltip.processingInfo.tooltipData.id;
               if (ST_PM["talent"] == "0") then      -- nie ma zezwolenia tłumaczenia talentów
                  return;
               end
            else
               ST_prefix = "s" .. GameTooltip.processingInfo.tooltipData.id;
               if (ST_PM["spell"] == "0") then      -- nie ma zezwolenia tłumaczenia spelli
                  return;
               end
            end
         else   --if (GameTooltip.processingInfo.tooltipData.type > 1) then
            ST_prefix = "s" .. GameTooltip.processingInfo.tooltipData.id;
            if (ST_PM["spell"] == "0") and (GameTooltip.processingInfo.tooltipData.id == 9) then    -- nie ma zezwolenia tłumaczenia spelli
               return;
            end
         end
      end

      local numLines = GameTooltip:NumLines();
      if ((numLines == 1) and (ST_prefix ~= "h")) then   -- GameTooltip zawiera tylko 1 linijkę opisu i jest to tytuł itemu lub spella
         return;
      end
      
      local ST_kodKoloru;
      local ST_leftText, ST_rightText, ST_tlumaczenie, ST_hash, ST_hash2, ST_pomoc5, ST_pomoc6, ST_pomoc7;
      local _font1, _size1, _1;
      local ST_odstep = true;
      local ST_orygText = {};
      local ST_nh = 0;   -- nowy Hash ?
      
      -- sprawdź czy są ramki z ceną
      local moneyFrameLineNumber = {};
      local money = {};
      table.insert(moneyFrameLineNumber, 0);
      table.insert(money,0);
      if (GameTooltip.shownMoneyFrames) then        -- są ramki z ceną itemu
         for i = 1, GameTooltip.shownMoneyFrames, 1 do
            local moneyFrameName = GameTooltip:GetName().."MoneyFrame"..i;           -- nazwa obiektu
            _G[moneyFrameName.."PrefixText"]:SetText(QTR_ReverseIfAR(WoWTR_Localization.sellPrice));  -- SELL PRICE
            _font1, _size1, _1 = _G[moneyFrameName.."PrefixText"]:GetFont();  -- odczytaj aktualną czcionkę i rozmiar    
            _G[moneyFrameName.."PrefixText"]:SetFont(WOWTR_Font2, _size1);
            if (ST_PM["sellprice"] == "1") then    -- jest zezwolenie na ukrycie ceny skupu
               _G[moneyFrameName]:Hide();
               ST_odstep = false;
            end
         end
      end

      local ST_fromLine = 2;
      if (ST_prefix == "h") then
         ST_fromLine = 1;
      end
      
      if (ST_TooltipsID and (ST_PM["transtitle"]=="1") and ST_TooltipsID[ST_prefix]) then     -- jest zezwolenie na tłumaczenie tytułu i jest tłumaczenie
         _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(ST_TooltipsID[ST_prefix],WOWTR_Font2)..NONBREAKINGSPACE);   -- znacznik twardej spacji do tytułu
         _font1, _size1, _1 = _G["GameTooltipTextLeft1"]:GetFont();           -- odczytaj aktualną czcionkę i rozmiar    
         _G["GameTooltipTextLeft1"]:SetFont(WOWTR_Font2, _size1);
      end

      -- Get the line object
      local lineObj = _G["GameTooltipTextLeft1"]
      -- Get original font details *before* deciding translation
      local originalFont, originalSize, originalFlags = lineObj:GetFont()

      for i = ST_fromLine, numLines, 1 do
         ST_leftText = _G["GameTooltipTextLeft"..i]:GetText();
         if (ST_leftText and (string.find(ST_leftText,NONBREAKINGSPACE)==nil)) then                 -- nie jest to nasze tłumaczenie
            leftColR, leftColG, leftColB = _G["GameTooltipTextLeft"..i]:GetTextColor();
            ST_kodKoloru = OkreslKodKoloru(leftColR, leftColG, leftColB);
            if (ST_leftText and (string.len(ST_leftText)>15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText)>30))) then
--print(ST_kodKoloru,i,ST_leftText);
               if (GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id and (GameTooltip.processingInfo.tooltipData.id == 6948)) then   -- wyjątek na Kamień Powrotu
                  ST_pomoc5, _ = string.find(ST_leftText,". Speak");        -- znajdź kropkę kończącą pierwsze zdanie
                  if (ST_pomoc5 and (ST_pomoc5>22)) then
                     ST_miasto = string.sub(ST_leftText,21,ST_pomoc5-1);
                  else
                     ST_miasto = WoWTR_Localization.your_home;
                  end
                  ST_pomoc6, _ = string.find(ST_leftText,' Min Cooldown)');
                  if (ST_pomoc6) then              -- mamy 2 wersję tekstu z Cooldown
                     ST_hash = 1336493626;
                  else                             -- 1 wersja tekstu (bez Cooldown)
                     ST_hash = 3076025968;
                  end
               else
                  ST_hash = StringHash(ST_UsunZbedneZnaki(ST_leftText));
               end
               if (((ST_kodKoloru == "c7") or (string.len(ST_leftText)>30)) and (not ST_hash2)) then
                  ST_hash2 = ST_hash;
               end
               ST_pomoc7, _ = string.find(ST_leftText,"<Made by");    -- znajdź czy jest to tekst typu "|cff00ff00<Made by Platine>|r"
               if (ST_pomoc7) then
                  ST_hash = 1381871427;
               end
               if (ST_TooltipsHS[ST_hash]) then        -- mamy przetłumaczony ten Hash lub jest to <Made by...
                  if (ST_pomoc7) then
                     local endBy = string.find(ST_leftText,">");
                     local nameBy = string.sub(ST_leftText,ST_pomoc7+9,endBy-1);
                     ST_tlumaczenie = ST_TooltipsHS[ST_hash];
                     if (WoWTR_Localization.lang == 'AR') then
                        ST_tlumaczenie = string.gsub(ST_tlumaczenie, "NAMEBY", string.reverse(nameBy));
                        ST_tlumaczenie = string.gsub(ST_tlumaczenie, "{$M}", string.reverse(nameBy));
                     else
                        ST_tlumaczenie = string.gsub(ST_tlumaczenie, "$M", nameBy);
                     end
                  else
                     ST_tlumaczenie = ST_TooltipsHS[ST_hash];
                  end
                  ST_tlumaczenie = ST_TranslatePrepare(ST_leftText, ST_tlumaczenie);
                  _font1, _size1, _1 = _G["GameTooltipTextLeft"..i]:GetFont();    -- odczytaj aktualną czcionkę i rozmiar    
                  _G["GameTooltipTextLeft"..i]:SetFont(WOWTR_Font2, _size1);      -- ustawiamy czcionkę turecką
                  _G["GameTooltipTextLeft"..i]:SetText(QTR_ExpandUnitInfo(ST_tlumaczenie,false,_G["GameTooltipTextLeft"..i],WOWTR_Font2, -5)..NONBREAKINGSPACE);      -- dodajemy twardą spacje na końcu
                  _G["GameTooltipTextLeft"..i].wrap = true;
                  if (GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id and (GameTooltip.processingInfo.tooltipData.id == 6948)) then   -- wyjątek na Kamień Powrotu
                     break;
                  end
               else
                   -- >>> Explicitly ensure original font if no translation <<<
                  if lineObj.SetFont then
                      lineObj:SetFont(originalFont, originalSize, originalFlags)
                  end
                  -- >>> End explicit ensure <<<

                  ST_nh = 1;              -- nowy Hash
                  table.insert(ST_orygText,ST_leftText);
               end
            end
         end
      end
      

      if (((ST_PM["showID"]=="1") and (string.len(ST_prefix) > 1)) or ((ST_PM["showHS"]=="1") and ST_hash2)) then   -- czy dodawać ID i Hash ?
         numLines = GameTooltip:NumLines();           -- aktualna liczba linii
         if (numLines > 0 and ST_odstep) then
            GameTooltip:AddLine(" ",0,0,0);           -- dodaj odstęp przed linią z ID
         end
         local typName = " ";
         if (string.sub(ST_prefix,1,1) == "i") then
            typName = "Item";
            ST_ID = string.sub(ST_prefix,2);
         elseif (string.sub(ST_prefix,1,1) == "s") then
            typName = "Spell";
            ST_ID = string.sub(ST_prefix,2);
         elseif (string.sub(ST_prefix,1,1) == "t") then
            typName = "Talent";
            ST_ID = string.sub(ST_prefix,2);
         else
            ST_ID = nil;
         end
         if ((ST_PM["showID"]=="1") and ST_ID) then
            GameTooltip:AddLine(typName.." ID: "..tostring(ST_ID),0,1,1);
            numLines = GameTooltip:NumLines();                -- Aktualna liczba linii w GameTooltip
            _G["GameTooltipTextLeft"..numLines]:SetFont(WOWTR_Font2, 12);      -- wielkość 12
            _G["GameTooltipTextRight"..numLines]:SetFont(WOWTR_Font2, 12);     -- wielkość 12
         end
         if ((ST_PM["showHS"]=="1") and ST_hash2) then
            GameTooltip:AddLine("Hash: "..tostring(ST_hash2),0,1,1);
            numLines = GameTooltip:NumLines();                -- Aktualna liczba linii w GameTooltip
            _G["GameTooltipTextLeft"..numLines]:SetFont(WOWTR_Font2, 12);      -- wielkość 12
            _G["GameTooltipTextRight"..numLines]:SetFont(WOWTR_Font2, 12);     -- wielkość 12
         end
      end
      
      if ((ST_PM["constantly"] == "1") and (UnitLevel("player") > 60) and _G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText()) then
         _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(_G["GameTooltipTextLeft1"]:GetText(),WOWTR_Font2)..NONBREAKINGSPACE);
      end
      GameTooltip:Show();   -- wyświetla ramkę podpowiedzi (zrobi także resize)
      ST_lastNumLines = GameTooltip:NumLines();

      if ((ST_orygText or (ST_nh == 1)) and (ST_PM["saveNW"] == "1")) then
          for _, ST_origin in ipairs(ST_orygText) do
              local ST_hash = StringHash(ST_UsunZbedneZnaki(ST_origin))
              if (string.sub(ST_origin, 1, 11) ~= '|A:raceicon') then
                  local shouldSave = true
                  
                  for _, word in ipairs(ignoreSettings.words) do
                      if string.find(ST_origin, word) then
                          shouldSave = false
                          break
                      end
                  end

                  if shouldSave and string.find(ST_origin, ignoreSettings.pattern) then
                      shouldSave = false
                  end

                  if shouldSave then
                      ST_PH[ST_hash] = ST_prefix .. "@" .. ST_PrzedZapisem(ST_origin)
                  end
              end
          end
      end
   end
end

-------------------------------------------------------------------------------------------------------

function ST_SetText(txt)      -- funkcja wyszukuje tłumaczenie, albo zapisuje test oryginalny
   if (string.find(txt,NONBREAKINGSPACE)==nil) then    -- nie jest to tekst turecki (nie ma twardej spacji na końcu tłumaczenia)
      local ST_hash = StringHash(ST_UsunZbedneZnaki(txt));
      if (ST_TooltipsHS[ST_hash]) then
         return ST_TooltipsHS[ST_hash]..NONBREAKINGSPACE;       -- dodajemy twardą spację na końcu tłumaczenia
      elseif (ST_PM["saveNW"]=="1") then           -- jest zezwolenie na zapis oryginalnego tekstu
         ST_PH[ST_hash] = "ui@"..ST_PrzedZapisem(txt);
      end
   end
   return txt;       -- zwracamy oryginalny tekst bez zmiany   
end

-------------------------------------------------------------------------------------------------------

if ((GetLocale()=="enUS") or (GetLocale()=="enGB")) then
   hooksecurefunc("GameTooltip_ShowCompareItem",function(self)
      if (ShoppingTooltip1 and ShoppingTooltip1:IsVisible()) then
         ST_CurrentEquipped(ShoppingTooltip1);
      end
      if (ShoppingTooltip2 and ShoppingTooltip2:IsVisible()) then
         ST_CurrentEquipped(ShoppingTooltip2);
      end
   end );
end

--GameTooltip:HookScript("KeyDown", function() print("key pressed"); end);

-------------------------------------------------------------------------------------------------------

-- Funkcja przegląda wyświetlane itemy Current Equipped w oknie ShoppingTooltip1 lub ShoppingTooltip2
function ST_CurrentEquipped(obj)
   if ((ST_PM["active"]=="1") and (ST_PM["item"] == "1")) then          -- dodatek aktywny i zezwolono na tłumaczenie itemów
      if (obj.processingInfo and obj.processingInfo.tooltipData.id) then
         ST_prefix = "i" .. obj.processingInfo.tooltipData.id;

         local ST_kodKoloru;
         local ST_leftText, ST_rightText, ST_tlumaczenie, ST_hash, ST_hash2;
         local _font1, _size1, _1;
         local ST_odstep = true;
         local ST_orygText = {};
         local ST_nh = 0;   -- nowy Hash ?
         local numLines = obj:NumLines();
         
         -- sprawdź czy są ramki z ceną
         local moneyFrameLineNumber = {};
         local money = {};
         table.insert(moneyFrameLineNumber, 0);
         table.insert(money,0);
         if (obj.shownMoneyFrames) then        -- są ramki z ceną itemu
            for i = 1, obj.shownMoneyFrames, 1 do
               local moneyFrameName = obj:GetName().."MoneyFrame"..i;           -- nazwa obiektu
               _G[moneyFrameName.."PrefixText"]:SetText(QTR_ReverseIfAR(WoWTR_Localization.sellPrice));  -- SELL PRICE
               _font1, _size1, _1 = _G[moneyFrameName.."PrefixText"]:GetFont();  -- odczytaj aktualną czcionkę i rozmiar    
               _G[moneyFrameName.."PrefixText"]:SetFont(WOWTR_Font2, _size1);
               if (ST_PM["sellprice"] == "1") then    -- jest zezwolenie na ukrycie ceny skupu
                  _G[moneyFrameName]:Hide();
                  ST_odstep = false;
               end
            end
         end
         
         -- pierwsza linia z opisem założenia przedmiotu (Currently Equipped lub Equipped With)
         ST_leftText = _G[obj:GetName().."TextLeft1"]:GetText();
         if (ST_leftText) then 
            if (string.find(ST_leftText,NONBREAKINGSPACE)==nil) then                             -- nie jest to tekst przetłumaczony (twarda spacja na końcu)
               if (ST_leftText=="Currently Equipped") then
                  ST_info = WoWTR_Localization.currentlyEquipped;
               elseif(ST_leftText=="Equipped With") then
                  ST_info = WoWTR_Localization.additionalEquipped;
               else
                  ST_info = ST_leftText;     -- inny wariant tekstu?
               end
               if ((ST_info == ST_leftText) and (string.len(ST_leftText)>2) and (string.sub(ST_leftText,1,2)~="|T")) then  -- nic nie przetłumaczono
               --   ST_PI[ST_info]=leftText[1];        -- zapisz
               else
                  _font1, _size1, _1 = _G[obj:GetName().."TextLeft1"]:GetFont();    -- odczytaj aktualną czcionkę i rozmiar    
                  _G[obj:GetName().."TextLeft1"]:SetText(QTR_ReverseIfAR(ST_info)..NONBREAKINGSPACE);             -- dodajemy twardą spacje na końcu
                  _G[obj:GetName().."TextLeft1"]:SetFont(WOWTR_Font2, _size1);
               end
            end               
         end
   
         -- druga linia z tytułem przedmiotu
         ST_pomoc0, _ = string.find(_G[obj:GetName().."TextLeft2"]:GetText(),NONBREAKINGSPACE);   -- szukamy twardej spacji
         if (ST_TooltipID and (ST_pomoc0==nil) and (ST_TooltipsID[ST_prefix..tostring(ST_itemID)]) and (ST_PM["transtitle"]=="1")) then  -- jest tłumaczenie tytułu w bazie
            _G[obj:GetName().."TextLeft2"]:SetText(QTR_ExpandUnitInfo(ST_TooltipsID[ST_prefix..tostring(ST_itemID)]),WOWTR_Font2);
            _font1, _size1, _1 = _G[obj:GetName().."TextLeft2"]:GetFont();  -- odczytaj aktualną czcionkę i rozmiar    
            _G[obj:GetName().."TextLeft2"]:SetFont(WOWTR_Font2, _size1);
         end
   
         for i = 3, numLines, 1 do
            ST_leftText = _G[obj:GetName().."TextLeft"..i]:GetText();
            if (ST_leftText and (string.find(ST_leftText,NONBREAKINGSPACE)==nil)) then                 -- nie jest to nasze tłumaczenie
               leftColR, leftColG, leftColB = _G[obj:GetName().."TextLeft"..i]:GetTextColor();
               ST_kodKoloru = OkreslKodKoloru(leftColR, leftColG, leftColB);
               if (ST_leftText and (string.len(ST_leftText)>15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText)>30))) then
                  --print(ST_kodKoloru,i,ST_leftText);
                  -- Get the line object
                  local lineObj = _G[obj:GetName().."TextLeft"..i]
                  -- Get original font details *before* deciding translation
                  local originalFont, originalSize, originalFlags = lineObj:GetFont()
                  ST_hash = StringHash(ST_UsunZbedneZnaki(ST_leftText));
                  if (((ST_kodKoloru == "c7") or (string.len(ST_leftText)>30)) and (not ST_hash2)) then
                     ST_hash2 = ST_hash;
                  end
                  if (ST_TooltipsHS[ST_hash]) then        -- mamy przetłumaczony ten Hash
                     ST_tlumaczenie = ST_TooltipsHS[ST_hash];
                     ST_tlumaczenie = ST_TranslatePrepare(ST_leftText, ST_tlumaczenie);
                     _font1, _size1, _1 = _G[obj:GetName().."TextLeft"..i]:GetFont();    -- odczytaj aktualną czcionkę i rozmiar    
                     _G[obj:GetName().."TextLeft"..i]:SetFont(WOWTR_Font2, _size1);      -- ustawiamy czcionkę turecką
                     _G[obj:GetName().."TextLeft"..i]:SetText(QTR_ExpandUnitInfo(ST_tlumaczenie,false,_G["GameTooltipTextLeft"..i],WOWTR_Font2)..NONBREAKINGSPACE);      -- dodajemy twardą spacje na końcu
                  else
                        -- >>> Explicitly ensure original font if no translation <<<
                        if lineObj.SetFont then
                           lineObj:SetFont(originalFont, originalSize, originalFlags)
                        end
                        -- >>> End explicit ensure <<<
  
                       ST_nh = 1;              -- nowy Hash
                       table.insert(ST_orygText,ST_leftText);
                  end
               end
            end
         end
         
   
         if (((ST_PM["showID"]=="1") and (string.len(ST_prefix) > 1)) or ((ST_PM["showHS"]=="1") and ST_hash2)) then   -- czy dodawać ID i Hash ?
            numLines = obj:NumLines();           -- aktualna liczba linii
            if (numLines > 0 and ST_odstep) then
               obj:AddLine(" ",0,0,0);           -- dodaj odstęp przed linią z ID
            end
            local typName = " ";
            if (string.sub(ST_prefix,1,1) == "i") then
               typName = "Item";
               ST_ID = string.sub(ST_prefix,2);
            elseif (string.sub(ST_prefix,1,1) == "s") then
               typName = "Spell";
               ST_ID = string.sub(ST_prefix,2);
            elseif (string.sub(ST_prefix,1,1) == "t") then
               typName = "Talent";
               ST_ID = string.sub(ST_prefix,2);
            else
               ST_ID = nil;
            end
            if ((ST_PM["showID"]=="1") and ST_ID) then
               obj:AddLine(typName.." ID: "..tostring(ST_ID),0,1,1);
               numLines = obj:NumLines();                -- Aktualna liczba linii w obj
               _G[obj:GetName().."TextLeft"..numLines]:SetFont(WOWTR_Font2, 12);      -- wielkość 12
               _G[obj:GetName().."TextRight"..numLines]:SetFont(WOWTR_Font2, 12);     -- wielkość 12
            end
            if ((ST_PM["showHS"]=="1") and ST_hash2) then
               obj:AddLine("Hash: "..tostring(ST_hash2),0,1,1);
               numLines = obj:NumLines();                -- Aktualna liczba linii w obj
               _G[obj:GetName().."TextLeft"..numLines]:SetFont(WOWTR_Font2, 12);      -- wielkość 12
               _G[obj:GetName().."TextRight"..numLines]:SetFont(WOWTR_Font2, 12);     -- wielkość 12
            end
         end
         
         obj:Show();   -- wyświetla ramkę podpowiedzi (zrobi także resize)
         
         if ((ST_orygText or (ST_nh==1)) and (ST_PM["saveNW"]=="1")) then
            for _, ST_origin in ipairs(ST_orygText) do   
               ST_hash = StringHash(ST_UsunZbedneZnaki(ST_origin));
               if ((not ST_TooltipsHS[ST_hash]) and (string.find(ST_origin,NONBREAKINGSPACE)==nil)) then    -- i nie jest to tekst tłumaczenia (twarda spacja)
                  ST_PH[ST_hash]=ST_prefix.."@"..ST_PrzedZapisem(ST_origin);
               end
            end
         end
      end
         
   end   -- if ST_PM["active"]
   
end
    
-------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------

function ST_updateSpellBookFrame()
   if (TT_PS["ui1"] == "1") then --Game Option UI
      local ST_titleTextFontString = SpellBookFrame:GetTitleText();
      if (ST_titleTextFontString and ST_titleTextFontString:GetText()) then
         local str_ID = StringHash(ST_UsunZbedneZnaki(ST_titleTextFontString:GetText()));
         if (ST_TooltipsHS[str_ID]) then
            local text0 = QTR_ReverseIfAR(ST_titleTextFontString:GetText());
            ST_titleTextFontString:SetText(ST_SetText(text0));
         end
      end

      if (SpellBookFrameTabButton1 and SpellBookFrameTabButton1:GetText()) then
         local str_ID = StringHash(ST_UsunZbedneZnaki(SpellBookFrameTabButton1:GetText()));
         if (ST_TooltipsHS[str_ID]) then
            local text1 = QTR_ReverseIfAR(ST_SetText(SpellBookFrameTabButton1:GetText()));
            local fo = SpellBookFrameTabButton1:CreateFontString();
            fo:SetFont(WOWTR_Font2, 11);
            fo:SetText(text1);
            SpellBookFrameTabButton1:SetFontString(fo);
            SpellBookFrameTabButton1:SetText(text1);
         end
      end
      
      if (SpellBookFrameTabButton2 and SpellBookFrameTabButton2:GetText()) then
         local str_ID = StringHash(ST_UsunZbedneZnaki(SpellBookFrameTabButton2:GetText()));
         if (ST_TooltipsHS[str_ID]) then
            local text1 = QTR_ReverseIfAR(ST_SetText(SpellBookFrameTabButton2:GetText()));
            local fo = SpellBookFrameTabButton2:CreateFontString();
            fo:SetFont(WOWTR_Font2, 11);
            fo:SetText(text1);
            SpellBookFrameTabButton2:SetFontString(fo);
            SpellBookFrameTabButton2:SetText(text1);
         end
      end
      
      if (SpellBookFrameTabButton3 and SpellBookFrameTabButton3:GetText()) then
         local str_ID = StringHash(ST_UsunZbedneZnaki(SpellBookFrameTabButton3:GetText()));
         if (ST_TooltipsHS[str_ID]) then
            local text1 = QTR_ReverseIfAR(ST_SetText(SpellBookFrameTabButton3:GetText()));
            local fo = SpellBookFrameTabButton3:CreateFontString();
            fo:SetFont(WOWTR_Font2, 11);
            fo:SetText(text1);
            SpellBookFrameTabButton3:SetFontString(fo);
            SpellBookFrameTabButton3:SetText(text1);
         end
      end

      local SBPageText = SpellBookPageText;
      ST_CheckAndReplaceTranslationText(SBPageText, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------

function WOWSTR_onEvent(_, event, addonName)
   --print(addonName);
   --QTR_PS["Test"] = Frame; -- search data
      if (QTR_PS) then
         C_Timer.After(1, function() 
         QTR_ObjectiveTrackerFrame_Titles() -- Addon adds translations when it starts
         end)
      end
      if (addonName == 'Blizzard_PlayerSpells') then
         ST_Load1 = true;
         PlayerSpellsFrame:HookScript("OnShow", ST_SpellBookTranslateButton);
         PlayerSpellsFrame.SpecFrame:HookScript("OnShow", ST_updateSpecContentsHook);
         PlayerSpellsFrame.TalentsFrame:HookScript("OnShow", ST_TalentsTranslate);
         HeroTalentsSelectionDialog.SpecOptionsContainer:HookScript("OnShow", ST_updateHeroTalentHook);
         
      elseif (addonName == 'Blizzard_EncounterJournal') then
         ST_load2 = true;
         EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription:HookScript("OnShow", ST_clickBosses)
         EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription:HookScript("OnShow", function() StartTicker(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription, ST_ShowAbility, 0.1) end)
         EncounterJournal:HookScript("OnShow", function() StartTicker(EncounterJournal, ST_SuggestTabClick, 0) end)
         EncounterJournal:HookScript("OnShow", ST_AdventureGuidebutton)
         EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont:HookScript("OnShow", ST_showLoreDescription)
         
      -- elseif (addonName == 'Blizzard_Professions') then -- Removed block
         -- ST_load3 = true; -- Removed line
         -- ProfessionsFrame:HookScript("OnShow", function() StartTicker(ProfessionsFrame, ST_showProfessionDescription, 0) end) -- Removed line
         -- ProfessionsFrame:HookScript("OnShow", ST_ProfDescbutton) -- Removed line
         
      elseif (addonName == 'Blizzard_Collections') then
         ST_load4 = true;
         CollectionsJournalTitleText:HookScript("OnShow", function() StartTicker(CollectionsJournalTitleText, ST_MountJournal, 0.1) end)
         WardrobeCollectionFrame:HookScript("OnShow", function() StartTicker(WardrobeCollectionFrame, ST_HelpPlateTooltip, 0.2) end)
         MountJournalName:HookScript("OnShow", ST_MountJournalbutton)
        
      elseif (addonName == 'Blizzard_PVPUI') then
         ST_load5 = true;
         PVPQueueFrameCategoryButton1:HookScript("OnShow", function() StartTicker(PVPQueueFrameCategoryButton1, ST_GroupPVPFinder, 0.02) end)
        
      elseif (addonName == 'Blizzard_ChallengesUI') then
         ST_load6 = true;
         ChallengesFrame:HookScript("OnShow", function() StartTicker(ChallengesFrame, ST_GroupMplusFinder, 0) end)
         
      elseif (addonName == 'Blizzard_DelvesDifficultyPicker') then
         ST_load7 = true;
         DelvesDifficultyPickerFrame:HookScript("OnShow", function() StartTicker(DelvesDifficultyPickerFrame, ST_showDelveDifficultFrame, 0.2) end)
         
      elseif (addonName == 'Blizzard_ItemUpgradeUI') then
         ST_load8 = true;
         ItemUpgradeFrame:HookScript("OnShow", function() StartTicker(ItemUpgradeFrame, ST_ItemUpgradeFrm, 0.2) end)
         
      elseif (addonName == 'Blizzard_WeeklyRewards') then
         ST_load9 = true;
         WeeklyRewardsFrame:HookScript("OnShow", function() StartTicker(WeeklyRewardsFrame, ST_WeeklyRewardsFrame, 0.2) end) 
         
      elseif (addonName == 'Blizzard_AdventureMap') then
         ST_load10 = true;
         AdventureMapQuestChoiceDialog.Details.Child.DescriptionText:HookScript("OnShow", function() StartTicker(AdventureMapQuestChoiceDialog.Details.Child.DescriptionText, ST_AdvantureMapFrm, 0.2) end) 
   
      -- elseif (addonName == 'Blizzard_ProfessionsBook') then -- Removed block
         -- ST_load11 = true; -- Removed line
         -- ProfessionsBookFrame:HookScript("OnShow", function() StartTicker(ProfessionsBookFrame, ST_ProfessionEmptyText, 0.02) end) -- Removed line
      end

      -- Updated condition to remove ST_load3 and ST_load11
      if (ST_load1 and ST_load2 and ST_load4 and ST_load5 and ST_load6 and ST_load7 and ST_load8 and ST_load9 and ST_load10) then    -- otworzono wszystkie inne dodatki Blizzarda
         WOWSTR:UnregisterEvent("ADDON_LOADED");      -- wyłącz nasłuchiwanie
      end
   end


-------------------------------------------------------------------------------------------------------

function ST_SpellBookTranslateButton()
   if (ST_PM["active"] == "1") then
      -- Button to toggle between TR - EN for talents
      WOWTR_ToggleButtonS = CreateFrame("Button", nil, SpellBookFrame, "UIPanelButtonTemplate")
      WOWTR_ToggleButtonS:SetWidth(80)
      WOWTR_ToggleButtonS:SetHeight(13) -- Set the height to 15
      WOWTR_ToggleButtonS:SetFrameStrata("TOOLTIP")

      if (ST_PM["spell"] == "1") then
            if (WoWTR_Localization.lang == 'AR') then
               WOWTR_ToggleButtonS:SetText(QTR_ReverseIfAR(WoWTR_Localization.WoWTR_Spellbook_trDESC))
               WOWTR_ToggleButtonS:GetFontString():SetFont(WOWTR_Font2, 7)
            else
               WOWTR_ToggleButtonS:SetText(WoWTR_Localization.WoWTR_Spellbook_trDESC)
               WOWTR_ToggleButtonS:GetFontString():SetFont(WOWTR_ToggleButtonS:GetFontString():GetFont(), 7)
            end
      else
            WOWTR_ToggleButtonS:SetText(WoWTR_Localization.WoWTR_Spellbook_enDESC)
            WOWTR_ToggleButtonS:GetFontString():SetFont(WOWTR_ToggleButtonS:GetFontString():GetFont(), 7)
      end

      WOWTR_ToggleButtonS:ClearAllPoints()
      WOWTR_ToggleButtonS:SetPoint("TOPLEFT", PlayerSpellsFrame, "TOPRIGHT", -110, 0)
      WOWTR_ToggleButtonS:SetScript("OnClick", STspell_ON_OFF)
      PlayerSpellsFrame:HookScript("OnHide", function() WOWTR_ToggleButtonS:Hide() end)
   end
end
     
-------------------------------------------------------------------------------------------------------
   
function ST_SuggestTabClick()
--print("SuggestTab clicked");
   if (TT_PS["ui5"] == "1") then
      local obj0 = EncounterJournalInstanceSelect.Title;
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj0, true, "Dungeon&Raid:Suggest:SuggestTittle",WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj0, true, "Dungeon&Raid:Suggest:SuggestTittle",false);
      end
      
      local obj1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.description.text;
      local title1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.title.text:GetText() or "?";
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj1, true, "Dungeon&Raid:Suggest:"..title1,WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj1, true, "Dungeon&Raid:Suggest:"..title1,false);
      end
      
      local obj2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.description.text;
      local title2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.title.text:GetText() or "?";
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj2, true, "Dungeon&Raid:Suggest:"..title2,WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj2, true, "Dungeon&Raid:Suggest:"..title2,false);
      end

      local obj3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.description.text;
      local title3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.title.text:GetText() or "?";
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj3, true, "Dungeon&Raid:Suggest:"..title3,WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj3, true, "Dungeon&Raid:Suggest:"..title3,false);
      end

      local obj4 = EncounterJournalMonthlyActivitiesFrame.BarComplete.AllRewardsCollectedText; -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj4, true, "ui",WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj4, true, "ui",false);
      end

      local obj5 = EncounterJournalTitleText;                            -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj5, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj5, true, "ui",false);
      end

      local obj6 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Month;         -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj6, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj6, true, "ui",false);
      end

      local obj7 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Title;         -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj7, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj7, true, "ui",false);
      end

      local obj8 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.TimeLeft;      -- https://imgur.com/KE3uW72
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj8, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj8, true, "ui",false);
      end

      local obj9 = EncounterJournalSuggestFrame.Suggestion1.button.Text;             -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj9, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj9, true, "ui",false);
      end

      local obj10 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.button.Text; -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj10, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj10, true, "ui",false);
      end

      local obj11 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.button.Text; -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj11, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj11, true, "ui",false);
      end

      local obj12 = EncounterJournalSuggestFrame.Suggestion1.reward.text;               -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj12, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj12, true, "ui",false);
      end
     
      local obj13 = EncounterJournalMonthlyActivitiesFrame.BarComplete.PendingRewardsText;               -- https://imgur.com/kkPedLC
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj13, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj13, true, "ui",false);
      end

      local obj14 = EncounterJournalMonthlyActivitiesTab.Text;  -- Tab: Traveler's Log
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj14, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj14, true, "ui", false);
      end

      local obj15 = EncounterJournalSuggestTab.Text;            -- Tab: Suggested Content
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj15, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj15, true, "ui", false);
      end

      local obj16 = EncounterJournalDungeonTab.Text;            -- Tab: Dungeons
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj16, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj16, true, "ui", false);
      end

      local obj17 = EncounterJournalRaidTab.Text;               -- Tab: Raids
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj17, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj17, true, "ui", false);
      end

      local obj18 = EncounterJournalLootJournalTab.Text;        -- Tab: Item Sets
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationTextUI(obj18, true, "ui", WOWTR_Font1);
      else
         ST_CheckAndReplaceTranslationTextUI(obj18, true, "ui", false);
      end
   end
end

-------------------------------------------------------------------------------------------------------

function ST_showLoreDescription()
--print("show LoreDescription");
 if (TT_PS["ui5"] == "1") then
   local ST_Dungeon_Raid_zone = EncounterJournalEncounterFrameInstanceFrame.title:GetText() or "?";
   local ST_loreDescription = EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox.FontStringContainer.FontString;
   if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(ST_loreDescription, true, "Dungeon&Raid:Zone:"..ST_Dungeon_Raid_zone, false, false, -5, "RIGHT");
   else
      ST_CheckAndReplaceTranslationText(ST_loreDescription, true, "Dungeon&Raid:Zone:"..ST_Dungeon_Raid_zone);
   end
   local ST_loreShowmap = EncounterJournalEncounterFrameInstanceFrameMapButtonText;
   if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(ST_loreShowmap, true, "ui");
   else
      ST_CheckAndReplaceTranslationText(ST_loreShowmap, true, "ui");
   end
 end
end

-------------------------------------------------------------------------------------------------------
-- PROFESSION FRAME - Function to work in harmony with the CraftSim plugin.
-- Removed CheckAndHookProfessionsFrame and StartProfessionsFrameCheck functions
-- as they are now fully managed within UI/Professions.lua
-------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------

--DelveDifficultFrame, TEXT and OTHER TRANSLATE
function ST_showDelveDifficultFrame() 
--print("show DelveDifficultFrame");
   -- if (TT_PS["ui7"] == "1") then
      local DelveDF01 = DelvesDifficultyPickerFrame.Description; -- https://imgur.com/a/SAyXuiR
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationText(DelveDF01, true, "Dungeon&Raid:Zone:DelvesFrame",false,false);       -- save untranslated text
      else
         ST_CheckAndReplaceTranslationTextUI(DelveDF01, true, "Dungeon&Raid:Zone:DelvesFrame");       -- save untranslated text
      end
      
      local DelveDF02 = DelvesDifficultyPickerFrame.EnterDelveButton.Text; -- https://imgur.com/a/SAyXuiR
      ST_CheckAndReplaceTranslationTextUI(DelveDF02, false, "ui");       -- dont save untranslated text

      local DelveDF03 = DelvesDifficultyPickerFrame.DelveRewardsContainerFrame.RewardText; -- https://imgur.com/a/SAyXuiR
      ST_CheckAndReplaceTranslationTextUI(DelveDF03, false, "ui");       -- dont save untranslated text

      local DelveDF04 = DelvesDifficultyPickerFrame.ScenarioLabel; -- https://imgur.com/a/SAyXuiR
      ST_CheckAndReplaceTranslationTextUI(DelveDF04, false, "ui");       -- dont save untranslated text

      local DelveDF05 = DelvesDifficultyPickerFrame.Title; -- https://imgur.com/a/SAyXuiR
      ST_CheckAndReplaceTranslationTextUI(DelveDF05, true, "Dungeon&Raid:Zone:DelvesFrame");       -- dont save untranslated text
   -- end
end

-------------------------------------------------------------------------------------------------------

function ST_UpdateJournalEncounterBossInfo(ST_bossName)
   -- Exit early if no boss name or translation for this section is disabled
   if not ST_bossName or TT_PS["ui5"] ~= "1" then return end

   -- Simplified helper function: Calls ST_CheckAndReplaceTranslationText with appropriate params
   -- Relies on ST_CheckAndReplaceTranslationText to handle font and justification.
   local function updateElement(element, prefix, ST_corr, justifyAlign)
       -- Ensure element exists and has GetText method before proceeding
       if not element or not element.GetText then return end
       
       -- Pass parameters directly to the main translation function
       -- 'true' for saving, WOWTR_Font2 as default font (can be overridden by font1 if needed), 'false' for onlyReverse
       ST_CheckAndReplaceTranslationText(element, true, prefix .. ST_bossName, WOWTR_Font2, false, ST_corr, justifyAlign)
   end

   -- Define elements and their specific parameters, including conditional justification
   local elementsToUpdate = {
       -- Apply RIGHT align only if language is AR, otherwise pass nil (use default)
       {EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription, "Dungeon&Raid:Boss:", -5, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil},
       -- Handling the overview description separately below using tempObj
       -- {EncounterJournalEncounterFrameInfo.overviewScroll.child.overviewDescription, "Dungeon&Raid:Boss:", nil, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil},
       {EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription, "Dungeon&Raid:Boss:", nil, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil},
       {EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildTitle, "ui", nil, nil} -- Titles usually default to LEFT
   }

   -- Process the standard elements defined above
   for _, elementData in ipairs(elementsToUpdate) do
       -- Unpack all four values and pass them to updateElement
       updateElement(elementData[1], elementData[2], elementData[3], elementData[4])
   end

   -- Special handling for the main overview description (often a SimpleHTML object)
   local overviewDesc = EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChild.overviewDescription
   if overviewDesc then
      local descText = overviewDesc.Text -- The actual FontString or SimpleHTML object holding the text display
      local originalText = overviewDesc.textString -- SimpleHTML often stores the original string here

      if originalText and descText then
         ST_SaveOriginalText(ST_bossName, originalText) -- Save original if needed

         -- Create a temporary object wrapper conforming to ST_CheckAndReplaceTranslationText's expected interface
         local tempObj = {
             GetText = function() return originalText end,
             -- SetText in the wrapper now ONLY sets the text and updates font visuals
             SetText = function(self, text)
                 descText:SetText(text)
                 ST_UpdateBossDescriptionFont(descText) -- Update font styles if necessary for SimpleHTML
                 -- NO justification logic here anymore - handled by ST_CheckAndReplaceTranslationText
             end,
             -- Provide GetFont and GetWidth for ST_CheckAndReplaceTranslationText
             GetFont = function()
                 -- *** FIX: Call GetFont with "p" for SimpleHTML ***
                 -- Get font details specifically for the paragraph tag ("p")
                 -- as a reasonable default base size for SimpleHTML objects.
                 -- Returns fontFile, height, flags for the "p" tag.
                 return descText:GetFont("p")
             end,
             SetFont = function(self, font, size, flags)
                 -- This might be less effective for SimpleHTML than SetFontObject,
                 -- but ST_UpdateBossDescriptionFont likely handles detailed styling.
                 -- We keep it for interface compatibility with ST_CheckAndReplaceTranslationText.
                 -- Note: SimpleHTML SetFont might need a textType argument too,
                 -- but ST_CheckAndReplaceTranslationText calls it without one.
                 -- We rely on ST_UpdateBossDescriptionFont for the main styling.
                 pcall(function() descText:SetFont("p", font, size, flags) end)
             end,
             GetWidth = function() return descText:GetWidth() end,
             SetJustifyH = function(self, align) -- Needed for ST_CheckAndReplaceTranslationText to call
                 -- Handle justification for SimpleHTML potentially needing per-tag alignment
                 local textTypes = {"p", "h1", "h2", "h3"}
                 for _, textType in ipairs(textTypes) do
                     pcall(function() descText:SetJustifyH(textType, align) end)
                 end
             end
             -- GetRegions = function() return descText:GetRegions() end -- Might not be needed by the main function
         }

         -- Call the main function with the tempObj and conditional justification
         ST_CheckAndReplaceTranslationText(tempObj, true, "Dungeon&Raid:Boss:" .. ST_bossName, WOWTR_Font2, false, -120, (WoWTR_Localization.lang == 'AR') and "RIGHT" or nil)
      end
   end

   -- Update the root button text based on language (existing logic)
   local rootButton = EncounterJournalEncounterFrameInfoRootButton
   if rootButton then
       rootButton:SetText(WoWTR_Localization.lang == 'AR' and ">" or "<")
   end

   -- Update header tab text (existing logic)
   ST_BossHeaderTabText()
end

function ST_SaveOriginalText(bossName, text)
    if not ST_OriginalTexts then
        ST_OriginalTexts = {}
    end
    ST_OriginalTexts[bossName] = text
    -- Here you can save the text permanently, for example, to a file or database
end

function ST_BossHeaderTabText()
    local tabs = {
        EncounterJournalEncounterFrameInfoOverviewTab,
        EncounterJournalEncounterFrameInfoLootTab,
        EncounterJournalEncounterFrameInfoBossTab,
        EncounterJournalEncounterFrameInfoModelTab
    }

    for _, tab in ipairs(tabs) do
        ST_CheckAndReplaceTranslationText(tab, false, "ui", WOWTR_Font2, false, 0)
    end
end

function ST_UpdateBossDescriptionFont(descText)
   if not descText then return end
   
   local textTypes = {"p", "h1", "h2", "h3"}
   for _, textType in ipairs(textTypes) do
       local alignment = (WoWTR_Localization.lang == 'AR') and "RIGHT" or "LEFT"
       if descText.SetJustifyH then
           descText:SetJustifyH(textType, alignment)
       end
       if descText.SetFont then
           descText:SetFont(textType, WOWTR_Font2, 12, "")
       end
       if descText.SetFontObject then
           local fontName = "WOWTRBossDescFont_" .. textType
           local fontObj = CreateFont(fontName)
           fontObj:SetFont(WOWTR_Font2, 12, "")
           fontObj:SetJustifyH(alignment)
           descText:SetFontObject(textType, fontObj)
       end
   end
end

function ST_UpdateBossDescriptionFont(textObject)
    if not textObject then return end
    
    -- Create a custom font object
    local fontName = "WOWTRBossDescFont"
    local font = CreateFont(fontName)
    font:SetFont(WOWTR_Font2, 12, "")
    
    -- Set the font for each text type of the SimpleHTML object
    local textTypes = {"p", "h1", "h2", "h3"}
    for _, textType in ipairs(textTypes) do
        if textObject.SetFont then
            textObject:SetFont(textType, WOWTR_Font2, 12, "")
        end
        if textObject.SetFontObject then
            textObject:SetFontObject(textType, font)
        end
    end
end

function ST_clickBosses()
   local previousText = ""
   local function OnUpdateHandler()
       local currentText = EncounterJournalEncounterFrameInfoEncounterTitle:GetText()
       if currentText and currentText ~= previousText then
           -- Get the boss name from the navigation bar
           local ST_bossName = EncounterJournalNavBarButton3Text:GetText()
           -- Update boss info
           ST_UpdateJournalEncounterBossInfo(ST_bossName)
           -- Update previousText
           previousText = currentText

           -- Add " " at the end of the text (only once)
           if not string.find(currentText, " $") then
               local modifiedText = currentText .. " "
               EncounterJournalEncounterFrameInfoEncounterTitle:SetText(modifiedText)
           end
       end
   end

   local frame = CreateFrame("Frame")
   frame:SetScript("OnUpdate", OnUpdateHandler)
end


local isEJournalButtonCreated = false
local EncounterJournalupdateVisibility
function ST_AdventureGuidebutton()
    if not isEJournalButtonCreated then
        TT_PS = TT_PS or { ui5 = "1" }

      EncounterJournalupdateVisibility = CreateToggleButton(
         EncounterJournal,
         TT_PS,
         "ui5",
         WoWTR_Localization.WoWTR_enDESC,
         WoWTR_Localization.WoWTR_trDESC,
         {"TOPLEFT", EncounterJournal, "TOPRIGHT", -170, 0},
         function()
            ST_clickBosses()
            if EncounterJournal then
               EncounterJournal:Hide()
               EncounterJournal:Show()
               -- Butonun temizlenmesi için burada gerekli işlemleri yapabilirsiniz
            end
         end
        )

        isEJournalButtonCreated = true -- Butonlar ilk kez oluşturulunca işaretleyin
    end

    if EncounterJournalupdateVisibility then
       EncounterJournalupdateVisibility()
    end
end
-------------------------------------------------------------------------------------------------------

function ST_ShowAbility()            -- sprawdzanie tekstów Ability
  if (TT_PS["ui5"] == "1") then
   for i = 1, 99, 1 do
      if (_G["EncounterJournalInfoHeader"..i.."Description"]) then
         local obj = _G["EncounterJournalInfoHeader"..i.."Description"];
         local obj1= _G["EncounterJournalInfoHeader"..i];
         local obj2= _G["EncounterJournalInfoHeader"..i.."DescriptionBG"];
         local txt = obj:GetText();

         ST_CheckAndReplaceTranslationText(obj, true, "Dungeon&Raid:Ability:".._G["EncounterJournalInfoHeader"..i.."HeaderButton"].title:GetText());
         local ST_bossDescription2 = EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription;
         ST_CheckAndReplaceTranslationText(ST_bossDescription2, false);
      end
   end
  end
end

-------------------------------------------------------------------------------------------------------

function ST_BossHeaderTabText()
   if (TT_PS["ui5"] == "1") then
    local ST_bossName = EncounterJournalNavBarButton3Text:GetText()

    local headers = {
        EncounterJournalOverviewInfoHeader1,
        EncounterJournalOverviewInfoHeader2,
        EncounterJournalOverviewInfoHeader3
    }

    for index, header in ipairs(headers) do
        if header then
            local bulletsTable = header.Bullets

            if bulletsTable then
                for _, bulletData in ipairs(bulletsTable) do
                    if bulletData.Text and bulletData.Text.GetTextData then
                        local textData = bulletData.Text:GetTextData()
                        if textData then
                            for text_index, textInfo in ipairs(textData) do
                                if textInfo.text then
                                    local metin = textInfo.text
                                    
                                    -- Create a temporary object to handle text replacement
                                    local tempObj = {
                                        GetText = function() return metin end,
                                        SetText = function(self, text)
                                            bulletData.Text:SetText(text)
                                            -- Update font/style if needed
                                            ST_UpdateBossDescriptionFont(bulletData.Text)
                                        end
                                    }
                                    
                                    local prefix = "Dungeon&Raid:Boss:" .. ST_bossName
                                    ST_CheckAndReplaceTranslationText(tempObj, true, prefix, nil, false, nil)
                                end
                            end
                        end
                    end
                end
            else
                -- Uncomment for debugging: print("Bullets table not found for Header " .. index)
            end
        else
            -- Uncomment for debugging: print("Header " .. index .. " not found.")
        end
    end
      local HeaderTitle1 = EncounterJournalOverviewInfoHeader1HeaderButtonTitle;
      ST_CheckAndReplaceTranslationText(HeaderTitle1, true, "ui");
      local HeaderTitle2 = EncounterJournalOverviewInfoHeader2HeaderButtonTitle;
      ST_CheckAndReplaceTranslationText(HeaderTitle2, true, "ui");
      local HeaderTitle3 = EncounterJournalOverviewInfoHeader3HeaderButtonTitle;
      ST_CheckAndReplaceTranslationText(HeaderTitle3, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------

--StaticPopup1 and StaticPopup1 WINDOW
function ST_StaticPopup1()
--print(StaticPopup1Text:GetText());
   if (TT_PS["ui1"] == "1") then
      local SPobj01 = StaticPopup1Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj01, true, "h@popuptext-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj02 = StaticPopup1Button1Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj02, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj03 = StaticPopup1Button2Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj03, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj04 = StaticPopup1Button3Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj04, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj05 = StaticPopup1Button4Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj05, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.
      
      local SPobj06 = StaticPopup2Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj06, true, "h@popuptext-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj07 = StaticPopup2Button1Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj07, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj08 = StaticPopup2Button2Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj08, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj09 = StaticPopup2Button3Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj09, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.

      local SPobj10 = StaticPopup2Button4Text;
      ST_CheckAndReplaceTranslationTextUI(SPobj10, true, "h@popupbutton-ui"); -- Dodano znacznik "h" do kontroli danych od użytkowników.
   end
end

-------------------------------------------------------------------------------------------------------

--WORLD MAP TITLE
function ST_WorldMapFunc()
--print("ST_WorldMapFunc");
   local wmframe01 = WorldMapFrameTitleText;
   ST_CheckAndReplaceTranslationText(wmframe01, true, "ui", false, 1);

   local wmframe02 = WorldMapFrameHomeButtonText;
   ST_CheckAndReplaceTranslationText(wmframe02, true, "ui");
end

-------------------------------------------------------------------------------------------------------

--Group Finder Frames
function ST_GroupFinder()
--print("ST_GroupFinder");
-- Dungeons & Raids
   if (TT_PS["ui3"] == "1") then
      local GFobj01 = PVEFrameTitleText;
      ST_CheckAndReplaceTranslationTextUI(GFobj01, true, "ui");

      local GFobj02 = PVEFrameTab1.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj02, true, "ui");

      local GFobj03 = PVEFrameTab2.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj03, true, "ui");

      local GFobj04 = PVEFrameTab3.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj04, true, "ui");

      local GFobj05 = GroupFinderFrameGroupButton1Name;
      ST_CheckAndReplaceTranslationText(GFobj05, true, "ui",false,true);

      local GFobj06 = GroupFinderFrameGroupButton2Name;
      ST_CheckAndReplaceTranslationTextUI(GFobj06, true, "ui");

      local GFobj07 = GroupFinderFrameGroupButton3Name;
      ST_CheckAndReplaceTranslationText(GFobj07, true, "ui",false,true);

      local GFobj08 = LFDQueueFrameTypeDropDownName;
      ST_CheckAndReplaceTranslationTextUI(GFobj08, true, "ui");

      local GFobj09 = LFDQueueFrameRandomScrollFrameChildFrameTitle;
      ST_CheckAndReplaceTranslationTextUI(GFobj09, true, "ui", WOWTR_Font1);

      local GFobj10 = LFDQueueFrameRandomScrollFrameChildFrameDescription;
      ST_CheckAndReplaceTranslationText(GFobj10, true, "ui",false,false);

      local GFobj11 = LFDQueueFrameRandomScrollFrameChildFrameRewardsLabel;
      ST_CheckAndReplaceTranslationTextUI(GFobj11, true, "ui", WOWTR_Font1);

      local GFobj12 = LFDQueueFrameRandomScrollFrameChildFrameRewardsDescription;
      ST_CheckAndReplaceTranslationText(GFobj12, true, "ui",false,false,-10);

      local GFobj13 = LFDQueueFrameFindGroupButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj13, true, "ui");

      local GFobj14 = RaidFinderQueueFrameScrollFrameChildFrameDescription;
      ST_CheckAndReplaceTranslationTextUI(GFobj14, true, "ui");

      local GFobj15 = RaidFinderQueueFrameScrollFrameChildFrameRewardsLabel;
      ST_CheckAndReplaceTranslationTextUI(GFobj15, true, "ui", WOWTR_Font1);

      local GFobj16 = RaidFinderQueueFrameScrollFrameChildFrameRewardsDescription;
      ST_CheckAndReplaceTranslationTextUI(GFobj16, true, "ui");

      local GFobj17 = RaidFinderFrameFindRaidButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj17, true, "ui");

      local GFobj18 = LFGListFrame.CategorySelection.StartGroupButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj18, true, "ui");

      local GFobj19 = LFGListFrame.CategorySelection.FindGroupButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj19, true, "ui");

      local GFobj20 = LFGListFrame.CategorySelection.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj20, true, "ui", WOWTR_Font1);

      local GFobj21 = LFGListApplicationDialog.Label; -- Choose your Roles
      ST_CheckAndReplaceTranslationTextUI(GFobj21, true, "ui");

      local GFobj22 = LFGListApplicationDialog.SignUpButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj22, true, "ui");

      local GFobj23 = LFGListApplicationDialog.CancelButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj23, true, "ui");

      local GFobj24 = LFGListFrame.SearchPanel.SignUpButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj24, true, "ui");

      local GFobj25 = LFGListFrame.SearchPanel.BackButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj25, true, "ui");

      local GFobj26 = LFGListFrame.SearchPanel.CategoryName;
      ST_CheckAndReplaceTranslationTextUI(GFobj26, true, "ui");

      local GFobj27 = LFGListFrame.EntryCreation.NameLabel;
      ST_CheckAndReplaceTranslationTextUI(GFobj27, true, "ui");

      local GFobj28 = LFGListFrame.EntryCreation.DescriptionLabel;
      ST_CheckAndReplaceTranslationTextUI(GFobj28, true, "ui");

      local GFobj29 = LFGListFrame.EntryCreation.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj29, true, "ui", WOWTR_Font1);

      local GFobj30 = LFGListInviteDialog.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj30, true, "ui");

      local GFobj31 = LFGListInviteDialog.RoleDescription;
      ST_CheckAndReplaceTranslationTextUI(GFobj31, true, "ui");

      local GFobj32 = LFGListInviteDialog.AcceptButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj32, true, "ui");

      local GFobj33 = LFGListInviteDialog.DeclineButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj33, true, "ui");

      local GFobj34 = LFGListInviteDialog.AcknowledgeButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj34, true, "ui");

      local GFobj35 = LFDQueueFrameFollowerTitle;
      ST_CheckAndReplaceTranslationTextUI(GFobj35, true, "ui", WOWTR_Font1);

      local GFobj36 = LFDQueueFrameFollowerDescription;
      ST_CheckAndReplaceTranslationTextUI(GFobj36, true, "ui");

      local GFobj37 = LFGListFrame.EntryCreation.ListGroupButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj37, true, "ui");

      local GFobj38 = LFGListFrame.SearchPanel.ScrollBox.StartGroupButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj38, true, "ui");

      local GFobj39 = LFGListFrame.SearchPanel.SearchBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(GFobj39, true, "ui");

      local GFobj40 = LFGListFrame.SearchPanel.ScrollBox.NoResultsFound;
      ST_CheckAndReplaceTranslationTextUI(GFobj40, true, "ui");

      local GFobj41 = LFGListFrame.EntryCreation.PlayStyleLabel;
      ST_CheckAndReplaceTranslationTextUI(GFobj41, true, "ui");

      local GFobj42 = LFGListCreationDescription.EditBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(GFobj42, true, "ui");

      local GFobj43 = LFGListFrame.EntryCreation.MythicPlusRating.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj43, true, "ui");

      local GFobj44 = LFGListFrame.EntryCreation.ItemLevel.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj44, true, "ui");

      local GFobj45 = LFGListFrame.EntryCreation.VoiceChat.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj45, true, "ui");

      local GFobj46 = LFGListFrame.EntryCreation.PrivateGroup.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj46, true, "ui");

      local GFobj47 = LFGListFrame.EntryCreation.CrossFactionGroup.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj47, true, "ui");

      local GFobj48 = LFGListFrame.EntryCreation.Name.Instructions;
      ST_CheckAndReplaceTranslationTextUI(GFobj48, true, "ui");

      local GFobj49 = LFGListFrame.EntryCreation.ItemLevel.EditBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(GFobj49, true, "ui");

      local GFobj50 = LFGListFrame.EntryCreation.VoiceChat.EditBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(GFobj50, true, "ui");

      local GFobj51 = LFGListFrame.EntryCreation.CancelButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj51, true, "ui");

      local GFobj52 = LFGListApplicationDialogDescription.EditBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(GFobj52, true, "ui");

      local GFobj53 = LFGListFrame.ApplicationViewer.ScrollBox.NoApplicants;
      ST_CheckAndReplaceTranslationTextUI(GFobj53, true, "ui");

      local GFobj54 = LFGListFrame.ApplicationViewer.BrowseGroupsButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj54, true, "ui");

      local GFobj55 = LFGListFrame.ApplicationViewer.RemoveEntryButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj55, true, "ui");

      local GFobj56 = LFGListFrame.ApplicationViewer.EditButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj56, true, "ui");

      local GFobj57 = LFGListFrame.SearchPanel.BackToGroupButton.Text;
      ST_CheckAndReplaceTranslationTextUI(GFobj57, true, "ui");

      local GFobj58 = LFGListFrame.ApplicationViewer.NameColumnHeader.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj58, true, "ui");

      local GFobj59 = LFGListFrame.ApplicationViewer.RoleColumnHeader.Label;
      ST_CheckAndReplaceTranslationTextUI(GFobj59, true, "ui");


      -- Utility function for applying translations to UI elements with custom font
      local function ApplyTranslationToElement(element, alignment)
         -- Check if the element is valid and has the necessary text methods
         if element and element.GetText and element.SetText then
               local originalText = element:GetText()  -- Get the current text
      
               if originalText then
                  -- --- START: Debug code to print font information ---
                  if element.GetFont then -- Check if the element supports getting font info
                     local fontFile, fontHeight, fontFlags = element:GetFont()
                     local elementName = element:GetName() -- Try to get the element's name for context
                     local parentName = element:GetParent() and element:GetParent():GetName() -- Get parent name too
      
                     --print("--- ApplyTranslationToElement Debug ---")
                     if elementName then
                           --print("Element Name:", elementName)
                     end
                     if parentName then
                           --print("Parent Name:", parentName)
                     end
                     -- If no name, maybe show the first few chars of text for context
                     if not elementName then
                           --print("Element (no name): Text starts with ->", string.sub(originalText, 1, 30))
                     end
                     --print("Original Font File:", fontFile or "N/A")
                     --print("Original Font Size:", fontHeight or "N/A")
                     -- print("Original Font Flags:", fontFlags or "N/A") -- Optional: Uncomment if you need flags
                     --print("---------------------------------------")
                  else
                        -- Optionally print if GetFont isn't supported
                        local elementName = element:GetName()
                        --print("ApplyTranslationToElement:", elementName or "Unnamed Element", "does not support GetFont()")
                  end
                  -- --- END: Debug code ---
      
                  local hash = StringHash(ST_UsunZbedneZnaki(originalText))  -- Calculate the hash
      
                  -- If a translation exists, update the text and font
                  if ST_TooltipsHS[hash] then
                     local translatedText = QTR_ReverseIfAR(ST_TooltipsHS[hash])
                     element:SetText(translatedText)  -- Set the translated text
      
                     if element.SetFont then
                           -- Use select(2,...) which is safer if GetFont returns nil
                           if WoWTR_Localization.lang == 'AR' then 
                              element:SetFont(WOWTR_Font1, select(2, element:GetFont()))
                           else
                              element:SetFont(WOWTR_Font2, select(2, element:GetFont()))
                           end
                     end
                  -- else -- No translation found
                     -- Ensure original font remains if needed (usually not necessary unless something else modified it)
                     -- if element.SetFont and fontFile and fontHeight then
                     --    element:SetFont(fontFile, fontHeight, fontFlags)
                     -- end
                  end
      
                  -- Adjust text alignment if specified
                  if alignment and element.SetJustifyH then
                     element:SetJustifyH(alignment)
                  end
               end
         end
      end

      -- Iterate through the category buttons and apply translations
      local categoryButtons = {
         LFGListFrame.CategorySelection.CategoryButtons[1],
         LFGListFrame.CategorySelection.CategoryButtons[2],
         LFGListFrame.CategorySelection.CategoryButtons[3],
         LFGListFrame.CategorySelection.CategoryButtons[4],
         LFGListFrame.CategorySelection.CategoryButtons[5],
         LFGListFrame.CategorySelection.CategoryButtons[6]
      }

      for _, button in ipairs(categoryButtons) do
         -- MODIFICATION: Check for the .Label child and pass THAT to the function
         if button and button.Label then
             -- Pass the actual Label element which holds the text and font info
             ApplyTranslationToElement(button.Label)
         elseif button then
             -- Fallback: If no Label child, try applying to the button itself (might not work for font)
             --print("Warning: Button", button:GetName(), "does not have a .Label child. Applying to button itself.")
             ApplyTranslationToElement(button)
         end
     end
   end
end

-------------------------------------------------------------------------------------------------------

function ST_GroupPVPFinder()
--print("ST_GroupPVPFinder");
-- Player vs. Player
   if (TT_PS["ui3"] == "1") then
      local gfpvpobj01 = PVPQueueFrameCategoryButton1.Name;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj01, true, "ui");

      local gfpvpobj02 = PVPQueueFrameCategoryButton2.Name;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj02, true, "ui");

      local gfpvpobj03 = PVPQueueFrameCategoryButton3.Name;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj03, true, "ui");

      local gfpvpobj04 = PVPQueueFrame.NewSeasonPopup.NewSeason;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj04, true, "ui");

      local gfpvpobj05 = PVPQueueFrame.NewSeasonPopup.SeasonDescriptionHeader;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj05, true, "ui");

      local gfpvpobj06 = PVPQueueFrame.NewSeasonPopup.SeasonDescription;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj06, true, "ui");

      local gfpvpobj07 = PVPQueueFrame.NewSeasonPopup.SeasonRewardText;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj07, true, "ui");

      local gfpvpobj08 = PVPQueueFrame.NewSeasonPopup.Leave.Text;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj08, true, "ui");

      local gfpvpobj09 = PVPQueueFrame.HonorInset.CasualPanel.HKLabel;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj09, true, "ui");

      local gfpvpobj10 = PVPQueueFrame.HonorInset.CasualPanel.HonorLevelDisplay.LevelLabel;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj10, true, "ui");

      local gfpvpobj11 = HonorFrameQueueButton.Text;
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj11, true, "ui");

      local gfpvpobj12 = PVPQueueFrame.HonorInset.RatedPanel.Label; -- Great Vault
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj12, true, "ui");

      local gfpvpobj13 = PVPQueueFrame.HonorInset.RatedPanel.Tier.Title; -- Season High
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj13, true, "ui");

      local gfpvpobj14 = ConquestJoinButtonText; -- Join Battle
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj14, true, "ui");

      local gfpvpobj15 = LFGListFrame.CategorySelection.Label; -- Premade Groups
      ST_CheckAndReplaceTranslationTextUI(gfpvpobj15, true, "ui");
   end

end

-------------------------------------------------------------------------------------------------------

function ST_GroupMplusFinder()
   if TT_PS["ui3"] == "1" then
     local elements = {
       {ChallengesFrame.SeasonChangeNoticeFrame.NewSeason, "ui"},
       {ChallengesFrame.SeasonChangeNoticeFrame.SeasonDescription, "ui"},
       {ChallengesFrame.SeasonChangeNoticeFrame.SeasonDescription2, "ui"},
       {ChallengesFrame.WeeklyInfo.Child.Description, "ui"},
       {ChallengesFrame.WeeklyInfo.Child.SeasonBest, "ui"},
       {ChallengesFrame.WeeklyInfo.Child.ThisWeekLabel, "ui"},
       {ChallengesFrame.WeeklyInfo.Child.WeeklyChest.RunStatus, "ui"},
       {ChallengesFrame.WeeklyInfo.Child.DungeonScoreInfo.Title, "ui"},
     };
 
     for _, elementData in ipairs(elements) do
       local element, prefix = unpack(elementData);
       if WoWTR_Localization.lang == 'AR' then
         ST_CheckAndReplaceTranslationText(element, true, prefix, false, false, -10);
       else
         ST_CheckAndReplaceTranslationTextUI(element, true, prefix);
       end
     end
   end
 end

-------------------------------------------------------------------------------------------------------

--MERCHANT FRAME
function ST_MerchantFrame()
--print("ST_MerchantFrame");
   if (TT_PS["ui1"] == "1") then
      local MercTab1 = MerchantFrameTab1.Text;
      ST_CheckAndReplaceTranslationTextUI(MercTab1, true, "ui");

      local MercTab2 = MerchantFrameTab2.Text;
      ST_CheckAndReplaceTranslationTextUI(MercTab2, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------

--GAME MENU
function ST_GameMenuTranslate()
   if TT_PS["ui1"] ~= "1" then return end

   local function SafeUpdateText(textObject)
       if not textObject or not textObject.GetText then return end
       local originalText = textObject:GetText()
       if not originalText then return end

       local hash = StringHash(ST_UsunZbedneZnaki(originalText))
       if ST_TooltipsHS[hash] then
           local translatedText = QTR_ReverseIfAR(ST_TooltipsHS[hash]) .. NONBREAKINGSPACE
           C_Timer.After(0.01, function()
               if textObject:GetText() == originalText then
                   textObject:SetText(translatedText)
                   if textObject.SetFont then
                       textObject:SetFont(WOWTR_Font2, select(2, textObject:GetFont()))
                   end
               end
           end)
       -- elseif ST_PM["saveNW"] == "1" then
           -- ST_PH[hash] = "ui@" .. ST_PrzedZapisem(originalText)
       end
   end

   local function SafeUpdateButton(button)
      SafeUpdateText(button)
      
      local fontStates = {
          "Normal",
          "Highlight",
          "Disabled",
          "Pushed"
      }
      
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
       C_Timer.After(0.01, function()
           if GameMenuFrame.buttonPool then
               for buttonFrame in GameMenuFrame.buttonPool:EnumerateActive() do
                   SafeUpdateButton(buttonFrame)
               end
           end
       end)
   end

   hooksecurefunc(GameMenuFrame, "InitButtons", SafeInitButtons)

   SafeInitButtons()
end

-------------------------------------------------------------------------------------------------------

--Collections Journal & Toys
function ST_MountJournal()
--print(ST_MountJournal);
   if (TT_PS["ui4"] == "1") then
      local CJobj01 = MountJournalLore;
      local ST_MountName = MountJournalName:GetText();
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationText(CJobj01, true, "Collections:Mount:"..(ST_MountName or ''),false,false,-10);
      else
         ST_CheckAndReplaceTranslationTextUI(CJobj01, true, "Collections:Mount:"..(ST_MountName or ''));  -- https://imgur.com/7INQmHh
      end

      local CJobj02 = MountJournalSummonRandomFavoriteButtonSpellName;
      ST_CheckAndReplaceTranslationText(CJobj02, false, "ui",false,false);

      local CJobj03 = MountJournal.BottomLeftInset.SlotLabel;
      ST_CheckAndReplaceTranslationTextUI(CJobj03, false, "ui");

      local CJobj04 = MountJournal.MountDisplay.ModelScene.TogglePlayer.TogglePlayerText;
      ST_CheckAndReplaceTranslationTextUI(CJobj04, false, "ui");

      local CJobj05 = MountJournal.MountCount.Label;
      ST_CheckAndReplaceTranslationTextUI(CJobj05, false, "ui");

      local CJobj06 = CollectionsJournalTitleText;
      ST_CheckAndReplaceTranslationTextUI(CJobj06, false, "ui");

      local CJobj07 = MountJournalMountButton.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj07, false, "ui");

      local CJobj13 = WardrobeCollectionFrameTab1.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj13, false, "ui");

      local CJobj14 = WardrobeCollectionFrameTab2.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj14, false, "ui");

      local CJobj15 = MountJournalSearchBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(CJobj15, false, "ui");

      local CJobj16 = PetJournalSearchBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(CJobj16, false, "ui");

      local CJobj17 = PetJournal.PetCount.Label;
      ST_CheckAndReplaceTranslationTextUI(CJobj17, false, "ui");

      local CJobj18 = PetJournalSummonButton.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj18, false, "ui");

      local CJobj19 = PetJournalFindBattle.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj19, false, "ui");

      local CJobj20 = PetJournalSummonRandomFavoritePetButtonSpellName;
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationText(CJobj20, false, "ui",false,false);
      else
         ST_CheckAndReplaceTranslationTextUI(CJobj20, false, "ui");
      end

      local CJobj21 = PetJournalHealPetButtonSpellName;
      if (WoWTR_Localization.lang == 'AR') then
         ST_CheckAndReplaceTranslationText(CJobj21, false, "ui",false,false);
      else
         ST_CheckAndReplaceTranslationTextUI(CJobj21, false, "ui");
      end

      local CJobj22 = MountJournal.FilterDropdown.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj22, false, "ui");

      local CJobj23 = PetJournal.FilterDropdown.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj23, false, "ui");

      local CJobj24 = ToyBox.searchBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(CJobj24, false, "ui");

      local CJobj25 = ToyBox.FilterDropdown.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj25, false, "ui");

      local CJobj26 = ToyBox.PagingFrame.PageText;
      ST_CheckAndReplaceTranslationTextUI(CJobj26, false, "ui");

      local CJobj27 = HeirloomsJournalSearchBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(CJobj27, false, "ui");

      local CJobj28 = HeirloomsJournal.FilterDropdown.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj28, false, "ui");

      local CJobj29 = HeirloomsJournal.PagingFrame.PageText;
      ST_CheckAndReplaceTranslationTextUI(CJobj29, false, "ui");

      local CJobj30 = WardrobeCollectionFrameSearchBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(CJobj30, false, "ui");

      local CJobj31 = WardrobeCollectionFrame.FilterButton.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj31, false, "ui");

      local CJobj32 = WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.PageText;
      ST_CheckAndReplaceTranslationTextUI(CJobj32, false, "ui");

      for i = 1, 18 do
         local CJToys = ToyBox.iconsFrame["spellButton"..i].name;
         ST_CheckAndReplaceTranslationTextUI(CJToys, true, "toyname");
      end
   end
   
   if (TT_PS["ui5"] == "1") then
      local CJobj08 = CollectionsJournalTab1.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj08, false, "ui");

      local CJobj09 = CollectionsJournalTab2.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj09, false, "ui");

      local CJobj10 = CollectionsJournalTab3.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj10, false, "ui");

      local CJobj11 = CollectionsJournalTab4.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj11, false, "ui");

      local CJobj12 = CollectionsJournalTab5.Text;
      ST_CheckAndReplaceTranslationTextUI(CJobj12, false, "ui");
   end
end

local isMountButtonCreated = false
local mountUpdateVisibility

function ST_MountJournalbutton()
    if not isMountButtonCreated then
        TT_PS = TT_PS or { ui4 = "1" }

        mountUpdateVisibility = CreateToggleButton(
            MountJournal,
            TT_PS,
            "ui4",
            WoWTR_Localization.WoWTR_enDESC,
            WoWTR_Localization.WoWTR_trDESC,
            {"TOPLEFT", MountJournal, "TOPRIGHT", -170, 0},
            function()
                ST_MountJournal()
                -- You can add any necessary refresh logic here for the mount journal.
            end
        )

        isMountButtonCreated = true -- Mark that the button has been created to avoid duplication.
    end

    -- Adjust visibility of the existing button
    if mountUpdateVisibility then
        mountUpdateVisibility()
    end
end

-------------------------------------------------------------------------------------------------------

--CHARACTER FRAME
function ST_CharacterFrame() -- https://imgur.com/FV5MXvb
--print("ST_CharacterFrame");
   if (TT_PS["ui2"] == "1") then
      local ChFrame1 = CharacterStatsPane.ItemLevelCategory.Title;    -- Item Level
      ST_CheckAndReplaceTranslationTextUI(ChFrame1, true, "ui");

      local ChFrame2 = CharacterStatsPane.AttributesCategory.Title;   -- Attributes
      ST_CheckAndReplaceTranslationTextUI(ChFrame2, true, "ui");

      local ChFrame3 = CharacterStatsPane.EnhancementsCategory.Title; -- Enhancements
      ST_CheckAndReplaceTranslationTextUI(ChFrame3, true, "ui");

      local ChFrame4 = CharacterFrameTab1.Text;                       -- Character Tab
      ST_CheckAndReplaceTranslationTextUI(ChFrame4, true, "ui");

      local ChFrame5 = CharacterFrameTab2.Text;                       -- Reputation Tab
      ST_CheckAndReplaceTranslationTextUI(ChFrame5, true, "ui");

      local ChFrame6 = CharacterFrameTab3.Text;                       -- Currency Tab
      ST_CheckAndReplaceTranslationTextUI(ChFrame6, true, "ui");

      local ChFrame7 = ReputationFrame.ReputationDetailFrame.ScrollingDescription.ScrollBox.ScrollTarget; -- https://imgur.com/A77RwLM
      local childFrame = select(1, ChFrame7:GetChildren())  -- Get the first child frame 
      if childFrame and childFrame.FontString and childFrame.FontString.GetText then
         local text = childFrame.FontString:GetText()  -- Get the text
         --print("ChFrame7 text: " .. text)  -- Print the text to the console
         local RDFactionName = ReputationFrame.ReputationDetailFrame.Title:GetText(); -- Get the Faction Name
         ST_CheckAndReplaceTranslationTextUI(childFrame.FontString, true, "Factions:" .. ST_RenkKoduSil(RDFactionName));
      else
         --print("ChFrame7 text not found.");
      end

      local ChFrame8 = ReputationDetailAtWarCheckBoxText;             -- Check Box Text - At War
      ST_CheckAndReplaceTranslationTextUI(ChFrame8, true, "ui");

      local ChFrame9 = ReputationDetailInactiveCheckBoxText;          -- Check Box Text - Move to Inactive
      ST_CheckAndReplaceTranslationTextUI(ChFrame9, true, "ui");

      local ChFrame10 = ReputationDetailMainScreenCheckBoxText;       -- Check Box Text - Show as Experience Bar
      ST_CheckAndReplaceTranslationTextUI(ChFrame10, true, "ui");
   end

end

-------------------------------------------------------------------------------------------------------

--FRIENDS FRAME
function ST_FriendsFrame()
--print("ST_FriendsFrame");
   if (TT_PS["ui6"] == "1") then
      local Friendsobj01 = FriendsFrameTitleText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj01, true, "ui");

      local Friendsobj02 = FriendsTabHeaderTab1.Text;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj02, true, "ui");

      local Friendsobj03 = FriendsTabHeaderTab2.Text;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj03, true, "ui");

      local Friendsobj04 = FriendsTabHeaderTab3.Text;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj04, true, "ui");

      local Friendsobj05 = FriendsFrameTab1.Text;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj05, true, "ui");

      local Friendsobj06 = FriendsFrameTab2.Text;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj06, true, "ui");

      local Friendsobj07 = FriendsFrameTab3.Text;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj07, true, "ui");

      local Friendsobj08 = FriendsFrameTab4.Text;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj08, true, "ui");

      local Friendsobj09 = FriendsFrameAddFriendButtonText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj09, true, "ui");

      local Friendsobj10 = FriendsFrameSendMessageButtonText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj10, true, "ui");

      local Friendsobj11 = FriendsFrameIgnorePlayerButtonText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj11, true, "ui");

      local Friendsobj12 = FriendsFrameUnsquelchButtonText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj12, true, "ui");

      local Friendsobj13 = WhoFrameWhoButtonText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj13, true, "ui");

      local Friendsobj14 = WhoFrameAddFriendButtonText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj14, true, "ui");

      local Friendsobj15 = WhoFrameGroupInviteButtonText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj15, true, "ui");

      local Friendsobj16 = WhoFrameTotals;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj16, true, "ui");

      local Friendsobj17 = RaidFrameConvertToRaidButtonText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj17, true, "ui");

      local Friendsobj18 = RaidFrameRaidInfoButtonText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj18, true, "ui");

      local Friendsobj19 = RaidFrameRaidDescription;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj19, true, "ui");

      local Friendsobj20 = RecruitAFriendRecruitmentFrame.Title;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj20, true, "ui");
      
      local Friendsobj21 = RecruitAFriendRecruitmentFrame.Description;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj21, true, "ui");

      local Friendsobj22 = RecruitAFriendRecruitmentFrame.FactionAndRealm;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj22, true, "ui");

      local Friendsobj23 = RecruitAFriendFrame.RecruitList.Header.RecruitedFriends;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj23, true, "ui");

      local Friendsobj24 = RecruitAFriendFrame.RecruitmentButton.Text;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj24, true, "ui");



      local Friendsobj26 = RecruitAFriendFrame.RewardClaiming.MonthCount.Text;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj26, true, "ui");

      local Friendsobj27 = RecruitAFriendFrameText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj27, true, "ui");

      local Friendsobj28 = RecruitAFriendRecruitmentFrame.EditBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj28, true, "ui");

      local Friendsobj29 = RecruitAFriendRecruitmentFrameText;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj29, true, "ui");

      local Friendsobj30 = RecruitAFriendRecruitmentFrame.InfoText1;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj30, true, "ui");

      local Friendsobj31 = RecruitAFriendRecruitmentFrame.InfoText2;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj31, true, "ui");

      local Friendsobj32 = RecruitAFriendFrame.RewardClaiming.EarnInfo;
      ST_CheckAndReplaceTranslationTextUI(Friendsobj32, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------

--HELP FRAME TOOLTIP
function ST_HelpPlateTooltip()   -- https://imgur.com/MkPVoFr
--print("ST_HelpPlateTooltip");
   if (TT_PS["active"] == "1") then
      local HPT01 = HelpPlateTooltip.Text;
      ST_CheckAndReplaceTranslationTextUI(HPT01, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------

--SPLASH FRAME (What's New)
function ST_SplashFrame()   -- https://imgur.com/80WLNbC       You can use FontFile: Original_Font1, Original_Font2
--print("ST_SplashFrame");
   if (TT_PS["active"] == "1") then
      local SplashF01 = SplashFrame.Header;
      ST_CheckAndReplaceTranslationTextUI(SplashF01, true, "ui");

      local SplashF02 = SplashFrame.Label;
      ST_CheckAndReplaceTranslationTextUI(SplashF02, true, "ui");

      local SplashF03 = SplashFrame.TopLeftFeature.Description;
      if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(SplashF03, true, "ui",false,false,-10);
      SplashF03:SetJustifyH("RIGHT");
      else
      ST_CheckAndReplaceTranslationTextUI(SplashF03, true, "ui");
      end

      local SplashF04 = SplashFrame.BottomLeftFeature.Description;
      if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(SplashF04, true, "ui",false,false,-15);
      SplashF04:SetJustifyH("RIGHT");
      else
      ST_CheckAndReplaceTranslationTextUI(SplashF04, true, "ui");
      end

      local SplashF05 = SplashFrame.RightFeature.Description;
      if (WoWTR_Localization.lang == 'AR') then
      ST_CheckAndReplaceTranslationText(SplashF05, true, "ui",false,false,-10);
      else
      ST_CheckAndReplaceTranslationTextUI(SplashF05, true, "ui");
      end

      local SplashF06 = SplashFrame.BottomCloseButton.Text;
      ST_CheckAndReplaceTranslationTextUI(SplashF06, true, "ui");

      local SplashF07 = SplashFrame.TopLeftFeature.Title;
      ST_CheckAndReplaceTranslationTextUI(SplashF07, true, "ui");

      local SplashF08 = SplashFrame.BottomLeftFeature.Title;
      ST_CheckAndReplaceTranslationTextUI(SplashF08, true, "ui");

      local SplashF09 = SplashFrame.RightFeature.Title;
      ST_CheckAndReplaceTranslationTextUI(SplashF09, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------

--PING TUTORIAL FRAME
function ST_PingSystemTutorial()   -- https://imgur.com/tv61op7      You can use FontFile: Original_Font1, Original_Font2
--print("ST_PingSystemTutorial");
   if (TT_PS["active"] == "1") then
      local PST01 = PingSystemTutorialTitleText;
      ST_CheckAndReplaceTranslationTextUI(PST01, true, "ui");

      local PST02 = PingSystemTutorial.Tutorial1.TutorialHeader;
      ST_CheckAndReplaceTranslationTextUI(PST02, true, "ui");

      local PST03 = PingSystemTutorial.Tutorial2.TutorialHeader;
      ST_CheckAndReplaceTranslationTextUI(PST03, true, "ui");

      local PST04 = PingSystemTutorial.Tutorial3.TutorialHeader;
      ST_CheckAndReplaceTranslationTextUI(PST04, true, "ui");

      local PST05 = PingSystemTutorial.Tutorial4.TutorialHeader;
      ST_CheckAndReplaceTranslationTextUI(PST05, true, "ui");

      local PST06 = PingSystemTutorial.Tutorial4.ImageBounds.TutorialBody1;
      ST_CheckAndReplaceTranslationTextUI(PST06, true, "ui");

      local PST07 = PingSystemTutorial.Tutorial4.ImageBounds.TutorialBody2;
      ST_CheckAndReplaceTranslationTextUI(PST07, true, "ui");

      local PST08 = PingSystemTutorial.Tutorial4.ImageBounds.TutorialBody3;
      ST_CheckAndReplaceTranslationTextUI(PST08, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------

--BANK FRAME (Bank, Reagent, Warband Bank)
function ST_WarbandBankFrm()
--print("ST_WarbandBankFrm")
   if (TT_PS["active"] == "1") then
      local BANKFrame01 = AccountBankPanel.PurchasePrompt.Title;
      ST_CheckAndReplaceTranslationTextUI(BANKFrame01, false, "ui");

      local BANKFrame02 = AccountBankPanel.PurchasePrompt.PromptText;
      ST_CheckAndReplaceTranslationTextUI(BANKFrame02, false, "ui");

      local BANKFrame03 = AccountBankPanel.PurchasePrompt.TabCostFrame.PurchaseButton.Text;
      ST_CheckAndReplaceTranslationTextUI(BANKFrame03, false, "ui");

      local BANKFrame04 = AccountBankPanel.PurchasePrompt.TabCostFrame.TabCost;
      ST_CheckAndReplaceTranslationTextUI(BANKFrame04, false, "ui");

      local BANKFrame05 = AccountBankPanel.MoneyFrame.WithdrawButton.Text;
      ST_CheckAndReplaceTranslationTextUI(BANKFrame05, false, "ui");

      local BANKFrame06 = AccountBankPanel.MoneyFrame.DepositButton.Text;
      ST_CheckAndReplaceTranslationTextUI(BANKFrame06, false, "ui");

      local BANKFrame07 = AccountBankPanel.ItemDepositFrame.DepositButton.Text;
      ST_CheckAndReplaceTranslationTextUI(BANKFrame07, false, "ui");

      local BANKFrame08 = AccountBankPanel.ItemDepositFrame.IncludeReagentsCheckbox.Text;
      ST_CheckAndReplaceTranslationTextUI(BANKFrame08, false, "ui");

      local BANKFrame09 = BankItemSearchBox.Instructions;
      ST_CheckAndReplaceTranslationTextUI(BANKFrame09, false, "ui");
   end
end

-------------------------------------------------------------------------------------------------------

--TOOLTIPS FRAME (click on chat frame) 
local ignoreList = {}  -- The texts in the list will not be translated.
if WoWTR_Localization.lang == 'TR' then
    ignoreList = {
        "Head", "Neck", "Shoulder", "Back", "Chest", "Tabard", "Wrist", "Hands", "Waist", "Legs", "Feet", "Finger", "Trinket"
    }
else
    -- For other languages, the ignore list empty.
end

local function shouldIgnore(text)
    for _, ignoreText in ipairs(ignoreList) do
        if text:find(ignoreText) then
            return true
        end
    end
    return false
end

function ST_ItemRefTooltip()         -- https://imgur.com/a/5Ooqnb2
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

-------------------------------------------------------------------------------------------------------

--ITEM UPGRADE FRAME
function ST_ItemUpgradeFrm()         -- https://imgur.com/a/Vy6wNjO
   if (TT_PS["ui1"] == "1") then
   local ItemUpFrm01 = ItemUpgradeFrameTitleText;
   ST_CheckAndReplaceTranslationTextUI(ItemUpFrm01, false, "ui");
   local ItemUpFrm02 = ItemUpgradeFrame.ItemInfo.MissingItemText;
   ST_CheckAndReplaceTranslationTextUI(ItemUpFrm02, false, "ui");
   local ItemUpFrm03 = ItemUpgradeFrame.MissingDescription;
   ST_CheckAndReplaceTranslationTextUI(ItemUpFrm03, false, "ui");
   local ItemUpFrm04 = ItemUpgradeFrame.UpgradeButton.Text;
   ST_CheckAndReplaceTranslationTextUI(ItemUpFrm04, false, "ui");
   local ItemUpFrm05 = ItemUpgradeFrame.UpgradeCostFrame.Label;
   ST_CheckAndReplaceTranslationTextUI(ItemUpFrm05, false, "ui");
   local ItemUpFrm06 = ItemUpgradeFrame.ItemInfo.UpgradeTo;
   ST_CheckAndReplaceTranslationTextUI(ItemUpFrm06, false, "ui");
   local ItemUpFrm07 = ItemUpgradeFrameLeftItemPreviewFrameTextLeft1;
   ST_CheckAndReplaceTranslationTextUI(ItemUpFrm07, false, "ui");
   local ItemUpFrm08 = ItemUpgradeFrameRightItemPreviewFrameTextLeft1;
   ST_CheckAndReplaceTranslationTextUI(ItemUpFrm08, false, "ui");
   end
end

-------------------------------------------------------------------------------------------------------

--WEEKLY REWARDS - GREAT VAULT FRAME
function ST_WeeklyRewardsFrame()
   if (TT_PS["ui1"] == "1") then
    local WeeklyRFrm01 = WeeklyRewardsFrame.HeaderFrame.Text
    if (WoWTR_Localization.lang == 'AR') then
    ST_CheckAndReplaceTranslationText(WeeklyRFrm01, false, "ui", WOWTR_Font1,false,5)
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

-------------------------------------------------------------------------------------------------------

-- EVENT UNLOCKED TEXT FRAME
function ST_EventToastManagerFrame()
   if (TT_PS["ui1"] == "1") then
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

-------------------------------------------------------------------------------------------------------

-- RAID BOSS EMOTE FRAME
function ST_RaidBossEmoteFrame()
   if (TT_PS["ui1"] == "1") then
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

-------------------------------------------------------------------------------------------------------

if ((GetLocale()=="enUS") or (GetLocale()=="enGB")) then
-- Własne okno Tooltips - do wyświetlenia tłumaczenia Buff lub Debudd
   ST_MyGameTooltip = CreateFrame( "GameTooltip", "ST_MyGameTooltip", UIParent, "GameTooltipTemplate" );
   ST_MyGameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE" );

-------------------------------------------------------------------------------------------------------

   WOWSTR = CreateFrame("Frame");               -- ramka czekająca na załadowanie modułu ClassTalentFrame
   WOWSTR:SetScript("OnEvent", WOWSTR_onEvent);
   WOWSTR:RegisterEvent("ADDON_LOADED");

-------------------------------------------------------------------------------------------------------

   if SpellBookFrame_Update then
      hooksecurefunc("SpellBookFrame_Update", ST_updateSpellBookFrame);
   end

end
