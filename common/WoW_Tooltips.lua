-- Description: The AddOn displays the translated text information in chosen language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
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
local ST_load3 = false;
local ST_load4 = false;
local ST_load5 = false;
local ST_load6 = false;
local ST_load7 = false;
local ST_load8 = false;
local ST_load9 = false;
local ST_load10 = false;
local ST_firstBoss = true;
local ST_nameBoss = { };
local ST_navBar1, ST_navBar2, ST_navBar3, ST_navBar4, ST_navBar5 = false;

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

function ST_CheckAndReplaceTranslationText(obj, sav, prefix, font1, onlyReverse, ST_corr)     -- obj=object with stingtext,  sav=permission to save untranstaled tekst (true/false)
   if (obj and obj.GetText) then                                        -- prefix=text to save group,  font1=if present:SetFont to given font file,  onlyReverse=use only Reverse function
      local txt = obj:GetText();                                        -- Font Files: WOWTR_Font1, Original_Font1, Original_Font2     ST_corr=changing the width of the object to the translation text 
      if (txt and string.find(txt," ")==nil) then
         local ST_Hash = StringHash(ST_UsunZbedneZnaki(txt));
         if (ST_TooltipsHS[ST_Hash]) then
            local a1, a2, a3 = obj:GetFont();
            if (not ST_corr) then
               ST_corr = 0;
            end
            if (font1) then
               obj:SetFont(font1, a2);
               if (onlyReverse) then
                  obj:SetText(QTR_ReverseIfAR(ST_TranslatePrepare(txt, ST_TooltipsHS[ST_Hash])).." ");        -- hard space at the end of translation
               else
                  obj:SetText(QTR_ExpandUnitInfo(ST_TranslatePrepare(txt, ST_TooltipsHS[ST_Hash]),false,obj,font1,ST_corr).." ");        -- hard space at the end of translation
               end
            else
               obj:SetFont(WOWTR_Font2, a2);
               if (onlyReverse) then
                  obj:SetText(QTR_ReverseIfAR(ST_TranslatePrepare(txt, ST_TooltipsHS[ST_Hash])).." ");        -- hard space at the end of translation
               else
                  obj:SetText(QTR_ExpandUnitInfo(ST_TranslatePrepare(txt, ST_TooltipsHS[ST_Hash]),false,obj,WOWTR_Font2,ST_corr).." ");  -- hard space at the end of translation
               end
            end
         elseif (sav and (ST_PM["saveNW"]=="1")) then
            ST_PH[ST_Hash] = prefix.."@"..ST_PrzedZapisem(txt);
         end
      end
   end
