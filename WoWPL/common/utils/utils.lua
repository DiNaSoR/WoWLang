local addonName, addon = ...
local C = addon.C

local U = {}

function U.ST_UsunZbedneZnaki(txt) -- przed obliczeniem kodu Hash
   if (not txt) then return ""; end
   text = string.gsub(txt, "|cFFFFFFFF", "");
   text = string.gsub(text, "|r", "");
   text = string.gsub(text, "\r", "");
   text = string.gsub(text, "\n", "");
   text = string.gsub(text, '%f[%a]' .. WOWTR_player_name .. '%f[%A]', "$N");
   text = string.gsub(text, "(%d),(%d)", "%1%2"); -- usuń przecinek między cyframi (odstęp tysięczny)
   text = string.gsub(text, "0", "");
   text = string.gsub(text, "1", "");
   text = string.gsub(text, "2", "");
   text = string.gsub(text, "3", "");
   text = string.gsub(text, "4", "");
   text = string.gsub(text, "5", "");
   text = string.gsub(text, "6", "");
   text = string.gsub(text, "7", "");
   text = string.gsub(text, "8", "");
   text = string.gsub(text, "9", "");
   return text;
end

function U.ST_PrzedZapisem(txt)
   local text = string.gsub(txt, "(%d),(%d)", "%1%2"); -- usuń przecinek między cyframi (odstęp tysięczny)
   text = string.gsub(text, "\r", "");
   text = string.gsub(text, '%f[%a]' .. WOWTR_player_name .. '%f[%A]', "$N");
   return text;
end

function U.ST_RenkKoduSil(txt)
   if (not txt) then return ""; end
   local text = string.gsub(txt, "|r", "");
   text = string.gsub(text, "Dragon Isles ", "");
   text = string.gsub(text, " Specializations", "");
   text = string.gsub(text, "Classic ", "");
   text = string.gsub(text, "|cffffd100", "");
   text = string.gsub(text, "|cff0070dd", "");
   text = string.gsub(text, "|cffffffff", "");
   text = string.gsub(text, "|cff1eff00", "");
   text = string.gsub(text, "|cffa335ee", "");
   text = string.gsub(text, "|cffffd200", "");
   return text;
end

