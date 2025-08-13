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
GossipDUI_LN = { };
GossipDUI_EN = { };
Gossip2DUI_LN = { };
Gossip2DUI_EN = { };
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
   --print("GS_ON_OFF");
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
         GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR.." ",false,GossipGreetingText,WOWTR_Font2,-5));    -- dodano na końcu twardą spację
         GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR..NONBREAKINGSPACE,false,GossipGreetingText,WOWTR_Font2,-5));    -- dodano na końcu twardą spację
         GossipGreetingText:SetJustifyH("RIGHT");
      else
         GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR..NONBREAKINGSPACE,false,GossipGreetingText,WOWTR_Font2));    -- dodano na końcu twardą spację
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
   --print("GS_ON_OFF2");
   if (QTR_curr_goss=="1") then         -- Switch TO English (LTR)
      QTR_display_constants(0);          -- Reset constants to original
      QTR_curr_goss="0";
      GreetingText:SetText(QTR_GS[QTR_curr_hash] or ""); -- Restore original main text
      GreetingText:SetJustifyH("LEFT");                 -- Ensure main text is LTR
      -- GreetingText:SetFont(Original_Font2, 12);     -- Uncomment to reset main text font if needed
      QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." EN");

      -- Restore options to English LTR layout
      if (QTR_goss_optionsEN) then
         for k, v in pairs(QTR_goss_optionsEN) do -- k is the button frame, v is the original English text
            k:SetText(v or ""); -- Restore original English text, add fallback

            local fontStringRegion = nil;
            local iconRegion = k.Icon; -- Get the icon region if it exists
            local regions = { k:GetRegions() };
             for _, region in pairs(regions) do
                if (region:GetObjectType() == "FontString") then
                   fontStringRegion = region;
                   break; -- Found the font string
                end
             end

             if fontStringRegion then
                -- === Reset Layout to LTR (English Standard) ===
                local leftPadding = 10; -- Default left padding for text

                if iconRegion then
                   -- 1. Position Icon on the far left
                   iconRegion:ClearAllPoints();
                   -- Anchor TOPLEFT of icon to TOPLEFT of button, add small offset
                   iconRegion:SetPoint("TOPLEFT", k, "TOPLEFT", 5, -2); -- 5px from left, 2px from top
                   leftPadding = iconRegion:GetWidth() + 5 + 5; -- Icon width + icon padding + text padding
                end

                -- 2. Position Text to the right of the Icon (or default padding)
                fontStringRegion:ClearAllPoints();
                fontStringRegion:SetPoint("TOPLEFT", k, "TOPLEFT", leftPadding, -2); -- Position text
                fontStringRegion:SetJustifyH("LEFT"); -- Ensure LTR justification for text

                -- Optional: Reset font if it was changed for translation
                -- fontStringRegion:SetFont(Original_Font2, tonumber(QTR_PS["fontsize"]));
             end

             -- Resize the button frame after potential text/layout changes
             if k.Resize then k:Resize() end;
         end
      end

   else                                 -- Switch TO Translated (Potentially RTL)
      QTR_display_constants(1);          -- Set constants to translated
      QTR_curr_goss="1";
      local Greeting_TR = GS_Gossip[QTR_curr_hash] or (QTR_GS[QTR_curr_hash] or ""); -- Get translation, fallback to original
      local isArabic = (WoWTR_Localization.lang == 'AR');

      -- Handle special case: Bronze Timekeeper number formatting (Keep this logic)
      if (string.sub(Nazwa_NPC or "",1,17) == "Bronze Timekeeper") then
         local wartab = {0,0,0,0,0,0};
         local arg0 = 0;
         -- Using QTR_GS[QTR_curr_hash] which holds the original English text for number extraction
         for w in string.gmatch(strtrim(QTR_GS[QTR_curr_hash] or ""), "%d+") do
            arg0 = arg0 + 1;
            local num_w = tonumber(w) or 0;
            if (num_w>999999) then
               wartab[arg0] = tostring(math.floor(num_w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2."):gsub("(%-?)$", "%1"):reverse();
            elseif (num_w>99999) then
               wartab[arg0] = tostring(math.floor(num_w)):reverse():gsub("(%d%d%d)(%d%d%d)", "%1.%2"):gsub("(%-?)$", "%1"):reverse();
            elseif (num_w>999) then
               wartab[arg0] = tostring(math.floor(num_w)):reverse():gsub("(%d%d%d)", "%1."):gsub("(%-?)$", "%1"):reverse();
            else
               wartab[arg0] = w;
            end
         end;
         -- Replace placeholders in the translated text
         if (arg0>5 and wartab[6]) then Greeting_TR=string.gsub(Greeting_TR, "$6", wartab[6]); end
         if (arg0>4 and wartab[5]) then Greeting_TR=string.gsub(Greeting_TR, "$5", wartab[5]); end
         if (arg0>3 and wartab[4]) then Greeting_TR=string.gsub(Greeting_TR, "$4", wartab[4]); end
         if (arg0>2 and wartab[3]) then Greeting_TR=string.gsub(Greeting_TR, "$3", wartab[3]); end
         if (arg0>1 and wartab[2]) then Greeting_TR=string.gsub(Greeting_TR, "$2", wartab[2]); end
         if (arg0>0 and wartab[1]) then Greeting_TR=string.gsub(Greeting_TR, "$1", wartab[1]); end
      end

      -- Format and set main gossip text based on language
      if isArabic then
         GreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR..NONBREAKINGSPACE,false,GreetingText,WOWTR_Font2,-5)); -- Use ExpandUnitInfo for main text too
         GreetingText:SetJustifyH("RIGHT");
      else
         GreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR..NONBREAKINGSPACE,false,GreetingText,WOWTR_Font2)); -- Use ExpandUnitInfo for main text too
         GreetingText:SetJustifyH("LEFT");
      end
      -- GreetingText:SetFont(WOWTR_Font2, 12); -- Set translated font if needed

      QTR_ToggleButton0:SetText("Gossip-Hash="..tostring(QTR_curr_hash).." "..WoWTR_Localization.lang);

      -- Apply translated text and layout to options
      if (QTR_goss_optionsTR) then
          for k, v in pairs(QTR_goss_optionsTR) do -- k is the button frame, v is the translated text
             k:SetText(v or ""); -- Set translated text, add fallback

             local fontStringRegion = nil;
             local iconRegion = k.Icon;
             local regions = { k:GetRegions() };
             for _, region in pairs(regions) do
                if (region:GetObjectType() == "FontString") then
                   fontStringRegion = region;
                   break;
                end
             end

             if fontStringRegion then
                -- Apply translated font
                fontStringRegion:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"]));

                -- Apply layout based on language and icon presence
                if iconRegion and isArabic then
                    -- === ARABIC (RTL) WITH ICON ===
                    iconRegion:ClearAllPoints();
                    iconRegion:SetPoint("TOPRIGHT", k, "TOPRIGHT", -10, -2); -- Icon far right
                    fontStringRegion:ClearAllPoints();
                    fontStringRegion:SetPoint("TOPRIGHT", iconRegion, "TOPLEFT", -5, 0); -- Text left of icon
                    fontStringRegion:SetJustifyH("RIGHT");

                elseif isArabic then
                    -- === ARABIC (RTL) WITHOUT ICON ===
                    fontStringRegion:ClearAllPoints();
                    fontStringRegion:SetPoint("TOPRIGHT", k, "TOPRIGHT", -10, -2); -- Text far right
                    fontStringRegion:SetJustifyH("RIGHT");

                else
                    -- === LTR (English, etc.) or Non-AR ===
                    local leftPadding = 10;
                    if iconRegion then
                       iconRegion:ClearAllPoints();
                       iconRegion:SetPoint("TOPLEFT", k, "TOPLEFT", 5, -2); -- Icon far left
                       leftPadding = iconRegion:GetWidth() + 5 + 5;
                    end
                    fontStringRegion:ClearAllPoints();
                    fontStringRegion:SetPoint("TOPLEFT", k, "TOPLEFT", leftPadding, -2); -- Text right of icon/padding
                    fontStringRegion:SetJustifyH("LEFT");
                end
             end

             -- Resize the button frame after potential text/layout changes
             if k.Resize then k:Resize() end;
          end
       end
   end
end

-------------------------------------------------------------------------------------------------------------------

-- NPC chat window opened - frame: GossipFrame
function QTR_Gossip_Show()
   --print("QTR_Gossip_Show");
   local function ProcessOPT(buttonString)
      local fontString = buttonString.Content.Name;
      local GOptionText = WOWTR_DetectAndReplacePlayerName(fontString:GetText());
      local prefix = "";
      local sufix = "";
      table.insert(Gossip2DUI_EN, fontString:GetText());   -- english version
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
         local transLN = prefix .. QTR_ExpandUnitInfo(GS_Gossip[OptHash],false,fontString,WOWTR_Font2,-40) .. sufix .. NONBREAKINGSPACE;   -- twarda spacja na końcu
         fontString:SetText(transLN);
      end
      table.insert(Gossip2DUI_LN, fontString:GetText());    -- translated version
   end

   QTR_IconAI:Hide();
   GoQ_IconAI:Hide();
   Nazwa_NPC = GossipFrameTitleText:GetText();
   if (isImmersion()) then           -- jest aktywny Immersion
      if (Nazwa_NPC==nil) then
         Nazwa_NPC = ImmersionFrame.TalkBox.NameFrame.Name:GetText();
      end
      QTR_ToggleButton4:SetText(QTR_ReverseIfAR(WoWTR_Localization.gossipText));
      QTR_ToggleButton4:Disable();   -- this button is only for quest information 
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
      
      if (Greeting_Text and (string.find(Greeting_Text,NONBREAKINGSPACE)==nil)) then   -- nie jest to tekst przetłumaczony (nie ma twardej spacji)
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
                  GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR..NONBREAKINGSPACE,false,GossipGreetingText,WOWTR_Font2,-5));    -- dodano na końcu twardą spację
                  GossipGreetingText:SetJustifyH("RIGHT");
               else
                  GossipGreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR..NONBREAKINGSPACE,false,GossipGreetingText,WOWTR_Font2));    -- dodano na końcu twardą spację
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
               if (Storyline_NPCFrameChat.texts == nil) then
                  C_Timer.After(1.0, function() txt0txt = QTR_ExpandUnitInfo(Greeting_TR,false,Storyline_NPCFrameChat.texts[0],WOWTR_Font2); QTR_Storyline_Gossip(); end);
               else
                  txt0txt = QTR_ExpandUnitInfo(Greeting_TR,false,Storyline_NPCFrameChat.texts[0],WOWTR_Font2);
                  if (not WOWTR_wait(1.0, QTR_Storyline_Gossip)) then
                  -- opóźnienie 1.0 sek
                  end
               end
            end
            if (IsDUIQuestFrame()) then   -- jest aktywny dodatek DialogueUI i zezwolono na tłumaczenia
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
            if (IsDUIQuestFrame()) then   -- jest aktywny dodatek DialogueUI i zezwolono na tłumaczenia
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
            if (((GTtype==3) or (GTtype==4) or (GTtype==5)) and (QTR_PS["gossip"]=="1") and (string.find(GTxtframe:GetText(),NONBREAKINGSPACE)==nil)) then    -- gossip options
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
                     transTR = prefix .. QTR_ExpandUnitInfo(GS_Gossip[OptHash],false,GTxtframe,WOWTR_Font2,-60,"RIGHT") .. sufix .. NONBREAKINGSPACE;   -- twarda spacja na końcu
                  else                 
                     transTR = prefix .. QTR_ExpandUnitInfo(GS_Gossip[OptHash],false,GTxtframe,WOWTR_Font2,-40,"RIGHT") .. sufix .. NONBREAKINGSPACE;   -- twarda spacja na końcu
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
      
      if ( QTR_first_ok ) then   -- switch to english
         if (IsDUIQuestFrame()) then
            GossipDUI_ON_OFF();
         elseif (isImmersion()) then       -- addon Immersion is active
            ImmersionFrame.TalkBox.TextFrame.Text:SetFont(Original_Font2, 12);
            ImmersionFrame.TalkBox.TextFrame.Text:SetText(Greeting_Text);     
         else
            GS_ON_OFF();
         end
      end
   end
   
   -- Gossip Frame Buttons - Goodbye,
   -- print("Gossip Frame");
   local GFGoodbyeBtext = GossipFrame.GreetingPanel.GoodbyeButton.Text;
   ST_CheckAndReplaceTranslationText(GFGoodbyeBtext, true, "ui",false,true);
