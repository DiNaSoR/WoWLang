-- Description: Texts in the selected localization language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
---------------------------------------------------------------------------------------------------------

WoWTR_Localization = {
   lang = "HU",
   started = "Elindult",                                             -- addon was started
   mainFolder = "Interface\\AddOns\\WoWHU",                          -- origin main folder for addon files
   addonFolder = "WoWHU",                                            -- name of the folder where the addon was installed
   addonName = "WowHunCraft",                                        -- origin short name of the addon 
   addonIconDesc = "Kattints ide a beállításokhoz",                  -- Click to open the settings menu 
   optionName = "WowHunCraft - Beállítások",                         -- WowTR - options 
   optionTitle = "World of HunCraft",                                -- origin WowTR Hungarian Patch 
   optionTitleAR = "",
   addressWWW = "https://panel.wowpopolsku.pl/tools/index_hu.php",   -- address of project page 
   addressDiscord = "https://discord.gg/4NUBhGW9yc",                 -- address of discord page 
   addressTwitch = "",                                               -- address of Twitch page 
   addressFanPage = "",                                              -- address of FanPage 
   addressEmail = "worldofhuncraft@gmail.com",                       -- address of e-mail
   addressCurse = "https://www.curseforge.com/wow/addons/world-of-huncraft",          -- address of CurseForge page
   addressPayPal = "https://www.paypal.com/donate/?hosted_button_id=FC2NVQ5DN7GVA",   -- address of PayPal page
   addressBlik = "",                                                 -- telephon number for BLIK payment
   gossipText = "Pletykák",                                          -- gossip text 
   quests = "Küldetések",                                            -- Quests 
   campaignquests = "Kampány küldetések",                            -- Campaign Quests
   scenariodung = "Forgatókönyv",                                    -- Scenario/Dungeon
   objectives = "Célok",                                             -- Objectives 
   rewards = "Jutalmak",                                             -- Rewards 
   storyLineProgress = "A történet előrehaladása",                   -- Story Progress 
   storyLineChapters = "Fejezetek",                                  -- Chapters 
   choiceQuestFirst = "Elő válassz feladatot",                       -- choose a quest first 
   readyForTurnIn = "Befejezésre készen",                            -- Ready for turn-in 
   clickToComplete = "Kattints a befejezéshez",                      -- click to complete 
   failed = "Nem sikerült",                                          -- Failed 
   optional = "Választható",                                         -- Optional 
   bookID = "Könyvazonosító:",                                       -- Book ID:
   stopTheMovie = "Leállítod a videót?",                             -- Do you want to stop the video? 
   stopTheMovieYes = "Igen",                                         -- Yes 
   stopTheMovieNo = "Nem",                                           -- No 
   reopenBoard = "Nyisd meg újra a hirdetőtáblát.",                  -- Reopen the Bulletin Board 
   sellPrice = "Eladási ár:",                                        -- Sell price:
   currentlyEquipped = "Jelenleg felszerelt",                        -- Currently Equipped
   additionalEquipped = "Kiegészítő berendezésekkel felszerelve",    -- Equipped with additional Equipment
   WoWTR_trDESC = "Magyar",                                          -- Hungarian
   WoWTR_enDESC = "English",                                         -- English
   WoWTR_Spellbook_trDESC = "Varázskönyv: Magyar",                   -- Spell Book: Hungarian
   WoWTR_Spellbook_enDESC = "Spell Book: English",                   -- Spell Book: English
   your_home = "az otthonod",                                        -- 'your home' (if the Hearthstone location fails to be read)
   welcomeIconPos = 255,                                             -- position of welcome icon on the welcom panel; 0 = disabled to display
   resetButton1 = "Mentett lefordítatlan szövegek törlése",          -- Clear saved untranslated texts
   resetButton2 = "Állítsa vissza az|nalapértelmezett beállításokat", -- Reset the addon to its default settings
   resetButton1Opis = "Törölje a mentett lefordítatlan szövegeket a WowHunCraft.lua fájlból",            -- Clear saved untranslated texts (as tooltip)
   resetButton1OpisDESC = "A WowHunCraft.lua fájlban tárolt összes adat törlődik. A fájl tiszta lesz.",  -- Clear saved untranslated texts (as tooltip)
   resetButton2Opis = "Állítsa vissza a kiegészítő beállításait az alapértelmezettre",  -- Reset the addon to its default settings (as tooltip)
   resetButton2OpisDESC = "A kiegészítő összes beállítása visszaáll az alapértelmezettre",
   resultButton1 = "A mentett szövegek törölve",                     -- Saved texts cleared
   confirmationHeader = "Megerősítés",                               -- Confirmation Header
   confirmationText1 = "Törölni szeretné az összes mentett lefordítatlan szöveget?",           -- Do you want to clear all saved untranslated texts?
   confirmationText2 = "Szeretné visszaállítani a kiegészítő alapértelmezett beállításait?",   -- Do you want to restore the default settings of the addon?
   moveFrameUpDown = "Mozgassa az ablakot felfelé vagy lefelé",      -- Move the window up or down
}

---------------------------------------------------------------------------------------------------------

