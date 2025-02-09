-- Description: The AddOn displays the translated text information in chosen language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
-------------------------------------------------------------------------------------------------------

-- Test both version 11.00 and 10.2.7 will be delete it after testing
local version, build, date, tocversion = GetBuildInfo()
local qtrmajor, qtrminor, qtrpatch = strsplit(".", version)
qtrmajor = tonumber(qtrmajor)
qtrminor = tonumber(qtrminor)
qtrpatch = tonumber(qtrpatch)

-- Global Variables
QTR_MessOrig = {
   details    = "Description", 
   objectives = "Quest Objectives", 
   rewards    = "Rewards", 
   itemchoose0= "You will receive:",
   itemchoose1= "You will be able to choose one of these rewards:", 
   itemchoose2= "Choose one of these rewards:", 
   itemchoose3= "You receiving the reward:",
   itemreceiv0= "You will receive:",
   itemreceiv1= "You will also receive:", 
   itemreceiv2= "You receiving the reward:", 
   itemreceiv3= "You also receiving the reward:",
   learnspell = "Learn Spell:", 
   reqmoney   = "Required Money:", 
   reqitems   = "Required items:", 
   experience = "Experience:", 
   currquests = "Current Quests", 
   avaiquests = "Available Quests", 
   reward_aura      = "The following will be cast on you:", 
   reward_spell     = "You will learn the following:", 
   reward_companion = "You will gain these Companions:", 
   reward_follower  = "You will gain these followers:", 
   reward_reputation= "Reputation awards:", 
   reward_title     = "You shall be granted the title:", 
   reward_tradeskill= "You will learn how to create::", 
   reward_unlock    = "You will unlock access to the following:", 
   reward_bonus     = "Completing this quest while in Party Sync may reward:", 
   };
QTR_quest_ID = 0;
QTR_quest_EN = { };
QTR_quest_LG = { };
QTR_quest_EN[0] = { };
QTR_quest_LG[0] = { };
QTR_goss_optionsEN = { };
QTR_goss_optionsTR = { };
gossipDUI_LN = { };
gossipDUI_EN = { };
gossip2DUI_LN = { };
gossip2DUI_EN = { };
QTR_curr_trans = "1";
QTR_curr_goss = "X";
QTR_curr_hash = 0;
QTR_first_show = 0;
QTR_first_show2 = 0;
QTR_PrepareTime = 0;
QTR_ModelTextHash = 0;
QTR_ModelText_EN = ""; 
QTR_ModelText_PL = ""; 
local Nazwa_NPC = "";
quest_numReward = {};       -- liczba dostępnych nagród do questu
QTR_curr_dialog = "1";
Original_Font1 = "Fonts\\MORPHEUS.ttf";
Original_Font2 = "Fonts\\FRIZQT__.ttf";

-------------------------------------------------------------------------------------------------------------------

function GS_ON_OFF()
   if (QTR_curr_goss=="1") then         -- wyłącz tłumaczenie - pokaż oryginalny tekst
      QTR_curr_goss="0";
      GossipGreetingText:SetText(QTR_GS[QTR_curr_hash]);
      GossipGreetingText:SetJustifyH("LEFT");
--    GossipGreetingText:SetFont(Original_Font2, 12);
      QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." EN");
      if (QTR_goss_optionsEN) then
         for k, v in pairs(QTR_goss_optionsEN) do
            k:SetText(v);      -- odtworzenie oryginalnych opcji
            k:Resize();
            if ((k.Icon) and (WoWTR_Localization.lang == 'AR')) then
               local point, relativeTo, relativePoint, xOfs, yOfs = k.Icon:GetPoint(1);
               k.Icon:ClearAllPoints();
               k.Icon:SetPoint(point, relativeTo, "TOPLEFT", xOfs+40, yOfs);
            end
         end
      end
   else                                 -- pokaż tłumaczenie
      QTR_curr_goss="1";
      local Greeting_TR = GS_Gossip[QTR_curr_hash];
      if (string.sub(Nazwa_NPC,1,17) == "Bronze Timekeeper") then       -- wyścigi na smokach - wyjątej z sekundami: $1.$2 oraz $3.$4
         local wartab = {0,0,0,0,0,0};                                  -- max. 6 liczb całkowitych w tekście
         local arg0 = 0;
         for w in string.gmatch(strtrim(QTR_GS[QTR_curr_hash]), "%d+") do
            arg0 = arg0 + 1;
            if (math.floor(w)>999999) then
               wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2."):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
            elseif (math.floor(w)>99999) then
               wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2"):gsub("(%-?)$", "%1"):reverse();    -- tu mamy kolejne cyfry z oryginału
            elseif (math.floor(w)>999) then
               wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)", "%1."):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
            else   
               wartab[arg0] = w;      -- tu mamy kolejne liczby całkowite z oryginału
            end
         end;
         if (arg0>5) then
            Greeting_TR=string.gsub(Greeting_TR, "$6", wartab[6]);
         end
         if (arg0>4) then
            Greeting_TR=string.gsub(Greeting_TR, "$5", wartab[5]);
         end
         if (arg0>3) then
            Greeting_TR=string.gsub(Greeting_TR, "$4", wartab[4]);
         end
         if (arg0>2) then
            Greeting_TR=string.gsub(Greeting_TR, "$3", wartab[3]);
         end
         if (arg0>1) then
            Greeting_TR=string.gsub(Greeting_TR, "$2", wartab[2]);
         end
         if (arg0>0) then
            Greeting_TR=string.gsub(Greeting_TR, "$1", wartab[1]);
         end
      end
      if (WoWTR_Localization.lang == 'AR') then
         GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR.." ",false,GossipGreetingText,WOWTR_Font2,-5));    -- dodano na końcu twardą spację
         GossipGreetingText:SetJustifyH("RIGHT");
      else
         GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR.." ",false,GossipGreetingText,WOWTR_Font2));    -- dodano na końcu twardą spację
      end
--    GossipGreetingText:SetFont(WOWTR_Font2, 12);      
      QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." "..WoWTR_Localization.lang);
      if (QTR_goss_optionsTR) then
         for k, v in pairs(QTR_goss_optionsTR) do
            k:SetText(v);      -- przywrócenie przetłumaczonych opcji
            k:Resize();
            if ((k.Icon) and (WoWTR_Localization.lang == 'AR')) then
               local point, relativeTo, relativePoint, xOfs, yOfs = k.Icon:GetPoint(1);
               k.Icon:ClearAllPoints();
               k.Icon:SetPoint(point, relativeTo, "TOPRIGHT", xOfs-40, yOfs);
            end
         end
      end
   end
end

-------------------------------------------------------------------------------------------------------------------

function GS_ON_OFF2()
   if (QTR_curr_goss=="1") then         -- wyłącz tłumaczenie - pokaż oryginalny tekst
      QTR_display_constants(0);
      QTR_curr_goss="0";
      GreetingText:SetText(QTR_GS[QTR_curr_hash]);
--    GreetingText:SetFont(Original_Font2, 12);
      QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." EN");
      if (QTR_goss_optionsEN) then
         for k, v in pairs(QTR_goss_optionsEN) do
            k:SetText(v);      -- odtworzenie oryginalnych opcji
--            k:Resize();
         end
      end
   else                                 -- pokaż tłumaczenie
      QTR_display_constants(1);
      QTR_curr_goss="1";
      local Greeting_TR = GS_Gossip[QTR_curr_hash];
      if (string.sub(Nazwa_NPC,1,17) == "Bronze Timekeeper") then       -- wyścigi na smokach - wyjątej z sekundami: $1.$2 oraz $3.$4
         local wartab = {0,0,0,0,0,0};                                  -- max. 6 liczb całkowitych w tekście
         local arg0 = 0;
         for w in string.gmatch(strtrim(QTR_GS[QTR_curr_hash]), "%d+") do
            arg0 = arg0 + 1;
            if (math.floor(w)>999999) then
               wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2."):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
            elseif (math.floor(w)>99999) then
               wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2"):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
            elseif (math.floor(w)>999) then
               wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)", "%1."):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
            else   
               wartab[arg0] = w;      -- tu mamy kolejne liczby całkowite z oryginału
            end
         end;
         if (arg0>5) then
            Greeting_TR=string.gsub(Greeting_TR, "$6", wartab[6]);
         end
         if (arg0>4) then
            Greeting_TR=string.gsub(Greeting_TR, "$5", wartab[5]);
         end
         if (arg0>3) then
            Greeting_TR=string.gsub(Greeting_TR, "$4", wartab[4]);
         end
         if (arg0>2) then
            Greeting_TR=string.gsub(Greeting_TR, "$3", wartab[3]);
         end
         if (arg0>1) then
            Greeting_TR=string.gsub(Greeting_TR, "$2", wartab[2]);
         end
         if (arg0>0) then
            Greeting_TR=string.gsub(Greeting_TR, "$1", wartab[1]);
         end
      end
      GreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR,false,GreetingText,WOWTR_Font2));
--    GreetingText:SetFont(WOWTR_Font2, 12);      
      QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." "..WoWTR_Localization.lang);
      if (QTR_goss_optionsTR) then
         for k, v in pairs(QTR_goss_optionsTR) do
            k:SetText(v);      -- przywrócenie przetłumaczonych opcji
--            k:Resize();
         end
      end
   end
end

-------------------------------------------------------------------------------------------------------------------

-- NPC chat window opened - frame: GossipFrame
function QTR_Gossip_Show()
--print ("Gossip_Show");
   local function ProcessOPT(buttonString)
      local fontString = buttonString.Content.Name;
      local GOptionText = WOWTR_DetectAndReplacePlayerName(fontString:GetText());
      local prefix = "";
      local sufix = "";
      table.insert(gossip2DUI_EN, fontString:GetText());   -- english version
      local _font1, _size1, _1 = fontString:GetFont();     -- odczytaj aktualną czcionkę i rozmiar
      fontString:SetFont(WOWTR_Font2,_size1);
      --buttonString:HookScript("OnClick", QTR_DUIGossipFrame);
      if (string.sub(GOptionText,1,2) == "|c") then
         prefix = string.sub(GOptionText, 1, 10);
         sufix = "|r";
         GOptionText = string.gsub(GOptionText, prefix, "");
         GOptionText = string.gsub(GOptionText, sufix, "");
      end
      if (string.sub(GOptionText,2,2)==".") then
         GOptionText = string.sub(GOptionText,4);
      end
      local OptHash = StringHash(GOptionText);
      if (GS_Gossip[OptHash]) then               -- jest tłumaczenie
         local transLN = prefix .. QTR_ExpandUnitInfo(GS_Gossip[OptHash],false,fontString,WOWTR_Font2,-40) .. sufix .. " ";   -- twarda spacja na końcu
         fontString:SetText(transLN);
      end
      table.insert(gossip2DUI_LN, fontString:GetText());    -- translated version
   end

   QTR_IconAI:Hide();
   GoQ_IconAI:Hide();
   Nazwa_NPC = GossipFrameTitleText:GetText();
   if (isImmersion()) then           -- jest aktywny Immersion
      if (Nazwa_NPC==nil) then
         Nazwa_NPC = ImmersionFrame.TalkBox.NameFrame.Name:GetText();
      end
      QTR_ToggleButton4:SetText(QTR_ReverseIfAR(WoWTR_Localization.gossipText));
   elseif (isStoryline()) then       -- jest aktywny StoryLine
      if (Nazwa_NPC==nil) then
         Nazwa_NPC = Storyline_NPCFrameChatName:GetText();
      end
      QTR_ToggleButton5:SetText(QTR_ReverseIfAR(WoWTR_Localization.gossipText));
   end
   if (Nazwa_NPC==nil) then
      Nazwa_NPC = UnitName("target");
   end
   QTR_curr_hash = 0;
   local QTR_first_ok = false;
   if (Nazwa_NPC) then
      local GossipTextFrame;
      Greeting_Text = C_GossipInfo:GetText();
      local GO_resized = 0;
      QTR_goss_optionsEN = { };    -- wyzeruj tablicę na opcje EN gossip
      QTR_goss_optionsTR = { };    -- wyzeruj tablicę na opcje TR gossip
      for _,GTxtframe in GossipFrame.GreetingPanel.ScrollBox:EnumerateFrames() do      -- pobierz obiekty enumeryczne
         if (GTxtframe.GreetingText) then    -- Greeting Text
            GossipTextFrame = GTxtframe;
         end
      end
      
      if (Greeting_Text and (string.find(Greeting_Text," ")==nil)) then   -- nie jest to tekst przetłumaczony (nie ma twardej spacji)
         Nazwa_NPC = string.gsub(Nazwa_NPC, '"', '\"');
         local Origin_Text = WOWTR_DetectAndReplacePlayerName(Greeting_Text);
         local Czysty_Text = WOWTR_DeleteSpecialCodes(Origin_Text);
         if (string.sub(Nazwa_NPC,1,17) == "Bronze Timekeeper") then    -- wyścigi na smokach - wyjątek z sekundami
            Czysty_Text = string.gsub(Czysty_Text, "0", "");
            Czysty_Text = string.gsub(Czysty_Text, "1", "");
            Czysty_Text = string.gsub(Czysty_Text, "2", "");
            Czysty_Text = string.gsub(Czysty_Text, "3", "");
            Czysty_Text = string.gsub(Czysty_Text, "4", "");
            Czysty_Text = string.gsub(Czysty_Text, "5", "");
            Czysty_Text = string.gsub(Czysty_Text, "6", "");
            Czysty_Text = string.gsub(Czysty_Text, "7", "");
            Czysty_Text = string.gsub(Czysty_Text, "8", "");
            Czysty_Text = string.gsub(Czysty_Text, "9", "");
         end
         local Hash = StringHash(Czysty_Text);
         QTR_curr_hash = Hash;
         QTR_GS[Hash] = Greeting_Text;                      -- zapis oryginalnego tekstu
         if ( GS_Gossip[Hash] == nil ) then                 -- może to być nazwa zadania z dopiskiem (low level)
            Origin_Text = string.gsub(Origin_Text, ' (low level)', '');
            Czysty_Text = string.gsub(Czysty_Text, ' (low level)', '');
            Hash = StringHash(Czysty_Text);
            QTR_curr_hash = Hash;
         end
         
         if ( GS_Gossip[Hash] ) then   -- istnieje tłumaczenie tekstu GOSSIP tego NPC
            local Greeting_TR = GS_Gossip[Hash];
            if (string.sub(Nazwa_NPC,1,17) == "Bronze Timekeeper") then       -- wyścigi na smokach - wyjątej z sekundami: $1.$2 oraz $3.$4
               local wartab = {0,0,0,0,0,0};                                  -- max. 6 liczb całkowitych w tekście
               local arg0 = 0;
               for w in string.gmatch(strtrim(Greeting_Text), "%d+") do
                  arg0 = arg0 + 1;
                  if (math.floor(w)>999999) then
                     wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2."):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
                  elseif (math.floor(w)>99999) then
                     wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2"):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
                  elseif (math.floor(w)>999) then
                     wartab[arg0] = tostring(math.floor(w)):reverse():gsub("(%d%d%d)", "%1."):gsub("(%-?)$", "%1"):reverse();   -- tu mamy kolejne cyfry z oryginału
                  else
                     wartab[arg0] = w;      -- tu mamy kolejne liczby całkowite z oryginału
                  end
               end;
               if (arg0>5) then
                  Greeting_TR=string.gsub(Greeting_TR, "$6", wartab[6]);
               end
               if (arg0>4) then
                  Greeting_TR=string.gsub(Greeting_TR, "$5", wartab[5]);
               end
               if (arg0>3) then
                  Greeting_TR=string.gsub(Greeting_TR, "$4", wartab[4]);
               end
               if (arg0>2) then
                  Greeting_TR=string.gsub(Greeting_TR, "$3", wartab[3]);
               end
               if (arg0>1) then
                  Greeting_TR=string.gsub(Greeting_TR, "$2", wartab[2]);
               end
               if (arg0>0) then
                  Greeting_TR=string.gsub(Greeting_TR, "$1", wartab[1]);
               end
            end
            if (GossipTextFrame) then
               QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(Hash).." "..WoWTR_Localization.lang);
               QTR_ToggleButtonGS1:Enable();
               GossipGreetingText = GossipTextFrame.GreetingText;
               local GO_height = GossipGreetingText:GetHeight();
               if (WoWTR_Localization.lang == 'AR') then
                  GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR.." ",false,GossipGreetingText,WOWTR_Font2,-5));    -- dodano na końcu twardą spację
                  GossipGreetingText:SetJustifyH("RIGHT");
               else
                  GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR.." ",false,GossipGreetingText,WOWTR_Font2));    -- dodano na końcu twardą spację
               end
               GossipGreetingText:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"]));
--               GossipTextFrame:Resize();
               QTR_curr_goss="1";
               if (GossipGreetingText:GetHeight() > GO_height+1) then
                  GO_resized = GO_resized + GossipGreetingText:GetHeight() - GO_height;
               end
               if (GS_AI and GS_AI[Hash]) then
                  QTR_IconAI:Show();
               end
            end
            if (isImmersion()) then       -- jest aktywny Immersion i zezwolono na tłumaczenia
               ImmersionFrame.TalkBox.TextFrame.Text:SetFont(WOWTR_Font2, 14);
               ImmersionFrame.TalkBox.TextFrame.Text:SetText(QTR_ExpandUnitInfo(Greeting_TR,false,ImmersionFrame.TalkBox.TextFrame.Text,WOWTR_Font2));     
            elseif (isStoryline()) then   -- jest aktywny StoryLine i zezwolono na tłumaczenia
               txt0txt = QTR_ExpandUnitInfo(Greeting_TR,false,Storyline_NPCFrameChat.texts[0],WOWTR_Font2);
               if (not WOWTR_wait(1.0, QTR_Storyline_Gossip)) then
                 -- opóźnienie 1.0 sek
               end
            end
            if (isDUIQuestFrame()) then   -- jest aktywny dodatek DialogueUI i zezwolono na tłumaczenia
               QTR_ToggleButton6:SetText("Gossip-Hash="..tostring(Hash).." ("..WoWTR_Localization.lang..")");
               QTR_ToggleButton6:Enable();
               QTR_DUIGossipFrame();
            end
            if ( QTR_PS["en_first"]=="1" ) then   -- przełącz na angielski
               QTR_first_ok = true;
            end
         else              -- nie mamy tłumaczenia
            QTR_ToggleButtonGS1:SetText("Gossip-Hash="..tostring(Hash).." (EN)");
            QTR_ToggleButtonGS1:Disable();
            if (isDUIQuestFrame()) then   -- jest aktywny dodatek DialogueUI i zezwolono na tłumaczenia
               QTR_ToggleButton6:SetText("Gossip-Hash="..tostring(Hash).." (EN)");
               QTR_ToggleButton6:Show();
               QTR_ToggleButton6:Disable();
               QTR_ToggleButton7:Hide();
               if (TT_PS["ui1"] == "1") then
                  QTR_DUIbuttons();
                  DUIQuestFrame.optionButtonPool:ProcessActiveObjects(ProcessOPT);
               end
            end
            -- zapis do pliku
            if (QTR_PS["saveGS"]=="1") then
               Origin_Text = string.gsub(Origin_Text, '"', '\"');                
               if (C_Map.GetBestMapForUnit("player")) then
                  QTR_GOSSIP[Nazwa_NPC.."@"..tostring(Hash).."@"..C_Map.GetBestMapForUnit("player")] = Origin_Text.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class;
               else
                  QTR_GOSSIP[Nazwa_NPC.."@"..tostring(Hash).."@0"] = Origin_Text.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class;
               end
            end
         end
      end

      for _,GTxtframe in GossipFrame.GreetingPanel.ScrollBox:EnumerateFrames() do      -- pobierz obiekty enumeryczne
         local GTtype =  GTxtframe.GetElementData().buttonType;
         if (GTxtframe.GreetingText) then    -- Greeting Text
            GossipTextFrame = GTxtframe;
         else
            if (((GTtype==3) or (GTtype==4) or (GTtype==5)) and (QTR_PS["gossip"]=="1") and (string.find(GTxtframe:GetText()," ")==nil)) then    -- gossip options
               local GOptionText = WOWTR_DetectAndReplacePlayerName(GTxtframe:GetText(), nil, '$N');     -- detect only name of player
               local prefix = "";
               local sufix = "";
               if (string.sub(GOptionText,1,2) == "|c") then
                  prefix = string.sub(GOptionText, 1, 10);
                  sufix = "|r";
                  GOptionText = string.gsub(GOptionText, prefix, "");
                  GOptionText = string.gsub(GOptionText, sufix, "");
               end
               local Czysty_Text = WOWTR_DeleteSpecialCodes(GOptionText, '$N');
               local OptHash = StringHash(Czysty_Text);
               if (GO_resized > 0) then
                  local point, relativeTo, relativePoint, xOfs, yOfs = GTxtframe:GetPoint(1);
                  GTxtframe:ClearAllPoints();
                  GTxtframe:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-GO_resized);
               end
               local GO_height = GTxtframe:GetHeight();
               if (GS_Gossip[OptHash]) then               -- jest tłumaczenie
                  local transTR;
                  if (GTxtframe.Icon) then
                     transTR = prefix .. QTR_ExpandUnitInfo(GS_Gossip[OptHash],false,GTxtframe,WOWTR_Font2,-60) .. sufix .. " ";   -- twarda spacja na końcu
                  else                 
                     transTR = prefix .. QTR_ExpandUnitInfo(GS_Gossip[OptHash],false,GTxtframe,WOWTR_Font2,-40) .. sufix .. " ";   -- twarda spacja na końcu
                  end
                  QTR_goss_optionsEN[GTxtframe] = GOptionText;   -- zapis tekstu oryginalnego gossip option
                  QTR_goss_optionsTR[GTxtframe] = transTR;       -- zapis tekstu przetłumaczonego gossip option
                  GTxtframe:SetText(transTR);                    -- tu nic nie odwracamy, transTR jest już przerobiony
                  if ((GTxtframe.Icon) and (WoWTR_Localization.lang == 'AR')) then
                     local point, relativeTo, relativePoint, xOfs, yOfs = GTxtframe.Icon:GetPoint(1);
                     if (relativePoint ~= "TOPRIGHT") then
                        GTxtframe.Icon:ClearAllPoints();
                        GTxtframe.Icon:SetPoint(point, relativeTo, "TOPRIGHT", xOfs-40, yOfs);
                     end
                  end
               else
                  -- zapis do pliku
                  if (C_Map.GetBestMapForUnit("player")) then
                     QTR_GOSSIP[Nazwa_NPC.."@"..tostring(OptHash).."@"..C_Map.GetBestMapForUnit("player")] = GOptionText.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class;
                  else
                     QTR_GOSSIP[Nazwa_NPC.."@"..tostring(OptHash).."@0"] = GOptionText.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class;
                  end
               end
               local regions = { GTxtframe:GetRegions() };     -- poszukiwanie obiektu FontString do ustawienia własnej czcionki
               for k, v in pairs(regions) do
                  if (v:GetObjectType() == "FontString") then
                     v:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"]));
--                     QTR_goss_optionsFONT[GTxtframe] = v;     -- zapis obiektu z czcionką tekstu tureckiego
                  end
               end
               GTxtframe:Resize();
               if (GTxtframe:GetHeight() > GO_height+1) then
                  GO_resized = GO_resized + GTxtframe:GetHeight() - GO_height;
               end
            end
         end
      end
      
      if ( QTR_first_ok ) then   -- przełącz na angielski
         GS_ON_OFF();
      end
   end
   
   -- Gossip Frame Buttons - Goodbye,
   -- print("Gossip Frame");
   local GFGoodbyeBtext = GossipFrame.GreetingPanel.GoodbyeButton.Text;
   ST_CheckAndReplaceTranslationText(GFGoodbyeBtext, true, "ui",false,true);
