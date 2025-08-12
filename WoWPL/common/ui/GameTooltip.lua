local addonName, addon = ...
local C = addon.C
local U = addon.U
local T = addon.T

local GT = {}

function GT.ST_BuffOrDebuff()
   if (_G["GameTooltipTextLeft2"] and _G["GameTooltipTextLeft2"]:GetText()) then
      local ST_leftText2 = _G["GameTooltipTextLeft2"]:GetText();
      local ST_hash = StringHash(U.ST_UsunZbedneZnaki(ST_leftText2));
      if (ST_TooltipsHS[ST_hash]) then -- mamy przetłumaczony ten Hash
         local ST_tlumaczenie = ST_TooltipsHS[ST_hash];
         ST_tlumaczenie = U.ST_TranslatePrepare(ST_leftText2, ST_tlumaczenie);
         local leftColR, leftColG, leftColB = _G["GameTooltipTextLeft2"]:GetTextColor();

         if not GameTooltip.OnHideHooked then
            GameTooltip:HookScript("OnHide", function()
               C_Timer.After(0.01, function()
                  ST_MyGameTooltip:Hide()
               end)
            end)
            GameTooltip.OnHideHooked = true
         end

         ST_MyGameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
         ST_MyGameTooltip:ClearAllPoints();
         ST_MyGameTooltip:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", 0, 0); -- pod przyciskiem od prawej strony
         ST_MyGameTooltip:ClearLines();
         if (WoWTR_Localization.lang == 'AR') then
            ST_MyGameTooltip:AddLine(QTR_ExpandUnitInfo(ST_tlumaczenie, false, ST_MyGameTooltip, WOWTR_Font2), leftColR,
               leftColG, leftColB, true);
         else
            ST_MyGameTooltip:AddLine(QTR_ReverseIfAR(ST_tlumaczenie), leftColR, leftColG, leftColB, true);
         end
         _G["ST_MyGameTooltipTextLeft1"]:SetFont(WOWTR_Font2, 12);    -- wielkość 12
         if (ST_PM["showHS"] == "1") then                             -- czy Hash ?
            ST_MyGameTooltip:AddLine(" ", 0, 0, 0);                   -- dodaj odstęp przed linią z Hash
            ST_MyGameTooltip:AddLine("Hash: " .. tostring(ST_hash), 0, 1, 1);
            _G["ST_MyGameTooltipTextLeft3"]:SetFont(WOWTR_Font2, 12); -- wielkość 12
         end
         ST_MyGameTooltip:Show();                                     -- wyświetla ramkę w tłumaczeniem (zrobi także resize)
      elseif ((ST_PM["saveNW"] == "1") and GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id) then
         local ST_prefix = "s" .. GameTooltip.processingInfo.tooltipData.id;
         ST_PH[ST_hash] = ST_prefix .. "@" .. U.ST_PrzedZapisem(ST_leftText2);
      end
   end
end

