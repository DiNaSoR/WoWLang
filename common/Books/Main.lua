-- Books/Main.lua
-- Modularized Books (letters, notes) translation logic

local addonName, ns = ...
ns = ns or {}
ns.Books = ns.Books or {}
local Books = ns.Books

-- Internal state
local act_tr = "0"         -- current translation toggle state for the open book ("1" = translated)
local bookID = "0"
local title_en, title_tr, text_en, text_tr = "", "", "", ""
local page_str = "1"

local function save_original()
  if (BT_PM and BT_PM["saveNW"] == "1") then
    if (not page_str or page_str == "0") then return end
    if (strlen(page_str) == 1) then page_str = "0" .. page_str end
    local safe_bookID = bookID or tostring(StringHash(text_en))
    BT_SAVED[safe_bookID .. " STR" .. page_str] = (title_en or "") .. "@" .. (text_en or "")
  end
end

-- Toggle translated/original view
function Books.Toggle()
  if (act_tr == "0") then
    act_tr = "1"
    if (BT_PM and BT_PM["title"] == "1" and title_tr) then
      ItemTextFrameTitleText:SetText(title_tr)
    end
    ItemTextPageText:SetText(QTR_ExpandUnitInfo(text_tr, false, ItemTextPageText, WOWTR_Font2, -10))
    if (BT_PM and BT_PM["showID"] == "1") then
      if (WoWTR_Localization.lang == 'AR') then
        BT_ToggleButton0:SetText("("..WoWTR_Localization.lang..") "..bookID.." "..QTR_ReverseIfAR(WoWTR_Localization.bookID))
      else
        BT_ToggleButton0:SetText(WoWTR_Localization.bookID.." "..bookID.." ("..WoWTR_Localization.lang..")")
      end
    else
      BT_ToggleButton0:SetText(WoWTR_Localization.lang)
    end
  else
    act_tr = "0"
    if (BT_PM and BT_PM["title"] == "1") then
      ItemTextFrameTitleText:SetText(title_en)
    end
    ItemTextPageText:SetText(text_en)
    if (BT_PM and BT_PM["showID"] == "1") then
      if (WoWTR_Localization.lang == 'AR') then
        BT_ToggleButton0:SetText("(EN) "..bookID.." "..QTR_ReverseIfAR(WoWTR_Localization.bookID))
      else
        BT_ToggleButton0:SetText(WoWTR_Localization.bookID.." "..bookID.." (EN)")
      end
    else
      BT_ToggleButton0:SetText("EN")
    end
  end
end