end

-------------------------------------------------------------------------------------------------------------------

function GossipOnQuestFrame()       -- frame: QuestFrame
   QTR_IconAI:Hide();
   GoQ_IconAI:Hide();
   if ((GreetingText:IsVisible()) and (QTR_PS["gossip"]=="1")) then     -- mamy gossip w QuestFrame i włączone wyświetlanie tłumaczeń gossip
      QTR_ToggleButton0:Disable();                                      -- wyłącz możliwość przełączania EN-TR
      QTR_ToggleButton0:SetWidth(200);
      local Greeting_Text = GreetingText:GetText();
      if (Greeting_Text and (string.find(Greeting_Text," ")==nil)) then         -- nie jest to tekst po turecku (nie ma twardej spacji)
         local GO_resized = 0;
         QTR_goss_optionsEN = { };    -- wyzeruj tablicę na opcje EN gossip
         QTR_goss_optionsTR = { };    -- wyzeruj tablicę na opcje TR gossip
         local Origin_Text = WOWTR_DetectAndReplacePlayerName(Greeting_Text);
         local Czysty_Text = WOWTR_DeleteSpecialCodes(Origin_Text);
         local Hash = StringHash(Czysty_Text);
         QTR_curr_hash = Hash;
         QTR_GS[Hash] = Greeting_Text;                      -- zapis oryginalnego tekstu
         if ( GS_Gossip[Hash] ) then   -- istnieje tłumaczenie tekstu GOSSIP dla tego hasha
            QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(Hash).." "..WoWTR_Localization.lang);
            QTR_ToggleButton0:SetScript("OnClick", GS_ON_OFF2);
            QTR_ToggleButton0:Enable();
            local Greeting_TR = GS_Gossip[Hash];
            local GO_height = GreetingText:GetHeight();
            GreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR.." ",false,GreetingText,WOWTR_Font2));
            GreetingText:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"]));
--            GreetingText:Resize();
            QTR_curr_goss="1";
            if (GreetingText:GetHeight() > GO_height+1) then
               GO_resized = GO_resized + GreetingText:GetHeight() - GO_height;
            end
            if (GS_AI and GS_AI[Hash]) then
               GoQ_IconAI:Show();
            end
            if (isDUIQuestFrame()) then   -- jest aktywny dodatek DialogueUI i zezwolono na tłumaczenia
               QTR_ToggleButton6:SetText("Gossip-Hash="..tostring(Hash).." ("..WoWTR_Localization.lang..")");
               QTR_ToggleButton6:Enable();
               QTR_DUIGossipFrame();
            end
         else                       -- brak tłumaczenia
            QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(Hash).." (EN)");
            if (QTR_PS["saveGS"]=="1") then
               local Nazwa_NPC = QuestFrameTitleText:GetText();
               Origin_Text = string.gsub(Origin_Text, '"', '\"');                
               QTR_GOSSIP[Nazwa_NPC..'@'..tostring(Hash)..'@'..C_Map.GetBestMapForUnit("player")] = Origin_Text..'@'..WOWTR_player_name..':'..WOWTR_player_race..':'..WOWTR_player_class;
            end
         end
         if (CurrentQuestsText and CurrentQuestsText:IsVisible()) then
            CurrentQuestsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.currquests,false,CurrentQuestsText,WOWTR_Font1,-30));
            CurrentQuestsText:SetFont(WOWTR_Font1, 18);
         end
         if (AvailableQuestsText and AvailableQuestsText:IsVisible()) then
            AvailableQuestsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.avaiquests,false,AvailableQuestsText,WOWTR_Font1,-30));
            AvailableQuestsText:SetFont(WOWTR_Font1, 18);
         end
         if (QTR_PS["gossip"]=="1") then
            for GText in QuestFrameGreetingPanel.titleButtonPool:EnumerateActive() do     -- options in gossip QuestFrame
               local GossText = GText:GetText();
               local prefix = "";
               local sufix = "";
               if (string.sub(GossText,1,2) == "|c") then
                  prefix = string.sub(GossText, 1, 10);
                  sufix = "|r";
                  GossText = string.gsub(GossText, prefix, "");
                  GossText = string.gsub(GossText, sufix, "");
               end
               local GOptionText = WOWTR_DetectAndReplacePlayerName(GossText, nil, '$N');    -- detect only name of player
               local Czysty_Text = WOWTR_DeleteSpecialCodes(GOptionText, '$N');
               local TitleHash = StringHash(Czysty_text);
               if (GO_resized > 0) then
                  local point, relativeTo, relativePoint, xOfs, yOfs = GText:GetPoint(1);
                  GText:ClearAllPoints();
                  GText:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-GO_resized);
               end
               local GO_height = GText:GetHeight();
               if (GS_Gossip[TitleHash]) then
                  local transTR;
                  if (GText.Icon) then
                     transTR = prefix .. QTR_ExpandUnitInfo(GS_Gossip[TitleHash],false,GText,WOWTR_Font2,-60) .. sufix .. " ";    -- twarda spacja na końcu
                  else
                     transTR = prefix .. QTR_ExpandUnitInfo(GS_Gossip[TitleHash],false,GText,WOWTR_Font2,-40) .. sufix .. " ";    -- twarda spacja na końcu
                  end
                  QTR_goss_optionsEN[GText] = GText:GetText();   -- zapis tekstu oryginalnego gossip option
                  QTR_goss_optionsTR[GText] = transTR;           -- zapis tekstu tureckiego gossip option
                  GText:SetText(transTR);                        -- tu nic nie odwracamy, transTR jest już zrobiony poprawnie
                  if (GText.Icon and (WoWTR_Localization.lang == 'AR')) then
                     local point, relativeTo, relativePoint, xOfs, yOfs = GText.Icon:GetPoint(1);
                     if (relativePoint ~= "TOPRIGHT") then
                        GText.Icon:ClearAllPoints();
                        GText.Icon:SetPoint(point, relativeTo, "TOPRIGHT", xOfs-40, yOfs-7);
                     end
                  end
               else
                  if (QTR_PS["saveGS"]=="1") then
                     local Nazwa_NPC = QuestFrameTitleText:GetText();
                     GossText = WOWTR_DetectAndReplacePlayerName(GossText);
                     GossText = string.gsub(GossText, '"', '\"');
                     if (C_Map.GetBestMapForUnit("player")) then
                        QTR_GOSSIP[Nazwa_NPC..'@'..tostring(TitleHash).."@"..C_Map.GetBestMapForUnit("player")] = GOptionText.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class;
                     else
                        QTR_GOSSIP[Nazwa_NPC..'@'..tostring(TitleHash).."@0"] = GOptionText.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class;
                     end
                  end
               end
               local regions = { GText:GetRegions() };     -- poszukiwanie obiektu FontString do ustawienia własnej czcionki
               for k, v in pairs(regions) do
                  if (v:GetObjectType() == "FontString") then
                     v:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"]));
                  end
               end
               if (GText.Resize) then
                  GText:Resize();
               end
               if (GText:GetHeight() > GO_height+1) then
                  GO_resized = GO_resized + GText:GetHeight() - GO_height;
               end
            end
         end
      end
   end

-- Quest Frame Buttons - Accept, Decline, Complete Quest, Continue and Cancel
-- print("Quest Frame");
   local QFCompleteQBtext = QuestFrameCompleteQuestButtonText;
   ST_CheckAndReplaceTranslationText(QFCompleteQBtext, true, "ui",false,true);

   local QFAcceptBtext = QuestFrameAcceptButtonText;
   ST_CheckAndReplaceTranslationText(QFAcceptBtext, true, "ui",false,true);

   local QFDeclineBtext = QuestFrameDeclineButtonText;
   ST_CheckAndReplaceTranslationText(QFDeclineBtext, true, "ui",false,true);

   local QFContinueBtext = QuestFrameContinueButtonText;
   ST_CheckAndReplaceTranslationText(QFContinueBtext, true, "ui",false,true);

   local QFGoodbyeBtext = QuestFrameGoodbyeButtonText;
   ST_CheckAndReplaceTranslationText(QFGoodbyeBtext, true, "ui",false,true);

   if (WoWTR_Localization.lang == 'AR') then
      local QFNoticetext = QuestInfoAccountCompletedNotice;
      ST_CheckAndReplaceTranslationText(QFNoticetext, true, "ui",false,true);
      QuestInfoAccountCompletedNotice:SetTextColor(0.5, 0, 0.5);
      QuestInfoAccountCompletedNotice:SetJustifyH("RIGHT");
      -- Get the current anchor point and offset
      -- Adjust the x offset by -50 pixels (move to the left)
      local point, relativeTo, relativePoint, xOfs, yOfs = QuestInfoAccountCompletedNotice:GetPoint(1);
      QuestInfoAccountCompletedNotice:SetPoint(point, relativeTo, relativePoint, xOfs - 20, yOfs);
   else  
      local QFNoticetext = QuestInfoAccountCompletedNotice;
      ST_CheckAndReplaceTranslationText(QFNoticetext, true, "ui",false,true);
   end

end

-------------------------------------------------------------------------------------------------------------------

function QTR_SaveQuest(event)
   if (event=="QUEST_DETAIL") then
      QTR_SAVED[QTR_quest_ID.." TITLE"]=C_QuestLog.GetTitleForQuestID(QTR_quest_ID);            -- save original title to future translation
      QTR_SAVED[QTR_quest_ID.." DESCRIPTION"]=WOWTR_DetectAndReplacePlayerName(QuestInfoDescriptionText:GetText());      -- save original text to future translation
      QTR_SAVED[QTR_quest_ID.." OBJECTIVE"]=WOWTR_DetectAndReplacePlayerName(QuestInfoObjectivesText:GetText());    -- save original text to future translation
      local QTR_mapID = C_Map.GetBestMapForUnit("player");
      if (QTR_mapID) then
         local QTR_mapINFO = C_Map.GetMapInfo(QTR_mapID);
         QTR_SAVED[QTR_quest_ID.." MAPID"]=QTR_mapID.."@"..QTR_mapINFO.name.."@"..QTR_mapINFO.mapType.."@"..QTR_mapINFO.parentMapID;     -- save mapID to locale place of this quest
      end
   end
   if (event=="QUEST_PROGRESS") then
      QTR_SAVED[QTR_quest_ID.." PROGRESS"]=WOWTR_DetectAndReplacePlayerName(GetProgressText());      -- save original text to future translation
   end
   if (event=="QUEST_COMPLETE") then
      QTR_SAVED[QTR_quest_ID.." COMPLETE"]=WOWTR_DetectAndReplacePlayerName(QuestInfoRewardText:GetText());        -- save original text to future translation
   end
   if (QTR_SAVED[QTR_quest_ID.." TITLE"]==nil) then
      QTR_SAVED[QTR_quest_ID.." TITLE"]=C_QuestLog.GetTitleForQuestID(QTR_quest_ID);            -- zapisz tytuł w przypadku tylko Zakończenia
   end
   QTR_SAVED[QTR_quest_ID.." PLAYER"]=WOWTR_player_name..'@'..WOWTR_player_race..'@'..WOWTR_player_class;  -- zapisz dane gracza
end

-------------------------------------------------------------------------------------------------------------------

function QTR_ON_OFF()
   if (QTR_curr_trans=="1") then
      QTR_curr_trans="0";
      QTR_Translate_Off(1);
   else   
      QTR_curr_trans="1";
      QTR_Translate_On(1);
   end
end

-------------------------------------------------------------------------------------------------------------------

-- Pierwsza funkcja wywoływana po załadowaniu dodatku
function QTR_START()

   -- Button in QuestFrame (NPC)
   QTR_ToggleButton0 = CreateFrame("Button", nil, QuestFrame, "UIPanelButtonTemplate")
   QTR_ToggleButton0:SetWidth(150)
   QTR_ToggleButton0:SetHeight(20)
   QTR_ToggleButton0:SetText("Quest ID=?")
   QTR_ToggleButton0:Show()
   QTR_ToggleButton0:ClearAllPoints()
   QTR_ToggleButton0:SetPoint("TOPLEFT", QuestFrame, "TOPLEFT", 105, -20)
   QTR_ToggleButton0:SetScript("OnClick", QTR_ON_OFF)

   -- Button in QuestLogPopupDetailFrame
   QTR_ToggleButton1 = CreateFrame("Button", nil, QuestLogPopupDetailFrame, "UIPanelButtonTemplate")
   QTR_ToggleButton1:SetWidth(150)
   QTR_ToggleButton1:SetHeight(20)
   QTR_ToggleButton1:SetText("Quest ID=?")
   QTR_ToggleButton1:Show()
   QTR_ToggleButton1:ClearAllPoints()
   QTR_ToggleButton1:SetPoint("TOPLEFT", QuestLogPopupDetailFrame, "TOPLEFT", 45, -31)
   QTR_ToggleButton1:SetScript("OnClick", QTR_ON_OFF)

   -- Button in QuestMapDetailsScrollFrame
   QTR_ToggleButton2 = CreateFrame("Button", nil, QuestMapDetailsScrollFrame, "UIPanelButtonTemplate")
   QTR_ToggleButton2:SetWidth(150)
   QTR_ToggleButton2:SetHeight(22)
   QTR_ToggleButton2:SetText("Quest ID=?")
   QTR_ToggleButton2:Show()
   QTR_ToggleButton2:ClearAllPoints()
   QTR_ToggleButton2:SetPoint("TOPLEFT", QuestMapDetailsScrollFrame, "TOPLEFT", 96, 32)
   QTR_ToggleButton2:SetScript("OnClick", QTR_ON_OFF)

   -- Button in GossipFrame
   QTR_ToggleButtonGS1 = CreateFrame("Button", nil, GossipFrame, "UIPanelButtonTemplate")
   QTR_ToggleButtonGS1:SetWidth(220)
   QTR_ToggleButtonGS1:SetHeight(20)
   QTR_ToggleButtonGS1:SetText("Gossip-Hash=?")
   QTR_ToggleButtonGS1:ClearAllPoints()
   QTR_ToggleButtonGS1:SetPoint("TOPLEFT", GossipFrame, "TOPLEFT", 75, -20)
   QTR_ToggleButtonGS1:Disable()
   QTR_ToggleButtonGS1:Show()
   QTR_ToggleButtonGS1:SetScript("OnClick", GS_ON_OFF)

   QTR_IconAI = GossipFrame:CreateTexture(nil, "OVERLAY")
   QTR_IconAI:ClearAllPoints()
   QTR_IconAI:SetPoint("TOPRIGHT", QTR_ToggleButtonGS1, "TOPRIGHT", 40, 0)
   QTR_IconAI:SetWidth(24)
   QTR_IconAI:SetHeight(24)
   QTR_IconAI:SetTexture(WoWTR_Localization.mainFolder.."\\Images\\icon_ai.png")
   QTR_IconAI:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines()
      if (GS_Gossip[1975795450]) then
         GameTooltip:AddLine(QTR_ExpandUnitInfo(GS_Gossip[1975795450], false, GameTooltip, WOWTR_Font2).." ", 1, 1, 1, true)   -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13)
      end
      GameTooltip:Show() -- Show the tooltip
   end)
   QTR_IconAI:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end)
   QTR_IconAI:Hide()

   GoQ_IconAI = QuestFrame:CreateTexture(nil, "OVERLAY")
   GoQ_IconAI:ClearAllPoints()
   GoQ_IconAI:SetPoint("TOPRIGHT", QTR_ToggleButton0, "TOPRIGHT", 72, 0)
   GoQ_IconAI:SetWidth(24)
   GoQ_IconAI:SetHeight(24)
   GoQ_IconAI:SetTexture(WoWTR_Localization.mainFolder.."\\Images\\icon_ai.png")
   GoQ_IconAI:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:ClearLines()
      if (GS_Gossip[1975795450]) then
         GameTooltip:AddLine(QTR_ExpandUnitInfo(GS_Gossip[1975795450], false, GameTooltip, WOWTR_Font2).." ", 1, 1, 1, true)   -- white color, wrap
         getglobal("GameTooltipTextLeft1"):SetFont(WOWTR_Font2, 13)
      end
      GameTooltip:Show() -- Show the tooltip
   end)
   GoQ_IconAI:SetScript("OnLeave", function(self)
      GameTooltip:Hide() -- Hide the tooltip
   end)
   GoQ_IconAI:Hide()

   --hooksecurefunc(QuestObjectiveTracker, "Update", QTR_ObjectiveTracker_Check);

   WorldMapFrame:HookScript("OnHide", function() 
      if (not WOWTR_wait(0.01, QTR_ObjectiveTrackerFrame_Titles)) then
      -- opóźnienie 0.1 sek
      end
   end );

   WorldMapFrame:HookScript("OnShow", function() 
      if (not WOWTR_wait(0.2, QTR_QuestScrollFrame_OnShow)) then
      -- opóźnienie 0.2 sek
      end
    WOWTR_wait(0.01, QTR_ObjectiveTrackerFrame_Titles)
   end);
   
   hooksecurefunc("QuestLogQuests_Update", QTR_QuestLogQuests_Update)
   
   -- Function called on clicking a quest name in QuestMapFrame
   hooksecurefunc("QuestMapFrame_ShowQuestDetails", QTR_PrepareReload)
   
   -- Function called on showing GreetingText in QuestFrame
   QuestFrame:HookScript("OnShow", GossipOnQuestFrame)
   QuestFrameAcceptButton:HookScript("OnClick", QTR_QuestFrameButton_OnClick)
   QuestFrameCompleteQuestButton:HookScript("OnClick", QTR_QuestFrameButton_OnClick)
   QuestLogPopupDetailFrame:HookScript("OnShow", QTR_QuestLogPopupShow)

   local versionString = select(4, GetBuildInfo())
   local versionNumber = tonumber(versionString)
   if versionNumber then
      if versionNumber <= 110007 then
         QuestMapFrame.CampaignOverview:HookScript("OnShow", function() StartDelayedFunction(TT_CampaignOverview, 0.5) end)
      else
         QuestMapFrame.QuestsFrame.CampaignOverview:HookScript("OnShow", function() StartDelayedFunction(TT_CampaignOverview, 0.5) end)
      end
   else
   end

   isClassicQuestLog()
   isImmersion()
   isStoryline()
   
   hooksecurefunc(QuestObjectiveTracker, "UpdateSingle", function(self, quest)
      QTR_OverrideObjectiveTrackerHeader(self, quest);
      end);

end

-------------------------------------------------------------------------------------------------------------------

function QTR_QuestLogPopupShow()
   if (QuestLogPopupDetailFrame:IsVisible()) then
      QTR_QuestPrepare("QUEST_DETAIL");
   end
end

-------------------------------------------------------------------------------------------------------------------

-- function QTR_ObjectiveTracker_QuestHeader()
-- print("questheader")
   -- if ( QTR_PS["active"]=="1" and QTR_PS["tracker"]=="1" ) then   -- tłumaczenia włączone
      -- --10.2.7
      -- --local _font1, _size1, _3 = QuestObjectiveTracker.Header.Text:GetFont();   -- odczytaj aktualną czcionkę i rozmiar
      -- --QuestObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.quests));
      -- --QuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, _size1);
      -- --11.00
      -- local _font1, _size1, _3 = QuestObjectiveTracker.Header.Text:GetFont();   -- odczytaj aktualną czcionkę i rozmiar
      -- --QuestObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.quests));
      -- --QuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, _size1);
   -- end
-- end

-------------------------------------------------------------------------------------------------------------------

function QTR_QuestScrollFrame_OnShow()
   if (QTR_PS["active"]=="1" and QTR_PS["tracker"]=="1") then   -- translations enabled
      if (QuestScrollFrame.Contents.StoryHeader.Progress and QuestScrollFrame.Contents.StoryHeader.Progress:GetText()) then
         local txt = QuestScrollFrame.Contents.StoryHeader.Progress:GetText();
         
         txt = string.gsub(txt, "Story Progress", QTR_ReverseIfAR(WoWTR_Localization.storyLineProgress));
         txt = string.gsub(txt, "Chapters", QTR_ReverseIfAR(WoWTR_Localization.storyLineChapters));

         local _font1, _size1, _3 = QuestScrollFrame.Contents.StoryHeader.Progress:GetFont();   -- get current font and size
         QuestScrollFrame.Contents.StoryHeader.Progress:SetText(txt);
         QuestScrollFrame.Contents.StoryHeader.Progress:SetFont(WOWTR_Font2, _size1);
         
         if (WoWTR_Localization.lang == 'AR') then
            -- Set text alignment to right using anchors
            QuestScrollFrame.Contents.StoryHeader.Progress:ClearAllPoints();
            QuestScrollFrame.Contents.StoryHeader.Progress:SetPoint("TOPRIGHT", QuestScrollFrame.Contents.StoryHeader, "TOPRIGHT", -10, -40);
            QuestScrollFrame.Contents.StoryHeader.Progress:SetJustifyH("RIGHT");
         else
            -- For other languages, set alignment to left
            QuestScrollFrame.Contents.StoryHeader.Progress:ClearAllPoints();
            QuestScrollFrame.Contents.StoryHeader.Progress:SetPoint("TOPLEFT", QuestScrollFrame.Contents.StoryHeader, "TOPLEFT", 10, -40);
            QuestScrollFrame.Contents.StoryHeader.Progress:SetJustifyH("LEFT");
         end
      end
   end
   if (TT_PS["ui1"]=="1") then
      local QuestScrollFrameText01 = QuestScrollFrame.EmptyText;
      if QuestScrollFrameText01 then
         ST_CheckAndReplaceTranslationTextUI(QuestScrollFrameText01, true, "ui"); -- https://imgur.com/4joWH6I
      end
   end
end



-------------------------------------------------------------------------------------------------------------------

-- Kolejny quest w otwartym już oknie QuestFrame?
function QTR_QuestFrameButton_OnClick()
   if (not WOWTR_wait(0.5, QTR_QuestFrameWithoutOpenQuestFrame)) then
      -- opóźnienie 0.5 sek
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_QuestFrameWithoutOpenQuestFrame()
   if (QuestFrame:IsVisible()) then
      GossipOnQuestFrame();
   end
end

-------------------------------------------------------------------------------------------------------------------

function isClassicQuestLog()
   if (ClassicQuestLog ~= nil ) then
      if (QTR_ToggleButton3==nil) then
         -- przycisk z nr ID questu w ClassicQuestLog
         QTR_ToggleButton3 = CreateFrame("Button",nil, ClassicQuestLog, "UIPanelButtonTemplate");
         QTR_ToggleButton3:SetWidth(150);
         QTR_ToggleButton3:SetHeight(20);
         QTR_ToggleButton3:SetText("Quest ID=?");
         QTR_ToggleButton3:ClearAllPoints();
         QTR_ToggleButton3:SetPoint("TOPLEFT", ClassicQuestLog, "TOPLEFT", 330, -33);
         QTR_ToggleButton3:SetScript("OnClick", QTR_ON_OFF);
--         QTR_ToggleButton3:Disable();         -- wyłączam, bo uaktualnienie poniżej jest zbyt często
         -- uaktualniono dane w QuestLogu
         ClassicQuestLog:HookScript("OnUpdate", function() QTR_PrepareDelay(1) end);
      end
      if (QTR_PS["questlog"]=="0") then       -- jest aktywny Classic Quest Log, ale nie zezwolono na tłumaczenie
         QTR_ToggleButton3:Hide();
         return false;
      else
         QTR_ToggleButton3:Show();
         return true;
      end
   else
      return false;   
   end
end

-------------------------------------------------------------------------------------------------------------------