QTR_Messages = {   
   isactive   = "Aktív",                                       -- (is active) 
   isinactive = "Inaktív",                                     -- (is inactive) 
   missing    = "Nincs fordítás",                              -- (no translation) 
   details    = "Leírás",                                      -- (Description) 
   progress   = "Folyamatban",                                 -- (Progress) 
   objectives = "Feladatok",                                   -- (Objectives) 
   completion = "Befejezés",                                   -- (Completion) 
   translator = "Fordító",                                     -- (Translator) 
   rewards    = "Jutalmak",                                    -- (Rewards) 
   experience = "Tapasztalat:",                                -- (Experience) 
   reqmoney   = "Pénz Jutalom:",                               -- (Required money) 
   reqitems   = "Tárgy jutalom:",                              -- (Required items) 
   itemchoose0= "Kapni fogsz:",                                -- (You will receive:) 
   itemchoose1= "Az alábbi jutalmak közül választhatsz:",      -- (You will be able to choose one of these rewards:) 
   itemchoose2= "Válassz egyet a jutalmak közül:",             -- (Choose one of these rewards:) 
   itemchoose3= "Jutalmat kapsz:",                             -- (You receiving the reward:) 
   itemreceiv0= "Kapni fogsz:",                                -- (You will receive:) 
   itemreceiv1= "Továbbá kapni fogsz:",                        -- (You will also receive:) 
   itemreceiv2= "Jutalmat kapsz:",                             -- (You receiving the reward:) 
   itemreceiv3= "Továbbá kapsz még jutalmul:",                 -- (You also receiving the reward:) 
   learnspell = "Képességet tanulsz:",                         -- (Learn Spell:) 
   currquests = "Jelenlegi küldetések",                        -- (Current Quests) 
   avaiquests = "Elérhető küldetések",                         -- (Available Quests) 
   reward_aura      = "A következő varázslatot használják rajtad:",   --  (The following will be cast on you:) 
   reward_spell     = "A következőt fogod megtanulni:",               --  (You will learn the following:) 
   reward_companion = "Az következő társ fog csatlakozni hozzád:",    --  (You will gain these Companions:) 
   reward_follower  = "Az alábbi követők csatlakozik hozzád:",        --  (You will gain these followers:) 
   reward_reputation= "Hírnév jutalom:",                              --  (Reputation awards:) 
   reward_title     = "A következő címet adományozzák neked:",        --  (You shall be granted the title:) 
   reward_tradeskill= "Megtanulod elkészíteni:",                      --  (You will learn how to create:) 
   reward_unlock    = "A következő válik elérhetővé számodra:",       --  (You will unlock access to the following:) 
   reward_bonus     = "A küldetés csapat szinkronizációban való teljesítése jutalmat adhat:",  --  (Completing this quest while in Party Sync may reward:) 
}; 

---------------------------------------------------------------------------------------------------------