end
-------------------------------------------------------------------------------------------------------
function ST_CheckAndReplaceTranslationTextUI(obj, sav, prefix, font1)     -- obj=object with stingtext,  sav=permission to save untranstaled tekst (true/false)
   if (obj and obj.GetText) then                                          -- prefix=text to save group,  font1=if present:SetFont to given font file
      local txt = obj:GetText();                                          -- Font Files: WOWTR_Font1, Original_Font1, Original_Font2
      if (txt and string.find(txt, " ") == nil) then
         local ST_Hash = StringHash(ST_UsunZbedneZnaki(txt));
         local destroyText = "Do you want to destroy";
         local deleteText = "DELETE";
         
         if (string.sub(txt, 1, #destroyText) == destroyText) then
            if (string.find(txt, deleteText)) then
               ST_Hash = 1479612176;
            else
               ST_Hash = 1202097063;
            end
         end
         
         if (ST_TooltipsHS[ST_Hash]) then             -- we have translation for this text
            local a1, a2, a3 = obj:GetFont();
            local new_trans = ST_TooltipsHS[ST_Hash];
            if ((ST_Hash == 1479612176) or (ST_Hash == 1202097063)) then
               local pos_end = string.find(txt, "?");
               if (pos_end) then
                  local new_item = string.sub(txt, #destroyText + 2, pos_end - 1);
                  new_trans = string.gsub(new_trans, "$I", new_item);                   -- change name of item in the place of code $I in translation
               end
            end
            obj:SetText(QTR_ReverseIfAR(ST_TranslatePrepare(txt, new_trans)).." ");     -- hard space at the end of translation
            if (font1) then
               obj:SetFont(font1, a2);
            else
               obj:SetFont(WOWTR_Font2, a2);
            end
         elseif (sav and (TT_PS["saveui"] == "1")) then
            ST_PH[ST_Hash] = prefix.."@"..ST_PrzedZapisem(txt);
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
      if (math.floor(w)>999999) then
         wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2."):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
      elseif (math.floor(w)>99999) then
         wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2"):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
      elseif (math.floor(w)>999) then
         wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)", "%1."):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
      else   
         wartab[arg0] = tostring(math.floor(w));
      end
   end;
   if (arg0>19) then
      tlumaczenie=string.gsub(tlumaczenie, "{02}", WOWTR_AnsiReverse(wartab[20]));
      tlumaczenie=string.gsub(tlumaczenie, "$20", WOWTR_AnsiReverse(wartab[20]));
   end
   if (arg0>18) then
      tlumaczenie=string.gsub(tlumaczenie, "{91}", WOWTR_AnsiReverse(wartab[19]));
      tlumaczenie=string.gsub(tlumaczenie, "$19", WOWTR_AnsiReverse(wartab[19]));
   end
   if (arg0>17) then
      tlumaczenie=string.gsub(tlumaczenie, "{81}", WOWTR_AnsiReverse(wartab[18]));
      tlumaczenie=string.gsub(tlumaczenie, "$18", WOWTR_AnsiReverse(wartab[18]));
   end
   if (arg0>16) then
      tlumaczenie=string.gsub(tlumaczenie, "{71}", WOWTR_AnsiReverse(wartab[17]));
      tlumaczenie=string.gsub(tlumaczenie, "$17", WOWTR_AnsiReverse(wartab[17]));
   end
   if (arg0>15) then
      tlumaczenie=string.gsub(tlumaczenie, "{61}", WOWTR_AnsiReverse(wartab[16]));
      tlumaczenie=string.gsub(tlumaczenie, "$16", WOWTR_AnsiReverse(wartab[16]));
   end
   if (arg0>14) then
      tlumaczenie=string.gsub(tlumaczenie, "{51}", WOWTR_AnsiReverse(wartab[15]));
      tlumaczenie=string.gsub(tlumaczenie, "$15", WOWTR_AnsiReverse(wartab[15]));
   end
   if (arg0>13) then
      tlumaczenie=string.gsub(tlumaczenie, "{41}", WOWTR_AnsiReverse(wartab[14]));
      tlumaczenie=string.gsub(tlumaczenie, "$14", WOWTR_AnsiReverse(wartab[14]));
   end
   if (arg0>12) then
      tlumaczenie=string.gsub(tlumaczenie, "{31}", WOWTR_AnsiReverse(wartab[13]));
      tlumaczenie=string.gsub(tlumaczenie, "$13", WOWTR_AnsiReverse(wartab[13]));
   end
   if (arg0>11) then
      tlumaczenie=string.gsub(tlumaczenie, "{21}", WOWTR_AnsiReverse(wartab[12]));
      tlumaczenie=string.gsub(tlumaczenie, "$12", WOWTR_AnsiReverse(wartab[12]));
   end
   if (arg0>10) then
      tlumaczenie=string.gsub(tlumaczenie, "{11}", WOWTR_AnsiReverse(wartab[11]));
      tlumaczenie=string.gsub(tlumaczenie, "$11", WOWTR_AnsiReverse(wartab[11]));
   end
   if (arg0>9) then
      tlumaczenie=string.gsub(tlumaczenie, "{01}", WOWTR_AnsiReverse(wartab[10]));
      tlumaczenie=string.gsub(tlumaczenie, "$10", WOWTR_AnsiReverse(wartab[10]));
   end
   if (arg0>8) then
      tlumaczenie=string.gsub(tlumaczenie, "{9}", WOWTR_AnsiReverse(wartab[9]));
      tlumaczenie=string.gsub(tlumaczenie, "$9", WOWTR_AnsiReverse(wartab[9]));
   end
   if (arg0>7) then
      tlumaczenie=string.gsub(tlumaczenie, "{8}", WOWTR_AnsiReverse(wartab[8]));
      tlumaczenie=string.gsub(tlumaczenie, "$8", WOWTR_AnsiReverse(wartab[8]));
   end
   if (arg0>6) then
      tlumaczenie=string.gsub(tlumaczenie, "{7}", WOWTR_AnsiReverse(wartab[7]));
      tlumaczenie=string.gsub(tlumaczenie, "$7", WOWTR_AnsiReverse(wartab[7]));
   end
   if (arg0>5) then
      tlumaczenie=string.gsub(tlumaczenie, "{6}", WOWTR_AnsiReverse(wartab[6]));
      tlumaczenie=string.gsub(tlumaczenie, "$6", WOWTR_AnsiReverse(wartab[6]));
   end
   if (arg0>4) then
      tlumaczenie=string.gsub(tlumaczenie, "{5}", WOWTR_AnsiReverse(wartab[5]));
      tlumaczenie=string.gsub(tlumaczenie, "$5", WOWTR_AnsiReverse(wartab[5]));
   end
   if (arg0>3) then
      tlumaczenie=string.gsub(tlumaczenie, "{4}", WOWTR_AnsiReverse(wartab[4]));
      tlumaczenie=string.gsub(tlumaczenie, "$4", WOWTR_AnsiReverse(wartab[4]));
   end
   if (arg0>2) then
      tlumaczenie=string.gsub(tlumaczenie, "{3}", WOWTR_AnsiReverse(wartab[3]));
      tlumaczenie=string.gsub(tlumaczenie, "$3", WOWTR_AnsiReverse(wartab[3]));
   end
   if (arg0>1) then
      tlumaczenie=string.gsub(tlumaczenie, "{2}", WOWTR_AnsiReverse(wartab[2]));
      tlumaczenie=string.gsub(tlumaczenie, "$2", WOWTR_AnsiReverse(wartab[2]));
   end
   if (arg0>0) then
      tlumaczenie=string.gsub(tlumaczenie, "{1}", WOWTR_AnsiReverse(wartab[1]));
      tlumaczenie=string.gsub(tlumaczenie, "$1", WOWTR_AnsiReverse(wartab[1]));
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
      if (not WOWTR_wait(0.01, ST_GameTooltipOnShow)) then
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
            elseif (_G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText() and (string.find(_G["GameTooltipTextLeft1"]:GetText()," ")==nil)) then
               ST_GameTooltipOnShow();
            end
         elseif ((ST_PM["constantly"] == "1") and (self.updateTooltipTimer > 1)) then
            self.updateTooltipTimer = 2;
         end
      end
   end );
   
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
         if (string.find(_G["GameTooltipTextLeft1"]:GetText()," ")) then
             return;
         end
         _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(_G["GameTooltipTextLeft1"]:GetText(),WOWTR_Font2).." ");   -- znacznik twardej spacji do tytułu
      end
      
      local ST_prefix = "h";
      if (GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id) then
         if (GameTooltip.processingInfo.tooltipData.type == 0) then           -- items
            ST_prefix = "i" .. GameTooltip.processingInfo.tooltipData.id;
            if (ST_PM["item"] == "0") then      -- nie ma zezwolenia tłumaczenia przedmiotów
               return;
            end
         elseif (GameTooltip.processingInfo.tooltipData.type == 1) then       -- spell or talent
            if (ClassTalentFrame and ClassTalentFrame:IsVisible() and (ClassTalentFrame:GetTab()==2)) then     -- otwarta zakładka Talents
               local PTFleft = ClassTalentFrame:GetLeft();
               local PTFright = ClassTalentFrame:GetRight();
               local PTFbootom = ClassTalentFrame:GetBottom();
               local PTFtop = ClassTalentFrame:GetTop();
               local x,y = GetCursorPosition();
               if (x>PTFleft and x<PTFright and y>PTFbootom and y<PTFtop) then
                  ST_prefix = "t" .. GameTooltip.processingInfo.tooltipData.id;
                  if (ST_PM["talent"] == "0") then      -- nie ma zezwolenia tłumaczenia talentów
                     return;
                  end
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
         _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(ST_TooltipsID[ST_prefix],WOWTR_Font2).." ");   -- znacznik twardej spacji do tytułu
         _font1, _size1, _1 = _G["GameTooltipTextLeft1"]:GetFont();           -- odczytaj aktualną czcionkę i rozmiar    
         _G["GameTooltipTextLeft1"]:SetFont(WOWTR_Font2, _size1);
      end

      for i = ST_fromLine, numLines, 1 do
         ST_leftText = _G["GameTooltipTextLeft"..i]:GetText();
         if (ST_leftText and (string.find(ST_leftText," ")==nil)) then                 -- nie jest to nasze tłumaczenie
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
                  _G["GameTooltipTextLeft"..i]:SetText(QTR_ExpandUnitInfo(ST_tlumaczenie,false,_G["GameTooltipTextLeft"..i],WOWTR_Font2).." ");      -- dodajemy twardą spacje na końcu
                  _G["GameTooltipTextLeft"..i].wrap = true;
                  if (GameTooltip.processingInfo and GameTooltip.processingInfo.tooltipData.id and (GameTooltip.processingInfo.tooltipData.id == 6948)) then   -- wyjątek na Kamień Powrotu
                     break;
                  end
               else
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
         _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(_G["GameTooltipTextLeft1"]:GetText(),WOWTR_Font2).." ");
      end
      GameTooltip:Show();   -- wyświetla ramkę podpowiedzi (zrobi także resize)
      ST_lastNumLines = GameTooltip:NumLines();
      
		local ignoreWords = {
			"Seller: |cffffffff",
			"Sellers: |cffffffff",
			"Equipment Sets: |cFFFFFFFF",
			"|cff00ff00<Made by ",
			"Leader: |cffffffff",
			"Realm: |cffffffff",
			"Waiting on: |cff",
			"Reagents: |n"
		}

		local ignorePattern = "[Яа-яĄ-Źą-źŻ-żЀ-ӿΑ-Ωα-ω]"

		if ((ST_orygText or (ST_nh == 1)) and (ST_PM["saveNW"] == "1")) then
			for _, ST_origin in ipairs(ST_orygText) do
				ST_hash = StringHash(ST_UsunZbedneZnaki(ST_origin))
				if (string.sub(ST_origin, 1, 11) ~= '|A:raceicon') then
					local shouldSave = true
					for _, word in ipairs(ignoreWords) do
						if string.find(ST_origin, "^" .. word) then
							shouldSave = false
							break
						end
					end
					if shouldSave and (not string.find(ST_origin, ignorePattern)) then
						ST_PH[ST_hash] = ST_prefix .. "@" .. ST_PrzedZapisem(ST_origin)
					end
				end
			end
		end
	  
      
   end