function isImmersion()
   if (ImmersionFrame ~= nil ) then            -- jest uruchomiony dodatek Immersion
      if (QTR_ToggleButton4==nil) then
         -- przycisk z nr ID questu
         QTR_ToggleButton4 = CreateFrame("Button",nil, ImmersionFrame.TalkBox, "UIPanelButtonTemplate");
         QTR_ToggleButton4:SetWidth(150);
         QTR_ToggleButton4:SetHeight(20);
         QTR_ToggleButton4:SetText(QTR_ReverseIfAR(WoWTR_Localization.choiceQuestFirst));  -- może: QTR_ExpandUnitInfo ?
         QTR_ToggleButton4:ClearAllPoints();
         QTR_ToggleButton4:SetPoint("TOPLEFT", ImmersionFrame.TalkBox, "TOPRIGHT", -200, -116);
         QTR_ToggleButton4:SetScript("OnClick", QTR_ON_OFF);
         -- otworzono okno dodatku Immersion : wywołanie przez OnEvent
         ImmersionFrame.TalkBox:HookScript("OnHide",function() QTR_ToggleButton4:Hide(); end);
         QTR_ToggleButton4:Disable();          -- nie można na razie przyciskać przycisku
      end
      if (QTR_PS["immersion"]=="0") then       -- jest aktywny Immersion, ale nie zezwolono na tłumaczenie
         QTR_ToggleButton4:Hide();
         return false;
      else
         QTR_ToggleButton4:Show();
         return true;
      end
   else   
      return false;
   end
end
   
-------------------------------------------------------------------------------------------------------------------

function isStoryline()
   if (Storyline_NPCFrame ~= nil ) then         -- jest uruchomiony dodatek StoryLine
      if (QTR_ToggleButton5==nil) then
         -- przycisk z nr ID questu
         QTR_ToggleButton5 = CreateFrame("Button",nil, Storyline_NPCFrameChat, "UIPanelButtonTemplate");
         QTR_ToggleButton5:SetWidth(150);
         QTR_ToggleButton5:SetHeight(20);
         QTR_ToggleButton5:SetText(QTR_ReverseIfAR(WoWTR_Localization.choiceQuestFirst));  -- może: QTR_ExpandUnitInfo ?
         QTR_ToggleButton5:ClearAllPoints();
         QTR_ToggleButton5:SetPoint("BOTTOMLEFT", Storyline_NPCFrameChat, "BOTTOMLEFT", 244, -16);
         QTR_ToggleButton5:SetScript("OnClick", QTR_ON_OFF);
         Storyline_NPCFrameObjectivesContent:HookScript("OnShow", function() QTR_Storyline_Objectives() end);
         Storyline_NPCFrameRewards:HookScript("OnShow", function() QTR_Storyline_Rewards() end);
         Storyline_NPCFrameChat:HookScript("OnHide", function() QTR_Storyline_Hide() end);
         QTR_ToggleButton5:Disable();          -- nie można na razie przyciskać przycisku
      end
      if (QTR_PS["storyline"]=="0") then       -- jest aktywny StoryLine, ale nie zezwolono na tłumaczenie
         QTR_ToggleButton5:Hide();
         return false;
      else
         QTR_ToggleButton5:Show();
         return true;
      end
   else
      return false;
   end
end

-------------------------------------------------------------------------------------------------------------------

function isDUIQuestFrame()
   if (DUIQuestFrame ~= nil) then        -- jest uruchomiony dodatek DialogueUI
      if (QTR_ToggleButton6 == nil) then    -- przycisk w oknie tekstu gossip
         -- przycisk z Hash gossip
         QTR_ToggleButton6 = CreateFrame("Button", nil, DUIQuestFrame, "UIPanelButtonTemplate")
         QTR_ToggleButton6:SetWidth(150)
         QTR_ToggleButton6:SetHeight(20)
         QTR_ToggleButton6:SetText("Gossip-Hash=?")
         QTR_ToggleButton6:ClearAllPoints()
         QTR_ToggleButton6:SetPoint("TOPLEFT", DUIQuestFrame, "TOPLEFT", 140, -16)
         QTR_ToggleButton6:SetScript("OnClick", gossipDUI_ON_OFF)
         QTR_ToggleButton6:Disable()          -- nie można na razie przyciskać przycisku

         -- Set smaller font size by modifying the FontString
         local font = QTR_ToggleButton6:GetFontString()
         font:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
      end

      if (QTR_ToggleButton7 == nil) then    -- przycisk w oknie zadania
         -- przycisk z nr ID questu
         QTR_ToggleButton7 = CreateFrame("Button", nil, DUIQuestFrame, "UIPanelButtonTemplate")
         QTR_ToggleButton7:SetWidth(100)
         QTR_ToggleButton7:SetHeight(20)
         QTR_ToggleButton7:SetText("Quest ID=?")
         QTR_ToggleButton7:ClearAllPoints()
         QTR_ToggleButton7:SetPoint("TOPLEFT", DUIQuestFrame, "TOPLEFT", 180, -16)
         QTR_ToggleButton7:SetScript("OnClick", DUI_ON_OFF)
         QTR_ToggleButton7:Disable()          -- nie można na razie przyciskać przycisku

         -- Set smaller font size by modifying the FontString
         local font = QTR_ToggleButton7:GetFontString()
         font:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
         
         DUIQuestFrame:HookScript("OnHide", function() QTR_ToggleButton6:Hide(); QTR_ToggleButton7:Hide(); end)
      end

      if (QTR_PS["dialogueui"] == "0") then      -- jest aktywny DialogueUI, ale nie zezwolono na tłumaczenie
         QTR_ToggleButton6:Hide()
         QTR_ToggleButton7:Hide()
         return false
      else
         QTR_ToggleButton6:Show()
         QTR_ToggleButton7:Show()
         return true
      end
   else
      return false
   end
end


-------------------------------------------------------------------------------------------------------------------

-- Określa aktualny numer ID questu z różnych metod
function QTR_GetQuestID()
   local quest_ID;
   
   if (QuestFrame:IsVisible() or isStoryline() or isImmersion() or isDUIQuestFrame()) then
      quest_ID = GetQuestID();
   end
   
   if (((quest_ID==nil) or (quest_ID==0)) and QuestMapDetailsScrollFrame:IsVisible()) then
      quest_ID = QuestMapFrame.DetailsFrame.questID;
   end         

   if (((quest_ID==nil) or (quest_ID==0)) and QuestLogPopupDetailFrame:IsVisible()) then
      quest_ID = QuestLogPopupDetailFrame.questID;
   end
      
   if (((quest_ID==nil) or (quest_ID==0)) and isClassicQuestLog()) then
      quest_ID = C_QuestLog.GetSelectedQuest();
   end
   
   if (quest_ID==nil) then
      quest_ID=0;
   end   
   
   return (quest_ID);
end

-------------------------------------------------------------------------------------------------------------------

objectiveSpecials = {
   ClickComplete = function(fontString)
      fontString:SetText("("..QTR_ReverseIfAR(WoWTR_Localization.clickToComplete)..")");   -- (click to complete),  może: QTR_ExpandUnitInfo ?
      fontString:SetFont(WOWTR_Font2, 13);   
   end,
 
   Failed = function(fontString)
      fontString:SetText(QTR_ReverseIfAR(WoWTR_Localization.failed));                      -- failed,  może: QTR_ExpandUnitInfo ?
   end,
 
   QuestComplete = function(fontString, questID)
      if ((fontString:GetText() == QUEST_WATCH_QUEST_READY) or (fontString:GetText() == "Ready for turn-in")) then
         fontString:SetText(QTR_ReverseIfAR(WoWTR_Localization.readyForTurnIn));           -- Ready for turn-in,  może: QTR_ExpandUnitInfo ?
      else
         if (QTR_quest_EN[questID] and QTR_quest_EN[questID].objectives) then
            local obj = QTR_quest_EN[questID].objectives;
            local obj1= strsplit("\n\n", obj);
            if (QTR_QuestData[tostring(questID)] and (fontString:GetText() == obj1)) then
               obj = QTR_ExpandUnitInfo(QTR_QuestData[tostring(questID)]["Objectives"],true,fontString,WOWTR_Font2);
               obj1= strsplit("\n\n", obj);
               fontString:SetText(QTR_ReverseIfAR(obj1));      -- może: QTR_ExpandUnitInfo ?
               fontString:SetFont(WOWTR_Font2, 12);
               QTR_ResizeBlock(fontString);
            elseif (string.find(fontString:GetText()," ") == nil) then   -- nie jest to przetłumaczony tekst
               local qtr_obj = fontString:GetText();
               for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online) do
                  qtr_obj = string.gsub(qtr_obj, qtr_en, qtr_pl);
               end
               fontString:SetText(QTR_ReverseIfAR(qtr_obj).." ");         -- może: QTR_ExpandUnitInfo ?
               fontString:SetFont(WOWTR_Font2, 12);
               QTR_ResizeBlock(fontString);
            end
         elseif (string.find(fontString:GetText()," ") == nil) then   -- nie jest to przetłumaczony tekst
            local qtr_obj = fontString:GetText();
            for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online) do
               qtr_obj = string.gsub(qtr_obj, qtr_en, qtr_pl);
            end
            fontString:SetText((qtr_obj).." ");            -- może: QTR_ExpandUnitInfo ?
            fontString:SetFont(WOWTR_Font2, 12);
            QTR_ResizeBlock(fontString);
         end
      end
   end,
 
   Waypoint = function(fontString, questID)
      local waypointText = C_QuestLog.GetNextWaypointText(questID);
      if (waypointText) then
         fontString:SetText(("0/1 %s ("..QTR_ReverseIfAR(WoWTR_Localization.optional)..")"):format(waypointText));    -- 0/1 %s (Optional)
         fontString:SetFont(WOWTR_Font2, 12);   
      end
   end
}

-------------------------------------------------------------------------------------------------------------------

function QTR_ObjectiveTracker_Check()
   if ( QTR_PS["active"]=="1" and QTR_PS["tracker"]=="1" ) then   -- tłumaczenia włączone
      -- ObjectiveTrackerFrame.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.objectives));
      -- ObjectiveTrackerFrame.Header.Text:SetFont(WOWTR_Font2, 16);
      -- QuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 16);
      -- if (WoWTR_Localization.lang == 'AR') then
         -- --Added New Translation Campaign and Scenario for Arabic only
         -- ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetFont(WOWTR_Font2, 16);
         -- ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetFont(WOWTR_Font2, 16);
         -- ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.campaignquests));
         -- ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.scenariodung));
         -- --Make LEFT
         -- ObjectiveTrackerBlocksFrame.CampaignQuestHeader.Text:SetJustifyH("LEFT");
         -- ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetJustifyH("LEFT");
         -- -- --10.2.7
         -- -- --ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetJustifyH("LEFT");
         -- -- --11.00
         -- QuestObjectiveTracker.Header.Text:SetJustifyH("LEFT");
      -- end
      -- --10.2.7
      -- --ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.quests));   -- może: QTR_ExpandUnitInfo ?
      -- --11.00
      -- QuestObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.quests));   -- może: QTR_ExpandUnitInfo ?

--      for questID, block in pairs(QuestObjectiveTracker.ContentsFrame) do
--         QTR_OverrideObjectiveTrackerHeader(QuestObjectiveTracker.ContentsFrame, questID);
--         local str_ID = tostring(questID);
--         if (str_ID and QTR_PS["transtitle"]=="1" and QTR_QuestData[str_ID] and block.HeaderText) then  -- tłumaczenie tytułu
--            block.HeaderText:SetText(QTR_ReverseIfAR(QTR_ExpandUnitInfo(QTR_QuestData[str_ID]["Title"]),false,block.HeaderText,WOWTR_Font2));
--            if (WoWTR_Localization.lang == 'AR') then
--               block.HeaderText:SetFont(WOWTR_Font2, 14);
--            else
--               block.HeaderText:SetFont(WOWTR_Font2, 12);
--            end
--            QTR_ResizeBlock(block.HeaderText);
--         end
--         local objectives = block.lines;
--         for special, func in pairs(objectiveSpecials) do
--            if (questID and objectives[special]) then
--               func(objectives[special].Text, questID);
--            end
--         end
--         if (block.currentLine and block.currentLine.Text) then
--            local qtr_obj = block.currentLine.Text:GetText();
--            for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online) do
--               qtr_obj = string.gsub(qtr_obj, qtr_en, qtr_pl);
--            end
--            block.currentLine.Text:SetText(QTR_ReverseIfAR(qtr_obj));    -- może: QTR_ExpandUnitInfo ?
--            if (WoWTR_Localization.lang == 'AR') then
--               block.currentLine.Text:SetFont(WOWTR_Font2, 13);
--            else
--               block.currentLine.Text:SetFont(WOWTR_Font2, 11);
--            end
--            QTR_ResizeBlock(block.currentLine.Text);
--         end
--         for index = 1, #objectives do
--            if ((index <= #objectives) and objectives[index]) then
--               local qtr_obj = objectives[index].Text:GetText();
--               for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online) do
--                  qtr_obj = string.gsub(qtr_obj, qtr_en, qtr_pl);
--               end
--               objectives[index].Text:SetText(QTR_ReverseIfAR(qtr_obj)); -- może: QTR_ExpandUnitInfo ?
--               if (WoWTR_Localization.lang == 'AR') then
--                  objectives[index].Text:SetFont(WOWTR_Font2, 13);
--               else
--                  objectives[index].Text:SetFont(WOWTR_Font2, 11);
--               end
--               QTR_ResizeBlock(objectives[index].Text);
--            end
--         end
--      end
      
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_ObjectiveTrackerFrame_Titles()                       -- Translation of Quest Tracker titles
	if ( QTR_PS["active"]=="1" and QTR_PS["tracker"]=="1" ) then   -- Translations included
			 ObjectiveTrackerFrame.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.objectives));
			 ObjectiveTrackerFrame.Header.Text:SetFont(WOWTR_Font2, 14);
			 QuestObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.quests));
			 QuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 14);
			 WorldQuestObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.worldquests));
			 WorldQuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 14);
			 CampaignQuestObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.campaignquests));
			 CampaignQuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 14);
			 BonusObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.bonusobjective));
			 BonusObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 14);
			 MonthlyActivitiesObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.travelerlog));
			 MonthlyActivitiesObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 14);

			if (WoWTR_Localization.lang == 'AR') then
			 --Added New Translation Campaign and Scenario for Arabic only
			 ObjectiveTrackerFrame.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.objectives));
			 ObjectiveTrackerFrame.Header.Text:SetFont(WOWTR_Font2, 16);
			 QuestObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.quests));
			 QuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 16);
			 WorldQuestObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.worldquests));
			 WorldQuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 16);
			 CampaignQuestObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.campaignquests));
			 CampaignQuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 16);
			 BonusObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.bonusobjective));
			 BonusObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 16);
			 MonthlyActivitiesObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.travelerlog));
			 MonthlyActivitiesObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 16);
			 --Make LEFT
			 ObjectiveTrackerFrame.Header.Text:SetJustifyH("LEFT");
			 QuestObjectiveTracker.Header.Text:SetJustifyH("LEFT");
			 WorldQuestObjectiveTracker.Header.Text:SetJustifyH("LEFT");
			 CampaignQuestObjectiveTracker.Header.Text:SetJustifyH("LEFT");
			end
	end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_ResizeBlock(element)
   if (not element) then return; end
   if (type(element) ~= "string") then return; end    -- element is not a string
   local dlug = string.len(element:GetText());
   local linia = 11.5;
   local wys, szer;
   if (element:GetWidth()<320) then       -- jest ikonka akcji
      szer = 45;
   elseif (element:GetWidth()<220) then   -- jest ikonka akcji
      szer = 35;
   elseif (element:GetWidth()<120) then   -- jest ikonka akcji
      szer = 25;
   elseif (element:GetWidth()<50) then    -- jest ikonka akcji
      szer = 15;
   else
      szer = 50;
   end
   if (dlug+2<szer) then
      wys = linia;
   elseif (dlug*1.1<=szer*2) then
      wys = linia*2;
   elseif (dlug*1.2<=szer*3) then
      wys = linia*3;
   elseif (dlug*1.25<=szer*4) then
      wys = linia*4;
   elseif (dlug*1.3<=szer*5) then
      wys = linia*5;
   else
      wys = element:GetHeight();
   end
   element:SetHeight(wys);        -- resize text on the block
end

-------------------------------------------------------------------------------------------------------------------

function QTR_QuestLogQuests_Update()
   if ( QTR_PS["active"]=="1" and QTR_PS["tracker"]=="1" ) then   -- tłumaczenia włączone
      for button in QuestScrollFrame.titleFramePool:EnumerateActive() do
         local str_ID = tostring(button.questID);
         if (QTR_PS["transtitle"]=="1" and QTR_QuestData[str_ID]) then           -- tłumaczenie tytułu
            local _font1, _size1, _3 = button.Text:GetFont();                      -- odczytaj aktualną czcionkę i rozmiar
            button.Text:SetText(QTR_ReverseIfAR(QTR_QuestData[str_ID]["Title"]));    -- może: QTR_ExpandUnitInfo ?
            button.Text:SetFont(WOWTR_Font2, _size1);
         end
      end
         for frame in QuestScrollFrame.objectiveFramePool:EnumerateActive() do
            local str_ID = tostring(frame.questID);
            local qtr_obj_original = frame.Text:GetText();  -- Store the original text
            local qtr_obj_translated = qtr_obj_original;    -- Start with the original text for translation attempts
      
            if (strfind(qtr_obj_original, "/") and (strfind(qtr_obj_original, "/") > 0)) then
               for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online) do
                  qtr_obj_translated = string.gsub(qtr_obj_translated, qtr_en, qtr_pl);
               end
               local _font1, _size1, _3 = frame.Text:GetFont();  -- read current font and size
               frame.Text:SetText((qtr_obj_translated));        -- Set the text objective in the Quest Scroll Frame
               frame.Text:SetFont(WOWTR_Font2, _size1);
            else
               if ((qtr_obj_original == QUEST_WATCH_QUEST_READY) or (qtr_obj_original == "Ready for turn-in")) then
                  frame.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.readyForTurnIn));  -- Ready for turn-in
               else
                  local _font1, _size1, _3 = frame.Text:GetFont();  -- Read the current font and size
                  if (QTR_quest_EN[frame.questID] and QTR_quest_EN[frame.questID].objectives) then
                        local obj = QTR_quest_EN[frame.questID].objectives;
                        local obj1 = strsplit("\n\n", obj);
                        if (qtr_obj_original == obj1) then
                           obj = QTR_ExpandUnitInfo(QTR_QuestData[str_ID]["Objectives"], true, frame.Text, WOWTR_Font2);
                           obj1 = strsplit("\n\n", obj);
                           frame.Text:SetText(QTR_ReverseIfAR(obj1));      
                           frame.Text:SetFont(WOWTR_Font2, _size1);
                        else
                           for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online) do
                              qtr_obj_translated = string.gsub(qtr_obj_translated, qtr_en, qtr_pl);
                           end
                           -- Check if the translation is the same as the original
                           if qtr_obj_translated == qtr_obj_original then
                              frame.Text:SetText(qtr_obj_original);  -- revert to the original text
                           else
                              frame.Text:SetText(QTR_ReverseIfAR(qtr_obj_translated));
                           end
                           frame.Text:SetFont(WOWTR_Font2, _size1);
                        end
                  else
                        for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online) do
                           qtr_obj_translated = string.gsub(qtr_obj_translated, qtr_en, qtr_pl);
                        end
                        -- Check if the translation is the same as the original
                        if qtr_obj_translated == qtr_obj_original then
                           frame.Text:SetText(qtr_obj_original);  -- revert to the original text
                        else
                           frame.Text:SetText(QTR_ReverseIfAR(qtr_obj_translated));  -- Not using QTR_ExpandUnitInfo here as per your instruction
                        end
                        frame.Text:SetFont(WOWTR_Font2, _size1);
                  end
               end
            end
      end
      QTR_QuestScrollFrame_OnShow();     -- Story Progress
   end
end

-------------------------------------------------------------------------------------------------------------------

-- Otworzono okienko QuestLogPopupDetailFrame lub QuestMapDetailsScrollFrame lub ClassicQuestLog lub Immersion
function QTR_QuestPrepare(zdarzenie)
   QTR_PrepareTime = time();
   QTR_IconAI:Hide();
   GoQ_IconAI:Hide();
   if (isClassicQuestLog()) then
      if (QTR_PS["questlog"]=="0") then       -- jest aktywny ClassicQuestLog, ale nie zezwolono na tłumaczenie
         QTR_ToggleButton3:Hide();
         return;
      else   
         QTR_ToggleButton3:Show();
         if (ClassicQuestLog:IsVisible() and (QTR_curr_trans=="0")) then
            QTR_Translate_Off(1);
            return;
         end
      end   
   end
   if (isImmersion()) then
      if (ImmersionContentFrame:IsVisible() and (QTR_curr_trans=="0")) then
         QTR_Translate_Off(1);
         return;
      end      
   end
   if (isDUIQuestFrame()) then
      QTR_ToggleButton6:Hide();     -- przycisk w ramce DUIQuestFrame (gossip)
   end
   
   q_ID = QTR_GetQuestID();         -- uzyskaj aktualne ID questu
   if (q_ID==0) then
      return
   end   

   QTR_quest_ID = q_ID;
   str_ID = tostring(q_ID);
   if ( not (QTR_quest_EN[QTR_quest_ID])) then
      QTR_quest_EN[QTR_quest_ID] = { };
      QTR_quest_LG[QTR_quest_ID] = { };
   end
   QTR_ToggleButton0:SetWidth(150);
   QTR_ToggleButton0:SetScript("OnClick", QTR_ON_OFF);
   if ( QTR_PS["active"]=="1" ) then   -- tłumaczenia włączone
      QTR_ToggleButton0:Enable();      -- przycisk w ramce QuestFrame (NPC)
      QTR_ToggleButton1:Enable();      -- przycisk w ramce QuestLogPopupDetailFrame
      QTR_ToggleButton2:Enable();      -- przycisk w ramce QuestMapDetailsScrollFrame