WoWTR_Config_Interface = {
   showMinimapIcon = "Jelenítse meg a kiegészítő beállítások ikonját a minitérkép mellett",                       -- Show the addon settings icon next to the minimap
   showMinimapIconDESC = "Ha engedélyezve van, a kiegészítő beállítási ikonja megjelenik a minitérkép mellett",   -- If enabled, the addon settings icon will display next to the minimap
   
   titleTab1 = "Küldetések",                                                                         -- Quests
   generalMainHeaderQS = "Küldetések fordítása",                                                     -- Quest translations
   activateQuestsTranslations = "Küldetések fordítása",                                              -- Activate quest translations
   activateQuestsTranslationsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",   -- If enabled, quest translations will appear in place of the original texts
   translateQuestTitles = "Küldetések címének frodítása",                                            -- Display translations of quest TITLES 
   translateQuestTitlesDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",   -- If enabled, quest titles will be translated 
   translateGossipTexts = "NPC-k által mondott szövegek lefordítása",                                -- Display translations of GOSSIP texts 
   translateGossipTextsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",   -- If enabled, gossip texts will be translated
   translateTrackObjectives = "A Küldetés követőben lévő szövegek fordítása",                        -- Display translations online in Objectives Tracker
   translateTrackObjectivesDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",   -- If enabled, texts in Objectives Tracker will be translated
   translateOwnNames = "Saját helyek megjelenítése magyar nyelven",                                 -- Display own names places in hungarian language
   translateOwnNamesDESC = "Ha engedélyezve van, a városok, helyek stb. saját nevei magyar nyelven jelennek meg",   -- If enabled, own names of cities, places etc. will displaying in hungarian language
   savingUntranslatedQuests = "Le nem fordított küldetések",                                         -- Saving untranslated quests and gossip texts
   saveUntranslatedQuests = "A le nem fordított küldetések mentése",                                 -- Save untranslated quests 
   saveUntranslatedQuestsDESC = "Ha lehetséges, a le nem fordított küldetések mentve lesznek",       -- If enabled, untranslated quests will be saved 
   saveUntranslatedGossip = "A le nem fordított szövegek mentése",                                   -- Save untranslated gossip texts
   saveUntranslatedGossipDESC = "Ha lehetséges, a le nem fordított szövegek mentve lesznek",         -- If enabled, untranslated gossip texts will be saved
   integrationWithOtherAddons = "Integráció más addon-okkal",                                        -- Integration with other addons
   translateImmersion = "Fordítás megjelenítése Immersion addon esetén",                             -- Display translations in Immersion addon
   translateImmersionDESC = "Ha elérhető, az Immersion addon szövegeinek fordítása",                 -- If enabled, texts in Immersion addon will be translated
   translateStoryLine = "Fordítások megjelenítése StoryLine addon esetén",                           -- Display translations in StoryLine addon
   translateStoryLineDESC = "Ha elérhető, a StoryLine addon szövegeinek fordítása",                  -- If enabled, texts in StoryLine addon will be translated
   translateQuestLog = "Fordítások megjelenítése Classic Quest Log addon esetén",                    -- Display translations in Classic Quest Log addon
   translateQuestLogDESC = "Ha elérhető, a Classic Quest Log addon szövegeinek fordítása",           -- If enabled, texts in Classic Quest Log addon will be translated
   translateDialogueUI = "Fordítások megjelenítése DialogueUI addon esetén",                         -- Display translations in DialogueUI addon
   translateDialogueUIDESC = "Ha elérhető, a DialogueUI addon szövegeinek fordítása",                -- If enabled, texts in DialogueUI addon will be translated
   sampleGossipText = "Minta Gossip|nbetűméret szöveg",                                              -- Sample Gossip font size text (TR:Gossip Örnek yazı tipi boyutu metni)

   titleTab2 = "Buborékok",                                                                          -- Bubbles 
   generalMainHeaderBB = "Szövegbuborékok fordítása",                                                -- Bubbles translations
   activateBubblesTranslations = "Szövegbuborékok fordításáa",                                       -- Activate bubble translations 
   activateBubblesTranslationsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredti szöveg helyén",     -- If enabled, bubble translations will appear in place of the original texts
   displayOriginalTexts = "Az eredeti szöveg megjelenítése a Csevegés ablakban",                     -- Display original text in chat frame
   displayOriginalTextsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",   -- If enabled, original texts of bullbe will be displayed 
   displayTranslatedTexts = "Fordított szöveg megjelenítése a Csevegés ablakban",                    -- Display translated text in chat frame 
   displayTranslatedTextsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén", -- If enabled, translated texts will be displayed
   choiceGender1OfPlayer = "Hím nemű fogalmazásmód megjelenítése",                                   -- Choice of male expression to the player 
   choiceGender1OfPlayerDESC = "Ha elérhető az NPC szövegek hím nyelvezetben jelenik meg",           -- If enabled, translated bubbles will be displayed in male form 
   choiceGender2OfPlayer = "Nő nemű fogalmazásmód megjelenítése",                                    -- Choice of female expression to the player 
   choiceGender2OfPlayerDESC = "Ha lehetséges, az NPC szövegek női nyelvezetben jelenik meg",        -- If enabled, translated bubbles will be displayed in female form 
   choiceGender3OfPlayer = "A karakter nemétől függő fogalmazásmód megjelenítése",                   -- Choise of expression for the player depending on the gender of the character 
   choiceGender3OfPlayerDESC = "Ha lehetséges, az NPC szövegek hím nyelvezetben jelenik meg",        -- If enbled, translated bubbles will be displayed in male form 
   showBubblesInDungeon = "Szövegbuborékok megjelenítése a kazamatakban",                            -- Show bubbles in dungeons
   showBubblesInDungeonDESC = "Ha be van jelölve, a dungeon buborékok saját 5 keretükben jelennek meg a képernyő tetején",   -- If checked, dungeon bubbles will be shown in their own 5 frames at the top of the screen
   setDungeonFrames = "Állítsa be a szövegbuborék-ablakokat",                                        -- Set up speech bubble frames
   setDungeonFramesDESC = "Ha be van jelölve, akkor képes lesz a kazamatákban lévő buborékablakokat függőlegesen igazítani", -- When checked, you will be able to vertically align the bubble windows in dungeons
   savingUntranslatedBubbles = "Le nem fordított szövegbuborékok mentése",                           -- Saving untranslated bubbles
   saveUntranslatedBubbles = "A le nem fordított szövegbuborékok mentése",                           -- Save untranslated bubbles 
   saveUntranslatedBubblesDESC = "Ha lehetséges, a le nem fordított szövegbuborékok mentve lesznek", -- If enabled, untranslated bubbles will be saved 
   fontSizeHeader = "Szövegbuborékok betűmérete",                                                    -- Font size of texts
   setFontActivate = "Betűméret beállításának engedélyezése",                                        -- Activate font size changes 
   setFontActivateDESC = "Ha lehetséges betűméret beállítás akkor az alábbi értékre lesz állítva",   -- If enabled, font size will be set to below value   
   fontsizeBubbles = "Válassz betűméretet",                                                          -- Choose a font size 
   fontsizeBubblesDESC = "A betűméret 10 és 20 között állítható",                                    -- The font size is a number between 10 and 20
   sampleText = "Egyszerű szövegek betümérete",                                                      -- Sample font size text
   timerDisplay = "Fordítás megjelenítési ideje",                                                    -- Translation display time

   titleTab3 = "Feliratok",                                                                          -- Movies & Cinematics
   generalMainHeaderMF = "Feliratok fordítása",                                                      -- Subtitle translations
   activateSubtitleTranslations = "Feliratok fordítása",                                             -- Activate subtitle translations
   activateSubtitleTranslationsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredti szöveg helyén",  -- If enabled, translated subtitles will displayed
   subtitleIntro = "Fordított feliratok megjelenítése a Bevezetőben",                                -- Display translated subtitles of Intro
   subtitleIntroDESC = "Ha elérhető, fordított felirat megjelenítése a Bevezetőben",                 -- If enbled, translated subtitles will be displyed into starting Intro
   subtitleMovies = "Fordított feliratok megjelenítése a Videók alatt",                              -- Display translated subtitles of Movies
   subtitleMoviesDESC = "Ha elérhető, fordított felirat megjelenítése videók alatt",                 -- If enbled, translated subtitles will be displyed into movies 
   subtitleCinematics = "Fordított feliratok megjelenítése Filmek alatt",                            -- Display translated subtitles of Cinematics
   subtitleCinematicsDESC = "Ha elérhető, fordított felirat megjelenítése Filmek alatt",             -- If enbled, translated subtitles will be displyed into cinematics 
   savingUntranslatedSubtitles = "Le nem fordított feliratok mentése",                               -- Saving untranslated subtitles 
   saveUntranslatedSubtitles = "A le nem fordított feliratokat mentése",                             -- Save untranslated subtitles
   saveUntranslatedSubtitlesDESC = "Ha lehetséges,a le nem fordított feliratok mentve lesznek",      -- If enbled, untranslated subtitles will be saved
   chatService = "Service of arabic chat",
   activateChatService = "Activate of arabic chat",
   activateChatServiceDESC = "If enabled, arabic chat is active",
   chatFontActivate = "Activate font size changes",
   chatFontActivateDESC = "If enabled, font size will be set to below value",
   fontsizeChat = "Choose a font size",
   fontsizeChatDESC = "The font size is a number between 10 and 20",

   titleTab4 = "UI beállítások",                                                                     -- UI settings
   generalMainHeaderTT = "Oktatóanyagok fordítása",                                                  -- Tutorial translations
   activateTutorialTranslations = "Oktatóanyagok fordítása",                                         -- Activate tutorial translations
   activateTutorialTranslationsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",   -- If enabled, translated tutorials will displayed
   savingUntranslatedTutorials = "Le nem fordított oktatóanyagok mentése",                           -- Saving untranslated tutorials
   saveUntranslatedTutorials = "A le nem fordított oktatóanyagokat mentve lesznek",                  -- Save untranslated tutorials
   saveUntranslatedTutorialsDESC = "Ha lehetésges, a le a le nem fordított oktatóanyagok mentve lesznek",   -- If enbled, untranslated tutorials will be saved
   fontSelectingFontHeader = "A FORDÍTÁSI BETŰKIVÁLASZTÁSA",                                         -- Font selection for the main texts of the translation
   fontSelectFontFile = "Válasszon ki egy betűtípusfájlt",                                           -- Select a font file
   fontCurrentFont = "Jelenlegi betűtípus:",                                                         -- Current font:

   translationUI = "FELHASZNÁLÓI FELÜLET – UI",                                                      -- Translation of user interface
   savingTranslationUI = "REGISZTRÁCIÓS LEHETŐSÉGEK",                                                -- Saving untanslated user interface
   saveTranslationUI = "Mentse el a lefordítatlan felhasználói felület elemeit",                     -- Save untranslated user interface
   saveTranslationUIDESC = "Ha be van jelölve, a nem lefordított felhasználói felület elemei mentésre kerülnek",   -- If enabled, untranslated user interface will be saving
   ReloadButtonUI = "Kattintson a beállítások alkalmazásához \"Reload UI\"",                         -- For the application of settings click "ReloadUI"
   displayTranslationtxt = "Válassza ki azokat, amelyeknek a fordítását aktiválni szeretné",         -- Display translation of user interface
   displayTranslationUI1 = "Játék menü",                                                             -- Display translation of Game Menu
   displayTranslationUI1DESC = "A játékmenü és annak tartalma mostantól törökül fog megjelenni",     -- If enabled, user interface will be displayed in translation
   displayTranslationUI2 = "Karakter információk",                                                   -- Display translation of Character Info
   displayTranslationUI2DESC = "A karakterinformációs felület török ​​nyelven jelenik meg",            -- If enabled, user interface will be displayed in translation
   displayTranslationUI3 = "Csoportkereső",                                                          -- Display translation of Group Finder
   displayTranslationUI3DESC = "A Group Finder és annak allapjai mostantól törökül jelennek meg",    -- If enabled, user interface will be displayed in translation
   displayTranslationUI4 = "Gyűjtemények",                                                           -- Display translation of Collections
   displayTranslationUI4DESC = "A gyűjtemények oldala és annak tartalma mostantól török ​​nyelven jelenik meg",   -- If enabled, user interface will be displayed in translation
   displayTranslationUI5 = "Kalandkalauz",                                                           -- Display translation of Adventure Guide
   displayTranslationUI5DESC = "Kalandkalauz és aloldalai mostantól török ​​nyelven jelennek meg",     -- If enabled, user interface will be displayed in translation
   displayTranslationUI6 = "Barátlista",                                                             -- Display translation of Friend List
   displayTranslationUI6DESC = "Az ismerőslista tartalma mostantól török ​​nyelven jelenik meg",       -- If enabled, user interface will be displayed in translation
   displayTranslationUI7 = "Állások",                                                                -- Display translation of Profession
   displayTranslationUI7DESC = "A szakma és annak tartalma mostantól törökül jelenik meg",           -- If enabled, user interface will be displayed in translation
   displayTranslationUI8 = "Szűrő és legördülő menük",                                               -- Display translation of Filter & Open List
   displayTranslationUI8DESC = "A Szűrés és a lista megnyitása menük mostantól török ​​nyelven jelennek meg",   -- If enabled, user interface will be displayed in translation

   titleTab5 = "Könyvek",                                                                            -- Books 
   generalMainHeaderBT = "Könyvek fordítása",                                                        -- Books translations
   activateBooksTranslations = "Könyvek fordítása",                                                  -- Activate book translations
   activateBooksTranslationsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",  -- If enabled, book translations will appear in place of the original texts
   translateBookTitles = "A lefordított könyvek címének megjelenítése",                              -- Display translations of book TITLES
   translateBookTitlesDESC = "Ha elérhető a lefordított könyvek címének megjelenítése",              -- If enabled, book titles will be translated 
   showBookID = "Könyvek sorszámának megjelenítése",                                                 -- Show ID of book
   showBookIDDESC = "Ha lehetséges, a könyvek sorszámának megjelenítése",                            -- If enabled, ID of book will be shown
   savingUntranslatedBooks = "Le nem fordított könyvek mentése",                                     -- Saving untranslated books
   saveUntranslatedBooks = "A le nem fordított könyvek mentve lesznek",                              -- Save untranslated books
   saveUntranslatedBooksDESC = "Ha lehetséges, a le nem fordított könyvek mentve lesznek",           -- If enabled, untranslated books will be saved 

   titleTab6 = "Eszköztippek",                                                                       -- Tooltips
   generalMainHeaderST = "Ezköztippek fordítása",                                                    -- Tooltip translations
   activateTooltipTranslations = "Eszköztippek fordítása",                                           -- Activate tooltip translations
   activateTooltipTranslationsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",  -- If enabled, translated tooltips will displayed
   translateItems = "Tárgyak eszkötippjeinek fordítása",                                             -- Display translated tooltips for items
   translateItemsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",         -- If enabled, translated tooltips for items will be displayed
   translateSpells = "Képességek eszköztippjeinek fordítása",                                        -- Display translated tooltips for spells 
   translateSpellsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",        -- If enabled, translated tooltips for spells will be displayed
   translateTalents = "Tehetségek eszköztippjeinek fordítása",                                       -- Display translated tooltips for talents 
   translateTalentsDESC = "Ha elérhető fordítás, az meg fog jelenni az eredeti szöveg helyén",       -- If enabled, translated tooltips for talents will be displayed
   translateTooltipTitle = "Jelenítse meg az elem, varázslat vagy tehetség lefordított címét",      -- Display translated title of item, spell or talent
   translateTooltipTitleDESC = "Ha engedélyezve van, megjelenik az eszköztippek lefordított címe",  -- If enabled, translated title of tooltips will be displayed
   showTooltipID = "Eszköztipp sorszámának megjelenítése",                                           -- Show tooltips ID
   showTooltipIDDESC = "Ha elérhető, az eszköztipp sorszáma megjelenik",                             -- If enabled, display tooltips ID 
   showTooltipHash = "Eszköztipp Hash számánk megjelenítése",                                        -- Show tooltips Hash
   showTooltipHashDESC = "Ha elérhető az eszköztipp Hash száma megjelnik",                           -- If enabled, display tooltips Hash
   hideSellPrice = "Tárgy eladási árának elrejtése",                                                 -- Hide sell price of items
   hideSellPriceDESC = "Ha lehetséges, a tárgy eladási ára rejtve marad",                            -- If enabled, sell price of items will be hidden
   timerHoldTranslation = "Fordítás megjelenítés felfüggesztése",                                    -- Suspend the translation display
   timerLimitSeconds = "Válassz fordítás fenntartási időt",                                          -- Select a translation hold time
   timerLimitSecondsDESC = "Az idő egy 5 és 30 közötti szám lehet",                                  -- The times is a number between 5 and 30
   displayTranslationConstantly = "Fordítások állandó megjelenítése",                                -- Display translation constantly
   displayTranslationConstantlyDESC = "Ha be van jelölve, a bővítmény megpróbálja ellensúlyozni az eszköztipp tartalmának frissítési hatásait",                          -- Description of option 'displayTranslationConstantly'
   savingUntranslatedTooltips = "Le nem fordított eszkötippek mentése",                              -- Saving untranslated tooltips
   saveUntranslatedTooltips = "A le nem fordított eszköztippek mentése",                             -- Save untranslated tooltips
   saveUntranslatedTooltipsDESC = "Ha lehetséges, a le nem fordított eszköztippek mentve lesznek",   -- If enabled, untranslated tooltips will be saved

   titleTab9 = "Az addonról",                                                                        -- About
   generalText = "\nJó játékot kívánunk!\nAmennyiben csatlakoznál az alábbi linken vagy discordon vedd fel velünk a kapcsolatot.\nAmennyiben hibát találsz, vagy észrevételed lenne az e-mail címünkön vagy discordon tudod jelezni.",                               -- info about project
   welcomeText = "",
   welcomeButton = "Oké, elolvastam",                                                                -- Button: Close welcome panel
   showWelcome = "Üdvözlő panel megjelenítése",                                                      -- Button: Show welcome panel
   authorHeader = "Szerző információ",                                                               -- Author info
   author = "Szerző:",                                                                               -- Author: 
   email = "E-mail:",                                                                                -- E-mail: 
   teamHeader = "World of Huncraft csapata",                                                         -- WoWTR project team (TR:WoWTR)
   textContact = "Ha bármilyen kérdése van a kiegészítővel kapcsolatban, kérjük, vegye fel velünk a kapcsolatot az alábbi csatornákon:",
   linkWWWShow = "Kattintson a |cffffff00WWW|r bővítményoldalra való hivatkozáshoz",
   linkWWWTitle = "Link a weboldalra",
   linkDISCShow = "Kattintson a |cffffff00Discord|r hivatkozásához",
   linkDISCTitle = "Link a Discord oldalra",
   linkEMAILShow = "Kattintson ide a projekt megtekintéséhez |cffffff00email|r cím",
   linkEMAILTitle = "Projekt e-mail címe",
   linkCURSEShow = "Kattintson a |cffffff00CurseForge|r hivatkozáshoz",
   linkCURSETitle = "Link a CurseForge webhelyére",
   linkPPShow = "Kattintson az oldal hivatkozásához |cffffff00PayPal|r",
   linkPPTitle = "Link a PayPal webhelyére",
   linkBLIKShow = "Kattintson ide a telefonszám megtekintéséhez |cffffff00BLIK|r",
   linkBLIKTitle = "BLIK telefonszám",
   linkTWITCHShow = "Kattintson a |cffffff00Twitch|r hivatkozásához",
   linkTWITCHTitle = "Link a Twitch oldalra",
   linkFBShow = "Kattintson a rajongói oldal hivatkozásának megtekintéséhez",
   linkFBTitle = "Link a rajongói oldalra",
   linkCloseFrame = "Zárja be a keretet",
   linkCopy = "Nyomj |cffff00ffCtr+C|r-t a kijelöléshez,\nmajd |cffff00ffCtrl+V|r-t a másoláshoz",   -- Press Ctrl+A to select this address, then press Ctrl+C to copy the address to the clipboard
   betaTestersHeader = "Fordítócsapat:",                                                             -- TRANSLATION TEAM
   betaTestersHeaderDESC = "Fordítók és béta tesztelők: |cffff00ffDorten|r, |cffff00ffKecskex|r, |cffff00ffCasualCrash|r",    -- Translators and Beta testers:                                       -- Beta Testers: 
};

