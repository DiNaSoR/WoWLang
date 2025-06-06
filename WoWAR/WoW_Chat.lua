﻿-- Description: The addon supports chat for entering and displaying messages in Arabic.
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR]
-------------------------------------------------------------------------------------------------------

local CH_on_debug = false;
-- General Variables
local CH_ctrFrame = CreateFrame("FRAME", "WoWinArabic-Chat");
local CH_ED_mode = 0;           -- włączony tryb arabski, wyrównanie do prawej strony
local CH_ED_cursor_move = 0;    -- tryb przesuwania kursora po wpisaniu litery (0-w prawo, 1-w lewo)
local CH_BubblesArray = {};
local CH_BuforEditBox = {};
local CH_BuforLength = 0;
local CH_BuforCursor = 0;
local CH_last_letter = "";
local limit_chars1 = 35;        -- max. number of 1 line on bubble (one-line bubble)
local limit_chars2 = 60;        -- max. number of 2 line on bubble (two-lines bubble)
local CH_key_ctrl = false;
local CH_key_shift = false;
local CH_key_alt = false;
local CH_highlight_text = false;
local CH_BSize = 14;            -- default size of chat bubbles

-- fonty z arabskimi znakami
CH_Font = WOWTR_Font2;
-------------------------------------------------------------------------------------------------------

