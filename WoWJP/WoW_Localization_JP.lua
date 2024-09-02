-- Description: Texts in the selected localization language
-- Author: Platine [platine.wow@gmail.com]
-- Co-Author: Dragonarab[WoWAR], Hakan YILMAZ[WoWTR]
-------------------------------------------------------------------------------------------------------

WoWTR_Localization = {
   lang = "JP",
   started = "動作中",                                                -- addon was started
   mainFolder = "Interface\\AddOns\\WoWJP",                          -- origin main folder for addon files
   addonFolder = "WoWJP",                                            -- name of the folder where the addon was installed
   addonName = "WoWinJapanese",                                      -- origin short name of the addon 
   addonIconDesc = "クリックして設定メニューを開く ",                             -- Click to open the settings menu 
   optionName = "WoWinJapanese - 設定",                               -- WoWJP - options 
   optionTitle = "WoWinJapanese",                                    -- origin full name 
   optionTitleAR = "",
   addressWWW = "https://panel.wowpopolsku.pl/",                     -- address of project page 
   addressDiscord = "",                                              -- address of discord page 
   addressTwitch = "",                                               -- address of Twitch page 
   addressFanPage = "",                                              -- address of FanPage 
   addressEmail = "",                                                -- address of e-mail
   addressCurse = "https://legacy.curseforge.com/wow/addons/wowinjapanese",           -- address of CurseForge page
   addressPayPal = "https://www.paypal.com/donate/?hosted_button_id=FC2NVQ5DN7GVA",   -- address of PayPal page
   addressBlik = "",                                                 -- telephon number for BLIK payment
   gossipText = "ゴシップ",                                              -- gossip text 
   quests = "クエスト",                                                  -- Quests 
   worldquests = "ワールドクエスト",                                        -- World Quests 
   campaignquests = "キャンペーンクエスト",                                   -- Campaign Quests
   scenariodung = "シナリオ",                                            -- Scenario/Dungeon
   objectives = "目的",                                               -- Objectives 
   rewards = "報酬",                                                  -- Rewards 
   storyLineProgress = "ストーリーの進捗状況",                              -- Story Progress 
   storyLineChapters = "チャプター",                                      -- Chapters 
   choiceQuestFirst = "最初にクエストを選ぶ",                                -- choose a quest first 
   readyForTurnIn = "報告準備完了",                                     -- Ready for turn-in 
   clickToComplete = "クリックで完了",                                     -- click to complete 
   failed = "失敗",                                                   -- Failed 
   optional = "オプション",                                               -- Optional 
   emptyProgress = "良くやった, $N",                                      -- You are doing well, $N 
   bookID = "本のID:",                                                 -- Book ID:
   stopTheMovie = "ムービーを止めますか？",                                   -- Do you want to stop the video? 
   stopTheMovieYes = "はい",                                           -- Yes 
   stopTheMovieNo = "いいえ",                                           -- No 
   reopenBoard = "掲示を再度開いてください",                                  -- Reopen the Bulletin Board 
   sellPrice = "売値:",                                                -- Sell price:
   currentlyEquipped = "現在装備中",                                     -- Currently Equipped
   additionalEquipped = "追加装備を装備",                                 -- Equipped with additional Equipment
   WoWTR_trDESC = "日本語",                               -- Japanese
   WoWTR_enDESC = "英語",                              -- English
   WoWTR_Spellbook_trDESC = "スペルブック: 日本語",                          -- Spell Book: Japanese
   WoWTR_Spellbook_enDESC = "Spell Book: 英語",                        -- Spell Book: English
   your_home = "あなたのホーム",                                            -- 'your home' (if the Hearthstone location fails to be read)
   welcomeIconPos = 255,                                               -- position of welcome icon on the welcom panel; 0 = disabled to display
   resetButton1 = "保存された未翻訳のテキストをクリア",                            -- Clear saved untranslated texts (without polish font)
   resetButton2 = "アドオンの設定をデフォルトにリセット",                             -- Reset the addon to its default settings (without polish font)
   resetButton1Opis = "保存された未翻訳のテキストをクリア",                        -- Clear saved untranslated texts (as tooltip)
   resetButton1OpisDESC = "ゲーム内のすべての保存データが削除されます",               -- Reset the addon to its default settings (as tooltip)
   resetButton2Opis = "アドオンの設定をデフォルトにリセット",                         -- Reset the addon to its default settings (as tooltip)
   resetButton2OpisDESC = "アドオンのすべての設定がデフォルト値にリセットされます (ゲームの再起動が必要です)",
   resultButton1 = "保存されたテキストがクリアされました",                            -- Saved texts cleared
   confirmationHeader = "確認",                                         -- Confirmation Header
   confirmationText1 = "保存された未翻訳のテキストをすべてクリアしますか？",              -- Do you want to clear all saved untranslated texts?
   confirmationText2 = "アドオンのデフォルト設定を復元しますか？",                    -- Do you want to restore the default settings of the addon?
   moveFrameUpDown = "ウィンドウを上下に移動",                                 -- Move the window up or down
};