end

-------------------------------------------------------------------------------------------------------

function ST_SetText(txt)      -- funkcja wyszukuje tłumaczenie, albo zapisuje test oryginalny
   if (string.find(txt," ")==nil) then    -- nie jest to tekst turecki (nie ma twardej spacji na końcu tłumaczenia)
      local ST_hash = StringHash(ST_UsunZbedneZnaki(txt));
      if (ST_TooltipsHS[ST_hash]) then
         return ST_TooltipsHS[ST_hash].." ";       -- dodajemy twardą spację na końcu tłumaczenia
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
            if (string.find(ST_leftText," ")==nil) then                             -- nie jest to tekst przetłumaczony (twarda spacja na końcu)
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
                  _G[obj:GetName().."TextLeft1"]:SetText(QTR_ReverseIfAR(ST_info).." ");             -- dodajemy twardą spacje na końcu
                  _G[obj:GetName().."TextLeft1"]:SetFont(WOWTR_Font2, _size1);
               end
            end               
         end
   
         -- druga linia z tytułem przedmiotu
         ST_pomoc0, _ = string.find(_G[obj:GetName().."TextLeft2"]:GetText()," ");   -- szukamy twardej spacji
         if (ST_TooltipID and (ST_pomoc0==nil) and (ST_TooltipsID[ST_prefix..tostring(ST_itemID)]) and (ST_PM["transtitle"]=="1")) then  -- jest tłumaczenie tytułu w bazie
            _G[obj:GetName().."TextLeft2"]:SetText(QTR_ExpandUnitInfo(ST_TooltipsID[ST_prefix..tostring(ST_itemID)]),WOWTR_Font2);
            _font1, _size1, _1 = _G[obj:GetName().."TextLeft2"]:GetFont();  -- odczytaj aktualną czcionkę i rozmiar    
            _G[obj:GetName().."TextLeft2"]:SetFont(WOWTR_Font2, _size1);
         end
   
         for i = 3, numLines, 1 do
            ST_leftText = _G[obj:GetName().."TextLeft"..i]:GetText();
            if (ST_leftText and (string.find(ST_leftText," ")==nil)) then                 -- nie jest to nasze tłumaczenie
               leftColR, leftColG, leftColB = _G[obj:GetName().."TextLeft"..i]:GetTextColor();
               ST_kodKoloru = OkreslKodKoloru(leftColR, leftColG, leftColB);
               if (ST_leftText and (string.len(ST_leftText)>15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText)>30))) then
--print(ST_kodKoloru,i,ST_leftText);
                  ST_hash = StringHash(ST_UsunZbedneZnaki(ST_leftText));
                  if (((ST_kodKoloru == "c7") or (string.len(ST_leftText)>30)) and (not ST_hash2)) then
                     ST_hash2 = ST_hash;
                  end
                  if (ST_TooltipsHS[ST_hash]) then        -- mamy przetłumaczony ten Hash
                     ST_tlumaczenie = ST_TooltipsHS[ST_hash];
                     ST_tlumaczenie = ST_TranslatePrepare(ST_leftText, ST_tlumaczenie);
                     _font1, _size1, _1 = _G[obj:GetName().."TextLeft"..i]:GetFont();    -- odczytaj aktualną czcionkę i rozmiar    
                     _G[obj:GetName().."TextLeft"..i]:SetFont(WOWTR_Font2, _size1);      -- ustawiamy czcionkę turecką
                     _G[obj:GetName().."TextLeft"..i]:SetText(QTR_ExpandUnitInfo(ST_tlumaczenie,false,_G["GameTooltipTextLeft"..i],WOWTR_Font2).." ");      -- dodajemy twardą spacje na końcu
                  else
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
               if ((not ST_TooltipsHS[ST_hash]) and (string.find(ST_origin," ")==nil)) then    -- i nie jest to tekst tłumaczenia (twarda spacja)
                  ST_PH[ST_hash]=ST_prefix.."@"..ST_PrzedZapisem(ST_origin);
               end
            end
         end
      end
         
   end   -- if ST_PM["active"]
   