local function CH_bubblizeText()
   for _, bubble in pairs(C_ChatBubbles.GetAllChatBubbles()) do
   -- Iterate the children, as the actual bubble content 
   -- has been placed in a nameless subframe in 9.0.1.
      for j = 1, bubble:GetNumChildren() do
         local child = select(j, select(j, bubble:GetChildren()));
         if (not child:IsForbidden()) then                           -- czy ramka nie jest zabroniona?
            if (child:GetObjectType() == "Frame") and (child.String) and (child.Center) then
            -- This is hopefully the frame with the content
               for i = 1, child:GetNumRegions() do
                  local region = select(i, child:GetRegions());
                  if (CH_PM["setsize"]=="1") then
                     act_font = tonumber(CH_PM["fontsize"]);
                  else
                     act_font = CH_BSize;
                  end
                  for idx, iArray in ipairs(CH_BubblesArray) do      -- sprawdź, czy dane są właściwe (tekst oryg. się zgadza z zapisaną w tablicy)
                     if (region and not region:GetName() and region:IsVisible() and region.GetText and (region:GetText() == iArray[1])) then
                        local newText = iArray[2];   -- text received
                        local okrWidth = AS_UTF8len(newText);
                        region:SetFont(CH_Font, act_font);     -- ustaw arabską czcionkę oraz wielkość
                        if ((okrWidth >= limit_chars2) or (region:GetHeight() > act_font*3)) then    -- 3 lines or more
                           region:SetJustifyH("RIGHT");              -- wyrównanie do prawej strony (domyślnie jest CENTER)
                           newText = CH_LineReverse(iArray[2], 3);
                           region:SetText(newText);
                        elseif ((okrWidth >= limit_chars1) or (region:GetHeight() > act_font*2)) then   -- 2 lines
                           region:SetJustifyH("RIGHT");              -- wyrównanie do prawej strony
                           newText = CH_LineReverse(iArray[2], 2);
                           region:SetText(newText);
                        else                                         -- bubble in 1-line
                           region:SetJustifyH("CENTER");             -- wyrównanie do środka
                           region:SetText(newText);                  -- wpisz tu nasze tłumaczenie
                        end
                        region:SetWidth(CH_SpecifyBubbleWidth(newText, region));  -- określ nową szer. okna
                        tremove(CH_BubblesArray, idx);               -- usuń zapamiętane dane z tablicy
                     end
                  end
               end
            end
         end
      end
   end

   for idx, iArray in ipairs(CH_BubblesArray) do            -- przeszukaj jeszcze raz tablicę
      if (iArray[3] >= 100) then                            -- licznik osiągnął 100
         tremove(CH_BubblesArray, idx);                     -- usuń zapamiętane dane z tablicy
      else
         iArray[3] = iArray[3]+1;                           -- zwiększ licznik (nie pokazał się dymek?)
      end;
   end;
   if (#(CH_BubblesArray) == 0) then
      CH_ctrFrame:SetScript("OnUpdate", nil);               -- wyłącz metodę Update, bo tablica pusta
   end;
end;

-------------------------------------------------------------------------------------------------------

local function CH_Usun_Linki(txt)       -- funkcja usuwa kody linków przedmiotów
   local pocz, koniec, final;
   local txt1 = txt;
   pocz = string.find(txt1, "|cffffffff|Hitem");
   while (pocz and pocz > 0) do         -- znalazł początek linku
      koniec = string.find(txt1, "|h");
      final = string.find(txt1, "|h|r");
      if (koniec and final and (koniec > 0) and (pocz < koniec) and (koniec < final)) then
         txt1 = string.sub(txt1, 1, pocz-1) .. string.sub(txt1, koniec+3, final-2) .. string.sub(txt1, final+4);
      else
         break;
      end
      pocz = string.find(txt1, "|cffffff|Hitem");
   end
   return txt1;
end

-------------------------------------------------------------------------------------------------------

local function CH_Hex2Char(txt)
   local ret = txt;
   if (strlen(ret) < 2) then
      ret = "0" .. ret;
   end
   return ret;
end

-------------------------------------------------------------------------------------------------------

local function CH_Check_Arabic_Letters(txt)
   local result = false;
   if (txt) then
      local bytes = strlen(txt);
      local pos = 1;
      local char0 = '';
      local charbytes0;
      while (pos <= bytes) do
         charbytes0 = AS_UTF8charbytes(txt, pos);         -- count of bytes (liczba bajtów znaku)
         char0 = strsub(txt, pos, pos + charbytes0 - 1);  -- current character
         pos = pos + charbytes0;
         if (char0 >= "؀") then      -- it is an arabic letter
            result = true;
            break;
         end
      end
   end
   return result;
end

-------------------------------------------------------------------------------------------------------

local function CH_ChatFilter(self, event, arg1, arg2, arg3, _, arg5, ...)
   if (CH_PM["active"]=="0") then
      return false;     -- wyświetlaj tekst oryginalny w oknie czatu
   end
   local colorText = "";
   local colorR, colorG, colorB;
   if (event == "CHAT_MSG_SAY") then
      colorR =  CH_Hex2Char(string.format("%x",ChatTypeInfo.SAY.r * 255));
      colorG =  CH_Hex2Char(string.format("%x",ChatTypeInfo.SAY.g * 255));
      colorB =  CH_Hex2Char(string.format("%x",ChatTypeInfo.SAY.b * 255));
      colorText = "|cFF"..colorR..colorG..colorB;
   elseif (event == "CHAT_MSG_YELL") then
      colorR =  CH_Hex2Char(string.format("%x",ChatTypeInfo.YELL.r * 255));
      colorG =  CH_Hex2Char(string.format("%x",ChatTypeInfo.YELL.g * 255));
      colorB =  CH_Hex2Char(string.format("%x",ChatTypeInfo.YELL.b * 255));
      colorText = "|cFF"..colorR..colorG..colorB;
   elseif ((event == "CHAT_MSG_WHISPER") or (event == "CHAT_MSG_WHISPER_INFORM")) then
      colorR =  CH_Hex2Char(string.format("%x",ChatTypeInfo.WHISPER.r * 255));
      colorG =  CH_Hex2Char(string.format("%x",ChatTypeInfo.WHISPER.g * 255));
      colorB =  CH_Hex2Char(string.format("%x",ChatTypeInfo.WHISPER.b * 255));
      colorText = "|cFF"..colorR..colorG..colorB;
   elseif ((event == "CHAT_MSG_PARTY") or (event == "CHAT_MSG_PARTY_LEADER")) then
      colorR =  CH_Hex2Char(string.format("%x",ChatTypeInfo.PARTY.r * 255));
      colorG =  CH_Hex2Char(string.format("%x",ChatTypeInfo.PARTY.g * 255));
      colorB =  CH_Hex2Char(string.format("%x",ChatTypeInfo.PARTY.b * 255));
      colorText = "|cFF"..colorR..colorG..colorB;
   elseif (event == "CHAT_MSG_RAID") then
      colorR =  CH_Hex2Char(string.format("%x",ChatTypeInfo.RAID.r * 255));
      colorG =  CH_Hex2Char(string.format("%x",ChatTypeInfo.RAID.g * 255));
      colorB =  CH_Hex2Char(string.format("%x",ChatTypeInfo.RAID.b * 255));
      colorText = "|cFF"..colorR..colorG..colorB;
   elseif (event == "CHAT_MSG_RAID_LEADER") then
      colorText = "|cFFFF0000";        -- red color
   elseif (event == "CHAT_MSG_RAID_WARNING") then
      colorText = "|cFFFF0000";        -- red color
   elseif ((event == "CHAT_MSG_GUILD") or (event == "CHAT_MSG_OFFICER")) then
      colorR =  CH_Hex2Char(string.format("%x",ChatTypeInfo.GUILD.r * 255));
      colorG =  CH_Hex2Char(string.format("%x",ChatTypeInfo.GUILD.g * 255));
      colorB =  CH_Hex2Char(string.format("%x",ChatTypeInfo.GUILD.b * 255));
      colorText = "|cFF"..colorR..colorG..colorB;
   elseif ((event == "CHAT_MSG_BATTLEGROUND") or (event == "CHAT_MSG_BATTLEGROUND_LEADER")) then
      colorR =  CH_Hex2Char(string.format("%x",ChatTypeInfo.BATTLEGROUND.r * 255));
      colorG =  CH_Hex2Char(string.format("%x",ChatTypeInfo.BATTLEGROUND.g * 255));
      colorB =  CH_Hex2Char(string.format("%x",ChatTypeInfo.BATTLEGROUND.b * 255));
      colorText = "|cFF"..colorR..colorG..colorB;
   end

   local is_arabic = CH_Check_Arabic_Letters(arg1);
   if (is_arabic) then
      local output = "";
      
      -- Determine player name and attempt to get class color
      local playerNameOnly = arg2 -- Default name for UnitClass lookup & display
      local playerFullName = arg2 -- Full name for GetPlayerLink target
      local playerColorStr = "FFFFFFFF" -- Default color to white

      local poz = string.find(playerFullName, "-");
      if poz then
         -- Extract name without realm if hyphen exists
         playerNameOnly = string.sub(playerFullName, 1, poz-1)
      end

      -- Debugging Output 1: Show names being processed
      if CH_on_debug then print("|cFF00FF00WoWAR Debug:|r Processing player:", playerFullName, "| Name for UnitClass:", playerNameOnly) end

      -- Try to get the class name and color using pcall for safety
      local success, className = pcall(UnitClass, playerNameOnly);
      local classNameUpper = nil -- Variable to hold the uppercase version

      -- Debugging Output 2: Show result of UnitClass
       if CH_on_debug then
           if success then
               print("|cFF00FF00WoWAR Debug:|r UnitClass result for", playerNameOnly, "is:", className or "nil")
           else
               print("|cFFFF0000WoWAR Debug:|r UnitClass call failed for", playerNameOnly, ":", className) -- className holds error msg here
               className = nil
           end
       end

      -- Trim and convert to uppercase if successful
      if success and className then
          className = string.trim(className) -- Trim first
          classNameUpper = string.upper(className) -- Then convert to uppercase
          if CH_on_debug then print("|cFF00FF00WoWAR Debug:|r Trimmed className:", className, "| Uppercase for lookup:", classNameUpper) end
      end

      -- Use the uppercase version for the lookup
      if classNameUpper and RAID_CLASS_COLORS[classNameUpper] then
         -- Class found, use the specific class color
         playerColorStr = RAID_CLASS_COLORS[classNameUpper].colorStr;
         if CH_on_debug then print("|cFF00FF00WoWAR Debug:|r Class color FOUND for", classNameUpper, ": |c"..playerColorStr..playerColorStr.."|r") end
      else
         -- Debugging Output 4: Indicate fallback reason
         if CH_on_debug then
            if not classNameUpper then
               print("|cFF00FF00WoWAR Debug:|r ClassName was nil, failed, or became empty after processing. Using default white.")
            else
               -- Print the uppercase name that failed the lookup
               print("|cFF00FF00WoWAR Debug:|r Uppercase ClassName '", classNameUpper, "' not found in RAID_CLASS_COLORS. Using default white.")
            end
         end
      end

      -- Construct the player link using the correct names and determined color
      -- Note: We still display the original Capitalized playerNameOnly, just use classNameUpper for color lookup
      local playerLink = GetPlayerLink(playerFullName, ("[|c"..playerColorStr.."%s|r]"):format(playerNameOnly), arg11);

      -- Debugging Output 5: Show the final link generated
      if CH_on_debug then print("|cFF00FF00WoWAR Debug:|r Generated playerLink:", playerLink or "nil") end

      local _fontC, _sizeC, _C = self:GetFont();   -- odczytaj aktualną czcionkę, rozmiar i typ
      -- Font should be handled by hooks/guardian, setting it here might be redundant/cause issues
      -- self:SetFont(CH_Font, _sizeC, _C);
      
      if (event == "CHAT_MSG_SAY") then
         output = arg1..AS_UTF8reverseRS(" يتحدث: ")..playerLink;   -- said (forma właściwa)
         local czystyArg = CH_Usun_Linki(arg1);
         tinsert(CH_BubblesArray, { [1] = czystyArg, [2] = czystyArg, [3] = 1 });
         CH_ctrFrame:SetScript("OnUpdate", CH_bubblizeText);      -- obsługa bubbles dla komunikatu SAY
      elseif (event == "CHAT_MSG_YELL") then
         output = arg1..AS_UTF8reverseRS(" يصرخ: ")..playerLink;    -- yelled
         local czystyArg = CH_Usun_Linki(arg1);
         tinsert(CH_BubblesArray, { [1] = czystyArg, [2] = czystyArg, [3] = 1 });
         CH_ctrFrame:SetScript("OnUpdate", CH_bubblizeText);      -- obsługa bubbles dla komunikatu SAY
      elseif (event == "CHAT_MSG_WHISPER") then          -- otrzymany szept od innego gracza
         if (self:GetName() == "ChatFrame1") then        -- jest komunikat WHISPER w głównym oknie czatu
            return true;                      -- nie wyświetlaj komunikatu WHISPER w głównym oknie czatu
         end
         output = arg1..AS_UTF8reverseRS(" همس: ")..playerLink;     -- whisped
      elseif (event == "CHAT_MSG_WHISPER_INFORM") then   -- wysyłany szept do innego gracza
         if (self:GetName() == "ChatFrame1") then        -- jest komunikat WHISPER w głównym oknie czatu
            return true;                      -- nie wyświetlaj komunikatu WHISPER w głównym oknie czatu
         end
         output = arg1.." :"..playerLink.." "..AS_UTF8reverseRS("إلى");    
      elseif ((event == "CHAT_MSG_PARTY") or (event == "CHAT_MSG_PARTY_LEADER")) then
         local isPratLoaded = C_AddOns.IsAddOnLoaded("Prat-3.0")
         local tag = ""
         if (event == "CHAT_MSG_PARTY_LEADER") then
             tag = isPratLoaded and " [PL]" or " [Party Leader]"
         else
             tag = isPratLoaded and " [P]" or " [Party]"
         end
         output = arg1.." :"..playerLink..tag;

         local czystyArg = CH_Usun_Linki(arg1);
         tinsert(CH_BubblesArray, { [1] = czystyArg, [2] = czystyArg, [3] = 1 });
         CH_ctrFrame:SetScript("OnUpdate", CH_bubblizeText);      -- obsługa bubbles dla komunikatu SAY
      elseif (event == "CHAT_MSG_RAID") then
         local isPratLoaded = C_AddOns.IsAddOnLoaded("Prat-3.0")
         output = arg1.." :"..playerLink..(isPratLoaded and " [R]" or " [Raid]");
      elseif (event == "CHAT_MSG_RAID_LEADER") then
         local isPratLoaded = C_AddOns.IsAddOnLoaded("Prat-3.0")
         output = arg1.." :"..playerLink..(isPratLoaded and " [RL]" or " [Raid Leader]");
      elseif (event == "CHAT_MSG_RAID_WARNING") then
         local _, _size1, _ = RaidWarningFrameSlot1:GetFont(); -- Only need size
         -- Ensure RaidWarningFrames use the correct font
         RaidWarningFrameSlot1:SetFont(CH_Font, _size1);
         RaidWarningFrameSlot2:SetFont(CH_Font, _size1);
         local isPratLoaded = C_AddOns.IsAddOnLoaded("Prat-3.0")
         output = arg1.." :"..playerLink..(isPratLoaded and " [RW]" or " [Raid Warning]");
      elseif ((event == "CHAT_MSG_GUILD") or (event == "CHAT_MSG_OFFICER")) then
          local isPratLoaded = C_AddOns.IsAddOnLoaded("Prat-3.0")
          local tag = isPratLoaded and " [G]" or " [Guild]"
          if event == "CHAT_MSG_OFFICER" then
             tag = isPratLoaded and " [O]" or " [Officer]"
          end
         output = arg1.." :"..playerLink..tag;
      elseif ((event == "CHAT_MSG_BATTLEGROUND") or (event == "CHAT_MSG_BATTLEGROUND_LEADER")) then
         local tag = ""
         if event == "CHAT_MSG_BATTLEGROUND_LEADER" then
             tag = " [L]"
         end
         output = arg1.." :"..playerLink..tag;
      else
         return false;  -- wyświetlaj tekst oryginalny w oknie czatu
      end   

      self:AddMessage(colorText..CH_LineChat(output, _sizeC)); 
      return true;      -- nie wyświetlaj oryginalnego tekstu
   else
      return false;     -- wyświetlaj tekst oryginalny w oknie czatu
   end   
end

-------------------------------------------------------------------------------------------------------

local function CH_AR_ON_OFF()       -- funkcja włącz/wyłącza tryb arabski
   local txt = DEFAULT_CHAT_FRAME.editBox:GetText();
   if (CH_ED_mode == 0) then        -- mamy tryb EN - przełącz na tryb arabski
      DEFAULT_CHAT_FRAME.editBox:SetJustifyH("RIGHT");
      DEFAULT_CHAT_FRAME.editBox:SetCursorPosition(0);         -- przesuń kursor na skrajne lewo
      CH_ToggleButton:SetNormalFontObject("GameFontNormal");   -- litery AR żółte
      CH_ToggleButton:SetText("AR");
      CH_ToggleButton2:SetNormalFontObject("GameFontNormal");  -- litery AR żółte
      CH_ToggleButton2:SetText("AR");
      CH_ED_mode = 1;
      CH_BuforCursor = 0;
      CH_ED_cursor_move = 1;
      CH_InsertButton:SetText("←");
      CH_InsertButton:Show();
   else                             -- mamy tryb arabski - przełącz na tryb angielski
      DEFAULT_CHAT_FRAME.editBox:SetJustifyH("LEFT");
      CH_ToggleButton:SetNormalFontObject("GameFontRed");      -- litery EN czerwone
      CH_ToggleButton:SetText("EN");
      CH_ToggleButton2:SetNormalFontObject("GameFontRed");     -- litery EN czerwone
      CH_ToggleButton2:SetText("EN");
      CH_ED_mode = 0;
      if ((CH_BuforLength > 0) and (CH_BuforEditBox[CH_BuforLength] >= "؀")) then   -- pierwszym znakiem z prawej strony jest litera arabska
         DEFAULT_CHAT_FRAME.editBox:SetCursorPosition(0);      -- przesuń kursor na skrajne lewo
         CH_BuforCursor = 0;
         CH_ED_cursor_move = 1;
      else
         DEFAULT_CHAT_FRAME.editBox:SetCursorPosition(strlen(txt));      -- przesuń kursor na skrajne prawo
         CH_BuforCursor = CH_BuforLength;
         CH_ED_cursor_move = 0;
         CH_InsertButton:SetText("→");
         CH_InsertButton:Hide();
      end
   end
   if (strlen(txt) == 0) then    -- przy komendzie /w Player trzeba wyzerować tę komendę
      CH_BuforEditBox = {};
      CH_BuforLength = 0;
      CH_BuforCursor = 0;
   end
   ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox);
   DEFAULT_CHAT_FRAME.editBox:SetFocus();