--      if (isClassicQuestLog()) then
--         QTR_ToggleButton3:Enable(); -- przycisk w ramce ClassicQuestLog -- wyłączono przyciskanie, bo uaktualnienie zbyt często
--      end
      if (isImmersion()) then
         QTR_ToggleButton4:Enable();   -- przycisk w ramce Immersion
      end
      if (isStoryline()) then
         QTR_ToggleButton5:Enable();   -- przycisk w ramce StoryLine
      end
      if (QuestNPCModelText:IsVisible()) then              -- jest wyświetlony tekst QuestNPCModelText
         local QTR_ModelText = QuestNPCModelText:GetText();
         if (QTR_ModelText and (string.find(QTR_ModelText," ") == nil)) then   -- nie jest to turecki tekst (twarda spacja)
            QTR_ModelTextHash = StringHash(QTR_ModelText);
            if (GS_Gossip[QTR_ModelTextHash]) then         -- jest tłumaczenie w bazie gossip
               QTR_ModelText_EN = QTR_ModelText;
               QTR_ModelText_PL = GS_Gossip[QTR_ModelTextHash];
            else
               local mapka = 0;
               if (C_Map.GetBestMapForUnit("player")) then
                  mapka = C_Map.GetBestMapForUnit("player") or 0;
               end
               local QTR_QuestNPCModelName = "Unknown Monster";
               if (QuestNPCModelNameText and QuestNPCModelNameText:GetText()) then
                  QTR_QuestNPCModelName = QuestNPCModelNameText:GetText();
               end
               QTR_GOSSIP[QTR_QuestNPCModelName.."@"..tostring(QTR_ModelTextHash).."@"..tostring(mapka)] = QTR_ModelText.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class;  -- zapisz do tłumaczenia
               QTR_ModelTextHash = 0;
            end
         end
      end      
      if (isDUIQuestFrame()) then
         QTR_ToggleButton7:Enable();   -- przycisk w ramce DUIQuestFrame (quests)
      end
      QTR_curr_trans = "1";                -- aktualnie wyświetlane jest tłumaczenie PL
      QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose0;
      QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv0;
      if ( QTR_QuestData[str_ID] ) then    -- wyświetlaj tylko, gdy istnieje tłumaczenie
         if (QTR_quest_EN[QTR_quest_ID].title == nil) then
            QTR_quest_LG[QTR_quest_ID].title = QTR_QuestData[str_ID]["Title"];
            QTR_quest_EN[QTR_quest_ID].title = GetTitleText();
            if (QTR_quest_EN[QTR_quest_ID].title=="") then
               QTR_quest_EN[QTR_quest_ID].title=QuestInfoTitleHeader:GetText();
            end
         end
         if (QTR_quest_LG[QTR_quest_ID].details == nil) then
            QTR_quest_LG[QTR_quest_ID].details = QTR_QuestData[str_ID]["Description"];
            QTR_quest_LG[QTR_quest_ID].objectives = QTR_QuestData[str_ID]["Objectives"];
         end
         if (zdarzenie=="QUEST_DETAIL") then
            if (QTR_quest_EN[QTR_quest_ID].details == nil) then
               QTR_quest_EN[QTR_quest_ID].details = GetQuestText();
               QTR_quest_EN[QTR_quest_ID].objectives = GetObjectiveText();
            end
            -- sprawdź ile jest nagród za ten quest?
            quest_numReward[str_ID] = GetNumQuestChoices();
            if (quest_numReward[str_ID]>1) then
               QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose1;
               QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose1;
            else
               QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose0;
               QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose0;
            end
            -- czy jest jeszcze kasa w nagrodę? a może jest tylko sama kasa?
            if (quest_numReward[str_ID]>0) then
               QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv1;
               QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv1;
            else
               QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv0;
               QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv0;
            end
            if (strlen(QTR_quest_EN[QTR_quest_ID].details)>0 and strlen(QTR_quest_LG[QTR_quest_ID].details)==0) then
               QTR_MISSING[QTR_quest_ID.." DESCRIPTION"]=WOWTR_DetectAndReplacePlayerName(QTR_quest_EN[QTR_quest_ID].details);    -- save missing translation part
            end
            if (strlen(QTR_quest_LG[QTR_quest_ID].details)==0) then
               QTR_quest_LG[QTR_quest_ID].details = QTR_quest_EN[QTR_quest_ID].details;         -- If the translation is missing, the original text appears.
            end
            if (strlen(QTR_quest_EN[QTR_quest_ID].objectives)>0 and strlen(QTR_quest_LG[QTR_quest_ID].objectives)==0) then
               QTR_MISSING[QTR_quest_ID.." OBJECTIVE"]=WOWTR_DetectAndReplacePlayerName(QTR_quest_EN[QTR_quest_ID].objectives);   -- save missing translation part
            end
            if (strlen(QTR_quest_LG[QTR_quest_ID].objectives)==0) then
               QTR_quest_LG[QTR_quest_ID].objectives = QTR_quest_EN[QTR_quest_ID].objectives;   -- If the translation is missing, the original text appears.
            end
         else        -- nie jest to zdarzenie QUEST_DETAILS
            if (QTR_quest_EN[QTR_quest_ID].details == nil) then
               QTR_quest_EN[QTR_quest_ID].details = QuestInfoDescriptionText:GetText();
            end
            if (QTR_quest_EN[QTR_quest_ID].objectives == nil) then
               QTR_quest_EN[QTR_quest_ID].objectives = QuestInfoObjectivesText:GetText();
            end
            if (quest_numReward[str_ID]==nil) then         -- mamy zapamiętaną liczbę nagród do tego questu
               QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose0;
               QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose0;
               if (MapQuestInfoRewardsFrame.ItemChooseText:IsVisible()) then
                  QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv1;
                  QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv1;
               else
                  QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv0;
                  QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv0;
               end
            else
               if (quest_numReward[str_ID]>1) then
                  QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose1;
                  QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose1;
               else
                  QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose0;
                  QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose0;
               end
               -- czy jest jeszcze kasa w nagrodę? a może jest tylko sama kasa?
               if (quest_numReward[str_ID]>0) then
                  QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv1;
                  QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv1;
               else
                  QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv0;
                  QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv0;
               end
            end
         end   
         if (zdarzenie=="QUEST_PROGRESS") then
            if (QTR_quest_EN[QTR_quest_ID].progress == nil) then
               QTR_quest_EN[QTR_quest_ID].progress = GetProgressText();
               QTR_quest_LG[QTR_quest_ID].progress = QTR_QuestData[str_ID]["Progress"];
            end
            if (strlen(QTR_quest_EN[QTR_quest_ID].progress)>0 and strlen(QTR_quest_LG[QTR_quest_ID].progress)==0) then
               QTR_MISSING[QTR_quest_ID.." PROGRESS"]=WOWTR_DetectAndReplacePlayerName(QTR_quest_EN[QTR_quest_ID].progress);     -- save missing translation part
            end
            if (strlen(QTR_quest_LG[QTR_quest_ID].progress)==0) then
               QTR_quest_LG[QTR_quest_ID].progress = QTR_quest_EN[QTR_quest_ID].progress;   -- If the translation is missing, the original text appears.
            end
         end
         if (zdarzenie=="QUEST_COMPLETE") then
            if (QTR_quest_EN[QTR_quest_ID].completion == nil) then
               QTR_quest_EN[QTR_quest_ID].completion = GetRewardText();
               QTR_quest_LG[QTR_quest_ID].completion = QTR_QuestData[str_ID]["Completion"];
            end
            -- sprawdź ile jest nagród za ten quest?
            if (quest_numReward[str_ID]==nil) then
               quest_numReward[str_ID] = GetNumQuestChoices();
            end
            if (quest_numReward[str_ID]>1) then
               QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose2;
               QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose2;
            else
               QTR_quest_EN[QTR_quest_ID].itemchoose = QTR_MessOrig.itemchoose3;
               QTR_quest_LG[QTR_quest_ID].itemchoose = QTR_Messages.itemchoose3;
            end
            -- czy jest jeszcze kasa w nagrodę? a może jest tylko sama kasa?
            if (quest_numReward[str_ID]>0) then
               QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv3;
               QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv3;
            else
               QTR_quest_EN[QTR_quest_ID].itemreceive = QTR_MessOrig.itemreceiv2;
               QTR_quest_LG[QTR_quest_ID].itemreceive = QTR_Messages.itemreceiv2;
            end
            if (strlen(QTR_quest_EN[QTR_quest_ID].completion)>0 and strlen(QTR_quest_LG[QTR_quest_ID].completion)==0) then
               QTR_MISSING[QTR_quest_ID.." COMPLETE"]=WOWTR_DetectAndReplacePlayerName(QTR_quest_EN[QTR_quest_ID].completion);     -- save missing translation part
            end
            if (strlen(QTR_quest_LG[QTR_quest_ID].completion)==0) then
               QTR_quest_LG[QTR_quest_ID].completion = QTR_quest_EN[QTR_quest_ID].completion;    -- If the translation is missing, the original text appears.
            end
         end   
         QTR_ToggleButton0:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
         QTR_ToggleButton1:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
         QTR_ToggleButton2:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
--         if (isClassicQuestLog()) then
--            QTR_ToggleButton3:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
--            QTR_ToggleButton3:Enable();
--         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
         end
         if (isStoryline() and Storyline_NPCFrame:IsVisible()) then
            QTR_ToggleButton5:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
         end
         QTR_Translate_On(1,zdarzenie);
         if ( QTR_PS["en_first"]=="1" ) then   -- przełącz na angielski
            QTR_ON_OFF();
         end
      else        -- nie ma przetłumaczonego takiego questu
         QTR_ToggleButton0:Disable();     -- przycisk w ramce QuestFrame (NPC)
         QTR_ToggleButton1:Disable();     -- przycisk w ramce QuestLogPopupDetailFrame
         QTR_ToggleButton2:Disable();     -- przycisk w ramce QuestMapDetailsScrollFrame
--         if (isClassicQuestLog()) then
--            QTR_ToggleButton3:Disable();
--         end
         QTR_ToggleButton0:SetText("Quest ID="..str_ID);
         QTR_ToggleButton1:SetText("Quest ID="..str_ID);
         QTR_ToggleButton2:SetText("Quest ID="..str_ID);
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("Quest ID="..str_ID);
         end
         if (isImmersion()) then
            QTR_ToggleButton4:Disable();
            if (q_ID==0) then
               if (ImmersionFrame.TitleButtons:IsVisible()) then
                  QTR_ToggleButton4:SetText(QTR_ReverseIfAR(WoWTR_Localization.choiceQuestFirst));
               end
            else
               QTR_ToggleButton4:SetText("Quest ID="..str_ID);
            end
         end
         if (isStoryline()) then
            QTR_ToggleButton5:Disable();
            QTR_ToggleButton5:SetText("Quest ID="..str_ID);
         end
         if (isDUIQuestFrame()) then
            QTR_ToggleButton6:Hide();     -- przycisk w ramce DUIQuestFrame (gossip)
            QTR_ToggleButton7:Disable();
            QTR_ToggleButton7:SetText("Quest ID="..str_ID);
            if (TT_PS["ui1"] == "1") then
               QTR_DUIbuttons();
            end
         end
         QTR_Translate_Off(1);
         QTR_SaveQuest(zdarzenie);
      end   -- jest przetłumaczony quest w bazie
   else     -- tłumaczenia wyłączone
      QTR_ToggleButton0:Disable();        -- przycisk w ramce QuestFrame (NPC)
      QTR_ToggleButton1:Disable();        -- przycisk w ramce QuestLogPopupDetailFrame
      QTR_ToggleButton2:Disable();        -- przycisk w ramce QuestMapDetailsScrollFrame
      if ( QTR_QuestData[str_ID] ) then   -- ale jest tłumaczenie w bazie
         QTR_ToggleButton1:SetText("Quest ID="..str_ID.." (EN)");
         QTR_ToggleButton2:SetText("Quest ID="..str_ID.." (EN)");
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("Quest ID="..str_ID.." (EN)");
         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("Quest ID="..str_ID.." (EN)");
         end
         if (isStoryline()) then
            QTR_ToggleButton5:SetText("Quest ID="..str_ID.." (EN)");
         end
      else
         QTR_ToggleButton1:SetText("Quest ID="..str_ID);
         QTR_ToggleButton2:SetText("Quest ID="..str_ID);
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("Quest ID="..str_ID);
         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("Quest ID="..str_ID);
         end
         if (isStoryline()) then
            QTR_ToggleButton5:SetText("Quest ID="..str_ID);
         end
         if (isDUIQuestFrame()) then
            QTR_ToggleButton7:SetText("Quest ID="..str_ID);
         end
      end
   end   -- tłumaczenia są włączone
   
   if (TT_PS["ui1"] == "1") then
      
      local QuestMFrame01 = QuestMapFrame.DetailsFrame.BackFrame.BackButton.Text;
      ST_CheckAndReplaceTranslationTextUI(QuestMFrame01, true, "ui");

      local QuestMFrame02 = QuestMapFrame.DetailsFrame.AbandonButton.Text;
      ST_CheckAndReplaceTranslationTextUI(QuestMFrame02, true, "ui");

      local QuestMFrame03 = QuestMapFrame.DetailsFrame.ShareButton.Text;
      ST_CheckAndReplaceTranslationTextUI(QuestMFrame03, true, "ui");

      local QuestMFrame04 = QuestMapFrame.DetailsFrame.TrackButton.Text;
      ST_CheckAndReplaceTranslationTextUI(QuestMFrame04, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------------------

-- wyświetla tłumaczenie
function QTR_Translate_On(typ,event)
   QTR_display_constants(1);
   if (QuestNPCModelText:IsVisible() and (QTR_ModelTextHash>0)) then         -- jest wyświetlony tekst QuestNPCModelText
      QuestNPCModelText:SetText(QTR_ExpandUnitInfo(QTR_ModelText_PL.." ",false,QuestNPCModelText,WOWTR_Font2,-15));   -- na końcu dodajemy "twardą" spację
      QuestNPCModelText:SetFont(WOWTR_Font2, 13);
   end
   
   if (typ==1) then        -- pełne przełączenie (jest tłumaczenie)
      local numer_ID = QTR_quest_ID;
      str_ID = tostring(numer_ID);
      if (numer_ID>0 and QTR_QuestData[str_ID]) then	-- przywróć przetłumaczoną wersję napisów
         QTR_ToggleButton0:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
         QTR_ToggleButton1:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
         QTR_ToggleButton2:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
            if (not WOWTR_wait(0.2,QTR_Immersion)) then    -- wywołaj podmienianie danych po 0.2 sek
               -- opóźnienie 0.2 sek
            end
         end
         if (isStoryline() and Storyline_NPCFrame:IsVisible()) then
            QTR_ToggleButton5:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
            QTR_Storyline(1);
         end
         if (isDUIQuestFrame()) then
            QTR_ToggleButton7:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
            QTR_ToggleButton7:Enable();
         end
         if qtrmajor == 10 and qtrminor == 2 and qtrpatch == 7 then
            -- Code for version 10.2.7
            local WOW_width = 265;
            if (WorldMapFrame:IsVisible()) then
                WOW_width = 245;
            end
            if (QTR_PS["transtitle"] == "1") then
                QuestInfoTitleHeader:SetWidth(WOW_width + 30);
                QuestProgressTitleText:SetWidth(WOW_width + 10);
                QuestInfoTitleHeader:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
                QuestProgressTitleText:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
                if (WorldMapFrame:IsVisible()) then
                    QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50));
                else
                    QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -30));
                end
                QuestProgressTitleText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestProgressTitleText, WOWTR_Font1, -10));
            end
            QuestInfoDescriptionText:SetWidth(WOW_width + 5);
            QuestInfoObjectivesText:SetWidth(WOW_width + 5);
            QuestProgressText:SetWidth(WOW_width);
            QuestInfoRewardText:SetWidth(WOW_width + 5);
            QuestInfoDescriptionText:SetFont(WOWTR_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or 13)
            QuestInfoObjectivesText:SetFont(WOWTR_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or 13)
            QuestProgressText:SetFont(WOWTR_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or 13)
            QuestInfoRewardText:SetFont(WOWTR_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or 13)
            QuestInfoDescriptionText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].details, false, QuestInfoDescriptionText, WOWTR_Font2, -5));
        elseif qtrmajor == 11 then
         local WOW_width = 280;

         if (WoWTR_Localization.lang == 'AR') then
             WOW_width = 320;
         end
         
         if (QuestInfoRewardsFrame:IsVisible() and WoWTR_Localization.lang ~= 'AR') then
             WOW_width = 280;
         end
            if (QTR_PS["transtitle"] == "1") then
                QuestInfoTitleHeader:SetWidth(WOW_width);
                QuestProgressTitleText:SetWidth(WOW_width);
                QuestInfoTitleHeader:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
                QuestProgressTitleText:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
                if (WorldMapFrame:IsVisible()) then
                    QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50));
                else
                    QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50));
                end
                QuestProgressTitleText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestProgressTitleText, WOWTR_Font1, -50));
            end
            if (WoWTR_Localization.lang == 'AR') then
               QuestInfoDescriptionText:SetWidth(WOW_width - 50);
               QuestInfoObjectivesText:SetWidth(WOW_width - 50);
               QuestProgressText:SetWidth(WOW_width - 50);
               QuestInfoRewardText:SetWidth(WOW_width - 45);
           else
               QuestInfoDescriptionText:SetWidth(WOW_width - 1);
               QuestInfoObjectivesText:SetWidth(WOW_width - 1);
               QuestProgressText:SetWidth(WOW_width - 1);
               QuestInfoRewardText:SetWidth(WOW_width);
           end
            QuestInfoDescriptionText:SetFont(WOWTR_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"]))
            QuestInfoObjectivesText:SetFont(WOWTR_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"]))
            QuestProgressText:SetFont(WOWTR_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"]))
            QuestInfoRewardText:SetFont(WOWTR_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"]))
            QuestInfoDescriptionText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].details, false, QuestInfoDescriptionText, WOWTR_Font2, -5));
        else
            -- Handle other versions if necessary
        end
         if (WoWTR_Localization.lang == 'AR') then
            QuestInfoDescriptionText:SetJustifyH("RIGHT");
         else
            QuestInfoDescriptionText:SetJustifyH("LEFT");
         end
         QuestInfoObjectivesText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].objectives,true,QuestInfoObjectivesText,WOWTR_Font2,-10));
         if (WoWTR_Localization.lang == 'AR') then
            QuestInfoObjectivesText:SetJustifyH("RIGHT");
         else
            QuestInfoObjectivesText:SetJustifyH("LEFT");
         end
         QuestProgressText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].progress,false,QuestProgressText,WOWTR_Font2));
         if (WoWTR_Localization.lang == 'AR') then
            QuestProgressText:SetJustifyH("RIGHT");
         else
            QuestProgressText:SetJustifyH("LEFT");
         end
         QuestInfoRewardText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].completion,false,QuestInfoRewardText,WOWTR_Font2,-5));
      end
--      if ((not isImmersion()) and (QuestInfoDescriptionText:GetText()~=QTR_quest_LG[QTR_quest_ID].details) and (QTR_first_show2 == 0)) then   -- nie wczytały się tłumaczenia
--         QTR_first_show2 = 1;
--         if (not WOWTR_wait(0.2,QTR_ON_OFF)) then    -- przeładuj wpierw na OFF
         ---
--         end
--         if (not WOWTR_wait(0.2,QTR_ON_OFF)) then    -- przeładuj ponownie na ON
         ---
--         end
--      end
      if (isDUIQuestFrame()) then
         QTR_DUIQuestFrame(event);
      end
   else
      if (QTR_curr_trans == "1") then
         if ((ImmersionFrame ~= nil ) and (ImmersionFrame.TalkBox:IsVisible() )) then
            if (not WOWTR_wait(0.2,QTR_Immersion_Static)) then
               -- podmiana tekstu z opóźnieniem 0.2 sek
            end
         end
      end
   end
end

-------------------------------------------------------------------------------------------------------------------

