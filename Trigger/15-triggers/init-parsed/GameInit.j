library GameInit initializer init requires GroupUtils

    globals
        boolean AllowBetSelection = false
        boolean AllPlayerHeroesSpawned = false
        boolean ARLearningAbil = false
        boolean ArNotLearningAbil = false
        boolean array PlayerPlacedGoldBet
        boolean array RoundLiveLost
        boolean BettingEnabled = false
        boolean BrStarted = false
        boolean ElimModeEnabled = false
        boolean ElimPvpStarted = false
        boolean GameComplete = false
        boolean GameModeShort = false
        boolean ModeNoDeath = false
        boolean RandomHeroMode = false
        boolean SuddenDeathEnabled = false
        boolean udg_boolean09 = false
        boolean udg_boolean12 = false
        boolean udg_boolean14 = false
        boolean udg_boolean15 = false
        boolean udg_boolean17 = false
        button array DeathDialogButtons
        button array VotingRightButtons
        dialog DeathDialog = null
        dialog VotingRightsDialog = null
        force DefeatedPlayers = null
        force RoundPlayersCompleted = null
        force Team1BettingForce = null
        force Team2BettingForce = null
        force LeaverPlayers = null
        force PlayersWithHero = null
        group DuelingHeroes = null
        group DuelWinnerDisabled = null
        group DuelWinners = null
        group GroupEmptyArenaCheck = null
        group OnPeriodGroup
        integer array CreepUnitTypeIds
        integer array HeroAbilityCount
        integer array LumberGained
        integer array PlayerLastLearnedSpell
        integer array PlayerResourceBetPercentage
        integer array ResourceBetPercentageGoldReward
        integer array ShopIds
        integer BettingPlayerCount = 0
        integer BoughtAbility = 0
        integer HideShopsCount = 0
        integer HideShopsIndex = 0
        integer InitialPlayerCount = 0
        integer MaxCreepUnitTypes = 0
        integer PlayerCount = 0
        integer PvpGoldWinAmount = 0
        integer ResourceBetPercentageCalculation = 0
        integer RoundCreepAbilCastChance = 0
        integer RoundCreepChanceBash = 0
        integer RoundCreepChanceBigBadV = 0
        integer RoundCreepChanceBlink = 0
        integer RoundCreepChanceCleave = 0
        integer RoundCreepChanceCritStrike = 0
        integer RoundCreepChanceEvasion = 0
        integer RoundCreepChanceFaerieFire = 0
        integer RoundCreepChanceHurlBoulder = 0
        integer RoundCreepChanceLifesteal = 0
        integer RoundCreepChanceManaBurn = 0
        integer RoundCreepChanceRejuv = 0
        integer RoundCreepChanceShockwave = 0
        integer RoundCreepChanceSlow = 0
        integer RoundCreepChanceThorns = 0
        integer RoundCreepChanceThunderClap = 0
        integer RoundCreepMaxAttackSpeed = 0
        integer RoundCreepMoveSpeed = 0
        integer RoundCreepNumber = 0
        integer RoundCreepTypeId = 0
        integer RoundFinishedCount = 0
        integer RoundGenCreepIndex = 0
        integer RoundNumber = 0
        integer SpawnedHeroCount = 0
        integer SuddenDeathTick = 0
        integer udg_integer41 = 0
        integer udg_integer59 = 0
        integer udg_integer61 = 0
        integer udg_integer63 = 0
        integer UnknownInteger01 = 0
        integer TryLearnRandomAbilityAttempts = 0
        location array HideShopsLocations
        location array PlayerArenaRectCenters
        location RectMidArenaCenter
        player HostPlayer = null
        player SingleplayerPlayer = null
        real RoundCreepPower = 0
        rect RectMidArena
        rect RectMidBRRespawnArena
        rect array PlayerArenaRects
        sound array udg_sounds01
        sound udg_sound01 = null
        sound udg_sound02 = null
        sound udg_sound03 = null
        sound udg_sound04 = null
        sound udg_sound05 = null
        sound udg_sound06 = null
        sound udg_sound07 = null
        sound udg_sound08 = null
        sound udg_sound09 = null
        sound udg_sound10 = null
        sound udg_sound11 = null
        sound udg_sound12 = null
        sound udg_sound13 = null
        sound udg_sound15 = null
        sound udg_sound17 = null
        sound udg_sound18 = null
        sound udg_sound19 = null
        sound udg_sound20 = null
        sound udg_sound21 = null
        sound udg_sound22 = null
        sound udg_sound23 = null
        sound udg_sound24 = null
        sound udg_sound25 = null
        string array RoundCreepInfo
        string RoundAbilities = ""
        string RoundCreepTitle
        Table roundAbilities
        trigger AllPlayersCompletedRoundTrigger = null
        trigger AllPlayersDeadTrigger = null
        trigger BonusExpTrigger = null
        trigger CancelBettingTrigger = null
        trigger CenterArenaInvulnerabilityTrigger = null
        trigger CenterArenaRemoveUnitTrigger = null
        trigger ComputerPvpEnforceDuelTrigger = null
        trigger CreepAutoCastTrigger = null
        trigger CreepDiesTrigger = null
        trigger CreepPeriodicAttackTrigger = null
        trigger CreepPowerAndHpTrigger = null
        trigger CreepTypesTrigger = null
        trigger DeathDialogLeaveTrigger = null
        trigger DialogInitializationTrigger = null
        trigger DisableAbilitiesTrigger = null
        trigger DistributeBetsTrigger = null
        trigger DivineSourceTrigger = null
        trigger DuelWinnerRewardsTrigger = null
        trigger EndGameTrigger = null
        trigger EnterShopModeTrigger = null
        trigger EveryoneVotesTrigger = null
        trigger FaerieDragonDiesTrigger = null
        trigger GameModeQuestSetupTrigger = null
        trigger GenerateNextCreepLevelTrigger = null
        trigger HeroDiesInRoundTrigger = null
        trigger HeroRefreshTrigger = null
        trigger HideShopsTrigger = null
        trigger HostSelectsModeTrigger = null
        trigger InitializeBattleRoyaleTrigger = null
        trigger InitializePvpTrigger = null
        trigger IsGameFinishedTrigger = null
        trigger LearnAbilityTrigger = null
        trigger LearnRandomAbilityTrigger = null
        trigger ModifyCreepAbilitiesTrigger = null
        trigger PandarenDeathSoundsTrigger = null
        trigger PandarenDiesTrigger = null
        trigger PlaceGoldBetTrigger = null
        trigger PlacePercentageBetTrigger = null
        trigger PlayerAntiStuckTrigger = null
        trigger PlayerCompleteRoundMoveTrigger = null
        trigger PlayerCompleteRoundTrigger = null
        trigger PlayerDiesInBattleRoyaleTrigger = null
        trigger PlayerHeroDeathTrigger = null
        trigger PlayerInitializationTrigger = null
        trigger PlayerLeavesGameTrigger = null
        trigger SetHostPlayerTrigger = null
        trigger SinglePvpHeroDeathTrigger = null
        trigger DuelDrawTrigger = null
        trigger SpacebarCameraTrigger = null
        trigger StartLevelTrigger = null
        trigger SuddenDeathCreepTimerTrigger = null
        trigger Team1BettingTrigger = null
        trigger Team2BettingTrigger = null
        trigger TryLearnRandomAbilityTrigger = null
        trigger UnhideShopsTrigger = null
        trigger UnlearnAbilityTrigger = null
        trigger UpdateItemsTrigger = null
        trigger VotingRightsDialogTrigger = null
        trigger WispActionsTrigger = null
        unit array PlayerHeroes
        unit TempUnit = null
    endglobals

    private function InitializeGlobals takes nothing returns nothing
        set OnPeriodGroup = NewGroup()
        set roundAbilities = Table.create()
        set PlayersWithHero = CreateForce()
        set DefeatedPlayers = CreateForce()
        set DuelingHeroes = CreateGroup()
        set DuelWinners = CreateGroup()
        set DuelWinnerDisabled = CreateGroup()
        set RoundPlayersCompleted = CreateForce()
        set Team1BettingForce = CreateForce()
        set Team2BettingForce = CreateForce()
        set DeathDialog = DialogCreate()
        set LeaverPlayers = CreateForce()
        set GroupEmptyArenaCheck = CreateGroup()
        set VotingRightsDialog = DialogCreate()

        // Needs to be specified right away since a lot of triggers depend on it
        set RectMidArena = Rect(-1696.0, -1952.0, 1696.0, 1440.0)
        set RectMidBRRespawnArena = Rect(-1200.0, -1500.0, 1200.0, 1000.0)

        set RectMidArenaCenter = GetRectCenter(RectMidArena)
    endfunction

    private function InitializeEnvironment takes nothing returns nothing
        call SetCameraBounds(-5376.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -5632.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 5376.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 5120.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -5376.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 5120.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 5376.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -5632.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
        call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
        call NewSoundEnvironment("Default")
        call SetAmbientDaySound("SunkenRuinsDay")
        call SetAmbientNightSound("SunkenRuinsNight")
        call SetMapMusic("Music", true, 0)

        call AddWeatherEffectSaveLast(GetPlayableMapRect(), 'SNhs')
    endfunction

    private function InitializeSounds takes nothing returns nothing
        set udg_sound01 = CreateSound("Sound\\Interface\\QuestNew.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound01, "QuestNew")
        call SetSoundDuration(udg_sound01, 3750)
        set udg_sound02 = CreateSound("Sound\\Interface\\QuestCompleted.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound02, "QuestCompleted")
        call SetSoundDuration(udg_sound02, 5154)
        set udg_sound03 = CreateSound("Sound\\Interface\\QuestActivateWhat1.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound03, "QuestLogModified")
        call SetSoundDuration(udg_sound03, 539)
        set udg_sound04 = CreateSound("Sound\\Interface\\UpkeepRing.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound04, "UpkeepLevel")
        call SetSoundDuration(udg_sound04, 1578)
        set udg_sound05 = CreateSound("Sound\\Music\\mp3Music\\HeroicVictory.mp3", false, false, false, 10, 10, "")
        call SetSoundDuration(udg_sound05, 53472)
        call SetSoundChannel(udg_sound05, 0)
        call SetSoundVolume(udg_sound05, 127)
        call SetSoundPitch(udg_sound05, 1.0)
        set udg_sound06 = CreateSound("Sound\\Music\\mp3Music\\TragicConfrontation.mp3", false, false, false, 10, 10, "")
        call SetSoundDuration(udg_sound06, 72254)
        call SetSoundChannel(udg_sound06, 0)
        call SetSoundVolume(udg_sound06, 127)
        call SetSoundPitch(udg_sound06, 1.0)
        set udg_sound07 = CreateSound("Sound\\Interface\\ItemReceived.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound07, "ItemReward")
        call SetSoundDuration(udg_sound07, 1483)
        set udg_sound08 = CreateSound("Sound\\Interface\\ClanInvitation.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound08, "ClanInvitation")
        call SetSoundDuration(udg_sound08, 4295)
        set udg_sound09 = CreateSound("Sound\\Interface\\BattleNetTick.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound09, "ChatroomTimerTick")
        call SetSoundDuration(udg_sound09, 476)
        set udg_sound10 = CreateSound("Sound\\Interface\\NewTournament.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound10, "NewTournament")
        call SetSoundDuration(udg_sound10, 7987)
        set udg_sound11 = CreateSound("Sound\\Interface\\Rescue.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound11, "Rescue")
        call SetSoundDuration(udg_sound11, 3796)
        set udg_sound12 = CreateSound("Sound\\Dialogue\\GenericWarnings\\GenericWarningHeroFallen1.mp3", false, false, false, 10, 10, "DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound12, "HeroDiesGeneric")
        call SetSoundDuration(udg_sound12, 1593)
        call SetSoundVolume(udg_sound12, 127)
        call SetSoundPitch(udg_sound12, 0.9)
        set udg_sound13 = CreateSound("Units\\Undead\\Varimathras\\VarimathrasPissed8.wav", false, false, true, 10, 10, "HeroAcksEAX")
        call SetSoundParamsFromLabel(udg_sound13, "VarimathrasPissed")
        call SetSoundDuration(udg_sound13, 8906)
        set udg_sound15 = CreateSound("Sound\\Interface\\ArrangedTeamInvitation.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound15, "ArrangedTeamInvitation")
        call SetSoundDuration(udg_sound15, 2914)
        set udg_sound17 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound17, "PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound17, 2699)
        set udg_sound18 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound18, "PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound18, 2699)
        set udg_sound19 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound19, "PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound19, 2699)
        set udg_sound20 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound20, "PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound20, 2699)
        set udg_sound21 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound21, "PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound21, 2699)
        set udg_sound22 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound22, "PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound22, 2699)
        set udg_sound23 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound23, "PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound23, 2699)
        set udg_sound24 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound24, "PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound24, 2699)
        set udg_sound25 = CreateSound("Sound\\Interface\\QuestLog.wav", false, false, false, 10, 10, "")
        call SetSoundParamsFromLabel(udg_sound25, "QuestUpdate")
        call SetSoundDuration(udg_sound25, 2275)
    endfunction

    private function StartGame takes nothing returns nothing
        call FogMaskEnableOff()
        call FogEnableOff()

        call ConditionalTriggerExecute(PlayerInitializationTrigger)
        call ConditionalTriggerExecute(GenerateNextCreepLevelTrigger)
        call ConditionalTriggerExecute(VotingRightsDialogTrigger)
    endfunction  

    public function init takes nothing returns nothing
        call InitializeEnvironment()
        call InitializeGlobals()
        call InitializeSounds()

        call DisplayTimedTextToForce(GetPlayersAll(), 3.00, "|cff52ff5bPlease wait while the game initializes..|r")

        call TimerStart(CreateTimer(), 3, false, function StartGame)
    endfunction

endlibrary
