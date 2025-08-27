-- WoW_Quests_Gossip.lua
-- Gossip toggle handlers (modularized)

local addonName, ns = ...
ns = ns or {}
ns.Quests = ns.Quests or {}
local Quests = ns.Quests

Quests.Gossip = Quests.Gossip or {}

local function isRTL()
   return ns and ns.RTL and ns.RTL.IsRTL and ns.RTL.IsRTL() or false
end

function Quests.Gossip.ToggleNPCGossip()
   if (QTR_curr_goss=="1") then         -- turn off translation, show original
      QTR_curr_goss="0"
      if GossipGreetingText and QTR_GS then
         GossipGreetingText:SetText(QTR_GS[QTR_curr_hash])
         if ns and ns.RTL and ns.RTL.JustifyFontString then ns.RTL.JustifyFontString(GossipGreetingText, "LEFT") else GossipGreetingText:SetJustifyH("LEFT") end
      end
      if QTR_ToggleButtonGS1 then
         QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." EN")
      end
      if (QTR_goss_optionsEN) then
         for k, v in pairs(QTR_goss_optionsEN) do
            if k and k.SetText then
               k:SetText(v)
               if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then Quests.Utils.ApplyOptionButtonLayout(k, false) end
               if k.Resize then k:Resize() end
            end
         end
      end
   else                                   -- show translation
      QTR_curr_goss="1"
      local Greeting_TR = GS_Gossip and GS_Gossip[QTR_curr_hash]
      if (string.sub((Nazwa_NPC or ""),1,17) == "Bronze Timekeeper") then
         if Quests.Utils and Quests.Utils.FormatBronzeTimekeeper then
            Greeting_TR = Quests.Utils.FormatBronzeTimekeeper(QTR_GS[QTR_curr_hash], Greeting_TR)
         end
      end
      if GossipGreetingText then
         if isRTL() then
            GossipGreetingText:SetText(QTR_ExpandUnitInfo((Greeting_TR or "")..NONBREAKINGSPACE,false,GossipGreetingText,WOWTR_Font2,-5))
            if ns and ns.RTL and ns.RTL.JustifyFontString then ns.RTL.JustifyFontString(GossipGreetingText, "LEFT") else GossipGreetingText:SetJustifyH("RIGHT") end
         else
            GossipGreetingText:SetText(QTR_ExpandUnitInfo((Greeting_TR or "")..NONBREAKINGSPACE,false,GossipGreetingText,WOWTR_Font2))
            if ns and ns.RTL and ns.RTL.JustifyFontString then ns.RTL.JustifyFontString(GossipGreetingText, "LEFT") end
         end
      end
      if QTR_ToggleButtonGS1 then
         QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." "..WoWTR_Localization.lang)
      end
      if (QTR_goss_optionsTR) then
         for k, v in pairs(QTR_goss_optionsTR) do
            if k and k.SetText then
               k:SetText(v)
               if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then Quests.Utils.ApplyOptionButtonLayout(k, isRTL()) end
               if k.Resize then k:Resize() end
            end
         end
      end
   end
end

function Quests.Gossip.ToggleQuestFrame()
   if (QTR_curr_goss=="1") then         -- switch to English (LTR)
      if QTR_display_constants then QTR_display_constants(0) end
      QTR_curr_goss="0"
      if GreetingText then
         GreetingText:SetText(QTR_GS[QTR_curr_hash] or "")
         if ns and ns.RTL and ns.RTL.JustifyFontString then ns.RTL.JustifyFontString(GreetingText, "LEFT") else GreetingText:SetJustifyH("LEFT") end
      end
      if QTR_ToggleButton0 then
         QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." EN")
      end
      -- Restore options to English LTR layout
      if (QTR_goss_optionsEN) then
         for k, v in pairs(QTR_goss_optionsEN) do
            if k and k.SetText then
               k:SetText(v or "")
               if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then Quests.Utils.ApplyOptionButtonLayout(k, false) end
               if k.Resize then k:Resize() end
            end
         end
      end
   else                                   -- switch to translated (potentially RTL)
      if QTR_display_constants then QTR_display_constants(1) end
      QTR_curr_goss="1"
      local Greeting_TR = (GS_Gossip and GS_Gossip[QTR_curr_hash]) or (QTR_GS[QTR_curr_hash] or "")
      if (string.sub((Nazwa_NPC or ""),1,17) == "Bronze Timekeeper") then
         if Quests.Utils and Quests.Utils.FormatBronzeTimekeeper then
            Greeting_TR = Quests.Utils.FormatBronzeTimekeeper(QTR_GS[QTR_curr_hash], Greeting_TR)
         end
      end
      if GreetingText then
         if isRTL() then
            GreetingText:SetText(QTR_ExpandUnitInfo((Greeting_TR or "")..NONBREAKINGSPACE,false,GreetingText,WOWTR_Font2,-5))
            if ns and ns.RTL and ns.RTL.JustifyFontString then ns.RTL.JustifyFontString(GreetingText, "LEFT") else GreetingText:SetJustifyH("RIGHT") end
         else
            GreetingText:SetText(QTR_ExpandUnitInfo((Greeting_TR or "")..NONBREAKINGSPACE,false,GreetingText,WOWTR_Font2))
            if ns and ns.RTL and ns.RTL.JustifyFontString then ns.RTL.JustifyFontString(GreetingText, "LEFT") else GreetingText:SetJustifyH("LEFT") end
         end
      end
      if QTR_ToggleButton0 then
         QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." "..WoWTR_Localization.lang)
      end
      if (QTR_goss_optionsTR) then
         for k, v in pairs(QTR_goss_optionsTR) do
            if k and k.SetText then
               k:SetText(v or "")
               local fontStringRegion = Quests.Utils and Quests.Utils.GetFirstFontStringRegion and Quests.Utils.GetFirstFontStringRegion(k)
               if fontStringRegion and WOWTR_Font2 and QTR_PS then
                  fontStringRegion:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"]))
               end
               if Quests.Utils and Quests.Utils.ApplyOptionButtonLayout then Quests.Utils.ApplyOptionButtonLayout(k, isRTL()) end
               if k.Resize then k:Resize() end
            end
         end
      end
   end
end

-- Backward-compatible global wrappers (define only if absent)
if not GS_ON_OFF then
   function GS_ON_OFF()
      return Quests.Gossip.ToggleNPCGossip()
   end
end

if not GS_ON_OFF2 then
   function GS_ON_OFF2()
      return Quests.Gossip.ToggleQuestFrame()
   end
end

