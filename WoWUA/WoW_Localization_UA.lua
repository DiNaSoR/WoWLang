-- Description: Texts in the selected localization language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
---------------------------------------------------------------------------------------------------------

WoWTR_Localization = {
   lang = "UA",
   started = "запущено",
   mainFolder = "Interface\\AddOns\\WoWUA",
   addonFolder = "WoWUA",
   addonName = "WoW-UA",
   addonIconDesc = "Натисніть, щоб відкрити\nменю налаштувань доповнення",
   optionName = "wow-ua - Налаштування",
   optionTitle = "WoW-UA",
   optionTitleAR = "",
   addressWWW = "https://panel.wowpopolsku.pl/tools/index_ua.php",
   addressDiscord = "https://discord.gg/s5rKEJMukA",
   addressTwitch = "",                                               -- address of Twitch page 
   addressFanPage = "",                                              -- address of FanPage 
   addressEmail = "",
   addressCurse = "https://www.curseforge.com/wow/addons/wow-ua",     -- address of CurseForge page
   addressPayPal = "https://www.paypal.com/donate/?hosted_button_id=FC2NVQ5DN7GVA",   -- address of PayPal page
   addressBlik = "",                                                 -- telephon number for BLIK payment
   gossipText = "Плитки",
   quests = "Квести",
   worldquests = "Світові квести",
   campaignquests = "Квести кампанії",                               -- Campaign Quests
   scenariodung = "Сценарій",                                        -- Scenario/Dungeon
   objectives = "Цілі завдання",
   bonusobjective = "Бонусні цілі",
   rewards = "Вигороди",
   storyLineProgress = "Хід історії ",
   storyLineChapters = "Розділи",
   choiceQuestFirst = "спочатку оберіть завдання",
   readyForTurnIn = "Готовий до здачі",
   clickToComplete = "натисніть, щоб завершити",
   failed = "Не вдалося",
   optional = "Необов'язково",
   bookID = "Ідентифікатор книги:",
   stopTheMovie = "Ви хочете зупинити відео??",
   stopTheMovieYes = "Так",
   stopTheMovieNo = "Ні",
   reopenBoard = "Знову відкрити дошку",
   sellPrice = "Ціна покупки:",
   currentlyEquipped = "Наразі одягнено",
   additionalEquipped = "Додатково одягнено",
   WoWTR_trDESC = "Українська",
   WoWTR_enDESC = "Англійська",
   WoWTR_Spellbook_trDESC = "Книга заклинань: Українська",
   WoWTR_Spellbook_enDESC = "Книга заклинань: Англійська",
   travelerlog = "Щоденник мандрівника",                               -- Traveler's Log
   your_home = "Ваш Дім",
   welcomeIconPos = 245,
   resetButton1 = "Очистити збережені неперекладені тексти",
   resetButton2 = "Скинути надбудову до|nстандартних налаштувань",
   resetButton1Opis = "Очистити збережені неперекладені тексти",   -- Clear saved untranslated texts (as tooltip)
   resetButton1OpisDESC = "Усі дані, що зберігаються у файлі WowHunCraft.lua, буде видалено. Файл буде чистим.",  -- Clear saved untranslated texts (as tooltip)
   resetButton2Opis = "Скинути параметри надбудови до стандартних",  -- Reset the addon to its default settings (as tooltip)
   resetButton2OpisDESC = "Усі параметри надбудови буде скинуто до стандартних",
   resultButton1 = "Очищено збережені тексти", 
   confirmationHeader = "Підтвердження",
   confirmationText1 = "Ви хочете очистити всі збережені неперекладені тексти?",
   confirmationText2 = "Чи хочете ви відновити налаштування за замовчуванням?",
   moveFrameUpDown = "Перемістіть вікно вгору або вниз",
}

---------------------------------------------------------------------------------------------------------

QTR_Messages = { 
   isactive = "активний",
   isinactive = "неактивний",
   missing = "немає перекладу",
   details = "Опис",
   progress = "Прогрес",
   objectives = "Мета",
   completion = "Завершення",
   translator = "Перекладач",
   rewards = "Нагороди",
   experience = "Досвід:",
   reqmoney = "Необхідна сума:",
   reqitems = "Необхідні предмети:",
   itemchoose0= "Ви отримаєте:",
   itemchoose1= "Ви можете обрати одну з нагород:",
   itemchoose2= "Виберіть одну з винагород:",
   itemchoose3= "Ви отримаєте винагороду:",
   itemreceiv0= "Ви отримаєте:",
   itemreceiv1= "Ви також отримаєте:",
   itemreceiv2= "Ви отримаєте нагороду:",
   itemreceiv3= "Ви також отримаєте нагороду:",
   learnspell= "Вивчити заклинання:",
   currquests = "Поточні завдання",
   avaiquests = "Доступні завдання",
   reward_aura = "Ви отримаєте ефект:",
   reward_spell = "Ви дізнаєтеся наступне:",
   reward_companion = "Ви знайдете цих Супутників:",
   reward_follower = "Ви отримаєте цих послідовників:",
   reward_reputation = "Нагороди за репутацію:",
   reward_title = "Ви отримаєте цей титул:",
   reward_tradeskill = "Ви навчитеся створювати:",
   reward_unlock = "Ви розблокуєте доступ до наступного:",
   reward_bonus = "Виконання цього завдання в групі може винагородити вас:",
};

