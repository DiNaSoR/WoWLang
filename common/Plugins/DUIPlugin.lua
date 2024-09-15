local DUIQuestFrame = _G.DUIQuestFrame or {}
_G.DUIQuestFrame = DUIQuestFrame  -- Ensure it's available globally

local DUIPlugin = {}

function DUIPlugin.isDUIQuestFrame()
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

function DUIPlugin.QTR_DUIbuttons()
    local DUI_AcceptButton = DUIQuestFrame.AcceptButton.Content.Name
    ST_CheckAndReplaceTranslationText(DUI_AcceptButton, true, "ui", false, true)

    local DUI_ExitButton = DUIQuestFrame.ExitButton.Content.Name
    ST_CheckAndReplaceTranslationText(DUI_ExitButton, true, "ui", false, true)
end

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

-- Add any other DUI-related functions here

return DUIPlugin