end

-------------------------------------------------------------------------------------------------------

local function CH_INS_ON_OFF()            -- funkcja przełącza przesuwanie kursora w zależności od wprowadzonej litery
   if (CH_ED_cursor_move == 1) then       -- mamy tryb przesuwania kursowa na lewo
      CH_InsertButton:SetText("→");
      CH_ED_cursor_move = 0;              -- włącz tryb przesuwania na prawo od wpisanego znaku
   else
      CH_InsertButton:SetText("←");
      CH_ED_cursor_move = 1;              -- włącz tryb przesuwania w lewo od wpisanego znaku
   end
   DEFAULT_CHAT_FRAME.editBox:SetFocus();
   CH_InsertButton:Show();
end

-------------------------------------------------------------------------------------------------------

function CH_Oblicz_Pozycje(curs)        -- oblicza pozycję (bytes) cursora w oknie edycji
   local pozycja = 0;
   if (CH_ED_cursor_move == 1) then    -- mamy tryb przesuwania w lewo (litera arabska)
      curs = curs - 1;
   end
   for i = 1, curs do
      pozycja = pozycja + strlen(CH_BuforEditBox[i]);   -- liczba bajtów znaku
   end
   return pozycja;
end

-------------------------------------------------------------------------------------------------------

local function CH_OnShow()       -- otworzony został editBox
   if (CH_PM["active"]=="1") then
      CH_ToggleButton2:Show();
   else
      CH_ToggleButton2:Hide();
      return;
   end
--   if (not CH_ToggleButton:IsVisible()) then
--      CH_ToggleButton2:Show();
--   end
   CH_BuforEditBox = {};
   CH_BuforLength = 0;
   CH_BuforCursor = 0;
   CH_last_letter = "";
   if (CH_ED_mode == 1) then     -- tryb arabski
      CH_ED_cursor_move = 1;     -- przesuwanie w lewo
      CH_InsertButton:SetText("←");
   else                          -- tryb angielski
      CH_ED_cursor_move = 0;     -- przesuwanie w prawo
      CH_InsertButton:SetText("→");
   end
