-- Tooltip Constants
local addonName, addon = ...

local C = {}

C.ST_miasto = ""; -- miejsce powrotu przedmiotu Heartstone
C.ST_GameGossip_Show = false;
C.ST_width2 = math.floor(UIParent:GetWidth() / 2 + 0.5);
C.ST_height2 = math.floor(UIParent:GetHeight() / 2 + 0.5);
C.ST_lastNumLines = 0;
C.ST_load1 = false;
C.ST_load2 = false;
C.ST_load4 = false;
C.ST_load5 = false;
C.ST_load6 = false;
C.ST_load7 = false;
C.ST_load8 = false;
C.ST_load9 = false;
C.ST_load10 = false;
C.ST_firstBoss = true;
C.ST_nameBoss = {};
C.ST_navBar1, C.ST_navBar2, C.ST_navBar3, C.ST_navBar4, C.ST_navBar5 = false;
C.ST_OriginalTextCache = {}
C.ST_OriginalFontCache = {}
C.ST_OriginalJustifyCache = {}

-- ignore settings
C.ignoreSettings = {
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

-- ignore list for ItemRefTooltip
C.ItemRefTooltipIgnoreList = {}
if WoWTR_Localization.lang == 'TR' then
   C.ItemRefTooltipIgnoreList = {
      "Head", "Neck", "Shoulder", "Back", "Chest", "Tabard", "Wrist", "Hands", "Waist", "Legs", "Feet", "Finger",
      "Trinket"
   }
end

addon.C = C