-- wyświetla oryginalny tekst angielski
function QTR_Translate_Off(typ,event)
   QTR_display_constants(0);
   if (QuestNPCModelText:IsVisible() and (QTR_ModelTextHash>0)) then
      QuestNPCModelText:SetText(QTR_ModelText_EN);
      QuestNPCModelText:SetFont(Original_Font2, 13);
   end
   
   if (typ==1) then
      local numer_ID = QTR_quest_ID;
      str_ID = tostring(numer_ID);
      if (numer_ID>0 and QTR_QuestData[str_ID]) then
         QTR_ToggleButton0:SetText("Quest ID="..QTR_quest_ID.." (EN)");
         QTR_ToggleButton1:SetText("Quest ID="..QTR_quest_ID.." (EN)");
         QTR_ToggleButton2:SetText("Quest ID="..QTR_quest_ID.." (EN)");
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("Quest ID="..QTR_quest_ID.." (EN)");
         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("Quest ID="..QTR_quest_ID.." (EN)");
            QTR_Immersion_OFF();
            ImmersionFrame.TalkBox.TextFrame.Text:RepeatTexts();
         end
         if (isStoryline() and Storyline_NPCFrame:IsVisible()) then
            QTR_ToggleButton5:SetText("Quest ID="..QTR_quest_ID.." (EN)");
            QTR_Storyline_OFF(1);
         end
         local WOW_width = 280;
         if (QuestInfoRewardsFrame:IsVisible()) then
            WOW_width = 280;
         end
         QuestInfoTitleHeader:SetFont(Original_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
         QuestProgressTitleText:SetFont(Original_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
         QuestInfoTitleHeader:SetText(QTR_quest_EN[QTR_quest_ID].title);
         QuestProgressTitleText:SetText(QTR_quest_EN[QTR_quest_ID].title);
         QuestInfoDescriptionText:SetWidth(WOW_width - 1);
         QuestInfoObjectivesText:SetWidth(WOW_width - 1);
         QuestProgressText:SetWidth(WOW_width - 1);
         QuestInfoRewardText:SetWidth(WOW_width);
         QuestInfoDescriptionText:SetFont(Original_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"]));
         QuestInfoObjectivesText:SetFont(Original_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"]));
         QuestProgressText:SetFont(Original_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"]));
         QuestInfoRewardText:SetFont(Original_Font2, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtext.size or tonumber(QTR_PS["fontsize"]));
         QuestInfoDescriptionText:SetText(QTR_quest_EN[QTR_quest_ID].details);
         QuestInfoObjectivesText:SetText(QTR_quest_EN[QTR_quest_ID].objectives);
         QuestProgressText:SetText(QTR_quest_EN[QTR_quest_ID].progress);
         QuestInfoRewardText:SetText(QTR_quest_EN[QTR_quest_ID].completion);

         -- Reset text alignment and justification for all languages
         QuestInfoDescriptionText:SetJustifyH("LEFT");
         QuestInfoObjectivesText:SetJustifyH("LEFT");
         QuestProgressText:SetJustifyH("LEFT");

         -- Reset experience text
         QuestInfoXPFrame.ReceiveText:SetText(EXPERIENCE_COLON);
         QuestInfoXPFrame.ReceiveText:SetFont(Original_Font2, 13);
         QuestInfoXPFrame.ReceiveText:SetJustifyH("LEFT");

         -- Reset item choose and receive text
         QuestInfoRewardsFrame.ItemChooseText:SetText(QTR_quest_EN[QTR_quest_ID].itemchoose);
         QuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_quest_EN[QTR_quest_ID].itemreceive);
         QuestInfoRewardsFrame.ItemChooseText:SetFont(Original_Font2, 13);
         QuestInfoRewardsFrame.ItemReceiveText:SetFont(Original_Font2, 13);
         QuestInfoRewardsFrame.ItemChooseText:SetJustifyH("LEFT");
         QuestInfoRewardsFrame.ItemReceiveText:SetJustifyH("LEFT");

         -- Hide Arabic-specific text elements
         if QTR_QuestDetail_ItemReceiveText then QTR_QuestDetail_ItemReceiveText:Hide() end
         if QTR_QuestReward_ItemReceiveText then QTR_QuestReward_ItemReceiveText:Hide() end
         if QTR_QuestDetail_InfoXP then QTR_QuestDetail_InfoXP:Hide() end
         if QTR_QuestReward_InfoXP then QTR_QuestReward_InfoXP:Hide() end

         -- Reset reward headers
         local rewardHeaders = {
            REWARD_CHOICES = "ItemChooseText",
            REWARD_ITEMS = "ItemReceiveText",
            REWARD_AURA = "rewardAura",
            REWARD_SPELL = "rewardSpell",
            REWARD_COMPANION = "rewardCompanion",
            REWARD_FOLLOWER = "rewardFollower",
            REWARD_REPUTATION = "rewardReputation",
            REWARD_TITLE = "rewardTitle",
            REWARD_TRADESKILL = "rewardTradeskill",
            REWARD_UNLOCK = "rewardUnlock",
            REWARD_BONUS = "rewardBonus"
         }

         for constant, property in pairs(rewardHeaders) do
            if QuestInfoRewardsFrame[property] then
               QuestInfoRewardsFrame[property]:SetText(_G[constant]);
               QuestInfoRewardsFrame[property]:SetFont(Original_Font2, 13);
               QuestInfoRewardsFrame[property]:SetJustifyH("LEFT");
            end
         end

         -- Process reward headers in the pool
         for fontString in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
            for constant, _ in pairs(rewardHeaders) do
               if fontString:GetText() == QTR_Messages[string.lower(constant)] then
                  fontString:SetText(_G[constant]);
                  fontString:SetFont(Original_Font2, 13);
                  fontString:SetJustifyH("LEFT");
               end
            end
         end
      end
   else   
      if (QTR_curr_trans == "0") then
         if ((ImmersionFrame ~= nil ) and (ImmersionFrame.TalkBox:IsVisible() )) then
            if (not WOWTR_wait(0.2,QTR_Immersion_OFF_Static)) then
               -- delay text replacement by 0.2 sec
            end
         end
      end
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_display_constants(lg)
   if (lg==1 and QTR_QuestData[str_ID]) then        -- dane stałe przetłumaczone
      local WOW_width = 265;
      if (WorldMapFrame:IsVisible()) then
         WOW_width = 245;
      end
      QuestInfoObjectivesHeader:SetWidth(WOW_width+10);
      QuestInfoDescriptionHeader:SetWidth(WOW_width+40);
      QuestInfoRewardsFrame.Header:SetWidth(WOW_width+10);
      QuestProgressRequiredItemsText:SetWidth(WOW_width+7);
      QuestInfoObjectivesHeader:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
      QuestInfoObjectivesHeader:SetText(QTR_ExpandUnitInfo(QTR_Messages.objectives,false,QuestInfoObjectivesHeader,WOWTR_Font1,-10));
      QuestInfoDescriptionHeader:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
      QuestInfoDescriptionHeader:SetText(QTR_ExpandUnitInfo(QTR_Messages.details,false,QuestInfoDescriptionHeader,WOWTR_Font1,-10));
      QuestInfoRewardsFrame.Header:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
      QuestInfoRewardsFrame.Header:SetText(QTR_ExpandUnitInfo(QTR_Messages.rewards,false,QuestInfoRewardsFrame.Header,WOWTR_Font1,-12));
      QuestProgressRequiredItemsText:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
      QuestProgressRequiredItemsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.reqitems,false,QuestProgressRequiredItemsText,WOWTR_Font1,-10));
      CurrentQuestsText:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
      CurrentQuestsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.currquests,false,CurrentQuestsText,WOWTR_Font1,-30));
      AvailableQuestsText:SetFont(WOWTR_Font1, C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18);
      AvailableQuestsText:SetText(QTR_ReverseIfAR(QTR_Messages.avaiquests));
      --10.2.7
      --local regions = { QuestMapFrame.DetailsFrame.RewardsFrame:GetRegions() };
      --11.00
      local regions = { QuestMapFrame.DetailsFrame.RewardsFrameContainer.RewardsFrame:GetRegions() };
      for index = 1, #regions do
         local region = regions[index];
         if ((region:GetObjectType() == "FontString") and (region:GetText() == QUEST_REWARDS)) then
            region:SetText(QTR_ReverseIfAR(QTR_Messages.rewards));
            region:SetFont(WOWTR_Font1, 18);
         end
      end
      
      -- stałe elementy okna zadania:
      if (WoWTR_Localization.lang == 'AR') then
         QuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 14);
         QuestInfoRewardsFrame.ItemChooseText:SetWidth(260);
         QuestInfoRewardsFrame.ItemChooseText:SetJustifyH("RIGHT"); -- wyrównanie od prawego
         QuestInfoRewardsFrame.ItemChooseText:SetText(AS_UTF8reverse(QTR_quest_LG[QTR_quest_ID].itemchoose));
   
         QuestInfoRewardsFrame.ItemReceiveText:SetText(" ");
         QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(" ");
         QuestInfoXPFrame.ReceiveText:SetText(" ");
   
         -- własne obiekty z tekstami arabskimi
         if (not QTR_QuestDetail_ItemReceiveText) then
            QTR_QuestDetail_ItemReceiveText = QuestDetailScrollChildFrame:CreateFontString(nil, "ARTWORK");
            QTR_QuestDetail_ItemReceiveText:SetFontObject(GameFontBlack);
            QTR_QuestDetail_ItemReceiveText:SetJustifyH("RIGHT");
            QTR_QuestDetail_ItemReceiveText:SetJustifyV("TOP");
            QTR_QuestDetail_ItemReceiveText:ClearAllPoints();
            QTR_QuestDetail_ItemReceiveText:SetPoint("TOPRIGHT", QuestInfoRewardsFrame.ItemReceiveText, "TOPLEFT", 260, 2);
            QTR_QuestDetail_ItemReceiveText:SetFont(WOWTR_Font2, 13);
         end
         if (QTR_quest_LG[QTR_quest_ID].itemreceive) then
            QTR_QuestDetail_ItemReceiveText:SetText(AS_UTF8reverse(QTR_quest_LG[QTR_quest_ID].itemreceive));
         else
            QTR_QuestDetail_ItemReceiveText:SetText(AS_UTF8reverse(QTR_Messages.itemreceiv0));
         end
         QTR_QuestDetail_ItemReceiveText:Show();
         if (not QTR_QuestReward_ItemReceiveText) then
            QTR_QuestReward_ItemReceiveText = QuestRewardScrollChildFrame:CreateFontString(nil, "ARTWORK");
            QTR_QuestReward_ItemReceiveText:SetFontObject(GameFontBlack);
            QTR_QuestReward_ItemReceiveText:SetJustifyH("RIGHT");
            QTR_QuestReward_ItemReceiveText:SetJustifyV("TOP");
            QTR_QuestReward_ItemReceiveText:ClearAllPoints();
            QTR_QuestReward_ItemReceiveText:SetPoint("TOPRIGHT", QuestInfoRewardsFrame.ItemReceiveText, "TOPLEFT", 260, 2);
            QTR_QuestReward_ItemReceiveText:SetFont(WOWTR_Font2, 14);
         end
         if (QTR_quest_LG[QTR_quest_ID].itemreceive) then
            QTR_QuestReward_ItemReceiveText:SetText(AS_UTF8reverse(QTR_quest_LG[QTR_quest_ID].itemreceive));
         else
            QTR_QuestReward_ItemReceiveText:SetText(AS_UTF8reverse(QTR_Messages.itemreceiv0));
         end
         if (not QTR_QuestDetail_InfoXP) then
            QTR_QuestDetail_InfoXP = QuestDetailScrollChildFrame:CreateFontString(nil, "ARTWORK");
            QTR_QuestDetail_InfoXP:SetFontObject(GameFontBlack);
            QTR_QuestDetail_InfoXP:SetJustifyH("RIGHT");
            QTR_QuestDetail_InfoXP:SetJustifyV("TOP");
            QTR_QuestDetail_InfoXP:ClearAllPoints();
            QTR_QuestDetail_InfoXP:SetPoint("TOPRIGHT", QuestInfoRewardsFrame.XPFrame.ReceiveText, "TOPLEFT", 260, 2);
            QTR_QuestDetail_InfoXP:SetFont(WOWTR_Font2, 14);
         end
         QTR_QuestDetail_InfoXP:SetText(AS_UTF8reverse(QTR_Messages.experience));
         QTR_QuestDetail_InfoXP:Show();
         if (not QTR_QuestReward_InfoXP) then
            QTR_QuestReward_InfoXP = QuestRewardScrollChildFrame:CreateFontString(nil, "ARTWORK");
            QTR_QuestReward_InfoXP:SetFontObject(GameFontBlack);
            QTR_QuestReward_InfoXP:SetJustifyH("RIGHT");
            QTR_QuestReward_InfoXP:SetJustifyV("TOP");
            QTR_QuestReward_InfoXP:ClearAllPoints();
            QTR_QuestReward_InfoXP:SetPoint("TOPRIGHT", QuestInfoRewardsFrame.XPFrame.ReceiveText, "TOPLEFT", 260, 2);
            QTR_QuestReward_InfoXP:SetFont(WOWTR_Font2, 14);
         end
         QTR_QuestReward_InfoXP:SetText(AS_UTF8reverse(QTR_Messages.experience));
   
         QTR_QuestDetail_ItemReceiveText:Show();
         QTR_QuestReward_ItemReceiveText:Show();
         QTR_QuestDetail_InfoXP:Show();
         QTR_QuestReward_InfoXP:Show();
   
         if (QuestInfoMoneyFrame:IsVisible()) then
            QuestInfoXPFrame.ValueText:ClearAllPoints();
            QuestInfoXPFrame.ValueText:SetPoint("TOPRIGHT", QuestInfoMoneyFrame, "BOTTOMRIGHT", -10, 0);
         end
   
         local max_len = AS_UTF8len(QTR_QuestDetail_ItemReceiveText:GetText());
         local money_len = QuestInfoMoneyFrame:GetWidth();
         local spaces05 = "     ";
         local spaces10 = "          ";
         local spaces15 = "               ";
         local spaces20 = "                    ";
         --print(max_len,money_len)
         if (max_len < 10) then
            if (money_len < 70) then
               QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces20);
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces20);
               QuestInfoXPFrame.ReceiveText:SetText(spaces20);
            elseif (money_len < 90) then
               QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces15);
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces15);
               QuestInfoXPFrame.ReceiveText:SetText(spaces15);
            elseif (money_len < 110) then
               QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces10);
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces10);
               QuestInfoXPFrame.ReceiveText:SetText(spaces10);
            elseif (money_len < 130) then
               QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces05);
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces05);
               QuestInfoXPFrame.ReceiveText:SetText(spaces05);
            end
         elseif (max_len < 20) then
            if (money_len < 70) then
               QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces15);
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces15);
               QuestInfoXPFrame.ReceiveText:SetText(spaces15);
            elseif (money_len < 90) then
               QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces10);
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces10);
               QuestInfoXPFrame.ReceiveText:SetText(spaces15);
            elseif (money_len < 110) then
               QuestInfoRewardsFrame.ItemReceiveText:SetText(spaces05);
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(spaces05);
               QuestInfoXPFrame.ReceiveText:SetText(spaces05);
            end
         end

         QuestInfoSpellObjectiveLearnLabel:SetFont(WOWTR_Font2, 13);
         QuestInfoSpellObjectiveLearnLabel:SetJustifyH("LEFT"); -- wyrównanie od prawego
         QuestInfoSpellObjectiveLearnLabel:SetText(AS_UTF8reverse(QTR_Messages.learnspell));
         MapQuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 16);
         local line_size = MapQuestInfoRewardsFrame.ItemChooseText:GetWidth();
         MapQuestInfoRewardsFrame.ItemChooseText:SetJustifyH("RIGHT"); -- wyrównanie do prawego
         MapQuestInfoRewardsFrame.ItemChooseText:SetText(AS_UTF8reverse(QTR_quest_LG[QTR_quest_ID].itemchoose));
         MapQuestInfoRewardsFrame.ItemReceiveText:SetFont(WOWTR_Font2, 13);
         MapQuestInfoRewardsFrame.ItemReceiveText:SetWidth(line_size);
         MapQuestInfoRewardsFrame.ItemReceiveText:SetJustifyH("RIGHT"); -- wyrównanie do prawego
         MapQuestInfoRewardsFrame.ItemReceiveText:SetText(AS_UTF8reverse(QTR_quest_LG[QTR_quest_ID].itemreceive));
         QuestInfoRewardsFrame.PlayerTitleText:SetFont(WOWTR_Font2, 13);
         QuestInfoRewardsFrame.PlayerTitleText:SetJustifyH("LEFT"); -- wyrównanie od prawego
         QuestInfoRewardsFrame.PlayerTitleText:SetText(AS_UTF8reverse(QTR_Messages.reward_title));
         QuestInfoRewardsFrame.QuestSessionBonusReward:SetFont(WOWTR_Font2, 13);
         QuestInfoRewardsFrame.QuestSessionBonusReward:SetJustifyH("LEFT"); -- wyrównanie od lewego
         QuestInfoRewardsFrame.QuestSessionBonusReward:SetText(AS_UTF8reverse(QTR_Messages.reward_bonus));
         if (QuestInfoRewardsFrame:IsVisible()) then
            for fontString in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
               if (fontString:GetText() == REWARD_AURA) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_aura));
               end
               if (fontString:GetText() == REWARD_SPELL) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_spell));
               end
               if (fontString:GetText() == REWARD_COMPANION) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_companion));
               end
               if (fontString:GetText() == REWARD_FOLLOWER) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_follower));
               end
               if (fontString:GetText() == REWARD_REPUTATION) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_reputation));
               end
               if (fontString:GetText() == REWARD_TITLE) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_title));
               end
               if (fontString:GetText() == REWARD_TRADESKILL) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_tradeskill));
               end
               if (fontString:GetText() == REWARD_UNLOCK) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_unlock));
               end
               if (fontString:GetText() == REWARD_BONUS) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_bonus));
               end
            end
         end
         if (MapQuestInfoRewardsFrame:IsVisible()) then
            for fontString in MapQuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
               if (fontString:GetText() == REWARD_AURA) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_aura));
               end
               if (fontString:GetText() == REWARD_SPELL) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_spell));
               end
               if (fontString:GetText() == REWARD_COMPANION) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_companion));
               end
               if (fontString:GetText() == REWARD_FOLLOWER) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_follower));
               end
               if (fontString:GetText() == REWARD_REPUTATION) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_reputation));
               end
               if (fontString:GetText() == REWARD_TITLE) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_title));
               end
               if (fontString:GetText() == REWARD_TRADESKILL) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_tradeskill));
               end
               if (fontString:GetText() == REWARD_UNLOCK) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_unlock));
               end
               if (fontString:GetText() == REWARD_BONUS) then
                  fontString:SetFont(WOWTR_Font2, 13);
                  fontString:SetJustifyH("RIGHT"); -- wyrównanie od prawego
                  fontString:SetText(AS_UTF8reverse(QTR_Messages.reward_bonus));
               end
            end
         end
      else           -- pozostałe języki poza AR
         QuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 13);
         QuestInfoRewardsFrame.ItemReceiveText:SetFont(WOWTR_Font2, 13);
         QuestInfoRewardsFrame.ItemChooseText:SetText(QTR_quest_LG[QTR_quest_ID].itemchoose);
         QuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_quest_LG[QTR_quest_ID].itemreceive);
         QuestInfoSpellObjectiveLearnLabel:SetFont(WOWTR_Font2, 13);
         QuestInfoSpellObjectiveLearnLabel:SetText(QTR_Messages.learnspell);
         QuestInfoXPFrame.ReceiveText:SetFont(WOWTR_Font2, 13);
         QuestInfoXPFrame.ReceiveText:SetText(QTR_Messages.experience);
         QuestInfoRewardsFrame.XPFrame.ReceiveText:SetFont(WOWTR_Font2, 13);
         QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(QTR_Messages.experience);
         MapQuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 13);
         MapQuestInfoRewardsFrame.ItemReceiveText:SetFont(WOWTR_Font2, 13);
         MapQuestInfoRewardsFrame.ItemChooseText:SetText(QTR_quest_LG[QTR_quest_ID].itemchoose);
         MapQuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_quest_LG[QTR_quest_ID].itemreceive);
         QuestInfoRewardsFrame.PlayerTitleText:SetFont(WOWTR_Font2, 13);
         QuestInfoRewardsFrame.PlayerTitleText:SetText(QTR_Messages.reward_title);
         QuestInfoRewardsFrame.QuestSessionBonusReward:SetFont(WOWTR_Font2, 13);
         QuestInfoRewardsFrame.QuestSessionBonusReward:SetText(QTR_Messages.reward_bonus);
         if ( QuestInfoRewardsFrame:IsVisible() ) then
            for fontString in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
               if (fontString:GetText() == REWARD_AURA) then
                  fontString:SetText(QTR_Messages.reward_aura);
                  fontString:SetFont(WOWTR_Font2, 13);
               end
               if (fontString:GetText() == REWARD_SPELL) then
                  fontString:SetText(QTR_Messages.reward_spell);
                  fontString:SetFont(WOWTR_Font2, 13);
               end
               if (fontString:GetText() == REWARD_COMPANION) then
                  fontString:SetText(QTR_Messages.reward_companion);
                  fontString:SetFont(WOWTR_Font2, 13);
               end
               if (fontString:GetText() == REWARD_FOLLOWER) then
                  fontString:SetText(QTR_Messages.reward_follower);
                  fontString:SetFont(WOWTR_Font2, 13);
               end
               if (fontString:GetText() == REWARD_REPUTATION) then
                  fontString:SetText(QTR_Messages.reward_reputation);
                  fontString:SetFont(WOWTR_Font2, 13);
               end
               if (fontString:GetText() == REWARD_TITLE) then
                  fontString:SetText(QTR_Messages.reward_title);
                  fontString:SetFont(WOWTR_Font2, 13);
               end
               if (fontString:GetText() == REWARD_TRADESKILL) then
                  fontString:SetText(QTR_Messages.reward_tradeskill);
                  fontString:SetFont(WOWTR_Font2, 13);
               end
               if (fontString:GetText() == REWARD_UNLOCK) then
                  fontString:SetText(QTR_Messages.reward_unlock);
                  fontString:SetFont(WOWTR_Font2, 13);
               end
               if (fontString:GetText() == REWARD_BONUS) then
                  fontString:SetText(QTR_Messages.reward_bonus);
                  fontString:SetFont(WOWTR_Font2, 13);
               end
            end
         end
         if ( MapQuestInfoRewardsFrame:IsVisible() ) then
            for fontString in MapQuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
               if (fontString:GetText() == REWARD_AURA) then
                  fontString:SetText(QTR_Messages.reward_aura);
                  fontString:SetFont(WOWTR_Font2, 11);
               end
               if (fontString:GetText() == REWARD_SPELL) then
                  fontString:SetText(QTR_Messages.reward_spell);
                  fontString:SetFont(WOWTR_Font2, 11);
               end
               if (fontString:GetText() == REWARD_COMPANION) then
                  fontString:SetText(QTR_Messages.reward_companion);
                  fontString:SetFont(WOWTR_Font2, 11);
               end
               if (fontString:GetText() == REWARD_FOLLOWER) then
                  fontString:SetText(QTR_Messages.reward_follower);
                  fontString:SetFont(WOWTR_Font2, 11);
               end
               if (fontString:GetText() == REWARD_REPUTATION) then
                  fontString:SetText(QTR_Messages.reward_reputation);
                  fontString:SetFont(WOWTR_Font2, 11);
               end
               if (fontString:GetText() == REWARD_TITLE) then
                  fontString:SetText(QTR_Messages.reward_title);
                  fontString:SetFont(WOWTR_Font2, 11);
               end
               if (fontString:GetText() == REWARD_TRADESKILL) then
                  fontString:SetText(QTR_Messages.reward_tradeskill);
                  fontString:SetFont(WOWTR_Font2, 11);
               end
               if (fontString:GetText() == REWARD_UNLOCK) then
                  fontString:SetText(QTR_Messages.reward_unlock);
                  fontString:SetFont(WOWTR_Font2, 11);
               end
               if (fontString:GetText() == REWARD_BONUS) then
                  fontString:SetText(QTR_Messages.reward_bonus);
                  fontString:SetFont(WOWTR_Font2, 11);
               end
            end
         end
      end
   else        -- przywróć oryginalne teksty
      --Call Function for Reset Quest to Original
      QTR_ResetQuestToOriginal();
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_ResetQuestToOriginal()
   
   -- Reset Quest Info headers and text to original values
   QuestInfoObjectivesHeader:SetText(QTR_MessOrig.objectives);
   QuestInfoObjectivesHeader:SetFont(Original_Font1, 18);
   QuestInfoObjectivesHeader:SetJustifyH("LEFT");
   QuestInfoObjectivesText:SetFont(Original_Font2, 13);
   QuestInfoObjectivesText:SetJustifyH("LEFT");
   
   QuestInfoDescriptionHeader:SetText(QTR_MessOrig.details); 
   QuestInfoDescriptionHeader:SetFont(Original_Font1, 18);
   QuestInfoDescriptionText:SetFont(Original_Font2, 13);
   QuestInfoDescriptionText:SetJustifyH("LEFT");
   
   QuestInfoRewardsFrame.Header:SetText(QTR_MessOrig.rewards);
   QuestInfoRewardsFrame.Header:SetFont(Original_Font1, 18);
   
   QuestProgressRequiredItemsText:SetText(QTR_MessOrig.reqitems);
   QuestProgressRequiredItemsText:SetFont(Original_Font1, 18);
   
   CurrentQuestsText:SetText(QTR_MessOrig.currquests);
   CurrentQuestsText:SetFont(Original_Font1, 18);
   
   AvailableQuestsText:SetText(QTR_MessOrig.avaiquests);
   AvailableQuestsText:SetFont(Original_Font1, 18);

   -- Reset Quest Map rewards text
   --10.2.7
   --local regions = { QuestMapFrame.DetailsFrame.RewardsFrame:GetRegions() };
   --11.00
   local regions = { QuestMapFrame.DetailsFrame.RewardsFrameContainer.RewardsFrame:GetRegions() };
   for index = 1, #regions do
      local region = regions[index];
      if ((region:GetObjectType() == "FontString") and (region:GetText() == QTR_Messages.rewards)) then
         region:SetText(QUEST_REWARDS);
         region:SetFont(Original_Font1, 18);
      end
   end
   
   -- Reset fixed quest window elements
   if (WoWTR_Localization.lang == 'AR') then
      -- For Arabic, set text justification to left
      QuestInfoRewardsFrame.ItemChooseText:SetJustifyH("LEFT");
      QuestInfoRewardsFrame.ItemReceiveText:SetJustifyH("LEFT"); 
      QuestInfoSpellObjectiveLearnLabel:SetJustifyH("LEFT");
      QuestInfoRewardsFrame.XPFrame.ReceiveText:SetJustifyH("LEFT");
      MapQuestInfoRewardsFrame.ItemChooseText:SetJustifyH("LEFT");
      MapQuestInfoRewardsFrame.ItemReceiveText:SetJustifyH("LEFT"); 
      QuestInfoRewardsFrame.PlayerTitleText:SetJustifyH("LEFT");
      QuestInfoRewardsFrame.QuestSessionBonusReward:SetJustifyH("LEFT");
      if (QTR_QuestDetail_ItemReceiveText) then         -- własne obiekty
         QTR_QuestDetail_ItemReceiveText:Hide();
      end
      if (QTR_QuestReward_ItemReceiveText) then
         QTR_QuestReward_ItemReceiveText:Hide();
      end
   end
   
   -- Reset fonts and text for various quest elements
   QuestInfoRewardsFrame.ItemChooseText:SetFont(Original_Font2, 13);
   QuestInfoRewardsFrame.ItemReceiveText:SetFont(Original_Font2, 13);
   QuestInfoRewardsFrame.ItemChooseText:SetText(QTR_quest_EN[QTR_quest_ID].itemchoose);
   QuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_quest_EN[QTR_quest_ID].itemreceive);

   QuestInfoSpellObjectiveLearnLabel:SetFont(Original_Font2, 13);
   QuestInfoSpellObjectiveLearnLabel:SetText(QTR_MessOrig.learnspell);
   
   QuestInfoXPFrame.ReceiveText:SetFont(Original_Font2, 13);
   QuestInfoXPFrame.ReceiveText:SetText(QTR_MessOrig.experience);
   
   QuestInfoRewardsFrame.XPFrame.ReceiveText:SetFont(Original_Font2, 13);
   QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(QTR_MessOrig.experience);
   
   MapQuestInfoRewardsFrame.ItemChooseText:SetFont(Original_Font2, 11);
   MapQuestInfoRewardsFrame.ItemReceiveText:SetFont(Original_Font2, 11);
   MapQuestInfoRewardsFrame.ItemChooseText:SetText(QTR_quest_EN[QTR_quest_ID].itemchoose);
   MapQuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_quest_EN[QTR_quest_ID].itemreceive);
   
   QuestInfoRewardsFrame.PlayerTitleText:SetFont(Original_Font2, 13);
   QuestInfoRewardsFrame.PlayerTitleText:SetText(QTR_MessOrig.reward_title);
   
   QuestInfoRewardsFrame.QuestSessionBonusReward:SetFont(Original_Font2, 13);
   QuestInfoRewardsFrame.QuestSessionBonusReward:SetText(QTR_MessOrig.reward_bonus);

   if (QTR_QuestDetail_ItemReceiveText) then
      QTR_QuestDetail_ItemReceiveText:Hide();
   end
   if (QTR_QuestDetail_InfoXP) then
      QTR_QuestDetail_InfoXP:Hide();
   end

   if ( QuestInfoRewardsFrame:IsVisible() ) then
      for fontString in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
         if (fontString:GetText() == QTR_Messages.reward_aura) then
            fontString:SetText(REWARD_AURA);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 13);
         end
         if (fontString:GetText() == QTR_Messages.reward_spell) then
            fontString:SetText(REWARD_SPELL);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 13);
         end
         if (fontString:GetText() == QTR_Messages.reward_companion) then
            fontString:SetText(REWARD_COMPANION);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 13);
         end
         if (fontString:GetText() == QTR_Messages.reward_follower) then
            fontString:SetText(REWARD_FOLLOWER);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 13);
         end
         if (fontString:GetText() == QTR_Messages.reward_reputation) then
            fontString:SetText(REWARD_REPUTATION);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 13);
         end
         if (fontString:GetText() == QTR_Messages.reward_title) then
            fontString:SetText(REWARD_TITLE);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 13);
         end
         if (fontString:GetText() == QTR_Messages.reward_tradeskill) then
            fontString:SetText(REWARD_TRADESKILL);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 13);
         end
         if (fontString:GetText() == QTR_Messages.reward_unlock) then
            fontString:SetText(REWARD_UNLOCK);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 13);
         end
         if (fontString:GetText() == QTR_Messages.reward_bonus) then
            fontString:SetText(REWARD_BONUS);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 13);
         end
      end
   end
   if ( MapQuestInfoRewardsFrame:IsVisible() ) then
      for fontString in MapQuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
         if (fontString:GetText() == QTR_Messages.reward_aura) then
            fontString:SetText(REWARD_AURA);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 11);
         end
         if (fontString:GetText() == QTR_Messages.reward_spell) then
            fontString:SetText(REWARD_SPELL);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 11);
         end
         if (fontString:GetText() == QTR_Messages.reward_companion) then
            fontString:SetText(REWARD_COMPANION);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 11);
         end
         if (fontString:GetText() == QTR_Messages.reward_follower) then
            fontString:SetText(REWARD_FOLLOWER);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 11);
         end
         if (fontString:GetText() == QTR_Messages.reward_reputation) then
            fontString:SetText(REWARD_REPUTATION);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 11);
         end
         if (fontString:GetText() == QTR_Messages.reward_title) then
            fontString:SetText(REWARD_TITLE);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 11);
         end
         if (fontString:GetText() == QTR_Messages.reward_tradeskill) then
            fontString:SetText(REWARD_TRADESKILL);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 11);
         end
         if (fontString:GetText() == QTR_Messages.reward_unlock) then
            fontString:SetText(REWARD_UNLOCK);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 11);
         end
         if (fontString:GetText() == QTR_Messages.reward_bonus) then
            fontString:SetText(REWARD_BONUS);
            fontString:SetJustifyH("LEFT"); -- wyrównanie od lewego
            fontString:SetFont(Original_Font2, 11);
         end
      end
   end