---------------------------------------------------------------------------------------------------------

QTR_Messages = {   
   isactive   = "アクティブ",                                     -- (is active) 
   isinactive = "非アクティブ",                                   -- (is inactive) 
   missing    = "見つかりません",                                 -- (no translation) 
   details    = "詳細",                                       -- (Description) 
   progress   = "進捗",                                       -- (Progress) 
   objectives = "目的",                                       -- (Objectives) 
   completion = "完了",                                       -- (Completion) 
   translator = "翻訳者",                                      -- (Translator) 
   rewards    = "報酬",                                       -- (Rewards) 
   experience = "経験値:",                                     -- (Experience) 
   reqmoney   = "必要な金額:",                                  -- (Required money) 
   reqitems   = "必要なアイテム:",                                -- (Required items) 
   itemchoose0= "あなたが受け取るもの:",                            -- (You will receive:) 
   itemchoose1= "報酬から1つ選ぶことができます:",                      -- (You will be able to choose one of these rewards:) 
   itemchoose2= "これらの報酬から1つ選んでください:",                    -- (Choose one of these rewards:) 
   itemchoose3= "報酬を受け取る:",                               -- (You receiving the reward:) 
   itemreceiv0= "あなたが受け取るもの:",                            -- (You will receive:) 
   itemreceiv1= "さらに受け取るもの:",                              -- (You will also receive:) 
   itemreceiv2= "報酬を受け取る:",                               -- (You receiving the reward:) 
   itemreceiv3= "さらに報酬を受け取る:",                            -- (You also receiving the reward:) 
   learnspell = "スペルを学ぶ:",                                 -- (Learn Spell:) 
   currquests = "現在のクエスト",                                 -- (Current Quests) 
   avaiquests = "利用可能なクエスト",                              -- (Available Quests) 
   reward_aura      = "次のオーラがかかる:",                        -- (The following will be cast on you:) 
   reward_spell     = "次の呪文を学ぶ:",                         -- (You will learn the following:) 
   reward_companion = "コンパニオンを得る:",                        -- (You will gain these Companions:) 
   reward_follower  = "フォロアーを得る:",                         -- (You will gain these followers:) 
   reward_reputation= "名声が上がる:",                          -- (Reputation awards:) 
   reward_title     = "次の称号を得る:",                         -- (You shall be granted the title:) 
   reward_tradeskill= "次のアイテムを作成する方法を学ぶ:",              -- (You will learn how to create:) 
   reward_unlock    = "次のアクセスが解除される:",                    -- (You will unlock access to the following:) 
   reward_bonus     = "パーティ同期中にこのクエストを完了すると、報酬として次のものが得られる可能性がある:",  -- (Completing this quest while in Party Sync may reward:) 
}; 

---------------------------------------------------------------------------------------------------------

