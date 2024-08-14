-- Japońska baza przetłumaczonych tekstów (ONLINE)
-- dodatku WoWinJapanese (https://wowpopolsku.pl)

TO_lang = "JP";
TO_date = "2021-01-31";
TO_base = "??";

-- tabela tłumaczeń ONLINE
QTR_Tlumacz_Online = {
};

function pairsByKeys (t)
   local a = {}
   for n in pairs(t) do table.insert(a, n) end
   table.sort(a, function(a, b) return a > b end)
   local i = 0      -- iterator variable
   local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
         else return a[i], t[a[i]]
      end
   end
   return iter
end