end

-------------------------------------------------------------------------------------------------------------------

function GossipOnQuestFrame()       -- frame: QuestFrame
   --print("GossipOnQuestFrame");
   QTR_IconAI:Hide();
   GoQ_IconAI:Hide();
   if ((GreetingText:IsVisible()) and (QTR_PS["gossip"]=="1")) then     -- mamy gossip w QuestFrame i włączone wyświetlanie tłumaczeń gossip
      QTR_ToggleButton0:Disable();                                      -- wyłącz możliwość przełączania EN-TR
      QTR_ToggleButton0:SetWidth(200);
      local Greeting_Text = GreetingText:GetText();
      if (Greeting_Text and (string.find(Greeting_Text,NONBREAKINGSPACE)==nil)) then         -- nie jest to tekst po turecku (nie ma twardej spacji)
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
            GreetingText:SetText(QTR_ExpandUnitInfo(Greeting_TR..NONBREAKINGSPACE,false,GreetingText,WOWTR_Font2));
            GreetingText:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"]));
--            GreetingText:Resize();
            QTR_curr_goss="1";
            if (GreetingText:GetHeight() > GO_height+1) then
               GO_resized = GO_resized + GreetingText:GetHeight() - GO_height;
            end
            if (GS_AI and GS_AI[Hash]) then
               GoQ_IconAI:Show();
            end
            if (IsDUIQuestFrame()) then   -- jest aktywny dodatek DialogueUI i zezwolono na tłumaczenia
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
               local originalGossText = GText:GetText(); -- Get original text before modifications
               local questID = GText.questID; -- IMPORTANT: Get quest ID from the button object
               local transTR = nil; -- Variable to hold the final translated text
               local prefix = "";
               local sufix = "";
               local isTranslated = false;

               -- Check for color codes in the original text
               if (string.sub(originalGossText,1,2) == "|c") then
                  prefix = string.sub(originalGossText, 1, 10);
                  sufix = "|r";
               end

               -- --- PRIORITY 1: Check if it's a Quest and use QTR_QuestData ---
               if questID and questID ~= 0 and QTR_PS["transtitle"] == "1" then
                  local str_ID = tostring(questID);
                  if QTR_QuestData[str_ID] and QTR_QuestData[str_ID]["Title"] then
                     local translatedTitle = QTR_QuestData[str_ID]["Title"];
                     -- Store the clean title for ExpandUnitInfo, re-add prefix/suffix later
                     local cleanTransTR = QTR_ExpandUnitInfo(translatedTitle, false, GText, WOWTR_Font2, -40); -- Width adjustment might still be needed here
                     transTR = prefix .. cleanTransTR .. sufix .. " ";
                     isTranslated = true;
                  end
               end

               -- --- PRIORITY 2: If not a quest or quest title not found/disabled, check GS_Gossip ---
               if not isTranslated then
                   local GOptionText = WOWTR_DetectAndReplacePlayerName(originalGossText, nil, '$N'); -- Detect only player name
                   local cleanOptionText = GOptionText;
                   if prefix ~= "" then -- Remove color codes if they existed for hashing
                       cleanOptionText = string.gsub(cleanOptionText, prefix, "");
                       cleanOptionText = string.gsub(cleanOptionText, sufix, "");
                   end
                   local Czysty_Text = WOWTR_DeleteSpecialCodes(cleanOptionText, '$N');
                   local TitleHash = StringHash(Czysty_Text); -- Hash the cleaned English text

                   if GS_Gossip[TitleHash] then
                      -- Use ExpandUnitInfo for potential codes and Arabic reversal
                      local cleanTransTR = QTR_ExpandUnitInfo(GS_Gossip[TitleHash], false, GText, WOWTR_Font2, -40); -- Width adjustment
                      transTR = prefix .. cleanTransTR .. sufix .. " ";
                      isTranslated = true;
                   else
                      -- Save non-translated GOSSIP option for later
                      if (QTR_PS["saveGS"]=="1") then
                         local Nazwa_NPC = QuestFrameTitleText:GetText();
                         local textToSave = WOWTR_DetectAndReplacePlayerName(originalGossText); -- Use original text with player name code
                         textToSave = string.gsub(textToSave, '"', '\"');
                         local mapId = C_Map.GetBestMapForUnit("player") or "0";
                         QTR_GOSSIP[Nazwa_NPC..'@'..tostring(TitleHash).."@"..mapId] = GOptionText.."@"..WOWTR_player_name..":"..WOWTR_player_race..":"..WOWTR_player_class;
                      end
                   end
               end

               -- --- Apply Translation and Positioning if Found ---
               if isTranslated and transTR then
                  if (GO_resized > 0) then -- Adjust button position due to main text resize
                     local point, relativeTo, relativePoint, xOfs, yOfs = GText:GetPoint(1);
                     GText:ClearAllPoints();
                     GText:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-GO_resized);
                  end
                  local GO_height = GText:GetHeight();

                  -- Store original and translated versions
                  QTR_goss_optionsEN[GText] = originalGossText;
                  QTR_goss_optionsTR[GText] = transTR;

                  GText:SetText(transTR); -- Set the translated text (FontString will use this)

                  -- Find the actual FontString and Icon to position them
                  local fontStringRegion = nil;
                  local iconRegion = GText.Icon; -- Assume icon is directly accessible
                  local regions = { GText:GetRegions() };
                  for k, v in pairs(regions) do
                     if (v:GetObjectType() == "FontString") then
                        fontStringRegion = v;
                        break; -- Found the font string
                     end
                  end

                  if fontStringRegion then
                      fontStringRegion:SetFont(WOWTR_Font2, tonumber(QTR_PS["fontsize"]));

                      if iconRegion and (WoWTR_Localization.lang == 'AR') then
                          -- === ARABIC (RTL) WITH ICON ===
                          -- 1. Position Icon on the far right
                          iconRegion:ClearAllPoints();
                          -- Anchor TOPRIGHT of icon to TOPRIGHT of button, slight offset from edge
                          iconRegion:SetPoint("TOPRIGHT", GText, "TOPRIGHT", -10, -2); -- -10px from right, -2px from top

                          -- 2. Position Text to the left of the Icon
                          fontStringRegion:ClearAllPoints();
                          -- Anchor TOPRIGHT of text to TOPLEFT of icon, with a gap
                          fontStringRegion:SetPoint("TOPRIGHT", iconRegion, "TOPLEFT", -5, 0); -- -5px gap
                          fontStringRegion:SetJustifyH("RIGHT"); -- Justify text within its available space (flows left)

                      elseif (WoWTR_Localization.lang == 'AR') then
                          -- === ARABIC (RTL) WITHOUT ICON ===
                          fontStringRegion:ClearAllPoints();
                          -- Anchor text near right edge
                          fontStringRegion:SetPoint("TOPRIGHT", GText, "TOPRIGHT", -10, -2);
                          fontStringRegion:SetJustifyH("RIGHT");

                      else
                          -- === LTR (English, etc.) or Non-AR ===
                          local leftPadding = 10; -- Default padding
                          if iconRegion then
                              -- Position icon on the left (standard LTR)
                              iconRegion:ClearAllPoints();
                              iconRegion:SetPoint("TOPLEFT", GText, "TOPLEFT", 5, -2); -- 5px from left
                              leftPadding = iconRegion:GetWidth() + 5 + 5; -- Icon width + gap + text padding
                          end
                          -- Position text to the right of the icon (or default padding)
                          fontStringRegion:ClearAllPoints();
                          fontStringRegion:SetPoint("TOPLEFT", GText, "TOPLEFT", leftPadding, -2);
                          fontStringRegion:SetJustifyH("LEFT"); -- Standard LTR justification
                      end
                  end

                  -- Resize button and account for height changes
                  if GText.Resize then GText:Resize(); end
                  if (GText:GetHeight() > GO_height+1) then
                     GO_resized = GO_resized + GText:GetHeight() - GO_height;
                  end
               else
                  -- --- Handle Untranslated Text ---
                  if (GO_resized > 0) then -- Adjust button position
                     local point, relativeTo, relativePoint, xOfs, yOfs = GText:GetPoint(1);
                     GText:ClearAllPoints();
                     GText:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-GO_resized);
                  end
                   local GO_height = GText:GetHeight(); -- Get height before potential resize

                  -- Find the FontString and Icon to reset position
                  local fontStringRegion = nil;
                  local iconRegion = GText.Icon;
                  local regions = { GText:GetRegions() };
                  for k, v in pairs(regions) do
                     if (v:GetObjectType() == "FontString") then
                        fontStringRegion = v;
                        break;
                     end
                  end

                  if fontStringRegion then
                      -- Reset to default LTR layout
                      local leftPadding = 10;
                      if iconRegion then
                          -- Ensure icon is positioned left
                          iconRegion:ClearAllPoints();
                          iconRegion:SetPoint("TOPLEFT", GText, "TOPLEFT", 5, -2);
                          leftPadding = iconRegion:GetWidth() + 5 + 5;
                      end
                      -- Position text left
                      fontStringRegion:ClearAllPoints();
                      fontStringRegion:SetPoint("TOPLEFT", GText, "TOPLEFT", leftPadding, -2);
                      fontStringRegion:SetJustifyH("LEFT");
                      -- Maybe reset font here if needed?
                      -- fontStringRegion:SetFont(Original_Font2, tonumber(QTR_PS["fontsize"]));
                  end

                   -- Resize button and account for height changes
                  if GText.Resize then GText:Resize(); end
                  if (GText:GetHeight() > GO_height+1) then
                     GO_resized = GO_resized + GText:GetHeight() - GO_height;
                  end
               end
            end -- End loop through buttons
         end
      end
   end

