-- Description: Texts in the selected localization language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
-------------------------------------------------------------------------------------------------------

WoWTR_Localization = {
   lang = "PL",
   started = "uruchomiony",                                          -- addon was started
   mainFolder = "Interface\\AddOns\\WoWPL",                          -- origin main folder for addon files
   addonFolder = "WoWPL",                                            -- name of the folder where the addon was installed
   addonName = "WoWpoPolsku",                                        -- origin short name of the addon 
   addonIconDesc = "Kliknij, aby otworzyć\nmenu ustawień dodatku",   -- Click to open the settings menu 
   optionName = "WoWpoPolsku - ustawienia",                          -- WoWPL - options 
   optionTitle = "WoWpoPolsku",                                      -- origin full name 
   optionTitleAR = "",
   addressWWW = "https://www.wowpopolsku.pl/",                       -- address of project page 
   addressDiscord = "https://discord.gg/s5rKEJMukA",                 -- address of discord page 
   addressTwitch = "https://www.twitch.tv/kalinkus",                 -- address of Twitch page 
   addressFanPage = "https://www.facebook.com/fanpageWoWpoPolsku",   -- address of FanPage 
   addressEmail = "",                                                -- address of e-mail
   addressCurse = "https://www.curseforge.com/wow/addons/wowpopolsku",                -- address of CurseForge page
   addressPayPal = "https://www.paypal.com/donate/?hosted_button_id=MQY4PVV2CMZXS",   -- address of PayPal page
   addressBlik = "+48 601 635 712",                                  -- telephon number for BLIK payment
   gossipText = "Gossip",                                            -- gossip text 
   quests = "Zadania",                                               -- Quests 
   worldquests = "Światowe Zadania",                                 -- World Quests 
   campaignquests = "Zadania Kampanii",                              -- Campaign Quests
   scenariodung = "Scenariusz",                                      -- Scenario/Dungeon
   objectives = "Cele zadanie",                                      -- Objectives 
   bonusobjective = "Cel bonusowy",                                  -- Bonus Objective
   rewards = "Nagrody",                                              -- Rewards 
   storyLineProgress = "Postęp historii",                            -- Story Progress 
   storyLineChapters = "Rozdziały",                                  -- Chapters 
   choiceQuestFirst = "wybierz najpierw zadanie",                    -- choose a quest first 
   readyForTurnIn = "Gotowe do oddania",                             -- Ready for turn-in 
   clickToComplete = "kliknij, aby zakończyć",                       -- click to complete 
   failed = "Niepowodzenie",                                         -- Failed 
   optional = "Opcjonalne",                                          -- Optional 
   emptyProgress = "Dobrze ci idzie, $N",                            -- You are doing well, $N 
   bookID = "ID książki:",                                           -- Book ID:
   stopTheMovie = "Czy na pewno zatrzymać film?",                    -- Do you want to stop the video? 
   stopTheMovieYes = "Tak",                                          -- Yes 
   stopTheMovieNo = "Nie",                                           -- No 
   reopenBoard = "Otwórz ponownie tę tablicę",                       -- Reopen the Bulletin Board 
   sellPrice = "Cena skupu:",                                        -- Sell price:
   currentlyEquipped = "Aktualnie masz założone",                    -- Currently Equipped
   additionalEquipped = "Masz aktualnie także założone",             -- Equipped with additional Equipment
   WoWTR_trDESC = "Polski",                                          -- Polish
   WoWTR_enDESC = "English",                                         -- English
   WoWTR_Spellbook_trDESC = "Spell Book: Polski",                    -- Spell Book: Polish
   WoWTR_Spellbook_enDESC = "Spell Book: English",                   -- Spell Book: English
   your_home = "twojego domu",                                       -- 'your home' (if the Hearthstone location fails to be read)
   welcomeIconPos = 255,                                             -- position of welcome icon on the welcom panel; 0 = disabled to display
   resetButton1 = "Wyczyść zapisane nieprzetłumaczone teksty",       -- Clear saved untranslated texts (without polish font)
   resetButton2 = "Przywróc ustawienia|ndomyslne dodatku",           -- Reset the addon to its default settings (without polish font)
   resetButton1Opis = "Wyczyść zapisane nieprzetłumaczone teksty",   -- Clear saved untranslated texts (as tooltip)
   resetButton1OpisDESC = "Wszystkie zapisane dane z gry zostaną skasowane",   -- Reset the addon to its default settings (as tooltip)
   resetButton2Opis = "Przywróć ustawienia domyślne dodatku",        -- Reset the addon to its default settings (as tooltip)
   resetButton2OpisDESC = "Wszystkie ustawienia dodatku zostaną przywrócone do wartości domyślnych (wymagane będzie ponowne uruchomienie gry)",
   resultButton1 = "Wyczyszczono zapisane teksty",                   -- Saved texts cleared
   confirmationHeader = "Potwierdzenie",                             -- Confirmation Header
   confirmationText1 = "Czy chcesz wyczyścić wszystkie zapisane, nieprzetłumaczone teksty?",   -- Do you want to clear all saved untranslated texts?
   confirmationText2 = "Czy chcesz przywrócić ustawienia domyślne dodatku?",                   -- Do you want to restore the default settings of the addon?
   moveFrameUpDown = "Przesuń okno w górę lub w dół",                -- Move the window up or down
};

---------------------------------------------------------------------------------------------------------

