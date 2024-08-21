-- Description: Texts in the selected localization language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
-------------------------------------------------------------------------------------------------------

WoWTR_Localization = {
   lang = "TR",
   started = "yüklendi",                                             -- addon was started
   mainFolder = "Interface\\AddOns\\WoWTR",                          -- main folder for addon files
   addonFolder = "WoWTR",                                            -- name of the folder where the addon was installed
   addonName = "WoWTR",                                              -- short name of the addon
   addonIconDesc = "Ayar menüsünü açmak için tıkla",                 -- Click to open the settings menu
   optionName = "WoWTR - Ayarlar",                                   -- WowTR - options
   optionTitle = "WoWTR Türkçe Yama",                                -- WowTR Turkish Patch
   optionTitleAR = "",
   addressWWW = "https://www.wowtr.com.tr",                          -- address of project page
   addressDiscord = "https://discord.gg/PEknRSqEQ7",                 -- address of discord page
   addressTwitch = "",                                               -- address of Twitch page 
   addressFanPage = "",                                              -- address of FanPage 
   addressEmail = "info@wowtr.com.tr",                               -- address of project e-mail
   addressCurse = "https://www.curseforge.com/wow/addons/wowtr",     -- address of CurseForge page
   addressPayPal = "",                                               -- address of PayPal page
   addressBlik = "hknylmz#2807",                                     -- telephon number for BLIK payment
   gossipText = "dedikodu metni",                                    -- gossip text
   quests = "Görevler",                                              -- Quests
   worldquests = "Dünya Görevleri",                                  -- World Quests
   campaignquests = "Ana Hikaye Görevleri",                          -- Campaign Quests
   scenariodung = "Senaryo",                                         -- Scenario/Dungeon
   objectives = "Tüm Hedefler",                                      -- All Objectives
   bonusobjective = "Bonus Hedef",								            -- Bonus Objective
   travelerlog = "Gezgin Günlüğü",                                     -- Traveler's Log
   rewards = "Ödüller",                                              -- Rewards
   storyLineProgress = "Hikaye İlerlemesi",                          -- StoryLine Progress
   storyLineChapters = "Bölümler",                                   -- StoryLine Chapters
   choiceQuestFirst = "önce bir görev seç",                          -- choose a quest first
   readyForTurnIn = "Görev teslim için hazır",                       -- Ready for turn-in
   clickToComplete = "bitirmek için tıklayın",                       -- click to complete
   failed = "Başarısız",                                             -- Failed
   optional = "Opsiyonel",                                           -- Optional
   bookID = "Kitap ID:",                                             -- Book ID:
   stopTheMovie = "Videoyu durdurmak mı istiyorsunuz?",              -- Do you want to stop the video?
   stopTheMovieYes = "Evet",                                         -- Yes
   stopTheMovieNo = "Hayır",                                         -- No
   reopenBoard = "Bülten Tahtasını yeniden açın",                    -- Reopen the Bulletin Board
   sellPrice = "Satış fiyatı:",                                      -- Sell price:
   currentlyEquipped = "Şu anda Donanımlı",                          -- Currently Equipped
   additionalEquipped = "Ek Ekipmanla donatılmış",                   -- Equipped with additional Equipment
   WoWTR_Talent_trDESC = "Yetenekler: Türkçe",                   		-- Talents: Turkish
   WoWTR_Talent_enDESC = "Talents: English",                   		-- Talents: English
   WoWTR_Spellbook_trDESC = "Türkçe",                   			      -- Spell Book: Turkish
   WoWTR_Spellbook_enDESC = "English",                   			   -- Spell Book: English
   your_home = "eviniz",                                             -- 'your home' (if the Hearthstone location fails to be read)
   welcomeIconPos = 255,                                             -- position of welcome icon on the welcom panel; 0 = disabled to display
   resetButton1 = "WoWTR.lua dosyasındaki kayıtları temizle",        -- Clear saved untranslated texts (without turkish font)
   resetButton2 = "Eklenti ayarlarını sıfırla",                      -- Reset the addon to its default settings (without turkish font)
   resetButton1Opis = "Kaydedilmiş çevrilmemiş metinleri temizle",   -- Clear saved untranslated texts (as tooltip)
   resetButton1OpisDESC = "Kaydedilen tüm oyun verileri silinecek",  -- Clear saved untranslated texts (as tooltip)
   resetButton2Opis = "Eklentiyi varsayılan ayarlarına sıfırlayın",  -- Reset the addon to its default settings (as tooltip)
   resetButton2OpisDESC = "Eklenti ayarları varsayılana sıfırlanacak \n(arayüz yeniden yüklenecektir)",
   resultButton1 = "Kayıtlı metinler temizlendi",                    -- Wyczyszczono zapisane teksty
   confirmationHeader = "Onayla",                                    -- Confirmation Header
   confirmationText1 = "Kaydedilmiş tüm kayıtları \nsilmek istiyor musunuz?",     -- Czy chcesz wyczyścić wszystkie zapisane, nieprzetłumaczone teksty?
   confirmationText2 = "Eklentiyi varsayılan ayarlarına \ngeri yüklemek istiyor musunuz?\n(Arayüz yeniden yüklenecek)",   -- Czy chcesz przywrócić ustawienia domyślne dodatku?
   moveFrameUpDown = "Pencereyi yukarı veya aşağı hareket ettirin",  -- Move the window up or down
};

---------------------------------------------------------------------------------------------------------