WoWTR_Config_Interface = {
   showMinimapIcon = "ミニマップの横にアドオン設定アイコンを表示",                          -- Show the addon setting icon next to the minimap
   showMinimapIconDESC = "有効にすると、ミニマップの横にアドオン設定アイコンが表示されます",         -- If enabled, the addon settings icon will display next to the minimap
   
   titleTab1 = "クエスト",                                                                   -- Quests
   generalMainHeaderQS = "クエスト翻訳",                                                      -- Quest translations
   activateQuestsTranslations = "クエスト翻訳を有効にする",                                       -- Activate quest translations
   activateQuestsTranslationsDESC = "有効にすると、クエストの翻訳がオリジナルテキストの代わりに表示されます",       -- If enabled, quest translations will appear in place of the original texts
   translateQuestTitles = "クエストのタイトル翻訳を表示",                                          -- Display translations of quest TITLES 
   translateQuestTitlesDESC = "有効にすると、クエストタイトルの翻訳が表示されます",                         -- If enabled, quest titles will be translated 
   translateGossipTexts = "ゴシップテキストの翻訳を表示",                                          -- Display translations of GOSSIP texts 
   translateGossipTextsDESC = "有効にすると、ゴシップテキストの翻訳が表示されます",                         -- If enabled, gossip texts will be translated
   translateTrackObjectives = "Objectives Trackerでのオンライン翻訳を表示",                       -- Display translations online in Objectives Tracker
   translateTrackObjectivesDESC = "有効にすると、Objectives Tracker内のテキストが翻訳されます",         -- If enabled, texts in Objectives Tracker will be translated
   translateOwnNames = "地名の固有名詞を日本語で表示",                                           -- Display own mames in polish language
   translateOwnNamesDESC = "有効にすると、ゲーム内の地名が日本語で表示されます",                          -- If enabled, own names of cities, places etc. will displaying in polish language
   savingUntranslatedQuests = "未翻訳のクエストとゴシップテキストの保存",                               -- Saving untranslated quests and gossip texts
   saveUntranslatedQuests = "未翻訳のクエストを保存",                                           -- Save untranslated quests 
   saveUntranslatedQuestsDESC = "有効にすると、未翻訳のクエストが保存されます",                          -- If enabled, untranslated quests will be saved 
   saveUntranslatedGossip = "未翻訳のゴシップテキストを保存",                                      -- Save untranslated gossip texts
   saveUntranslatedGossipDESC = "有効にすると、未翻訳のゴシップテキストが保存されます",                     -- If enabled, untranslated gossip texts will be saved
   integrationWithOtherAddons = "他のアドオンとの統合",                                         -- Integration with other addons
   translateImmersion = "Immersionアドオンでの翻訳を表示",                                      -- Display translations in Immersion addon
   translateImmersionDESC = "有効にすると、Immersionアドオンでテキストが翻訳されます",                    -- If enabled, texts in Immersion addon will be translated
   translateStoryLine = "StoryLineアドオンでの翻訳を表示",                                      -- Display translations in StoryLine addon
   translateStoryLineDESC = "有効にすると、StoryLineアドオンでテキストが翻訳されます",                    -- If enabled, texts in StoryLine addon will be translated
   translateQuestLog = "ClassicQuestLogアドオンでの翻訳を表示",                                 -- Display translations in Classic Quest Log addon
   translateQuestLogDESC = "有効にすると、ClassicQuestLogアドオンでテキストが翻訳されます",               -- If enabled, texts in Classic Quest Log addon will be translated
   translateDialogueUI = "DialogueUIアドオンでの翻訳を表示",                                    -- Display translations in DialogueUI addon
   translateDialogueUIDESC = "有効にすると、DialogueUIアドオンでテキストが翻訳されます",                  -- If enabled, texts in DialogueUI addon will be translated
   sampleGossipText = "ゴシップフォントサイズのサンプルテキスト",                                        -- Sample Gossip font size text (TR:Gossip Örnek yazı tipi boyutu metni)

   titleTab2 = "吹き出し",                                                                 -- Bubbles 
   generalMainHeaderBB = "吹き出しの翻訳",                                                   -- Bubbles translations
   activateBubblesTranslations = "吹き出しの翻訳を有効にする",                                   -- Activate bubble translations 
   activateBubblesTranslationsDESC = "有効にすると、吹き出しの翻訳がオリジナルテキストの代わりに表示されます",     -- If enabled, bubble translations will appear in place of the original texts
   displayOriginalTexts = "チャットフレームにオリジナルの吹き出しテキストを表示",                             -- Display original text in chat frame
   displayOriginalTextsDESC = "有効にすると、チャットフレームにオリジナルの吹き出しテキストが表示されます",           -- If enabled, original texts of bullbe will be displayed 
   displayTranslatedTexts = "チャットフレームに翻訳された吹き出しテキストを表示",                           -- Display translated text in chat frame 
   displayTranslatedTextsDESC = "有効にすると、チャットフレームに翻訳された吹き出しテキストが表示されます",          -- If enabled, translated texts will be displayed
   choiceGender1OfPlayer = "プレイヤーに対する男性形の表現を選択",                                   -- Choice of male expression to the player 
   choiceGender1OfPlayerDESC = "有効にすると、プレイヤーに対する表現が男性形で表示されます",                  -- If enabled, translated bubbles will be displayed in male form 
   choiceGender2OfPlayer = "プレイヤーに対する女性形の表現を選択",                                   -- Choice of female expression to the player 
   choiceGender2OfPlayerDESC = "有効にすると、プレイヤーに対する表現が女性形で表示されます",                  -- If enabled, translated bubbles will be displayed in female form 
   choiceGender3OfPlayer = "ゲーム内のキャラクターの性別に応じた表現を選択",                              -- Choise of expression for the player depending on the gender of the character 
   choiceGender3OfPlayerDESC = "有効にすると、ゲーム内のキャラクターの性別に応じて表現が表示されます",             -- If enbled, translated bubbles will be displayed in male form 
   showBubblesInDungeon = "ダンジョン内で吹き出しを表示",                                           -- Show bubbles in dungeons
   showBubblesInDungeonDESC = "有効にすると、ダンジョン内の吹き出しが画面上部にある5つの専用フレームで表示されます",    -- If checked, dungeon bubbles will be shown in their own 5 frames at the top of the screen
   setDungeonFrames = "吹き出しウィンドウの設定",                                                  -- Set up speech bubble frames
   setDungeonFramesDESC = "有効にすると、ダンジョン内で吹き出しウィンドウを縦に整列させることができます",               -- When checked, you will be able to vertically align the bubble windows in dungeons
   savingUntranslatedBubbles = "未翻訳の吹き出しの保存",                                        -- Saving untranslated bubbles
   saveUntranslatedBubbles = "未翻訳の吹き出しを保存",                                          -- Save untranslated bubbles 
   saveUntranslatedBubblesDESC = "有効にすると、未翻訳の吹き出しが保存されます",                         -- If enabled, untranslated bubbles will be saved 
   fontSizeHeader = "表示されるテキストのフォントサイズ",                                              -- Font size of bubbles
   setFontActivate = "フォントサイズ変更の有効化",                                                 -- Activate font size changes 
   setFontActivateDESC = "有効にすると、フォントサイズが以下の値に設定されます",                              -- If enabled, font size will be set to below value   
   fontsizeBubbles = "フォントサイズを選択",                                                      -- Choose a font size 
   fontsizeBubblesDESC = "フォントサイズは10から20の間の数値です",                                     -- The font size is a number between 10 and 20
   sampleText = "フォントサイズのサンプルテキスト",                                                    -- Sample font size text
   timerDisplay = "翻訳の表示時間",                                                           -- Translation display time

   titleTab3 = "ムービー＆シネマティック",                                                           -- Movies & Cinematics
   generalMainHeaderMF = "字幕の翻訳",                                                       -- Subtitle translations
   activateSubtitleTranslations = "字幕の翻訳を有効にする",                                      -- Activate subtitle translations
   activateSubtitleTranslationsDESC = "有効にすると、字幕の翻訳が表示されます",                        -- If enabled, translated subtitles will displayed
   subtitleIntro = "イントロの翻訳を表示",                                                       -- Display translated subtitles of Intro
   subtitleIntroDESC = "有効にすると、キャラクターのイントロの翻訳が表示されます",                              -- If enbled, translated subtitles will be displyed into starting Intro
   subtitleMovies = "ムービーの字幕翻訳を表示",                                                   -- Display translated subtitles of Movies
   subtitleMoviesDESC = "有効にすると、ムービーの字幕翻訳が表示されます",                                  -- If enabled, translated subtitles will be displyed into movies 
   subtitleCinematics = "シネマティックの字幕翻訳を表示",                                             -- Display translated subtitles of Cinematics
   subtitleCinematicsDESC = "有効にすると、シネマティックの字幕翻訳が表示されます",                           -- If enbled, translated subtitles will be displyed into cinematics 
   savingUntranslatedSubtitles = "未翻訳の字幕の保存",                                          -- Saving untranslated subtitles 
   saveUntranslatedSubtitles = "未翻訳の字幕の保存",                                            -- Save untranslated subtitles
   saveUntranslatedSubtitlesDESC = "有効にすると、未翻訳の字幕が保存されます",                           -- If enbled, untranslated subtitles will be saved
   chatService = "アラビア語チャットのサービス",
   activateChatService = "アラビア語チャットを有効にする",
   activateChatServiceDESC = "有効にすると、アラビア語チャットがアクティブになります",
   chatFontActivate = "フォントサイズ変更の有効化",
   chatFontActivateDESC = "有効にすると、フォントサイズが以下の値に設定されます",
   fontsizeChat = "フォントサイズを選択",
   fontsizeChatDESC = "フォントサイズは10から20の間の数値です",

   titleTab4 = "UI設定",                                                                   -- Ustawienia Interfejsu Użytkownika
   generalMainHeaderTT = "チュートリアルの翻訳",                                                  -- Tutorial translations
   activateTutorialTranslations = "チュートリアルテキストの翻訳を有効にする",                            -- Activate tutorial translations
   activateTutorialTranslationsDESC = "有効にすると、チュートリアルのテキスト翻訳が表示されます",               -- If enabled, translated tutorials will displayed
   savingUntranslatedTutorials = "未翻訳のチュートリアルテキストの保存",                               -- Saving untranslated tutorials
   saveUntranslatedTutorials = "未翻訳のチュートリアルテキストを保存",                                 -- Save untranslated tutorials
   saveUntranslatedTutorialsDESC = "有効にすると、未翻訳のチュートリアルテキストが保存されます",                -- If enbled, untranslated tutorials will be saved
   fontSelectingFontHeader = "翻訳用フォントの選択",                                             -- Font selection for the main texts of the translation
   fontSelectFontFile = "フォントファイルを選択",                                                  -- Select a font file
   fontCurrentFont = "現在のフォント:",                                                        -- Current font:

   translationUI = "ユーザーインターフェースの翻訳",                                                  -- Translation of user interface
   savingTranslationUI = "データの保存",                                                      -- Saving untanslated user interface
   saveTranslationUI = "未翻訳のインターフェース要素を保存",                                          -- Save untranslated user interface
   saveTranslationUIDESC = "有効にすると、未翻訳のユーザーインターフェース要素が保存されます",                    -- If enabled, untranslated user interface will be saving
   ReloadButtonUI = "\"Reload UI\"設定を適用するにはクリック",                                      -- Click to apple the setting "ReloadUI" (bez polskich znaków)
   displayTranslationtxt = "どの翻訳を有効にするか選択してください:",                                   -- Display whith translations do you want to translate:
   displayTranslationUI1 = "ゲームメニュー",                                                    -- Game Menu
   displayTranslationUI1DESC = "ゲームメニューとその内容が日本語で表示されるようになります",                    -- If enabled, user interface will be displayed in translation
   displayTranslationUI2 = "キャラクター情報",                                                  -- Character Info
   displayTranslationUI2DESC = "キャラクター情報のインターフェースが日本語で表示されるようになります",               -- If enabled, user interface will be displayed in translation
   displayTranslationUI3 = "グループファインダー",                                                 -- Group Finder
   displayTranslationUI3DESC = "グループ検索とそのサブタブが日本語で表示されるようになります",                   -- If enabled, user interface will be displayed in translation
   displayTranslationUI4 = "コレクション",                                                      -- Collections
   displayTranslationUI4DESC = "コレクションページとその内容が日本語で表示されるようになります",                  -- If enabled, user interface will be displayed in translation
   displayTranslationUI5 = "アドベンチャーガイド",                                                -- Adventure Guide
   displayTranslationUI5DESC = "アドベンチャーガイドとそのサブページが日本語で表示されるようになります",             -- If enabled, user interface will be displayed in translation
   displayTranslationUI6 = "フレンドリスト",                                                    -- Friend List
   displayTranslationUI6DESC = "フレンドリストの内容が日本語で表示されるようになります",                      -- If enabled, user interface will be displayed in translation
   displayTranslationUI7 = "プロフェッション",                                                   -- Profession
   displayTranslationUI7DESC = "プロフェッションとその内容が日本語で表示されるようになります",                   -- If enabled, user interface will be displayed in translation
   displayTranslationUI8 = "フィルターとオープンリスト",                                             -- Filter & Open List
   displayTranslationUI8DESC = "フィルターメニューとオープンリストが日本語で表示されるようになります",               -- If enabled, user interface will be displayed in translation

   titleTab5 = "本",                                                                     -- Books (header of Tab)
   generalMainHeaderBT = "本の翻訳",                                                       -- Books translations
   activateBooksTranslations = "本の翻訳を有効にする",                                         -- Activate book translations
   activateBooksTranslationsDESC = "有効にすると、本の翻訳がオリジナルテキストの代わりに表示されます",           -- If enabled, book translations will appear in place of the original texts
   translateBookTitles = "本のタイトルの翻訳を表示",                                             -- Display translations of book TITLES
   translateBookTitlesDESC = "有効にすると、本のタイトルが翻訳されて表示されます",                         -- If enabled, book titles will be translated 
   showBookID = "本のIDを表示",                                                            -- Show ID of book
   showBookIDDESC = "有効にすると、本のIDが表示されます",                                           -- If enabled, ID of book will be shown
   savingUntranslatedBooks = "未翻訳の本を保存",                                             -- Saving untranslated books
   saveUntranslatedBooks = "未翻訳の本を保存",                                               -- Save untranslated books
   saveUntranslatedBooksDESC = "有効にすると、未翻訳の本が保存されます",                              -- If enabled, untranslated books will be saved 

   titleTab6 = "ツールチップ",                                                                -- Tooltips
   generalMainHeaderST = "ツールチップの翻訳 (|cffff00ff初期翻訳段階|r)",                          -- Tooltip translations
   activateTooltipTranslations = "ツールチップの翻訳を有効にする",                                   -- Activate tooltip translations
   activateTooltipTranslationsDESC = "有効にすると、ツールチップの翻訳がオリジナルテキストの代わりに表示されます",    -- If enabled, translated tooltips will displayed
   translateItems = "アイテムの翻訳を表示",                                                     -- Display translated tooltips for items
   translateItemsDESC = "有効にすると、アイテムのツールチップが翻訳されて表示されます",                         -- If enabled, translated tooltips for items will be displayed
   translateSpells = "スペルの翻訳を表示",                                                     -- Display translated tooltips for spells 
   translateSpellsDESC = "有効にすると、スペルのツールチップが翻訳されて表示されます",                         -- If enabled, translated tooltips for spells will be displayed
   translateTalents = "タレントの翻訳を表示",                                                   -- Display translated tooltips for talents 
   translateTalentsDESC = "有効にすると、タレントのツールチップが翻訳されて表示されます",                        -- If enabled, translated tooltips for talents will be displayed
   translateTooltipTitle = "アイテム、スペル、またはタレントのタイトルの翻訳を表示",                           -- Display translated title of item, spell or talent
   translateTooltipTitleDESC = "有効にすると、アイテム、スペル、タレントのツールチップのタイトルが翻訳されて表示されます",   -- If enabled, translated title of tooltips will be displayed
   showTooltipID = "ツールチップIDを表示",                                                      -- Show tooltips ID
   showTooltipIDDESC = "有効にすると、ツールチップのIDが表示されます",                                    -- If enabled, display tooltips ID 
   showTooltipHash = "ツールチップテキストのハッシュを表示",                                            -- Show tooltips Hash
   showTooltipHashDESC = "有効にすると、ツールチップテキストのハッシュが表示されます",                           -- If enabled, display tooltips Hash
   hideSellPrice = "アイテムの売却価格を隠す",                                                    -- Hide sell price of items
   hideSellPriceDESC = "有効にすると、アイテムの売却価格が表示されなくなります",                              -- If enabled, sell price of items will be hidden
   timerHoldTranslation = "翻訳のレンダリングを一時停止",                                           -- Suspend the translation display
   timerLimitSeconds = "翻訳の停止時間を選択",                                                 -- Select a translation hold time
   timerLimitSecondsDESC = "時間は5から30の間の数値です",                                         -- The times is a number between 5 and 30
   displayTranslationConstantly = "翻訳を継続的に表示",                                        -- Display translation constantly
   displayTranslationConstantlyDESC = "有効にすると、ツールチップの内容の更新に対抗するようにアドオンが努めます",     -- Description of option 'displayTranslationConstantly'
   savingUntranslatedTooltips = "未翻訳のツールチップを保存",                                       -- Saving untranslated tooltips
   saveUntranslatedTooltips = "未翻訳のツールチップを保存",                                         -- Save untranslated tooltips
   saveUntranslatedTooltipsDESC = "有効にすると、未翻訳のツールチップが保存されます",                       -- If enabled, untranslated tooltips will be saved

   titleTab9 = "アドオンについて",                                                               -- About
   generalText = "\nWoWinJapaneseは、World of Warcraftのローカライズプロジェクトです。\n日本語で表示されるゲーム要素には、クエスト、NPCとの会話中のゴシップテキスト、NPCによって表示されるセリフの吹き出し、ゲーム内のチュートリアルテキスト、ヒントテキスト、ムービーやシネマティクスの字幕、ゲーム内で見つける本の翻訳が含まれます。",   -- info about project
   welcomeText = "ようこそ、アドオン|cffff00ffWoWinJapanese|rへ。これはアドオンの初回起動であり、導入を確認してください。\n\nこれは、ゲームのテキスト翻訳を日本語で表示する新しいアドオンです。WoWinJapaneseプロジェクトの構成要素が組み合わさっており、以下の部分が含まれています。\n\n|cff00ffffクエスト|r - NPCとの会話中やクエストログ\n|cff00ffffGossip|r - NPCとの会話中に表示されるテキスト\n|cff00ffff吹き出し|r - NPCのキャラクターの上に表示されるセリフ\n|cff00ffff字幕|r - ゲーム内のムービーやシネマティクスの字幕\n|cff00ffffチュートリアル|r - ゲームの使い方を教えるテキスト\n|cff00ffffヒント|r - アイテム、魔法、または特技にマウスを合わせたときに表示されるテキスト\n|cff00ffff本|r - ゲーム内で見つけられる本のテキスト翻訳\n\nこれらの各要素は、アドオン設定パネルで個別に構成できます - 最も簡単に呼び出すには、ミニマップの横にある小さなアドオンアイコンをクリックしてください。\n\n\nプロジェクトを発展させるためには、あなたのサポートをお願い申し上げます。\n\n英語の|cffff00ff翻訳者|r、ゲームデータの|cffff00ff収集者|r、そしてプロジェクトサーバーの維持のための|cffff00ff寄付|rが必要です。詳細は当社のフォーラムでご確認ください: |cffff00ffhttps://wowpopolsku.pl|r。",
   welcomeButton = "OK - 読みました",                                                          -- Button: Close welcome panel
   showWelcome = "ウェルカムパネルを表示",                                                          -- Button: Show welcome panel
   authorHeader = "著者情報",                                                                 -- Author info
   author = "著者:",                                                                         -- Author: 
   email = "E-mail:",                                                                       -- E-mail: 
   teamHeader = "WoWinJapanese プロジェクトチームへの連絡",                                            -- WoWJP project team
   textContact = "アドオンに関する質問がある場合は、以下のいずれかの方法でご連絡ください:",
   linkWWWShow = "クリックして |cffffff00WWW|r へのリンクを表示",
   linkWWWTitle = "WWWのリンク",
   linkDISCShow = "クリックして |cffffff00Discord|r へのリンクを表示",
   linkDISCTitle = "Discordのリンク",
   linkEMAILShow = "クリックして |cffffff00e-mail|r プロジェクトのメールアドレスを表示",
   linkEMAILTitle = "プロジェクトのメールアドレス",
   linkCURSEShow = "クリックして |cffffff00CurseForge|r へのリンクを表示",
   linkCURSETitle = "CurseForgeサイトのリンク",
   linkPPShow = "クリックして |cffffff00PayPal|r へのリンクを表示",
   linkPPTitle = "PayPalのリンク",
   linkBLIKShow = "クリックして |cffffff00BLIK|r 電話番号を表示",
   linkBLIKTitle = "BLIK電話番号",
   linkTWITCHShow = "クリックして |cffffff00Twitch|r へのリンクを表示",
   linkTWITCHTitle = "Twitchのリンク",
   linkFBShow = "クリックして |cffffff00FanPage|r へのリンクを表示",
   linkFBTitle = "FanPageのリンク",
   linkCloseFrame = "フレームを閉じる",
   linkCopy = "リンクをコピーするには |cff00ffffCtrl+C|r を押してください",                                   -- Press Ctrl+C to copy the address to the clipboard
   betaTestersHeader = "WoWinJapanese チーム:",                                                   -- TRANSLATION TEAM
   betaTestersHeaderDESC = "モデレーター: |cffff00ffDumpty|r, |cffff00ffXeon|r,\n\n|cffffff00末尾に[AI]タグを含む翻訳は、人工知能によって翻訳されたもので、モデレーターによるチェックはまだ受けていません。|r",    -- Translators and Beta testers:
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

WOWTR_Font1 = WoWTR_Localization.mainFolder.."\\Fonts\\ipagui.ttf";
WOWTR_Font2 = WoWTR_Localization.mainFolder.."\\Fonts\\ipagui.ttf";
WOWTR_Fonts = {"ipagui.ttf"};
local GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata;
WOWTR_version = GetAddOnMetadata(WoWTR_Localization.addonFolder, "Version");