---------------------------------------------------------------------------------------------------------

WoWTR_Config_Interface = {
   showMinimapIcon = "Показати піктограму налаштувань доповнення поруч з міні-картою",
   showMinimapIconDESC = "Якщо увімкнено, поруч з міні-мапою з'явиться піктограма налаштувань доповнення",

   titleTab1 = "Завдання",
   generalMainHeaderQS = "ПЕРЕКЛАДИ ЗАВДАНЬ",
   activateQuestsTranslations = "Активувати переклади завдань",
   activateQuestsTranslationsDESC = "Якщо вибрано, переклад завдання буде показано замість оригінального тексту",
   translateQuestTitles = "Відображати переклад назв",
   translateQuestTitlesDESC = "Якщо позначено, буде показано переклад назви завдання",
   translateGossipTexts = "Показувати переклад тексту плиток",
   translateGossipTextsDESC = "Якщо позначено, буде показано переклад тексту плиток",
   translateTrackObjectives = "Відображати онлайн-переклади в Відстежувач цілей",
   translateTrackObjectivesDESC = "Якщо позначено, буде показано тексти в Відстежувач цілей",
   translateOwnNames = "Відображати географічні назви українською мовою",
   translateOwnNamesDESC = "Якщо вибрано, власні географічні назви у грі будуть відображатися польською мовою",
   savingUntranslatedQuests = "ЗАПИС НЕПЕРЕКЛАДЕНИХ ЗАДАЧ І ПЛІТКИ",
   saveUntranslatedQuests = "Зберегти неперекладені завдання",
   saveUntranslatedQuestsDESC = "Якщо позначено, неперекладені завдання буде збережено",
   saveUntranslatedGossip = "Зберегти неперекладені тексти плиток",
   saveUntranslatedGossipDESC = "Якщо позначено, неперекладені тексти пліток буде збережено",
   integrationWithOtherAddons = "ІНТЕГРАЦІЯ З ІНШИМИ ДОДАТКАМИ",
   translateImmersion = "Відображати переклади в доповненні immersion",
   translateImmersionDESC = "Якщо вибрано, переклади буде показано в доповненні Immersion",
   translateStoryLine = "Показувати переклади у доповненні StoryLine",
   translateStoryLineDESC = "Якщо позначено, переклади будуть відображатися у доповненні StoryLine",
   translateQuestLog = "Відображати переклади у доповненні ClassicQuestLog",
   translateQuestLogDESC = "Якщо позначено, переклади буде показано у доповненні ClassicQuestLog",
   translateDialogueUI = "Відображати переклади у доповненні DialogueUI",                         -- Display translations in DialogueUI addon
   translateDialogueUIDESC = "Якщо позначено, переклади буде показано у доповненні DialogueUI",   -- If enabled, texts in DialogueUI addon will be translated
   sampleGossipText = "Зразок тексту|розмір шрифту плиток",
   displayENfirst = "WВідображення тексту спочатку EN",                                           -- display EN text first on Quests and Gossip
   displayENfirstDESC = "Якщо позначено, спочатку відображатиметься англійський текст",           -- If enabled, English text will display first on Quests and Gossip

   titleTab2 = "Бульбашки", 
   generalMainHeaderBB = "Переклади бульбашок", 
   activateBubblesTranslations = "Активувати бульбашкові переклади",
   activateBubblesTranslationsDESC = "Якщо позначено, замість оригінального тексту буде показано переклад бульбашками", 
   displayOriginalTexts = "Відображати оригінальний текст бульбашки у вікні чату", 
   displayOriginalTextsDESC = "Якщо позначено, то у вікні чату буде відображатися оригінальний текст бульбашки", 
   displayTranslatedTexts = "Відображати перекладений текст бульбашки у вікні чату",
   displayTranslatedTextsDESC = "Якщо позначено, то у вікні чату буде показано текст перекладу бульбашкиі",
   choiceGender1OfPlayer = "Вибрати чоловічу форму звертання до гравця", 
   choiceGender1OfPlayerDESC = "Якщо вибрано, висловлювання, звернені до гравця, будуть відображатися у чоловічій формі", 
   choiceGender2OfPlayer = "Вибрати жіночу форму звертання до гравця", 
   choiceGender2OfPlayerDESC = "Якщо позначено, висловлювання, звернені до гравця, будуть відображатися у жіночій формі", 
   choiceGender3OfPlayer = "Вибрати форму звертання до гравця залежно від статі ігрового персонажа",
   choiceGender3OfPlayerDESC = "Якщо вибрано, висловлювання, звернені до гравця, будуть відображатися у формі, що залежить від статі ігрового персонажа",
   showBubblesInDungeon = "Показувати бульбашки з мовою в підземеллях",
   showBubblesInDungeonDESC = "Якщо позначено, бульбашки підземель відображатимуться у власних 5 кадрах у верхній частині екрана",
   setDungeonFrames = "Налаштувати спливаючі вікна",
   setDungeonFramesDESC = "Якщо позначено, ви зможете вертикально вирівнювати бульбашкові вікна в підземеллях",
   savingUntranslatedBubbles = "РЕКОРД НЕПЕРЕКЛАДЕНИХ СИЦЕЙ",
   saveUntranslatedBubbles = "Зберегти неперекладені бульбашки",
   saveUntranslatedBubblesDESC = "Якщо позначено, неперекладені бульбашки буде збережено", 
   fontSizeHeader = "розмір шрифту відображуваного тексту",
   setFontActivate = "Активувати зміну розміру шрифту тексту", 
   setFontActivateDESC = "Якщо вибрано, розмір шрифту тексту буде встановлено на наступне значення",
   fontsizeBubbles = "Виберіть розмір шрифту", 
   fontsizeBubblesDESC = "Розмір шрифту - це число від 10 до 20",
   sampleText = "Зразок розміру шрифту тексту",
   timerDisplay = "Час відображення перекладу",                                                        -- Translation display time

   titleTab3 = "Фільми", 
   generalMainHeaderMF = "переклади субтитрів до фільмів", 
   activateSubtitleTranslations = "Активувати переклад субтитрів",
   activateSubtitleTranslationsDESC = "Якщо позначено, переклади субтитрів буде показано для фільмів та кінематографії", 
   subtitleIntro = "Показувати переклад субтитрів у вступі",
   subtitleIntroDESC = "Якщо позначено, буде показано переклад субтитрів у вступних текстах до персонажів (INTRO)", 
   subtitleMovies = "Показувати переклад субтитрів у фільмах", 
   subtitleMoviesDESC = "Якщо позначено, буде показано переклад субтитрів у фільмах", 
   subitleMoviesDESC = "Якщо позначено, буде показано переклад субтитрів у фільмах", 
   subtitleCinematics = "Відображати переклад субтитрів у кінематографічних фільмах",
   subtitleCinematicsDESC = "Якщо позначено, відображатимуться переклади субтитрів у кінофільмах", 
   saveUntranslatedSubtitles = "Зберегти неперекладені субтитри", 
   saveUntranslatedSubtitlesDESC = "Якщо позначено, неперекладені субтитри буде збережено",
   chatService = "Service of arabic chat",
   activateChatService = "Activate of arabic chat",
   activateChatServiceDESC = "If enabled, arabic chat is active",
   chatFontActivate = "Activate font size changes",
   chatFontActivateDESC = "If enabled, font size will be set to below value",
   fontsizeChat = "Choose a font size",
   fontsizeChatDESC = "The font size is a number between 10 and 20",

   titleTab4 = "Налаштування", 
   generalMainHeaderTT = "Переклади підручників",
   activateTutorialTranslations = "Активувати переклад текстів підручників",
   activateTutorialTranslationsDESC = "Якщо вибрано, буде показано переклад текстів підручників",
   savingUntranslatedTutorials = "ЗАПИС НЕПЕРЕКЛАДНИХ ТЕКСТІВ",
   saveUntranslatedTutorials = "Зберегти неперекладені тексти підручників", 
   saveUntranslatedTutorialsDESC = "Якщо позначено, неперекладені тексти підручників буде збережено",
   fontSelectingFontHeader = "Вибір додаткового шрифту",                                             -- Selecting the add-on font
   fontSelectFontFile = "Виберіть файл шрифту",                                                      -- Select a font file
   fontCurrentFont = "Поточний шрифт:",                                                              -- Current font:

   translationUI = "ІНТЕРФЕЙС КОРИСТУВАЧА - UI",                                                     -- Translation of user interface
   savingTranslationUI = "ВАРІАНТИ РЕЄСТРАЦІЇ",                                                      -- Saving untanslated user interface
   saveTranslationUI = "Збережіть неперекладені елементи інтерфейсу",                                -- Save untranslated user interface
   saveTranslationUIDESC = "Якщо позначено, неперекладені елементи інтерфейсу зберігаються",         -- If enabled, untranslated user interface will be saving
   ReloadButtonUI = "Натисніть, щоб застосувати налаштування \"Reload UI\"",                         -- For the application of settings click "ReloadUI"
   displayTranslationtxt = "Виберіть ті, переклад яких ви хочете активувати",                        -- Display translation of user interface
   displayTranslationUI1 = "Меню гри",                                                               -- Display translation of Game Menu
   displayTranslationUI1DESC = "Меню гри та його вміст тепер відображатимуться турецькою мовою",     -- If enabled, user interface will be displayed in translation
   displayTranslationUI2 = "Інформація про персонажа",                                               -- Display translation of Character Info
   displayTranslationUI2DESC = "Інтерфейс Character Info з’явиться турецькою мовою",                 -- If enabled, user interface will be displayed in translation
   displayTranslationUI3 = "Пошук груп",                                                             -- Display translation of Group Finder
   displayTranslationUI3DESC = "Пошук груп і його підвкладки тепер відображатимуться турецькою мовою",   -- If enabled, user interface will be displayed in translation
   displayTranslationUI4 = "Колекції",                                                               -- Display translation of Collections
   displayTranslationUI4DESC = "Сторінка колекцій і її вміст тепер відображатимуться турецькою мовою",   -- If enabled, user interface will be displayed in translation
   displayTranslationUI5 = "Пригодницький посібник",                                                 -- Display translation of Adventure Guide
   displayTranslationUI5DESC = "Довідник із пригод та його підсторінки тепер відображатимуться турецькою мовою",   -- If enabled, user interface will be displayed in translation
   displayTranslationUI6 = "Список друзів",                                                          -- Display translation of Friend List
   displayTranslationUI6DESC = "Вміст списку друзів тепер відображатиметься турецькою мовою",        -- If enabled, user interface will be displayed in translation
   displayTranslationUI7 = "Професія",                                                               -- Display translation of Profession
   displayTranslationUI7DESC = "Професія та її зміст тепер відображатимуться турецькою мовою",       -- If enabled, user interface will be displayed in translation
   displayTranslationUI8 = "Фільтр і розкривні списки",                                              -- Display translation of Filter & Open List
   displayTranslationUI8DESC = "Меню фільтрів і відкритих списків тепер відображатимуться турецькою мовою",   -- If enabled, user interface will be displayed in translation

   titleTab5 = "Книги", 
   generalMainHeaderBT = "Книжкові переклади",
   activateBooksTranslations = "Активувати переклади книг",
   activateBooksTranslationsDESC = "Якщо вибрано, переклади книг буде показано замість оригінального тексту", 
   translateBookTitles = "Відображати переклад назв книг", 
   translateBookTitlesDESC = "Якщо позначено, буде показано переклад назви книги",
   showBookID = "Показати ідентифікатор книги", 
   showBookIDDESC = "Якщо позначено, буде показано ідентифікатор книги", 
   savingUntranslatedBooks = "ЗАПИС НЕПЕРЕКЛАДЕНИХ КНИГ",
   saveUntranslatedBooks = "Зберегти неперекладені книги",
   saveUntranslatedBooksDESC = "Якщо вибрано, неперекладені тексти книг буде збережено", 

   titleTab6 = "Підказки",
   generalMainHeaderST = "Переклади Підказок (|cffff00ffранній етап перекладу|r)", 
   activateTooltipTranslations = "Увімкнути переклад підкозки",
   activateTooltipTranslationsDESC = "Якщо вибрано, переклади текстів підказок буде показано замість оригінального тексту",
   translateItems = "Відображати переклад елементів", 
   translateItemsDESC = "Якщо позначено, буде показано переклад елементів", 
   translateSpells = "Відображати переклад орфограм",
   translateSpellsDESC = "Якщо позначено, то буде показано переклади заклинань",
   translateTalents = "Показувати переклад талантів",
   translateTalentsDESC = "Якщо позначено, буде показано переклад талантів", 
   showTooltipID = "Показати ідентифікатор підказки",
   showTooltipIDDESC = "Якщо вибрано, буде показано ідентифікатор підказки",
   showTooltipHash = "Показувати HASH тексту підказки",
   showTooltipHashDESC = "Якщо вибрано, буде показано HASH тексту підказки",
   translateTooltipTitle = "Показувати перекладені назви предметів, заклинань або талантів",  -- Display translated title of items, spells or talents
   translateTooltipTitleDESC = "Якщо ввімкнено, відображатимуться перекладені назви предметів, заклинань або талантів",  -- If enabled, translated title of tooltips will be displayed
   hideSellPrice = "Приховати ціну покупки товару", 
   hideSellPriceDESC = "Якщо позначено, то не відображатиметься ціна покупки товару", 
   timerHoldTranslation = "Зупинити показ товару",
   timerLimitSeconds = "Виберіть час для зупинки перекладу", 
   timerLimitSecondsDESC = "Час - число від 5 до 30", 
   displayTranslationConstantly = "Відображати переклад безперервно", 
   displayTranslationConstantlyDESC = "Якщо позначено, доповнення намагатиметься протидіяти ефекту оновлення вмісту підказок", 
   savingUntranslatedTooltips = "ЗАПИС НЕПЕРЕКЛАДЕНИХ ПІДКАЗОК",
   saveUntranslatedTooltips = "Зберегти неперекладені підказки", 
   saveUntranslatedTooltipsDESC = "Якщо вибрано, неперекладені підказки буде збережено",

   titleTab9 = "Про додаток", 
   generalText = "\nWoW-UA - це проект, спрямований на покращення гри World of Warcraft. Елементи гри, що відображаються українською мовою, включають: квести, тексти плиток при розмові з NPC, бульбашкові повідомлення, що відображаються NPC, внутрішньоігрові навчальні тексти, тексти підказок, а також субтитри до фільмів і кінематографічних фільмів та переклади книг, що зустрічаються в грі.",   -- info about project
   welcomeText = "Ласкаво просимо до доповнення |cffff00ffWoW-UA|r. Це перший запуск доповнення, тож, будь ласка, прочитайте наш вступ. \n\n\nЦе нове доповнення, яке відображає переклади ігрових текстів українською мовою. Він був створений шляхом об'єднання окремих компонентів проекту WoWpoPolsku і містить наступні частини: \n\n|cff00ffffЗавдання|r - під час розмов з NPC та в журналі квестів \n|cff00ffffПлитки|r - тексти, що відображаються під час розмов з NPC \n|cff00ffffХмарні повідомлення|r - висловлювання NPC у вигляді кульки над персонажем - субтитри для відео та кінематографу, що відображаються в грі, \n|cff00ffffПідручник|r - тексти, які навчають користуватися грою \n|cff00ffffПідказки|r - тексти, які відображаються при наведенні миші на предмет, заклинання або талант \n|cff00ffffКниги|r - переклади тексту книг, які можна знайти в грі - кожен з цих елементів можна налаштувати окремо в панелі налаштувань доповнення - найшвидший спосіб викликати її - натиснути на маленьку іконку доповнення, розміщену поруч з міні-картою. \n\n\nДля того, щоб мати можливість розвивати проект, ми будемо вдячні за вашу підтримку: для підтримки сервера проекту потрібні перекладачі англійської мови, збирачі ігрових даних та фінансові пожертви. Вся інформація доступна на нашому форумі: |cffff00ff https://wowpopolsku.pl|r Щоб полегшити фінансову підтримку, ми запустили можливість пожертвувати |cffff00ffBLIK|r за телефоном |cffff00ff+48 601 635 712|r.",
   welcomeButton = "ОК - читати",
   showWelcome = "Показати панель привітання",
   authorHeader = "ІНФОРМАЦІЯ ПРО АВТОРА",
   author = "Автор:", 
   email = "E-mail:", 
   teamHeader = "Контактні дані",
   textContact = "Якщо у вас виникли запитання щодо доповнення, зв’яжіться з нами на будь-якому каналі нижче:",
   linkWWWShow = "Натисніть, щоб переглянути посилання на веб-сторінку надбудови",
   linkWWWTitle = "Посилання на сайт",
   linkDISCShow = "Натисніть, щоб переглянути посилання на сторінку Discord",
   linkDISCTitle = "Посилання на сторінку Discord",
   linkEMAILShow = "Натисніть, щоб переглянути електронну адресу проекту",
   linkEMAILTitle = "Електронна адреса проекту",
   linkCURSEShow = "Натисніть, щоб переглянути посилання на веб-сайт CurseForge",
   linkCURSETitle = "Посилання на сайт CurseForge",
   linkPPShow = "Натисніть, щоб переглянути посилання на веб-сайт PayPal",
   linkPPTitle = "Посилання на сайт PayPal",
   linkBLIKShow = "Натисніть, щоб переглянути номер телефону BLIK",
   linkBLIKTitle = "Номер телефону BLIK",
   linkTWITCHShow = "Натисніть, щоб переглянути посилання на сторінку Twitch",
   linkTWITCHTitle = "Посилання на сторінку Twitch",
   linkFBShow = "Натисніть, щоб переглянути посилання на FanPage",
   linkFBTitle = "Посилання на FanPage",
   linkCloseFrame = "Закрийте раму",
   linkCopy = "Клікніть |cff00ffff Ctr+C|r щоб скопіювати посилання до буфера обміну Windows", 
   betaTestersHeader = "Команда WoW-UA:",
   betaTestersHeaderDESC = "Модератори: |cffff00ffIceDNicco|r\n\n|cffffff00Переклади, що містять тег в кінці [AI] були перекладені штучно\nта ще не були перевірені нашими модераторами.|r",    -- Translators and Beta testers:
};

