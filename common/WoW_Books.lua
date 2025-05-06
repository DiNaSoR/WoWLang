-- Description: The AddOn displays the translated text information in chosen language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
-------------------------------------------------------------------------------------------------------

-- Local Variables
local BT_act_tr = "0";
local BT_bookID = "0";
local BT_tytul_en, BT_tytul_tr, BT_tekst_en, BT_tekst_tr = "";

-------------------------------------------------------------------------------------------------------

function BookTranslator_ShowTranslation()
   if (BT_PM["active"] == "1") then
      BT_ToggleButton0:Show();
      BT_ToggleButton0:Disable();
      BT_ToggleButton0:SetText("EN");
      BT_ToggleButton0:SetWidth(40);
      BT_act_tr = "0";

      -- Metin bilgilerini al (Get text information) (Pobierz informacje tekstowe)
      BT_tytul_en = ItemTextGetItem();
      BT_tekst_en = WOWTR_DetectAndReplacePlayerName(ItemTextGetText(), nil, "$N");
      BT_nr_str = tostring(ItemTextGetPage());

      -- Sayfa numarası geçerli mi? (Check page number validity) (Sprawdź poprawność numeru strony)
      if (not BT_nr_str or BT_nr_str == "nil" or BT_nr_str == "") then
         BT_nr_str = '1';
      end

      local par1, par2, par3 = C_Item.GetItemInfo(ItemTextGetItem());
      local BT_bookIDsh = tostring(StringHash(BT_tekst_en));

      -- Gerçek itemID'yi önceliklendir (Prioritize real itemID) (Uwzględnij rzeczywiste ID przedmiotu)
      BT_bookID = nil;
      if par2 and type(par2) == "string" then
         local _, itemID, _ = strsplit(":", par2);
         if itemID and tonumber(itemID) then
            BT_bookID = itemID;  -- Gerçek itemID kullan (Use actual itemID) (Użyj rzeczywistego ID przedmiotu)
         end
      end

      -- itemID yoksa hash tabanlı ID kullan (If no itemID, use hash-based ID) (Jeśli brak ID, użyj ID opartego na hash)
      if not BT_bookID or BT_bookID == "" or BT_bookID == "|Hitem" then
         if BT_tytul_en == "Plain Letter" or BT_tytul_en == "Order of Night Propaganda" or BT_Books[tostring(StringHash(BT_tekst_en))] then
            BT_bookID = tostring(StringHash(BT_tekst_en));
         else
            local BT_beginTXT = string.gsub(BT_tekst_en, "\n", "");
            local BT_znacznik = BT_tytul_en .. "#" .. BT_nr_str .. "#" .. string.sub(BT_beginTXT, 1, 15);
            BT_bookID = BT_BooksID and BT_BooksID[BT_znacznik] or tostring(StringHash(BT_tekst_en));
         end
      end

      -- Geçerli bir bookID var mı? (Is there a valid bookID?) (Czy istnieje poprawne ID książki?)
      if not BT_bookID or BT_bookID == "" or BT_bookID == "|Hitem" then
         BT_save_original();
         return;
      end

      -- Eğer hala yoksa hash ile ayarla (If still missing, assign via hash) (Jeśli nadal brak, przypisz przez hash)
      if not BT_bookID then
         local BT_beginTXT = string.gsub(BT_tekst_en, "\n", "");
         local BT_znacznik = BT_tytul_en .. "#" .. BT_nr_str .. "#" .. string.sub(BT_beginTXT, 1, 15);
         BT_bookID = BT_BooksID and BT_BooksID[BT_znacznik] or BT_bookIDsh;
      end

      -- Çeviri mevcut mu? (Is translation available?) (Czy tłumaczenie jest dostępne?)
      if BT_Books and BT_Books[BT_bookID] then
         if BT_Books[BT_bookID][BT_nr_str] or (BT_PM["title"] == "1" and BT_Books[BT_bookID].Title and BT_Books[BT_bookID].Title ~= '') then

            -- Başlık çevirisi varsa göster (Show title translation if exists) (Wyświetl tytuł jeśli istnieje tłumaczenie)
            if BT_PM["title"] == "1" and BT_Books[BT_bookID].Title and BT_Books[BT_bookID].Title ~= '' then
               BT_tytul_tr = BT_Books[BT_bookID]["Title"];
               ItemTextFrameTitleText:SetText(QTR_ReverseIfAR(BT_tytul_tr));
               ItemTextFrameTitleText:SetFont(WOWTR_Font2, 11);
            end

            -- İçerik çevirisi (Content translation) (Tłumaczenie treści)
            BT_tekst_tr = string.gsub(BT_Books[BT_bookID][BT_nr_str], "$b", "$B");
            BT_tekst_tr = string.gsub(BT_tekst_tr, "$B", "\n");
            BT_tekst_tr = string.gsub(BT_tekst_tr, "$N", WOWTR_player_name);

            -- $O kodu için çeviriler (Handling $O code for gender/person) ($O - obsługa form osobowych)
            BT_tekst_tr = string.gsub(BT_tekst_tr, "$o", "$O");
            local nr_poz = string.find(BT_tekst_tr, "$O");

            while nr_poz and nr_poz > 0 do
               local nr_1 = nr_poz + 1;
               while string.sub(BT_tekst_tr, nr_1, nr_1) ~= "(" do
                  nr_1 = nr_1 + 1;
               end
               local nr_2 = nr_1 + 1;
               while string.sub(BT_tekst_tr, nr_2, nr_2) ~= ";" do
                  nr_2 = nr_2 + 1;
               end
               local nr_3 = nr_2 + 1;
               while string.sub(BT_tekst_tr, nr_3, nr_3) ~= ")" do
                  nr_3 = nr_3 + 1;
               end

               local QTR_forma = "";
               if QTR_PS["ownname"] == "1" then
                  QTR_forma = string.sub(BT_tekst_tr, nr_2 + 1, nr_3 - 1);
               else
                  QTR_forma = string.sub(BT_tekst_tr, nr_1 + 1, nr_2 - 1);
               end

               BT_tekst_tr = string.sub(BT_tekst_tr, 1, nr_poz - 1) ..
                             QTR_forma ..
                             string.sub(BT_tekst_tr, nr_3 + 1);

               nr_poz = string.find(BT_tekst_tr, "$O", nr_poz + 1);
            end

            -- Yazı tipi ayarları (Font settings) (Ustawienia czcionki)
            local a1, a2, a3 = ItemTextPageText:GetFont("P");
            if (BT_PM["setsize"] == "1") then
               ItemTextPageText:SetFont("P", WOWTR_Font2, tonumber(BT_PM["fontsize"]), a3);
            else
               ItemTextPageText:SetFont("P", WOWTR_Font2, a2, a3);
            end

            ItemTextPageText:SetText(QTR_ExpandUnitInfo(BT_tekst_tr, false, ItemTextPageText, WOWTR_Font2, -10));

            -- ID Gösterme Ayarı (Show Book ID Option) (Opcja pokazywania ID książki)
            if (BT_PM["showID"] == "1") then
               local fo = BT_ToggleButton0:CreateFontString();
               if fo and fo.SetFont then
                  fo:SetFont(WOWTR_Font2, 13);
                  if (WoWTR_Localization.lang == 'AR') then
                     fo:SetText("("..WoWTR_Localization.lang..") "..BT_bookID.." "..QTR_ReverseIfAR(WoWTR_Localization.bookID));
                  else
                     fo:SetText(WoWTR_Localization.bookID.." "..BT_bookID.." ("..WoWTR_Localization.lang..")");
                  end
                  BT_ToggleButton0:SetFontString(fo);
               end
               if (WoWTR_Localization.lang == 'AR') then
                  BT_ToggleButton0:SetText("("..WoWTR_Localization.lang..") "..BT_bookID.." "..QTR_ReverseIfAR(WoWTR_Localization.bookID));
               else
                  BT_ToggleButton0:SetText(WoWTR_Localization.bookID.." "..BT_bookID.." ("..WoWTR_Localization.lang..")");
               end
               BT_ToggleButton0:SetWidth(170);
            else
               BT_ToggleButton0:SetText(WoWTR_Localization.lang);
            end

            BT_ToggleButton0:Enable();
            BT_act_tr = "1"; -- Tercüme aktif (Translation active) (Tłumaczenie aktywne)
         else
            BT_save_original(); -- Sayfa yoksa orijinal göster (Show original if page missing) (Pokaż oryginał jeśli brak strony)
         end
      else
         BT_save_original(); -- Kitap yoksa orijinal göster (Show original if book missing) (Pokaż oryginał jeśli brak książki)
      end
   else
      BT_ToggleButton0:Hide();
   end