QTR_Messages = {   
   isactive   = "jest aktywny",                                      -- (is active) 
   isinactive = "jest nieaktywny",                                   -- (is inactive) 
   missing    = "brak tłumaczenia",                                  -- (no translation) 
   details    = "Opis",                                              -- (Description) 
   progress   = "Postęp",                                            -- (Progress) 
   objectives = "Cele zadania",                                      -- (Objectives) 
   completion = "Zakończenie",                                       -- (Completion) 
   translator = "Tłumacz",                                           -- (Translator) 
   rewards    = "Nagrody",                                           -- (Rewards) 
   experience = "Doświadczenie:",                                    -- (Experience) 
   reqmoney   = "Wymagane pieniądze:",                               -- (Required money) 
   reqitems   = "Wymagane przedmioty:",                              -- (Required items) 
   itemchoose0= "Otrzymasz:",                                        -- (You will receive:) 
   itemchoose1= "Możesz wybrać jedną z nagród:",                     -- (You will be able to choose one of these rewards:) 
   itemchoose2= "Wybierz jedną z nagród:",                           -- (Choose one of these rewards:) 
   itemchoose3= "Otrzymujesz nagrodę:",                              -- (You receiving the reward:) 
   itemreceiv0= "Otrzymasz:",                                        -- (You will receive:) 
   itemreceiv1= "Otrzymasz również:",                                -- (You will also receive:) 
   itemreceiv2= "Otrzymujesz nagrodę:",                              -- (You receiving the reward:) 
   itemreceiv3= "Otrzymujesz również nagrodę:",                      -- (You also receiving the reward:) 
   learnspell = "Naucz się zaklęcia:",                               -- (Learn Spell:) 
   currquests = "Bieżące zadania",                                   -- (Current Quests) 
   avaiquests = "Dostępne zadania",                                  -- (Available Quests) 
   reward_aura      = "Otrzymasz efekt:",                            -- (The following will be cast on you:) 
   reward_spell     = "Nauczysz się:",                               -- (You will learn the following:) 
   reward_companion = "Zyskasz towarzyszy:",                         -- (You will gain these Companions:) 
   reward_follower  = "Zyskasz zwolenników:",                        -- (You will gain these followers:) 
   reward_reputation= "Wzrost reputacji:",                           -- (Reputation awards:) 
   reward_title     = "Otrzymasz tytuł:",                            -- (You shall be granted the title:) 
   reward_tradeskill= "Nauczysz się wytwarzania:",                   -- (You will learn how to create:) 
   reward_unlock    = "Odblokujesz:",                                -- (You will unlock access to the following:) 
   reward_bonus     = "Ukończenie tego zadania gdy jesteś w grupie może cię nagrodzić:",  -- (Completing this quest while in Party Sync may reward:) 
}; 

---------------------------------------------------------------------------------------------------------