end
-------------------------------------------------------------------------------------------------------------------
function QTR_delayed3()
   QTR_ToggleButton4:SetText(QTR_ReverseIfAR(WoWTR_Localization.choiceQuestFirst));
   QTR_ToggleButton4:Hide();
   if (not WOWTR_wait(1,QTR_delayed4)) then
   ---
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_delayed4()
   if (ImmersionFrame.TitleButtons:IsVisible()) then
      if (ImmersionFrame.TitleButtons.Buttons[1] ~= nil ) then
         ImmersionFrame.TitleButtons.Buttons[1]:HookScript("OnClick", function() QTR_PrepareDelay(1) end);
      end
      if (ImmersionFrame.TitleButtons.Buttons[2] ~= nil ) then
         ImmersionFrame.TitleButtons.Buttons[2]:HookScript("OnClick", function() QTR_PrepareDelay(1) end);
      end
      if (ImmersionFrame.TitleButtons.Buttons[3] ~= nil ) then
         ImmersionFrame.TitleButtons.Buttons[3]:HookScript("OnClick", function() QTR_PrepareDelay(1) end);
      end   
      if (ImmersionFrame.TitleButtons.Buttons[4] ~= nil ) then
         ImmersionFrame.TitleButtons.Buttons[4]:HookScript("OnClick", function() QTR_PrepareDelay(1) end);
      end
      if (ImmersionFrame.TitleButtons.Buttons[5] ~= nil ) then
         ImmersionFrame.TitleButtons.Buttons[5]:HookScript("OnClick", function() QTR_PrepareDelay(1) end);
      end
   end
   QTR_QuestPrepare('');
end;      

-------------------------------------------------------------------------------------------------------------------

function QTR_PrepareDelay(czas)     -- wywoływane po kliknięciu na nazwę questu z listy NPC
   if (czas==1) then
      if (not WOWTR_wait(1,QTR_PrepareReload)) then
      ---
      end
   end
   if (czas==3) then
      if (not WOWTR_wait(3,QTR_PrepareReload)) then
      ---
      end
   end
   if (czas==9) then
      if (not WOWTR_wait(0.5,QTR_PrepareReload)) then
      ---
      end
   end
end;      

-------------------------------------------------------------------------------------------------------------------

function QTR_PrepareReload()
   QTR_QuestPrepare('');
end;      

-------------------------------------------------------------------------------------------------------------------

function QTR_Immersion()   -- wywoływanie tłumaczenia z opóźnieniem 0.2 sek
   ImmersionContentFrame.ObjectivesText:SetFont(WOWTR_Font2, 14);
   ImmersionContentFrame.ObjectivesText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].objectives,true,ImmersionContentFrame.ObjectivesText,WOWTR_Font2));
   ImmersionFrame.TalkBox.NameFrame.Name:SetFont(WOWTR_Font1, 20);
   ImmersionFrame.TalkBox.NameFrame.Name:SetText(QTR_ReverseIfAR(QTR_quest_LG[QTR_quest_ID].title));
   ImmersionFrame.TalkBox.TextFrame.Text:SetFont(WOWTR_Font2, 14);
   if (QTR_quest_EN[QTR_quest_ID].completion and (strlen(QTR_quest_LG[QTR_quest_ID].completion)>1)) then   -- mamy zdarzenie COMPLETION
      ImmersionFrame.TalkBox.TextFrame.Text:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].completion,false,ImmersionFrame.TalkBox.TextFrame.Text,WOWTR_Font2));
   elseif (QTR_quest_EN[QTR_quest_ID].progress and (strlen(QTR_quest_LG[QTR_quest_ID].progress)>1)) then   -- mamy zdarzenie PROGRESS
      ImmersionFrame.TalkBox.TextFrame.Text:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].progress,false,ImmersionFrame.TalkBox.TextFrame.Text,WOWTR_Font2));
   elseif (QTR_quest_EN[QTR_quest_ID].details and (strlen(QTR_quest_LG[QTR_quest_ID].details)>1)) then     -- mamy zdarzenie DETAILS
      ImmersionFrame.TalkBox.TextFrame.Text:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].details,false,ImmersionFrame.TalkBox.TextFrame.Text,WOWTR_Font2));
   end
   QTR_Immersion_Static();        -- inne statyczne dane
 end

-------------------------------------------------------------------------------------------------------------------

function QTR_Immersion_Static() 
   ImmersionContentFrame.ObjectivesHeader:SetFont(WOWTR_Font1, 18);
   ImmersionContentFrame.ObjectivesHeader:SetText(QTR_ReverseIfAR(QTR_Messages.objectives));                              -- "Zadanie"
   ImmersionContentFrame.RewardsFrame.Header:SetFont(WOWTR_Font1, 18);
   ImmersionContentFrame.RewardsFrame.Header:SetText(QTR_ReverseIfAR(QTR_Messages.rewards));                              -- "Nagrody"
   ImmersionContentFrame.RewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 13);
   ImmersionContentFrame.RewardsFrame.ItemChooseText:SetText(QTR_ReverseIfAR(QTR_quest_LG[QTR_quest_ID].itemchoose));     -- "Możesz wybrać nagrodę:"
   ImmersionContentFrame.RewardsFrame.ItemReceiveText:SetFont(WOWTR_Font2, 13);
   ImmersionContentFrame.RewardsFrame.ItemReceiveText:SetText(QTR_ReverseIfAR(QTR_quest_LG[QTR_quest_ID].itemreceive));   -- "Otrzymasz w nagrodę:"
   ImmersionContentFrame.RewardsFrame.XPFrame.ReceiveText:SetFont(WOWTR_Font2, 13);
   ImmersionContentFrame.RewardsFrame.XPFrame.ReceiveText:SetText(QTR_ReverseIfAR(QTR_Messages.experience));              -- "Doświadczenie"
   ImmersionFrame.TalkBox.Elements.Progress.ReqText:SetFont(WOWTR_Font1, 18);
   ImmersionFrame.TalkBox.Elements.Progress.ReqText:SetText(QTR_ReverseIfAR(QTR_Messages.reqitems));                      -- "Wymagane itemy:"
   for fontString in ImmersionContentFrame.RewardsFrame.spellHeaderPool:EnumerateActive() do
      if (fontString:GetText() == REWARD_AURA) then
         fontString:SetText(QTR_ReverseIfAR(QTR_Messages.reward_aura));
         fontString:SetFont(WOWTR_Font2, 13);
      end
      if (fontString:GetText() == REWARD_SPELL) then
         fontString:SetText(QTR_ReverseIfAR(QTR_Messages.reward_spell));
         fontString:SetFont(WOWTR_Font2, 13);
      end
      if (fontString:GetText() == REWARD_COMPANION) then
         fontString:SetText(QTR_ReverseIfAR(QTR_Messages.reward_companion));
         fontString:SetFont(WOWTR_Font2, 13);
      end
      if (fontString:GetText() == REWARD_FOLLOWER) then
         fontString:SetText(QTR_ReverseIfAR(QTR_Messages.reward_follower));
         fontString:SetFont(WOWTR_Font2, 13);
      end
      if (fontString:GetText() == REWARD_REPUTATION) then
         fontString:SetText(QTR_ReverseIfAR(QTR_Messages.reward_reputation));
         fontString:SetFont(WOWTR_Font2, 13);
      end
      if (fontString:GetText() == REWARD_TITLE) then
         fontString:SetText(QTR_ReverseIfAR(QTR_Messages.reward_title));
         fontString:SetFont(WOWTR_Font2, 13);
      end
      if (fontString:GetText() == REWARD_TRADESKILL) then
         fontString:SetText(QTR_ReverseIfAR(QTR_Messages.reward_tradeskill));
         fontString:SetFont(WOWTR_Font2, 13);
      end
      if (fontString:GetText() == REWARD_UNLOCK) then
         fontString:SetText(QTR_ReverseIfAR(QTR_Messages.reward_unlock));
         fontString:SetFont(WOWTR_Font2, 13);
      end
      if (fontString:GetText() == REWARD_BONUS) then
         fontString:SetText(QTR_ReverseIfAR(QTR_Messages.reward_bonus));
         fontString:SetFont(WOWTR_Font2, 13);
      end
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Immersion_OFF()   -- wywoływanie oryginału
   ImmersionContentFrame.ObjectivesText:SetFont(Original_Font2, 14);
   ImmersionContentFrame.ObjectivesText:SetText(QTR_quest_EN[QTR_quest_ID].objectives);
   ImmersionFrame.TalkBox.NameFrame.Name:SetFont(Original_Font1, 20);
   ImmersionFrame.TalkBox.NameFrame.Name:SetText(QTR_quest_EN[QTR_quest_ID].title);
   ImmersionFrame.TalkBox.TextFrame.Text:SetFont(Original_Font2, 14);
   if (QTR_quest_EN[QTR_quest_ID].completion and (strlen(QTR_quest_EN[QTR_quest_ID].completion)>0)) then   -- przywróć oryginalny tekst
      ImmersionFrame.TalkBox.TextFrame.Text:SetText(QTR_quest_EN[QTR_quest_ID].completion);
   elseif (QTR_quest_EN[QTR_quest_ID].progress and (strlen(QTR_quest_EN[QTR_quest_ID].progress)>0)) then
      ImmersionFrame.TalkBox.TextFrame.Text:SetText(QTR_quest_EN[QTR_quest_ID].progress);
   else
      ImmersionFrame.TalkBox.TextFrame.Text:SetText(QTR_quest_EN[QTR_quest_ID].details);
   end
   QTR_Immersion_OFF_Static();       -- inne statyczne dane
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Immersion_OFF_Static()
   ImmersionContentFrame.ObjectivesHeader:SetFont(Original_Font1, 18);
   ImmersionContentFrame.ObjectivesHeader:SetText(QTR_MessOrig.objectives);                               -- "Zadanie"
   ImmersionContentFrame.RewardsFrame.Header:SetFont(Original_Font1, 18);
   ImmersionContentFrame.RewardsFrame.Header:SetText(QTR_MessOrig.rewards);                               -- "Nagroda"
   ImmersionContentFrame.RewardsFrame.ItemChooseText:SetFont(Original_Font2, 13);
   ImmersionContentFrame.RewardsFrame.ItemChooseText:SetText(QTR_quest_EN[QTR_quest_ID].itemchoose);      -- "Możesz wybrać nagrodę:"
   ImmersionContentFrame.RewardsFrame.ItemReceiveText:SetFont(Original_Font2, 13);
   ImmersionContentFrame.RewardsFrame.ItemReceiveText:SetText(QTR_quest_EN[QTR_quest_ID].itemreceive);    -- "Otrzymasz w nagrodę:"
   ImmersionContentFrame.RewardsFrame.XPFrame.ReceiveText:SetFont(Original_Font2, 13);
   ImmersionContentFrame.RewardsFrame.XPFrame.ReceiveText:SetText(QTR_MessOrig.experience);               -- "Doświadczenie"
   ImmersionFrame.TalkBox.Elements.Progress.ReqText:SetFont(Original_Font1, 18);
   ImmersionFrame.TalkBox.Elements.Progress.ReqText:SetText(QTR_MessOrig.reqitems);                       -- "Wymagane itemy:"
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Delay()
   QTR_Storyline(1);
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Quest()
   if (QTR_PS["active"]=="1" and QTR_PS["storyline"]=="1" and Storyline_NPCFrame:IsVisible()) then
      QTR_QuestPrepare('');
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Hide()
   if (QTR_PS["active"]=="1" and QTR_PS["storyline"]=="1") then
      QTR_ToggleButton5:Hide();
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Objectives()
   if (QTR_PS["active"]=="1" and QTR_PS["storyline"]=="1" and QTR_quest_ID>0) then
      local string_ID= tostring(QTR_quest_ID);
      Storyline_NPCFrameObjectivesContent.Title:SetText(QTR_ReverseIfAR(WoWTR_Localization.objectives));
      Storyline_NPCFrameObjectivesContent.Title:SetFont(WOWTR_Font1, 13);
      if (QTR_QuestData[string_ID] ) then
         Storyline_NPCFrameObjectivesContent.Objectives:SetText(QTR_ExpandUnitInfo(QTR_QuestData[string_ID]["Objectives"],true,Storyline_NPCFrameObjectivesContent.Objectives,WOWTR_Font2,-40));
         Storyline_NPCFrameObjectivesContent.Objectives:SetFont(WOWTR_Font2, 13);
      end   
      if (Storyline_RewardsHeader0) then
         Storyline_RewardsHeader0:SetText(QTR_ReverseIfAR(QTR_quest_LG[QTR_quest_ID].itemreceive));
         Storyline_RewardsHeader0:SetFont(WOWTR_Font1, 13);
      end
      if (Storyline_RewardsHeader1) then
         if (Storyline_RewardsHeader1:GetText() == REWARD_AURA) then
            Storyline_RewardsHeader1:SetText(QTR_ReverseIfAR(QTR_Messages.reward_aura));
            Storyline_RewardsHeader1:SetFont(WOWTR_Font1, 13);
         elseif (Storyline_RewardsHeader1:GetText() == REWARD_SPELL) then
            Storyline_RewardsHeader1:SetText(QTR_ReverseIfAR(QTR_Messages.reward_spell));
            Storyline_RewardsHeader1:SetFont(WOWTR_Font1, 13);
         elseif (Storyline_RewardsHeader1:GetText() == REWARD_COMPANION) then
            Storyline_RewardsHeader1:SetText(QTR_ReverseIfAR(QTR_Messages.reward_companion));
            Storyline_RewardsHeader1:SetFont(WOWTR_Font1, 13);
         elseif (Storyline_RewardsHeader1:GetText() == REWARD_FOLLOWER) then
            Storyline_RewardsHeader1:SetText(QTR_ReverseIfAR(QTR_Messages.reward_follower));
            Storyline_RewardsHeader1:SetFont(WOWTR_Font1, 13);
         elseif (Storyline_RewardsHeader1:GetText() == REWARD_REPUTATION) then
            Storyline_RewardsHeader1:SetText(QTR_ReverseIfAR(QTR_Messages.reward_reputation));
            Storyline_RewardsHeader1:SetFont(WOWTR_Font1, 13);
         elseif (Storyline_RewardsHeader1:GetText() == REWARD_TITLE) then
            Storyline_RewardsHeader1:SetText(QTR_ReverseIfAR(QTR_Messages.reward_title));
            Storyline_RewardsHeader1:SetFont(WOWTR_Font1, 13);
         elseif (Storyline_RewardsHeader1:GetText() == REWARD_TRADESKILL) then
            Storyline_RewardsHeader1:SetText(QTR_ReverseIfAR(QTR_Messages.reward_tradeskill));
            Storyline_RewardsHeader1:SetFont(WOWTR_Font1, 13);
         elseif (Storyline_RewardsHeader1:GetText() == REWARD_UNLOCK) then
            Storyline_RewardsHeader1:SetText(QTR_ReverseIfAR(QTR_Messages.reward_unlock));
            Storyline_RewardsHeader1:SetFont(WOWTR_Font1, 13);
         elseif (Storyline_RewardsHeader1:GetText() == REWARD_BONUS) then
            Storyline_RewardsHeader1:SetText(QTR_ReverseIfAR(QTR_Messages.reward_bonus));
            Storyline_RewardsHeader1:SetFont(WOWTR_Font1, 13);
         end
      end
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Rewards()
   if (QTR_PS["active"]=="1" and QTR_PS["storyline"]=="1") then
      Storyline_NPCFrameRewards.Content.Title:SetText(QTR_ReverseIfAR(WoWTR_Localization.rewards));
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline(nr)
   if (QTR_PS["transtitle"]=="1") then
      Storyline_NPCFrame.Banner.Title:SetText(QTR_ReverseIfAR(QTR_quest_LG[QTR_quest_ID].title));
      Storyline_NPCFrame.Banner.Title:SetFont(WOWTR_Font1, 18);
   end
   local string_ID= tostring(QTR_quest_ID);
   local texts = { "" };
   if ((Storyline_NPCFrameChat.event ~= nil) and (QTR_QuestData[string_ID] ~= nil))then
      local event = Storyline_NPCFrameChat.event;
      if (event=="QUEST_DETAIL") then
     	   texts = { strsplit("\n", QTR_ExpandUnitInfo(QTR_QuestData[string_ID]["Description"],false,Storyline_NPCFrameChatText,WOWTR_Font2,-15)) };
      end   
      if (event=="QUEST_PROGRESS") then
     	   texts = { strsplit("\n", QTR_ExpandUnitInfo(QTR_QuestData[string_ID]["Progress"],false,Storyline_NPCFrameChatText,WOWTR_Font2)) };
      end   
      if (event=="QUEST_COMPLETE") then
     	   texts = { strsplit("\n", QTR_ExpandUnitInfo(QTR_QuestData[string_ID]["Completion"],false,Storyline_NPCFrameChatText,WOWTR_Font2)) };
      end   
   end
   local ileOry = #Storyline_NPCFrameChat.texts;
   local indeks = 0;
   for i=1,#texts do
      if texts[i]:len() > 0 then
         if (indeks<ileOry) then
            indeks=indeks+1;
            Storyline_NPCFrameChat.texts[indeks]=texts[i];
         end
      end
   end
   Storyline_NPCFrameChatText:SetFont(WOWTR_Font2, 16);
   if (nr==1) then      -- Reload text
      Storyline_NPCFrameObjectivesContent:Hide();
      Storyline_NPCFrame.chat.currentIndex = 0;
      Storyline_API.playNext(Storyline_NPCFrameModelsYou);   -- reload
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Gossip()
   Storyline_NPCFrameChatText:SetFont(WOWTR_Font2, 16);
   if (not txt0txt) then return; end
   local texts = { "" };
   texts = { strsplit("\n\n", txt0txt) };
   if (Storyline_NPCFrameChat.texts) then
      local ileOry = #Storyline_NPCFrameChat.texts;
      local indeks = 0;
      for i=1,#texts do
         if texts[i]:len() > 0 then
            if (indeks<ileOry) then
               indeks=indeks+1;
               Storyline_NPCFrameChat.texts[indeks]=texts[i];
            end
         end
      end
      Storyline_NPCFrameObjectivesContent:Hide();
      Storyline_NPCFrame.chat.currentIndex = 0;
      Storyline_API.playNext(Storyline_NPCFrameModelsYou);   -- reload
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_OFF(nr)
   if (QTR_PS["transtitle"]=="1") then
      Storyline_NPCFrame.Banner.Title:SetText(QTR_quest_EN[QTR_quest_ID].title);
      Storyline_NPCFrame.Banner.Title:SetFont(Original_Font2, 18);
   end
   local string_ID= tostring(QTR_quest_ID);
   local texts = { "" };
   if ((Storyline_NPCFrameChat.event ~= nil) and (QTR_QuestData[string_ID] ~= nil))then
      local event = Storyline_NPCFrameChat.event;
      if (event=="QUEST_DETAIL") then
     	   texts = { strsplit("\n", GetQuestText()) };
      end   
      if (event=="QUEST_PROGRESS") then
     	   texts = { strsplit("\n", GetProgressText()) };
      end   
      if (event=="QUEST_COMPLETE") then
     	   texts = { strsplit("\n", GetRewardText()) };
      end   
   end
   local ileOry = #Storyline_NPCFrameChat.texts;
   local indeks = 0;
   for i=1,#texts do
      if texts[i]:len() > 0 then
         if (indeks<ileOry) then
            indeks=indeks+1;
            Storyline_NPCFrameChat.texts[indeks]=texts[i];
         end
      end
   end
   Storyline_NPCFrameChatText:SetFont(Original_Font2, 16);
   if (nr==1) then      -- Reload text
      Storyline_NPCFrameObjectivesContent:Hide();
      Storyline_NPCFrame.chat.currentIndex = 0;
      Storyline_API.playNext(Storyline_NPCFrameModelsYou);   -- reload
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_DUIbuttons()
   local DUI_AcceptButton = DUIQuestFrame.AcceptButton.Content.Name;
   ST_CheckAndReplaceTranslationText(DUI_AcceptButton, true, "ui",false,true);

   local DUI_ExitButton = DUIQuestFrame.ExitButton.Content.Name;
   ST_CheckAndReplaceTranslationText(DUI_ExitButton, true, "ui",false,true);
end
   
-------------------------------------------------------------------------------------------------------------------

