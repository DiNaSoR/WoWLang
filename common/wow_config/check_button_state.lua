function WOWTR_SetCheckButtonState()
   WOWTR_CheckButton00:SetChecked(QTR_PS["icon"] == "1");
   WOWTR_CheckButton11:SetChecked(QTR_PS["active"] == "1");
   WOWTR_CheckButton12:SetChecked(QTR_PS["transtitle"] == "1");
   WOWTR_CheckButton13:SetChecked(QTR_PS["gossip"] == "1");
   WOWTR_CheckButton14:SetChecked(QTR_PS["tracker"] == "1");
   WOWTR_CheckButton15:SetChecked(QTR_PS["saveQS"] == "1");
   WOWTR_CheckButton16:SetChecked(QTR_PS["saveGS"] == "1");
   WOWTR_CheckButton17:SetChecked(QTR_PS["immersion"] == "1");
   WOWTR_CheckButton18:SetChecked(QTR_PS["storyline"] == "1");
   WOWTR_CheckButton19:SetChecked(QTR_PS["questlog"] == "1");
   WOWTR_CheckButton1a:SetChecked(QTR_PS["ownnames"] == "1");
   WOWTR_CheckButton1b:SetChecked(QTR_PS["dialogueui"] == "1");
   WOWTR_CheckButton1c:SetChecked(QTR_PS["en_first"] == "1");

   WOWTR_CheckButton21:SetChecked(BB_PM["active"] == "1");
   WOWTR_CheckButton22:SetChecked(BB_PM["chat-en"] == "1");
   WOWTR_CheckButton23:SetChecked(BB_PM["chat-tr"] == "1");
   WOWTR_CheckButton24:SetChecked(BB_PM["sex"] == "2");
   WOWTR_CheckButton25:SetChecked(BB_PM["sex"] == "3");
   WOWTR_CheckButton26:SetChecked(BB_PM["sex"] == "4");
   WOWTR_CheckButton27:SetChecked(BB_PM["saveNB"] == "1");
   WOWTR_CheckButton28:SetChecked(BB_PM["setsize"] == "1");
   WOWTR_CheckButton2d1:SetChecked(BB_PM["dungeon"] == "1");
   WOWTR_CheckButton2d2:SetChecked(false);
   BB_PM["dungeonF"] = "0"; -- setting dungeon frames

   WOWTR_CheckButton31:SetChecked(MF_PM["active"] == "1");
   WOWTR_CheckButton32:SetChecked(MF_PM["intro"] == "1");
   WOWTR_CheckButton33:SetChecked(MF_PM["movie"] == "1");
   WOWTR_CheckButton34:SetChecked(MF_PM["cinematic"] == "1");
   WOWTR_CheckButton35:SetChecked(MF_PM["save"] == "1");

   if (WoWTR_Localization.lang == 'AR') then -- part: Chat
      WOWTR_CheckButton36:SetChecked(CH_PM["active"] == "1");
      WOWTR_CheckButton37:SetChecked(CH_PM["setsize"] == "1");
      WOWTR_slider6:SetValue(tonumber(CH_PM["fontsize"]));
   end

   WOWTR_CheckButton40:SetChecked(TT_PS["ui8"] == "1");
   WOWTR_CheckButton41:SetChecked(TT_PS["active"] == "1");
   WOWTR_CheckButton42:SetChecked(TT_PS["save"] == "1");
   WOWTR_CheckButton43:SetChecked(TT_PS["ui1"] == "1");
   WOWTR_CheckButton44:SetChecked(TT_PS["saveui"] == "1");
   WOWTR_CheckButton45:SetChecked(TT_PS["ui2"] == "1");
   WOWTR_CheckButton46:SetChecked(TT_PS["ui3"] == "1");
   WOWTR_CheckButton47:SetChecked(TT_PS["ui4"] == "1");
   WOWTR_CheckButton48:SetChecked(TT_PS["ui5"] == "1");
   WOWTR_CheckButton49:SetChecked(TT_PS["ui6"] == "1");
   WOWTR_CheckButton50:SetChecked(TT_PS["ui7"] == "1");

   WOWTR_CheckButton51:SetChecked(BT_PM["active"] == "1");
   WOWTR_CheckButton52:SetChecked(BT_PM["title"] == "1");
   WOWTR_CheckButton53:SetChecked(BT_PM["showID"] == "1");
   WOWTR_CheckButton55:SetChecked(BT_PM["saveNW"] == "1");
   WOWTR_CheckButton58:SetChecked(BT_PM["setsize"] == "1");

   WOWTR_CheckButton61:SetChecked(ST_PM["active"] == "1");
   WOWTR_CheckButton62:SetChecked(ST_PM["item"] == "1");
   WOWTR_CheckButton63:SetChecked(ST_PM["spell"] == "1");
   WOWTR_CheckButton64:SetChecked(ST_PM["talent"] == "1");
   WOWTR_CheckButton65:SetChecked(ST_PM["showID"] == "1");
   WOWTR_CheckButton66:SetChecked(ST_PM["showHS"] == "1");
   WOWTR_CheckButton67:SetChecked(ST_PM["sellprice"] == "1");
   WOWTR_CheckButton68:SetChecked(ST_PM["constantly"] == "1");
   WOWTR_CheckButton69:SetChecked(ST_PM["saveNW"] == "1");
   if (ST_TooltipsID) then
      WOWTR_CheckButton6A:SetChecked(ST_PM["transtitle"] == "1");
   end

   local fontsize1 = tonumber(BB_PM["fontsize"]) or 13;
   WOWTR_Opis1:SetFont(WOWTR_Font2, fontsize1);

   local fontsize2 = tonumber(BT_PM["fontsize"]) or 13;
   WOWTR_Opis2:SetFont(WOWTR_Font2, fontsize2);

   local fontsize4 = tonumber(QTR_PS["fontsize"]) or 13; -- gossip font size
   WOWTR_Opis4:SetFont(WOWTR_Font2, fontsize4);

   WOWTR_slider1:SetValue(tonumber(BB_PM["fontsize"]));
   WOWTR_slider2:SetValue(tonumber(BT_PM["fontsize"]));
   WOWTR_slider3:SetValue(tonumber(ST_PM["timer"]));
   WOWTR_slider4:SetValue(tonumber(QTR_PS["fontsize"]));
   WOWTR_slider5:SetValue(tonumber(BB_PM["timeDisplay"]));

   -- if (WOWTR_ConfigFirstTime) then      -- The options window was launched for the first time - show all tabs so that the texts are fully displayed
   -- WOWTR_ConfigFirstTime = false;
   -- if (not WOWTR_wait(0.5, WOWTR_ChangePanel1)) then
   -- delay 0.5 sec.
   -- end
   -- if (not WOWTR_wait(0.5, WOWTR_ChangePanel2)) then
   -- delay 0.5 sec.
   -- end
   -- if (not WOWTR_wait(0.5, WOWTR_ChangePanel3)) then
   -- delay 0.5 sec.
   -- end
   -- if (not WOWTR_wait(0.5, WOWTR_ChangePanel4)) then
   -- delay 0.5 sec.
   -- end
   -- if (not WOWTR_wait(0.5, WOWTR_ChangePanel5)) then
   -- delay 0.5 sec.
   -- end
   -- if (not WOWTR_wait(0.5, WOWTR_ChangePanel6)) then
   -- delay 0.5 sec.
   -- end
   -- if (not WOWTR_wait(0.5, WOWTR_ChangePanel1)) then
   -- delay 0.5 sec.
   -- end
   -- end
end

---------------------------------------------------------------------------------------------------------------

