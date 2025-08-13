function WOWTR_SetDungeonFrames(obj, tryb, horiz)
   if (tryb) then -- show
      obj:SetOwner(UIParent, "ANCHOR_NONE");
      obj:ClearAllPoints();
      obj:SetPoint("CENTER", horiz, obj.vertical);
      obj:ClearLines();
      obj:AddLine(QTR_ReverseIfAR(WoWTR_Localization.moveFrameUpDown), 1, 1, 1, true);
      if (BB_PM["setsize"] == "1") then                                                      -- jest włączona wielkość czcionki dymku
         _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, tonumber(BB_PM["fontsize"])); -- wielkość czcionki
      else
         _G[obj:GetName() .. "TextLeft1"]:SetFont(WOWTR_Font2, 13);                          -- ustaw turecką czcionkę oraz niezmienioną wielkość (13)
      end
      obj:Show();
      obj:SetMovable(true);
      obj:SetScript("OnMouseDown", function() WOWBB_OnMouseDown(obj); end);
      obj:SetScript("OnMouseUp", function() WOWBB_OnMouseUp(obj); end);
   else -- hide
      obj:SetMovable(false);
      obj:SetScript("OnMouseDown", nil);
      obj:SetScript("OnMouseUp", nil);
      obj:Hide();
      BB_PM["dungeonF1"] = WOWBB1.vertical;
      BB_PM["dungeonF2"] = WOWBB2.vertical;
      BB_PM["dungeonF3"] = WOWBB3.vertical;
      BB_PM["dungeonF4"] = WOWBB4.vertical;
      BB_PM["dungeonF5"] = WOWBB5.vertical;
   end
end

-----------------------------------------------------------------------------------------------------------------

function WOWTR_HideOptionsFrame()
   WOWTR_SetDungeonFrames(WOWBB1, false);
   WOWTR_SetDungeonFrames(WOWBB2, false);
   WOWTR_SetDungeonFrames(WOWBB3, false);
   WOWTR_SetDungeonFrames(WOWBB4, false);
   WOWTR_SetDungeonFrames(WOWBB5, false);
end

-----------------------------------------------------------------------------------------------------------------