function DUI_ON_OFF()
   if (QTR_curr_dialog == "1") then      -- wyłącz tłumaczenie - pokaż oryginalny tekst
      QTR_curr_dialog = "0";
      QTR_ToggleButton7:SetText("Quest ID="..QTR_quest_ID.." (EN)");
      if (QTR_PS["transtitle"] == "1") then
         DUIQuestFrame.FrontFrame.Header.Title:SetFont(Original_Font1,18);
         if (WoWTR_Localization.lang == 'AR') then
            DUIQuestFrame.FrontFrame.Header.Title:SetText(QTR_quest_EN[QTR_quest_ID].title);
            DUIQuestFrame.FrontFrame.Header.Title:SetJustifyH("LEFT");
         else
            DUIQuestFrame.FrontFrame.Header.Title:SetText(QTR_ExpandUnitInfo(QTR_quest_EN[QTR_quest_ID].title,false,QuestProgressTitleText,WOWTR_Font1));
            DUIQuestFrame.FrontFrame.Header.Title:SetJustifyH("LEFT");
         end         
      end
   else                                  -- pokaż tłumaczenie
      QTR_curr_dialog="1";
      QTR_ToggleButton7:SetText("Quest ID="..QTR_quest_ID.." ("..QTR_lang..")");
      if (QTR_PS["transtitle"] == "1") then
         DUIQuestFrame.FrontFrame.Header.Title:SetFont(WOWTR_Font1,18);
         if (WoWTR_Localization.lang == 'AR') then
            DUIQuestFrame.FrontFrame.Header.Title:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title,false,QuestProgressTitleText,WOWTR_Font1));
            DUIQuestFrame.FrontFrame.Header.Title:SetJustifyH("RIGHT");
         else
            DUIQuestFrame.FrontFrame.Header.Title:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title,false,QuestProgressTitleText,WOWTR_Font1));
            DUIQuestFrame.FrontFrame.Header.Title:SetJustifyH("LEFT");
         end
      end
   end
   
   local countFontString = 0;
   local function ProcessOnOff(fontString)
      countFontString = countFontString + 1;
      if (QTR_curr_dialog == "1") then   -- pokaż tłumaczenia
         fontString:SetText(dialogueUI_LN[countFontString]);
         if (WoWTR_Localization.lang == 'AR') then
            fontString:SetJustifyH("RIGHT");
         else
            fontString:SetJustifyH("LEFT");
         end
      else                               -- pokaż tekst oryginalny
         fontString:SetText(dialogueUI_EN[countFontString]);
         fontString:SetJustifyH("LEFT");
      end
   end
   DUIQuestFrame.fontStringPool:ProcessActiveObjects(ProcessOnOff);
end

-------------------------------------------------------------------------------------------------------------------

function QTR_DUIQuestFrame(event)
--print("obsługa okna DUIQuestFrame");
   QTR_ToggleButton7:Show();
   QTR_ToggleButton6:Hide();
   
   if (QTR_PS["transtitle"]=="1") then
      DUIQuestFrame.FrontFrame.Header.Title:SetFont(WOWTR_Font1,18);
      if (WoWTR_Localization.lang == 'AR') then
         DUIQuestFrame.FrontFrame.Header.Title:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title,false,QuestProgressTitleText,WOWTR_Font1));
         DUIQuestFrame.FrontFrame.Header.Title:SetJustifyH("RIGHT");
      else
         DUIQuestFrame.FrontFrame.Header.Title:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title,false,QuestProgressTitleText,WOWTR_Font1));
         DUIQuestFrame.FrontFrame.Header.Title:SetJustifyH("LEFT");
      end
   end

   local function SplitParagraph(text)
      local tbl = {};
      if (text) then
         for v in gmatch(text, "[%C]+") do
            tinsert(tbl, v);
         end
      end
      return tbl;
   end

   local countFontString = 0;
   local offset = 0;
   local objectivesNow = false;
   local rewardsNow = false;
   local det = string.gsub(QTR_quest_LG[QTR_quest_ID].details or '', 'NEW_LINE', '\n');
   det = string.gsub(det, '$b', '$B');
   det = string.gsub(det, '$B', '\n');
   det = string.gsub(det, '{B}', '\n');
   local pro = string.gsub(QTR_quest_LG[QTR_quest_ID].progress or '', 'NEW_LINE', '\n');
   pro = string.gsub(pro, '$b', '$B');
   pro = string.gsub(pro, '$B', '\n');
   pro = string.gsub(pro, '{B}', '\n');
   local com = string.gsub(QTR_quest_LG[QTR_quest_ID].completion or '', 'NEW_LINE', '\n');
   com = string.gsub(com, '$b', '$B');
   com = string.gsub(com, '$B', '\n');
   com = string.gsub(com, '{B}', '\n');
   local details = SplitParagraph(det);
   local progress = SplitParagraph(pro);
   local completion = SplitParagraph(com);
   dialogueUI_LN = { };
   dialogueUI_EN = { };

   local function Process(fontString)
--      print(event, fontString:GetText());
      countFontString = countFontString + 1;
      fontString:SetSpacing(4.2);      -- normalny odstęp między wierszami
      table.insert(dialogueUI_EN, fontString:GetText());    -- english version
      local _font1, _size1, _1 = fontString:GetFont();      -- odczytaj aktualną czcionkę i rozmiar
      fontString:SetFont(WOWTR_Font2,_size1);
      if (fontString:GetText() == "Objectives") then        -- nagłówek "Cele zadania:"
         fontString:SetWidth(DUIQuestFrame.ContentFrame:GetWidth());
         fontString:SetText(QTR_ExpandUnitInfo(QTR_Messages.objectives,false,fontString,WOWTR_Font2,-15));
         objectivesNow = true;
      elseif ((fontString:GetText() == "Rewards") or (fontString:GetText() == "Reward")) then       -- nagłówek "Nagrody:"
         fontString:SetWidth(DUIQuestFrame.ContentFrame:GetWidth());
         fontString:SetText(QTR_ExpandUnitInfo(QTR_Messages.rewards,false,fontString,WOWTR_Font2,-15));
         rewardsNow = true;
      elseif (fontString:GetText() == "Requirements") then       -- nagłówek "Wymagane przedmioty:"
         fontString:SetWidth(DUIQuestFrame.ContentFrame:GetWidth());
         fontString:SetText(QTR_ExpandUnitInfo(QTR_Messages.reqitems,false,fontString,WOWTR_Font2,-15));
      else
         local firstHeight = fontString:GetHeight();
         detailsX = details[countFontString];
         progressX = progress[countFontString];
         completionX = completion[countFontString];
         if (event=="QUEST_DETAIL" and detailsX) then
            if (WoWTR_Localization.lang == 'AR') then
               fontString:SetText(QTR_ExpandUnitInfo(detailsX,false,fontString,WOWTR_Font2,-15));
               fontString:SetJustifyH("RIGHT");
            else
               fontString:SetText(QTR_ExpandUnitInfo(detailsX,false,fontString,WOWTR_Font2));
               fontString:SetJustifyH("LEFT");
            end
         elseif (event=="QUEST_PROGRESS" and progressX) then
            if (WoWTR_Localization.lang == 'AR') then
               fontString:SetText(QTR_ExpandUnitInfo(progressX,false,fontString,WOWTR_Font2,-15));
               fontString:SetJustifyH("RIGHT");
            else
               fontString:SetText(QTR_ExpandUnitInfo(progressX,false,fontString,WOWTR_Font2));
               fontString:SetJustifyH("LEFT");
            end
         elseif (event=="QUEST_COMPLETE" and completionX) then
            if (WoWTR_Localization.lang == 'AR') then
               fontString:SetText(QTR_ExpandUnitInfo(completionX,false,fontString,WOWTR_Font2,-15));
               fontString:SetJustifyH("RIGHT");
            else
               fontString:SetText(QTR_ExpandUnitInfo(completionX,false,fontString,WOWTR_Font2));
               fontString:SetJustifyH("LEFT");
            end
         elseif (objectivesNow) then
            if (WoWTR_Localization.lang == 'AR') then
               fontString:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].objectives,false,fontString,WOWTR_Font2,-15));
               fontString:SetJustifyH("RIGHT");
               objectivesNow = false;        -- objectives is in one long rows?
            else
               fontString:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].objectives,false,fontString,WOWTR_Font2));
               fontString:SetJustifyH("LEFT");
               objectivesNow = false;        -- objectives is in one long rows?
            end

         elseif (rewardsNow) then
            if (WoWTR_Localization.lang == 'AR') then
               fontString:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].itemreceive,false,fontString,WOWTR_Font2));
               fontString:SetJustifyH("RIGHT");
               rewardsNow = false;        -- rewards is in one long rows?
            else
               fontString:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].itemreceive,false,fontString,WOWTR_Font2));
               fontString:SetJustifyH("LEFT");
               rewardsNow = false;        -- rewards is in one long rows?
            end
         end
         local secondHeight = fontString:GetHeight();
         offset = secondHeight - firstHeight;
         local counter0 = 0;
         while ((offset > 0) and (counter0<6)) do
            counter0 = counter0 + 1;
            fontString:SetSpacing(fontString:GetSpacing()*firstHeight/secondHeight);  -- zmiana odstępu między wierszami
            secondHeight = fontString:GetHeight();
            offset = secondHeight - firstHeight;
         end
      end
      table.insert(dialogueUI_LN, fontString:GetText());    -- translated version
   end
   
   DUIQuestFrame.fontStringPool:ProcessActiveObjects(Process);
   QTR_curr_dialog = "1";           -- aktualnie wyświetlane jest tłumaczenie

   local function ProcessBG(element)
      element:SetWidth(DUIQuestFrame.ContentFrame:GetWidth());
   end
   DUIQuestFrame.textBackgroundPool:ProcessActiveObjects(ProcessBG);
   
   if (TT_PS["ui1"] == "1") then
      QTR_DUIbuttons();
   end
end

-------------------------------------------------------------------------------------------------------------------

function gossipDUI_ON_OFF()
   if (QTR_curr_goss == "1") then      -- wyłącz tłumaczenie - pokaż oryginalny tekst
      QTR_curr_goss = "0";
      QTR_ToggleButton6:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." (EN)");
   else                                -- pokaż tłumaczenie
      QTR_curr_goss = "1";
      QTR_ToggleButton6:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." ("..WoWTR_Localization.lang..")");
   end
   
   local countFontString = 0;
   local function ProcessOnOff(fontString)
      countFontString = countFontString + 1;
      if (QTR_curr_goss == "1") then   -- pokaż tłumaczenia
         if (WoWTR_Localization.lang == 'AR') then
            fontString:SetText(gossipDUI_LN[countFontString]);
            fontString:SetJustifyH("RIGHT");
         else
            fontString:SetText(gossipDUI_LN[countFontString]);
            fontString:SetJustifyH("LEFT");
         end
      else                             -- pokaż tekst oryginalny
         fontString:SetText(gossipDUI_EN[countFontString]);
         fontString:SetJustifyH("LEFT");
      end
   end
   local count2FontString = 0;
   local function Process2OnOff(buttonString)
      count2FontString = count2FontString + 1;
      local fontString = buttonString.Content.Name;
      if (QTR_curr_goss == "1") then   -- pokaż tłumaczenia
         if (WoWTR_Localization.lang == 'AR') then
            fontString:SetText(gossip2DUI_LN[count2FontString]);
            fontString:SetJustifyH("LEFT");
         else
            fontString:SetText(gossip2DUI_LN[count2FontString]);
            fontString:SetJustifyH("LEFT");
         end
      else                             -- pokaż tekst oryginalny
         fontString:SetText(gossip2DUI_EN[count2FontString]);
         fontString:SetJustifyH("LEFT");
      end
   end
   DUIQuestFrame.fontStringPool:ProcessActiveObjects(ProcessOnOff);
   DUIQuestFrame.optionButtonPool:ProcessActiveObjects(Process2OnOff);
end

-------------------------------------------------------------------------------------------------------------------

function QTR_DUIGossipFrame()
--print("obsługa okna DUIGossipFrame");
   QTR_ToggleButton6:Show();
   QTR_ToggleButton7:Hide();
   
   local function SplitParagraph(text)
      local tbl = {};
      if (text) then
         for v in gmatch(text, "[%C]+") do
            tinsert(tbl, v);
         end
      end
      return tbl;
   end

   local countFontString = 0;
   local offset = 0;
   local objectivesNow = false;
   local gos = string.gsub(GS_Gossip[QTR_curr_hash] or '', 'NEW_LINE', '\n');
   gos = string.gsub(gos, '$b', '$B');
   gos = string.gsub(gos, '$B', '\n');
   gos = string.gsub(gos, '{B}', '\n');
   local gossip = SplitParagraph(gos);
   gossipDUI_LN = { };
   gossipDUI_EN = { };
   gossip2DUI_LN = { };
   gossip2DUI_EN = { };

   local function ProcessGS(fontString)
      if (string.find(fontString:GetText()," ") == nil) then   -- nie jest to przetłumaczony tekst (twarda spacja)
         countFontString = countFontString + 1;
         table.insert(gossipDUI_EN, fontString:GetText());    -- english version
         local _font1, _size1, _1 = fontString:GetFont();     -- odczytaj aktualną czcionkę i rozmiar
         fontString:SetFont(WOWTR_Font2,_size1);
         local firstHeight = fontString:GetHeight();
         gossipX = gossip[countFontString] or '';
         if (WoWTR_Localization.lang == 'AR') then
            fontString:SetText(QTR_ExpandUnitInfo(gossipX.." ",false,fontString,WOWTR_Font2));
         else
            fontString:SetText(QTR_ExpandUnitInfo(gossipX.." ",false,fontString,WOWTR_Font2));
         end
         local secondHeight = fontString:GetHeight();
         offset = secondHeight - firstHeight;
         local counter0 = 0;
         while ((offset > 0) and (counter0<6)) do
            counter0 = counter0 + 1;
            fontString:SetSpacing(fontString:GetSpacing()*firstHeight/secondHeight);  -- zmiana odstępu między wierszami
            secondHeight = fontString:GetHeight();
            offset = secondHeight - firstHeight;
         end
         table.insert(gossipDUI_LN, fontString:GetText());    -- translated version
      end
   end
   
   local function ProcessOPT(buttonString)
      local fontString = buttonString.Content.Name;
      local GOptionText = WOWTR_DetectAndReplacePlayerName(fontString:GetText());
      local prefix = "";
      local sufix = "";
      table.insert(gossip2DUI_EN, fontString:GetText());   -- english version
      local _font1, _size1, _1 = fontString:GetFont();     -- odczytaj aktualną czcionkę i rozmiar
      fontString:SetFont(WOWTR_Font2,_size1);
--      buttonString:HookScript("OnClick", QTR_DUIGossipFrame);
      if (string.sub(GOptionText,2,2)==".") then           -- usuń liczby przed tekstem opcji
         GOptionText = string.sub(GOptionText,4);
      end
      if (string.sub(GOptionText,1,2) == "|c") then
         prefix = string.sub(GOptionText, 1, 10);
         sufix = "|r";
         GOptionText = string.gsub(GOptionText, prefix, "");
         GOptionText = string.gsub(GOptionText, sufix, "");
      end
      local OptHash = StringHash(GOptionText);
      if (GS_Gossip[OptHash]) then               -- jest tłumaczenie
         local transLN = prefix .. QTR_ExpandUnitInfo(GS_Gossip[OptHash],false,fontString,WOWTR_Font2,-40) .. sufix .. " ";   -- twarda spacja na końcu
         fontString:SetText(transLN);
         fontString:SetJustifyH("LEFT");
      end
      table.insert(gossip2DUI_LN, fontString:GetText());    -- translated version
   end

   QTR_curr_goss = "1";           -- aktualnie wyświetlane jest tłumaczenie
   
   DUIQuestFrame.fontStringPool:ProcessActiveObjects(ProcessGS);
   DUIQuestFrame.optionButtonPool:ProcessActiveObjects(ProcessOPT);
   
   if (TT_PS["ui1"] == "1") then
      QTR_DUIbuttons();
   end
end

-------------------------------------------------------------------------------------------------------------------
-- New function to handle special WoW codes
   function HandleWoWSpecialCodes(msg)
      local specialCodes = {}
      local index = 1
      local prefix = ""
   
      -- Handle UE_COLOR prefix
      msg = msg:gsub("^(UE_COLOR:)", function(ueColor)
         prefix = ueColor
         return ""
      end)
   
      -- Handle color codes separately
      msg = msg:gsub("(|c%x%x%x%x%x%x%x%x)(.-)(|r)", function(colorStart, text, colorEnd)
          specialCodes[index] = colorStart
          local startPlaceholder = "\001" .. index .. "\002"
          index = index + 1
          specialCodes[index] = colorEnd
          local endPlaceholder = "\001" .. index .. "\002"
          index = index + 1
          return startPlaceholder .. text .. endPlaceholder
      end)
   
      -- Find and store other special WoW codes
      msg = msg:gsub("(|T.-|t)", function(code)
          specialCodes[index] = code
          index = index + 1
          return "\001" .. (index-1) .. "\002"
      end)
   
      msg = msg:gsub("(|A.-|a)", function(code)
         specialCodes[index] = code
         index = index + 1
         return "\001" .. (index-1) .. "\002"
     end)
   
      msg = msg:gsub("(|H.-|h%[.-%]|h)", function(code)
          specialCodes[index] = code
          index = index + 1
          return "\001" .. (index-1) .. "\002"
      end)
   
      return msg, specialCodes, prefix
   end

-- Function to restore special codes
function RestoreWoWSpecialCodes(msg, specialCodes)
   return msg:gsub("\002(%d+)\001", function(i)
       return specialCodes[tonumber(i)]
   end)
end