end

-------------------------------------------------------------------------------------------------------

local function CH_OnHide()       -- został zamknięty editBox
   if (CH_PM["active"]=="0") then
      return;
   end
   CH_ToggleButton2:Hide();
   CH_ToggleButton:Enable();
   CH_ToggleButton2:Enable();
end
   
-------------------------------------------------------------------------------------------------------

function CH_GetIsolatedLetterForm(ch)
   local retu = ch;
   local rules = AS_Reshaping_Rules[ch];
   if rules then
      retu = rules.isolated;
      if AS_UTF8len(retu) > 1 then   -- we have 2 Arabic letters in isolated form
         CH_BuforLength = CH_BuforLength + 1;
         CH_BuforEditBox[CH_BuforLength] = AS_UTF8sub(retu, 1, 1);
         retu = AS_UTF8sub(retu, 2, 2);
      end
   end
   return retu;
end

-------------------------------------------------------------------------------------------------------

local function CH_Insert_Text_to_Buffer(s)
   CH_BuforEditBox = {};
   CH_BuforLength = 0;
   local bytes = strlen(s);
   local pos = 1;
   local char1, char2;
   local charbytes1, charbytes2;
   local is_link = false;
   local newstr = "";
   while (pos <= bytes) do
      charbytes1 = AS_UTF8charbytes(s, pos);         -- count of bytes (liczba bajtów znaku)
      char1 = strsub(s, pos, pos + charbytes1 - 1);  -- current character
      pos = pos + charbytes1;
      if (pos <= bytes) then
         charbytes2 = AS_UTF8charbytes(s, pos);         -- count of bytes (liczba bajtów znaku)
         char2 = strsub(s, pos, pos + charbytes2 - 1);  -- next character
      else
         char2 = "";
         charbytes2 = 0;
      end
      if (char1..char2 == "|c") then    -- zaczyna się link od definicji koloru
         is_link = true;
      end
      if (char1..char2 == "|r") then    -- kończy się link od przywrócenia koloru
         is_link = false;
         newstr = newstr .. '|r';
         CH_BuforLength = CH_BuforLength + 1;
         CH_BuforEditBox[CH_BuforLength] = newstr;
         newstr = "";
         pos = pos + charbytes2;
      end
      if (is_link) then       -- poszczegójne znaki linku
         newstr = newstr .. char1;
      else                    -- wprowadzamy do bufora poszczególne znaku w pola edycji
         CH_BuforLength = CH_BuforLength + 1;
         CH_BuforEditBox[CH_BuforLength] = CH_GetIsolatedLetterForm(char1);
      end
   end
end

-------------------------------------------------------------------------------------------------------

local function CH_OnChar(self, character)    -- wprowadzono znak litery z klawiatury
   if (CH_PM["active"]=="0") then
      return;
   end
   if (CH_ToggleButton:IsEnabled()) then
      if (CH_highlight_text) then            -- mamy podświetlony tekst i wciśnięto cyfrę lub literę
         self:SetText(character);            -- wyzeruj pole edycji i wprowadź character
         self:SetCursorPosition(0);
         CH_BuforEditBox= {};
         CH_BuforLength = 0;
         CH_BuforCursor = 0;
         CH_highlight_text = false;
         if (CH_ED_mode == 0) then
            CH_ToggleButton:SetNormalFontObject("GameFontRed");      -- litery EN czerwone
         else
            CH_ToggleButton:SetNormalFontObject("GameFontNormal");   -- litery AR żółte
         end
      end
      CH_BuforLength = CH_BuforLength + 1;      -- bufor powiększył się o 1 element
      if (CH_BuforLength == 1) then             -- pierwsza litera w edytorze
         tinsert(CH_BuforEditBox, 1, character);
         CH_BuforCursor = 1;                    -- kursor na pierwszym znaku
         if (((character >= "؀") and (character <= "ݿ")) or ((string.sub(character,1,1) == "|") and (CH_ED_mode == 1))) then   -- mamy literę arabską
            self:SetCursorPosition(0);
            CH_ED_cursor_move = 1;              -- włącz przesuwanie w lewo
            CH_InsertButton:SetText("←");
            CH_InsertButton:Show();
         else
            self:SetCursorPosition(AS_UTF8charbytes(character));
            CH_ED_cursor_move = 0;              -- włącz przesuwanie w prawo
            if (CH_ED_mode == 1) then
               CH_InsertButton:SetText("→");
               CH_InsertButton:Show();
            end
         end
      else                                      -- wprowadzono kolejną literę
         if (CH_ED_cursor_move == 1) then       -- mamy tryb przesuwania w lewo (litera arabska)
            if (CH_BuforCursor == 0) then
               CH_BuforCursor = 1;              -- tylko gdy = 0
            end
            tinsert(CH_BuforEditBox, CH_BuforCursor, character);
         else                                   -- tu jest tryb przesuwania w prawo (litera łacińska)
            if (CH_BuforCursor < CH_BuforLength) then
               CH_BuforCursor = CH_BuforCursor + 1;   -- aktualna pozycja kursora
            end
            tinsert(CH_BuforEditBox, CH_BuforCursor, character);
         end
         local spaces = "( )?؟!,.;:،";             -- letters that we treat as a space
         if (AS_UTF8find(spaces, character) == false) then       -- nie wprowadzono znaku z listy spaces      
            if (((character >= "؀") and (character <= "ݿ")) or ((string.sub(character,1,1) == "|") and (CH_ED_mode == 1))) then  -- mamy literę arabską
               if (CH_ED_cursor_move == 0) then    -- mamy tryb przesuwania w prawo - przełącz na tryb przesuwania w lewo od wpisanego znaku
                  CH_INS_ON_OFF();                 -- zmień na przesuwanie w lewo
               end
            else                                                 -- wprowadzono literę inną niż arabska
               if (CH_ED_cursor_move == 1) then    -- mamy tryb przesuwania w lewo - przełącz na tryb przesuwania w prawo od wpisanego znaku
                  CH_INS_ON_OFF();
               end
            end
         end
         local newtext = "";
         if (CH_ED_mode == 1) then        -- tryb arabski: reshaping text into editBox
            for i = CH_BuforLength, 1, -1 do
               if (string.sub(CH_BuforEditBox[i],1,1) == "|") then           -- mamy tu link do przedmiotu
                  newtext = newtext .. CH_UTF8reverse(CH_BuforEditBox[i]);   -- trzeba odwrócić znaki w linku
               else
                  newtext = newtext .. CH_BuforEditBox[i];
               end
            end
            newtext = AS_UTF8reverseRS(newtext);     -- odwróć kolejność liter + ReShaping
         else
            for i = 1, CH_BuforLength do
               newtext = newtext .. CH_BuforEditBox[i];
            end
         end
         self:SetText(newtext);
         self:SetCursorPosition(CH_Oblicz_Pozycje(CH_BuforCursor));
      end
      CH_last_letter = character;
   end
end

-------------------------------------------------------------------------------------------------------