end
    
-------------------------------------------------------------------------------------------------------

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

--   local _font, _size, _ = classTalentFrame:GetTalentsTabButton():GetFont();
   classTalentFrame:GetTalentsTabButton():SetText(ST_SetText(_G["TALENT_FRAME_TAB_LABEL_TALENTS"]));
--   classTalentFrame:GetTalentsTabButton():SetFont(WOWTR_Font2, _size);
--   local _font, _size, _ = classTalentFrame:GetTabButton(classTalentFrame.specTabID):GetFont();
   classTalentFrame:GetTabButton(classTalentFrame.specTabID):SetText(QTR_ReverseIfAR(ST_SetText(_G["TALENT_FRAME_TAB_LABEL_SPEC"])));
--   classTalentFrame:GetTabButton(classTalentFrame.specTabID):SetFont(WOWTR_Font2, _size);
   if ((ST_PM["active"] == "1") and (classTalentFrame:GetTab() ~= classTalentFrame.specTabID)) then
      WOWTR_ToggleButtonT:Show();
   else
      WOWTR_ToggleButtonT:Hide();
   end
end

-------------------------------------------------------------------------------------------------------

function ST_TalentsTab_OnShow(talentsTab)
   local _font, _size, _ = talentsTab.ClassCurrencyDisplay.CurrencyLabel:GetFont();    -- odczytaj aktualną czcionkę i rozmiar
   talentsTab.ClassCurrencyDisplay.CurrencyLabel:SetText(QTR_ReverseIfAR(ST_SetText(talentsTab.ClassCurrencyDisplay.CurrencyLabel:GetText())));   -- Main Class Talent Title
   talentsTab.ClassCurrencyDisplay.CurrencyLabel:SetFont(WOWTR_Font2, _size);
   local _font, _size, _ = talentsTab.SpecCurrencyDisplay.CurrencyLabel:GetFont();
   talentsTab.SpecCurrencyDisplay.CurrencyLabel:SetText(QTR_ReverseIfAR(ST_SetText(talentsTab.SpecCurrencyDisplay.CurrencyLabel:GetText())));     -- Spec Class Talent Title
   talentsTab.SpecCurrencyDisplay.CurrencyLabel:SetFont(WOWTR_Font2, _size);
end

-------------------------------------------------------------------------------------------------------

function ST_updateSpecContentsHook()
   for specContentFrame in PlayerSpellsFrame.SpecFrame.SpecContentFramePool:EnumerateActive() do
      local _, _, description, _, _, primaryStat = GetSpecializationInfo(specContentFrame.specIndex, false, false, nil, WOWTR_player_sex);
      if (description and string.find(description," ")==nil) then    -- nie jest to tekst turecki (twarda spacja)
         local ST_hash = StringHash(ST_UsunZbedneZnaki(description));
         if (ST_TooltipsHS[ST_hash]) then            -- mamy tłumaczenie tureckie
            ST_tlumaczenie = ST_TooltipsHS[ST_hash];
            ST_tlumaczenie = ST_TranslatePrepare(description, ST_tlumaczenie);
            local _font1, _size1, _1 = specContentFrame.Description:GetFont();    -- odczytaj aktualną czcionkę i rozmiar
            specContentFrame.Description:SetFont(WOWTR_Font2, _size1);
            specContentFrame.Description:SetText(QTR_ExpandUnitInfo(ST_tlumaczenie,false,specContentFrame.Description,WOWTR_Font2));
         elseif (ST_PM["saveNW"]=="1") then          -- jest zezwolenie na zapis
            ST_origin = string.gsub(description,"(%d),(%d)","%1%2");      -- usuń przecinek między cyframi (odstęp tysięczny)
            ST_origin = string.gsub(ST_origin,"\r","");
            ST_SpecName = specContentFrame.SpecName:GetText();
            ST_PH[ST_hash] = "SpecTab:"..WOWTR_player_class..":"..ST_SpecName.."@"..ST_PrzedZapisem(description);
         end
      end
      local _font, _size, _ = specContentFrame.RoleName:GetFont();    -- odczytaj aktualną czcionkę i rozmiar
      specContentFrame.RoleName:SetText(QTR_ReverseIfAR(ST_SetText(specContentFrame.RoleName:GetText())));
      specContentFrame.RoleName:SetFont(WOWTR_Font2, _size);
      _font, _size, _ = specContentFrame.SampleAbilityText:GetFont();
      specContentFrame.SampleAbilityText:SetText(QTR_ReverseIfAR(ST_SetText(specContentFrame.SampleAbilityText:GetText())));
      specContentFrame.SampleAbilityText:SetFont(WOWTR_Font2, _size);
      _font, _size, _ = specContentFrame.ActivatedText:GetFont();
      specContentFrame.ActivatedText:SetText(QTR_ReverseIfAR(ST_SetText(specContentFrame.ActivatedText:GetText())));
      specContentFrame.ActivatedText:SetFont(WOWTR_Font2, _size);
      _font, _size, _ = specContentFrame.ActivateButton.Text:GetFont();
      specContentFrame.ActivateButton.Text:SetText(QTR_ReverseIfAR(ST_SetText(specContentFrame.ActivateButton.Text:GetText())));
      specContentFrame.ActivateButton.Text:SetFont(WOWTR_Font2, _size);
   end