WoWTR_Config_Interface = {
   showMinimapIcon = "Pokaż ikonę ustawień dodatku obok minimapy",                          -- Show the addon setting icon next to the minimap
   showMinimapIconDESC = "Jeśli jest włączona, obok minimapy pojawi się ikona ustawień dodatku",   -- If enabled, the addon settings icon will display next to the minimap
   
   titleTab1 = "Zadania",                                                                          -- Quests
   generalMainHeaderQS = "TŁUMACZENIE ZADAŃ",                                                      -- Quest translations
   activateQuestsTranslations = "Aktywuj tłumaczenie zadań",                                       -- Activate quest translations
   activateQuestsTranslationsDESC = "Jeśli zaznaczono, tłumaczenie zadania będzie wyświetlane w miejscu oryginalnego tekstu",   -- If enabled, quest translations will appear in place of the original texts
   translateQuestTitles = "Wyświetlaj tłumaczenie tytułów",                                        -- Display translations of quest TITLES 
   translateQuestTitlesDESC = "Jeśli zaznaczono, tłumaczenie tytułu zadania będzie wyświetlane",   -- If enabled, quest titles will be translated 
   translateGossipTexts = "Wyświetlaj tłumaczenia tekstów gossip",                                 -- Display translations of GOSSIP texts 
   translateGossipTextsDESC = "Jeśli zaznaczono, tłumaczenie tekst gossip będzie wyświetlane",     -- If enabled, gossip texts will be translated
   translateTrackObjectives = "Wyświetlaj tłumaczenia online w Objectives Tracker",                -- Display translations online in Objectives Tracker
   translateTrackObjectivesDESC = "Jeśli zaznaczono, teksty w Objectives Tracker będą wyświetlane",   -- If enabled, texts in Objectives Tracker will be translated
   translateOwnNames = "Wyświetlaj nazwy własne po polsku",                                        -- Display own mames in polish language
   translateOwnNamesDESC = "Jeśli zaznaczono, nazwy własne w grze będą wyświetlane po polsku",     -- If enabled, own names of cities, places etc. will displaying in polish language
   savingUntranslatedQuests = "ZAPIS NIEPRZETŁUMACZONYCH ZADAŃ    I GOSSIP",                       -- Saving untranslated quests and gossip texts
   saveUntranslatedQuests = "Zapisz nieprzetłumaczone zadania",                                    -- Save untranslated quests 
   saveUntranslatedQuestsDESC = "Jeśli zaznaczono, nieprzetłumaczone zadania zostana zapisane",    -- If enabled, untranslated quests will be saved 
   saveUntranslatedGossip = "Zapisz nieprzetłumaczone teksty gossip",                              -- Save untranslated gossip texts
   saveUntranslatedGossipDESC = "Jeśli zaznaczono, nieprzetłumaczone teksy gossip zostaną zapisane",  -- If enabled, untranslated gossip texts will be saved
   integrationWithOtherAddons = "INTEGRACJA Z INNYMI DODATKAMI",                                   -- Integration with other addons
   translateImmersion = "Wyświetlaj tłumaczenia w dodatku Immersion",                              -- Display translations in Immersion addon
   translateImmersionDESC = "Jeśli zaznaczono, tłumaczenia będą wyświetlane w dodatku Immersion",  -- If enabled, texts in Immersion addon will be translated
   translateStoryLine = "Wyświetlaj tłumaczenia w dodatku StoryLine",                              -- Display translations in StoryLine addon
   translateStoryLineDESC = "Jeśli zaznaczono, tłumaczenia będą wyświetłane w dodatku StoryLine",  -- If enabled, texts in StoryLine addon will be translated
   translateQuestLog = "Wyświetlaj tłumaczenia w dodatku ClassicQuestLog",                         -- Display translations in Classic Quest Log addon
   translateQuestLogDESC = "Jeśli zaznaczono, tłumaczenia będą wyświetlane w dodatku ClassicQuestLog",   -- If enabled, texts in Classic Quest Log addon will be translated
   translateDialogueUI = "Wyświetlaj tłumaczenia w dodatku DialogueUI",                            -- Display translations in DialogueUI addon
   translateDialogueUIDESC = "Jeśli zaznaczono, tłumaczenia będą wyświetlane w dodatku DialogueUI",   -- If enabled, texts in DialogueUI addon will be translated
   sampleGossipText = "Przykładowy tekst|nrozmiaru czcionki Gossip",                               -- Sample Gossip font size text (TR:Gossip Örnek yazı tipi boyutu metni)

   titleTab2 = "Dymki",                                                                            -- Bubbles 
   generalMainHeaderBB = "TŁUMACZENIA DYMKÓW",                                                     -- Bubbles translations
   activateBubblesTranslations = "Aktywuj tłumaczenie dymków",                                     -- Activate bubble translations 
   activateBubblesTranslationsDESC = "Jeśli zaznaczono, tłumaczenia dymków będą wyświetlane w miejscu oryginalnego tekstu",   -- If enabled, bubble translations will appear in place of the original texts
   displayOriginalTexts = "Wyświetlaj oryginalny tekst dymku w oknie czatu",                       -- Display original text in chat frame
   displayOriginalTextsDESC = "Jeśli zaznaczono, oryginalny tekst dymku będzie wyświetlany w oknie czatu",   -- If enabled, original texts of bullbe will be displayed 
   displayTranslatedTexts = "Wyświetlaj tekst tłumaczenia dymku w oknie czatu",                    -- Display translated text in chat frame 
   displayTranslatedTextsDESC = "Jeśli zaznaczono, tekst tłumaczenia dymku będzie wyświetlany w oknie czatu", -- If enabled, translated texts will be displayed
   choiceGender1OfPlayer = "Wybierz męską formę wypowiedzi do gracza",                             -- Choice of male expression to the player 
   choiceGender1OfPlayerDESC = "Jeśli zaznaczono, wypowiedzi kierowane do gracza wyświetlane będą w formie męskiej",   -- If enabled, translated bubbles will be displayed in male form 
   choiceGender2OfPlayer = "Wybierz żeńską formę wypowiedzi do gracza",                            -- Choice of female expression to the player 
   choiceGender2OfPlayerDESC = "Jeśli zaznaczono, wypowiedzi kierowane do gracza wyświetlane będą w formie żeńskiej",   -- If enabled, translated bubbles will be displayed in female form 
   choiceGender3OfPlayer = "Wybierz formę wypowiedzi do gracza zależną od płci postaci w grze",    -- Choise of expression for the player depending on the gender of the character 
   choiceGender3OfPlayerDESC = "Jeśli zaznaczono, wypowiedzi kierowane do gracza wyświetlane będą w formie zależnej od płci postaci w grze",   -- If enbled, translated bubbles will be displayed in male form 
   showBubblesInDungeon = "Pokaż dymki w lochach",                                                 -- Show bubbles in dungeons
   showBubblesInDungeonDESC = "Jeśli zaznaczono, to będą pokazywane dymki w lochach we własnych 5 ramkach na górze ekranu",   -- If checked, dungeon bubbles will be shown in their own 5 frames at the top of the screen
   setDungeonFrames = "Ustaw okna dymków",                                                         -- Set up speech bubble frames
   setDungeonFramesDESC = "Po zaznaczeniu można będzie ustawiać w pionie okna dymków w lochach",   -- When checked, you will be able to vertically align the bubble windows in dungeons
   savingUntranslatedBubbles = "ZAPIS NIEPRZETŁUMACZONYCH DYMKÓW",                                 -- Saving untranslated bubbles
   saveUntranslatedBubbles = "Zapisz nieprzetłumaczone dymki",                                     -- Save untranslated bubbles 
   saveUntranslatedBubblesDESC = "Jeśli zaznaczono, nieprzetłumaczone dymki będą zapisywane",      -- If enabled, untranslated bubbles will be saved 
   fontSizeHeader = "WIELKOŚĆ CZCIONKI WYŚWIETLANYCH TEKSTÓW",                                     -- Font size of bubbles
   setFontActivate = "Aktywuj zmianę wielkości czcionki tekstu",                                   -- Activate font size changes 
   setFontActivateDESC = "Jeśli zaznaczono, wielkość czcionki tekstu będzie ustawiona na poniższą wartość",   -- If enabled, font size will be set to below value   
   fontsizeBubbles = "Wybierz wielkość czcionki",                                                  -- Choose a font size 
   fontsizeBubblesDESC = "Wielkość czcionki jest liczbą pomiędzy 10 i 20",                         -- The font size is a number between 10 and 20
   sampleText = "Przykładowy tekst wielkości czcionki",                                            -- Sample font size text
   timerDisplay = "Czas wyświetlania tłumaczenia",                                                 -- Translation display time

   titleTab3 = "Filmy",                                                                            -- Movies & Cinematics
   generalMainHeaderMF = "TŁUMACZENIA NAPISÓW DO FILMÓW",                                          -- Subtitle translations
   activateSubtitleTranslations = "Aktywuj tłumaczenie napisów",                                   -- Activate subtitle translations
   activateSubtitleTranslationsDESC = "Jeśli zaznaczono, tłumaczenia napisów będą wyświetlane na filmach i cinematikach",  -- If enabled, translated subtitles will displayed
   subtitleIntro = "Wyświetlaj tłumaczenia napisów w intro",                                       -- Display translated subtitles of Intro
   subtitleIntroDESC = "Jeśli zaznaczono, tłumaczenia napisów w tekstach początkowych postaci (INTRO) będą wyświetlane",   -- If enbled, translated subtitles will be displyed into starting Intro
   subtitleMovies = "Wyświetlaj tłumaczenia napisów w filmach",                                    -- Display translated subtitles of Movies
   subtitleMoviesDESC = "Jeśli zaznaczono, tłumaczenia napisów w filmach będą wyświetlane",        -- If enabled, translated subtitles will be displyed into movies 
   subtitleCinematics = "Wyświetlaj tłumaczenia napisów w cinematikach",                           -- Display translated subtitles of Cinematics
   subtitleCinematicsDESC = "Jeśli zaznaczono, tłumaczenia napisów w cinematikach będą wyświetlane",   -- If enbled, translated subtitles will be displyed into cinematics 
   savingUntranslatedSubtitles = "ZAPIS NIEPRZETŁUMACZONYCH NAPISÓW",                              -- Saving untranslated subtitles 
   saveUntranslatedSubtitles = "Zapisz nieprzetłumaczone napisy",                                  -- Save untranslated subtitles
   saveUntranslatedSubtitlesDESC = "Jeśli zaznaczono, nieprzetłumaczone napisy będą zapisywane",   -- If enbled, untranslated subtitles will be saved
   chatService = "Service of arabic chat",
   activateChatService = "Activate of arabic chat",
   activateChatServiceDESC = "If enabled, arabic chat is active",
   chatFontActivate = "Activate font size changes",
   chatFontActivateDESC = "If enabled, font size will be set to below value",
   fontsizeChat = "Choose a font size",
   fontsizeChatDESC = "The font size is a number between 10 and 20",

   titleTab4 = "Ustawienia UI",                                                                    -- Ustawienia Interfejsu Użytkownika
   generalMainHeaderTT = "TŁUMACZENIA SAMOUCZKA",                                                  -- Tutorial translations
   activateTutorialTranslations = "Aktywuj tłumaczenie tekstów samouczka",                         -- Activate tutorial translations
   activateTutorialTranslationsDESC = "Jeśli zaznaczono, tłumaczenia tekstów samouczka będą wyświetlane",  -- If enabled, translated tutorials will displayed
   savingUntranslatedTutorials = "ZAPIS NIEPRZETŁUMACZONYCH TEKSTÓW",                              -- Saving untranslated tutorials
   saveUntranslatedTutorials = "Zapisz nieprzetłumaczone teksty samouczka",                        -- Save untranslated tutorials
   saveUntranslatedTutorialsDESC = "Jeśli zaznaczono, nieprzetłumaczone teksty samouczka zostaną zapisane",  -- If enbled, untranslated tutorials will be saved
   fontSelectingFontHeader = "WYBÓR CZCIONKI TŁUMACZENIA",                                         -- Font selection for the main texts of the translation
   fontSelectFontFile = "Wybierz plik czcionki",                                                   -- Select a font file
   fontCurrentFont = "Aktualna czcionka:",                                                         -- Current font:

   translationUI = "INTERFEJS UŻYTKOWNIKA - UI",                                                   -- Translation of user interface
   savingTranslationUI = "ZAPIS DANYCH",                                                           -- Saving untanslated user interface
   saveTranslationUI = "Zapisz nieprzetłumaczone elementy interfejsu",                             -- Save untranslated user interface
   saveTranslationUIDESC = "Jeśli zaznaczono, nieprzetłumaczone elementy interfejsu użytkownika będą zapisywane",   -- If enabled, untranslated user interface will be saving
   ReloadButtonUI = "Kliknij, aby zastosowac ustawienia \"Reload UI\"",                            -- Click to apple the setting "ReloadUI" (bez polskich znaków)
   displayTranslationtxt = "Wybierz, które tłumaczenia chcesz aktywować:",                         -- Display whith translations do you want to translate:
   displayTranslationUI1 = "Menu Gry",                                                             -- Game Menu
   displayTranslationUI1DESC = "Menu gry i jego zawartość będą teraz wyświetlane w języku polskim",  -- If enabled, user interface will be displayed in translation
   displayTranslationUI2 = "Informacje o postaci",                                                 -- Character Info
   displayTranslationUI2DESC = "Interfejs informacji o postaci pojawi się w języku polskim",       -- If enabled, user interface will be displayed in translation
   displayTranslationUI3 = "Wyszukiwarka grup",                                                    -- Group Finder
   displayTranslationUI3DESC = "Wyszukiwarka grup i jej podzakładki będą teraz wyświetlane w języku polskim",   -- If enabled, user interface will be displayed in translation
   displayTranslationUI4 = "Kolekcje",                                                             -- Collections
   displayTranslationUI4DESC = "Strona Kolekcji i jej zawartość będą teraz wyświetlane w języku polskim",       -- If enabled, user interface will be displayed in translation
   displayTranslationUI5 = "Przewodnik po przygodach",                                             -- Adventure Guide
   displayTranslationUI5DESC = "Przewodnik Przygód i jego podstrony będą teraz wyświetlane w języku polskim",   -- If enabled, user interface will be displayed in translation
   displayTranslationUI6 = "Lista przyjaciół",                                                     -- Friend List
   displayTranslationUI6DESC = "Zawartość listy znajomych będzie teraz wyświetlana w języku polskim",           -- If enabled, user interface will be displayed in translation
   displayTranslationUI7 = "Zawód",                                                                -- Profession
   displayTranslationUI7DESC = "Zawód i jego treść będą teraz wyświetlane w języku polskim",       -- If enabled, user interface will be displayed in translation
   displayTranslationUI8 = "Filtrowanie i listy rozwijane",                            -- Filter & Open List
   displayTranslationUI8DESC = "Menu filtrów i list rozwijanych będzie teraz wyświetlane w języku polskim",   -- If enabled, user interface will be displayed in translation

   titleTab5 = "Książki",                                                                          -- Books (header of Tab)
   generalMainHeaderBT = "TŁUMACZENIE KSIĄŻEK",                                                    -- Books translations
   activateBooksTranslations = "Aktywuj tłumaczenie książek",                                      -- Activate book translations
   activateBooksTranslationsDESC = "Jeśli zaznaczono, tłumaczenie książek będzie wyświetlane w miejscu oryginalnego tekstu",   -- If enabled, book translations will appear in place of the original texts
   translateBookTitles = "Wyświetlaj tłumaczenie tytułu książki",                                  -- Display translations of book TITLES
   translateBookTitlesDESC = "Jeśli zaznaczono, tłumaczenie tytułu książki zostanie wyświetlone",  -- If enabled, book titles will be translated 
   showBookID = "Pokaż ID książki",                                                                -- Show ID of book
   showBookIDDESC = "Jeśli zaznaczono, ID książki zostanie wyświetlone",                           -- If enabled, ID of book will be shown
   savingUntranslatedBooks = "ZAPIS NIEPRZETŁUMACZONYCH KSIĄŻEK",                                  -- Saving untranslated books
   saveUntranslatedBooks = "Zapisz nieprzetłumaczone książki",                                     -- Save untranslated books
   saveUntranslatedBooksDESC = "Jeśli zaznaczono, nieprzetłumaczone teksty książek zostaną zapisane",   -- If enabled, untranslated books will be saved 

   titleTab6 = "Podpowiedzi",                                                                      -- Tooltips
   generalMainHeaderST = "TŁUMACZENIA PODPOWIEDZI (|cffff00ffwczesna faza tłumaczeń|r)",                                                -- Tooltip translations
   activateTooltipTranslations = "Aktywuj tłumaczenie podpowiedzi",                                -- Activate tooltip translations
   activateTooltipTranslationsDESC = "Jeśli zaznaczono, tłumaczenia tekstów podpowiedzi będą wyświetlane w miejscu oryginalnego tekstu",  -- If enabled, translated tooltips will displayed
   translateItems = "Wyświetlaj tłumaczenia przedmiotów",                                          -- Display translated tooltips for items
   translateItemsDESC = "Jeśli zaznaczono, tłumaczenia przedmiotów będą wyświetlane",              -- If enabled, translated tooltips for items will be displayed
   translateSpells = "Wyświetlaj tłumaczenia czarów",                                              -- Display translated tooltips for spells 
   translateSpellsDESC = "Jeśli zaznaczono, tłumaczenia czarów będą wyświetlane",                  -- If enabled, translated tooltips for spells will be displayed
   translateTalents = "Wyświetlaj tłumaczenia talentów",                                           -- Display translated tooltips for talents 
   translateTalentsDESC = "Jeśli zaznaczono, tłumaczenia talentów będą wyświetlane",               -- If enabled, translated tooltips for talents will be displayed
   translateTooltipTitle = "Wyświetlaj tłumaczenia tytułów przedmiotów, czarów lub talentów",      -- Display translated title of item, spell or talent
   translateTooltipTitleDESC = "Jeśli zaznaczono, tłumaczenia tytułów przedmiotów, czarów lub talentów będą wyświetlane",  -- If enabled, translated title of tooltips will be displayed
   showTooltipID = "Pokaż ID podpowiedzi",                                                         -- Show tooltips ID
   showTooltipIDDESC = "Jeśli zaznaczono, ID podpowiedzi zostanie wyświetlony",                    -- If enabled, display tooltips ID 
   showTooltipHash = "Pokaż HASH tekstu podpowiedzi",                                              -- Show tooltips Hash
   showTooltipHashDESC = "Jeśli zaznaczono, HASH tekstu podpowiedzi zostanie wyświetlony",         -- If enabled, display tooltips Hash
   hideSellPrice = "Ukryj cenę skupu przedmiotu",                                                  -- Hide sell price of items
   hideSellPriceDESC = "Jeśli zaznaczono, cena skupu przedmiotu nie będzie wyświetlana",           -- If enabled, sell price of items will be hidden
   timerHoldTranslation = "ZATRZYMAJ RENDEROWANIE TŁUMACZENIA",                                    -- Suspend the translation display
   timerLimitSeconds = "Wybierz czas zatrzymania tłumaczenia",                                     -- Select a translation hold time
   timerLimitSecondsDESC = "Czas jest liczbą pomiędzy 5 i 30",                                     -- The times is a number between 5 and 30
   displayTranslationConstantly = "Wyświetl tłumaczenie w sposób ciągły",                          -- Display translation constantly
   displayTranslationConstantlyDESC = "Jeśli zaznaczono, dodatek będzie się starać przeciwdziałać efektom odświeżania treści podpowiedzi",                          -- Description of option 'displayTranslationConstantly'
   savingUntranslatedTooltips = "ZAPIS NIEPRZETŁUMACZONYCH PODPOWIEDZI",                           -- Saving untranslated tooltips
   saveUntranslatedTooltips = "Zapisz nieprzetłumaczone podpowiedzi",                              -- Save untranslated tooltips
   saveUntranslatedTooltipsDESC = "Jeśli zaznaczono, nieprzetłumaczone podpowiedzi zostaną zapisane",   -- If enabled, untranslated tooltips will be saved

   titleTab9 = "O dodatku",                                                                        -- About
   generalText = "\nWoWpoPolsku to projekt spolszczenia gry World of Warcraft.\nElementy gry wyświetlane po polsku to: zadania, teksty gossip podczas rozmowy z NPC, dymki wypowiedzi wyświetlanie przez NPC, teksty samouczka w grze, teksty podpowiedzi, a także napisy do filmów i cinematików oraz tłumaczenie książek napotkanych w grze.",   -- info about project
   welcomeText = "Witamy w dodatku |cffff00ffWoWpoPolsku|r. To jest pierwsze uruchomienie dodatku i prosimy o zapoznanie się z naszym wprowadzeniem.\n\nJest to nowy dodatek wyświetlający tłumaczenia tekstów gry po polsku. Powstał z połączenia poszczególnych części składowych projektu WoWpoPolsku i zawiera następujące części:\n\n|cff00ffffZadania|r - podczas rozmowy z NPC oraz w Quest Logu\n|cff00ffffGossip|r - teksty wyświetlane podczas rozmowy z NPC\n|cff00ffffDymki|r - wypowiedzi NPC w formie dymku nad postacią\n|cff00ffffNapisy|r - napisy do wyświetlanych filmów i cinematików w grze\n|cff00ffffSamouczek|r - teksty uczące, jak obsługiwać grę\n|cff00ffffPodpowiedzi|r - teksty wyświetlane po najechaniu myszką na jakiś przedmiot, czar lub talent\n|cff00ffffKsiążki|r - tłumaczenie tekstu książek, jakie można spotkać w grze\n\nKażdy z tych elementów można oddzielnie konfigurować w panelu ustawień dodatku - najszybciej wywołać go poprzez kliknięcię na małą ikonę dodatku umieszczoną przy minimapie.\n\n\nAby móc rozwijać projekt, bylibyśmy wdzięczni za Twoje wsparcie.\n\nPotrzebni są |cffff00fftłumacze|r języka angielskiego, |cffff00ffzbieracze|r danych z gry, a także |cffff00ffdotacje|r finansowe na utrzymanie serwera projektu. Wszelkie informacje są dostępne na naszym forum: |cffff00ffhttps://wowpopolsku.pl|r\nDla ułatwienia wsparcia finansowego uruchomiliśmy możliwość wpłat |cff00ffffBLIK|riem na nr tel. |cff00ffff+48 601 635 712|r.",
   welcomeButton = "OK - przeczytane",                                                             -- Button: Close welcome panel
   showWelcome = "Pokaż panel powitalny",                                                          -- Button: Show welcome panel
   authorHeader = "INFORMACJA O AUTORZE",                                                          -- Author info
   author = "Autor:",                                                                              -- Author: 
   email = "E-mail:",                                                                              -- E-mail: 
   teamHeader = "PROJEKT WoWpoPolsku KONTAKT",                                                     -- WoWTR project team (TR:WoWTR)
   textContact = "Jeśli masz jakieś pytania odnośnie dodatku - prosimy o kontakt na dowolnym kanale poniżej:",
   linkWWWShow = "Kliknij, aby wyświetlić link do strony |cffffff00WWW|r dodatku",
   linkWWWTitle = "Link do strony WWW",
   linkDISCShow = "Kliknij, aby wyświetlić link do strony |cffffff00Discord|r",
   linkDISCTitle = "Link do strony Discord",
   linkEMAILShow = "Kliknij, aby wyświetlić adres |cffffff00e-mail|r projektu",
   linkEMAILTitle = "Adres e-mail projektu",
   linkCURSEShow = "Kliknij, aby wyświetlić link do strony |cffffff00CurseForge|r",
   linkCURSETitle = "Link do strony CurseForge",
   linkPPShow = "Kliknij, aby wyświetlić link do strony |cffffff00PayPal|r",
   linkPPTitle = "Link do strony PayPal",
   linkBLIKShow = "Kliknij, aby wyświetlić numer telefonu |cffffff00BLIK|r",
   linkBLIKTitle = "Numer telefonu BLIK",
   linkTWITCHShow = "Kliknij, aby wyświetlić link do strony |cffffff00Twitch|r",
   linkTWITCHTitle = "Link do strony Twitch",
   linkFBShow = "Kliknij, aby wyświetlić link do strony |cffffff00FanPage|r",
   linkFBTitle = "Link do strony FanPage",
   linkCloseFrame = "Zamknij ramkę",
   linkCopy = "Wciśnij |cff00ffffCtr+C|r aby skopiować link do schowka Windowsa",      -- Press Ctrl+C to copy the address to the clipboard
   betaTestersHeader = "EKIPA WoWpoPolsku:",                                                       -- TRANSLATION TEAM
   betaTestersHeaderDESC = "Moderatorzy: |cffff00ffOrina|r, |cffff00ffShaula|r, |cffff00ffErdzio|r, |cffff00ffPikownia|r\n\nBeta Testerzy: |cffff00ffBorygo|r, |cffff00ffKalinkuss|r\n\n|cffffff00Tłumaczenia zawierające na końcu znacznik [AI] zostały przetłumaczone przez Sztuczną\nInteligencję i nie zostały jeszcze sprawdzone przez naszych moderatorów.|r",    -- Translators and Beta testers:
};