local function CH_OnKeyDown(self, key)    -- wciśnięto klawisz key: spradź czy wciśnięto BACKSPACE lub DELETE
   if (CH_PM["active"]=="0") then
      return;
   end
   if ((key == "LCTRL") or (key == "RCTRL")) then        -- wciśnięta klawisz CONTROL
      CH_key_ctrl = true;
   elseif ((key == "LSHIFT") or (key == "RSHIFT")) then  -- wciśnięta klawisz SHIFT
      CH_key_shift = true;
   elseif ((key == "LALT") or (key == "RALT")) then      -- wciśnięta klawisz ALT
      CH_key_alt = true;
   end
   if (CH_key_ctrl and (key == "A") and (strlen(self:GetText())>0)) then  -- wciśnięto klawisze Ctrl+A: zaznaczono tekst w editBox
      CH_highlight_text = true;
      CH_ToggleButton:SetNormalFontObject("GameFontBlack");   -- litery EN/AR czarne
   end
   if (CH_ToggleButton:IsEnabled()) then                 -- obsługa bufora włączona?
      if (CH_ED_mode == 1) then        -- mamy tryb arabski
         if (key == "BACKSPACE") then  -- usuń znak poprzedzający, czyli 1 na prawo
            local buf = self:GetText();              -- cały tekst
            local pos = self:GetCursorPosition();    -- aktualna pozycja kursora
            if (strlen(buf) > 0) then                -- nie jest to pusty tekst
               if (pos < strlen(buf)) then           -- kursor nie jest na początku tekstu, skrajnie na prawo
                  local charbytes = AS_UTF8charbytes(buf, pos+1);   -- liczba bajtów 1 znaku w pozycji pos
                  self:SetCursorPosition(pos+charbytes);    -- przesuń kursor o 1 znak w prawo, aby usunięcie było tego znaku
               else                                         -- nic nie usuwaj, jesteś na początku tekstu, skrajnie na prawo
                  self:SetText(buf.." ");                   -- dodaj spację na początku, skrajnie na prawo
                  self:SetCursorPosition(strlen(buf)+1);    -- przesuń kursor na początek tekstu w prawo, aby usunąć tę spację
                  CH_BuforCursor = CH_BuforLength + 1;
               end
            end
  
            if (CH_BuforLength == 1) then               -- pierwszy znak z buforze
               tremove(CH_BuforEditBox, 1);
               CH_BuforCursor = 0;
               CH_BuforLength = 0;
            elseif (CH_BuforCursor <= CH_BuforLength) then
               if (CH_BuforCursor < 2) then
                  tremove(CH_BuforEditBox, 1);
               else
                  tremove(CH_BuforEditBox, CH_BuforCursor);
               end
               if (CH_BuforLength > 0) then
                  CH_BuforLength = CH_BuforLength - 1;
               end
            end
            
         elseif (key == "DELETE") then                -- usuń znak następujący, czyli 1 na lewo
            local buf = self:GetText();
            local pos = self:GetCursorPosition();
            if (pos > 0) then                         -- kursor nie jest na końcu tekstu, skrajnie w lewo
               -- ustal znak z lewej strony
--               if (pos == strlen(buf)) then           -- kursor jest skrajnie na prawo
                  pos = pos - 1;
                  if (pos > 0) then
                     local c = strbyte(buf, pos);
                     while (c >= 128 and c <= 191) do
                        pos = pos - 1;
                        c = strbyte(buf, pos);
                     end
                  end
--               end
               pos = pos - 1;
               if (pos > 0) then
                  local c = strbyte(buf, pos);
                  while (c >= 128 and c <= 191) do
                     pos = pos - 1;
                     c = strbyte(buf, pos);
                  end
               end
               self:SetCursorPosition(pos);    -- przesuń kursor o 1 znak w lewo, aby usunięcie było tego znaku
            else                             -- kursor jest na końcu tekstu, nie ma co usuwać - dodaj spację na końcu
               self:SetText(" "..buf);
               self:SetCursorPosition(0);    -- przesuń kursor na koniec tekstu w lewo, aby usunąć tę spację
               CH_BuforCursor = 1;
            end
            if (CH_BuforCursor > 1) then
               tremove(CH_BuforEditBox, CH_BuforCursor-1);
               CH_BuforCursor = CH_BuforCursor - 1;
               CH_BuforLength = CH_BuforLength - 1;
            end
         end
         
      else           -- mamy tryb angielski
         if (key == "DELETE") then                -- usuń bieżący znak z bufora
            if (CH_BuforLength > CH_BuforCursor) then
               if (self:GetCursorPosition() == 0) then
                  tremove(CH_BuforEditBox, 1);
               else
                  tremove(CH_BuforEditBox, CH_BuforCursor+1);
               end
               CH_BuforLength = CH_BuforLength - 1;
            elseif (CH_BuforLength == 0) then
               CH_BuforCursor = 0;
            end
         elseif (key == "BACKSPACE") then         -- usuń znak poprzedzający, czyli 1 na lewo
            if (CH_BuforCursor > 0) then
               tremove(CH_BuforEditBox, CH_BuforCursor);
               CH_BuforCursor = CH_BuforCursor - 1;
               CH_BuforLength = CH_BuforLength - 1;
            end
         end
      end
      if ((key == "ENTER") and (CH_ED_mode == 1)) then                    -- wciśnięto klawisz ENTER
         local newtext = "";
         for i = CH_BuforLength, 1, -1 do
            if (string.sub(CH_BuforEditBox[i],1,1) == "|") then           -- mamy tu link do przedmiotu
               newtext = newtext .. CH_UTF8reverseRS(CH_BuforEditBox[i]);   -- trzeba odwrócić znaki w linku przedmiotu
            else
               newtext = newtext .. CH_BuforEditBox[i];
            end
         end
         newtext = AS_UTF8reverseRS(newtext);       -- odwróć kolejność liter + ReShaping
         self:SetText(newtext);
      end
   end
end

-------------------------------------------------------------------------------------------------------

local function CH_OnKeyUp(self, key)      -- puszczono klawisz key: sprawdź czy wciśnięto HOME, END, LEFT i RIGHT
   if (CH_PM["active"]=="0") then
      return;
   end
   if ((CH_key_shift and ((key == "LALT") or (key == "RALT"))) or (CH_key_alt and ((key == "LSHIFT") or (key == "RSHIFT")))) then
      CH_AR_ON_OFF();                                    -- wciśnięto jednocześnie klawisze SHIFT+ALT
   end
   if ((key == "LCTRL") or (key == "RCTRL")) then        -- puszczono klawisz CONTROL
      CH_key_ctrl = false;
   elseif ((key == "LSHIFT") or (key == "RSHIFT")) then  -- puszczono klawisz SHIFT
      CH_key_shift = false;
   elseif ((key == "LALT") or (key == "RALT")) then      -- puszczono klawisz ALT
      CH_key_alt = false;
   end
   if (CH_ToggleButton:IsEnabled()) then
      if (CH_key_ctrl and ((key == "V") or (key == "N"))) then    -- wklejono dane ze schowka, lub z historii bufora
      -- trzeba wprowadzić nowe dane do bufora
         local act_pos = self:GetCursorPosition();
         CH_Insert_Text_to_Buffer(self:GetText());
         if (CH_ED_cursor_move == 1) then       -- mamy tryb arabski
            CH_BuforCursor = 0;
            self:SetCursorPosition(0);          -- ustaw kursor skrajnie na lewo
         else
            self:SetCursorPosition(strlen(self:GetText()));
            CH_BuforCursor = CH_BuforLength + 1;
         end
         return;
      end
      if (CH_ED_mode == 1) then        -- mamy tryb arabski
         if (key == "HOME") then       -- skocz kursorem na początek tekstu, czyli na skrajne prawo
            self:SetCursorPosition(strlen(self:GetText()));
            CH_BuforCursor = CH_BuforLength + 1;
            CH_ED_cursor_move = 1;
            CH_InsertButton:SetText("←");
         elseif (key == "END") then    -- skocz kursorem na koniec tekstu, czyli na skrajne lewo
            self:SetCursorPosition(0);
            CH_BuforCursor = 1;
            CH_ED_cursor_move = 1;
            CH_InsertButton:SetText("←");
         end
      else                             -- mamy tryb angielski
         if (key == "HOME") then       -- skocz kursorem na początek tekstu, czyli na skreajne lewo
            CH_BuforCursor = 0;
            CH_ED_cursor_move = 0;
            CH_InsertButton:SetText("→");
         elseif (key == "END") then    -- skocz kursorem na koniec tekstu, czyli na skrajne prawo
            CH_BuforCursor = CH_BuforLength;
            CH_ED_cursor_move = 0;
            CH_InsertButton:SetText("→");
         end
      end
      if ((key == "LEFT") and (CH_BuforCursor > CH_ED_mode)) then       -- wciśnięto klawisz "strzałka w lewo" alt+LEFT
         CH_BuforCursor = CH_BuforCursor - 1;      -- dopuszczamy: Cursor == 0 dla CH_ED_mode == 0
      end
      if ((key == "RIGHT") and (CH_BuforCursor-CH_ED_mode < CH_BuforLength)) then    -- wciśnięto klawisz "strzałka w prawo" alt+RIGHT
         CH_BuforCursor = CH_BuforCursor + 1;      -- dopuszczamy: Cursor+1 od Length dla CH_ED_mode == 1
      end
   end
   if (strlen(self:GetText()) == 0) then    -- profilaktycznie trzeba wyzerować bufor
      CH_BuforEditBox = {};
      CH_BuforLength = 0;
      CH_BuforCursor = 0;
   end
   if (CH_on_debug) then
      local aaa = "";
      for i = 1, CH_BuforLength, 1 do
         aaa = aaa.." "..CH_BuforEditBox[i];
      end
      print("BuforLength="..CH_BuforLength,"BuforCursor="..CH_BuforCursor,"Data:"..aaa);
   end