-- Quest Frame Buttons - Accept, Decline, Complete Quest, Continue and Cancel
-- print("Quest Frame");
   local QFCompleteQBtext = QuestFrameCompleteQuestButtonText;
   ST_CheckAndReplaceTranslationText(QFCompleteQBtext, true, "ui",false,true);

   local QFCompleteQBtext2 = QuestFrameCompleteButtonText;
   ST_CheckAndReplaceTranslationText(QFCompleteQBtext2, true, "ui",false,true);

   local QFAcceptBtext = QuestFrameAcceptButtonText;
   ST_CheckAndReplaceTranslationText(QFAcceptBtext, true, "ui",false,true);

   local QFDeclineBtext = QuestFrameDeclineButtonText;
   ST_CheckAndReplaceTranslationText(QFDeclineBtext, true, "ui",false,true);

   local QFContinueBtext = QuestFrameContinueButtonText;
   ST_CheckAndReplaceTranslationText(QFContinueBtext, true, "ui",false,true);

   local QFGoodbyeBtext = QuestFrameGreetingGoodbyeButtonText;
   ST_CheckAndReplaceTranslationText(QFGoodbyeBtext, true, "ui",false,true);

   local QFGoodbyeBtext2 = QuestFrameGoodbyeButtonText;
   ST_CheckAndReplaceTranslationText(QFGoodbyeBtext2, true, "ui",false,true);

   local QFCompleteButtontext = QuestFrameCompleteButtonText;
   ST_CheckAndReplaceTranslationText(QFCompleteButtontext, true, "ui",false,true);

   local QFCompleteNotice = QuestFrame.AccountCompletedNotice.Text;
   ST_CheckAndReplaceTranslationText(QFCompleteNotice, true, "ui",false,true);
	
   if (WoWTR_Localization.lang == 'AR') then
      if QuestInfoAccountCompletedNotice then -- Check if the element exists
         local QFNoticetext = QuestInfoAccountCompletedNotice;
         ST_CheckAndReplaceTranslationText(QFNoticetext, true, "ui",false,true);
         QuestInfoAccountCompletedNotice:SetTextColor(0.5, 0, 0.5);
         QuestInfoAccountCompletedNotice:SetJustifyH("RIGHT");
         -- Get the current anchor point and offset
         -- Adjust the x offset by -50 pixels (move to the left)
         local point, relativeTo, relativePoint, xOfs, yOfs = QuestInfoAccountCompletedNotice:GetPoint(1);
         QuestInfoAccountCompletedNotice:SetPoint(point, relativeTo, relativePoint, xOfs - 20, yOfs);
      end
   else  
      if QuestInfoAccountCompletedNotice then -- Check if the element exists
         local QFNoticetext = QuestInfoAccountCompletedNotice;
         ST_CheckAndReplaceTranslationText(QFNoticetext, true, "ui",false,true);
      end
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
   --print("QTR_START");

   -- Button in QuestFrame (NPC)
   QTR_ToggleButton0 = CreateFrame("Button", nil, QuestFrame, "UIPanelButtonTemplate")
   QTR_ToggleButton0:SetWidth(150)
   QTR_ToggleButton0:SetHeight(20)
   QTR_ToggleButton0:SetText("QID=?")
   QTR_ToggleButton0:Show()
   QTR_ToggleButton0:ClearAllPoints()
   QTR_ToggleButton0:SetPoint("TOPLEFT", QuestFrame, "TOPLEFT", 55, -20)
   QTR_ToggleButton0:SetScript("OnClick", QTR_ON_OFF)

   -- Button in QuestLogPopupDetailFrame
   QTR_ToggleButton1 = CreateFrame("Button", nil, QuestLogPopupDetailFrame, "UIPanelButtonTemplate")
   QTR_ToggleButton1:SetWidth(150)
   QTR_ToggleButton1:SetHeight(20)
   QTR_ToggleButton1:SetText("QID=?")
   QTR_ToggleButton1:Show()
   QTR_ToggleButton1:ClearAllPoints()
   QTR_ToggleButton1:SetPoint("TOPLEFT", QuestLogPopupDetailFrame, "TOPLEFT", 45, -31)
   QTR_ToggleButton1:SetScript("OnClick", QTR_ON_OFF)

   -- Button in QuestMapDetailsScrollFrame
   QTR_ToggleButton2 = CreateFrame("Button", nil, QuestMapDetailsScrollFrame, "UIPanelButtonTemplate")
   QTR_ToggleButton2:SetWidth(110)
   QTR_ToggleButton2:SetHeight(21)
   QTR_ToggleButton2:SetText("QID=?")
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
         GameTooltip:AddLine(QTR_ExpandUnitInfo(GS_Gossip[1975795450], false, GameTooltip, WOWTR_Font2)..NONBREAKINGSPACE, 1, 1, 1, true)   -- white color, wrap
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
         GameTooltip:AddLine(QTR_ExpandUnitInfo(GS_Gossip[1975795450], false, GameTooltip, WOWTR_Font2)..NONBREAKINGSPACE, 1, 1, 1, true)   -- white color, wrap
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
   
      -- Original hook for standard quests (UpdateSingle for individual quest blocks)
      hooksecurefunc(QuestObjectiveTracker, "UpdateSingle", function(self, quest)
         QTR_OverrideObjectiveTrackerHeader(self, quest); -- For individual quest titles within this tracker
      end);

      -- Helper function to process updates for INDIVIDUAL QUEST TITLES within trackers using the 'Update' method
      local function ProcessTrackerBlockUpdates(tracker)
         -- Iterate through all blocks managed by this specific tracker
         local template = tracker.blockTemplate or "ObjectiveTrackerBlockTemplate";
         local questBlocks = tracker.usedBlocks and tracker.usedBlocks[template];
         if questBlocks then
            for questID, block in pairs(questBlocks) do
                  if block and block:IsVisible() and block.HeaderText then
                     -- The 'true' flag tells QTR_OverrideObjectiveTrackerHeader it's getting a direct ID
                     QTR_OverrideObjectiveTrackerHeader(tracker, questID, true);
                  end
            end
         end
      end

      -- Hook specific tracker updates for their internal quest block titles
      hooksecurefunc(CampaignQuestObjectiveTracker, "Update", function(self)
         ProcessTrackerBlockUpdates(self);
      end);
      hooksecurefunc(WorldQuestObjectiveTracker, "Update", function(self)
         ProcessTrackerBlockUpdates(self);
      end);
      hooksecurefunc(BonusObjectiveTracker, "Update", function(self)
         ProcessTrackerBlockUpdates(self);
      end);
      hooksecurefunc(MonthlyActivitiesObjectiveTracker, "Update", function(self)
         ProcessTrackerBlockUpdates(self);
      end);
      -- Scenario tracker might also use Update for its internal blocks if it ever shows multiple scenarios
      hooksecurefunc(ScenarioObjectiveTracker, "Update", function(self)
         ProcessTrackerBlockUpdates(self);
      end);

      -- Hook the MAIN ObjectiveTrackerFrame's Update function
      -- This runs frequently and is a good place to ensure the CATEGORY HEADERS are correct.
      hooksecurefunc(ObjectiveTrackerFrame, "Update", function(self)
         -- 1. Update the main category headers ("Quests", "Scenario", "World Quests", etc.)
         --    This will re-apply the translation AFTER potential Blizzard resets.
         QTR_ObjectiveTrackerFrame_Titles();
      end);

      -- Ensure the hook for QTR_QuestScrollFrame_OnShow remains if you still need it for the map scroll frame
      WorldMapFrame:HookScript("OnShow", function()
         if (not WOWTR_wait(0.2, QTR_QuestScrollFrame_OnShow)) then
            -- opóźnienie 0.2 sek
         end
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
         ST_CheckAndReplaceTranslationText(QuestScrollFrameText01, true, "ui"); -- https://imgur.com/4joWH6I
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
   if ClassicQuestLogPlugin and ClassicQuestLogPlugin.isClassicQuestLog then
      return ClassicQuestLogPlugin.isClassicQuestLog()
   end
   return false
end

-------------------------------------------------------------------------------------------------------------------

function isImmersion()
   if ImmersionPlugin and ImmersionPlugin.isImmersion then
      return ImmersionPlugin.isImmersion()
   end
   return false
end
   
-------------------------------------------------------------------------------------------------------------------

function isStoryline()
   if StorylinePlugin and StorylinePlugin.isStoryline then
      return StorylinePlugin.isStoryline()
   end
   return false
end

-------------------------------------------------------------------------------------------------------------------

-- Określa aktualny numer ID questu z różnych metod
function QTR_GetQuestID()
   local quest_ID;
   
   if (QuestFrame:IsVisible() or isStoryline() or isImmersion() or IsDUIQuestFrame()) then
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

--objectiveSpecials = {
--   ClickComplete = function(fontString)
--      fontString:SetText("("..QTR_ReverseIfAR(WoWTR_Localization.clickToComplete)..")");   -- (click to complete),  może: QTR_ExpandUnitInfo ?
--      fontString:SetFont(WOWTR_Font2, 13);   
--   end,
--   Failed = function(fontString)
--      fontString:SetText(QTR_ReverseIfAR(WoWTR_Localization.failed));                      -- failed,  może: QTR_ExpandUnitInfo ?
--   end,
--   QuestComplete = function(fontString, questID)
--      if ((fontString:GetText() == QUEST_WATCH_QUEST_READY) or (fontString:GetText() == "Ready for turn-in")) then
--         fontString:SetText(QTR_ReverseIfAR(WoWTR_Localization.readyForTurnIn));           -- Ready for turn-in,  może: QTR_ExpandUnitInfo ?
--      else
--         if (QTR_quest_EN[questID] and QTR_quest_EN[questID].objectives) then
--            local obj = QTR_quest_EN[questID].objectives;
--            local obj1= strsplit("\n\n", obj);
--            if (QTR_QuestData[tostring(questID)] and (fontString:GetText() == obj1)) then
--               obj = QTR_ExpandUnitInfo(QTR_QuestData[tostring(questID)]["Objectives"],true,fontString,WOWTR_Font2);
--               obj1= strsplit("\n\n", obj);
--               fontString:SetText(QTR_ReverseIfAR(obj1));      -- może: QTR_ExpandUnitInfo ?
--               fontString:SetFont(WOWTR_Font2, 12);
--               QTR_ResizeBlock(fontString);
--            elseif (string.find(fontString:GetText(),NONBREAKINGSPACE) == nil) then   -- nie jest to przetłumaczony tekst
--               local qtr_obj = fontString:GetText();
--                for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online) do
--                  qtr_obj = string.gsub(qtr_obj, qtr_en, qtr_pl);
--               end
--               fontString:SetText(QTR_ReverseIfAR(qtr_obj)..NONBREAKINGSPACE);         -- może: QTR_ExpandUnitInfo ?
--               fontString:SetFont(WOWTR_Font2, 12);
--               QTR_ResizeBlock(fontString);
--            end
--            elseif (string.find(fontString:GetText(),NONBREAKINGSPACE) == nil) then   -- nie jest to przetłumaczony tekst
--               local qtr_obj = fontString:GetText();
--               for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online) do
--                  qtr_obj = string.gsub(qtr_obj, qtr_en, qtr_pl);
--               end
--            end
--            fontString:SetText((qtr_obj)..NONBREAKINGSPACE);            -- może: QTR_ExpandUnitInfo ?
--            fontString:SetFont(WOWTR_Font2, 12);
--            QTR_ResizeBlock(fontString);
--         end
--      end
--   end,
--   Waypoint = function(fontString, questID)
--      local waypointText = C_QuestLog.GetNextWaypointText(questID);
--      if (waypointText) then
--         fontString:SetText(("0/1 %s ("..QTR_ReverseIfAR(WoWTR_Localization.optional)..")"):format(waypointText));    -- 0/1 %s (Optional)
--         fontString:SetFont(WOWTR_Font2, 12);   
--      end
--   end
--}