---------------------------------------------------------------------------------------------------------
-- перекладено назви рас і класів гравців у різних відмінках іменника (M1,D1,C1,B1,N1,K1,W1;M2,D2,C2,B2,N2,K2,W2) та стать гравця (чоловіча:1, жіноча:2)
-- M1 називний,D1 родовий,C1 давальний,B1 знахідний,N1 орудний,K1 місцевий,W1 окличний
---------------------------------------------------------------------------------------------------------

local p_race = {
["Blood Elf"] = {M1 = "Кровавий Ельф", D1 = "Кровавого Ельфа", C1 = "Кровавому Ельфу", B1 = "Кровавого Ельфа", N1 = "Кровавим Ельфом", K1 = "Кровавому Ельфі", W1 = "Кровавий Ельфе", M2 = "Кровава Ельфійка", D2 = "Кровавої Ельфійки", C2 = "Кровавій Ельфійці", B2 = "Кроваву Ельфійку", N2 = "Кровавою Ельфійкою", K2 = "Кровавій Ельфійці", W2 = "Кровава Ельфійко"},
["Dark Iron Dwarf"] ={ M1 = "Дворф темного Заліза", D1 = "Дворфа темного Заліза", C1 = "Дворфу темного Заліза", B1 = "Дворфа темного Заліза", N1 = "Дворфом темного Заліза", K1 = "Дворфі темного Заліза", W1 = "Дворфе темного Заліза", M2 = "Дворфійка темного Заліза", D2 = "Дворфійки темного Заліза", C2 = "Дворфійці темного Заліза", B2 = "Дворфійку темного Заліза", N2 = "Дворфійкою темного Заліза", K2 = "Дворфійці темного Заліза", W2 = "Дворфійко темного Заліза" },
["Dracthyr"] = { M1 = "Драктир", D1 = "Драктира", C1 = "Драктирові", B1 = "Драктира", N1 = "Драктиром", K1 = "Драктирі", W1 = "Драктире", M2 = "Драктирка", D2 = "Драктирки", C2 = "Драктирці", B2 = "Драктирку", N2 = "Драктиркою", K2 = "Драктирці", W2 = "Драктирко" },
["Draenei"] = { M1 = "Дреней", D1 = "Дренея", C1 = "Дренеєві", B1 = "Дренея", N1 = "Дренеєм", K1 = "Дренеї", W1 = "Дренею", M2 = "Дренейка", D2 = "Дренейки", C2 = "Дренейці", B2 = "Дренейку", N2 = "Дренейкою", K2 = "Дренейці", W2 = "Дренейко" },
["Dwarf"] = { M1 = "Дворф", D1 = "Дворфа", C1 = "Дворфові", B1 = "Дворфа", N1 = "Дворфом", K1 = "Дворфі", W1 = "Дворфе", M2 = "Дворфійка", D2 = "Дворфійки", C2 = "Дворфійці", B2 = "Дворфійку", N2 = "Дворфійкою", K2 = "Дворфійці", W2 = "Дворфійко" },
["Earthen"] = { M1="Earthen", D1="Earthen", C1="Earthen", B1="Earthen", N1="Earthen", K1="Earthen", W1="Earthen", M2="Earthen", D2="Earthen", C2="Earthen", B2="Earthen", N2="Earthen", K2="Earthen", W2="Earthen" },
["Gnome"] = { M1 = "Гном", D1 = "Гнома", C1 = "Гнові", B1 = "Гнома", N1 = "Гномом", K1 = "Гномі", W1 = "Гноме", M2 = "Гномка", D2 = "Гномки", C2 = "Гномці", B2 = "Гномку", N2 = "Гномкою", K2 = "Гномці", W2 = "Гномко" },
["Goblin"] = { M1 = "Гоблін", D1 = "Гобліна", C1 = "Гоблінові", B1 = "Гобліна", N1 = "Гобліном", K1 = "Гобліні", W1 = "Гобліне", M2 = "Гоблінка", D2 = "Гоблінки", C2 = "Гоблінці", B2 = "Гоблінку", N2 = "Гоблінкою", K2 = "Гоблінці", W2 = "Гоблінко" },
["Highmountain Tauren"] = { M1 = "Таурен Високогір'я", D1 = "Таурена Високогір'я", C1 = "Тауренові Високогір'я", B1 = "Таурена Високогір'я", N1 = "Тауреном Високогір'я", K1 = "Таурені Високогір'я", W1 = "Таурене Високогір'я", M2 = "Тауренка Високогір'я", D2 = "Тауренки Високогір'я", C2 = "Тауренці Високогір'я", B2 = "Тауренку Високогір'я", N2 = "Тауренкою Високогір'я", K2 = "Тауренці Високогір'я", W2 = "Тауренко Високогір'я" },
["Human"] = { M1 = "Чоловік", D1 = "Чоловіка", C1 = "Чоловікові", B1 = "Чоловіка", N1 = "Чоловіком", K1 = "Чоловіці", W1 = "Чоловіче", M2 = "Жінка", D2 = "Жінки", C2 = "Жінці", B2 = "Жінку", N2 = "Жінкою", K2 = "Жінці", W2 = "Жінко" },
["Kul Tiran"] = { M1 = "Кул-Тирасець", D1 = "Кул-Тирасця", C1 = "Кул-Тирасцеві", B1 = "Кул-Тирасця", N1 = "Кул-Тирасцем", K1 = "Кул-Тирасці", W1 = "Кул-Тирасцю", M2 = "Кул-Тираска", D2 = "Кул-Тираски", C2 = "Кул-Тирасці", B2 = "Кул-Тираску", N2 = "Кул-Тираскою", K2 = "Кул-Тирасці", W2 = "Кул-Тираско" },
["Lightforged Draenei"] = { M1 = "Дреней Світла", D1 = "Дренея Світла", C1 = "Дренеєві Світла", B1 = "Дренея Світла", N1 = "Дренеєм Світла", K1 = "Дренеї Світла", W1 = "Дренею Світла", M2 = "Дренейка Світла", D2 = "Дренейки Світла", C2 = "Дренейці Світла", B2 = "Дренейку Світла", N2 = "Дренейкою Світла", K2 = "Дренейці Світла", W2 = "Дренейко Світла" },
["Mag'har Orc"] = { M1 = "Орк Маг'хар", D1 = "Орка Маг'хара", C1 = "Орку Маг'хару", B1 = "Орка Маг'хара", N1 = "Орком Маг'хара", K1 = "Орці Маг'хара", W1 = "Орку Маг'харе", M2 = "Орчиня Маг'хар", D2 = "Орчині Маг'хар", C2 = "Орчині Маг'хару", B2 = "Орчиню Маг'хар", N2 = "Орчинею Маг'хар", K2 = "Орчині Маг'хару", W2 = "Орчине Маг'хар" },
["Mechagnome"] = { M1="Механогном", D1="Механогнома", C1="Механогномові", B1="Механогнома", N1="Механогномом", K1="Механогномові", W1="Механогноме", M2="Механогномка", D2="Механогномки", C2="Механогномці", B2="Механогномку", N2="Механогномкою", K2="Механогномці", W2="Механогномко" },
["Nightborne"] = { M1="Нічнонароджений", D1="Нічнонародженого", C1="Нічнонародженому", B1="Нічнонародженого", N1="Нічнонародженим", K1="Нічнонародженому", W1="Нічнонароджений", M2="Нічнонароджена", D2="Нічнонародженої", C2="Нічнонародженій", B2="Нічнонароджену", N2="Нічнонародженою", K2="Нічнонародженій", W2="Нічнонароджена" },
["Night Elf"] = { M1="Нічний Ельф", D1="Нічного Ельфа", C1="Нічному Ельфу", B1="Нічного Ельфа", N1="Нічним Ельфом", K1="Нічному Ельфу", W1="Нічний Ельфе", M2="Нічна Ельфійка", D2="Нічної Ельфійки", C2="Нічній Ельфійці", B2="Нічну Ельфійку", N2="Нічною Ельфійкою", K2="Нічній Ельфійці", W2="Нічна Ельфійко" },
["Orc"] = { M1="Орк", D1="Орка", C1="Оркові", B1="Орка", N1="Орком", K1="Оркові", W1="Орче", M2="Орчиня", D2="Орчині", C2="Орчині", B2="Орчиню", N2="Орчинею", K2="Орчині", W2="Орчине" },
["Pandaren"] = { M1="Пандарен", D1="Пандарена", C1="Пандаренові", B1="Пандарена", N1="Пандареном", K1="Пандаренові", W1="Пандарене", M2="Пандаренка", D2="Пандаренки", C2="Пандаренці", B2="Пандаренку", N2="Пандаренкою", K2="Пандаренці", W2="Пандаренко" },
["Tauren"] = { M1="Таурен", D1="Таурена", C1="Тауренові", B1="Таурена", N1="Тауреном", K1="Тауренові", W1="Таурене", M2="Тауренка", D2="Тауренки", C2="Тауренці", B2="Тауренку", N2="Тауренкою", K2="Тауренці", W2="Тауренко" },
["Troll"] = { M1="Троль", D1="Троля", C1="Тролеві", B1="Троля", N1="Тролем", K1="Тролеві", W1="Троле", M2="Тролиня", D2="Тролині", C2="Тролині", B2="Тролиню", N2="Тролинею", K2="Тролині", W2="Тролине" },
["Undead"] = { M1="Нежить", D1="Нежиття", C1="Нежиттю", B1="Нежиття", N1="Нежиттям", K1="Нежитті", W1="Нежиттю", M2="Нежить", D2="Нежиття", C2="Нежиттю", B2="Нежиття", N2="Нежиттям", K2="Нежитті", W2="Нежиттю" },
["Void Elf"] = { M1="Ельф Порожнечі", D1="Ельфа Порожнечі", C1="Ельфу Порожнечі", B1="Ельфа Порожнечі", N1="Ельфом Порожнечі", K1="Ельфу Порожнечі", W1="Ельфе Порожнечі", M2="Ельфійка Порожнечі", D2="Ельфійки Порожнечі", C2="Ельфійці Порожнечі", B2="Ельфійку Порожнечі", N2="Ельфійкою Порожнечі", K2="Ельфійці Порожнечі", W2="Ельфійко Порожнечі" },
["Vulpera"] = { M1="Вульпер", D1="Вульпера", C1="Вульперу", B1="Вульпера", N1="Вульпером", K1="Вульпері", W1="Вульпере", M2="Вульперка", D2="Вульперки", C2="Вульперці", B2="Вульперку", N2="Вульперкою", K2="Вульперці", W2="Вульперко" },
["Worgen"] = { M1="Ворген", D1="Воргена", C1="Воргенові", B1="Воргена", N1="Воргеном", K1="Воргенові", W1="Воргене", M2="Воргенка", D2="Воргенки", C2="Воргенці", B2="Воргенку", N2="Воргенкою", K2="Воргенці", W2="Воргенко" },
["Zandalari Troll"] = { M1="Троль Зандалара", D1="Троля Зандалара", C1="Тролеві Зандалара", B1="Троля Зандалара", N1="Тролем Зандалара", K1="Тролеві Зандалара", W1="Троле Зандалара", M2="Тролиня Зандалара", D2="Тролині Зандалара", C2="Тролині Зандалара", B2="Тролиню Зандалара", N2="Тролинею Зандалара", K2="Тролині Зандалара", W2="Тролине Зандалара" },
};
local p_class = {
["Death Knight"] = { M1="Лицар Смерті", D1="Лицаря Смерті", C1="Лицареві Смерті", B1="Лицаря Смерті", N1="Лицарем Смерті", K1="Лицареві Смерті", W1="Лицарю Смерті", M2="Лицарка Смерті", D2="Лицарки Смерті", C2="Лицарці Смерті", B2="Лицарку Смерті", N2="Лицаркою Смерті", K2="Лицарці Смерті", W2="Лицарко Смерті" },
["Demon Hunter"] = { M1="Мисливець на Демонів", D1="Мисливця на Демонів", C1="Мисливцеві на Демонів", B1="Мисливця на Демонів", N1="Мисливцем на Демонів", K1="Мисливцеві на Демонів", W1="Мисливцю на Демонів", M2="Мисливеця на Демонів", D2="Мисливеці на Демонів", C2="Мисливеці на Демонів", B2="Мисливецю на Демонів", N2="Мисливецею на Демонів", K2="Мисливеці на Демонів", W2="Мисливеце на Демонів" },
["Druid"] = { M1="Друїд", D1="Друїда", C1="Друїдові", B1="Друїда", N1="Друїдом", K1="Друїдові", W1="Друїде", M2="Друїдка", D2="Друїдки", C2="Друїдці", B2="Друїдку", N2="Друїдкою", K2="Друїдці", W2="Друїдко" },
["Evoker"] = { M1="Евокер", D1="Евокера", C1="Евокерові", B1="Евокера", N1="Евокером", K1="Евокерові", W1="Евокере", M2="Евокерка", D2="Евокерки", C2="Евокерці", B2="Евокерку", N2="Евокеркою", K2="Евокерці", W2="Евокерко" },
["Hunter"] = { M1="Мисливець", D1="Мисливця", C1="Мисливцеві", B1="Мисливця", N1="Мисливцем", K1="Мисливцеві", W1="Мисливцю", M2="Мисливеця", D2="Мисливеці", C2="Мисливеці", B2="Мисливецю", N2="Мисливецею", K2="Мисливеці", W2="Мисливеце" },
["Mage"] = { M1="Чародій", D1="Чародія", C1="Чародієві", B1="Чародія", N1="Чародієм", K1="Чародієві", W1="Чародію", M2="Чародійка", D2="Чародійки", C2="Чародійці", B2="Чародійку", N2="Чародійкою", K2="Чародійці", W2="Чародійко" },
["Monk"] = { M1="Монах", D1="Монаха", C1="Монахові", B1="Монаха", N1="Монахом", K1="Монахові", W1="Монаше", M2="Монахиня", D2="Монахині", C2="Монахині", B2="Монахиню", N2="Монахинею", K2="Монахині", W2="Монахине" },
["Paladin"] = { M1="Паладін", D1="Паладіна", C1="Паладінові", B1="Паладіна", N1="Паладіном", K1="Паладінові", W1="Паладіне", M2="Паладінка", D2="Паладінки", C2="Паладінці", B2="Паладінку", N2="Паладінкою", K2="Паладінці", W2="Паладінко" },
["Priest"] = { M1="Жрець", D1="Жреця", C1="Жрецеві", B1="Жреця", N1="Жрецем", K1="Жрецеві", W1="Жрече", M2="Жриця", D2="Жриці", C2="Жриці", B2="Жрицю", N2="Жрицею", K2="Жриці", W2="Жрице" },
["Rogue"] = { M1="Розбійник", D1="Розбійника", C1="Розбійникові", B1="Розбійника", N1="Розбійником", K1="Розбійникові", W1="Розбійнику", M2="Розбійниця", D2="Розбійниці", C2="Розбійниці", B2="Розбійницю", N2="Розбійницею", K2="Розбійниці", W2="Розбійнице" },
["Shaman"] = { M1="Шаман", D1="Шамана", C1="Шаманові", B1="Шамана", N1="Шаманом", K1="Шаманові", W1="Шамане", M2="Шаманка", D2="Шаманки", C2="Шаманці", B2="Шаманку", N2="Шаманкою", K2="Шаманці", W2="Шаманко" },
["Warlock"] = { M1="Відьмак", D1="Відьмака", C1="Відьмакові", B1="Відьмака", N1="Відьмаком", K1="Відьмакові", W1="Відьмаку", M2="Відьмачка", D2="Відьмачки", C2="Відьмачці", B2="Відьмачку", N2="Відьмачкою", K2="Відьмачці", W2="Відьмачко" },
["Warrior"] = { M1="Воїн", D1="Воїна", C1="Воїнові", B1="Воїна", N1="Воїном", K1="Воїнові", W1="Воїне", M2="Воїтелька", D2="Воїтельки", C2="Воїтельці", B2="Воїтельку", N2="Воїтелькою", K2="Воїтельці", W2="Воїтелько" },
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

WOWTR_Font1 = WoWTR_Localization.mainFolder.."\\Fonts\\morpheus_ua.ttf";
WOWTR_Font2 = WoWTR_Localization.mainFolder.."\\Fonts\\frizquadratatt_ua.ttf";
WOWTR_Fonts = {"frizquadratatt_ua.ttf"};
local GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata;
WOWTR_version = GetAddOnMetadata(WoWTR_Localization.addonFolder, "Version");