end
  
-------------------------------------------------------------------------------------------------------

local function CH_SlashCommand(msg)
  -- check the command
  if (msg) then
     local CH_command = string.lower(msg);                -- normalizacja, tylko małe litery
     if ((CH_command=="on") or (CH_command=="1")) then    -- włącz przełącznik aktywności
        CH_PM["active"]="1";
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00WoWinArabic-Chat is active now");
     elseif ((CH_command=="off") or (CH_command=="0")) then
        CH_PM["active"]="0";
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00WoWinArabic-Chat is inactive now");
     else
        Settings.OpenToCategory("WoWinArabic-Chat");
     end   
  end
end

-------------------------------------------------------------------------------------------------------

function CHAT_START()
   -- Hook SetFont to force our Arabic font and preserve the requested height/flags
   local function HookSetFontToForceArabic(frameOrEditBox)
       if not frameOrEditBox or type(frameOrEditBox.SetFont) ~= "function" then return end
       
       -- Store original SetFont function if not already stored
       if not frameOrEditBox.originalSetFont_WoWinArabic then
           frameOrEditBox.originalSetFont_WoWinArabic = frameOrEditBox.SetFont
       end
       
       -- Override SetFont with our protected version
       frameOrEditBox.SetFont = function(self, fontPath, fontHeight, fontFlags)
           -- Always use our font, but keep requested height/flags
           self.originalSetFont_WoWinArabic(self, CH_Font, fontHeight, fontFlags)
       end
   end
   
   -- Function to periodically check and restore our font if changed
   local function CreateFontGuardian()
       local fontGuardian = CreateFrame("Frame")
       fontGuardian.frameConfigs = {}
       
       -- Store initial configuration for a frame/editbox
       fontGuardian.Register = function(self, frame, size, flags)
           if not frame then return end
           self.frameConfigs[frame] = {size = size, flags = flags}
       end
       
       -- Check and restore fonts periodically
       fontGuardian:SetScript("OnUpdate", function(self, elapsed)
           self.timeSinceLastCheck = (self.timeSinceLastCheck or 0) + elapsed
           if self.timeSinceLastCheck < 1 then return end -- Check once per second
           
           self.timeSinceLastCheck = 0
           for frame, config in pairs(self.frameConfigs) do
               -- Check if frame is still valid using safer method
               if frame and frame.GetFont then
                   local success, currentFont, currentSize, currentFlags = pcall(frame.GetFont, frame)
                   if success and currentFont ~= CH_Font then
                       -- Font was changed by something else, restore it
                       pcall(frame.SetFont, frame, CH_Font, config.size, config.flags)
                   end
               else
                   -- Frame no longer valid, remove from tracking
                   self.frameConfigs[frame] = nil
               end
           end
       end)
       
       return fontGuardian
   end
   
   -- Create our font guardian
   local fontGuardian = CreateFontGuardian()
   
   -- Get initial font settings
   local _, frameSize, frameFlags = DEFAULT_CHAT_FRAME:GetFont()
   local _, editBoxSize, editBoxFlags = DEFAULT_CHAT_FRAME.editBox:GetFont()
   
   -- Setup DEFAULT_CHAT_FRAME
   DEFAULT_CHAT_FRAME:SetFont(CH_Font, frameSize, frameFlags)
   HookSetFontToForceArabic(DEFAULT_CHAT_FRAME)
   fontGuardian:Register(DEFAULT_CHAT_FRAME, frameSize, frameFlags)
   
   -- Setup DEFAULT_CHAT_FRAME.editBox
   DEFAULT_CHAT_FRAME.editBox:SetFont(CH_Font, editBoxSize, editBoxFlags)
   DEFAULT_CHAT_FRAME.editBox:SetScript("OnChar", CH_OnChar)
   DEFAULT_CHAT_FRAME.editBox:SetScript("OnKeyDown", CH_OnKeyDown)
   DEFAULT_CHAT_FRAME.editBox:SetScript("OnKeyUp", CH_OnKeyUp)
   DEFAULT_CHAT_FRAME.editBox:SetScript("OnShow", CH_OnShow)
   DEFAULT_CHAT_FRAME.editBox:SetScript("OnHide", CH_OnHide)
   HookSetFontToForceArabic(DEFAULT_CHAT_FRAME.editBox)
   fontGuardian:Register(DEFAULT_CHAT_FRAME.editBox, editBoxSize, editBoxFlags)
   
   -- Setup other chat frames
   for i = 1, NUM_CHAT_WINDOWS do
       local frame = _G["ChatFrame" .. i]
       local editBox = _G["ChatFrame" .. i .. "EditBox"]
       
       if frame then
           local currentFrameSize, currentFrameFlags = select(2, frame:GetFont())
           frame:SetFont(CH_Font, currentFrameSize or frameSize, currentFrameFlags or frameFlags)
           HookSetFontToForceArabic(frame)
           fontGuardian:Register(frame, currentFrameSize or frameSize, currentFrameFlags or frameFlags)
       end
       
       if editBox then
           local currentEditBoxSize, currentEditBoxFlags = select(2, editBox:GetFont())
           editBox:SetFont(CH_Font, currentEditBoxSize or editBoxSize, currentEditBoxFlags or editBoxFlags)
           editBox:SetScript("OnChar", CH_OnChar)
           editBox:SetScript("OnKeyDown", CH_OnKeyDown)
           editBox:SetScript("OnKeyUp", CH_OnKeyUp)
           editBox:SetScript("OnShow", CH_OnShow)
           editBox:SetScript("OnHide", CH_OnHide)
           HookSetFontToForceArabic(editBox)
           fontGuardian:Register(editBox, currentEditBoxSize or editBoxSize, currentEditBoxFlags or editBoxFlags)
       end
   end
   
   -- Also hook SetFontObject to prevent indirect font changes
   local function HookSetFontObject(frame)
       if not frame or not frame.SetFontObject then return end
       
       if not frame.originalSetFontObject_WoWinArabic then
           frame.originalSetFontObject_WoWinArabic = frame.SetFontObject
       end
       
       frame.SetFontObject = function(self, fontObject)
           self.originalSetFontObject_WoWinArabic(self, fontObject)
           -- After applying the font object, force our font
           local _, height, flags = self:GetFont()
           self:SetFont(CH_Font, height, flags)
       end
   end
   
   -- Apply SetFontObject hook to all chat frames and edit boxes
   HookSetFontObject(DEFAULT_CHAT_FRAME)
   HookSetFontObject(DEFAULT_CHAT_FRAME.editBox)
   
   for i = 1, NUM_CHAT_WINDOWS do
       local frame = _G["ChatFrame" .. i]
       local editBox = _G["ChatFrame" .. i .. "EditBox"]
       
       if frame then HookSetFontObject(frame) end
       if editBox then HookSetFontObject(editBox) end
   end

   -- Rest of the original function (buttons, filters, etc.)
   
   CH_ToggleButton = CreateFrame("Button", nil, DEFAULT_CHAT_FRAME, "UIPanelButtonTemplate");
   CH_ToggleButton:SetWidth(34);
   CH_ToggleButton:SetHeight(20);
   CH_ToggleButton:SetNormalFontObject("GameFontRed");      -- litery EN czerwone
   CH_ToggleButton:SetText("EN");
   CH_ToggleButton:Show();
   CH_ToggleButton:ClearAllPoints();
   CH_ToggleButton:SetPoint("TOPRIGHT", DEFAULT_CHAT_FRAME, "BOTTOMLEFT", 1, -8);
   CH_ToggleButton:SetScript("OnClick", CH_AR_ON_OFF);

   CH_ToggleButton2 = CreateFrame("Button", nil, DEFAULT_CHAT_FRAME.editBox, "UIPanelButtonTemplate");
   CH_ToggleButton2:SetWidth(34);
   CH_ToggleButton2:SetHeight(20);
   CH_ToggleButton2:SetNormalFontObject("GameFontRed");      -- litery EN czerwone
   CH_ToggleButton2:SetText("EN");
   CH_ToggleButton2:Hide();
   CH_ToggleButton2:ClearAllPoints();
   CH_ToggleButton2:SetPoint("TOPRIGHT", DEFAULT_CHAT_FRAME.editBox, "TOPLEFT", 4, -4);
   CH_ToggleButton2:SetScript("OnClick", CH_AR_ON_OFF);

   CH_InsertButton = CreateFrame("Button", nil, DEFAULT_CHAT_FRAME.editBox, "UIPanelButtonTemplate");
   CH_InsertButton:SetWidth(28);
   CH_InsertButton:SetHeight(20);
   CH_InsertButton.Text:SetFont(CH_Font, 14, _C);
   CH_InsertButton:SetText("←");
   CH_InsertButton:Hide();
   CH_InsertButton:ClearAllPoints();
   if (Prat) then       -- jest aktywny dodatek Prat
      CH_InsertButton:SetPoint("TOPLEFT", DEFAULT_CHAT_FRAME.editBox, "TOPRIGHT", -2, -1);
   else
      CH_InsertButton:SetPoint("TOPLEFT", DEFAULT_CHAT_FRAME.editBox, "TOPRIGHT", -9, -6);
   end
   CH_InsertButton:SetScript("OnClick", CH_INS_ON_OFF);

   ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", CH_ChatFilter);
   ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", CH_ChatFilter);
   
   SlashCmdList["WOWAR"] = function(msg) CH_SlashCommand(msg); end
   SLASH_WOWINARABIC_CHAT1 = "/archat";
   if (CH_PM["active"]=="1") then
      CH_ToggleButton:Show();
   else
      CH_ToggleButton:Hide();
   end