---------------------------------------------------------------------------------------------------------

-- translated names of the player's races and classes in various cases of the noun variant (M1,D1,C1,B1,N1,K1,W1;M2,D2,C2,B2,N2,K2,W2) and the player's gender (male:1, female:2)
local p_race = {
      ["Blood Elf"] = { M1="Vér Elf", D1="Vér Elf", C1="Vér Elf", B1="Vér Elf", N1="Vér Elf", K1="Vér Elf", W1="Vér Elf", M2="Vér Elf", D2="Vér Elf", C2="Vér Elf", B2="Vér Elf", N2="Vér Elf", K2="Vér Elf", W2="Vér Elf" }, 
      ["Dark Iron Dwarf"] = { M1="Feketevas Törp", D1="Feketevas Törp", C1="Feketevas Törp", B1="Feketevas Törp", N1="Feketevas Törp", K1="Feketevas Törp", W1="Feketevas Törp", M2="Feketevas Törp", D2="Feketevas Törp", C2="Feketevas Törp", B2="Feketevas Törp", N2="Feketevas Törp", K2="Feketevas Törp", W2="Feketevas Törp" }, 
      ["Dracthyr"] = { M1="Dracthyr", D1="Dracthyr", C1="Dracthyr", B1="Dracthyr", N1="Dracthyr", K1="Dracthyr", W1="Dracthyr", M2="Dracthyr", D2="Dracthyr", C2="Dracthyr", B2="Dracthyr", N2="Dracthyr", K2="Dracthyr", W2="Dracthyr" }, 
      ["Draenei"] = { M1="Draenei", D1="Draenei", C1="Draenei", B1="Draenei", N1="Draenei", K1="Draenei", W1="Draenei", M2="Draenei", D2="Draenei", C2="Draenei", B2="Draenei", N2="Draenei", K2="Draenei", W2="Draenei" }, 
      ["Dwarf"] = { M1="Törp", D1="Törp", C1="Törp", B1="Törp", N1="Törp", K1="Törp", W1="Törp", M2="Törp", D2="Törp", C2="Törp", B2="Törp", N2="Törp", K2="Törp", W2="Törp" }, 
      ["Earthen"] = { M1="Earthen", D1="Earthen", C1="Earthen", B1="Earthen", N1="Earthen", K1="Earthen", W1="Earthen", M2="Earthen", D2="Earthen", C2="Earthen", B2="Earthen", N2="Earthen", K2="Earthen", W2="Earthen" },
      ["Gnome"] = { M1="Gnóm", D1="Gnóm", C1="Gnóm", B1="Gnóm", N1="Gnóm", K1="Gnóm", W1="Gnóm", M2="Gnóm", D2="Gnóm", C2="Gnóm", B2="Gnóm", N2="Gnóm", K2="Gnóm", W2="Gnóm" }, 
      ["Goblin"] = { M1="Goblin", D1="Goblin", C1="Goblin", B1="Goblin", N1="Goblin", K1="Goblin", W1="Goblin", M2="Goblin", D2="Goblin", C2="Goblin", B2="Goblin", N2="Goblin", K2="Goblin", W2="Goblin" }, 
      ["Highmountain Tauren"] = { M1="Hegyvidéki Tauren", D1="Hegyvidéki Tauren", C1="Hegyvidéki Tauren", B1="Hegyvidéki Tauren", N1="Hegyvidéki Tauren", K1="Hegyvidéki Tauren", W1="Hegyvidéki Tauren", M2="Hegyvidéki Tauren", D2="Hegyvidéki Tauren", C2="Hegyvidéki Tauren", B2="Hegyvidéki Tauren", N2="Hegyvidéki Tauren", K2="Hegyvidéki Tauren", W2="Hegyvidéki Tauren" }, 
      ["Human"] = { M1="Ember", D1="Ember", C1="Ember", B1="Ember", N1="Ember", K1="Ember", W1="Ember", M2="Ember", D2="Ember", C2="Ember", B2="Ember", N2="Ember", K2="Ember", W2="Ember" }, 
      ["Kul Tiran"] = { M1="Kul Tiraszi", D1="Kul Tiraszi", C1="Kul Tiraszi", B1="Kul Tiraszi", N1="Kul Tiraszi", K1="Kul Tiraszi", W1="Kul Tiraszi", M2="Kul Tiraszi", D2="Kul Tiraszi", C2="Kul Tiraszi", B2="Kul Tiraszi", N2="Kul Tiraszi", K2="Kul Tiraszi", W2="Kul Tiraszi", }, 
      ["Lightforged Draenei"] = { M1="Fényedzett Draenei", D1="Fényedzett Draenei", C1="Fényedzett Draenei", B1="Fényedzett Draenei", N1="Fényedzett Draenei", K1="Fényedzett Draenei", W1="Fényedzett Draenei", M2="Fényedzett Draenei", D2="Fényedzett Draenei", C2="Fényedzett Draenei", B2="Fényedzett Draenei", N2="Fényedzett Draenei", K2="Fényedzett Draenei", W2="Fényedzett Draenei" }, 
      ["Mag'har Orc"] = { M1="Mag'har Ork", D1="Mag'har Ork", C1="Mag'har Ork", B1="Mag'har Ork", N1="Mag'har Ork", K1="Mag'har Ork", W1="Mag'har Ork", M2="Mag'har Ork", D2="Mag'har Ork", C2="Mag'har Ork", B2="Mag'har Ork", N2="Mag'har Ork", K2="Mag'har Ork", W2="Mag'har Ork", }, 
      ["Mechagnome"] = { M1="Mechagnóm", D1="Mechagnóm", C1="Mechagnóm", B1="Mechagnóm", N1="Mechagnóm", K1="Mechagnóm", W1="Mechagnóm", M2="Mechagnóm", D2="Mechagnóm", C2="Mechagnóm", B2="Mechagnóm", N2="Mechagnóm", K2="Mechagnóm", W2="Mechagnóm" }, 
      ["Nightborne"] = { M1="Éjszülött", D1="Éjszülött", C1="Éjszülött", B1="Éjszülött", N1="Éjszülött", K1="Éjszülött", W1="Éjszülött", M2="Éjszülött", D2="Éjszülött", C2="Éjszülött", B2="Éjszülött", N2="Éjszülött", K2="Éjszülött", W2="Éjszülött" }, 
      ["Night Elf"] = { M1="Éjelf", D1="Éjelf", C1="Éjelf", B1="Éjelf", N1="Éjelf", K1="Éjelf", W1="Éjelf", M2="Éjelf", D2="Éjelf", C2="Éjelf", B2="Éjelf", N2="Éjelf", K2="Éjelf", W2="Éjelf" }, 
      ["Orc"] = { M1="Ork", D1="Ork", C1="Ork", B1="Ork", N1="Ork", K1="Ork", W1="Ork", M2="Ork", D2="Ork", C2="Ork", B2="Ork", N2="Ork", K2="Ork", W2="Ork" }, 
      ["Pandaren"] = { M1="Pandaren", D1="Pandaren", C1="Pandaren", B1="Pandaren", N1="Pandaren", K1="Pandaren", W1="Pandaren", M2="Pandaren", D2="Pandaren", C2="Pandaren", B2="Pandaren", N2="Pandaren", K2="Pandaren", W2="Pandaren" }, 
      ["Tauren"] = { M1="Tauren", D1="Tauren", C1="Tauren", B1="Tauren", N1="Tauren", K1="Tauren", W1="Tauren", M2="Tauren", D2="Tauren", C2="Tauren", B2="Tauren", N2="Tauren", K2="Tauren", W2="Tauren" }, 
      ["Troll"] = { M1="Troll", D1="Troll", C1="Troll", B1="Troll", N1="Troll", K1="Troll", W1="Troll", M2="Troll", D2="Troll", C2="Troll", B2="Troll", N2="Troll", K2="Troll", W2="Troll" }, 
      ["Undead"] = { M1="Élőholt", D1="Élőholt", C1="Élőholt", B1="Élőholt", N1="Élőholt", K1="Élőholt", W1="Élőholt", M2="Élőholt", D2="Élőholt", C2="Élőholt", B2="Élőholt", N2="Élőholt", K2="Élőholt", W2="Élőholt" }, 
      ["Void Elf"] = { M1="Árny Elf", D1="Árny Elf", C1="Árny Elf", B1="Árny Elf", N1="Árny Elf", K1="Árny Elf", W1="Árny Elf", M2="Árny Elf", D2="Árny Elf", C2="Árny Elf", B2="Árny Elf", N2="Árny Elf", K2="Árny Elf", W2="Árny Elf" }, 
      ["Vulpera"] = { M1="Vulpera", D1="Vulpera", C1="Vulpera", B1="Vulpera", N1="Vulpera", K1="Vulpera", W1="Vulpera", M2="Vulpera", D2="Vulpera", C2="Vulpera", B2="Vulpera", N2="Vulpera", K2="Vulpera", W2="Vulpera" }, 
      ["Worgen"] = { M1="Worgen", D1="Worgen", C1="Worgen", B1="Worgen", N1="Worgen", K1="Worgen", W1="Worgen", M2="Worgen", D2="Worgen", C2="Worgen", B2="Worgen", N2="Worgen", K2="Worgen", W2="Worgen" }, 
      ["Zandalari Troll"] = { M1="Zandalari Troll", D1="Zandalari Troll", C1="Zandalari Troll", B1="Zandalari Troll", N1="Zandalari Troll", K1="Zandalari Troll", W1="Zandalari Troll", M2="Zandalari Troll", D2="Zandalari Troll", C2="Zandalari Troll", B2="Zandalari Troll", N2="Zandalari Troll", K2="Zandalari Troll", W2="Zandalari Troll" }, 
};
local p_class = {
      ["Death Knight"] = { M1="Halál Lovag", D1="Halál Lovag", C1="Halál Lovag", B1="Halál Lovag", N1="Halál Lovag", K1="Halál Lovag", W1="Halál Lovag", M2="Halál Lovag", D2="Halál Lovag", C2="Halál Lovag", B2="Halál Lovag", N2="Halál Lovag", K2="Halál Lovag", W2="Halál Lovag" }, 
      ["Demon Hunter"] = { M1="Démonvadász", D1="Démonvadász", C1="Démonvadász", B1="Démonvadász", N1="Démonvadász", K1="Démonvadász", W1="Démonvadász", M2="Démonvadász", D2="Démonvadász", C2="Démonvadász", B2="Démonvadász", N2="Démonvadász", K2="Démonvadász", W2="Démonvadász" }, 
      ["Druid"] = { M1="Druida", D1="Druida", C1="Druida", B1="Druida", N1="Druida", K1="Druida", W1="Druida", M2="Druida", D2="Druida", C2="Druida", B2="Druida", N2="Druida", K2="Druida", W2="Druida" }, 
      ["Evoker"] = { M1="Evoker", D1="Evoker", C1="Evoker", B1="Evoker", N1="Evoker", K1="Evoker", W1="Evoker", M2="Evoker", D2="Evoker", C2="Evoker", B2="Evoker", N2="Evoker", K2="Evoker", W2="Evoker" }, 
      ["Hunter"] = { M1="Vadász", D1="Vadász", C1="Vadász", B1="Vadász", N1="Vadász", K1="Vadász", W1="Vadász", M2="Vadász", D2="Vadász", C2="Vadász", B2="Vadász", N2="Vadász", K2="Vadász", W2="Vadász" }, 
      ["Mage"] = { M1="Mágus", D1="Mágus", C1="Mágus", B1="Mágus", N1="Mágus", K1="Mágus", W1="Mágus", M2="Mágus", D2="Mágus", C2="Mágus", B2="Mágus", N2="Mágus", K2="Mágus", W2="Mágus" }, 
      ["Monk"] = { M1="Szerzetes", D1="Szerzetes", C1="Szerzetes", B1="Szerzetes", N1="Szerzetes", K1="Szerzetes", W1="Szerzetes", M2="Szerzetes", D2="Szerzetes", C2="Szerzetes", B2="Szerzetes", N2="Szerzetes", K2="Szerzetes", W2="Szerzetes" }, 
      ["Paladin"] = { M1="Lovag", D1="Lovag", C1="Lovag", B1="Lovag", N1="Lovag", K1="Lovag", W1="Lovag", M2="Lovag", D2="Lovag", C2="Lovag", B2="Lovag", N2="Lovag", K2="Lovag", W2="Lovag" }, 
      ["Priest"] = { M1="Pap", D1="Pap", C1="Pap", B1="Pap", N1="Pap", K1="Pap", W1="Pap", M2="Pap", D2="Pap", C2="Pap", B2="Pap", N2="Pap", K2="Pap", W2="Pap" }, 
      ["Rogue"] = { M1="Zsivány", D1="Zsivány", C1="Zsivány", B1="Zsivány", N1="Zsivány", K1="Zsivány", W1="Zsivány", M2="Zsivány", D2="Zsivány", C2="Zsivány", B2="Zsivány", N2="Zsivány", K2="Zsivány", W2="Zsivány" }, 
      ["Shaman"] = { M1="Sámán", D1="Sámán", C1="Sámán", B1="Sámán", N1="Sámán", K1="Sámán", W1="Sámán", M2="Sámán", D2="Sámán", C2="Sámán", B2="Sámán", N2="Sámán", K2="Sámán", W2="Sámán" }, 
      ["Warlock"] = { M1="Boszorkánymester", D1="Boszorkánymester", C1="Boszorkánymester", B1="Boszorkánymester", N1="Boszorkánymester", K1="Boszorkánymester", W1="Boszorkánymester", M2="Boszorkánymester", D2="Boszorkánymester", C2="Boszorkánymester", B2="Boszorkánymester", N2="Boszorkánymester", K2="Boszorkánymester", W2="Boszorkánymester" }, 
      ["Warrior"] = { M1="Harcos", D1="Harcos", C1="Harcos", B1="Harcos", N1="Harcos", K1="Harcos", W1="Harcos", M2="Harcos", D2="Harcos", C2="Harcos", B2="Harcos", N2="Harcos", K2="Harcos", W2="Harcos" }, 
};