-------------------------------------------------------------------------------------------------------------------

--function QTR_ObjectiveTracker_Check()
--   if ( QTR_PS["active"]=="1" and QTR_PS["tracker"]=="1" ) then   -- tłumaczenia włączone
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
--   end
--end

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
          ScenarioObjectiveTracker.Header.Text:SetText(QTR_ReverseIfAR(WoWTR_Localization.scenariodung));
          ScenarioObjectiveTracker.Header.Text:SetFont(WOWTR_Font2, 14);

			if (WoWTR_Localization.lang == 'AR') then
			 --Added New Translation Campaign and Scenario for Arabic only
			 ObjectiveTrackerFrame.Header.Text:SetFont(WOWTR_Font1, 14);
			 QuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font1, 14);
			 WorldQuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font1, 14);
			 CampaignQuestObjectiveTracker.Header.Text:SetFont(WOWTR_Font1, 14);
			 BonusObjectiveTracker.Header.Text:SetFont(WOWTR_Font1, 14);
			 MonthlyActivitiesObjectiveTracker.Header.Text:SetFont(WOWTR_Font1, 14);
          ScenarioObjectiveTracker.Header.Text:SetFont(WOWTR_Font1, 14);
			 --Make LEFT
			 ObjectiveTrackerFrame.Header.Text:SetJustifyH("LEFT");
			 QuestObjectiveTracker.Header.Text:SetJustifyH("LEFT");
			 WorldQuestObjectiveTracker.Header.Text:SetJustifyH("LEFT");
			 CampaignQuestObjectiveTracker.Header.Text:SetJustifyH("LEFT");
          BonusObjectiveTracker.Header.Text:SetJustifyH("LEFT");
          MonthlyActivitiesObjectiveTracker.Header.Text:SetJustifyH("LEFT");
          ScenarioObjectiveTracker.Header.Text:SetJustifyH("LEFT");
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
   -- Exit early if translations are disabled
   if not (QTR_PS["active"] == "1" and QTR_PS["tracker"] == "1") then
       return
   end

   local isArabic = (WoWTR_Localization.lang == 'AR')
   local defaultJustification = "LEFT"
   local arabicJustification = "RIGHT"

   -- Helper function to apply text, font, and justification
   local function ApplyFormatting(element, textToSet, fontToSet, size, justification)
       local oldH = element:GetHeight();
       element:SetText(textToSet);
       element:SetFont(fontToSet, size);
       element:SetJustifyH(justification);
       element:SetHeight(oldH);
   end

   -- 1. Process Quest Titles
   for button in QuestScrollFrame.titleFramePool:EnumerateActive() do
       local questID = button.questID
       local str_ID = tostring(questID)
       local textElement = button.Text
       local originalFont, originalSize, _ = textElement:GetFont() -- Store original font/size

       local textToSet = nil -- Default to no change initially
       local fontToSet = originalFont
       local justification = defaultJustification
       local applyReversal = false

       -- Check for valid translation from QTR_QuestData
       local hasQuestDataTranslation = (QTR_QuestData and QTR_QuestData[str_ID] and QTR_QuestData[str_ID]["Title"])

       if QTR_PS["transtitle"] == "1" and hasQuestDataTranslation then
           textToSet = QTR_QuestData[str_ID]["Title"]
           fontToSet = WOWTR_Font2
           justification = isArabic and arabicJustification or defaultJustification
           applyReversal = isArabic -- Titles from QuestData are reversed if Arabic
       end

       -- Apply reversal if needed
       if applyReversal and textToSet then
           -- Using QTR_ExpandUnitInfo as per your last version for potential better code handling
           textToSet = QTR_ExpandUnitInfo(textToSet, false, textElement, fontToSet, -5)
       end

       -- Apply formatting (only sets text if textToSet is not nil, otherwise uses original)
       ApplyFormatting(textElement, textToSet or textElement:GetText(), fontToSet, originalSize, justification)
   end

   -- 2. Process Objective Summaries
   for frame in QuestScrollFrame.objectiveFramePool:EnumerateActive() do
       local questID = frame.questID
       local str_ID = tostring(questID)
       local textElement = frame.Text
       local originalText = textElement:GetText()
       local originalFont, originalSize, _ = textElement:GetFont() -- Store original font/size

       local textToSet = nil -- Default to no change
       local fontToSet = originalFont
       local justification = defaultJustification
       local translationSourceIsQuestData = false
       local applyTranslationFormatting = false -- Should we use WOWTR_Font2?

       -- Determine the translated text based on objective type
       if (strfind(originalText, "/") and strfind(originalText, "/") > 0) then
           -- A: Progress Objective - No reversal, potential fallback for words
           local tempText = originalText
           for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online or {}) do
               tempText = string.gsub(tempText, qtr_en, qtr_pl)
           end
           if tempText ~= originalText then
               textToSet = tempText
               applyTranslationFormatting = true
           end
       elseif ((originalText == QUEST_WATCH_QUEST_READY) or (originalText == "Ready for turn-in")) then
           -- B: Ready for turn-in - Use constant, no reversal usually needed
           textToSet = QTR_ExpandUnitInfo(WoWTR_Localization.readyForTurnIn, false, textElement, WOWTR_Font2, -5)
           applyTranslationFormatting = true
       else
           -- C: Standard Text Objective - Check QuestData first, then fallback
           if QTR_QuestData and QTR_QuestData[str_ID] and QTR_QuestData[str_ID]["Objectives"] then
               textToSet = QTR_QuestData[str_ID]["Objectives"]
               translationSourceIsQuestData = true
               applyTranslationFormatting = true
           else
               -- Fallback only if QuestData didn't provide text
               local tempText = originalText
               for qtr_en, qtr_pl in pairsByKeys(QTR_Tlumacz_Online or {}) do
                   tempText = string.gsub(tempText, qtr_en, qtr_pl)
               end
               if tempText ~= originalText then
                   textToSet = tempText
                   applyTranslationFormatting = true
               end
           end
       end

       -- Set font and justification if a translation was applied
       if applyTranslationFormatting then
            fontToSet = WOWTR_Font2
            justification = isArabic and arabicJustification or defaultJustification
       end

       -- Process the final text (cleaning, reversal) if translation exists
       if textToSet then
           -- Clean line breaks for summary view
           local cleanedText = string.gsub(textToSet, "\r", "")
           cleanedText = string.gsub(cleanedText, "\n", " ")
           cleanedText = string.gsub(cleanedText, "$B", " ")

           local finalText = cleanedText

           -- Apply reversal ONLY if source was QTR_QuestData and language is AR
           if translationSourceIsQuestData and isArabic then
                finalText = QTR_ExpandUnitInfo(cleanedText, false, textElement, fontToSet, -5)
           end
           -- Apply the potentially modified text
           ApplyFormatting(textElement, finalText, fontToSet, originalSize, justification)
       else
           -- No translation applied, ensure original formatting
           ApplyFormatting(textElement, originalText, originalFont, originalSize, defaultJustification)
       end
   end

   -- 3. Update Story Header (if applicable)
   QTR_QuestScrollFrame_OnShow()
end

-------------------------------------------------------------------------------------------------------------------

-- Otworzono okienko QuestLogPopupDetailFrame lub QuestMapDetailsScrollFrame lub ClassicQuestLog lub Immersion
function QTR_QuestPrepare(zdarzenie)
   --print("QTR_QuestPrepare");
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
--   if (IsDUIQuestFrame()) then
--      QTR_ToggleButton6:Hide();     -- przycisk w ramce DUIQuestFrame (gossip)
--   end
   
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
         if (QTR_ModelText and (string.find(QTR_ModelText,NONBREAKINGSPACE) == nil)) then   -- nie jest to turecki tekst (twarda spacja)
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
      if (IsDUIQuestFrame()) then
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
         QTR_ToggleButton0:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
         QTR_ToggleButton1:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
         QTR_ToggleButton2:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
--         if (isClassicQuestLog()) then
--            QTR_ToggleButton3:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
--            QTR_ToggleButton3:Enable();
--         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
         end
         if (isStoryline() and Storyline_NPCFrame:IsVisible()) then
            QTR_ToggleButton5:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
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
         QTR_ToggleButton0:SetText("QID="..str_ID);
         QTR_ToggleButton1:SetText("QID="..str_ID);
         QTR_ToggleButton2:SetText("QID="..str_ID);
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("QID="..str_ID);
         end
         if (isImmersion()) then
            QTR_ToggleButton4:Disable();
            if (q_ID==0) then
               if (ImmersionFrame.TitleButtons:IsVisible()) then
                  QTR_ToggleButton4:SetText(QTR_ReverseIfAR(WoWTR_Localization.choiceQuestFirst));
               end
            else
               QTR_ToggleButton4:SetText("QID="..str_ID);
            end
         end
         if (isStoryline()) then
            QTR_ToggleButton5:Disable();
            QTR_ToggleButton5:SetText("QID="..str_ID);
         end
         if (IsDUIQuestFrame()) then
            QTR_ToggleButton6:Hide();     -- przycisk w ramce DUIQuestFrame (gossip)
            QTR_ToggleButton7:Disable();
            QTR_ToggleButton7:SetText("QID="..str_ID);
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
         QTR_ToggleButton1:SetText("QID="..str_ID.." (EN)");
         QTR_ToggleButton2:SetText("QID="..str_ID.." (EN)");
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("QID="..str_ID.." (EN)");
         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("QID="..str_ID.." (EN)");
         end
         if (isStoryline()) then
            QTR_ToggleButton5:SetText("QID="..str_ID.." (EN)");
         end
      else
         QTR_ToggleButton1:SetText("QID="..str_ID);
         QTR_ToggleButton2:SetText("QID="..str_ID);
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("QID="..str_ID);
         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("QID="..str_ID);
         end
         if (isStoryline()) then
            QTR_ToggleButton5:SetText("QID="..str_ID);
         end
         if (IsDUIQuestFrame()) then
            QTR_ToggleButton7:SetText("QID="..str_ID);
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

      local QuestMFrame05 = QuestMapFrame.QuestsFrame.DetailsFrame.BackFrame.AccountCompletedNotice.Text;
      ST_CheckAndReplaceTranslationTextUI(QuestMFrame05, true, "ui");
   end