end

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
      
      local PrimaryProfession1Text = PrimaryProfession1.missingText; -- https://imgur.com/amgQ7K7
      ST_CheckAndReplaceTranslationText(PrimaryProfession1Text, true, "Profession:Other",false, false, -15);
      if (WoWTR_Localization.lang == 'AR') then
         PrimaryProfession1Text:SetFont(WOWTR_Font2, 11);
         PrimaryProfession1Text:SetJustifyH("RIGHT");
      end

      local PrimaryProfession2Text = PrimaryProfession2.missingText; -- https://imgur.com/amgQ7K7
      ST_CheckAndReplaceTranslationText(PrimaryProfession2Text, true, "Profession:Other",false, false, -15);
      if (WoWTR_Localization.lang == 'AR') then
         PrimaryProfession2Text:SetFont(WOWTR_Font2, 11);
         PrimaryProfession2Text:SetJustifyH("RIGHT");
      end

      local SecondaryProfession1Text = SecondaryProfession1.missingText; -- https://imgur.com/amgQ7K7
      ST_CheckAndReplaceTranslationText(SecondaryProfession1Text, true, "Profession:Other", false, false, -15);
      if (WoWTR_Localization.lang == 'AR') then
         SecondaryProfession1Text:SetFont(WOWTR_Font2, 10);
         SecondaryProfession1Text:SetJustifyH("RIGHT");
      end

      local SecondaryProfession2Text = SecondaryProfession2.missingText; -- https://imgur.com/amgQ7K7
      ST_CheckAndReplaceTranslationText(SecondaryProfession2Text, true, "Profession:Other", false, false, -15);
      if (WoWTR_Localization.lang == 'AR') then
         SecondaryProfession2Text:SetFont(WOWTR_Font2, 10);
         SecondaryProfession2Text:SetJustifyH("RIGHT");
      end

      local SecondaryProfession3Text = SecondaryProfession3.missingText; -- https://imgur.com/amgQ7K7
      ST_CheckAndReplaceTranslationText(SecondaryProfession3Text, true, "Profession:Other", false, false, -15);
      if (WoWTR_Localization.lang == 'AR') then
         SecondaryProfession3Text:SetFont(WOWTR_Font2, 10);
         SecondaryProfession3Text:SetJustifyH("RIGHT");
      end

      local SBPageText = SpellBookPageText;
      ST_CheckAndReplaceTranslationText(SBPageText, true, "ui");
   end