function WOW_ZmienKody(message, target)
   msg = message;
   if (WoWTR_Localization.lang == 'AR') then
      msg = string.gsub(msg, "{N}", "YOUR_NAME");
      msg = string.gsub(msg, "{B}", "NEW_LINE");
      msg = string.gsub(msg, "{R}", "YOUR_RACE");
      msg = string.gsub(msg, "{C}", "YOUR_CLASS");
      
      --Tutorial Color Codes
      msg = string.gsub(msg, "{002DFFFFc}", "{cFFFFD200}");
      msg = string.gsub(msg, "{FFFF00FFc}", "{cFF00FFFF}");
      msg = string.gsub(msg, "{0000FFFFc}", "{cFFFF0000}");
      msg = string.gsub(msg, "{ffffffffc}", "{cffffffff}");
      msg = string.gsub(msg, "EU_ROLOC:", "UE_COLOR:");
      --msg = string.gsub(msg, "{002DFFFFc}", "{cFFFFD200}");

   else
      msg = string.gsub(msg, "$b", "$B");
      msg = string.gsub(msg, "$n", "$N");
      msg = string.gsub(msg, "$r", "$R");
      msg = string.gsub(msg, "$c", "$C");
      msg = string.gsub(msg, "$g", "$G");
      msg = string.gsub(msg, "$p", "$P");
      msg = string.gsub(msg, "$o", "$O");

      msg = string.gsub(msg, "$B", "NEW_LINE");
      msg = string.gsub(msg, "$N", "YOUR_NAME");
      msg = string.gsub(msg, "$R", "YOUR_RACE");
      msg = string.gsub(msg, "$C", "YOUR_CLASS");
      msg = string.gsub(msg, "$G", "YOUR_GENDER");
      msg = string.gsub(msg, "$P", "NPC_GENDER");
      msg = string.gsub(msg, "$O", "OWN_NAME");
   end
   
   msg = string.gsub(msg, "NEW_LINE", "\n");
   if (target) then
      msg = string.gsub(msg, "$target", WOWTR_AnsiReverse(target));
      msg = string.gsub(msg, "YOUR_NAME$", WOWTR_AnsiReverse(string.upper(target)));
      msg = string.gsub(msg, "YOUR_NAME", WOWTR_AnsiReverse(target));
   else
      msg = string.gsub(msg, "YOUR_NAME$", WOWTR_AnsiReverse(string.upper(WOWTR_player_name)));
      msg = string.gsub(msg, "YOUR_NAME", WOWTR_AnsiReverse(WOWTR_player_name));
   end

   if (WoWTR_Localization.lang == 'AR') then
      if (WOWTR_player_sex == 3) then   -- female, nominative case
         msg = string.gsub(msg, "YOUR_CLASS", player_class_table.F);
      else
         msg = string.gsub(msg, "YOUR_CLASS", player_class_table.M);
      end
      if (WOWTR_player_sex == 3) then   -- female, nominative case
         msg = string.gsub(msg, "YOUR_RACE", player_race_table.F);
      else
         msg = string.gsub(msg, "YOUR_RACE", player_race_table.M);
      end
   else
      if (WOWTR_player_sex == 3) then   -- female, nominative case
         msg = string.gsub(msg, "YOUR_RACE1", WOWTR_AnsiReverse(player_race_table.M2));
      else
         msg = string.gsub(msg, "YOUR_RACE1", WOWTR_AnsiReverse(player_race_table.M1));
      end
      if (WOWTR_player_sex == 3) then   -- female, genitive case
         msg = string.gsub(msg, "YOUR_RACE2", WOWTR_AnsiReverse(player_race_table.D2));
      else
         msg = string.gsub(msg, "YOUR_RACE2", WOWTR_AnsiReverse(player_race_table.D1));
      end
      if (WOWTR_player_sex == 3) then   -- female, dative case
         msg = string.gsub(msg, "YOUR_RACE3", WOWTR_AnsiReverse(player_race_table.C2));
      else
         msg = string.gsub(msg, "YOUR_RACE3", WOWTR_AnsiReverse(player_race_table.C1));
      end
      if (WOWTR_player_sex == 3) then   -- female, accusative case
         msg = string.gsub(msg, "YOUR_RACE4", WOWTR_AnsiReverse(player_race_table.B2));
      else
         msg = string.gsub(msg, "YOUR_RACE4", WOWTR_AnsiReverse(player_race_table.B1));
      end
      if (WOWTR_player_sex == 3) then   -- female, ablative case
         msg = string.gsub(msg, "YOUR_RACE5", WOWTR_AnsiReverse(player_race_table.N2));
      else
         msg = string.gsub(msg, "YOUR_RACE5", WOWTR_AnsiReverse(player_race_table.N1));
      end
      if (WOWTR_player_sex == 3) then   -- female, localive case
         msg = string.gsub(msg, "YOUR_RACE6", WOWTR_AnsiReverse(player_race_table.K2));
      else
         msg = string.gsub(msg, "YOUR_RACE6", WOWTR_AnsiReverse(player_race_table.K1));
      end
      if (WOWTR_player_sex == 3) then   -- female, vocative case
         msg = string.gsub(msg, "YOUR_RACE7", WOWTR_AnsiReverse(player_race_table.W2));
      else
         msg = string.gsub(msg, "YOUR_RACE7", WOWTR_AnsiReverse(player_race_table.W1));
      end
      
      if (WOWTR_player_sex == 3) then   -- female, nominative case
         msg = string.gsub(msg, "YOUR_CLASS1", WOWTR_AnsiReverse(player_class_table.M2));
      else
         msg = string.gsub(msg, "YOUR_CLASS1", WOWTR_AnsiReverse(player_class_table.M1));
      end
      if (WOWTR_player_sex == 3) then   -- female, genitive case
         msg = string.gsub(msg, "YOUR_CLASS2", WOWTR_AnsiReverse(player_class_table.D2));
      else
         msg = string.gsub(msg, "YOUR_CLASS2", WOWTR_AnsiReverse(player_class_table.D1));
      end
      if (WOWTR_player_sex == 3) then   -- female, dative case
         msg = string.gsub(msg, "YOUR_CLASS3", WOWTR_AnsiReverse(player_class_table.C2));
      else
         msg = string.gsub(msg, "YOUR_CLASS3", WOWTR_AnsiReverse(player_class_table.C1));
      end
      if (WOWTR_player_sex == 3) then   -- female, accusative case
         msg = string.gsub(msg, "YOUR_CLASS4", WOWTR_AnsiReverse(player_class_table.B2));
      else
         msg = string.gsub(msg, "YOUR_CLASS4", WOWTR_AnsiReverse(player_class_table.B1));
      end
      if (WOWTR_player_sex == 3) then   -- female, ablative case
         msg = string.gsub(msg, "YOUR_CLASS5", WOWTR_AnsiReverse(player_class_table.N2));
      else
         msg = string.gsub(msg, "YOUR_CLASS5", WOWTR_AnsiReverse(player_class_table.N1));
      end
      if (WOWTR_player_sex == 3) then   -- female, localive case
         msg = string.gsub(msg, "YOUR_CLASS6", WOWTR_AnsiReverse(player_class_table.K2));
      else
         msg = string.gsub(msg, "YOUR_CLASS6", WOWTR_AnsiReverse(player_class_table.K1));
      end
      if (WOWTR_player_sex == 3) then   -- female, vocative case
         msg = string.gsub(msg, "YOUR_CLASS7", WOWTR_AnsiReverse(player_class_table.W2));
      else
         msg = string.gsub(msg, "YOUR_CLASS7", WOWTR_AnsiReverse(player_class_table.W1));
      end
   
      msg = string.gsub(msg, "YOUR_CLASS$", WOWTR_AnsiReverse(string.upper(WOWTR_player_class)));
      msg = string.gsub(msg, "YOUR_CLASS", WOWTR_AnsiReverse(WOWTR_player_class));
      msg = string.gsub(msg, "YOUR_RACE$", WOWTR_AnsiReverse(string.upper(WOWTR_player_race)));
      msg = string.gsub(msg, "YOUR_RACE", WOWTR_AnsiReverse(WOWTR_player_race));
   end


   if (WoWTR_Localization.lang == 'AR') then
      -- obsługa kodu {Gx;y}
      local nr_1, nr_2, nr_3 = 0;
      local QTR_forma = "";
      local nr_poz, nr_poz2 = string.find(msg, "{G");    -- gdy nie znalazł, jest: nil
      while (nr_poz and nr_poz2>0) do
         nr_1 = nr_poz2 + 1;
         if (string.sub(msg, nr_1, nr_1) == " ") then    -- dopuszczam jedną spację po słowie kodowym
            nr_1 = nr_1 + 1;
         end
         nr_2 =  nr_1 + 1;
         while ((string.sub(msg, nr_2, nr_2) ~= ";") and (nr_2 - nr_1 < 100)) do     -- szukaj średnika
            nr_2 = nr_2 + 1;
         end
         if (string.sub(msg, nr_2, nr_2) == ";") then
            nr_3 = nr_2 + 1;
            while ((string.sub(msg, nr_3, nr_3) ~= "}") and (nr_3 - nr_2 < 100)) do  -- szukaj końca kodu
               nr_3 = nr_3 + 1;
            end
            if (string.sub(msg, nr_3, nr_3) == "}") then
               if (WOWTR_player_sex==3) then   -- forma żeńska
                  QTR_forma = string.sub(msg,nr_2+1,nr_3-1);
               else                            -- forma męska
                  QTR_forma = string.sub(msg,nr_1,nr_2-1);
               end
               if (nr_poz>1) then
                  msg = string.sub(msg,1,nr_poz-1) .. QTR_forma .. string.sub(msg,nr_3+1);
               else
                  msg = QTR_forma .. string.sub(msg,nr_3+1);
               end
            else
               msg = string.gsub(msg, "{G", "{X");    -- error in code {Gx;y}
            end
         else
            msg = string.gsub(msg, "{G", "{X");    -- error in code {Gx;y}
         end
         nr_poz, nr_poz2 = string.find(msg, "{G");
      end

      -- obsługa kodu {Px;y}
      local nr_1, nr_2, nr_3 = 0;
      local QTR_forma = "";
      local nr_poz, nr_poz2 = string.find(msg, "{P");    -- gdy nie znalazł, jest: nil
      while (nr_poz and nr_poz2>0) do
         nr_1 = nr_poz2 + 1;   
         if (string.sub(msg, nr_1, nr_1) == " ") then    -- dopuszczam jedną spację po słowie kodowym
            nr_1 = nr_1 + 1;
         end
         nr_2 =  nr_1 + 1;
         while ((string.sub(msg, nr_2, nr_2) ~= ";") and (nr_2 - nr_1 < 100)) do
            nr_2 = nr_2 + 1;
         end
         if (string.sub(msg, nr_2, nr_2) == ";") then
            nr_3 = nr_2 + 1;
            while ((string.sub(msg, nr_3, nr_3) ~= "}") and (nr_3 - nr_2 < 100)) do
               nr_3 = nr_3 + 1;
            end
            if (string.sub(msg, nr_3, nr_3) == "}") then
               if (WOWTR_player_sex==3) then   -- forma żeńska
                  QTR_forma = string.sub(msg,nr_2+1,nr_3-1);
               else                            -- forma męska
                  QTR_forma = string.sub(msg,nr_1,nr_2-1);
               end
               if (nr_poz>1) then
                  msg = string.sub(msg,1,nr_poz-1) .. QTR_forma .. string.sub(msg,nr_3+1);
               else
                  msg = QTR_forma .. string.sub(msg,nr_3+1);
               end
            else
               msg = string.gsub(msg, "{P", "{X");    -- error in code {Px;y}
            end
         else
            msg = string.gsub(msg, "{P", "{X");    -- error in code {Px;y}
         end
         nr_poz, nr_poz2 = string.find(msg, "{P");
      end
   
      -- obsługa kodu {Ox;y}
      local nr_1, nr_2, nr_3 = 0;
      local QTR_forma = "";
      local nr_poz, nr_poz2 = string.find(msg, "{O");    -- gdy nie znalazł, jest: nil
      while (nr_poz and nr_poz2>0) do
         nr_1 = nr_poz2 + 1;   
         if (string.sub(msg, nr_1, nr_1) == " ") then    -- dopuszczam jedną spację po słowie kodowym
            nr_1 = nr_1 + 1;
         end
         nr_2 =  nr_1 + 1;
         while ((string.sub(msg, nr_2, nr_2) ~= ";") and (nr_2 - nr_1 < 100)) do
            nr_2 = nr_2 + 1;
         end
         if (string.sub(msg, nr_2, nr_2) == ";") then
            nr_3 = nr_2 + 1;
            while ((string.sub(msg, nr_3, nr_3) ~= "}") and (nr_3 - nr_2 < 100)) do
               nr_3 = nr_3 + 1;
            end
            if (string.sub(msg, nr_3, nr_3) == "}") then
               if (WOWTR_player_sex==3) then   -- forma arabska
                  QTR_forma = string.sub(msg,nr_2+1,nr_3-1);
               else                            -- forma angielska
                  QTR_forma = string.sub(msg,nr_1,nr_2-1);
               end
               if (nr_poz>1) then
                  msg = string.sub(msg,1,nr_poz-1) .. QTR_forma .. string.sub(msg,nr_3+1);
               else
                  msg = QTR_forma .. string.sub(msg,nr_3+1);
               end
            else
               msg = string.gsub(msg, "{O", "{X");    -- error in code {Ox;y}
            end
         else
            msg = string.gsub(msg, "{O", "{X");    -- error in code {Ox;y}
         end
         nr_poz, nr_poz2 = string.find(msg, "{O");
      end
   else        -- other languages, not AR
      -- obsługa kodu YOUR_GENDER(x;y)
      local nr_1, nr_2, nr_3 = 0;
      local QTR_forma = "";
      local nr_poz, nr_poz2 = string.find(msg, "YOUR_GENDER");    -- gdy nie znalazł, jest: nil
      while (nr_poz and nr_poz2>0) do
         nr_1 = nr_poz2 + 1;   
         while (string.sub(msg, nr_1, nr_1) ~= "(") do            -- dopuszczam jedną spację po słowie kodowym
            nr_1 = nr_1 + 1;
         end
         if (string.sub(msg, nr_1, nr_1) == "(") then
            nr_2 =  nr_1 + 1;
            while ((string.sub(msg, nr_2, nr_2) ~= ";") and (nr_2 - nr_1 < 100)) do
               nr_2 = nr_2 + 1;
            end
            if (string.sub(msg, nr_2, nr_2) == ";") then
               nr_3 = nr_2 + 1;
               while ((string.sub(msg, nr_3, nr_3) ~= ")") and (nr_3 - nr_2 < 100)) do
                  nr_3 = nr_3 + 1;
               end
               if (string.sub(msg, nr_3, nr_3) == ")") then
                  if (WOWTR_player_sex==3) then        -- forma żeńska
                     QTR_forma = string.sub(msg,nr_2+1,nr_3-1);
                  else                        -- forma męska
                     QTR_forma = string.sub(msg,nr_1+1,nr_2-1);
                  end
                  if (nr_poz>1) then
                     msg = string.sub(msg,1,nr_poz-1) .. QTR_forma .. string.sub(msg,nr_3+1);
                  else
                     msg = QTR_forma .. string.sub(msg,nr_3+1);
                  end
               end   
            end
         end
         nr_poz, nr_poz2 = string.find(msg, "YOUR_GENDER");
      end

      -- obsługa kodu NPC_GENDER(x;y)
      local nr_1, nr_2, nr_3 = 0;
      local QTR_forma = "";
      local NPC_sex = UnitSex("npc");       -- 1:neutral,  2:męski,  3:żeński
      local nr_poz, nr_poz2 = string.find(msg, "NPC_GENDER");     -- gdy nie znalazł, jest: nil
      while (nr_poz and nr_poz2>0) do
         nr_1 = nr_poz2 + 1;   
         while (string.sub(msg, nr_1, nr_1) ~= "(") do            -- dopuszczam jedną spację po słowie kodowym
            nr_1 = nr_1 + 1;
         end
         if (string.sub(msg, nr_1, nr_1) == "(") then
            nr_2 =  nr_1 + 1;
            while ((string.sub(msg, nr_2, nr_2) ~= ";") and (nr_2 - nr_1 < 100)) do
               nr_2 = nr_2 + 1;
            end
            if (string.sub(msg, nr_2, nr_2) == ";") then
               nr_3 = nr_2 + 1;
               while ((string.sub(msg, nr_3, nr_3) ~= ")") and (nr_3 - nr_2 < 100)) do
                  nr_3 = nr_3 + 1;
               end
               if (string.sub(msg, nr_3, nr_3) == ")") then
                  if (NPC_sex==3) then        -- forma żeńska
                     QTR_forma = string.sub(msg,nr_2+1,nr_3-1);
                  else                        -- forma męska
                     QTR_forma = string.sub(msg,nr_1+1,nr_2-1);
                  end
                  if (nr_poz>1) then
                     msg = string.sub(msg,1,nr_poz-1) .. QTR_forma .. string.sub(msg,nr_3+1);
                  else
                     msg = QTR_forma .. string.sub(msg,nr_3+1);
                  end
               end   
            end
         end
         nr_poz, nr_poz2 = string.find(msg, "NPC_GENDER");
      end
   
      -- obsługa kodu OWN_NAME(EN;PL)
      local nr_1, nr_2, nr_3 = 0;
      local QTR_forma = "";
      local nr_poz, nr_poz2 = string.find(msg, "OWN_NAME");    -- gdy nie znalazł, jest: nil
      while (nr_poz and nr_poz2>0) do
         nr_1 = nr_poz2 + 1;   
         while (string.sub(msg, nr_1, nr_1) ~= "(") do         -- dopuszczam jedną spację po słowie kodowym
            nr_1 = nr_1 + 1;
         end
         if (string.sub(msg, nr_1, nr_1) == "(") then
            nr_2 =  nr_1 + 1;
            while ((string.sub(msg, nr_2, nr_2) ~= ";") and (nr_2 - nr_1 < 100)) do
               nr_2 = nr_2 + 1;
            end
            if (string.sub(msg, nr_2, nr_2) == ";") then
               nr_3 = nr_2 + 1;
               while ((string.sub(msg, nr_3, nr_3) ~= ")") and (nr_3 - nr_2 < 100)) do
                  nr_3 = nr_3 + 1;
               end
               if (string.sub(msg, nr_3, nr_3) == ")") then
                  if (QTR_PS["ownnames"] == "1") then        -- forma narodowa: polska, czeska, ukraińska, węgierska, włoska, turecka, arabska
                     QTR_forma = string.sub(msg,nr_2+1,nr_3-1);
                  else                                      -- forma angielska
                     QTR_forma = string.sub(msg,nr_1+1,nr_2-1);
                  end
                  if (nr_poz>1) then
                     msg = string.sub(msg,1,nr_poz-1) .. QTR_forma .. string.sub(msg,nr_3+1);
                  else
                     msg = QTR_forma .. string.sub(msg,nr_3+1);
                  end
               end   
            end
         end
         nr_poz, nr_poz2 = string.find(msg, "OWN_NAME");
      end
   end
   
   return msg;
end

-------------------------------------------------------------------------------------------------------------------

-- podmieniaj specjane znaki w tekście
function QTR_ExpandUnitInfo(msg, OnObjectives, AR_obj, AR_font, AR_corr)
   if (msg == nil) then
      msg = "";
   end
   msg = WOW_ZmienKody(msg);
   
   if ((WoWTR_Localization.lang == 'AR') and (AR_obj)) then    -- prepare the text for proper display
      local _font = WOWTR_Font2;
      local AR_size = 13;
      if (AR_obj.GetFont) then
         _font, AR_size, _3 = AR_obj:GetFont("P");             -- read current font and size of the object
      else
         local regions = { AR_obj:GetRegions() };              -- search for FontString object to read the font
         for k, v in pairs(regions) do
            if (v:GetObjectType() == "FontString") then
               _font, AR_size, _3 = v:GetFont();               -- read current font and size of the object
            end
         end
      end
      local _corr = 0;
      if (AR_corr and (type(AR_corr)=="number")) then
         _corr = AR_corr;
      end

      msg, specialCodes, prefix = HandleWoWSpecialCodes(msg)

      msg = string.gsub(msg, "{n}", "\n");
      msg = string.gsub(msg, "\n", "#");
      msg = string.gsub(msg, "{r}", "r|");
      
      -- Handle {c}, {T}, {A}, {H} codes
      local function handleCode(startCode, endCode)
         local nr_poz1 = string.find(msg, startCode)
         while (nr_poz1) do
            local nr_poz2 = string.find(msg, endCode, nr_poz1)
            if (nr_poz2) then
               local pomoc = string.sub(msg, nr_poz1+2, nr_poz2-1)
               msg = string.gsub(msg, startCode..pomoc..endCode, string.reverse(pomoc)..string.sub(startCode, 2, 2).."|")
               nr_poz1 = string.find(msg, startCode, nr_poz2)
            else
               break
            end
         end
      end

      handleCode("{c", "}")
      handleCode("{T", "{t}")
      handleCode("{A", "{a}")
      handleCode("{H", "{h}")

      msg = string.gsub(msg, "{t}", "t|");
      msg = string.gsub(msg, "{a}", "a|");
      msg = string.gsub(msg, "{h}", "h|");
      
      msg = AS_ReverseAndPrepareLineText(msg, AR_obj:GetWidth()+_corr, AR_font, AR_size);

      msg = RestoreWoWSpecialCodes(msg, specialCodes)

      -- Reattach the prefix
      msg = prefix .. msg
   end
   
   return msg;
end

-------------------------------------------------------------------------------------------------------------------

-- jeśli tekst jest arabski - odwróć kolejność wszystkich liter (znaków)
function QTR_ReverseIfAR(txt)
   if (txt and (WoWTR_Localization.lang == 'AR')) then
      local msg = string.gsub(txt, "{r}", "r|");
      msg = string.gsub(msg, "{n}", "\n");
      msg = string.gsub(msg, "|n|n", "n|n|");
      local nr_poz1, nr_poz2 = string.find(msg, "{c");    -- znajdź kod koloru {c , gdy nie znalazł, jest: nil
      while (nr_poz1) do
         local pomoc = string.sub(msg, nr_poz2+1, nr_poz2+8);  -- odczytaj składowe koloru
         msg = string.gsub(msg, "{c"..pomoc.."}", string.reverse(pomoc).."c|");
         nr_poz1, nr_poz2 = string.find(msg, "{c");       -- znajdź kod koloru {c , gdy nie znalazł, jest: nil
      end
      return AS_UTF8reverse(msg);
   end
   return txt;
end


-------------------------------------------------------------------------------------------------------------------

function WOWTR_AnsiReverse(txt)
   if not txt then
      return ""
   end
   local text = txt
   if (WoWTR_Localization.lang == 'AR') then
      text = string.reverse(text)
   end
   return text
end

-------------------------------------------------------------------------------------------------------------------

function WOWTR_ReplaceOnlyWholeWords(txt, finder, replacer)
   local result = txt;
   local last = 1;
   local nr_poz, nr_end = string.find(result, finder);   -- gdy nie znalazł, jest: nil
   while (nr_poz and nr_poz>0) do                        -- OK, znalazł coś, indeksuje pozycję początkową od 1
      if ((nr_poz==1) or ((nr_poz>1) and (string.sub(result, nr_poz-1, nr_poz-1)==' ')) or ((nr_poz>2) and (string.sub(result, nr_poz-2, nr_poz-1)=='$B'))) then
         -- znaleziony finder zaczyna tekst lub poprzedza go spacja lub poprzedza go kod $B
         local char_after = string.sub(result, nr_end+1, nr_end+1);   
         if ((char_after=='.') or (char_after==',') or (char_after=='?') or (char_after=='!') or (char_after==' ') or (char_after==';') or (char_after==':') or (char_after=='>') or (char_after=='-')) then
            -- po odszukanym finder jest znak: .,? !;:>-
            result = string.sub(result, 1, nr_poz-1)..replacer..string.sub(result, nr_end+1);
            last = nr_poz + strlen(replacer);
         else              -- nie jest to samodzielne słowo
            last = nr_end + 1;
         end
      else
         last = nr_poz + strlen(finder);
      end
      nr_poz, nr_end = string.find(result, finder, last);
   end
   return result;
end

-------------------------------------------------------------------------------------------------------------------

function WOWTR_DetectAndReplacePlayerName(txt,target,part)
   if (txt == nil) then return ""; end
   local text = string.gsub(txt, '\r', "");
   if (part==nil) or (part=='$B') then
      text = string.gsub(text, '\n', "$B");
   end
   if (part == nil) or (part == '$N') then
      local upperCaseName = string.upper(WOWTR_player_name);
      text = string.gsub(text, WOWTR_player_name, "$N");  --Match lowercase
      text = string.gsub(text, upperCaseName, "$N");     --Match uppercase
   end
   if (part==nil) or (part=='$R') then
      text = WOWTR_ReplaceOnlyWholeWords(text, WOWTR_player_race, '$R');
      text = WOWTR_ReplaceOnlyWholeWords(text, string.lower(WOWTR_player_race), '$R');
      text = WOWTR_ReplaceOnlyWholeWords(text, string.upper(WOWTR_player_race), '$R$');
   end
   if (part==nil) or (part=='$C') then
      text = WOWTR_ReplaceOnlyWholeWords(text, WOWTR_player_class, '$C');
      text = WOWTR_ReplaceOnlyWholeWords(text, string.lower(WOWTR_player_class), '$C');
      text = WOWTR_ReplaceOnlyWholeWords(text, string.upper(WOWTR_player_class), '$C$');
   end
   if (target) then
      text = WOWTR_ReplaceOnlyWholeWords(text, target, "$N");
   end
   return text;
end

-------------------------------------------------------------------------------------------------------------------

function WOWTR_DeleteSpecialCodes(txt,part)
   if (txt == nil) then return ""; end
   local text = txt;
   if (part==nil) or (part=='$B') then
      text = string.gsub(text, '$B', '');
   end
   if (part==nil) or (part=='$N') then
      text = string.gsub(text, '$N$', '');
      text = string.gsub(text, '$N', '');
   end
   if (part==nil) or (part=='$R') then
      text = string.gsub(text, '$R$', '');
      text = string.gsub(text, '$R', '');
   end
   if (part==nil) or (part=='$C') then
      text = string.gsub(text, '$C$', '');
      text = string.gsub(text, '$C', '');
   end
   return text;
end

-------------------------------------------------------------------------------------------------------------------

--ADVANTURE MAP QUEST
function ST_AdvantureMapFrm()			-- https://imgur.com/a/uQElPgm
   if (QTR_PS["active"] == "1") then
	local AdvMapFrm01 = AdventureMapQuestChoiceDialog.Details.Child.TitleHeader;
	ST_CheckAndReplaceTranslationTextUI(AdvMapFrm01, true, "Collections:Quest", WOWTR_Font1);
	local AdvMapFrm02 = AdventureMapQuestChoiceDialog.Details.Child.DescriptionText;
	ST_CheckAndReplaceTranslationTextUI(AdvMapFrm02, true, "Collections:Quest");
	local AdvMapFrm04 = AdventureMapQuestChoiceDialog.Details.Child.ObjectivesText;
	ST_CheckAndReplaceTranslationTextUI(AdvMapFrm04, true, "Collections:Quest");
   end
   if (TT_PS["ui1"] == "1") then
	local AdvMapFrm03 = AdventureMapQuestChoiceDialog.Details.Child.ObjectivesHeader;
	ST_CheckAndReplaceTranslationTextUI(AdvMapFrm03, false, "ui", WOWTR_Font1);
	local AdvMapFrm05 = AdventureMapQuestChoiceDialog.RewardsHeader;
	ST_CheckAndReplaceTranslationTextUI(AdvMapFrm05, false, "ui", WOWTR_Font1);
	local AdvMapFrm06 = AdventureMapQuestChoiceDialog.AcceptButton.Text;
	ST_CheckAndReplaceTranslationTextUI(AdvMapFrm06, false, "ui");
	local AdvMapFrm07 = AdventureMapQuestChoiceDialog.DeclineButton.Text;
	ST_CheckAndReplaceTranslationTextUI(AdvMapFrm07, false, "ui");
   end
end

-- --------------------------------------------------------------------------
-- Overwrite the QuestObjectiveTracker.ContentsFrame.HeaderText each time
-- the game updates the objective tracker
-- --------------------------------------------------------------------------
function QTR_OverrideObjectiveTrackerHeader(tracker, quest, directID)
   -- 1) Grab questID from the 'quest' object
   local questID;
   if ( directID ) then    -- true, if the quest ID is entered directly
      questID = quest;
   else
      questID = quest and tonumber(quest:GetID());
   end
   if not questID or questID == 0 then
       return;
   end

   -- 2) Locate the correct quest block from the tracker's usedBlocks
   local template = tracker.blockTemplate or "ObjectiveTrackerBlockTemplate";
   local questBlocks = tracker.usedBlocks and tracker.usedBlocks[template];
   if not questBlocks then
       return;
   end

   local block = questBlocks[questID];
   if not (block and block.HeaderText) then
       return;
   end

   -- 3) Look up your translation. Example: QTR_quest_LG[questID].title  --!!-- wrong: QTR_quest_LG[questID].title is available only AFTER displaying quest details
   if ( QTR_QuestData[tostring(questID)] ) and (QTR_PS["transtitle"] == "1") then    -- wyświetlaj tylko, gdy istnieje tłumaczenie
      local questDataTitle = QTR_QuestData[tostring(questID)]["Title"];
      if questDataTitle then
      
         -- 4) Assign your localized title to the block's header
         if WoWTR_Localization.lang == "AR" then
            block.HeaderText:SetFont(WOWTR_Font2, 14);
         else
            block.HeaderText:SetFont(WOWTR_Font2, 12);
         end
         block.HeaderText:SetText( QTR_ExpandUnitInfo(questDataTitle, false, block.HeaderText, WOWTR_Font2, -50) );

         -- Example: if Arabic, justify to the right, otherwise left
         if WoWTR_Localization.lang == "AR" then
            block.HeaderText:SetJustifyH("RIGHT");
         else
            block.HeaderText:SetJustifyH("LEFT");
         end
      end
   end
end
