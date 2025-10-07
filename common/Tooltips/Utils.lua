local addonName, ns = ...

ns = ns or {}
ns.Tooltips = ns.Tooltips or {}
local Tooltips = ns.Tooltips
local S = (ns.Tooltips and ns.Tooltips.State) or {}

ns.Tooltips.Utils = ns.Tooltips.Utils or {}
local U = ns.Tooltips.Utils

-- Ignore settings used when saving untranslated lines from tooltips
U.ignoreSettings = {
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

-- Text preprocessing and application helpers extracted from WoW_Tooltips.lua

-- Remove color codes, numbers and normalize text before hashing
function ST_UsunZbedneZnaki(txt)
  if (not txt) then return "" end
  local text = string.gsub(txt, "|cFFFFFFFF", "")
  text = string.gsub(text, "|r", "")
  text = string.gsub(text, "\r", "")
  text = string.gsub(text, "\n", "")
  if _G.WOWTR_player_name then
    text = string.gsub(text, '%f[%a]' .. _G.WOWTR_player_name .. '%f[%A]', "$N")
  end
  text = string.gsub(text, "(%d),(%d)", "%1%2")
  text = string.gsub(text, "0", "")
  text = string.gsub(text, "1", "")
  text = string.gsub(text, "2", "")
  text = string.gsub(text, "3", "")
  text = string.gsub(text, "4", "")
  text = string.gsub(text, "5", "")
  text = string.gsub(text, "6", "")
  text = string.gsub(text, "7", "")
  text = string.gsub(text, "8", "")
  text = string.gsub(text, "9", "")
  return text
end

function ST_PrzedZapisem(txt)
  local text = string.gsub(txt or "", "(%d),(%d)", "%1%2")
  text = string.gsub(text, "\r", "")
  if _G.WOWTR_player_name then
    text = string.gsub(text, '%f[%a]' .. _G.WOWTR_player_name .. '%f[%A]', "$N")
  end
  return text
end

function ST_RenkKoduSil(txt)
  if (not txt) then return "" end
  local text = string.gsub(txt, "|r", "")
  text = string.gsub(text, "Dragon Isles ", "")
  text = string.gsub(text, " Specializations", "")
  text = string.gsub(text, "Classic ", "")
  text = string.gsub(text, "|cffffd100", "")
  text = string.gsub(text, "|cff0070dd", "")
  text = string.gsub(text, "|cffffffff", "")
  text = string.gsub(text, "|cff1eff00", "")
  text = string.gsub(text, "|cffa335ee", "")
  text = string.gsub(text, "|cffffd200", "")
  return text
end

function OkreslKodKoloru(k1, k2, k3)
  local kol1 = ('%.0f'):format(k1)
  local kol2 = ('%.0f'):format(k2)
  local kol3 = ('%.0f'):format(k3)
  local c_out = 'c?'
  if (kol1 == "0" and kol2 == "0" and kol3 == "0") then
    c_out = 'c1'
  elseif (kol1 == "0" and kol2 == "0" and kol3 == "1") then
    c_out = 'c2'
  elseif (kol1 == "0" and kol2 == "1" and kol3 == "0") then
    c_out = 'c3'
  elseif (kol1 == "0" and kol2 == "1" and kol3 == "1") then
    c_out = 'c4'
  elseif (kol1 == "1" and kol2 == "0" and kol3 == "0") then
    c_out = 'c5'
  elseif (kol1 == "1" and kol2 == "0" and kol3 == "1") then
    c_out = 'c6'
  elseif (kol1 == "1" and kol2 == "1" and kol3 == "0") then
    c_out = 'c7'
  else
    c_out = 'c8'
  end
  return c_out
end

-- Forwarders to ns.Text wrappers; keep global names for back-compat usage elsewhere
local function ExpandUnit(text, isTooltip, obj, font, offset, noWrap)
  if _G.QTR_ExpandUnitInfo then
    return QTR_ExpandUnitInfo(text, isTooltip, obj, font, offset, noWrap)
  end
  return text
end

local function ReverseIfAR(text)
  if _G.QTR_ReverseIfAR then
    return QTR_ReverseIfAR(text)
  end
  return text
end

-- Translate prepare (moved, exact logic stays in original file; proxy here)
function ST_TranslatePrepare(origin, tlumacz)
  if _G.ST_TranslatePrepare and _G.ST_TranslatePrepare ~= ST_TranslatePrepare then
    return _G.ST_TranslatePrepare(origin, tlumacz)
  end
  -- Fallback minimal: just return provided translation
  return tlumacz
end

-- Apply translation to a FontString-like object; mirrors original signature
function ST_CheckAndReplaceTranslationText(obj, sav, prefix, font1, onlyReverse, ST_corr, justifyAlign)
  if not (obj and obj.GetText) then return end
  local txt = obj:GetText()
  if not txt or string.find(txt, NONBREAKINGSPACE) ~= nil then return end

  local hash = StringHash(ST_UsunZbedneZnaki(txt))
  local hs = rawget(_G, "ST_TooltipsHS")
  local tr = hs and hs[hash]
  if tr then
    local processed
    if onlyReverse then
      processed = ReverseIfAR(tr) .. NONBREAKINGSPACE
    else
      processed = ExpandUnit(ST_TranslatePrepare(txt, tr), true, obj, font1 or _G.WOWTR_Font2, ST_corr) .. NONBREAKINGSPACE
    end
    obj:SetText(processed)
    if obj.SetFont and _G.WOWTR_Font2 then
      local _, size, flags = obj:GetFont()
      obj:SetFont(font1 or _G.WOWTR_Font2, size or 12, flags)
    end
    if justifyAlign and obj.SetJustifyH then
      obj:SetJustifyH(justifyAlign)
    end
  elseif sav and _G.ST_PM and _G.ST_PM["saveNW"] == "1" then
    _G.ST_PH = _G.ST_PH or {}
    _G.ST_PH[hash] = (prefix or "") .. "@" .. ST_PrzedZapisem(txt)
  end
end

function ST_CheckAndReplaceTranslationTextUI(obj, sav, prefix, font1)
  if not (obj and obj.GetText) then return end
  local txt = obj:GetText()
  if not txt or string.find(txt, NONBREAKINGSPACE) ~= nil then return end
  local hash = StringHash(ST_UsunZbedneZnaki(txt))
  local hs = rawget(_G, "ST_TooltipsHS")
  local tr = hs and hs[hash]
  if tr then
    obj:SetText(ReverseIfAR(ST_TranslatePrepare(txt, tr)) .. NONBREAKINGSPACE)
    if obj.SetFont and _G.WOWTR_Font2 then
      local _, size, flags = obj:GetFont()
      obj:SetFont(font1 or _G.WOWTR_Font2, size or 12, flags)
    end
  elseif sav and _G.TT_PS and _G.TT_PS["saveui"] == "1" then
    _G.ST_PH = _G.ST_PH or {}
    _G.ST_PH[hash] = (prefix or "") .. "@" .. ST_PrzedZapisem(txt)
  end
end

-- Convenience wrapper retained for modules that call it directly
function ST_SetText(txt)
  local hash = StringHash(ST_UsunZbedneZnaki(txt or ""))
  local hs = rawget(_G, "ST_TooltipsHS")
  local tr = hs and hs[hash]
  if tr then
    return ST_TranslatePrepare(txt, tr)
  end
  return txt
end

return Tooltips