QTR_Messages = {   
   isactive   = "etkinleştirildi",                         -- jest aktywny (is active) 
   isinactive = "etkin değil",                             -- jest nieaktywny (is inactive) 
   missing    = "çevirilmedi",                             -- brak tłumaczenia (no translation) 
   details    = "Detaylar",                                -- Opis (Description) 
   progress   = "Durum",                                   -- Postęp (Progress) 
   objectives = "Hedefler",                                -- Cele zadania (Objectives) 
   completion = "Bitirme",                                 -- Zakończenie (Completion) 
   translator = "Çeviren",                                 -- Tłumaczenie (Translator) 
   rewards    = "Ödüller",                                 -- Nagrody (Rewards) 
   experience = "Deneyim:",                                -- Doświadczenie (Experience) 
   reqmoney   = "Gereken Para:",                           -- Wymagane pieniądze (Required money) 
   reqitems   = "Gereken Eşyalar:",                        -- Wymagane przedmioty (Required items) 
   itemchoose0= "Alacaksınız:",                            -- Otrzymasz: (You will receive:) 
   itemchoose1= "Bu ödüllerden birini seçebilirsin:",      -- Możesz wybrać jedną z nagród: (You will be able to choose one of these rewards:) 
   itemchoose2= "Bu ödüllerden birini seç:",               -- Wybierz jedną z nagród: (Choose one of these rewards:) 
   itemchoose3= "Alacağın Ödül:",                          -- Otrzymujesz nagrodę: (You receiving the reward:) 
   itemreceiv0= "Alacağın Ödül:",                          -- Otrzymasz: (You will receive:) 
   itemreceiv1= "Ayrıca şunları alacaksın:",               -- Otrzymasz również: (You will also receive:) 
   itemreceiv2= "Alacağın Ödül:",                          -- Otrzymujesz nagrodę: (You receiving the reward:) 
   itemreceiv3= "Bu ödülü de alıyorsun:",                  -- Otrzymujesz również nagrodę: (You also receiving the reward:) 
   learnspell = "Büyüleri öğren:",                         -- Naucz się zaklęcia: (Learn Spell:) 
   currquests = "Mevcut görevler",                         -- Bieżące zadania (Current Quests) 
   avaiquests = "Uygun görevler",                          -- Dostępne zadania (Available Quests) 
   reward_aura      = "Aşağıdakiler sana verilecektir:",   -- Otrzymasz efekt: (The following will be cast on you:) 
   reward_spell     = "Aşağıdakileri öğreneceksin:",       -- Nauczysz się: (You will learn the following:) 
   reward_companion = "Bu Companionları kazanacaksın:",    -- Zyskasz towarzyszy: (You will gain these Companions:) 
   reward_follower  = "Bu takipçileri kazanacaksın:",      -- Zyskasz zwolenników: (You will gain these followers:) 
   reward_reputation= "İtibar ödülleri:",                  -- Wzrost reputacji: (Reputation awards:) 
   reward_title     = "Sana unvan verilecektir:",          -- Otrzymasz tytuł: (You shall be granted the title:) 
   reward_tradeskill= "Nasıl oluşturulacağını öğreneceksin:",        -- Nauczysz się wytwarzania: (You will learn how to create:) 
   reward_unlock    = "Aşağıdakilere erişimin kilidini açacaksın:",  -- Odblokujesz: (You will unlock access to the following:) 
   reward_bonus     = "Party Sync'teyken bu görevi tamamlamak şunları kazandırabilir:",  -- Ukończenie tego zadania, gdy jesteś w grupie, może cię nagrodzić: (Completing this quest while in Party Sync may reward:) 
}; 

---------------------------------------------------------------------------------------------------------