--   CH_CheckVars();
--   CH_BlizzardOptions();
   
end

-------------------------------------------------------------------------------------------------------

function CH_CreateTestLine()
   CH_TestLine = CreateFrame("Frame", "CH_TestLine", UIParent, "BasicFrameTemplateWithInset");
   CH_TestLine:SetHeight(150);
   CH_TestLine:SetWidth(DEFAULT_CHAT_FRAME:GetWidth()+50);
   CH_TestLine:ClearAllPoints();
   CH_TestLine:SetPoint("TOPLEFT", 20, -300);
   CH_TestLine.title = CH_TestLine:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
   CH_TestLine.title:SetPoint("CENTER", CH_TestLine.TitleBg);
   CH_TestLine.title:SetText("Frame for testing width of text");
   CH_TestLine.ScrollFrame = CreateFrame("ScrollFrame", nil, CH_TestLine, "UIPanelScrollFrameTemplate");
   CH_TestLine.ScrollFrame:SetPoint("TOPLEFT", CH_TestLine.InsetBg, "TOPLEFT", 10, -40);
   CH_TestLine.ScrollFrame:SetPoint("BOTTOMRIGHT", CH_TestLine.InsetBg, "BOTTOMRIGHT", -5, 10);
  
   CH_TestLine.ScrollFrame.ScrollBar:ClearAllPoints();
   CH_TestLine.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", CH_TestLine.ScrollFrame, "TOPRIGHT", -12, -18);
   CH_TestLine.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", CH_TestLine.ScrollFrame, "BOTTOMRIGHT", -7, 15);
   CHchild = CreateFrame("Frame", nil, CH_TestLine.ScrollFrame);
   CHchild:SetSize(552,100);
   CHchild.bg = CHchild:CreateTexture(nil, "BACKGROUND");
   CHchild.bg:SetAllPoints(true);
   CHchild.bg:SetColorTexture(0, 0.05, 0.1, 0.8);
   CH_TestLine.ScrollFrame:SetScrollChild(CHchild);
   CH_TestLine.text = CHchild:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
   CH_TestLine.text:SetPoint("TOPLEFT", CHchild, "TOPLEFT", 2, 0);
   CH_TestLine.text:SetText("");
   CH_TestLine.text:SetSize(DEFAULT_CHAT_FRAME:GetWidth(),0);
   CH_TestLine.text:SetJustifyH("LEFT");
   CH_TestLine.CloseButton:SetPoint("TOPRIGHT", CH_TestLine, "TOPRIGHT", 0, 0);
   CH_TestLine:Hide();     -- the frame is invisible in the game
end

-------------------------------------------------------------------------------------------------------