---------------------------------------------------------------------------------------------------------

-- translated names of the player's races and classes in various cases of the noun variant (M1,D1,C1,B1,N1,K1,W1;M2,D2,C2,B2,N2,K2,W2) and the player's gender (male:1, female:2)


local p_race = {
      ["Blood Elf"] = { M1="Krwawy Elf", D1="krwawego elfa", C1="krwawemu elfowi", B1="krwawego elfa", N1="krwawym elfem", K1="krwawym elfie", W1="Krwawy Elfie", M2="Krwawa Elfka", D2="krwawej elfki", C2="krwawej elfce", B2="krwawą elfkę", N2="krwawą elfką", K2="krwawej elfce", W2="Krwawa Elfko" }, 
      ["Dark Iron Dwarf"] = { M1="Krasnolud Ciemnego Żelaza", D1="krasnoluda Ciemnego Żelaza", C1="krasnoludowi Ciemnego Żelaza", B1="krasnoluda Ciemnego Żelaza", N1="krasnoludem Ciemnego Żelaza", K1="krasnoludzie Ciemnego Żelaza", W1="Krasnoludzie Ciemnego Żelaza", M2="Krasnoludzica Ciemnego Żelaza", D2="krasnoludzicy Ciemnego Żelaza", C2="krasnoludzicy Ciemnego Żelaza", B2="krasnoludzicę Ciemnego Żelaza", N2="krasnoludzicą Ciemnego Żelaza", K2="krasnoludzicy Ciemnego Żelaza", W2="Krasnoludzico Ciemnego Żelaza" },
      ["Dracthyr"] = { M1="Draktyr", D1="draktyra", C1="draktyrowi", B1="draktyra", N1="draktyrem", K1="draktyrze", W1="Draktyrze", M2="Draktyrka", D2="draktyrki", C2="draktyrce", B2="draktyrkę", N2="draktyrką", K2="draktyrce", W2="Draktyrko" },
      ["Draenei"] = { M1="Draenei", D1="draeneia", C1="draeneiowi", B1="draeneia", N1="draeneiem", K1="draeneiu", W1="Draeneiu", M2="Draeneika", D2="draeneiki", C2="draeneice", B2="draeneikę", N2="draeneiką", K2="draeneice", W2="Draeneiko" },
      ["Dwarf"] = { M1="Krasnolud", D1="krasnoluda", C1="krasnoludowi", B1="krasnoluda", N1="krasnoludem", K1="krasnoludzie", W1="Krasnoludzie", M2="Krasnoludzica", D2="krasnoludzicy", C2="krasnoludzicy", B2="krasnoludzicę", N2="krasnoludzicą", K2="krasnoludzicy", W2="Krasnoludzico" },
      ["Earthen"] = { M1="Ziemny", D1="zmiemnego", C1="ziemnemu", B1="ziemnego", N1="ziemnym", K1="ziemnym", W1="Ziemny", M2="Ziemna", D2="ziemnej", C2="ziemnej", B2="ziemną", N2="ziemną", K2="ziemnej", W2="Ziemna" },
      ["Gnome"] = { M1="Gnom", D1="gnoma", C1="gnomowi", B1="gnoma", N1="gnomem", K1="gnomie", W1="Gnomie", M2="Gnomka", D2="gnomki", C2="gnomce", B2="gnomkę", N2="gnomką", K2="gnomce", W2="Gnomko" },
      ["Goblin"] = { M1="Goblin", D1="goblina", C1="goblinowi", B1="goblina", N1="goblinem", K1="goblinie", W1="Goblinie", M2="Goblinka", D2="goblinki", C2="goblince", B2="goblinkę", N2="goblinką", K2="goblince", W2="Goblinko" },
      ["Highmountain Tauren"] = { M1="Tauren z Wysokiej Góry", D1="taurena z Wysokiej Góry", C1="taurenowi z Wysokiej Góry", B1="taurena z Wysokiej Góry", N1="taurenen z Wysokiej Góry", K1="taurenie z Wysokiej Góry", W1="Taurenie z Wysokiej Góry", M2="Taurenka z Wysokiej Góry", D2="taurenki z Wysokiej Góry", C2="taurence z Wysokiej Góry", B2="taurenkę z Wysokiej Góry", N2="taurenką z Wysokiej Góry", K2="taurence z Wysokiej Góry", W2="Taurenko z Wysokiej Góry" },
      ["Human"] = { M1="Człowiek", D1="człowieka", C1="człowiekowi", B1="człowieka", N1="człowiekiem", K1="człowieku", W1="Człowieku", M2="Człowiek", D2="człowieka", C2="człowiekowi", B2="człowieka", N2="człowiekiem", K2="człowieku", W2="Człowieku" },
      ["Kul Tiran"] = { M1="Kul Tiran", D1="Kul Tirana", C1="Kul Tiranowi", B1="Kul Tirana", N1="Kul Tiranem", K1="Kul Tiranie", W1="Kul Tiranie", M2="Kul Tiranka", D2="Kul Tiranki", C2="Kul Tirance", B2="Kul Tirankę", N2="Kul Tiranką", K2="Kul Tirance", W2="Kul Tiranko" },
      ["Lightforged Draenei"] = { M1="Świetlisty Draenei", D1="świetlistego draeneia", C1="świetlistemu draeneiowi", B1="świetlistego draeneia", N1="świetlistym draeneiem", K1="świetlistym draeneiu", W1="Świetlisty Draeneiu", M2="Świetlista Draeneika", D2="świetlistej draeneiki", C2="świetlistej draeneice", B2="świetlistą draeneikę", N2="świetlistą draeneiką", K2="świetlistej draeneice", W2="Świetlista Draeneiko" },
      ["Mag'har Orc"] = { M1="Ork z Mag'har", D1="orka z Mag'har", C1="orkowi z Mag'har", B1="orka z Mag'har", N1="orkiem z Mag'har", K1="orku z Mag'har", W1="Orku z Mag'har", M2="Orczyca z Mag'har", D2="orczycy z Mag'har", C2="orczycy z Mag'har", B2="orczycę z Mag'har", N2="orczycą z Mag'har", K2="orczyce z Mag'har", W2="Orczyco z Mag'har" },
      ["Mechagnome"] = { M1="Mechagnom", D1="mechagnoma", C1="mechagnomowi", B1="mechagnoma", N1="mechagnomem", K1="mechagnomie", W1="Mechagnomie", M2="Mechagnomka", D2="mechagnomki", C2="mechagnomce", B2="mechagnomkę", N2="mechagnomką", K2="mechagnomce", W2="Mechagnomko" },
      ["Nightborne"] = { M1="Dziecię Nocy", D1="dziecięcia nocy", C1="dziecięciu nocy", B1="dziecię nocy", N1="dziecięcem nocy", K1="dziecięciu nocy", W1="Dziecię Nocy", M2="Dziecię Nocy", D2="dziecięcia nocy", C2="dziecięciu nocy", B2="dziecię nocy", N2="dziecięcem nocy", K2="dziecięciu nocy", W2="Dziecię Nocy" },
      ["Night Elf"] = { M1="Nocny Elf", D1="nocnego elfa", C1="nocnemu elfowi", B1="nocnego elfa", N1="nocnym elfem", K1="nocnym elfie", W1="Nocny Elfie", M2="Nocna Elfka", D2="nocnej elfki", C2="nocnej elfce", B2="nocną elfkę", N2="nocną elfką", K2="nocnej elfce", W2="Nocna Elfko" },
      ["Orc"] = { M1="Ork", D1="orka", C1="orkowi", B1="orka", N1="orkiem", K1="orku", W1="Orku", M2="Orczyca", D2="orczycy", C2="orczycy", B2="orczycę", N2="orczycą", K2="orczycy", W2="Orczyco" },
      ["Pandaren"] = { M1="Pandaren", D1="pandarena", C1="pandarenowi", B1="pandarena", N1="pandarenem", K1="pandarenie", W1="Pandarenie", M2="Pandarenka", D2="pandarenki", C2="pandarence", B2="pandarenkę", N2="pandarenką", K2="pandarence", W2="Pandarenko" },
      ["Tauren"] = { M1="Tauren", D1="taurena", C1="taurenowi", B1="taurena", N1="taurenem", K1="taurenie", W1="Taurenie", M2="Taurenka", D2="taurenki", C2="taurence", B2="taurenkę", N2="taurenką", K2="taurence", W2="Taurenko" },
      ["Troll"] = { M1="Troll", D1="trolla", C1="trollowi", B1="trolla", N1="trollem", K1="trollu", W1="Trollu", M2="Trollica", D2="trollicy", C2="trollicy", B2="trollicę", N2="trollicą", K2="trollicy", W2="Trollico" },
      ["Undead"] = { M1="Nieumarły", D1="nieumarłego", C1="nieumarłemu", B1="nieumarłego", N1="nieumarłym", K1="nieumarłym", W1="Nieumarły", M2="Nieumarła", D2="nieumarłej", C2="nieumarłej", B2="nieumarłą", N2="nieumarłą", K2="nieumarłej", W2="Nieumarła" },
      ["Void Elf"] = { M1="Elf Pustki", D1="elfa Pustki", C1="elfowi Pustki", B1="elfa Pustki", N1="elfem Pustki", K1="elfie Pustki", W1="Elfie Pustki", M2="Elfka Pustki", D2="elfki Pustki", C2="elfce Pustki", B2="elfkę Pustki", N2="elfką Pustki", K2="elfce Pustki", W2="Elfko Pustki" },
      ["Vulpera"] = { M1="Lisołak", D1="lisołaka", C1="lisołakowi", B1="lisołaka", N1="lisołakiem", K1="lisołaku", W1="Lisołaku", M2="Lisołaczka", D2="lisołaczki", C2="lisołaczce", B2="lisołaczkę", N2="lisołaczką", K2="lisołaczce", W2="Lisołaczko" },
      ["Worgen"] = { M1="Worgen", D1="worgena", C1="worgenowi", B1="worgena", N1="worgenem", K1="worgenie", W1="Worgenie", M2="Worgenka", D2="worgenki", C2="worgence", B2="worgenkę", N2="worgenką", K2="worgence", W2="Worgenko" },
      ["Zandalari Troll"] = { M1="Troll Zandalari", D1="trolla Zandalari", C1="trollowi Zandalari", B1="trolla Zandalari", N1="trollem Zandalari", K1="trollu Zandalari", W1="Trollu Zandalari", M2="Trollica Zandalari", D2="trollicy Zandalari", C2="trollicy Zandalari", B2="trollicę Zandalari", N2="trollicą Zandalari", K2="trollicy Zandalari", W2="Trollico Zandalari" },
};
local p_class = {
      ["Death Knight"] = { M1="Rycerz Śmierci", D1="rycerz śmierci", C1="rycerzowi śmierci", B1="rycerza śmierci", N1="rycerzem śmierci", K1="rycerzu śmierci", W1="Rycerzu Śmierci", M2="Rycerz Śmierci", D2="rycerz śmierci", C2="rycerzowi śmierci", B2="rycerza śmierci", N2="rycerzem śmierci", K2="rycerzu śmierci", W2="Rycerzu Śmierci" },
      ["Demon Hunter"] = { M1="Łowca demonów", D1="łowcy demonów", C1="łowcy demonów", B1="łowcę demonów", N1="łowcą demonów", K1="łowcy demonów", W1="Łowco demonów", M2="Łowczyni demonów", D2="łowczyni demonów", C2="łowczyni demonów", B2="łowczynię demonów", N2="łowczynią demonów", K2="łowczyni demonów", W2="Łowczyni demonów" },
      ["Druid"] = { M1="Druid", D1="druida", C1="druidowi", B1="druida", N1="druidem", K1="druidzie", W1="Druidzie", M2="Druidka", D2="druidki", C2="druidce", B2="druidkę", N2="druidką", K2="druidce", W2="Druidko" },
      ["Evoker"] = { M1="Przywoływacz", D1="przywoływacza", C1="przywoływaczowi", B1="przywoływacza", N1="przywoływaczem", K1="przywoływaczu", W1="Przywoływaczu", M2="Przywoływaczka", D2="przywoływaczki", C2="przywoływaczce", B2="przywoływaczkę", N2="przywoływaczką", K2="przywoływaczce", W2="przywoływaczko" },
      ["Hunter"] = { M1="Łowca", D1="łowcy", C1="łowcy", B1="łowcę", N1="łowcą", K1="łowcy", W1="Łowco", M2="Łowczyni", D2="łowczyni", C2="łowczyni", B2="łowczynię", N2="łowczynią", K2="łowczyni", W2="Łowczyni" },
      ["Mage"] = { M1="Mag", D1="maga", C1="magowi", B1="maga", N1="magiem", K1="magu", W1="Magu", M2="Maginia", D2="magini", C2="maginią", B2="maginię", N2="maginią", K2="magini", W2="Maginio" },
      ["Monk"] = { M1="Mnich", D1="mnicha", C1="mnichowi", B1="mnicha", N1="mnichem", K1="mnichu", W1="Mnichu", M2="Mniszka", D2="mniszki", C2="mniszce", B2="mniszkę", N2="mniszką", K2="mniszce", W2="Mniszko" },
      ["Paladin"] = { M1="Paladyn", D1="paladyna", C1="paladynowi", B1="paladyna", N1="paladynem", K1="paladynie", W1="Paladynie", M2="Paladynka", D2="paladynki", C2="paladynce", B2="paladynkę", N2="paladynką", K2="paladynce", W2="Paladynko" },
      ["Priest"] = { M1="Kapłan", D1="kapłana", C1="kapłanowi", B1="kapłana", N1="kapłanem", K1="kapłanie", W1="Kapłanie", M2="Kapłanka", D2="kapłanki", C2="kapłance", B2="kapłankę", N2="kapłanką", K2="kapłance", W2="Kapłanko" },
      ["Rogue"] = { M1="Łotrzyk", D1="łotrzyka", C1="łotrzykowi", B1="łotrzyka", N1="łotrzykiem", K1="łotrzyku", W1="Łotrzyku", M2="Łotrzyca", D2="łotrzycy", C2="łotrzycy", B2="łotrzycę", N2="łotrzycą", K2="łotrzycy", W2="Łotrzyco" },
      ["Shaman"] = { M1="Szaman", D1="szamana", C1="szamanowi", B1="szamana", N1="szamanem", K1="szamanie", W1="Szamanie", M2="Szamanka", D2="szamanki", C2="szamance", B2="szamankę", N2="szamanką", K2="szamance", W2="Szamanko" },
      ["Warlock"] = { M1="Czarnoksiężnik", D1="czarnoksiężnika", C1="czarnoksiężnikowi", B1="czarnoksiężnika", N1="czarnoksiężnikiem", K1="czarnoksiężniku", W1="Czarnoksiężniku", M2="Czarownica", D2="czarownicy", C2="czarownicy", B2="czarownicę", N2="czarownicą", K2="czarownicy", W2="Czarownico" },
      ["Warrior"] = { M1="Wojownik", D1="wojownika", C1="wojownikowi", B1="wojownika", N1="wojownikiem", K1="wojowniku", W1="Wojowniku", M2="Wojowniczka", D2="wojowniczki", C2="wojowniczce", B2="wojowniczkę", N2="wojowniczką", K2="wojowniczce", W2="Wojowniczko" },
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

WOWTR_Font1 = WoWTR_Localization.mainFolder.."\\Fonts\\morpheus_pl.ttf";
WOWTR_Font2 = WoWTR_Localization.mainFolder.."\\Fonts\\frizquadratatt_pl.ttf";
WOWTR_Fonts = {"frizquadratatt_pl.ttf", "Expressway.ttf"};
local GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata;
WOWTR_version = GetAddOnMetadata(WoWTR_Localization.addonFolder, "Version");