WoWTR_Config_Interface = {
   showMinimapIcon = "Mini haritanın yanında eklenti ayar simgesini göster",                          -- Show then addon setting icon next to the minimap
   showMinimapIconDESC = "Etkinleştirilirse, mini haritanın yanında eklenti ayar simgesi görüntülenecektir.",   -- If enabled, the addon setting icon will display next tp the minimap
   
   titleTab1 = "Görevler",                                                                            -- Quests (TR:Görevler)
   generalMainHeaderQS = "GÖREV ÇEVİRİLERİ - Quests",                                                 -- Quest translations (TR:GÖREV ÇEVİRİLERİ)
   activateQuestsTranslations = "Görev çevirilerini etkinleştir",                                     -- Activate quest translations (TR:Görev çevirilerini etkinleştir)
   activateQuestsTranslationsDESC = "Kapatıldığında, çeviriler orjinal dilinde gösterilecektir",      -- If enabled, quest translations will appear in place of the original texts (TR:Kapatıldığında, çeviriler orjinal dilinde gösterilecektir)
   translateQuestTitles = "Görev başlıklarını Türkçe göster",                                         -- Display translations of quest TITLES (TR:Görev başlıklarını Türkçe göster)
   translateQuestTitlesDESC = "Kapatıldığında, sadece başlıklar orjinal dilinde gösterilecektir",     -- If enabled, quest titles will be translated (TR:Kapatıldığında, sadece başlıklar orjinal dilinde gösterilecektir)
   translateGossipTexts = "NPC Konuşmalarını Türkçe göster",                                          -- Display translations of GOSSIP texts (TR:NPC Konuşmalarını Türkçe göster)
   translateGossipTextsDESC = "Kapatıldığında orjinal dilinde gösterilir",                            -- If enabled, gossip texts will be translated (TR:Kapatıldığında orjinal dilinde gösterilir)
   translateTrackObjectives = "Görev takip listesini Türkçe göster",                                  -- Display translations online in Objectives Tracker (TR:Görev takip listesini Türkçe göster)
   translateTrackObjectivesDESC = "Kapatıldığında, orjinal haliyle görünecektir",                     -- If enabled, texts in Objectives Tracker will be translated (TR:Kapatıldığında, orjinal haliyle görünecektir)
   translateOwnNames = "|CFF666666Yer isimlerini Türkçe göster - (şuan aktif değil)|r",               -- Display own names of places in turkish language
   translateOwnNamesDESC = "Etkinleştirilirse, şehirlerin, yerlerin vb. kendi adları türkçe olarak görüntülenecektir.",   -- If enabled, own names of cities, places etc. will displaying in turkish language
   savingUntranslatedQuests = "KAYIT SEÇENEKLERİ",                                                    -- Saving untranslated quests and gossip texts (TR:KAYIT SEÇENEKLERİ)
   saveUntranslatedQuests = "Çevirisi olmayan görevleri kaydet",                                      -- Save untranslated quests (TR:Çevirisi olmayan görevleri kaydet)
   saveUntranslatedQuestsDESC = "Kayıt dosyasına veri ekler",                                         -- If enabled, untranslated quests will be saved (TR:Kayıt dosyasına veri ekler)
   saveUntranslatedGossip = "Çevirisi olmayan npc konuşmalarını kaydet",                              -- Save untranslated gossip texts (TR:Çevirisi olmayan npc konuşmalarını kaydet)
   saveUntranslatedGossipDESC = "Kayıt dosyasına veri ekler",                                         -- If enabled, untranslated gossip texts will be saved (TR:Kayıt dosyasına veri ekler)
   integrationWithOtherAddons = "ENTEGRASYON",                                                        -- Integration with other addons (TR:ENTEGRASYON)
   translateImmersion = "Çevirileri Immersion eklentisinde göster",                                   -- Display translations in Immersion addon (TR:Çevirileri Immersion eklentisinde göster)
   translateImmersionDESC = "Kapatıldığında, Immersion orjinal dilde görünecektir",                   -- If enabled, texts in Immersion addon will be translated (TR:Kapatıldığında, Immersion orjinal dilde görünecektir)
   translateStoryLine = "Çevirileri StoryLine eklentisinde göster",                                   -- Display translations in StoryLine addon (TR:Çevirileri StoryLine eklentisinde göster)
   translateStoryLineDESC = "Kapatıldığında, StoryLine orjinal dilde görünecektir",                   -- If enabled, texts in StoryLine addon will be translated (TR:Kapatıldığında, StoryLine orjinal dilde görünecektir)
   translateQuestLog = "Çevirileri Classic Quest Log eklentisinde göster",                            -- Display translations in Classic Quest Log addon (TR:Çevirileri Classic Quest Log eklentisinde göster)
   translateQuestLogDESC = "Kapatıldığında, Classic Quest Log orjinal dilde görünecektir",            -- If enabled, texts in Classic Quest Log addon will be translated (TR:Kapatıldığında, Classic Quest Log orjinal dilde görünecektir)
   translateDialogueUI = "Çevirileri DialogueUI eklentisinde göster",                                 -- Display translations in DialogueUI addon
   translateDialogueUIDESC = "Kapatıldığında, DialogueUI orjinal dilde görünecektir",                 -- If enabled, texts in DialogueUI addon will be translated
   sampleGossipText = "Gossip NPC Konuşma|nÖrnek Font Büyüklüğü",                                     -- Sample Gossip font size text

   titleTab2 = "Baloncuklar",                                                                         -- Bubbles (TR:Baloncuklar)
   generalMainHeaderBB = "KONUŞMA BALONCUKLARI - Bubbles",                                            -- Bubbles translations (TR:KONUŞMA BALONCUKLARI)
   activateBubblesTranslations = "Konuşma baloncuklarını etkinleştir",                                -- Activate bubble translations (TR:Konuşma baloncuklarını etkinleştir)
   activateBubblesTranslationsDESC = "Kapatıldığında, çeviriler orjinal dilinde gösterilecektir",     -- If enabled, bubble translations will appear in place of the original texts (TR:Kapatıldığında, çeviriler orjinal dilinde gösterilecektir)
   displayOriginalTexts = "Sohbet penceresinde orjinal metni göster",                                 -- Display original text in chat frame (TR:Sohbet penceresinde orjinal metni göster)
   displayOriginalTextsDESC = "Kapatıldığında, sohbet penceresinde orjinal metin görüntülenmez",      -- If enabled, original texts of bullbe will be displayed (TR:Kapatıldığında, sohbet penceresinde orjinal metin görüntülenmez)
   displayTranslatedTexts = "Sohbet penceresinde Türkçe çevirisini göster",                           -- Display translated text in chat frame (TR:Sohbet penceresinde Türkçe çevirisini göster)
   displayTranslatedTextsDESC = "Kapatıldığında, sohbet penceresinde Türkçe çeviri görüntülenmez",    -- If enabled, translated texts will be displayed (TR:Kapatıldığında, sohbet penceresinde Türkçe çeviri görüntülenmez)
   choiceGender1OfPlayer = "İfadeler erkek oyuncuya göre yapılsın",                                   -- Choice of male expression to the player (TR:İfadeler erkek oyuncuya göre yapılsın)
   choiceGender1OfPlayerDESC = "Npc ler sizi erkek varsayarak tepki verir",                           -- If enabled, translated bubbles will be displayed in male form (TR:Npc ler sizi erkek varsayarak tepki verir)
   choiceGender2OfPlayer = "İfadeler kadın oyuncuya göre yapılsın",                                   -- Choice of female expression to the player (TR:İfadeler kadın oyuncuya göre yapılsın)
   choiceGender2OfPlayerDESC = "Npc ler sizi kadın varsayarak tepki verir",                           -- If enabled, translated bubbles will be displayed in female form (TR:Npc ler sizi kadın varsayarak tepki verir)
   choiceGender3OfPlayer = "İfadeler karakterinizin cinsiyet tercihine göre yapılır",                 -- Choise of expression for the player depending on the gender of the character (TR:İfadeler karakterinizin cinsiyet tercihine göre yapılır)
   choiceGender3OfPlayerDESC = "Npc ler karakterinizin cinsiyetine göre tepki verir",                 -- If enbled, translated bubbles will be displayed in male form (TR:Npc ler karakterinizin cinsiyetine göre tepki verir)
   showBubblesInDungeon = "Zindanlardaki baloncukları göster",                                        -- Show bubbles in dungeons
   showBubblesInDungeonDESC = "İşaretlenirse, zindan baloncukları ekranın üst kısmında kendi 5 karesinde gösterilecektir.",   -- If checked, dungeon bubbles will be shown in their own 5 frames at the top of the screen
   setDungeonFrames = "Konuşma balonu pencerelerini ayarla",                                          -- Set up speech bubble frames
   setDungeonFramesDESC = "İşaretlendiğinde, zindanlardaki kabarcık pencerelerini dikey olarak hizalayabileceksiniz.",        -- When checked, you will be able to vertically align the bubble windows in dungeons
   savingUntranslatedBubbles = "KAYIT SEÇENEKLERİ",                                                   -- Saving untranslated bubbles (TR:KAYIT SEÇENEKLERİ)
   saveUntranslatedBubbles = "Çevirisi olmayan konuşmaları kaydet",                          		  -- Save untranslated bubbles (TR:Çevirisi olmayan baloncuk konuşmaları kaydet)
   saveUntranslatedBubblesDESC = "Kayıt dosyasına veri ekler",                                        -- If enabled, untranslated bubbles will be saved (TR:Kayıt dosyasına veri ekler)
   fontSizeHeader = "YAZI TİPİ",                                                                      -- Font size of texts (TR:YAZI TİPİ)
   setFontActivate = "Yazı tipi değişikliğini etkinleştir",                                           -- Activate font size changes (TR:Yazı tipi değişikliğini etkinleştir)
   setFontActivateDESC = "Aktif edildiğinde, yazı tipi büyüklüğü sizin tercihinize göre ayarlanır",   -- If enabled, font size will be set to below value (TR:Aktif edildiğinde, yazı tipi büyüklüğü sizin tercihinize göre ayarlanır)   fontsizeBubbles = "yazı tipi büyüklüğü değiştir",                                                  -- Choose a font size (TR:)
   fontsizeBubbles = "Bir yazı tipi boyutu seçin",                                                    -- Choose a font size 
   fontsizeBubblesDESC = "10 ile 20 değeri arasında büyüklük seçebilirsiniz",                         -- The font size is a number between 10 and 20 (TR:10 ile 20 değeri arasında büyüklük seçebilirsiniz)
   sampleText = "Örnek yazı tipi boyutu metni",                                                       -- Sample font size text (TR:Örnek yazı tipi boyutu metni)
   timerDisplay = "Çeviri görüntüleme süresi",                                                        -- Translation display time

   titleTab3 = "Altyazılar",                                                                          -- Movies & Cinematics (TR:Altyazılar)
   generalMainHeaderMF = "ALTYAZI ÇEVİRİLERİ - Subtitles",                                            -- Subtitle translations (TR:ALTYAZI ÇEVİRİLERİ)
   activateSubtitleTranslations = "Altyazı çevirilerini etkinleştir",                                 -- Activate subtitle translations (TR:Altyazı çevirilerini etkinleştir)
   activateSubtitleTranslationsDESC = "Kapatıldığında, altyazıları gösterilmez",                      -- If enabled, translated subtitles will displayed (TR:Kapatıldığında, altyazıları gösterilmez)
   subtitleIntro = "Giriş sahnelerinin altyazı çevirilerini göster",                                  -- Display translated subtitles of Intro (TR:Giriş sahnelerinin altyazı çevirilerini göster)
   subtitleIntroDESC = "Etkinleştirilirse, çevrilmiş altyazılar başlangıç Intro'sunda gösterilir",    -- If enbled, translated subtitles will be displyed into starting Intro (TR:Etkinleştirilirse, çevrilmiş altyazılar başlangıç Intro'sunda gösterilir)
   subtitleMovies = "Video sahnelerin altyazı çevirilerini göster",                                   -- Display translated subtitles of Movies (TR:Video sahnelerin altyazı çevirilerini göster)
   subtitleMoviesDESC = "Etkinleştirilirse, çevrilmiş altyazılar vidyolarda gösterilir",              -- If enbled, translated subtitles will be displyed into movies (TR:Etkinleştirilirse, çevrilmiş altyazılar vidyolarda gösterilir)
   subtitleCinematics = "Sinematik sahnelerin altyazı çevirilerini göster",                           -- Display translated subtitles of Cinematics (TR:Sinematik sahnelerin altyazı çevirilerini göster)
   subtitleCinematicsDESC = "Etkinleştirilirse, çevrilmiş altyazılar sinematiklerde gösterilir",      -- If enbled, translated subtitles will be displyed into cinematics (TR:Etkinleştirilirse, çevrilmiş altyazılar sinematiklerde gösterilir)
   savingUntranslatedSubtitles = "KAYIT SEÇENEKLERİ",                                                 -- Saving untranslated subtitles (TR:KAYIT SEÇENEKLERİ)
   saveUntranslatedSubtitles = "Çevirisi olmayan altyazıları kaydet",                                 -- Save untranslated subtitles (TR:Çevirisi olmayan altyazıları kaydet)
   saveUntranslatedSubtitlesDESC = "Kayıt dosyasına veri ekler",                                      -- If enbled, untranslated subtitles will be saved (TR:Kayıt dosyasına veri ekler)
   chatService = "Service of arabic chat",
   activateChatService = "Activate of arabic chat",
   activateChatServiceDESC = "If enabled, arabic chat is active",
   chatFontActivate = "Activate font size changes",
   chatFontActivateDESC = "If enabled, font size will be set to below value",
   fontsizeChat = "Choose a font size",
   fontsizeChatDESC = "The font size is a number between 10 and 20",

   titleTab4 = "Arayüz Ayarları",                                                                     -- Tutorials (TR:Ögreticiler)
   generalMainHeaderTT = "ÖĞRETİCİ ÇEVİRİLERİ - Tutorials",                                           -- Tutorial translations (TR:ÖĞRETİCİ ÇEVİRİLERİ)
   activateTutorialTranslations = "Öğretici çevirileri etkinleştir",                                  -- Activate tutorial translations (TR:Öğretici çevirileri etkinleştir)
   activateTutorialTranslationsDESC = "Etkinleştirilirse, çevrilmiş öğreticiler görüntülenecektir",   -- If enabled, translated tutorials will displayed (TR:Etkinleştirilirse, çevrilmiş öğreticiler görüntülenecektir)
   savingUntranslatedTutorials = "KAYIT SEÇENEKLERİ",                                                 -- Saving untranslated tutorials (TR:KAYIT SEÇENEKLERİ)
   saveUntranslatedTutorials = "Çevrilmemiş öğreticileri kaydedin",                                   -- Save untranslated tutorials (TR:Çevrilmemiş öğreticileri kaydedin)
   saveUntranslatedTutorialsDESC = "Etkinleştirilirse çevrilmemiş öğreticiler kaydedilecek",          -- If enbled, untranslated tutorials will be saved (TR:Etkinleştirilirse çevrilmemiş öğreticiler kaydedilecek)
   fontSelectingFontHeader = "WoWTR YAZI TİPİNİ SEÇME",                                               -- Selecting the add-on font
   fontSelectFontFile = "Bir yazı tipi dosyası seçin",                                                -- Select a font file
   fontCurrentFont = "Mevcut yazı tipi:",                                                             -- Current font:

   translationUI = "KULLANICI ARAYÜZÜ - UI",                                                          -- Translation of user interface
   savingTranslationUI = "KAYIT SEÇENEKLERİ",                                                         -- Saving untanslated user interface
   saveTranslationUI = "Çevrilmemiş kullanıcı arayüzü öğelerini kaydet",                              -- Save untranslated user interface
   saveTranslationUIDESC = "İşaretlenirse çevrilmemiş kullanıcı arayüzü öğeleri kaydedilir",          -- If enabled, untranslated user interface will be saving
   ReloadButtonUI = "Ayarların uygulanması için tıklayın \"Reload UI\"",                              -- For the application of settings click "ReloadUI"
   displayTranslationtxt = "Çevirisini aktif etmek istediklerinizi seçiniz.",                         -- Display translation of user interface
   displayTranslationUI1 = "Oyun Arayüzü",                                                            -- Display translation of Game Menu
   displayTranslationUI1DESC = "Çevrilebilir oyun arayüzleri Türkçe görünecektir.",                   -- If enabled, user interface will be displayed in translation
   displayTranslationUI2 = "Karakter Bilgileri",                                                      -- Display translation of Character Info
   displayTranslationUI2DESC = "Character Info arayüzü Türkçe olarak görünecektir.",                  -- If enabled, user interface will be displayed in translation
   displayTranslationUI3 = "Grup Bulucu",                                                             -- Display translation of Group Finder
   displayTranslationUI3DESC = "Group Finder ve alt sekmeleri artık Türkçe görünecektir.",            -- If enabled, user interface will be displayed in translation
   displayTranslationUI4 = "Koleksiyonlar",                                                           -- Display translation of Collections
   displayTranslationUI4DESC = "Collections Sayfası ve içeriği artık Türkçe görünecektir.",           -- If enabled, user interface will be displayed in translation
   displayTranslationUI5 = "Macera Rehberi",                                                          -- Display translation of Adventure Guide
   displayTranslationUI5DESC = "Adventure Guide ve alt sayfaları artık Türkçe görünecektir.",         -- If enabled, user interface will be displayed in translation
   displayTranslationUI6 = "Arkadaş Listesi",                                                         -- Display translation of Friend List
   displayTranslationUI6DESC = "Friend List içeriği artık Türkçe görünecektir.",                      -- If enabled, user interface will be displayed in translation
   displayTranslationUI7 = "Meslekler",                                                               -- Display translation of Profession
   displayTranslationUI7DESC = "Profession ve içeriği artık Türkçe görünecektir.",                    -- If enabled, user interface will be displayed in translation
   displayTranslationUI8 = "Filtre ve Açılır Menüler",                                                -- Display translation of Filter & Open List
   displayTranslationUI8DESC = "Filter & Open List Menüler artık Türkçe görünecektir.",               -- If enabled, user interface will be displayed in translation

   titleTab5 = "Kitaplar",                                                                            -- Books (TR:Kitaplar)
   generalMainHeaderBT = "KİTAP ÇEVİRİLERİ - Books",                                                  -- Books translations (TR:KİTAP ÇEVİRİLERİ)
   activateBooksTranslations = "Kitap çevirilerini etkinleştir",                                      -- Activate book translations (TR:Kitap çevirilerini etkinleştir)
   activateBooksTranslationsDESC = "Etkinleştirilirse, orijinal metinlerin yerine kitap çevirileri görünecektir",   -- If enabled, book translations will appear in place of the original texts (TR:Etkinleştirilirse, orijinal metinlerin yerine kitap çevirileri görünecektir)
   translateBookTitles = "Kitap adlarının çevirilerini göster",                                       -- Display translations of book TITLES (TR:Kitap adlarının çevirilerini göster)
   translateBookTitlesDESC = "Etkinleştirilirse, kitap başlıkları çevrilecek",                        -- If enabled, book titles will be translated (TR:Etkinleştirilirse, kitap başlıkları çevrilecek)
   showBookID = "Kitabın kimliğini göster",                                                           -- Show ID of book (TR:Kitabın kimliğini göster)
   showBookIDDESC = "Etkinleştirilirse, kitabın kimliği gösterilecektir",                             -- If enabled, ID of book will be shown (TR:Etkinleştirilirse, kitabın kimliği gösterilecektir)
   savingUntranslatedBooks = "KAYIT SEÇENEKLERİ",                                                     -- Saving untranslated books (TR:KAYIT SEÇENEKLERİ)
   saveUntranslatedBooks = "Çevrilmemiş kitapları kaydet",                                            -- Save untranslated books (TR:Çevrilmemiş kitapları kaydet)
   saveUntranslatedBooksDESC = "Etkinleştirilirse çevrilmemiş kitaplar kaydedilecek",                 -- If enabled, untranslated books will be saved (TR:Etkinleştirilirse çevrilmemiş kitaplar kaydedilecek)

   titleTab6 = "Araç ipuçları",                                                                       -- Tooltips (TR:Araç ipuçları)
   generalMainHeaderST = "ARAÇ İPUCU ÇEVİRİLERİ - Tooltips",                                          -- Tooltip translations (TR:ARAÇ İPUCU ÇEVİRİLERİ)
   activateTooltipTranslations = "Araç ipucu çevirilerini etkinleştir",                               -- Activate tooltip translations (TR:Araç ipucu çevirilerini etkinleştir)
   activateTooltipTranslationsDESC = "Kapatılırsa aşağıdaki özelliklerin hiçbiri çalışmayacaktır",    -- If enabled, translated tooltips will displayed (TR:Etkinleştirilirse, çevrilmiş araç ipuçları görüntülenecektir)
   translateItems = "Item çevirilerini etkinleştir",					                                    -- Display translated tooltips for items (TR:Öğeler için çevrilmiş araç ipuçlarını göster)
   translateItemsDESC = "Kıyafet, eşya, yiyecek, trinket gibi öğelerin çevirileri etkinleşir",   	   -- If enabled, translated tooltips for items will be displayed (TR:Etkinleştirilirse, öğeler için çevrilmiş araç ipuçları görüntülenecektir)
   translateSpells = "Skill, Spell çevirilerini etkinleştir",                                 		   -- Display translated tooltips for spells (TR:Büyüler için çevrilmiş araç ipuçlarını göster)
   translateSpellsDESC = "Karakterinizin büyü ve becerilerinin çevirileri etkinleşir", 			      -- If enabled, translated tooltips for spells will be displayed (TR:Etkinleştirilirse, büyüler için çevrilmiş araç ipuçları görüntülenecektir)
   translateTalents = "Talent çevirilerini etkinleştir",                             				      -- Display translated tooltips for talents (TR:Yetenekler için çevrilmiş araç ipuçlarını göster)
   translateTalentsDESC = "Karakterinizin talentlerinin çevirileri etkinleşir",   					      -- If enabled, translated tooltips for talents will be displayed (TR:Etkinleştirilirse, yetenekler için çevrilmiş araç ipuçları görüntülenecektir)
   translateTooltipTitle = "Araç ipuçlarının varsa çevrilmiş isimlerini göster",                      -- Display translated title of item, spell or talent
   translateTooltipTitleDESC = "Etkinleştirilirse, öğenin, büyünün veya yeteneğin çevrilmiş başlığı görüntülenecektir",  -- If enabled, translated title of tooltips will be displayed
   showTooltipID = "Araç ipuçları kimliğini göster",                                                  -- Show tooltips ID (TR:Araç ipuçları kimliğini göster)
   showTooltipIDDESC = "Etkinleştirilirse, araç penceresinde ID görüntülenir",   					      -- If enabled, display tooltips ID (TR:Etkinleştirilirse, araç ipuçları kimliğini göster)
   showTooltipHash = "Hash kodunu göster",                                                            -- Show tooltips Hash (TR:Hash kodunu göster)
   showTooltipHashDESC = "Etkinleştirilirse, araç ipuçlarının hash kodu görüntülenir",                -- If enabled, display tooltips Hash (TR:Etkinleştirilirse, araç ipuçlarının hash kodu görüntülenir)
   hideSellPrice = "Ürünlerin satış fiyatını gizle",                                                  -- Hide sell price of items (TR:Ürünlerin satış fiyatını gizle)
   hideSellPriceDESC = "Etkinleştirilirse, öğelerin satış fiyatı gizlenir",                           -- If enabled, sell price of items will be hidden (TR:Etkinleştirilirse, öğelerin satış fiyatı gizlenir)
   timerHoldTranslation = "ÇEVİRİ BEKLEME SÜRESİ",                                                    -- Suspend the translation display (TR:ÇEVİRİ BEKLEME SÜRESİ)
   timerLimitSeconds = "bekletme süresi belirleyin",                                                  -- Select a translation hold time (TR:bekletme süresi belirleyin)
   timerLimitSecondsDESC = "Süreler 5 ile 30 arasında bir sayıdır",                                   -- The times is a number between 5 and 30 (TR:Süreler 5 ile 30 arasında bir sayıdır)
   displayTranslationConstantly = "Çeviriyi sürekli göster",                                          -- Display translation constantly (TR:Çeviriyi sürekli göster)
   displayTranslationConstantlyDESC = "Kapatılırsa, belirlenen süre kadar çeviri gösterilir",         -- If switched off, the translation is displayed for the specified time (TR:Kapatılırsa, belirlenen süre kadar çeviri gösterilir)
   savingUntranslatedTooltips = "KAYIT SEÇENEKLERİ",                                                  -- Saving untranslated tooltips (TR:KAYIT SEÇENEKLERİ)
   saveUntranslatedTooltips = "Çevrilmemiş ipuçlarını kaydet",                                        -- Save untranslated tooltips (TR:Çevrilmemiş ipuçlarını kaydet)
   saveUntranslatedTooltipsDESC = "Etkinleştirilirse çevrilmemiş araç ipuçları kaydedilecek",         -- If enabled, untranslated tooltips will be saved (TR:Etkinleştirilirse çevrilmemiş araç ipuçları kaydedilecek)

   titleTab9 = "Hakkında",                                                                            -- About (TR:Hakkında)
   generalText = "\nWoWTR: World of Warcraft Türkçe Yama Addonu\n\nBu addon, World of Warcraft oyununu Türkçe oynamak isteyen oyuncular için geliştirilmiştir. WoWTR, oyun içindeki metinleri, görev açıklamalarını, arayüz öğelerini ve daha fazlasını Türkçe\'ye çevirerek, Türk oyuncuların oyun deneyimini geliştirmeyi amaçlamaktadır.\n\n\nÖzellikler:\n - Oyun içi metinlerin Türkçe çevirisi\n - Görev açıklamalarının Türkçeleştirilmesi\n - Arayüz öğelerinin Türkçe gösterimi\n - NPC diyaloglarının çevirisi\n - Sürekli güncellenen çeviri veritabanı\n\n\nWoWTR, Türk WoW topluluğunun desteğiyle geliştirilmektedir.\nKeyifli oyunlar!\n\n\n|cffEAC408Kayıt Dosyası Yolu:|r \n...World of Warcraft\\_retail_\\WTF\\Account\\[XXX]\\SavedVariables\\|cffEAC408WoWTR.lua|r",
   welcomeText = "",
   welcomeButton = "Tamam - okundu",                                                                  -- Button: Close welcome panel
   showWelcome = "Karşılama panelini göster",                                                         -- Button: Show welcome panel
   authorHeader = "KOD YAZARI BİLGİLERİ",                                                             -- Author info (TR:KOD YAZARI BİLGİLERİ)
   author = "Kod Yazar:",                                                                             -- Author: (TR:Kod Yazar:)
   email = "E-posta:",                                                                                -- E-mail: (TR:E-posta:)
   teamHeader = "WoWTR - İLETİŞİM",                                                                   -- WoWTR project team (TR:WoWTR)
   textContact = "Katkıda bulunmak veya hata bildirmek için lütfen bizimle iletişime geçin.",
   linkWWWShow = "Web sayfamızın linkine ulaşmak için tıkla",
   linkWWWTitle = "İnternet sitesine bağlantı",
   linkDISCShow = "|cffffff00Discord|r bağlantısı için tıkla",
   linkDISCTitle = "Discord bağlantısı",
   linkEMAILShow = "|cffffff00e-mail|r adresini görüntülemek için tıkla",
   linkEMAILTitle = "E-posta adresi",
   linkCURSEShow = "|cffffff00CurseForge|r bağlantısı için tıkla",
   linkCURSETitle = "CurseForge web sitesine bağlantı",
   linkPPShow = "",
   linkPPTitle = "",
   linkBLIKShow = "|cffffff00BattleNet|r üzerinden iletişim",
   linkBLIKTitle = "BattleNet ile iletişim",
   linkTWITCHShow = "",
   linkTWITCHTitle = "",
   linkFBShow = "",
   linkFBTitle = "",
   linkCloseFrame = "Çerçeveyi kapat",
   linkCopy = "Bağlantıyı panoya kopyalamak için |cff00ffffCtrl+C|r tuşlarına bas",      -- Press Ctrl+C to copy the address to the clipboard
   betaTestersHeader = "",                                                       		  -- TRANSLATION TEAM
   betaTestersHeaderDESC = "",    -- Translators and Beta testers:
};

---------------------------------------------------------------------------------------------------------

-- translated names of the player's races and classes in various cases of the noun variant (M1,D1,C1,B1,N1,K1,W1;M2,D2,C2,B2,N2,K2,W2) and the player's gender (male:1, female:2)


local p_race = {
      ["Blood Elf"] = { M1="Blood Elf", D1="Blood Elf", C1="Blood Elf", B1="Blood Elf", N1="Blood Elf", K1="Blood Elf", W1="Blood Elf", M2="Blood Elf", D2="Blood Elf", C2="Blood Elf", B2="Blood Elf", N2="Blood Elf", K2="Blood Elf", W2="Blood Elf" }, 
      ["Dark Iron Dwarf"] = { M1="Dark Iron Dwarf", D1="Dark Iron Dwarf", C1="Dark Iron Dwarf", B1="Dark Iron Dwarf", N1="Dark Iron Dwarf", K1="Dark Iron Dwarf", W1="Dark Iron Dwarf", M2="Dark Iron Dwarf", D2="Dark Iron Dwarf", C2="Dark Iron Dwarf", B2="Dark Iron Dwarf", N2="Dark Iron Dwarf", K2="Dark Iron Dwarf", W2="Dark Iron Dwarf" }, 
      ["Dracthyr"] = { M1="Dracthyr", D1="Dracthyr", C1="Dracthyr", B1="Dracthyr", N1="Dracthyr", K1="Dracthyr", W1="Dracthyr", M2="Dracthyr", D2="Dracthyr", C2="Dracthyr", B2="Dracthyr", N2="Dracthyr", K2="Dracthyr", W2="Dracthyr" }, 
      ["Draenei"] = { M1="Draenei", D1="Draenei", C1="Draenei", B1="Draenei", N1="Draenei", K1="Draenei", W1="Draenei", M2="Draenei", D2="Draenei", C2="Draenei", B2="Draenei", N2="Draenei", K2="Draenei", W2="Draenei" }, 
      ["Dwarf"] = { M1="Dwarf", D1="Dwarf", C1="Dwarf", B1="Dwarf", N1="Dwarf", K1="Dwarf", W1="Dwarf", M2="Dwarf", D2="Dwarf", C2="Dwarf", B2="Dwarf", N2="Dwarf", K2="Dwarf", W2="Dwarf" }, 
      ["Earthen"] = { M1="Earthen", D1="Earthen", C1="Earthen", B1="Earthen", N1="Earthen", K1="Earthen", W1="Earthen", M2="Earthen", D2="Earthen", C2="Earthen", B2="Earthen", N2="Earthen", K2="Earthen", W2="Earthen" },
      ["Gnome"] = { M1="Gnome", D1="Gnome", C1="Gnome", B1="Gnome", N1="Gnome", K1="Gnome", W1="Gnome", M2="Gnome", D2="Gnome", C2="Gnome", B2="Gnome", N2="Gnome", K2="Gnome", W2="Gnome" }, 
      ["Goblin"] = { M1="Goblin", D1="Goblin", C1="Goblin", B1="Goblin", N1="Goblin", K1="Goblin", W1="Goblin", M2="Goblin", D2="Goblin", C2="Goblin", B2="Goblin", N2="Goblin", K2="Goblin", W2="Goblin" }, 
      ["Highmountain Tauren"] = { M1="Highmountain Tauren", D1="Highmountain Tauren", C1="Highmountain Tauren", B1="Highmountain Tauren", N1="Highmountain Tauren", K1="Highmountain Tauren", W1="Highmountain Tauren", M2="Highmountain Tauren", D2="Highmountain Tauren", C2="Highmountain Tauren", B2="Highmountain Tauren", N2="Highmountain Tauren", K2="Highmountain Tauren", W2="Highmountain Tauren" }, 
      ["Human"] = { M1="Human", D1="Human", C1="Human", B1="Human", N1="Human", K1="Human", W1="Human", M2="Human", D2="Human", C2="Human", B2="Human", N2="Human", K2="Human", W2="Human" }, 
      ["Kul Tiran"] = { M1="Kul Tiran", D1="Kul Tiran", C1="Kul Tiran", B1="Kul Tiran", N1="Kul Tiran", K1="Kul Tiran", W1="Kul Tiran", M2="Kul Tiran", D2="Kul Tiran", C2="Kul Tiran", B2="Kul Tiran", N2="Kul Tiran", K2="Kul Tiran", W2="Kul Tiran" }, 
      ["Lightforged Draenei"] = { M1="Lightforged Draenei", D1="Lightforged Draenei", C1="Lightforged Draenei", B1="Lightforged Draenei", N1="Lightforged Draenei", K1="Lightforged Draenei", W1="Lightforged Draenei", M2="Lightforged Draenei", D2="Lightforged Draenei", C2="Lightforged Draenei", B2="Lightforged Draenei", N2="Lightforged Draenei", K2="Lightforged Draenei", W2="Lightforged Draenei" }, 
      ["Mag'har Orc"] = { M1="Mag'har Orc", D1="Mag'har Orc", C1="Mag'har Orc", B1="Mag'har Orc", N1="Mag'har Orc", K1="Mag'har Orc", W1="Mag'har Orc", M2="Mag'har Orc", D2="Mag'har Orc", C2="Mag'har Orc", B2="Mag'har Orc", N2="Mag'har Orc", K2="Mag'har Orc", W2="Mag'har Orc" }, 
      ["Mechagnome"] = { M1="Mechagnome", D1="Mechagnome", C1="Mechagnome", B1="Mechagnome", N1="Mechagnome", K1="Mechagnome", W1="Mechagnome", M2="Mechagnome", D2="Mechagnome", C2="Mechagnome", B2="Mechagnome", N2="Mechagnome", K2="Mechagnome", W2="Mechagnome" }, 
      ["Nightborne"] = { M1="Nightborne", D1="Nightborne", C1="Nightborne", B1="Nightborne", N1="Nightborne", K1="Nightborne", W1="Nightborne", M2="Nightborne", D2="Nightborne", C2="Nightborne", B2="Nightborne", N2="Nightborne", K2="Nightborne", W2="Nightborne" }, 
      ["Night Elf"] = { M1="Night Elf", D1="Night Elf", C1="Night Elf", B1="Night Elf", N1="Night Elf", K1="Night Elf", W1="Night Elf", M2="Night Elf", D2="Night Elf", C2="Night Elf", B2="Night Elf", N2="Night Elf", K2="Night Elf", W2="Night Elf" }, 
      ["Orc"] = { M1="Orc", D1="Orc", C1="Orc", B1="Orc", N1="Orc", K1="Orc", W1="Orc", M2="Orc", D2="Orc", C2="Orc", B2="Orc", N2="Orc", K2="Orc", W2="Orc" }, 
      ["Pandaren"] = { M1="Pandaren", D1="Pandaren", C1="Pandaren", B1="Pandaren", N1="Pandaren", K1="Pandaren", W1="Pandaren", M2="Pandaren", D2="Pandaren", C2="Pandaren", B2="Pandaren", N2="Pandaren", K2="Pandaren", W2="Pandaren" }, 
      ["Tauren"] = { M1="Tauren", D1="Tauren", C1="Tauren", B1="Tauren", N1="Tauren", K1="Tauren", W1="Tauren", M2="Tauren", D2="Tauren", C2="Tauren", B2="Tauren", N2="Tauren", K2="Tauren", W2="Tauren" }, 
      ["Troll"] = { M1="Troll", D1="Troll", C1="Troll", B1="Troll", N1="Troll", K1="Troll", W1="Troll", M2="Troll", D2="Troll", C2="Troll", B2="Troll", N2="Troll", K2="Troll", W2="Troll" }, 
      ["Undead"] = { M1="Undead", D1="Undead", C1="Undead", B1="Undead", N1="Undead", K1="Undead", W1="Undead", M2="Undead", D2="Undead", C2="Undead", B2="Undead", N2="Undead", K2="Undead", W2="Undead" }, 
      ["Void Elf"] = { M1="Void Elf", D1="Void Elf", C1="Void Elf", B1="Void Elf", N1="Void Elf", K1="Void Elf", W1="Void Elf", M2="Void Elf", D2="Void Elf", C2="Void Elf", B2="Void Elf", N2="Void Elf", K2="Void Elf", W2="Void Elf" }, 
      ["Vulpera"] = { M1="Vulpera", D1="Vulpera", C1="Vulpera", B1="Vulpera", N1="Vulpera", K1="Vulpera", W1="Vulpera", M2="Vulpera", D2="Vulpera", C2="Vulpera", B2="Vulpera", N2="Vulpera", K2="Vulpera", W2="Vulpera" }, 
      ["Worgen"] = { M1="Worgen", D1="Worgen", C1="Worgen", B1="Worgen", N1="Worgen", K1="Worgen", W1="Worgen", M2="Worgen", D2="Worgen", C2="Worgen", B2="Worgen", N2="Worgen", K2="Worgen", W2="Worgen" }, 
      ["Zandalari Troll"] = { M1="Zandalari Troll", D1="Zandalari Troll", C1="Zandalari Troll", B1="Zandalari Troll", N1="Zandalari Troll", K1="Zandalari Troll", W1="Zandalari Troll", M2="Zandalari Troll", D2="Zandalari Troll", C2="Zandalari Troll", B2="Zandalari Troll", N2="Zandalari Troll", K2="Zandalari Troll", W2="Zandalari Troll" }, 
};
local p_class = {
      ["Death Knight"] = { M1="Death Knight", D1="Death Knight", C1="Death Knight", B1="Death Knight", N1="Death Knight", K1="Death Knight", W1="Death Knight", M2="Death Knight", D2="Death Knight", C2="Death Knight", B2="Death Knight", N2="Death Knight", K2="Death Knight", W2="Death Knight" }, 
      ["Demon Hunter"] = { M1="Demon Hunter", D1="Demon Hunter", C1="Demon Hunter", B1="Demon Hunter", N1="Demon Hunter", K1="Demon Hunter", W1="Demon Hunter", M2="Demon Hunter", D2="Demon Hunter", C2="Demon Hunter", B2="Demon Hunter", N2="Demon Hunter", K2="Demon Hunter", W2="Demon Hunter" }, 
      ["Druid"] = { M1="Druid", D1="Druid", C1="Druid", B1="Druid", N1="Druid", K1="Druid", W1="Druid", M2="Druid", D2="Druid", C2="Druid", B2="Druid", N2="Druid", K2="Druid", W2="Druid" }, 
      ["Evoker"] = { M1="Evoker", D1="Evoker", C1="Evoker", B1="Evoker", N1="Evoker", K1="Evoker", W1="Evoker", M2="Evoker", D2="Evoker", C2="Evoker", B2="Evoker", N2="Evoker", K2="Evoker", W2="Evoker" }, 
      ["Hunter"] = { M1="Hunter", D1="Hunter", C1="Hunter", B1="Hunter", N1="Hunter", K1="Hunter", W1="Hunter", M2="Hunter", D2="Hunter", C2="Hunter", B2="Hunter", N2="Hunter", K2="Hunter", W2="Hunter" }, 
      ["Mage"] = { M1="Mage", D1="Mage", C1="Mage", B1="Mage", N1="Mage", K1="Mage", W1="Mage", M2="Mage", D2="Mage", C2="Mage", B2="Mage", N2="Mage", K2="Mage", W2="Mage" }, 
      ["Monk"] = { M1="Monk", D1="Monk", C1="Monk", B1="Monk", N1="Monk", K1="Monk", W1="Monk", M2="Monk", D2="Monk", C2="Monk", B2="Monk", N2="Monk", K2="Monk", W2="Monk" }, 
      ["Paladin"] = { M1="Paladin", D1="Paladin", C1="Paladin", B1="Paladin", N1="Paladin", K1="Paladin", W1="Paladin", M2="Paladin", D2="Paladin", C2="Paladin", B2="Paladin", N2="Paladin", K2="Paladin", W2="Paladin" }, 
      ["Priest"] = { M1="Priest", D1="Priest", C1="Priest", B1="Priest", N1="Priest", K1="Priest", W1="Priest", M2="Priest", D2="Priest", C2="Priest", B2="Priest", N2="Priest", K2="Priest", W2="Priest" }, 
      ["Rogue"] = { M1="Rogue", D1="Rogue", C1="Rogue", B1="Rogue", N1="Rogue", K1="Rogue", W1="Rogue", M2="Rogue", D2="Rogue", C2="Rogue", B2="Rogue", N2="Rogue", K2="Rogue", W2="Rogue" }, 
      ["Shaman"] = { M1="Shaman", D1="Shaman", C1="Shaman", B1="Shaman", N1="Shaman", K1="Shaman", W1="Shaman", M2="Shaman", D2="Shaman", C2="Shaman", B2="Shaman", N2="Shaman", K2="Shaman", W2="Shaman" }, 
      ["Warlock"] = { M1="Warlock", D1="Warlock", C1="Warlock", B1="Warlock", N1="Warlock", K1="Warlock", W1="Warlock", M2="Warlock", D2="Warlock", C2="Warlock", B2="Warlock", N2="Warlock", K2="Warlock", W2="Warlock" }, 
      ["Warrior"] = { M1="Warrior", D1="Warrior", C1="Warrior", B1="Warrior", N1="Warrior", K1="Warrior", W1="Warrior", M2="Warrior", D2="Warrior", C2="Warrior", B2="Warrior", N2="Warrior", K2="Warrior", W2="Warrior" }, 
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

WOWTR_Font1 = WoWTR_Localization.mainFolder.."\\Fonts\\morpheus_tr.ttf";
WOWTR_Font2 = WoWTR_Localization.mainFolder.."\\Fonts\\frizquadrata_tr.ttf";
WOWTR_Fonts = {"frizquadrata_tr.ttf", "Expressway.ttf", "Naowh.ttf"};
local GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata;
WOWTR_version = GetAddOnMetadata(WoWTR_Localization.addonFolder, "Version");