end

-------------------------------------------------------------------------------------------------------------------

-- wyświetla tłumaczenie
function QTR_Translate_On(typ,event)
   --print("QTR_Translate_On");
   QTR_display_constants(1);
   if (QuestNPCModelText:IsVisible() and (QTR_ModelTextHash>0)) then         -- jest wyświetlony tekst QuestNPCModelText
      QuestNPCModelText:SetText(QTR_ExpandUnitInfo(QTR_ModelText_PL..NONBREAKINGSPACE,false,QuestNPCModelText,WOWTR_Font2,-15));   -- na końcu dodajemy "twardą" spację
      QuestNPCModelText:SetFont(WOWTR_Font2, 13);
   end
   
   if (typ==1) then        -- pełne przełączenie (jest tłumaczenie)
      local numer_ID = QTR_quest_ID;
      str_ID = tostring(numer_ID);
      if (numer_ID>0 and QTR_QuestData[str_ID]) then	-- przywróć przetłumaczoną wersję napisów
         QTR_ToggleButton0:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
         QTR_ToggleButton1:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
         QTR_ToggleButton2:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
            if (not WOWTR_wait(0.2,QTR_Immersion)) then    -- wywołaj podmienianie danych po 0.2 sek
               -- opóźnienie 0.2 sek
            end
         end
         if (isStoryline() and Storyline_NPCFrame:IsVisible()) then
            QTR_ToggleButton5:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
            QTR_Storyline(1);
         end
         if (IsDUIQuestFrame()) then
            QTR_ToggleButton7:SetText("QID="..QTR_quest_ID.." ("..QTR_lang..")");
            QTR_ToggleButton7:Enable();
         end

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
               if (WoWTR_Localization.lang == 'AR') then
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50, "RIGHT"));
               else
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50));
               end
            else 
               if (WoWTR_Localization.lang == 'AR') then
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50, "RIGHT"));
               else
                  QuestInfoTitleHeader:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestInfoTitleHeader, WOWTR_Font1, -50));
               end
            end
            if (WoWTR_Localization.lang == 'AR') then
               QuestProgressTitleText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestProgressTitleText, WOWTR_Font1, -50, "RIGHT"));
            else
               QuestProgressTitleText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].title, false, QuestProgressTitleText, WOWTR_Font1, -50));
            end
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
         if (WoWTR_Localization.lang == 'AR') then
            QuestInfoRewardText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].completion,false,QuestInfoRewardText,WOWTR_Font2,-5,"RIGHT"));
         else
            QuestInfoRewardText:SetText(QTR_ExpandUnitInfo(QTR_quest_LG[QTR_quest_ID].completion,false,QuestInfoRewardText,WOWTR_Font2,-5));
         end
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
      if (IsDUIQuestFrame()) then
         QTR_DUIQuestFrame(event);
         if ( QTR_PS["en_first"]=="1" ) then   -- switch to english
            DUI_ON_OFF();
         end
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
   --print("QTR_Translate_Off");
   QTR_display_constants(0);
   if (QuestNPCModelText:IsVisible() and (QTR_ModelTextHash>0)) then
      QuestNPCModelText:SetText(QTR_ModelText_EN);
      QuestNPCModelText:SetFont(Original_Font2, 13);
   end
   
   if (typ==1) then
      local numer_ID = QTR_quest_ID;
      str_ID = tostring(numer_ID);
      if (numer_ID>0 and QTR_QuestData[str_ID]) then
         QTR_ToggleButton0:SetText("QID="..QTR_quest_ID.." (EN)");
         QTR_ToggleButton1:SetText("QID="..QTR_quest_ID.." (EN)");
         QTR_ToggleButton2:SetText("QID="..QTR_quest_ID.." (EN)");
         if (isClassicQuestLog()) then
            QTR_ToggleButton3:SetText("QID="..QTR_quest_ID.." (EN)");
         end
         if (isImmersion()) then
            QTR_ToggleButton4:SetText("QID="..QTR_quest_ID.." (EN)");
            QTR_Immersion_OFF();
            ImmersionFrame.TalkBox.TextFrame.Text:RepeatTexts();
         end
         if (isStoryline() and Storyline_NPCFrame:IsVisible()) then
            QTR_ToggleButton5:SetText("QID="..QTR_quest_ID.." (EN)");
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
         QuestInfoRewardText:SetJustifyH("LEFT");
         QuestInfoTitleHeader:SetJustifyH("LEFT");
         QuestProgressTitleText:SetJustifyH("LEFT");

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
   --print("QTR_display_constants");
   -- Get current quest ID info, but don't block constants based on it initially
   local str_ID = QTR_quest_ID and tostring(QTR_quest_ID) or nil;
   local questDataExists = str_ID and QTR_QuestData and QTR_QuestData[str_ID];
   local questLGData = questDataExists and QTR_quest_LG and QTR_quest_LG[QTR_quest_ID];

   if lg == 1 then -- Apply Translations
   --print("Apply Translations lg 1");
        local isArabic = (WoWTR_Localization.lang == 'AR');
        local WOW_width = 265;
        if (WorldMapFrame:IsVisible()) then
           WOW_width = 245;
        end

        -- === Apply Translations to CONSTANT Headers (These run whenever lg == 1) ===
        local elvuiFontSize = C_AddOns.IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.fonts.questtext.enable and ElvUI[1].db.general.fonts.questtitle.size or 18;

        QuestInfoObjectivesHeader:SetWidth(WOW_width+10);
        QuestInfoObjectivesHeader:SetFont(WOWTR_Font1, elvuiFontSize);
        QuestInfoObjectivesHeader:SetText(QTR_ExpandUnitInfo(QTR_Messages.objectives,false,QuestInfoObjectivesHeader,WOWTR_Font1,-10));
        if isArabic then QuestInfoObjectivesHeader:SetJustifyH("RIGHT") else QuestInfoObjectivesHeader:SetJustifyH("LEFT") end;

        QuestInfoDescriptionHeader:SetWidth(WOW_width+40);
        QuestInfoDescriptionHeader:SetFont(WOWTR_Font1, elvuiFontSize);
        QuestInfoDescriptionHeader:SetText(QTR_ExpandUnitInfo(QTR_Messages.details,false,QuestInfoDescriptionHeader,WOWTR_Font1,-10));
        if isArabic then QuestInfoDescriptionHeader:SetJustifyH("RIGHT") else QuestInfoDescriptionHeader:SetJustifyH("LEFT") end;

        QuestInfoRewardsFrame.Header:SetWidth(WOW_width+10);
        QuestInfoRewardsFrame.Header:SetFont(WOWTR_Font1, elvuiFontSize);
        QuestInfoRewardsFrame.Header:SetText(QTR_ExpandUnitInfo(QTR_Messages.rewards,false,QuestInfoRewardsFrame.Header,WOWTR_Font1,-12));
        if isArabic then QuestInfoRewardsFrame.Header:SetJustifyH("RIGHT") else QuestInfoRewardsFrame.Header:SetJustifyH("LEFT") end;

        QuestProgressRequiredItemsText:SetWidth(WOW_width+7);
        QuestProgressRequiredItemsText:SetFont(WOWTR_Font1, elvuiFontSize);
        QuestProgressRequiredItemsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.reqitems,false,QuestProgressRequiredItemsText,WOWTR_Font1,-10));
        if isArabic then QuestProgressRequiredItemsText:SetJustifyH("RIGHT") else QuestProgressRequiredItemsText:SetJustifyH("LEFT") end;

        CurrentQuestsText:SetFont(WOWTR_Font1, elvuiFontSize);
        CurrentQuestsText:SetWidth(WOW_width);
        CurrentQuestsText:SetText(QTR_ExpandUnitInfo(QTR_Messages.currquests,false,CurrentQuestsText,WOWTR_Font1,-30));
        if isArabic then CurrentQuestsText:SetJustifyH("RIGHT") else CurrentQuestsText:SetJustifyH("LEFT") end;

        AvailableQuestsText:SetFont(WOWTR_Font1, elvuiFontSize);
        AvailableQuestsText:SetText(QTR_ReverseIfAR(QTR_Messages.avaiquests));
        AvailableQuestsText:SetWidth(WOW_width);
        if isArabic then AvailableQuestsText:SetJustifyH("RIGHT") else AvailableQuestsText:SetJustifyH("LEFT") end;

        -- Quest Map Frame Rewards Header (Check if frame exists)
        local rewardsFrame = QuestMapFrame.DetailsFrame.RewardsFrameContainer and QuestMapFrame.DetailsFrame.RewardsFrameContainer.RewardsFrame;
        if rewardsFrame then
            local regions = { rewardsFrame:GetRegions() };
            for index = 1, #regions do
               local region = regions[index];
               -- Check text using the Blizzard constant for reliability when applying translation
               if ((region:GetObjectType() == "FontString") and (region:GetText() == QUEST_REWARDS)) then
                  region:SetText(QTR_ReverseIfAR(QTR_Messages.rewards));
                  region:SetFont(WOWTR_Font1, 18);
                  if isArabic then region:SetJustifyH("RIGHT") else region:SetJustifyH("LEFT") end;
               end
            end
        end

        -- === Apply Translations DEPENDENT on Specific Quest Data (Only if data exists) ===
        if questDataExists and questLGData then
            --print("Apply Translations There is Quest Data");
            local itemChooseText = questLGData.itemchoose or QTR_Messages.itemchoose0;
            local itemReceiveText = questLGData.itemreceive or QTR_Messages.itemreceiv0;

            if isArabic then
               -- Handle AR-specific item/xp text and custom elements
               QuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 14);
               QuestInfoRewardsFrame.ItemChooseText:SetWidth(260);
               QuestInfoRewardsFrame.ItemChooseText:SetJustifyH("RIGHT");
               QuestInfoRewardsFrame.ItemChooseText:SetText(AS_UTF8reverse(itemChooseText));

               QuestInfoRewardsFrame.ItemReceiveText:SetText(" ");
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(" ");
               QuestInfoXPFrame.ReceiveText:SetText(" ");

               -- Create/Update custom AR elements
               if (not QTR_QuestDetail_ItemReceiveText) then
                  QTR_QuestDetail_ItemReceiveText = QuestDetailScrollChildFrame:CreateFontString(nil, "ARTWORK");
                  QTR_QuestDetail_ItemReceiveText:SetFontObject(GameFontBlack);
                  QTR_QuestDetail_ItemReceiveText:SetJustifyH("RIGHT");
                  QTR_QuestDetail_ItemReceiveText:SetJustifyV("TOP");
                  QTR_QuestDetail_ItemReceiveText:ClearAllPoints();
                  QTR_QuestDetail_ItemReceiveText:SetPoint("TOPRIGHT", QuestInfoRewardsFrame.ItemReceiveText, "TOPLEFT", 260, 2);
                  QTR_QuestDetail_ItemReceiveText:SetFont(WOWTR_Font2, 13);
               end
               QTR_QuestDetail_ItemReceiveText:SetText(AS_UTF8reverse(itemReceiveText));
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
               QTR_QuestReward_ItemReceiveText:SetText(AS_UTF8reverse(itemReceiveText));
               QTR_QuestReward_ItemReceiveText:Show();

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
               QTR_QuestReward_InfoXP:Show();

               -- Add MoneyFrame positioning for Arabic UI
               if (QuestInfoMoneyFrame:IsVisible()) then
                  QuestInfoXPFrame.ValueText:ClearAllPoints();
                  QuestInfoXPFrame.ValueText:SetPoint("TOPRIGHT", QuestInfoMoneyFrame, "BOTTOMRIGHT", -10, 0);
               end

               -- Handle space calculation (complete logic from original)
               local max_len = AS_UTF8len(QTR_QuestDetail_ItemReceiveText:GetText());
               local money_len = QuestInfoMoneyFrame:GetWidth();
               local spaces05 = "     ";
               local spaces10 = "          ";
               local spaces15 = "               ";
               local spaces20 = "                    ";
               
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

               -- Handle other AR specific elements (LearnLabel, MapRewards, PlayerTitle, BonusReward)
               QuestInfoSpellObjectiveLearnLabel:SetFont(WOWTR_Font2, 13);
               QuestInfoSpellObjectiveLearnLabel:SetJustifyH("RIGHT");
               QuestInfoSpellObjectiveLearnLabel:SetText(AS_UTF8reverse(QTR_Messages.learnspell));
               
               MapQuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 16);
               local line_size = MapQuestInfoRewardsFrame.ItemChooseText:GetWidth();
               MapQuestInfoRewardsFrame.ItemChooseText:SetJustifyH("RIGHT");
               MapQuestInfoRewardsFrame.ItemChooseText:SetText(AS_UTF8reverse(itemChooseText));
               MapQuestInfoRewardsFrame.ItemReceiveText:SetFont(WOWTR_Font2, 13);
               MapQuestInfoRewardsFrame.ItemReceiveText:SetWidth(line_size);
               MapQuestInfoRewardsFrame.ItemReceiveText:SetJustifyH("RIGHT");
               MapQuestInfoRewardsFrame.ItemReceiveText:SetText(AS_UTF8reverse(itemReceiveText));

               QuestInfoRewardsFrame.PlayerTitleText:SetFont(WOWTR_Font2, 13);
               QuestInfoRewardsFrame.PlayerTitleText:SetJustifyH("RIGHT");
               QuestInfoRewardsFrame.PlayerTitleText:SetText(AS_UTF8reverse(QTR_Messages.reward_title));

               QuestInfoRewardsFrame.QuestSessionBonusReward:SetFont(WOWTR_Font2, 13);
               QuestInfoRewardsFrame.QuestSessionBonusReward:SetJustifyH("RIGHT");
               QuestInfoRewardsFrame.QuestSessionBonusReward:SetText(AS_UTF8reverse(QTR_Messages.reward_bonus));

               -- Handle spell header pools (AR)
               if (QuestInfoRewardsFrame:IsVisible()) then
                  for fontString in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do 
                     local text = fontString:GetText(); 
                     local translatedText = nil; 
                     if text == REWARD_AURA then translatedText = QTR_Messages.reward_aura 
                     elseif text == REWARD_SPELL then translatedText = QTR_Messages.reward_spell 
                     elseif text == REWARD_COMPANION then translatedText = QTR_Messages.reward_companion 
                     elseif text == REWARD_FOLLOWER then translatedText = QTR_Messages.reward_follower 
                     elseif text == REWARD_REPUTATION then translatedText = QTR_Messages.reward_reputation 
                     elseif text == REWARD_TITLE then translatedText = QTR_Messages.reward_title 
                     elseif text == REWARD_TRADESKILL then translatedText = QTR_Messages.reward_tradeskill 
                     elseif text == "This quest line is part of unlocking:" then translatedText = QTR_Messages.reward_unlock 
                     elseif text == "You will unlock access to the following:" then translatedText = QTR_Messages.reward_unlock 
                     elseif text == REWARD_BONUS then translatedText = QTR_Messages.reward_bonus 
                     end 
                     if translatedText then 
                        fontString:SetFont(WOWTR_Font2, 13); 
                        fontString:SetJustifyH("RIGHT"); 
                        fontString:SetText(AS_UTF8reverse(translatedText)); 
                        if text == "This quest line is part of unlocking:" or text == "You will unlock access to the following:" then 
                           fontString:SetWidth(260); 
                        end 
                     end 
                  end
               end
               if (MapQuestInfoRewardsFrame:IsVisible()) then
                  for fontString in MapQuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do 
                     local text = fontString:GetText(); 
                     local translatedText = nil; 
                     local fontSize = (text == "This quest line is part of unlocking:") and 11 or 13;
                     if text == REWARD_AURA then translatedText = QTR_Messages.reward_aura 
                     elseif text == REWARD_SPELL then translatedText = QTR_Messages.reward_spell 
                     elseif text == REWARD_COMPANION then translatedText = QTR_Messages.reward_companion 
                     elseif text == REWARD_FOLLOWER then translatedText = QTR_Messages.reward_follower 
                     elseif text == REWARD_REPUTATION then translatedText = QTR_Messages.reward_reputation 
                     elseif text == REWARD_TITLE then translatedText = QTR_Messages.reward_title 
                     elseif text == REWARD_TRADESKILL then translatedText = QTR_Messages.reward_tradeskill 
                     elseif text == "This quest line is part of unlocking:" then translatedText = QTR_Messages.reward_unlock
                     elseif text == "You will unlock access to the following:" then translatedText = QTR_Messages.reward_unlock 
                     elseif text == REWARD_BONUS then translatedText = QTR_Messages.reward_bonus 
                     end 
                     if translatedText then 
                        fontString:SetFont(WOWTR_Font2, fontSize); 
                        fontString:SetJustifyH("RIGHT"); 
                        fontString:SetText(AS_UTF8reverse(translatedText)); 
                        if text == "This quest line is part of unlocking:" or text == "You will unlock access to the following:" then 
                           fontString:SetWidth(260);
                        end
                     end 
                  end
               end

            else -- LTR Languages
               -- Handle LTR item/xp text
               QuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 13);
               QuestInfoRewardsFrame.ItemReceiveText:SetFont(WOWTR_Font2, 13);
               QuestInfoRewardsFrame.ItemChooseText:SetText(itemChooseText);
               QuestInfoRewardsFrame.ItemReceiveText:SetText(itemReceiveText);
               QuestInfoRewardsFrame.ItemChooseText:SetJustifyH("LEFT");
               QuestInfoRewardsFrame.ItemReceiveText:SetJustifyH("LEFT");

               QuestInfoSpellObjectiveLearnLabel:SetFont(WOWTR_Font2, 13);
               QuestInfoSpellObjectiveLearnLabel:SetText(QTR_Messages.learnspell);
               QuestInfoSpellObjectiveLearnLabel:SetJustifyH("LEFT");

               QuestInfoXPFrame.ReceiveText:SetFont(WOWTR_Font2, 13);
               QuestInfoXPFrame.ReceiveText:SetText(QTR_Messages.experience);
               QuestInfoXPFrame.ReceiveText:SetJustifyH("LEFT");

               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetFont(WOWTR_Font2, 13);
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(QTR_Messages.experience);
               QuestInfoRewardsFrame.XPFrame.ReceiveText:SetJustifyH("LEFT");

               MapQuestInfoRewardsFrame.ItemChooseText:SetFont(WOWTR_Font2, 13);
               MapQuestInfoRewardsFrame.ItemReceiveText:SetFont(WOWTR_Font2, 13);
               MapQuestInfoRewardsFrame.ItemChooseText:SetText(itemChooseText);
               MapQuestInfoRewardsFrame.ItemReceiveText:SetText(itemReceiveText);
               MapQuestInfoRewardsFrame.ItemChooseText:SetJustifyH("LEFT");
               MapQuestInfoRewardsFrame.ItemReceiveText:SetJustifyH("LEFT");

               QuestInfoRewardsFrame.PlayerTitleText:SetFont(WOWTR_Font2, 13);
               QuestInfoRewardsFrame.PlayerTitleText:SetText(QTR_Messages.reward_title);
               QuestInfoRewardsFrame.PlayerTitleText:SetJustifyH("LEFT");

               QuestInfoRewardsFrame.QuestSessionBonusReward:SetFont(WOWTR_Font2, 13);
               QuestInfoRewardsFrame.QuestSessionBonusReward:SetText(QTR_Messages.reward_bonus);
               QuestInfoRewardsFrame.QuestSessionBonusReward:SetJustifyH("LEFT");

               -- Handle spell header pools (LTR)
               if (QuestInfoRewardsFrame:IsVisible()) then
                  for fontString in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do 
                     local text = fontString:GetText(); 
                     local translatedText = nil; 
                     if text == REWARD_AURA then translatedText = QTR_Messages.reward_aura 
                     elseif text == REWARD_SPELL then translatedText = QTR_Messages.reward_spell 
                     elseif text == REWARD_COMPANION then translatedText = QTR_Messages.reward_companion 
                     elseif text == REWARD_FOLLOWER then translatedText = QTR_Messages.reward_follower 
                     elseif text == REWARD_REPUTATION then translatedText = QTR_Messages.reward_reputation 
                     elseif text == REWARD_TITLE then translatedText = QTR_Messages.reward_title 
                     elseif text == REWARD_TRADESKILL then translatedText = QTR_Messages.reward_tradeskill 
                     elseif text == "This quest line is part of unlocking:" then translatedText = QTR_Messages.reward_unlock 
                     elseif text == "You will unlock access to the following:" then translatedText = QTR_Messages.reward_unlock 
                     elseif text == REWARD_BONUS then translatedText = QTR_Messages.reward_bonus 
                     end 
                     if translatedText then 
                        fontString:SetText(translatedText); 
                        fontString:SetFont(WOWTR_Font2, 13); 
                        fontString:SetJustifyH("LEFT"); 
                     end 
                  end
               end
               if (MapQuestInfoRewardsFrame:IsVisible()) then
                  for fontString in MapQuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do 
                     local text = fontString:GetText(); 
                     local translatedText = nil; 
                     local fontSize = 11; 
                     if text == REWARD_AURA then translatedText = QTR_Messages.reward_aura 
                     elseif text == REWARD_SPELL then translatedText = QTR_Messages.reward_spell 
                     elseif text == REWARD_COMPANION then translatedText = QTR_Messages.reward_companion 
                     elseif text == REWARD_FOLLOWER then translatedText = QTR_Messages.reward_follower 
                     elseif text == REWARD_REPUTATION then translatedText = QTR_Messages.reward_reputation 
                     elseif text == REWARD_TITLE then translatedText = QTR_Messages.reward_title 
                     elseif text == REWARD_TRADESKILL then translatedText = QTR_Messages.reward_tradeskill 
                     elseif text == "This quest line is part of unlocking:" then translatedText = QTR_Messages.reward_unlock 
                     elseif text == "You will unlock access to the following:" then translatedText = QTR_Messages.reward_unlock 
                     elseif text == REWARD_BONUS then translatedText = QTR_Messages.reward_bonus 
                     end 
                     if translatedText then 
                        fontString:SetText(translatedText); 
                        fontString:SetFont(WOWTR_Font2, fontSize); 
                        fontString:SetJustifyH("LEFT"); 
                     end 
                  end
               end
            end
        end -- End of check for questDataExists and questLGData

   else -- Apply Originals (lg == 0)
      --print("Apply Originals lg 0");
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
   QuestInfoRewardsFrame.Header:SetJustifyH("LEFT")
   QuestInfoRewardsFrame.Header:SetFont(Original_Font1, 18);

   QuestProgressRequiredItemsText:SetText(QTR_MessOrig.reqitems);
   QuestProgressRequiredItemsText:SetFont(Original_Font1, 18);
   QuestProgressRequiredItemsText:SetJustifyH("LEFT");

   CurrentQuestsText:SetText(QTR_MessOrig.currquests);
   CurrentQuestsText:SetJustifyH("LEFT");
   CurrentQuestsText:SetFont(Original_Font1, 18);

   AvailableQuestsText:SetText(QTR_MessOrig.avaiquests);
   AvailableQuestsText:SetFont(Original_Font1, 18);
   AvailableQuestsText:SetJustifyH("LEFT");

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
      -- REMOVED THE UNCONDITIONAL HIDE CALLS BELOW
      -- QTR_QuestDetail_ItemReceiveText:Hide(); -- Removed
      -- QTR_QuestReward_ItemReceiveText:Hide(); -- Removed
   end

   -- Reset fonts and text for various quest elements
   QuestInfoRewardsFrame.ItemChooseText:SetFont(Original_Font2, 13);
   QuestInfoRewardsFrame.ItemReceiveText:SetFont(Original_Font2, 13);
   -- Add a check for QTR_quest_EN existence before accessing it
   if QTR_quest_EN and QTR_quest_EN[QTR_quest_ID] then
       QuestInfoRewardsFrame.ItemChooseText:SetText(QTR_quest_EN[QTR_quest_ID].itemchoose or QTR_MessOrig.itemchoose0); -- Added fallback
       QuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_quest_EN[QTR_quest_ID].itemreceive or QTR_MessOrig.itemreceiv0); -- Added fallback
       MapQuestInfoRewardsFrame.ItemChooseText:SetText(QTR_quest_EN[QTR_quest_ID].itemchoose or QTR_MessOrig.itemchoose0); -- Added fallback
       MapQuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_quest_EN[QTR_quest_ID].itemreceive or QTR_MessOrig.itemreceiv0); -- Added fallback
   else
       -- Handle case where QTR_quest_EN doesn't exist for this ID yet (optional, but safer)
       QuestInfoRewardsFrame.ItemChooseText:SetText(QTR_MessOrig.itemchoose0);
       QuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_MessOrig.itemreceiv0);
       MapQuestInfoRewardsFrame.ItemChooseText:SetText(QTR_MessOrig.itemchoose0);
       MapQuestInfoRewardsFrame.ItemReceiveText:SetText(QTR_MessOrig.itemreceiv0);
   end


   QuestInfoSpellObjectiveLearnLabel:SetFont(Original_Font2, 13);
   QuestInfoSpellObjectiveLearnLabel:SetText(QTR_MessOrig.learnspell);

   QuestInfoXPFrame.ReceiveText:SetFont(Original_Font2, 13);
   QuestInfoXPFrame.ReceiveText:SetText(QTR_MessOrig.experience);

   QuestInfoRewardsFrame.XPFrame.ReceiveText:SetFont(Original_Font2, 13);
   QuestInfoRewardsFrame.XPFrame.ReceiveText:SetText(QTR_MessOrig.experience);

   MapQuestInfoRewardsFrame.ItemChooseText:SetFont(Original_Font2, 11);
   MapQuestInfoRewardsFrame.ItemReceiveText:SetFont(Original_Font2, 11);
   -- Text set above with nil checks

   QuestInfoRewardsFrame.PlayerTitleText:SetFont(Original_Font2, 13);
   QuestInfoRewardsFrame.PlayerTitleText:SetText(QTR_MessOrig.reward_title);

   QuestInfoRewardsFrame.QuestSessionBonusReward:SetFont(Original_Font2, 13);
   QuestInfoRewardsFrame.QuestSessionBonusReward:SetText(QTR_MessOrig.reward_bonus);

   -- Ensure AR-specific elements are hidden if they exist (These checks are correct)
   if (QTR_QuestDetail_ItemReceiveText) then
      QTR_QuestDetail_ItemReceiveText:Hide();
   end
   if (QTR_QuestReward_ItemReceiveText) then
      QTR_QuestReward_ItemReceiveText:Hide();
   end
   if (QTR_QuestDetail_InfoXP) then
      QTR_QuestDetail_InfoXP:Hide();
   end
   if (QTR_QuestReward_InfoXP) then
      QTR_QuestReward_InfoXP:Hide();
   end


   if ( QuestInfoRewardsFrame:IsVisible() ) then
      for fontString in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
         local currentText = fontString:GetText()
         local originalTextToSet = nil -- Variable to hold the correct original English text
         local originalFontSize = 13
         local originalFont = Original_Font2

         -- Check against known TRANSLATED texts to determine which ORIGINAL text to revert to
         if WoWTR_Localization.lang == 'AR' then
            -- Compare against the REVERSED Arabic translated strings
            if currentText == AS_UTF8reverse(QTR_Messages.reward_unlock) then
               originalTextToSet = "This quest line is part of unlocking:" -- The actual original text
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_aura) then
               originalTextToSet = REWARD_AURA
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_spell) then
               originalTextToSet = REWARD_SPELL
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_companion) then
               originalTextToSet = REWARD_COMPANION
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_follower) then
               originalTextToSet = REWARD_FOLLOWER
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_reputation) then
               originalTextToSet = REWARD_REPUTATION
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_title) then
               originalTextToSet = REWARD_TITLE
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_tradeskill) then
               originalTextToSet = REWARD_TRADESKILL
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_bonus) then
               originalTextToSet = REWARD_BONUS
            end
         else -- Non-Arabic languages
            -- Compare against the standard translated strings
            if currentText == QTR_Messages.reward_unlock then
               originalTextToSet = "This quest line is part of unlocking:" -- The actual original text
            elseif currentText == QTR_Messages.reward_aura then
               originalTextToSet = REWARD_AURA
            elseif currentText == QTR_Messages.reward_spell then
               originalTextToSet = REWARD_SPELL
            elseif currentText == QTR_Messages.reward_companion then
               originalTextToSet = REWARD_COMPANION
            elseif currentText == QTR_Messages.reward_follower then
               originalTextToSet = REWARD_FOLLOWER
            elseif currentText == QTR_Messages.reward_reputation then
               originalTextToSet = REWARD_REPUTATION
            elseif currentText == QTR_Messages.reward_title then
               originalTextToSet = REWARD_TITLE
            elseif currentText == QTR_Messages.reward_tradeskill then
               originalTextToSet = REWARD_TRADESKILL
            elseif currentText == QTR_Messages.reward_bonus then
               originalTextToSet = REWARD_BONUS
            end
         end

         -- If we identified which original text corresponds to the current translated text, apply the reset
         if originalTextToSet then
            fontString:SetText(originalTextToSet)
            fontString:SetJustifyH("LEFT")
            fontString:SetFont(originalFont, originalFontSize)
         end
      end
   end

   -- Repeat similar logic for the MapQuestInfoRewardsFrame.spellHeaderPool loop
   if ( MapQuestInfoRewardsFrame:IsVisible() ) then
      for fontString in MapQuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
      local currentText = fontString:GetText()
      local originalTextToSet = nil
      local originalFontSize = 11 -- Usually smaller font here for Map frame
      local originalFont = Original_Font2

      -- Check against known TRANSLATED texts
      if WoWTR_Localization.lang == 'AR' then
            -- Compare against the REVERSED Arabic translated strings
            if currentText == AS_UTF8reverse(QTR_Messages.reward_unlock) then
               originalTextToSet = "This quest line is part of unlocking:" -- Specific original text
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_aura) then
               originalTextToSet = REWARD_AURA
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_spell) then
               originalTextToSet = REWARD_SPELL
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_companion) then
               originalTextToSet = REWARD_COMPANION
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_follower) then
               originalTextToSet = REWARD_FOLLOWER
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_reputation) then
               originalTextToSet = REWARD_REPUTATION
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_title) then
               originalTextToSet = REWARD_TITLE
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_tradeskill) then
               originalTextToSet = REWARD_TRADESKILL
            elseif currentText == AS_UTF8reverse(QTR_Messages.reward_bonus) then
               originalTextToSet = REWARD_BONUS
            end
      else -- Non-Arabic languages
            -- Compare against the standard translated strings
            if currentText == QTR_Messages.reward_unlock then
               originalTextToSet = "This quest line is part of unlocking:" -- Specific original text
            elseif currentText == QTR_Messages.reward_aura then
               originalTextToSet = REWARD_AURA
            elseif currentText == QTR_Messages.reward_spell then
               originalTextToSet = REWARD_SPELL
            elseif currentText == QTR_Messages.reward_companion then
               originalTextToSet = REWARD_COMPANION
            elseif currentText == QTR_Messages.reward_follower then
               originalTextToSet = REWARD_FOLLOWER
            elseif currentText == QTR_Messages.reward_reputation then
               originalTextToSet = REWARD_REPUTATION
            elseif currentText == QTR_Messages.reward_title then
               originalTextToSet = REWARD_TITLE
            elseif currentText == QTR_Messages.reward_tradeskill then
               originalTextToSet = REWARD_TRADESKILL
            elseif currentText == QTR_Messages.reward_bonus then
               originalTextToSet = REWARD_BONUS
            end
      end

      -- If we identified which original text corresponds to the current translated text, apply the reset
      if originalTextToSet then
            fontString:SetText(originalTextToSet)
            fontString:SetJustifyH("LEFT")
            fontString:SetFont(originalFont, originalFontSize)
      end
   end