function GT.ST_GameTooltipOnShow()
   --print("Jestem w OnShow");
   if (ST_PM["active"] == "1") then -- dodatek aktywny
      C.ST_lastNumLines = 0;
      -- tu jeszcze obsługa buffów i debuffów - tłumaczenie w oddzielnej ramce pod oryginałem
      local ST_BFisOver = BuffFrame:IsMouseOver() or (ElvUIPlayerBuffs and ElvUIPlayerBuffs:IsMouseOver());
      local ST_DFisOver = DebuffFrame:IsMouseOver() or (ElvUIPlayerDebuffs and ElvUIPlayerDebuffs:IsMouseOver());
      if (ST_BFisOver or ST_DFisOver) then -- Buffy i Debuffy
         GT.ST_BuffOrDebuff();
         return;
      end

      GameTooltip.updateTooltipTimer = tonumber(ST_PM["timer"]); -- X sekund zatrzymania uaktualnienia GameTooltip
      if (_G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText()) then
         if (string.find(_G["GameTooltipTextLeft1"]:GetText(), NONBREAKINGSPACE)) then
            return;
         end
         _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(_G["GameTooltipTextLeft1"]:GetText(), WOWTR_Font2) ..
            NONBREAKINGSPACE); -- znacznik twardej spacji do tytułu
      end

      local ST_prefix = "h";
      if (GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id) then
         if (GameTooltip.processingInfo.tooltipData.type == 0) then -- items
            ST_prefix = "i" .. GameTooltip.processingInfo.tooltipData.id;
            if (ST_PM["item"] == "0") then                          -- nie ma zezwolenia tłumaczenia przedmiotów
               return;
            end
         elseif (GameTooltip.processingInfo.tooltipData.type == 1) then -- spell or talent
            if ST_IsTalentTooltip and ST_IsTalentTooltip(GameTooltip.processingInfo.tooltipData) then
               ST_prefix = "t" .. GameTooltip.processingInfo.tooltipData.id;
               if (ST_PM["talent"] == "0") then -- nie ma zezwolenia tłumaczenia talentów
                  return;
               end
            else
               ST_prefix = "s" .. GameTooltip.processingInfo.tooltipData.id;
               if (ST_PM["spell"] == "0") then -- nie ma zezwolenia tłumaczenia spelli
                  return;
               end
            end
         else                                                                                    --if (GameTooltip.processingInfo.tooltipData.type > 1) then
            ST_prefix = "s" .. GameTooltip.processingInfo.tooltipData.id;
            if (ST_PM["spell"] == "0") and (GameTooltip.processingInfo.tooltipData.id == 9) then -- nie ma zezwolenia tłumaczenia spelli
               return;
            end
         end
      end

      local numLines = GameTooltip:NumLines();
      if ((numLines == 1) and (ST_prefix ~= "h")) then -- GameTooltip zawiera tylko 1 linijkę opisu i jest to tytuł itemu lub spella
         return;
      end

      local ST_kodKoloru;
      local ST_leftText, ST_rightText, ST_tlumaczenie, ST_hash, ST_hash2, ST_pomoc5, ST_pomoc6, ST_pomoc7;
      local _font1, _size1, _1;
      local ST_odstep = true;
      local ST_orygText = {};
      local ST_nh = 0; -- nowy Hash ?

      -- sprawdź czy są ramki z ceną
      local moneyFrameLineNumber = {};
      local money = {};
      table.insert(moneyFrameLineNumber, 0);
      table.insert(money, 0);
      if (GameTooltip.shownMoneyFrames) then                                                           -- są ramki z ceną itemu
         for i = 1, GameTooltip.shownMoneyFrames, 1 do
            local moneyFrameName = GameTooltip:GetName() .. "MoneyFrame" .. i;                         -- nazwa obiektu
            _G[moneyFrameName .. "PrefixText"]:SetText(QTR_ReverseIfAR(WoWTR_Localization.sellPrice)); -- SELL PRICE
            _font1, _size1, _1 = _G[moneyFrameName .. "PrefixText"]:GetFont();                         -- odczytaj aktualną czcionkę i rozmiar
            _G[moneyFrameName .. "PrefixText"]:SetFont(WOWTR_Font2, _size1);
            if (ST_PM["sellprice"] == "1") then                                                        -- jest zezwolenie na ukrycie ceny skupu
               _G[moneyFrameName]:Hide();
               ST_odstep = false;
            end
         end
      end

      local ST_fromLine = 2;
      if (ST_prefix == "h") then
         ST_fromLine = 1;
      end

      if (ST_TooltipsID and (ST_PM["transtitle"] == "1") and ST_TooltipsID[ST_prefix]) then                                 -- jest zezwolenie na tłumaczenie tytułu i jest tłumaczenie
         _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(ST_TooltipsID[ST_prefix], WOWTR_Font2) .. NONBREAKINGSPACE); -- znacznik twardej spacji do tytułu
         _font1, _size1, _1 = _G["GameTooltipTextLeft1"]:GetFont();                                                         -- odczytaj aktualną czcionkę i rozmiar
         _G["GameTooltipTextLeft1"]:SetFont(WOWTR_Font2, _size1);
      end

      -- Get the line object
      local lineObj = _G["GameTooltipTextLeft1"]
      -- Get original font details *before* deciding translation
      local originalFont, originalSize, originalFlags = lineObj:GetFont()

      for i = ST_fromLine, numLines, 1 do
         ST_leftText = _G["GameTooltipTextLeft" .. i]:GetText();
         if (ST_leftText and (string.find(ST_leftText, NONBREAKINGSPACE) == nil)) then -- nie jest to nasze tłumaczenie
            leftColR, leftColG, leftColB = _G["GameTooltipTextLeft" .. i]:GetTextColor();
            ST_kodKoloru = U.OkreslKodKoloru(leftColR, leftColG, leftColB);
            if (ST_leftText and (string.len(ST_leftText) > 15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText) > 30))) then
               --print(ST_kodKoloru,i,ST_leftText);
               if (GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id and (GameTooltip.processingInfo.tooltipData.id == 6948)) then -- wyjątek na Kamień Powrotu
                  ST_pomoc5, _ = string.find(ST_leftText, ". Speak");                                                                                     -- znajdź kropkę kończącą pierwsze zdanie
                  if (ST_pomoc5 and (ST_pomoc5 > 22)) then
                     C.ST_miasto = string.sub(ST_leftText, 21, ST_pomoc5 - 1);
                  else
                     C.ST_miasto = WoWTR_Localization.your_home;
                  end
                  ST_pomoc6, _ = string.find(ST_leftText, ' Min Cooldown)');
                  if (ST_pomoc6) then -- mamy 2 wersję tekstu z Cooldown
                     ST_hash = 1336493626;
                  else                -- 1 wersja tekstu (bez Cooldown)
                     ST_hash = 3076025968;
                  end
               else
                  ST_hash = StringHash(U.ST_UsunZbedneZnaki(ST_leftText));
               end
               if (((ST_kodKoloru == "c7") or (string.len(ST_leftText) > 30)) and (not ST_hash2)) then
                  ST_hash2 = ST_hash;
               end
               ST_pomoc7, _ = string.find(ST_leftText, "<Made by"); -- znajdź czy jest to tekst typu "|cff00ff00<Made by Platine>|r"
               if (ST_pomoc7) then
                  ST_hash = 1381871427;
               end
               if (ST_TooltipsHS[ST_hash]) then -- mamy przetłumaczony ten Hash lub jest to <Made by...
                  if (ST_pomoc7) then
                     local endBy = string.find(ST_leftText, ">");
                     local nameBy = string.sub(ST_leftText, ST_pomoc7 + 9, endBy - 1);
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
                  ST_tlumaczenie = U.ST_TranslatePrepare(ST_leftText, ST_tlumaczenie);
                  _font1, _size1, _1 = _G["GameTooltipTextLeft" .. i]:GetFont();                                                                             -- odczytaj aktualną czcionkę i rozmiar
                  _G["GameTooltipTextLeft" .. i]:SetFont(WOWTR_Font2, _size1);                                                                               -- ustawiamy czcionkę turecką
                  _G["GameTooltipTextLeft" .. i]:SetText(QTR_ExpandUnitInfo(ST_tlumaczenie, false,
                     _G["GameTooltipTextLeft" .. i], WOWTR_Font2, -5) .. NONBREAKINGSPACE);                                                                  -- dodajemy twardą spacje na końcu
                  _G["GameTooltipTextLeft" .. i].wrap = true;
                  if (GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id and (GameTooltip.processingInfo.tooltipData.id == 6948)) then -- wyjątek na Kamień Powrotu
                     break;
                  end
               else
                  -- >>> Explicitly ensure original font if no translation <<<
                  if lineObj.SetFont then
                     lineObj:SetFont(originalFont, originalSize, originalFlags)
                  end
                  -- >>> End explicit ensure <<<

                  ST_nh = 1; -- nowy Hash
                  table.insert(ST_orygText, ST_leftText);
               end
            end
         end
      end


      if (((ST_PM["showID"] == "1") and (string.len(ST_prefix) > 1)) or ((ST_PM["showHS"] == "1") and ST_hash2)) then -- czy dodawać ID i Hash ?
         numLines = GameTooltip:NumLines();                                                                           -- aktualna liczba linii
         if (numLines > 0 and ST_odstep) then
            GameTooltip:AddLine(" ", 0, 0, 0);                                                                        -- dodaj odstęp przed linią z ID
         end
         local typName = " ";
         if (string.sub(ST_prefix, 1, 1) == "i") then
            typName = "Item";
            ST_ID = string.sub(ST_prefix, 2);
         elseif (string.sub(ST_prefix, 1, 1) == "s") then
            typName = "Spell";
            ST_ID = string.sub(ST_prefix, 2);
         elseif (string.sub(ST_prefix, 1, 1) == "t") then
            typName = "Talent";
            ST_ID = string.sub(ST_prefix, 2);
         else
            ST_ID = nil;
         end
         if ((ST_PM["showID"] == "1") and ST_ID) then
            GameTooltip:AddLine(typName .. " ID: " .. tostring(ST_ID), 0, 1, 1);
            numLines = GameTooltip:NumLines();                               -- Aktualna liczba linii w GameTooltip
            _G["GameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 12);  -- wielkość 12
            _G["GameTooltipTextRight" .. numLines]:SetFont(WOWTR_Font2, 12); -- wielkość 12
         end
         if ((ST_PM["showHS"] == "1") and ST_hash2) then
            GameTooltip:AddLine("Hash: " .. tostring(ST_hash2), 0, 1, 1);
            numLines = GameTooltip:NumLines();                               -- Aktualna liczba linii w GameTooltip
            _G["GameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 12);  -- wielkość 12
            _G["GameTooltipTextRight" .. numLines]:SetFont(WOWTR_Font2, 12); -- wielkość 12
         end
      end

      if ((ST_PM["constantly"] == "1") and (UnitLevel("player") > 60) and _G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText()) then
         _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(_G["GameTooltipTextLeft1"]:GetText(), WOWTR_Font2) ..
            NONBREAKINGSPACE);
      end
      GameTooltip:Show(); -- wyświetla ramkę podpowiedzi (zrobi także resize)
      C.ST_lastNumLines = GameTooltip:NumLines();

      if ((ST_orygText or (ST_nh == 1)) and (ST_PM["saveNW"] == "1")) then
         for _, ST_origin in ipairs(ST_orygText) do
            local ST_hash = StringHash(U.ST_UsunZbedneZnaki(ST_origin))
            if (string.sub(ST_origin, 1, 11) ~= '|A:raceicon') then
               local shouldSave = true

               for _, word in ipairs(C.ignoreSettings.words) do
                  if string.find(ST_origin, word) then
                     shouldSave = false
                     break
                  end
               end

               if shouldSave and string.find(ST_origin, C.ignoreSettings.pattern) then
                  shouldSave = false
               end

               if shouldSave then
                  ST_PH[ST_hash] = ST_prefix .. "@" .. U.ST_PrzedZapisem(ST_origin)
               end
            end
         end
      end
   end
end

function GT.ST_CurrentEquipped(obj)
   if ((ST_PM["active"] == "1") and (ST_PM["item"] == "1")) then -- dodatek aktywny i zezwolono na tłumaczenie itemów
      if (obj.processingInfo and obj.processingInfo.tooltipData.id) then
         ST_prefix = "i" .. obj.processingInfo.tooltipData.id;

         local ST_kodKoloru;
         local ST_leftText, ST_rightText, ST_tlumaczenie, ST_hash, ST_hash2;
         local _font1, _size1, _1;
         local ST_odstep = true;
         local ST_orygText = {};
         local ST_nh = 0; -- nowy Hash ?
         local numLines = obj:NumLines();

         -- sprawdź czy są ramki z ceną
         local moneyFrameLineNumber = {};
         local money = {};
         table.insert(moneyFrameLineNumber, 0);
         table.insert(money, 0);
         if (obj.shownMoneyFrames) then                                                                   -- są ramki z ceną itemu
            for i = 1, obj.shownMoneyFrames, 1 do
               local moneyFrameName = obj:GetName() .. "MoneyFrame" .. i;                                 -- nazwa obiektu
               _G[moneyFrameName .. "PrefixText"]:SetText(QTR_ReverseIfAR(WoWTR_Localization.sellPrice)); -- SELL PRICE
               _font1, _size1, _1 = _G[moneyFrameName .. "PrefixText"]:GetFont();                         -- odczytaj aktualną czcionkę i rozmiar
               _G[moneyFrameName .. "PrefixText"]:SetFont(WOWTR_Font2, _size1);
               if (ST_PM["sellprice"] == "1") then                                                        -- jest zezwolenie na ukrycie ceny skupu
                  _G[moneyFrameName]:Hide();
                  ST_odstep = false;
               end
            end
         end

         -- pierwsza linia z opisem założenia przedmiotu (Currently Equipped lub Equipped With)
         ST_leftText = _G[obj:GetName() .. "TextLeft1"]:GetText();
         if (ST_leftText) then
            if (string.find(ST_leftText, NONBREAKINGSPACE) == nil) then -- nie jest to tekst przetłumaczony (twarda spacja na końcu)
               if (ST_leftText == "Currently Equipped") then
                  ST_info = WoWTR_Localization.currentlyEquipped;
               elseif (ST_leftText == "Equipped With") then
                  ST_info = WoWTR_Localization.additionalEquipped;
               else
                  ST_info = ST_leftText;                                                                                        -- inny wariant tekstu?
               end
               if ((ST_info == ST_leftText) and (string.len(ST_leftText) > 2) and (string.sub(ST_leftText, 1, 2) ~= "|T")) then -- nic nie przetłumaczono
                  --   ST_PI[ST_info]=leftText[1];        -- zapisz
               else
                  _font1, _size1, _1 = _G[obj:GetName() .. "TextLeft1"]:GetFont();                        -- odczytaj aktualną czcionkę i rozmiar
                  _G[obj:GetName() .. "TextLeft1"]:SetText(QTR_ReverseIfAR(ST_info) .. NONBREAKINGSPACE); -- dodajemy twardą spacje na końcu
                  _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, _size1);
               end
            end
         end

         -- druga linia z tytułem przedmiotu
         ST_pomoc0, _ = string.find(_G[obj:GetName() .. "TextLeft2"]:GetText(), NONBREAKINGSPACE);                                            -- szukamy twardej spacji
         if (ST_TooltipID and (ST_pomoc0 == nil) and (ST_TooltipsID[ST_prefix .. tostring(ST_itemID)]) and (ST_PM["transtitle"] == "1")) then -- jest tłumaczenie tytułu w bazie
            _G[obj:GetName() .. "TextLeft2"]:SetText(QTR_ExpandUnitInfo(ST_TooltipsID[ST_prefix .. tostring(ST_itemID)]),
               WOWTR_Font2);
            _font1, _size1, _1 = _G[obj:GetName() .. "TextLeft2"]:GetFont(); -- odczytaj aktualną czcionkę i rozmiar
            _G[obj:GetName() .. "TextLeft2"]:SetFont(WOWTR_Font2, _size1);
         end

         for i = 3, numLines, 1 do
            ST_leftText = _G[obj:GetName() .. "TextLeft" .. i]:GetText();
            if (ST_leftText and (string.find(ST_leftText, NONBREAKINGSPACE) == nil)) then -- nie jest to nasze tłumaczenie
               leftColR, leftColG, leftColB = _G[obj:GetName() .. "TextLeft" .. i]:GetTextColor();
               ST_kodKoloru = U.OkreslKodKoloru(leftColR, leftColG, leftColB);
               if (ST_leftText and (string.len(ST_leftText) > 15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText) > 30))) then
                  --print(ST_kodKoloru,i,ST_leftText);
                  -- Get the line object
                  local lineObj = _G[obj:GetName() .. "TextLeft" .. i]
                  -- Get original font details *before* deciding translation
                  local originalFont, originalSize, originalFlags = lineObj:GetFont()
                  ST_hash = StringHash(U.ST_UsunZbedneZnaki(ST_leftText));
                  if (((ST_kodKoloru == "c7") or (string.len(ST_leftText) > 30)) and (not ST_hash2)) then
                     ST_hash2 = ST_hash;
                  end
                  if (ST_TooltipsHS[ST_hash]) then -- mamy przetłumaczony ten Hash
                     ST_tlumaczenie = ST_TooltipsHS[ST_hash];
                     ST_tlumaczenie = U.ST_TranslatePrepare(ST_leftText, ST_tlumaczenie);
                     _font1, _size1, _1 = _G[obj:GetName() .. "TextLeft" .. i]:GetFont();  -- odczytaj aktualną czcionkę i rozmiar
                     _G[obj:GetName() .. "TextLeft" .. i]:SetFont(WOWTR_Font2, _size1);    -- ustawiamy czcionkę turecką
                     _G[obj:GetName() .. "TextLeft" .. i]:SetText(QTR_ExpandUnitInfo(ST_tlumaczenie, false,
                        _G["GameTooltipTextLeft" .. i], WOWTR_Font2) .. NONBREAKINGSPACE); -- dodajemy twardą spacje na końcu
                  else
                     -- >>> Explicitly ensure original font if no translation <<<
                     if lineObj.SetFont then
                        lineObj:SetFont(originalFont, originalSize, originalFlags)
                     end
                     -- >>> End explicit ensure <<<

                     ST_nh = 1; -- nowy Hash
                     table.insert(ST_orygText, ST_leftText);
                  end
               end
            end
         end


         if (((ST_PM["showID"] == "1") and (string.len(ST_prefix) > 1)) or ((ST_PM["showHS"] == "1") and ST_hash2)) then -- czy dodawać ID i Hash ?
            numLines = obj:NumLines();                                                                                   -- aktualna liczba linii
            if (numLines > 0 and ST_odstep) then
               obj:AddLine(" ", 0, 0, 0);                                                                                -- dodaj odstęp przed linią z ID
            end
            local typName = " ";
            if (string.sub(ST_prefix, 1, 1) == "i") then
               typName = "Item";
               ST_ID = string.sub(ST_prefix, 2);
            elseif (string.sub(ST_prefix, 1, 1) == "s") then
               typName = "Spell";
               ST_ID = string.sub(ST_prefix, 2);
            elseif (string.sub(ST_prefix, 1, 1) == "t") then
               typName = "Talent";
               ST_ID = string.sub(ST_prefix, 2);
            else
               ST_ID = nil;
            end
            if ((ST_PM["showID"] == "1") and ST_ID) then
               obj:AddLine(typName .. " ID: " .. tostring(ST_ID), 0, 1, 1);
               numLines = obj:NumLines();                                             -- Aktualna liczba linii w obj
               _G[obj:GetName() .. "TextLeft" .. numLines]:SetFont(WOWTR_Font2, 12);  -- wielkość 12
               _G[obj:GetName() .. "TextRight" .. numLines]:SetFont(WOWTR_Font2, 12); -- wielkość 12
            end
            if ((ST_PM["showHS"] == "1") and ST_hash2) then
               obj:AddLine("Hash: " .. tostring(ST_hash2), 0, 1, 1);
               numLines = obj:NumLines();                                             -- Aktualna liczba linii w obj
               _G[obj:GetName() .. "TextLeft" .. numLines]:SetFont(WOWTR_Font2, 12);  -- wielkość 12
               _G[obj:GetName() .. "TextRight" .. numLines]:SetFont(WOWTR_Font2, 12); -- wielkość 12
            end
         end

         obj:Show(); -- wyświetla ramkę podpowiedzi (zrobi także resize)

         if ((ST_orygText or (ST_nh == 1)) and (ST_PM["saveNW"] == "1")) then
            for _, ST_origin in ipairs(ST_orygText) do
               ST_hash = StringHash(U.ST_UsunZbedneZnaki(ST_origin));
               if ((not ST_TooltipsHS[ST_hash]) and (string.find(ST_origin, NONBREAKINGSPACE) == nil)) then -- i nie jest to tekst tłumaczenia (twarda spacja)
                  ST_PH[ST_hash] = ST_prefix .. "@" .. U.ST_PrzedZapisem(ST_origin);
               end
            end
         end
      end
   end -- if ST_PM["active"]