-- Show translation for current ItemText page
function Books.ShowTranslation()
  if not BT_PM or BT_PM["active"] ~= "1" then
    if BT_ToggleButton0 then BT_ToggleButton0:Hide() end
    return
  end

  if BT_ToggleButton0 then
    BT_ToggleButton0:Show(); BT_ToggleButton0:Disable(); BT_ToggleButton0:SetText("EN"); BT_ToggleButton0:SetWidth(40)
  end
  act_tr = "0"

  title_en = ItemTextGetItem() or ""
  text_en = WOWTR_DetectAndReplacePlayerName(ItemTextGetText(), nil, "$N") or ""
  page_str = tostring(ItemTextGetPage() or "1")
  if (not page_str or page_str == "nil" or page_str == "") then page_str = '1' end

  local _, link = C_Item.GetItemInfo(ItemTextGetItem())
  local hashID = tostring(StringHash(text_en))
  bookID = nil
  if link and type(link) == "string" then
    local _, itemID = strsplit(":", link)
    if itemID and tonumber(itemID) then bookID = tostring(itemID) end
  end

  if ((not bookID) or (bookID == "") or (bookID == "|Hitem")) then
    if title_en == "Plain Letter" or title_en == "Order of Night Propaganda" or (BT_Books and BT_Books[tostring(StringHash(text_en))]) then
      bookID = tostring(StringHash(text_en))
    else
      local beginTXT = string.gsub(text_en, "\n", "")
      local marker = (title_en or "") .. "#" .. page_str .. "#" .. string.sub(beginTXT, 1, 15)
      bookID = BT_BooksID and BT_BooksID[marker] or tostring(StringHash(text_en))
    end
  end
  if (not bookID) then
    local beginTXT = string.gsub(text_en, "\n", "")
    local marker = (title_en or "") .. "#" .. page_str .. "#" .. string.sub(beginTXT, 1, 15)
    bookID = BT_BooksID and BT_BooksID[marker] or hashID
  end

  if ((not bookID) or (bookID == "") or (bookID == "|Hitem")) then
    save_original(); return
  end

  if BT_Books and BT_Books[bookID] then
    local hasPage = BT_Books[bookID][page_str]
    local hasTitle = (BT_PM and BT_PM["title"] == "1" and BT_Books[bookID].Title and BT_Books[bookID].Title ~= '')
    if hasPage or hasTitle then
      if hasTitle then
        title_tr = BT_Books[bookID]["Title"]
        ItemTextFrameTitleText:SetText(QTR_ReverseIfAR(title_tr))
        ItemTextFrameTitleText:SetFont(WOWTR_Font2, 11)
      end

      text_tr = BT_Books[bookID][page_str] or ""
      text_tr = string.gsub(text_tr, "$b", "$B")
      text_tr = string.gsub(text_tr, "$B", "\n")
      text_tr = string.gsub(text_tr, "$N", WOWTR_player_name or "")
      text_tr = string.gsub(text_tr, "$o", "$O")

      local pos = string.find(text_tr, "$O")
      while pos and pos > 0 do
        local n1 = pos + 1
        while string.sub(text_tr, n1, n1) ~= "(" do n1 = n1 + 1 end
        local n2 = n1 + 1
        while string.sub(text_tr, n2, n2) ~= ";" do n2 = n2 + 1 end
        local n3 = n2 + 1
        while string.sub(text_tr, n3, n3) ~= ")" do n3 = n3 + 1 end
        local forma
        if QTR_PS and QTR_PS["ownname"] == "1" then
          forma = string.sub(text_tr, n2 + 1, n3 - 1)
        else
          forma = string.sub(text_tr, n1 + 1, n2 - 1)
        end
        text_tr = string.sub(text_tr, 1, pos - 1) .. forma .. string.sub(text_tr, n3 + 1)
        pos = string.find(text_tr, "$O", pos + 1)
      end

      local font, size, flags = ItemTextPageText:GetFont("P")
      if (BT_PM and BT_PM["setsize"] == "1") then
        ItemTextPageText:SetFont("P", WOWTR_Font2, tonumber(BT_PM["fontsize"]) or size, flags)
      else
        ItemTextPageText:SetFont("P", WOWTR_Font2, size, flags)
      end
      ItemTextPageText:SetText(QTR_ExpandUnitInfo(text_tr, false, ItemTextPageText, WOWTR_Font2, -10))

      if (BT_PM and BT_PM["showID"] == "1" and BT_ToggleButton0) then
        local fo = BT_ToggleButton0:CreateFontString()
        if fo and fo.SetFont then
          fo:SetFont(WOWTR_Font2, 13)
          if (WoWTR_Localization.lang == 'AR') then
            fo:SetText("("..WoWTR_Localization.lang..") "..bookID.." "..QTR_ReverseIfAR(WoWTR_Localization.bookID))
          else
            fo:SetText(WoWTR_Localization.bookID.." "..bookID.." ("..WoWTR_Localization.lang..")")
          end
          BT_ToggleButton0:SetFontString(fo)
        end
        if (WoWTR_Localization.lang == 'AR') then
          BT_ToggleButton0:SetText("("..WoWTR_Localization.lang..") "..bookID.." "..QTR_ReverseIfAR(WoWTR_Localization.bookID))
        else
          BT_ToggleButton0:SetText(WoWTR_Localization.bookID.." "..bookID.." ("..WoWTR_Localization.lang..")")
        end
        BT_ToggleButton0:SetWidth(170)
      elseif BT_ToggleButton0 then
        BT_ToggleButton0:SetText(WoWTR_Localization.lang)
      end

      if BT_ToggleButton0 then BT_ToggleButton0:Enable() end
      act_tr = "1"
    else
      save_original()
    end
  else
    save_original()
  end
end

-- Global wrappers for back-compat with Core hooks
function BookTranslator_ShowTranslation() return Books.ShowTranslation() end
function BT_ON_OFF() return Books.Toggle() end