end -- End of MapQuestInfoRewardsFrame:IsVisible
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

function QTR_Immersion(...)
   if ImmersionPlugin and ImmersionPlugin.QTR_Immersion then
      return ImmersionPlugin.QTR_Immersion(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Immersion_Static(...)
   if ImmersionPlugin and ImmersionPlugin.QTR_Immersion_Static then
      return ImmersionPlugin.QTR_Immersion_Static(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Immersion_OFF(...)
   if ImmersionPlugin and ImmersionPlugin.QTR_Immersion_OFF then
      return ImmersionPlugin.QTR_Immersion_OFF(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Immersion_OFF_Static(...)
   if ImmersionPlugin and ImmersionPlugin.QTR_Immersion_OFF_Static then
      return ImmersionPlugin.QTR_Immersion_OFF_Static(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Delay(...)
   if StorylinePlugin and StorylinePlugin.QTR_Storyline_Delay then
      return StorylinePlugin.QTR_Storyline_Delay(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Quest(...)
   if StorylinePlugin and StorylinePlugin.QTR_Storyline_Quest then
      return StorylinePlugin.QTR_Storyline_Quest(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Hide(...)
   if StorylinePlugin and StorylinePlugin.QTR_Storyline_Hide then
      return StorylinePlugin.QTR_Storyline_Hide(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Objectives(...)
   if StorylinePlugin and StorylinePlugin.QTR_Storyline_Objectives then
      return StorylinePlugin.QTR_Storyline_Objectives(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Rewards(...)
   if StorylinePlugin and StorylinePlugin.QTR_Storyline_Rewards then
      return StorylinePlugin.QTR_Storyline_Rewards(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline(...)
   if StorylinePlugin and StorylinePlugin.QTR_Storyline then
      return StorylinePlugin.QTR_Storyline(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_Gossip(...)
   if StorylinePlugin and StorylinePlugin.QTR_Storyline_Gossip then
      return StorylinePlugin.QTR_Storyline_Gossip(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_Storyline_OFF(...)
   if StorylinePlugin and StorylinePlugin.QTR_Storyline_OFF then
      return StorylinePlugin.QTR_Storyline_OFF(...)
   end
end

-------------------------------------------------------------------------------------------------------------------

function IsDUIQuestFrame()
   -- Load the DUIPlugin if it's not already loaded
    local plugin = DUIPlugin
    if plugin and plugin.IsDUIQuestFrame then
        return plugin.IsDUIQuestFrame()
    end
    return false
end
-------------------------------------------------------------------------------------------------------------------

function QTR_DUIbuttons()
   -- Load the DUIPlugin if it's not already loaded
    local plugin = DUIPlugin
    if plugin and plugin.QTR_DUIbuttons then
        plugin.QTR_DUIbuttons()
    end
end
   
-------------------------------------------------------------------------------------------------------------------

function DUI_ON_OFF()
   -- Load the DUIPlugin if it's not already loaded
    local plugin = DUIPlugin
    if plugin and plugin.DUI_ON_OFF then
        plugin.DUI_ON_OFF()
    end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_DUIQuestFrame(event)
   --print("obsługa okna DUIQuestFrame");
   -- Load the DUIPlugin if it's not already loaded
    local plugin = DUIPlugin
    if plugin and plugin.QTR_DUIQuestFrame then
        plugin.QTR_DUIQuestFrame(event)
    end
end

-------------------------------------------------------------------------------------------------------------------

function GossipDUI_ON_OFF()
   -- Load the DUIPlugin if it's not already loaded
    local plugin = DUIPlugin
    if plugin and plugin.GossipDUI_ON_OFF then
        plugin.GossipDUI_ON_OFF()
    end
end

-------------------------------------------------------------------------------------------------------------------

function QTR_DUIGossipFrame()
   -- Load the DUIPlugin if it's not already loaded
    local plugin = DUIPlugin
    if plugin and plugin.QTR_DUIGossipFrame then
        plugin.QTR_DUIGossipFrame()
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

      -- Handle named color constants format |cnCOLOR_NAME:text|r
      msg = msg:gsub("(|cn[%w_]+:)(.-)(|r)", function(colorStart, text, colorEnd)
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
   if not specialCodes then
      return msg
   end
   -- Placeholders are inserted as \001<index>\002. Support both orders for safety.
   msg = msg:gsub("\001(%d+)\002", function(i)
      return specialCodes[tonumber(i)]
   end)
   msg = msg:gsub("\002(%d+)\001", function(i)
      return specialCodes[tonumber(i)]
   end)
   return msg
end

function WOW_ZmienKody(message, target)
   local msg = message;
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
function QTR_ExpandUnitInfo(msg, OnObjectives, AR_obj, AR_font, AR_corr, AR_RIGHT) -- Changed last arg to AR_RIGHT
   if (msg == nil) then
      msg = "";
   end
   msg = WOW_ZmienKody(msg);
   
   if ((WoWTR_Localization.lang == 'AR') and (AR_obj)) then    -- prepare the text for proper display
      local _font = WOWTR_Font2;
      local AR_size = 13;
      -- Attempt to get font/size, handling potential errors or different object types
      if AR_obj.GetFont then
         local success, fontResult, sizeResult, flagsResult = pcall(AR_obj.GetFont, AR_obj, "P") -- Try paragraph font first for SimpleHTML
         if success and fontResult then
            _font = fontResult
            AR_size = sizeResult or AR_size -- Keep default if size is nil
         else -- Fallback if GetFont("P") fails or object is not SimpleHTML
             success, fontResult, sizeResult, flagsResult = pcall(AR_obj.GetFont, AR_obj)
             if success and fontResult then
                 _font = fontResult
                 AR_size = sizeResult or AR_size
             end
         end
      elseif AR_obj.GetRegions then -- Fallback for objects without direct GetFont
         local regions = { AR_obj:GetRegions() };              
         for k, v in pairs(regions) do
            if (v:GetObjectType() == "FontString" and v.GetFont) then -- Check if region is FontString and has GetFont
               local success_region, fontResult_region, sizeResult_region, flagsResult_region = pcall(v.GetFont, v)
               if success_region and fontResult_region then
                  _font = fontResult_region;              
                  AR_size = sizeResult_region or AR_size; 
                  break -- Found a font string, stop searching
               end
            end
         end
      end
      
      local _corr = 0;
      if (AR_corr and (type(AR_corr)=="number")) then
         _corr = AR_corr;
      end

      local specialCodes, prefix
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
      
      -- *** Call appropriate processing function based on AR_RIGHT ***
      if AR_RIGHT then
         msg = AS_ReverseAndPrepareLineText_RIGHT(msg, AR_obj:GetWidth()+_corr, AR_font or _font, AR_size); 
      else
         msg = AS_ReverseAndPrepareLineText(msg, AR_obj:GetWidth()+_corr, AR_font or _font, AR_size);
      end

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
      -- First, apply localization-specific transformations
      local msg = WOW_ZmienKody(txt);
      
      -- Handle WoW special codes using HandleWoWSpecialCodes
      local specialCodes, prefix
      msg, specialCodes, prefix = HandleWoWSpecialCodes(msg)
      
      -- Apply simple text replacements
      msg = string.gsub(msg, "{n}", "\n");
      msg = string.gsub(msg, "{r}", "r|");
      msg = string.gsub(msg, "|n|n", "n|n|");
      
      -- Handle {c}, {T}, {A}, {H} codes - same approach as QTR_ExpandUnitInfo
      local function handleCode(startCode, endCode)
         local nr_poz1 = string.find(msg, startCode)
         local iteration_count = 0
         local max_iterations = 100  -- Safety limit
         
         while (nr_poz1 and iteration_count < max_iterations) do
            iteration_count = iteration_count + 1
            local nr_poz2 = string.find(msg, endCode, nr_poz1)
            if (nr_poz2) then
               local pomoc = string.sub(msg, nr_poz1+2, nr_poz2-1)
               local old_pattern = startCode..pomoc..endCode
               local new_pattern = string.reverse(pomoc)..string.sub(startCode, 2, 2).."|"
               
               -- Replace only the first occurrence to avoid infinite loop
               msg = string.gsub(msg, old_pattern, new_pattern, 1)
               nr_poz1 = string.find(msg, startCode)
            else
               break
            end
         end
         
         if iteration_count >= max_iterations then
            print("Warning: handleCode in QTR_ReverseIfAR hit maximum iteration count for pattern:", startCode)
         end
      end
      
      -- Process each type of formatting code
      handleCode("{c", "}")
      handleCode("{cn", "}")  -- Special handling for {cn...} format
      
      -- Convert remaining markers
      msg = string.gsub(msg, "{t}", "t|");
      msg = string.gsub(msg, "{a}", "a|");
      msg = string.gsub(msg, "{h}", "h|");
      
      -- Reverse the text for Arabic
      msg = AS_UTF8reverse(msg);
      
      -- Restore the special codes
      msg = RestoreWoWSpecialCodes(msg, specialCodes)
      
      -- Reattach the prefix if any
      if prefix and prefix ~= "" then
         msg = prefix .. msg
      end
      
      return msg;
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
            block.HeaderText:SetFont(WOWTR_Font1, 14);
         else
            block.HeaderText:SetFont(WOWTR_Font2, 12);
         end
         block.HeaderText:SetText( QTR_ExpandUnitInfo(questDataTitle, false, block.HeaderText, WOWTR_Font1, -50) );

         -- Example: if Arabic, justify to the right, otherwise left
         if WoWTR_Localization.lang == "AR" then
            block.HeaderText:SetJustifyH("RIGHT");
         else
            block.HeaderText:SetJustifyH("LEFT");
         end
      end
   end
end

-------------------------------------------------------------------------------------------------------

--Map Next Quest Objective
function QTR_Quest_Next() -- https://imgur.com/a/qamjwMN
   if (TT_PS["ui1"] == "1") then
      local QuestMapNextObj = QuestScrollFrame.Contents;
      local children = {QuestMapNextObj:GetChildren()};
      local foundQuestTexts = {}

      for i = 1, #children do
         if children[i] and children[i].NextObjective and children[i].NextObjective.Text then
            local questText = children[i].NextObjective.Text:GetText()
            if questText and questText ~= "" then
               table.insert(foundQuestTexts, children[i].NextObjective.Text)
            end
         end
      end

      for _, foundQuestText in ipairs(foundQuestTexts) do
         --print("Attempting to translate: " .. foundQuestText:GetText())  -- Added for Debug
         ST_CheckAndReplaceTranslationTextUI(foundQuestText, true, "Collections:Quest");
      end

      if #foundQuestTexts == 0 then
         --print("No valid quest text found in any child.")  -- Added for Debug
      end
   end
end