end

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
      
   elseif (addonName == 'Blizzard_EncounterJournal') then
      ST_load2 = true;
      EncounterJournalEncounterFrameInfo.BossesScrollBox:HookScript("OnShow", function() StartDelayedFunction(ST_openBossesList, 0.2) end)
      EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription:HookScript("OnShow", function() StartTicker(EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription, ST_clickBosses, 0.2) end)
      EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription:HookScript("OnShow", function() StartTicker(EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription, ST_ShowAbility, 0.2) end)
      EncounterJournal:HookScript("OnShow", function() StartTicker(EncounterJournal, ST_SuggestTabClick, 0.2) end)
      EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont:HookScript("OnShow", ST_showLoreDescription)
      
   elseif (addonName == 'Blizzard_Professions') then
      ST_load3 = true;
      ProfessionsFrame:HookScript("OnShow", function() StartTicker(ProfessionsFrame, ST_showProfessionDescription, 0.02) end)
      ProfessionsFrame:HookScript("OnShow", ST_ProfDescbutton)
      
   elseif (addonName == 'Blizzard_Collections') then
      ST_load4 = true;
      CollectionsJournalTitleText:HookScript("OnShow", function() StartTicker(CollectionsJournalTitleText, ST_MountJournal, 0.2) end)
      WardrobeCollectionFrame:HookScript("OnShow", function() StartTicker(WardrobeCollectionFrame, ST_HelpPlateTooltip, 0.2) end)
      
   elseif (addonName == 'Blizzard_PVPUI') then
      ST_load5 = true;
      PVPQueueFrameCategoryButton1:HookScript("OnShow", function() StartTicker(PVPQueueFrameCategoryButton1, ST_GroupPVPFinder, 0.2) end)
      
   elseif (addonName == 'Blizzard_ChallengesUI') then
      ST_load6 = true;
      ChallengesFrame:HookScript("OnShow", function() StartTicker(ChallengesFrame, ST_GroupMplusFinder, 0.2) end)
      
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
   end

   if (ST_load1 and ST_load2 and ST_load3 and ST_load4 and ST_load5 and ST_load6 and ST_load7 and ST_load8 and ST_load9 and ST_load10) then    -- otworzono wszystkie dodatki Blizzarda
      WOWSTR:UnregisterEvent("ADDON_LOADED");      -- wyłącz  nasłuchiwanie
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
      ST_CheckAndReplaceTranslationText(obj0, true, "Dungeon&Raid:Suggest:SuggestTittle",false,false);
      
      local obj1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.description.text;
      local title1 = EncounterJournalSuggestFrame.Suggestion1.centerDisplay.title.text:GetText() or "?";
      ST_CheckAndReplaceTranslationText(obj1, true, "Dungeon&Raid:Suggest:"..title1);
      
      local obj2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.description.text;
      local title2 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.title.text:GetText() or "?";
      ST_CheckAndReplaceTranslationText(obj2, true, "Dungeon&Raid:Suggest:"..title2);

      local obj3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.description.text;
      local title3 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.title.text:GetText() or "?";
      ST_CheckAndReplaceTranslationText(obj3, true, "Dungeon&Raid:Suggest:"..title3);

      local obj4 = EncounterJournalMonthlyActivitiesFrame.BarComplete.AllRewardsCollectedText; -- https://imgur.com/KE3uW72
      ST_CheckAndReplaceTranslationText(obj4, true, "ui");

      local obj5 = EncounterJournalTitleText;                            -- https://imgur.com/KE3uW72
      ST_CheckAndReplaceTranslationText(obj5, true, "ui");

      local obj6 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Month;         -- https://imgur.com/KE3uW72
      ST_CheckAndReplaceTranslationText(obj6, true, "ui");

      local obj7 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.Title;         -- https://imgur.com/KE3uW72
      ST_CheckAndReplaceTranslationText(obj7, true, "ui");

      local obj8 = EncounterJournalMonthlyActivitiesFrame.HeaderContainer.TimeLeft;      -- https://imgur.com/KE3uW72
      ST_CheckAndReplaceTranslationText(obj8, true, "ui");

      local obj9 = EncounterJournalSuggestFrame.Suggestion1.button.Text; 				-- https://imgur.com/kkPedLC
      ST_CheckAndReplaceTranslationText(obj9, true, "ui");

      local obj10 = EncounterJournalSuggestFrame.Suggestion2.centerDisplay.button.Text; -- https://imgur.com/kkPedLC
      ST_CheckAndReplaceTranslationText(obj10, true, "ui");

      local obj11 = EncounterJournalSuggestFrame.Suggestion3.centerDisplay.button.Text; -- https://imgur.com/kkPedLC
      ST_CheckAndReplaceTranslationText(obj11, true, "ui");

      local obj12 = EncounterJournalSuggestFrame.Suggestion1.reward.text;               -- https://imgur.com/kkPedLC
      ST_CheckAndReplaceTranslationText(obj12, true, "ui");
	  
      local obj13 = EncounterJournalMonthlyActivitiesFrame.BarComplete.PendingRewardsText;               -- https://imgur.com/kkPedLC
      ST_CheckAndReplaceTranslationText(obj13, true, "ui");

      local obj14 = EncounterJournalMonthlyActivitiesTab.Text;  -- Tab: Traveler's Log
      ST_CheckAndReplaceTranslationText(obj14, true, "ui");

      local obj15 = EncounterJournalSuggestTab.Text;            -- Tab: Suggested Content
      ST_CheckAndReplaceTranslationText(obj15, true, "ui");

      local obj16 = EncounterJournalDungeonTab.Text;            -- Tab: Dungeons
      ST_CheckAndReplaceTranslationText(obj16, true, "ui");

      local obj17 = EncounterJournalRaidTab.Text;               -- Tab: Raids
      ST_CheckAndReplaceTranslationText(obj17, true, "ui");

      local obj18 = EncounterJournalLootJournalTab.Text;        -- Tab: Item Sets
      ST_CheckAndReplaceTranslationText(obj18, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------

function ST_openBossesList()
   if ST_PM["active"] == "1" then
       local navBarButtons = {
           EncounterJournalNavBarButton1,
           EncounterJournalNavBarButton2,
           EncounterJournalNavBarButton3,
           EncounterJournalNavBarButton4,
           EncounterJournalNavBarButton5
       }

       for _, button in ipairs(navBarButtons) do
           if button and not button.ST_navBarHooked then
               button.ST_navBarHooked = true
               button.MenuArrowButton:HookScript("OnHide", function()
                   StartDelayedFunction(ST_clickBosses, 0.2)
               end)
           end
       end
   end
end

-------------------------------------------------------------------------------------------------------

function ST_showLoreDescription()
--print("show LoreDescription");
   local ST_Dungeon_Raid_zone = EncounterJournalEncounterFrameInstanceFrame.title:GetText() or "?";
   local ST_loreDescription = EncounterJournalEncounterFrameInstanceFrame.LoreScrollingFont.ScrollBox.FontStringContainer.FontString;
   ST_CheckAndReplaceTranslationText(ST_loreDescription, true, "Dungeon&Raid:Zone:"..ST_Dungeon_Raid_zone);
end

-------------------------------------------------------------------------------------------------------

--PROFESSION FRAME, TEXT and OTHER TRANSLATE-----------------------------------------------------------
function ST_showProfessionDescription() 
--print("ST_showProfessionDescription");
   if (TT_PS["ui7"] == "1") then
      local PRobj01 = ProfessionsFrame.CraftingPage.SchematicForm.Description; -- https://imgur.com/BswVlBQ
      local prof_title = ProfessionsFrame.CraftingPage.SchematicForm.OutputText:GetText() or "?";
      local prof_name = ProfessionsFrameTitleText:GetText() or "?";
      ST_CheckAndReplaceTranslationTextUI(PRobj01, true, "Profession:"..ST_RenkKoduSil(prof_name)..":"..ST_RenkKoduSil(prof_title));
      
      local PRobj02 = ProfessionsFrame.SpecPage.TreeView.TreeDescription; -- https://imgur.com/7iBBl30
      ST_CheckAndReplaceTranslationTextUI(PRobj02, false, "");       -- don't save untranslated text
      
      local PRobj03 = ProfessionsFrame.SpecPage.TreePreview.Description; -- https://imgur.com/iwhgxcy
      ST_CheckAndReplaceTranslationTextUI(PRobj03, false, "");    -- don't save untranslated text
      
      local PRobj04 = ProfessionsFrame.SpecPage.TreePreview.Highlight1.Description; -- https://imgur.com/SeLUJey
      ST_CheckAndReplaceTranslationTextUI(PRobj04, true, "Profession:"..ST_RenkKoduSil(prof_name)..":Other");
      
      local PRobj05 = ProfessionsFrame.SpecPage.TreePreview.Highlight2.Description; -- https://imgur.com/sIPdOx6
      ST_CheckAndReplaceTranslationTextUI(PRobj05, true, "Profession:"..ST_RenkKoduSil(prof_name)..":Other");
      
      local PRobj06 = ProfessionsFrame.SpecPage.TreePreview.Highlight3.Description; -- https://imgur.com/7sH7ygf
      ST_CheckAndReplaceTranslationTextUI(PRobj06, true, "Profession:"..ST_RenkKoduSil(prof_name)..":Other");
      
      local PRobj07 = ProfessionsFrame.SpecPage.TreePreview.Highlight4.Description; -- https://imgur.com/ZnJrOjS
      ST_CheckAndReplaceTranslationTextUI(PRobj07, true, "Profession:"..ST_RenkKoduSil(prof_name)..":Other");
      
      local PRobj08 = ProfessionsFrame.CraftingPage.SchematicForm.Details.Label; -- https://imgur.com/piy41yl
      ST_CheckAndReplaceTranslationTextUI(PRobj08, true, "Profession:Other");
      
      local PRobj09 = ProfessionsFrame.SpecPage.TreePreview.HighlightsHeader; -- https://imgur.com/4CrqODj
      ST_CheckAndReplaceTranslationTextUI(PRobj09, true, "Profession:Other");
      
      local PRobj10 = ProfessionsFrame.SpecPage.ViewPreviewButton.Text; -- https://imgur.com/ZhTfjUH
      ST_CheckAndReplaceTranslationTextUI(PRobj10, true, "Profession:Other");
      
      local PRobj11 = ProfessionsFrame.SpecPage.BackToFullTreeButton.Text; -- https://imgur.com/5iEFYpV
      ST_CheckAndReplaceTranslationTextUI(PRobj11, true, "Profession:Other");
      
      local PRobj12 = ProfessionsFrame.SpecPage.DetailedView.SpendPointsButton.Text; -- https://imgur.com/KmjEPCc
      ST_CheckAndReplaceTranslationTextUI(PRobj12, true, "Profession:Other");
      
      local PRobj13 = ProfessionsFrame.SpecPage.DetailedView.UnlockPathButton.Text; -- https://imgur.com/zR0RamH
      ST_CheckAndReplaceTranslationTextUI(PRobj13, true, "Profession:Other");
      
      local PRobj14 = ProfessionsFrame.SpecPage.ApplyButton.Text; -- https://imgur.com/1RqSqU2
      ST_CheckAndReplaceTranslationTextUI(PRobj14, true, "Profession:Other");

      local PRobj15 = ProfessionsFrame.SpecPage.ViewTreeButton.Text; 
      ST_CheckAndReplaceTranslationTextUI(PRobj15, true, "Profession:Other");

      local PRobj16 = ProfessionsFrame.CraftingPage.SchematicForm.Details.CraftingChoicesContainer.FinishingReagentSlotContainer.Label; -- https://imgur.com/PIAUMIB
      ST_CheckAndReplaceTranslationTextUI(PRobj16, true, "Profession:Other");

      -- local PRobj17 = ProfessionsFrame.CraftingPage.SchematicForm.AllocateBestQualityCheckBox.Text; -- https://imgur.com/XDbs3N5
      -- ST_CheckAndReplaceTranslationTextUI(PRobj17, true, "Profession:Other");

      local PRobj18 = ProfessionsFrame.CraftingPage.SchematicForm.FirstCraftBonus.Text; -- https://imgur.com/2N0WWfd
      ST_CheckAndReplaceTranslationTextUI(PRobj18, true, "Profession:Other");
      
      local PRobj19 = ProfessionsFrame.CraftingPage.SchematicForm.RecipeSourceButton.Text; -- https://imgur.com/W3mmU92
      ST_CheckAndReplaceTranslationTextUI(PRobj19, true, "Profession:Other");

      local PRobj20 = ProfessionsFrame.CraftingPage.SchematicForm.Reagents.Label; -- https://imgur.com/3C9smY0
      ST_CheckAndReplaceTranslationTextUI(PRobj20, true, "Profession:Other");

      local PRobj21 = ProfessionsFrame.CraftingPage.SchematicForm.OptionalReagents.Label; -- https://imgur.com/oaYzd5v
      ST_CheckAndReplaceTranslationTextUI(PRobj21, true, "Profession:Other");

      -- local PRobj22 = ProfessionsFrame.CraftingPage.SchematicForm.TrackRecipeCheckBox.Text; -- https://imgur.com/jZcvEE9
      -- ST_CheckAndReplaceTranslationTextUI(PRobj22, true, "Profession:Other");

      local PRobj23 = ProfessionsFrame.CraftingPage.SchematicForm.RecraftingDescription; -- https://imgur.com/ihYuF3m
      ST_CheckAndReplaceTranslationTextUI(PRobj23, true, "Profession:Other");
      
      local PRobj24 = ProfessionsFrame.SpecPage.UnlockTabButton.Text; -- https://imgur.com/TSpN8BY
      ST_CheckAndReplaceTranslationTextUI(PRobj24, true, "Profession:Other");

      local PRobj25 = ProfessionsFrame.CraftingPage.RecipeList.FilterDropdown.Text;
      ST_CheckAndReplaceTranslationTextUI(PRobj25, true, "ui");
   end
end

-- Global button variables
local ProfDescbuttonOFF
local ProfDescbuttonON

local function UpdateButtonVisibility()
    if TT_PS["ui7"] == "1" then
        if ProfDescbuttonOFF then ProfDescbuttonOFF:Show() end
        if ProfDescbuttonON then ProfDescbuttonON:Hide() end
    else
        if ProfDescbuttonOFF then ProfDescbuttonOFF:Hide() end
        if ProfDescbuttonON then ProfDescbuttonON:Show() end
    end
end

function ST_ProfDescbutton() -- Profession Descriptions Translate On Off Button
    -- Check the TT_PS table, create it if it does not exist
    TT_PS = TT_PS or { ui7 = "1" } -- Set default value

    -- Create both buttons
    if not ProfDescbuttonOFF then
        ProfDescbuttonOFF = CreateFrame("Button", nil, ProfessionsFrame, "UIPanelButtonTemplate")
        ProfDescbuttonOFF:SetSize(120, 22)
        if (WoWTR_Localization.lang == 'AR') then
            ProfDescbuttonOFF:SetText(QTR_ReverseIfAR(WoWTR_Localization.WoWTR_trDESC))
            ProfDescbuttonOFF:GetFontString():SetFont(WOWTR_Font2, 13)
        else
            ProfDescbuttonOFF:SetText(WoWTR_Localization.WoWTR_trDESC)
            ProfDescbuttonOFF:GetFontString():SetFont(ProfDescbuttonOFF:GetFontString():GetFont(), 13)
        end
        ProfDescbuttonOFF:SetPoint("TOPLEFT", ProfessionsFrame, "TOPRIGHT", -170, 0)
        ProfDescbuttonOFF:SetFrameStrata("TOOLTIP")

        ProfDescbuttonOFF:SetScript("OnClick", function()
            TT_PS["ui7"] = "0"
            ST_showProfessionDescription()
            if ProfessionsFrame.CraftingPage.SchematicForm then
                ProfessionsFrame.CraftingPage.SchematicForm:Hide()
                ProfessionsFrame.CraftingPage.SchematicForm:Show()
            end
            UpdateButtonVisibility()
        end)
    end

    if not ProfDescbuttonON then
        ProfDescbuttonON = CreateFrame("Button", nil, ProfessionsFrame, "UIPanelButtonTemplate")
        ProfDescbuttonON:SetSize(120, 22)
        if (WoWTR_Localization.lang == 'AR') then
            ProfDescbuttonON:SetText(QTR_ReverseIfAR(WoWTR_Localization.WoWTR_enDESC))
            ProfDescbuttonON:GetFontString():SetFont(WOWTR_Font2, 13)
        else
            ProfDescbuttonON:SetText(WoWTR_Localization.WoWTR_enDESC)
            ProfDescbuttonON:GetFontString():SetFont(ProfDescbuttonON:GetFontString():GetFont(), 13)
        end
        ProfDescbuttonON:SetPoint("TOPLEFT", ProfessionsFrame, "TOPRIGHT", -170, 0)
        ProfDescbuttonON:SetFrameStrata("TOOLTIP")

        ProfDescbuttonON:SetScript("OnClick", function()
            TT_PS["ui7"] = "1"
            ST_showProfessionDescription()
            UpdateButtonVisibility()
        end)
    end

    -- Set visibility of buttons at startup
    UpdateButtonVisibility()
end

-------------------------------------------------------------------------------------------------------

--DelveDifficultFrame, TEXT and OTHER TRANSLATE
function ST_showDelveDifficultFrame() 
--print("show DelveDifficultFrame");
   -- if (TT_PS["ui7"] == "1") then
      local DelveDF01 = DelvesDifficultyPickerFrame.Description; -- https://imgur.com/a/SAyXuiR
      ST_CheckAndReplaceTranslationTextUI(DelveDF01, true, "Dungeon&Raid:Zone:DelvesFrame");       -- save untranslated text
      
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
function ST_clickBosses()
   local navBarButtons = {
       EncounterJournalNavBarButton1,
       EncounterJournalNavBarButton2,
       EncounterJournalNavBarButton3,
       EncounterJournalNavBarButton4,
       EncounterJournalNavBarButton5
   }

   for _, button in ipairs(navBarButtons) do
       if button and not button.ST_navBarHooked then
           button.ST_navBarHooked = true
           button.MenuArrowButton:HookScript("OnHide", function()
               StartDelayedFunction(ST_clickBosses, 0.2)
           end)
       end
   end

   local ST_bossName = EncounterJournalEncounterFrameInfoEncounterTitle:GetText();
   if ST_bossName then
       local ST_bossDescription = EncounterJournalEncounterFrameInfoOverviewScrollFrameScrollChildLoreDescription;
       ST_CheckAndReplaceTranslationText(ST_bossDescription, true, "Dungeon&Raid:Boss:"..ST_bossName);
       local ST_bossOverview = EncounterJournalEncounterFrameInfo.overviewScroll.child.overviewDescription;
       ST_CheckAndReplaceTranslationText(ST_bossOverview, true, "Dungeon&Raid:Boss:"..ST_bossName);
       local ST_bossDescription2 = EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollChildDescription;
       ST_CheckAndReplaceTranslationText(ST_bossDescription2, true, "Dungeon&Raid:Boss:"..ST_bossName);
   end
end


-------------------------------------------------------------------------------------------------------

function ST_ShowAbility()            -- sprawdzanie tekstów Ability
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

function ST_GameMenuTranslate() -- https://imgur.com/drHJ9Yn
--print("ST_GameMenuTranslate");
   if (TT_PS["ui1"] == "1") then
      local gamemenu1 = GameMenuButtonHelpText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu1, false, "ui");

      local gamemenu2 = GameMenuButtonStoreText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu2, false, "ui");

      local gamemenu3 = GameMenuButtonWhatsNewText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu3, false, "ui");

      local gamemenu4 = GameMenuButtonSettingsText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu4, false, "ui");

      local gamemenu5 = GameMenuButtonEditModeText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu5, false, "ui");

      local gamemenu6 = GameMenuButtonMacrosText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu6, false, "ui");

      local gamemenu7 = GameMenuButtonAddonsText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu7, false, "ui");

      local gamemenu8 = GameMenuButtonLogoutText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu8, false, "ui");

      local gamemenu9 = GameMenuButtonQuitText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu9, false, "ui");

      local gamemenu10 = GameMenuButtonContinueText;
      ST_CheckAndReplaceTranslationTextUI(gamemenu10, false, "ui");

      local gamemenu11 = GameMenuFrame.Header.Text;
      ST_CheckAndReplaceTranslationTextUI(gamemenu11, false, "ui");
   end
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

      local ChFrame7 = ReputationFrame.ReputationDetailFrame.Description;            -- https://imgur.com/A77RwLM
      local RDFactionName = ReputationFrame.ReputationDetailFrame.Title:GetText();    -- Faction Name
      ST_CheckAndReplaceTranslationTextUI(ChFrame7, true, "Factions:"..ST_RenkKoduSil(RDFactionName));

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
function ST_ItemRefTooltip()			-- https://imgur.com/a/5Ooqnb2
    local ignorePatterns = {
        "^Achievement in progress by",
        "^Achievement earned by",
        "You completed this on "
    }

    local function shouldIgnore(text)
        for _, pattern in ipairs(ignorePatterns) do
            if text:find(pattern) then
                return true
            end
        end
        return false
    end

    for i = 2, 20 do
        local itemRefLeft = _G["ItemRefTooltipTextLeft" .. i];
        if itemRefLeft and itemRefLeft:GetText() and not shouldIgnore(itemRefLeft:GetText()) then
            ST_CheckAndReplaceTranslationTextUI(itemRefLeft, true, "other");
        end

        local itemRefRight = _G["ItemRefTooltipTextRight" .. i];
        if itemRefRight and itemRefRight:GetText() and not shouldIgnore(itemRefRight:GetText()) then
            ST_CheckAndReplaceTranslationTextUI(itemRefRight, true, "other");
        end
    end
end

-------------------------------------------------------------------------------------------------------

--ITEM UPGRADE FRAME
function ST_ItemUpgradeFrm()			-- https://imgur.com/a/Vy6wNjO
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
    ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm01, false, "ui")
    local WeeklyRFrm02 = WeeklyRewardsFrame.RaidFrame.Name
    ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm02, false, "ui")
    local WeeklyRFrm03 = WeeklyRewardsFrame.MythicFrame.Name
    ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm03, false, "ui")
    local WeeklyRFrm04 = WeeklyRewardsFrame.WorldFrame.Name
    ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm04, false, "ui")
    if WeeklyRewardsFrame.Overlay and WeeklyRewardsFrame.Overlay.Title then
        local WeeklyRFrm05 = WeeklyRewardsFrame.Overlay.Title
        ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm05, true, "ui")
    end
    if WeeklyRewardsFrame.Overlay and WeeklyRewardsFrame.Overlay.Text then
        local WeeklyRFrm06 = WeeklyRewardsFrame.Overlay.Text
        ST_CheckAndReplaceTranslationTextUI(WeeklyRFrm06, true, "ui")
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