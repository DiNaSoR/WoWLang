-- Quests/Utils.lua
-- Utility helpers for quests and gossip (split out)

local addonName, ns = ...
ns = ns or {}
ns.Quests = ns.Quests or {}
local Quests = ns.Quests

Quests.Utils = Quests.Utils or {}

-- Return the first FontString region from a frame
function Quests.Utils.GetFirstFontStringRegion(frame)
   if not frame or not frame.GetRegions then
      return nil
   end
   local regions = { frame:GetRegions() }
   for _, region in pairs(regions) do
      if (region and region.GetObjectType and region:GetObjectType()=="FontString") then
         return region
      end
   end
   return nil
end

-- Apply LTR/RTL layout for an option button (icon + text)
function Quests.Utils.ApplyOptionButtonLayout(buttonFrame, isRTL)
   if not buttonFrame then return end
   local fontStringRegion = Quests.Utils.GetFirstFontStringRegion(buttonFrame)
   if not fontStringRegion then return end
   local iconRegion = buttonFrame.Icon

   if isRTL then
      if iconRegion then
         iconRegion:ClearAllPoints()
         iconRegion:SetPoint("TOPRIGHT", buttonFrame, "TOPRIGHT", -10, -2)
         fontStringRegion:ClearAllPoints()
         fontStringRegion:SetPoint("TOPRIGHT", iconRegion, "TOPLEFT", -5, 0)
         fontStringRegion:SetJustifyH("RIGHT")
      else
         fontStringRegion:ClearAllPoints()
         fontStringRegion:SetPoint("TOPRIGHT", buttonFrame, "TOPRIGHT", -10, -2)
         fontStringRegion:SetJustifyH("RIGHT")
      end
   else
      local leftPadding = 10
      if iconRegion then
         iconRegion:ClearAllPoints()
         iconRegion:SetPoint("TOPLEFT", buttonFrame, "TOPLEFT", 5, -2)
         leftPadding = (iconRegion.GetWidth and iconRegion:GetWidth() or 0) + 10
      end
      fontStringRegion:ClearAllPoints()
      fontStringRegion:SetPoint("TOPLEFT", buttonFrame, "TOPLEFT", leftPadding, -2)
      fontStringRegion:SetJustifyH("LEFT")
   end
end

-- Bronze Timekeeper number formatting and placeholder substitution ($1..$6)
function Quests.Utils.FormatBronzeTimekeeper(sourceText, messageText)
   local src = strtrim(sourceText or "")
   local msg = messageText or ""
   local wartab = {0,0,0,0,0,0}
   local arg0 = 0
   for w in string.gmatch(src, "%d+") do
      arg0 = arg0 + 1
      local num = tonumber(w) or 0
      if (num>999999) then
         wartab[arg0] = tostring(math.floor(num)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2."):gsub("(%-?)$", "%1"):reverse()
      elseif (num>99999) then
         wartab[arg0] = tostring(math.floor(num)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2"):gsub("(%-?)$", "%1"):reverse()
      elseif (num>999) then
         wartab[arg0] = tostring(math.floor(num)):reverse():gsub("(%d%d%d)", "%1."):gsub("(%-?)$", "%1"):reverse()
      else
         wartab[arg0] = w
      end
      if arg0>=6 then break end
   end
   if (arg0>5 and wartab[6]) then msg = string.gsub(msg, "$6", wartab[6]) end
   if (arg0>4 and wartab[5]) then msg = string.gsub(msg, "$5", wartab[5]) end
   if (arg0>3 and wartab[4]) then msg = string.gsub(msg, "$4", wartab[4]) end
   if (arg0>2 and wartab[3]) then msg = string.gsub(msg, "$3", wartab[3]) end
   if (arg0>1 and wartab[2]) then msg = string.gsub(msg, "$2", wartab[2]) end
   if (arg0>0 and wartab[1]) then msg = string.gsub(msg, "$1", wartab[1]) end
   return msg
end