end

function GT.Initialize()
    if ((GetLocale() == "enUS") or (GetLocale() == "enGB")) then
        -- funkcja wywoływana po wyświetleniu się oryginalnego okienka Tooltip
        GameTooltip:HookScript('OnUpdate', function(self, ...)
            if (not WOWTR_wait(0, GT.ST_GameTooltipOnShow)) then
                -- opóźnienie 0.01 sek
            end
        end);

        -------------------------------------------------------------------------------------------------------

        -- funkcja wywoływana po ukryciu oryginalnego okienka Tooltip
        GameTooltip:HookScript('OnHide', function(self, ...)
            C.ST_lastNumLines = 0;
        end);

        -------------------------------------------------------------------------------------------------------

        -- funkcja wywoływana po wyświetleniu się oryginalnego okienka Tooltip
        GameTooltip:HookScript('OnUpdate', function(self, ...)
            if ((ST_PM["active"] == "1") and (C.ST_lastNumLines > 0)) then -- dodatek aktywny
                if ((ST_PM["constantly"] == "1") and (UnitLevel("player") > 10)) then
                    if ((ST_PM["showID"] == "1") or (ST_PM["showHS"] == "1")) then
                        if (C.ST_lastNumLines ~= self:NumLines()) then
                            GT.ST_GameTooltipOnShow();
                        end
                    elseif (_G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText() and (string.find(_G["GameTooltipTextLeft1"]:GetText(), NONBREAKINGSPACE) == nil)) then
                        GT.ST_GameTooltipOnShow();
                    end
                elseif ((ST_PM["constantly"] == "1") and (self.updateTooltipTimer > 1)) then
                    self.updateTooltipTimer = 2;
                end
            end
        end);

        hooksecurefunc("GameTooltip_ShowCompareItem", function(self)
            if (ShoppingTooltip1 and ShoppingTooltip1:IsVisible()) then
                GT.ST_CurrentEquipped(ShoppingTooltip1);
            end
            if (ShoppingTooltip2 and ShoppingTooltip2:IsVisible()) then
                GT.ST_CurrentEquipped(ShoppingTooltip2);
            end
        end);
    end
end

addon.GT = GT
