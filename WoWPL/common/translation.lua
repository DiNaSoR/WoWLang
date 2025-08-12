local addonName, addon = ...
local C = addon.C
local U = addon.U

local T = {}

-- ST_CheckAndReplaceTranslationText(obj, sav, prefix, font1, onlyReverse, ST_corr)
function T.ST_CheckAndReplaceTranslationText(obj, sav, prefix, font1, onlyReverse, ST_corr, justifyAlign)
   if (obj and obj.GetText) then
      -- *** Store original justification ***
      local originalJustifyH = "LEFT" -- Default if GetJustifyH doesn't exist or fails
      if obj.GetJustifyH then
         local success, align = pcall(obj.GetJustifyH, obj)
         if success and align then
            originalJustifyH = align
         end
      end

      local txt = obj:GetText();
      local originalFont, originalSize, originalFlags -- Declare variables

      -- Try to get original font info early
      if obj.GetFont then
         originalFont, originalSize, originalFlags = obj:GetFont();
      end

      -- Cache original text, font, and justification if it's not already translated and not nil
      if txt and string.find(txt, NONBREAKINGSPACE) == nil then
         -- Only cache if it doesn't already look like our translated text
         C.ST_OriginalTextCache[obj] = txt
         if originalFont then
            C.ST_OriginalFontCache[obj] = { originalFont, originalSize, originalFlags }
         end
         C.ST_OriginalJustifyCache[obj] = originalJustifyH -- Cache justification
      end

      -- Proceed only if text exists and is not already translated (no NBSP)
      if (txt and string.find(txt, NONBREAKINGSPACE) == nil) then
         local ST_Hash = StringHash(U.ST_UsunZbedneZnaki(txt));

         if (ST_TooltipsHS[ST_Hash]) then
            -- *** Apply Translation ***
            local ST_tlumaczenie = ST_TooltipsHS[ST_Hash];
            ST_tlumaczenie = U.ST_TranslatePrepare(txt, ST_tlumaczenie);
            if not ST_corr then
               ST_corr = 0;
            end

            local processedText;
            if (onlyReverse) then
               processedText = QTR_ReverseIfAR(ST_tlumaczenie) .. NONBREAKINGSPACE;
            else
               processedText = QTR_ExpandUnitInfo(ST_tlumaczenie, true, obj, WOWTR_Font2, ST_corr) .. NONBREAKINGSPACE;
            end
            obj:SetText(processedText);

            -- Set Font
            if obj.SetFont then
               local success_size, size = pcall(select, 2, obj.GetFont(obj))
               -- Use cached size as fallback if current size fails, else default to 12
               if not success_size then size = originalSize or 12 end
               local chosen_font = font1 or WOWTR_Font2
               pcall(obj.SetFont, obj, chosen_font, size)
            end

            -- Set Justification (Apply passed 'justifyAlign' if valid)
            if justifyAlign and obj.SetJustifyH then
               if justifyAlign == "LEFT" or justifyAlign == "RIGHT" or justifyAlign == "CENTER" then
                  pcall(obj.SetJustifyH, obj, justifyAlign)
               else
                  -- If justifyAlign was provided but invalid, fall back to original
                  pcall(obj.SetJustifyH, obj, originalJustifyH)
               end
            elseif obj.SetJustifyH then
               -- Ensure original justification if justifyAlign was nil (though it was already cached)
               pcall(obj.SetJustifyH, obj, originalJustifyH)
            end

            return -- Return after successful translation/formatting
         else
            -- *** No Translation Found ***
            -- Revert font to original (using cached values if available)
            if obj.SetFont and originalFont then
               pcall(obj.SetFont, obj, originalFont, originalSize, originalFlags);
            end
            -- *** Restore original justification *** (Already done by default, but explicit doesn't hurt)
            if obj.SetJustifyH then
               pcall(obj.SetJustifyH, obj, originalJustifyH)
            end

            -- Save untranslated text if enabled
            if (sav and (ST_PM["saveNW"] == "1")) then
               ST_PH[ST_Hash] = prefix .. "@" .. U.ST_PrzedZapisem(txt);
            end
         end
         -- else -- Text was nil or already translated (had NBSP)
         -- Do nothing here - either no text or already handled.
         -- Reversion for already-translated text happens via ST_revertProfessionDescription
      end
   end
end

function T.ST_CheckAndReplaceTranslationTextUI(obj, sav, prefix, font1)
   if (obj and obj.GetText) then
      local txt = obj:GetText();
      local originalFont, originalSize, originalFlags -- Declare variables
      local originalJustifyH = "LEFT"                 -- Default

      -- Try to get original font info early
      if obj.GetFont then
         originalFont, originalSize, originalFlags = obj:GetFont();
      end
      -- *** Store original justification ***
      if obj.GetJustifyH then
         local success, align = pcall(obj.GetJustifyH, obj)
         if success and align then
            originalJustifyH = align
         end
      end

      -- Cache original text, font, and justification if it's not already translated and not nil
      if txt and string.find(txt, NONBREAKINGSPACE) == nil then
         C.ST_OriginalTextCache[obj] = txt
         if originalFont then
            C.ST_OriginalFontCache[obj] = { originalFont, originalSize, originalFlags }
         end
         C.ST_OriginalJustifyCache[obj] = originalJustifyH -- Cache justification
      end

      -- Ignore specific patterns/words
      local function shouldIgnore(text)
         -- ... (keep existing shouldIgnore logic) ...
         -- ...
         return false
      end

      -- Proceed only if text exists, is not already translated (no NBSP), and not ignored
      if (txt and string.find(txt, NONBREAKINGSPACE) == nil and not shouldIgnore(txt)) then
         -- ... (existing hash calculation logic) ...
         local ST_Hash = StringHash(U.ST_UsunZbedneZnaki(txt));
         -- ...

         if (ST_TooltipsHS[ST_Hash]) then
            -- *** Apply Translation ***
            local a1, a2, a3 = obj:GetFont(); -- a2 is likely the size
            -- ... (translation application logic) ...
            obj:SetText(QTR_ReverseIfAR(U.ST_TranslatePrepare(txt, ST_TooltipsHS[ST_Hash])) .. NONBREAKINGSPACE);

            -- Set Font
            if obj.SetFont then
               local targetSize = a2 or originalSize or 12
               local targetFont = font1 or WOWTR_Font2
               pcall(obj.SetFont, obj, targetFont, targetSize); -- Use pcall for safety
            end
            -- Set Justification (UI usually doesn't change justification)
            -- If needed, apply logic similar to T.ST_CheckAndReplaceTranslationText
         elseif (sav and (TT_PS["saveui"] == "1")) then
            -- *** No Translation, Saving Enabled ***
            ST_PH[ST_Hash] = prefix .. "@" .. U.ST_PrzedZapisem(txt);
            -- Ensure original font and justification are restored
            if obj.SetFont and originalFont then
               pcall(obj.SetFont, obj, originalFont, originalSize, originalFlags);
            end
            if obj.SetJustifyH then
               pcall(obj.SetJustifyH, obj, originalJustifyH);
            end
         else
            -- *** No Translation, Saving Disabled ***
            -- Explicitly revert font and justification to original
            if obj.SetFont and originalFont then
               pcall(obj.SetFont, obj, originalFont, originalSize, originalFlags);
            end
            if obj.SetJustifyH then
               pcall(obj.SetJustifyH, obj, originalJustifyH);
            end
         end
         -- else -- Text was nil, already translated (had NBSP), or ignored
         -- Reversion happens via ST_revertProfessionDescription if needed.
         -- Still important to restore original justification if it was modified before
         -- and then the condition here became false (e.g., text became nil)
         if obj.SetJustifyH then
            local cachedJustify = C.ST_OriginalJustifyCache[obj]
            if cachedJustify then
               pcall(obj.SetJustifyH, obj, cachedJustify)
               -- else -- If nothing cached, maybe revert to default? Depends on desired behavior
               --    pcall(obj.SetJustifyH, obj, "LEFT")
            end
         end
      end
   end
end

addon.T = T