end

-------------------------------------------------------------------------------------------------------

function BT_save_original()
   if (BT_PM["saveNW"] == "1") then
      if (not BT_nr_str or BT_nr_str == "0") then return; end
      if (strlen(BT_nr_str) == 1) then
         BT_nr_str = "0" .. BT_nr_str;
      end

      -- Eğer BT_bookID nil ise, hash ile geçici ID oluştur
      local safe_bookID = BT_bookID or tostring(StringHash(BT_tekst_en));

      -- Kaydet
      BT_SAVED[safe_bookID .. " STR" .. BT_nr_str] = BT_tytul_en .. "@" .. BT_tekst_en;
   end
end

-------------------------------------------------------------------------------------------------------

function BT_ON_OFF()
   if (BT_act_tr == "0") then
      BT_act_tr = "1";
      if ((BT_PM["title"] == "1") and BT_tytul_tr) then            -- wyświetlaj tłumaczenie tytułu
         ItemTextFrameTitleText:SetText(BT_tytul_tr);
      end
      ItemTextPageText:SetText(QTR_ExpandUnitInfo(BT_tekst_tr,false,ItemTextPageText,WOWTR_Font2,-10));
      if (BT_PM["showID"]=="1") then             -- pokaż ID książki
         if (WoWTR_Localization.lang == 'AR') then
            BT_ToggleButton0:SetText("("..WoWTR_Localization.lang..") "..BT_bookID.." "..QTR_ReverseIfAR(WoWTR_Localization.bookID));
         else
            BT_ToggleButton0:SetText(WoWTR_Localization.bookID.." "..BT_bookID.." ("..WoWTR_Localization.lang..")");     -- Book ID:
         end
      else
         BT_ToggleButton0:SetText(WoWTR_Localization.lang);
      end
   else
      BT_act_tr = "0";
      if (BT_PM["title"] == "1") then            -- wyświetlaj tłumaczenie tytułu
         ItemTextFrameTitleText:SetText(BT_tytul_en);
      end
      ItemTextPageText:SetText(BT_tekst_en);
      if (BT_PM["showID"]=="1") then             -- pokaż ID książki
         if (WoWTR_Localization.lang == 'AR') then
            BT_ToggleButton0:SetText("(EN) "..BT_bookID.." "..QTR_ReverseIfAR(WoWTR_Localization.bookID));
         else
            BT_ToggleButton0:SetText(WoWTR_Localization.bookID.." "..BT_bookID.." (EN)");
         end
      else
         BT_ToggleButton0:SetText("EN");
      end   
   end  
end