function U.ST_TranslatePrepare(ST_origin, ST_tlumacz)
   local tlumaczenie = WOW_ZmienKody(ST_tlumacz);
   if (not C.ST_miasto) then
      C.ST_miasto = WoWTR_Localization.your_home;
   end
   tlumaczenie = string.gsub(tlumaczenie, "$L", QTR_ReverseIfAR(C.ST_miasto));      -- miasto lokalizacji do Kamienia Powrotu
   local wartab = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; -- max. 20 liczb całkowitych w tekście
   local arg0 = 0;
   ST_origin = string.gsub(ST_origin, "(%d),(%d)", "%1%2");                       -- usuń przecinek tysięczny przy liczbach
   for w in string.gmatch(ST_origin, "%d+") do
      arg0 = arg0 + 1;                                                            -- formatowanie do postaci: 99.123.456
      if (WoWTR_Localization.lang == 'TR') then
         wartab[arg0] = w:gsub("(%d+)", function(num)
            if #num > 1 and num:sub(1, 1) == "0" then
               return num
            else
               return tonumber(num)
            end
         end)
      elseif (WoWTR_Localization.lang == 'JP') then -- formatowanie do postaci: 99,123,456 (JP)
         if (math.floor(w) > 999999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1,%2,"):gsub("(%-?)$", "%1")
                :reverse(); -- tu mamy kolejne cyfry z oryginału
         elseif (math.floor(w) > 99999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1,%2"):gsub("(%-?)$", "%1")
                :reverse();                                                                                          -- tu mamy kolejne cyfry z oryginału
         elseif (math.floor(w) > 999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)", "%1,"):gsub("(%-?)$", "%1"):reverse(); -- tu mamy kolejne cyfry z oryginału
         else
            wartab[arg0] = tostring(math.floor(w));
         end
      else -- formatowanie do postaci: 99.123.456 (Europe)
         if (math.floor(w) > 999999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1,%2,"):gsub("(%-?)$", "%1")
                :reverse(); -- tu mamy kolejne cyfry z oryginału
         elseif (math.floor(w) > 99999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1,%2"):gsub("(%-?)$", "%1")
                :reverse();                                                                                          -- tu mamy kolejne cyfry z oryginału
         elseif (math.floor(w) > 999) then
            wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)", "%1,"):gsub("(%-?)$", "%1"):reverse(); -- tu mamy kolejne cyfry z oryginału
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
            tlumaczenie = string.gsub(tlumaczenie, "$" .. i, WOWTR_AnsiReverse(wartab[i]))
         end
      end
   end
   if (WoWTR_Localization.lang ~= 'AR') then
      tlumaczenie = string.gsub(tlumaczenie, "$o", "$O");
      local nr_1, nr_2, nr_3 = 0;
      local QTR_forma = "";
      local nr_poz = string.find(tlumaczenie, "$O"); -- gdy nie znalazł, jest: nil
      while (nr_poz and nr_poz > 0) do
         nr_1 = nr_poz + 1;
         while (string.sub(tlumaczenie, nr_1, nr_1) ~= "(") do
            nr_1 = nr_1 + 1;
         end
         if (string.sub(tlumaczenie, nr_1, nr_1) == "(") then
            nr_2 = nr_1 + 1;
            while (string.sub(tlumaczenie, nr_2, nr_2) ~= ";") do
               nr_2 = nr_2 + 1;
            end
            if (string.sub(tlumaczenie, nr_2, nr_2) == ";") then
               nr_3 = nr_2 + 1;
               while (string.sub(tlumaczenie, nr_3, nr_3) ~= ")") do
                  nr_3 = nr_3 + 1;
               end
               if (string.sub(tlumaczenie, nr_3, nr_3) == ")") then
                  if (QTR_PS["ownname"] == "1") then -- forma polska
                     QTR_forma = string.sub(tlumaczenie, nr_2 + 1, nr_3 - 1);
                  else                               -- forma angielska
                     QTR_forma = QTR_ReverseIfAR(string.sub(tlumaczenie, nr_1 + 1, nr_2 - 1));
                  end
                  tlumaczenie = string.sub(tlumaczenie, 1, nr_poz - 1) .. QTR_forma .. string.sub(tlumaczenie, nr_3 + 1);
               end
            end
         end
         nr_poz = string.find(tlumaczenie, "$O");
      end
   end

   return tlumaczenie;
end

function U.OkreslKodKoloru(k1, k2, k3)
   local kol1 = ('%.0f'):format(k1);
   local kol2 = ('%.0f'):format(k2);
   local kol3 = ('%.0f'):format(k3);
   local c_out = 'c?';
   if (kol1 == "0" and kol2 == "0" and kol3 == "0") then
      c_out = 'c1';
   elseif (kol1 == "0" and kol2 == "0" and kol3 == "1") then
      c_out = 'c2';
   elseif (kol1 == "0" and kol2 == "1" and kol3 == "0") then
      c_out = 'c3';
   elseif (kol1 == "0" and kol2 == "1" and kol3 == "1") then
      c_out = 'c4';
   elseif (kol1 == "1" and kol2 == "0" and kol3 == "0") then
      c_out = 'c5';
   elseif (kol1 == "1" and kol2 == "0" and kol3 == "1") then
      c_out = 'c6';
   elseif (kol1 == "1" and kol2 == "1" and kol3 == "0") then
      c_out = 'c7';
   else
      c_out = 'c8';
   end
   return c_out;
end

function U.ST_SetText(txt)                               -- funkcja wyszukuje tłumaczenie, albo zapisuje test oryginalny
   if (string.find(txt, NONBREAKINGSPACE) == nil) then -- nie jest to tekst turecki (nie ma twardej spacji na końcu tłumaczenia)
      local ST_hash = StringHash(U.ST_UsunZbedneZnaki(txt));
      if (ST_TooltipsHS[ST_hash]) then
         return ST_TooltipsHS[ST_hash] .. NONBREAKINGSPACE; -- dodajemy twardą spację na końcu tłumaczenia
      elseif (ST_PM["saveNW"] == "1") then                  -- jest zezwolenie na zapis oryginalnego tekstu
         ST_PH[ST_hash] = "ui@" .. U.ST_PrzedZapisem(txt);
      end
   end
   return txt; -- zwracamy oryginalny tekst bez zmiany
end

addon.U = U
