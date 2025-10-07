local addonName, ns = ...

ns = ns or {}
ns.Tooltips = ns.Tooltips or {}
local Tooltips = ns.Tooltips
local State = (Tooltips and Tooltips.State) or {}

Tooltips.GameTooltip = Tooltips.GameTooltip or {}
local GT = Tooltips.GameTooltip
local Utils = (ns.Tooltips and ns.Tooltips.Utils) or {}
local ignoreSettings = (Utils and Utils.ignoreSettings) or { words = {}, pattern = "" }

-- Placeholder handler; legacy global remains authoritative until full migration.
function GT.OnShow()
  if (ST_PM and ST_PM["active"] == "1") then
    ST_lastNumLines = 0
    local elvBuffs = rawget(_G, "ElvUIPlayerBuffs")
    local elvDebuffs = rawget(_G, "ElvUIPlayerDebuffs")
    local ST_BFisOver = (BuffFrame and BuffFrame:IsMouseOver()) or (elvBuffs and elvBuffs:IsMouseOver())
    local ST_DFisOver = (DebuffFrame and DebuffFrame:IsMouseOver()) or (elvDebuffs and elvDebuffs:IsMouseOver())
    if (ST_BFisOver or ST_DFisOver) then
      GT.BuffOrDebuff()
      return
    end

    GameTooltip.updateTooltipTimer = tonumber(ST_PM["timer"])
    if (_G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText()) then
      if (string.find(_G["GameTooltipTextLeft1"]:GetText(), NONBREAKINGSPACE)) then
        return
      end
      _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(_G["GameTooltipTextLeft1"]:GetText(), WOWTR_Font2) .. NONBREAKINGSPACE)
    end

    local ST_prefix = "h"
    local gtProc = GameTooltip and rawget(GameTooltip, "processingInfo")
    local gtData = gtProc and gtProc.tooltipData or nil
    if (gtData and gtData.id) then
      if (gtData.type == 0) then
        ST_prefix = "i" .. gtData.id
        if (ST_PM["item"] == "0") then
          return
        end
      elseif (gtData.type == 1) then
        if ST_IsTalentTooltip and ST_IsTalentTooltip(gtData) then
          ST_prefix = "t" .. gtData.id
          if (ST_PM["talent"] == "0") then
            return
          end
        else
          ST_prefix = "s" .. gtData.id
          if (ST_PM["spell"] == "0") then
            return
          end
        end
      else
        ST_prefix = "s" .. gtData.id
        if (ST_PM["spell"] == "0") and (gtData.id == 9) then
          return
        end
      end
    end

    local numLines = GameTooltip:NumLines()
    if ((numLines == 1) and (ST_prefix ~= "h")) then
      return
    end

    local ST_kodKoloru
    local ST_leftText, ST_rightText, ST_tlumaczenie, ST_hash, ST_hash2, ST_pomoc5, ST_pomoc6, ST_pomoc7
    local _font1, _size1, _1
    local ST_odstep = true
    local ST_orygText = {}
    local ST_nh = 0

    local moneyFrameLineNumber = {}
    local money = {}
    table.insert(moneyFrameLineNumber, 0)
    table.insert(money, 0)
    local shownMoneyFrames = GameTooltip and rawget(GameTooltip, "shownMoneyFrames")
    if (shownMoneyFrames) then
      for i = 1, shownMoneyFrames, 1 do
        local moneyFrameName = GameTooltip:GetName() .. "MoneyFrame" .. i
        _G[moneyFrameName .. "PrefixText"]:SetText(QTR_ReverseIfAR(WoWTR_Localization.sellPrice))
        _font1, _size1, _1 = _G[moneyFrameName .. "PrefixText"]:GetFont()
        _G[moneyFrameName .. "PrefixText"]:SetFont(WOWTR_Font2, _size1)
        if (ST_PM["sellprice"] == "1") then
          _G[moneyFrameName]:Hide()
          ST_odstep = false
        end
      end
    end

    local ST_fromLine = 2
    if (ST_prefix == "h") then
      ST_fromLine = 1
    end

    local ST_TooltipsID_gl = rawget(_G, "ST_TooltipsID")
    if (ST_TooltipsID_gl and (ST_PM["transtitle"] == "1") and ST_TooltipsID_gl[ST_prefix]) then
      _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(ST_TooltipsID_gl[ST_prefix], WOWTR_Font2) .. NONBREAKINGSPACE)
      _font1, _size1, _1 = _G["GameTooltipTextLeft1"]:GetFont()
      _G["GameTooltipTextLeft1"]:SetFont(WOWTR_Font2, _size1)
    end

    local lineObj = _G["GameTooltipTextLeft1"]
    local originalFont, originalSize, originalFlags = lineObj:GetFont()

    for i = ST_fromLine, numLines, 1 do
      ST_leftText = _G["GameTooltipTextLeft" .. i]:GetText()
      if (ST_leftText and (string.find(ST_leftText, NONBREAKINGSPACE) == nil)) then
        leftColR, leftColG, leftColB = _G["GameTooltipTextLeft" .. i]:GetTextColor()
        ST_kodKoloru = OkreslKodKoloru(leftColR, leftColG, leftColB)
        if (ST_leftText and (string.len(ST_leftText) > 15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText) > 30))) then
          local gtProc2 = GameTooltip and rawget(GameTooltip, "processingInfo")
          local gtData2 = gtProc2 and gtProc2.tooltipData or nil
          if (gtData2 and gtData2.id and (gtData2.id == 6948)) then
            ST_pomoc5, _ = string.find(ST_leftText, ". Speak")
            if (ST_pomoc5 and (ST_pomoc5 > 22)) then
              ST_miasto = string.sub(ST_leftText, 21, ST_pomoc5 - 1)
            else
              ST_miasto = WoWTR_Localization.your_home
            end
            ST_pomoc6, _ = string.find(ST_leftText, ' Min Cooldown)')
            if (ST_pomoc6) then
              ST_hash = 1336493626
            else
              ST_hash = 3076025968
            end
          else
            ST_hash = StringHash(ST_UsunZbedneZnaki(ST_leftText))
          end
          if (((ST_kodKoloru == "c7") or (string.len(ST_leftText) > 30)) and (not ST_hash2)) then
            ST_hash2 = ST_hash
          end
          ST_pomoc7, _ = string.find(ST_leftText, "<Made by")
          if (ST_pomoc7) then
            ST_hash = 1381871427
          end
          if (ST_TooltipsHS and ST_TooltipsHS[ST_hash]) then
            if (ST_pomoc7) then
              local endBy = string.find(ST_leftText, ">")
              local nameBy = string.sub(ST_leftText, ST_pomoc7 + 9, endBy - 1)
              ST_tlumaczenie = ST_TooltipsHS[ST_hash]
              if (WoWTR_Localization.lang == 'AR') then
                ST_tlumaczenie = string.gsub(ST_tlumaczenie, "NAMEBY", string.reverse(nameBy))
                ST_tlumaczenie = string.gsub(ST_tlumaczenie, "{$M}", string.reverse(nameBy))
              else
                ST_tlumaczenie = string.gsub(ST_tlumaczenie, "$M", nameBy)
              end
            else
              ST_tlumaczenie = ST_TooltipsHS[ST_hash]
            end
            ST_tlumaczenie = ST_TranslatePrepare(ST_leftText, ST_tlumaczenie)
            _font1, _size1, _1 = _G["GameTooltipTextLeft" .. i]:GetFont()
            _G["GameTooltipTextLeft" .. i]:SetFont(WOWTR_Font2, _size1)
            _G["GameTooltipTextLeft" .. i]:SetText(QTR_ExpandUnitInfo(ST_tlumaczenie, false, _G["GameTooltipTextLeft" .. i], WOWTR_Font2, -5) .. NONBREAKINGSPACE)
            _G["GameTooltipTextLeft" .. i].wrap = true
            local gtProc3 = GameTooltip and rawget(GameTooltip, "processingInfo")
            local gtData3 = gtProc3 and gtProc3.tooltipData or nil
            if (gtData3 and gtData3.id and (gtData3.id == 6948)) then
              break
            end
          else
            if lineObj.SetFont then
              lineObj:SetFont(originalFont, originalSize, originalFlags)
            end
            ST_nh = 1
            table.insert(ST_orygText, ST_leftText)
          end
        end
      end
    end

    if (((ST_PM["showID"] == "1") and (string.len(ST_prefix) > 1)) or ((ST_PM["showHS"] == "1") and ST_hash2)) then
      numLines = GameTooltip:NumLines()
      if (numLines > 0 and ST_odstep) then
        GameTooltip:AddLine(" ", 0, 0, 0)
      end
      local typName = " "
      if (string.sub(ST_prefix, 1, 1) == "i") then
        typName = "Item"
        ST_ID = string.sub(ST_prefix, 2)
      elseif (string.sub(ST_prefix, 1, 1) == "s") then
        typName = "Spell"
        ST_ID = string.sub(ST_prefix, 2)
      elseif (string.sub(ST_prefix, 1, 1) == "t") then
        typName = "Talent"
        ST_ID = string.sub(ST_prefix, 2)
      else
        ST_ID = nil
      end
      if ((ST_PM["showID"] == "1") and ST_ID) then
        GameTooltip:AddLine(typName .. " ID: " .. tostring(ST_ID), 0, 1, 1)
        numLines = GameTooltip:NumLines()
        _G["GameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 12)
        _G["GameTooltipTextRight" .. numLines]:SetFont(WOWTR_Font2, 12)
      end
      if ((ST_PM["showHS"] == "1") and ST_hash2) then
        GameTooltip:AddLine("Hash: " .. tostring(ST_hash2), 0, 1, 1)
        numLines = GameTooltip:NumLines()
        _G["GameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 12)
        _G["GameTooltipTextRight" .. numLines]:SetFont(WOWTR_Font2, 12)
      end
    end

    if ((ST_PM["constantly"] == "1") and (UnitLevel("player") > 60) and _G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText()) then
      _G["GameTooltipTextLeft1"]:SetText(QTR_ExpandUnitInfo(_G["GameTooltipTextLeft1"]:GetText(), WOWTR_Font2) .. NONBREAKINGSPACE)
    end
    GameTooltip:Show()
    ST_lastNumLines = GameTooltip:NumLines()

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

-- Migrate selected helpers for future use by Hooks when we switch over
function GT.IsBuffOrDebuffTooltip()
  local elvBuff = rawget(_G, "ElvUIPlayerBuffs")
  local elvDebuff = rawget(_G, "ElvUIPlayerDebuffs")
  local isBuff = BuffFrame and BuffFrame:IsMouseOver()
  local isDebuff = DebuffFrame and DebuffFrame:IsMouseOver()
  local isElvBuff = elvBuff and elvBuff:IsMouseOver()
  local isElvDebuff = elvDebuff and elvDebuff:IsMouseOver()
  return (isBuff or isDebuff or isElvBuff or isElvDebuff) and true or false
end

function GT.ElvSpellBookTooltipOnShow()
  local elvUI = rawget(_G, "ElvUI")
  if not elvUI then return end
  local E, L, V, P, G = unpack(elvUI)
  local ElvUISpellBookTooltip = E and E.SpellBookTooltip
  if not ElvUISpellBookTooltip then return end
  local numLines = ElvUISpellBookTooltip:NumLines()
  if (numLines == 1) then return end
  if (ST_PM and ST_PM["spell"] == "0") then return end

  local ST_kodKoloru
  local ST_leftText, ST_rightText, ST_tlumaczenie, ST_hash, ST_hash2
  local _font1, _size1, _1
  local ST_prefix = "s"
  local procInfo = rawget(ElvUISpellBookTooltip, "processingInfo")
  local ttData = procInfo and procInfo.tooltipData or nil
  if (ttData and ttData.id) then
    ST_prefix = ST_prefix .. ttData.id
  end
  ElvUISpellBookTooltip:HookScript("OnHide", function() ST_MyGameTooltip:Hide() end)
  ST_MyGameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
  ST_MyGameTooltip:ClearAllPoints()
  ST_MyGameTooltip:SetPoint("TOPLEFT", ElvUISpellBookTooltip, "BOTTOMLEFT", 0, 0)
  ST_MyGameTooltip:ClearLines()
  for i = 2, numLines - 1, 1 do
    ST_leftText = _G[ElvUISpellBookTooltip:GetName() .. "TextLeft" .. i]:GetText()
    leftColR, leftColG, leftColB = _G[ElvUISpellBookTooltip:GetName() .. "TextLeft" .. i]:GetTextColor()
    ST_kodKoloru = OkreslKodKoloru(leftColR, leftColG, leftColB)
    if (ST_leftText and (string.len(ST_leftText) > 15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText) > 30))) then
      ST_hash = StringHash(ST_UsunZbedneZnaki(ST_leftText))
      if (((ST_kodKoloru == "c7") or (string.len(ST_leftText) > 30)) and (not ST_hash2)) then
        ST_hash2 = ST_hash
      end
      if (ST_TooltipsHS and ST_TooltipsHS[ST_hash]) then
        ST_tlumaczenie = ST_TooltipsHS[ST_hash]
        ST_tlumaczenie = ST_TranslatePrepare(ST_leftText, ST_tlumaczenie)
        ST_MyGameTooltip:AddLine(QTR_ReverseIfAR(ST_tlumaczenie), leftColR, leftColG, leftColB, true)
        numLines = ST_MyGameTooltip:NumLines()
        _font1, _size1, _1 = _G[ElvUISpellBookTooltip:GetName() .. "TextLeft" .. i]:GetFont()
        _G["ST_MyGameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 11)
      end
    end
  end

  if (((ST_PM["showID"] == "1") and (string.len(ST_prefix) > 1)) or ((ST_PM["showHS"] == "1") and ST_hash2)) then
    numLines = ST_MyGameTooltip:NumLines()
    if (numLines == 0) then
      local qtrMsg = rawget(_G, "QTR_Messages")
      ST_MyGameTooltip:AddLine((qtrMsg and qtrMsg.missing) or "Missing", 1, 1, 0.5)
      _G["ST_MyGameTooltipTextLeft1"]:SetFont(WOWTR_Font2, 11)
    end
    ST_MyGameTooltip:AddLine(" ", 0, 0, 0)
    local typName = "Spell"
    local ST_ID = string.sub(ST_prefix, 2)
    if ((ST_PM["showID"] == "1") and ST_ID) then
      ST_MyGameTooltip:AddLine(typName .. " ID: " .. tostring(ST_ID), 0, 1, 1)
      numLines = ST_MyGameTooltip:NumLines()
      _G["ST_MyGameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 10)
    end
    if ((ST_PM["showHS"] == "1") and ST_hash2) then
      ST_MyGameTooltip:AddLine("Hash: " .. tostring(ST_hash2), 0, 1, 1)
      numLines = ST_MyGameTooltip:NumLines()
      _G["ST_MyGameTooltipTextLeft" .. numLines]:SetFont(WOWTR_Font2, 10)
    end
  end

  ST_MyGameTooltip:Show()
end

function GT.BuffOrDebuff()
  if (_G["GameTooltipTextLeft2"] and _G["GameTooltipTextLeft2"]:GetText()) then
    local ST_leftText2 = _G["GameTooltipTextLeft2"]:GetText()
    local ST_hash = StringHash(ST_UsunZbedneZnaki(ST_leftText2))
    if (ST_TooltipsHS and ST_TooltipsHS[ST_hash]) then
      local ST_tlumaczenie = ST_TooltipsHS[ST_hash]
      ST_tlumaczenie = ST_TranslatePrepare(ST_leftText2, ST_tlumaczenie)
      local leftColR, leftColG, leftColB = _G["GameTooltipTextLeft2"]:GetTextColor()

      if not GameTooltip.OnHideHooked then
        GameTooltip:HookScript("OnHide", function()
          C_Timer.After(0.01, function()
            ST_MyGameTooltip:Hide()
          end)
        end)
        GameTooltip.OnHideHooked = true
      end

      ST_MyGameTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
      ST_MyGameTooltip:ClearAllPoints()
      ST_MyGameTooltip:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", 0, 0)
      ST_MyGameTooltip:ClearLines()
      if (WoWTR_Localization.lang == 'AR') then
        ST_MyGameTooltip:AddLine(QTR_ExpandUnitInfo(ST_tlumaczenie, false, ST_MyGameTooltip, WOWTR_Font2), leftColR, leftColG, leftColB, true)
      else
        ST_MyGameTooltip:AddLine(QTR_ReverseIfAR(ST_tlumaczenie), leftColR, leftColG, leftColB, true)
      end
      _G["ST_MyGameTooltipTextLeft1"]:SetFont(WOWTR_Font2, 12)
      if (ST_PM["showHS"] == "1") then
        ST_MyGameTooltip:AddLine(" ", 0, 0, 0)
        ST_MyGameTooltip:AddLine("Hash: " .. tostring(ST_hash), 0, 1, 1)
        _G["ST_MyGameTooltipTextLeft3"]:SetFont(WOWTR_Font2, 12)
      end
      ST_MyGameTooltip:Show()
    elseif ((ST_PM and ST_PM["saveNW"] == "1")) then
      local gtProc = GameTooltip and rawget(GameTooltip, "processingInfo")
      local gtData = gtProc and gtProc.tooltipData or nil
      local ST_prefix = gtData and ("s" .. gtData.id) or "s0"
      ST_PH[ST_hash] = ST_prefix .. "@" .. ST_PrzedZapisem(ST_leftText2)
    end
  end
end

function GT.CurrentEquipped(obj)
  if ((ST_PM and ST_PM["active"] == "1") and (ST_PM["item"] == "1")) then
    local processingInfo = obj and rawget(obj, "processingInfo")
    local tooltipData = processingInfo and processingInfo.tooltipData or nil
    if (tooltipData and tooltipData.id) then
      ST_prefix = "i" .. tooltipData.id
      local ST_kodKoloru
      local ST_leftText, ST_rightText, ST_tlumaczenie, ST_hash, ST_hash2
      local _font1, _size1, _1
      local ST_odstep = true
      local ST_orygText = {}
      local ST_nh = 0
      local numLines = obj:NumLines()

      local moneyFrameLineNumber = {}
      local money = {}
      table.insert(moneyFrameLineNumber, 0)
      table.insert(money, 0)
      local objShown = rawget(obj, "shownMoneyFrames")
      if (objShown) then
        for i = 1, objShown, 1 do
          local moneyFrameName = obj:GetName() .. "MoneyFrame" .. i
          _G[moneyFrameName .. "PrefixText"]:SetText(QTR_ReverseIfAR(WoWTR_Localization.sellPrice))
          _font1, _size1, _1 = _G[moneyFrameName .. "PrefixText"]:GetFont()
          _G[moneyFrameName .. "PrefixText"]:SetFont(WOWTR_Font2, _size1)
          if (ST_PM["sellprice"] == "1") then
            _G[moneyFrameName]:Hide()
            ST_odstep = false
          end
        end
      end

      ST_leftText = _G[obj:GetName() .. "TextLeft1"]:GetText()
      if (ST_leftText) then
        if (string.find(ST_leftText, NONBREAKINGSPACE) == nil) then
          if (ST_leftText == "Currently Equipped") then
            ST_info = WoWTR_Localization.currentlyEquipped
          elseif (ST_leftText == "Equipped With") then
            ST_info = WoWTR_Localization.additionalEquipped
          else
            ST_info = ST_leftText
          end
          if ((ST_info == ST_leftText) and (string.len(ST_leftText) > 2) and (string.sub(ST_leftText, 1, 2) ~= "|T")) then
          else
            _font1, _size1, _1 = _G[obj:GetName() .. "TextLeft1"]:GetFont()
            _G[obj:GetName() .. "TextLeft1"]:SetText(QTR_ReverseIfAR(ST_info) .. NONBREAKINGSPACE)
            _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, _size1)
          end
        end
      end

      ST_pomoc0, _ = string.find(_G[obj:GetName() .. "TextLeft2"]:GetText(), NONBREAKINGSPACE)
      local ST_TooltipID_gl = rawget(_G, "ST_TooltipID")
      local ST_TooltipsID_gl = rawget(_G, "ST_TooltipsID")
      local ST_itemID_gl = rawget(_G, "ST_itemID")
      if (ST_TooltipID_gl and (ST_pomoc0 == nil) and (ST_TooltipsID_gl and ST_TooltipsID_gl[ST_prefix .. tostring(ST_itemID_gl)]) and (ST_PM["transtitle"] == "1")) then
        _G[obj:GetName() .. "TextLeft2"]:SetText(QTR_ExpandUnitInfo(ST_TooltipsID_gl[ST_prefix .. tostring(ST_itemID_gl)]), WOWTR_Font2)
        _font1, _size1, _1 = _G[obj:GetName() .. "TextLeft2"]:GetFont()
        _G[obj:GetName() .. "TextLeft2"]:SetFont(WOWTR_Font2, _size1)
      end

      for i = 3, numLines, 1 do
        ST_leftText = _G[obj:GetName() .. "TextLeft" .. i]:GetText()
        if (ST_leftText and (string.find(ST_leftText, NONBREAKINGSPACE) == nil)) then
          leftColR, leftColG, leftColB = _G[obj:GetName() .. "TextLeft" .. i]:GetTextColor()
          ST_kodKoloru = OkreslKodKoloru(leftColR, leftColG, leftColB)
          if (ST_leftText and (string.len(ST_leftText) > 15) and ((ST_kodKoloru == "c7") or (ST_kodKoloru == "c4") or (string.len(ST_leftText) > 30))) then
            local lineObj = _G[obj:GetName() .. "TextLeft" .. i]
            local originalFont, originalSize, originalFlags = lineObj:GetFont()
            ST_hash = StringHash(ST_UsunZbedneZnaki(ST_leftText))
            if (((ST_kodKoloru == "c7") or (string.len(ST_leftText) > 30)) and (not ST_hash2)) then
              ST_hash2 = ST_hash
            end
            if (ST_TooltipsHS and ST_TooltipsHS[ST_hash]) then
              ST_tlumaczenie = ST_TooltipsHS[ST_hash]
              ST_tlumaczenie = ST_TranslatePrepare(ST_leftText, ST_tlumaczenie)
              _font1, _size1, _1 = _G[obj:GetName() .. "TextLeft" .. i]:GetFont()
              _G[obj:GetName() .. "TextLeft" .. i]:SetFont(WOWTR_Font2, _size1)
              _G[obj:GetName() .. "TextLeft" .. i]:SetText(QTR_ExpandUnitInfo(ST_tlumaczenie, false, _G["GameTooltipTextLeft" .. i], WOWTR_Font2) .. NONBREAKINGSPACE)
              _G[obj:GetName() .. "TextLeft" .. i].wrap = true
            else
              if lineObj.SetFont then
                lineObj:SetFont(originalFont, originalSize, originalFlags)
              end
              ST_nh = 1
              table.insert(ST_orygText, ST_leftText)
            end
          end
        end
      end

      if (((ST_PM["showID"] == "1") and (string.len(ST_prefix) > 1)) or ((ST_PM["showHS"] == "1") and ST_hash2)) then
        numLines = obj:NumLines()
        if (numLines > 0 and ST_odstep) then
          obj:AddLine(" ", 0, 0, 0)
        end
        local typName = " "
        if (string.sub(ST_prefix, 1, 1) == "i") then
          typName = "Item"
          ST_ID = string.sub(ST_prefix, 2)
        elseif (string.sub(ST_prefix, 1, 1) == "s") then
          typName = "Spell"
          ST_ID = string.sub(ST_prefix, 2)
        elseif (string.sub(ST_prefix, 1, 1) == "t") then
          typName = "Talent"
          ST_ID = string.sub(ST_prefix, 2)
        else
          ST_ID = nil
        end
        if ((ST_PM["showID"] == "1") and ST_ID) then
          obj:AddLine(typName .. " ID: " .. tostring(ST_ID), 0, 1, 1)
          numLines = obj:NumLines()
          _G[obj:GetName() .. "TextLeft" .. numLines]:SetFont(WOWTR_Font2, 12)
          _G[obj:GetName() .. "TextRight" .. numLines]:SetFont(WOWTR_Font2, 12)
        end
        if ((ST_PM["showHS"] == "1") and ST_hash2) then
          obj:AddLine("Hash: " .. tostring(ST_hash2), 0, 1, 1)
          numLines = obj:NumLines()
          _G[obj:GetName() .. "TextLeft" .. numLines]:SetFont(WOWTR_Font2, 12)
          _G[obj:GetName() .. "TextRight" .. numLines]:SetFont(WOWTR_Font2, 12)
        end
      end

      obj:Show()

      if ((ST_orygText or (ST_nh == 1)) and (ST_PM["saveNW"] == "1")) then
        for _, ST_origin in ipairs(ST_orygText) do
          ST_hash = StringHash(ST_UsunZbedneZnaki(ST_origin))
          if ((not ST_TooltipsHS or not ST_TooltipsHS[ST_hash]) and (string.find(ST_origin, NONBREAKINGSPACE) == nil)) then
            ST_PH[ST_hash] = ST_prefix .. "@" .. ST_PrzedZapisem(ST_origin)
          end
        end
      end
    end
  end
end


return GT