local QTR_race = UnitRace("player");
local QTR_class = UnitClass("player");

if (p_race[QTR_race]) then      
   player_race_table = { M1=p_race[QTR_race].M1, D1=p_race[QTR_race].D1, C1=p_race[QTR_race].C1, B1=p_race[QTR_race].B1, N1=p_race[QTR_race].N1, K1=p_race[QTR_race].K1, W1=p_race[QTR_race].W1, M2=p_race[QTR_race].M2, D2=p_race[QTR_race].D2, C2=p_race[QTR_race].C2, B2=p_race[QTR_race].B2, N2=p_race[QTR_race].N2, K2=p_race[QTR_race].K2, W2=p_race[QTR_race].W2 };
else   
   player_race_table = { M1=QTR_race, D1=QTR_race, C1=QTR_race, B1=QTR_race, N1=QTR_race, K1=QTR_race, W1=QTR_race, M2=QTR_race, D2=QTR_race, C2=QTR_race, B2=QTR_race, N2=QTR_race, K2=QTR_race, W2=QTR_race };
end
if (p_class[QTR_class]) then
   player_class_table = { M1=p_class[QTR_class].M1, D1=p_class[QTR_class].D1, C1=p_class[QTR_class].C1, B1=p_class[QTR_class].B1, N1=p_class[QTR_class].N1, K1=p_class[QTR_class].K1, W1=p_class[QTR_class].W1, M2=p_class[QTR_class].M2, D2=p_class[QTR_class].D2, C2=p_class[QTR_class].C2, B2=p_class[QTR_class].B2, N2=p_class[QTR_class].N2, K2=p_class[QTR_class].K2, W2=p_class[QTR_class].W2 };
else
   player_class_table = { M1=QTR_class, D1=QTR_class, C1=QTR_class, B1=QTR_class, N1=QTR_class, K1=QTR_class, W1=QTR_class, M2=QTR_class, D2=QTR_class, C2=QTR_class, B2=QTR_class, N2=QTR_class, K2=QTR_class, W2=QTR_class };
end

WOWTR_Font1 = WoWTR_Localization.mainFolder.."\\Fonts\\morpheus_hu.ttf";
WOWTR_Font2 = WoWTR_Localization.mainFolder.."\\Fonts\\frizquadrata_hu.ttf";
WOWTR_Fonts = {"frizquadrata_hu.ttf"};
local GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata;
WOWTR_version = GetAddOnMetadata(WoWTR_Localization.addonFolder, "Version");