-- function formats arabic text for display in a left-justified chat line
function CH_LineChat(txt, font_size)
   local retstr = "";
  
   if (txt and font_size) then
      if (CH_TestLine == nil) then     -- a own frame for displaying the translation of texts and determining the length
         CH_CreateTestLine();
      end   
      local bytes = strlen(txt);
      local pos = bytes;
      local counter = 0;
      local second = 0;
      local link_start_stop = false;
      local newstr = "";
      local nextstr = "";
      local charbytes;
      local newstrR;
      local char1 = "";
      local char2 = "";
      local last_space = 0;
      while (pos > 0) do       -- UWAGA: tekst arabski jest podany wprost, od prawej: sprawdzaj długość od prawej
         c = strbyte(txt, pos);
         while (c >= 128) and (c <= 191) do
            pos = pos - 1;
            c = strbyte(txt, pos);
         end
      
         charbytes = AS_UTF8charbytes(txt, pos);
         char1 = strsub(txt, pos, pos + charbytes - 1);

         newstr = char1 .. newstr;        -- sprawdzamy znaki od ostatnich
         
         if ((char1..char2 == "|r") and (pos < bytes)) then          -- start of the link
            link_start_stop = true;
         elseif ((char1..char2 == "|c") and (pos < bytes)) then      -- end of the link
            link_start_stop = false;
         end
         
         if ((char1 == " ") and (link_start_stop == false)) then     -- mamy spację, nie wewnątrz linku
            last_space = 0;
            nextstr = "";
         else
            nextstr = char1 .. nextstr;
            last_space = last_space + 1;
         end
         if (link_start_stop == false) then           -- nie jesteśmy wewnątrz linku - można sprawdzać
            if (Prat) then       -- jest aktywny dodatek Prat
               CH_TestLine.text:SetWidth(DEFAULT_CHAT_FRAME:GetWidth()-(0.35*font_size+0.8)*10);     -- czas w dodatku Prat zabiera nam miejsce
            else
               CH_TestLine.text:SetWidth(DEFAULT_CHAT_FRAME:GetWidth());
            end
            CH_TestLine.text:SetText(newstr);
            if (CH_TestLine.text:GetHeight() > font_size*1.5) then   -- tekst nie mieści się już w 1 linii
               newstr = AS_UTF8sub(newstr, last_space+1);            -- tekst od ostatniej spacji
               newstrR = CH_AddSpaces(newstr, second);
               retstr = retstr .. newstrR .. "\n";
               newstr = nextstr;
               nextstr = "";
               counter = 0;
               second = 3;  
            end
         end
         char2 = char1;    -- zapamiętaj znak, potrzebne w następnej pętli
         pos = pos - 1;
      end
      newstrR = CH_AddSpaces(newstr, second);
      retstr = retstr .. newstrR;
      retstr = string.gsub(retstr, " \n", "\n");        -- space before newline code is useless
      retstr = string.gsub(retstr, "\n ", "\n");        -- space after newline code is useless
   end
   return retstr;
end

-------------------------------------------------------------------------------------------------------

-- the function appends spaces to the left of the given text so that the text is aligned to the right
function CH_AddSpaces(txt, snd)                                 -- snd = second or next line (interspace 2 on right)
   local _fontC, _sizeC, _C = DEFAULT_CHAT_FRAME:GetFont();     -- read current font, size and flag of the chat object
   local chars_limitC = 300;    -- so much max. characters can fit on one line
   
   if (CH_TestLine == nil) then     -- a own frame for displaying the translation of texts and determining the length
      CH_CreateTestLine();
   end   
   if ((Prat) and (snd==0)) then       -- jest aktywny dodatek Prat
      CH_TestLine.text:SetWidth(DEFAULT_CHAT_FRAME:GetWidth()-(0.35*_sizeC+0.8)*10);     -- czas w dodatku Prat zabiera nam miejsce
   else
      CH_TestLine.text:SetWidth(DEFAULT_CHAT_FRAME:GetWidth());
   end
   CH_TestLine.text:SetFont(_fontC, _sizeC, _C);
   CH_TestLine:Hide();     -- the frame is invisible in the game
   local count = 0;
   local text = txt;
   CH_TestLine.text:SetText(text);
   while ((CH_TestLine.text:GetHeight() < _sizeC*1.5) and (count < chars_limitC)) do
      count = count + 1;
      text = " "..text;
      CH_TestLine.text:SetText(text);
   end
   if (count < chars_limitC) then    -- failed to properly add leading spaces
      for i=4,count-snd,1 do         -- spaces are added to the left of the text
         txt = " "..txt;
      end
   end
   CH_TestLine.text:SetText(txt);
   
   return(txt);
end

-------------------------------------------------------------------------------------------------------

-- Reverses the order of UTF-8 letters, without arabic reshaping
function CH_UTF8reverse(s)
   local newstr = "";
   if (s) then                                   -- check if argument is not empty (nil)
      local bytes = strlen(s);
      local pos = 1;
      local char1;
      local charbytes1;

      while (pos <= bytes) do
         charbytes1 = AS_UTF8charbytes(s, pos);         -- count of bytes (liczba bajtów znaku)
         char1 = strsub(s, pos, pos + charbytes1 - 1);  -- current character
         pos = pos + charbytes1;
         newstr = char1 .. newstr;
      end
   end
   return newstr;
end

-------------------------------------------------------------------------------------------------------

function CH_mysplit(inputstr, sep)
   if (sep == nil) then
      sep = "%s";
   end
   local t={};
   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str);
   end
   return t;
end

-------------------------------------------------------------------------------------------------------

function CH_SpecifyBubbleWidth(str_txt, reg)
   local vlines = CH_mysplit(str_txt,"\n");
   local _fontR, _sizeR, _R = reg:GetFont();   -- odczytaj aktualną czcionkę i rozmiar
   local max_width = 20;
   for _, v in ipairs(vlines) do 
      if (CH_TestLine == nil) then     -- a own frame for displaying the translation of texts and determining the length
         CH_CreateTestLine();
      end   
      CH_TestLine:Hide();     -- the frame is invisible in the game
      CH_TestLine.text:SetFont(_fontR, _sizeR, _R);
      local newTextWidth = (0.35*act_font+0.8)*AS_UTF8len(v)*1.5;  -- maksymalna szerokość okna dymku
      CH_TestLine.text:SetWidth(newTextWidth);
      CH_TestLine.text:SetText(v);
      local minTextWidth = (0.35*act_font+0.8)*AS_UTF8len(v)*0.8;  -- minimalna szerokość ograniczająca pętlę
      
      while ((CH_TestLine.text:GetHeight() < _sizeR*1.5) and (minTextWidth < newTextWidth)) do
         newTextWidth = newTextWidth - 5;
         CH_TestLine.text:SetWidth(newTextWidth);
      end
      if (newTextWidth > max_width) then
         max_width = newTextWidth;
      end
   end
   return max_width + 5;
end

-------------------------------------------------------------------------------------------------------

-- Reverses the order of UTF-8 letters in (limit) lines: 2 or 3 
function CH_LineReverse(s, limit)
   local retstr = "";
   if (s and limit) then                           -- check if arguments are not empty (nil)
      local bytes = strlen(s);
      local count_chars = AS_UTF8len(s);           -- number of characters in a string s
      local limit_chars = count_chars / limit;     -- limit characters on one line (+-)
      local pos = bytes;
      local charbytes;
      local newstr = "";
      local counter = 0;
      local char1;
      while (pos > 0) do
         c = strbyte(s, pos);                      -- read the character (odczytaj znak)
         while c >= 128 and c <= 191 do
            pos = pos - 1;                         -- cofnij się na początek litery UTF-8
            c = strbyte(s, pos);
         end
         charbytes = AS_UTF8charbytes(s, pos);    -- count of bytes (liczba bajtów znaku)
         char1 = strsub(s, pos, pos + charbytes - 1);
         newstr = char1 .. newstr;
         
         counter = counter + 1;
         if ((char1 >= "A") and (char1 <= "z")) then
            counter = counter + 1;        -- latin letters are 2x wider, then Arabic
         end
         if ((char1 == " ") and (counter>=limit_chars-3)) then      -- break line here
            retstr = retstr .. newstr .. "\n";
            newstr = "";
            counter = 0;
         end
      pos = pos - 1;
      end
      retstr = retstr .. newstr;
      retstr = string.gsub(retstr, "\n ", "\n");        -- space after newline code is useless
   end
	return retstr;
end 