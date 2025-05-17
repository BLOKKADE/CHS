library HeroSelectorAction initializer Init uses HeroSelector, HeroInfo, PlayerHeroSelected, AbilityData
    //HeroSelectorAction V1.4.0
    
    globals
        private unit PreviewUnit
    endglobals

    function RemoveHeroPreviewUnit takes nothing returns nothing
        call RemoveUnit(PreviewUnit)
        set PreviewUnit = null
    endfunction

    //what happens to the unit beeing picked, player is the one having pressed the button
    function HeroSelectorUnitCreated takes nothing returns nothing
        local player p = HeroSelectorEventPlayer
        local PlayerStats ps = PlayerStats.forPlayer(p)
        local integer playerIndex = GetPlayerId(p)
        local unit u = HeroSelectorEventUnit
        local boolean isRandom = HeroSelectorEventIsRandom
        set bj_lastCreatedUnit = u

        // Don't spawn a hero for a leaver player
        if (IsPlayerInForce(p, LeaverPlayers)) then
            set p = null
            set u = null
            return
        endif

        call ps.setHeroUnitTypeId(GetUnitTypeId(u), isRandom)

        if isRandom then
            call AdjustPlayerStateBJ(900, p, PLAYER_STATE_RESOURCE_GOLD)

            if HeroMode > 2 then
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffffcc00has randomed " + GetUnitName(u)+ "! (+300 bonus gold and 1 gold ring)")
                call UnitAddItemByIdSwapped('I04R', u)
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffffcc00has randomed " + GetUnitName(u)+ "! (+300 bonus gold and 2 gold rings)")
                call UnitAddItemByIdSwapped('I04R', u)
                call UnitAddItemByIdSwapped('I04R', u)
            endif
        else
            call AdjustPlayerStateBJ(600, p, PLAYER_STATE_RESOURCE_GOLD)
            call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffffcc00has selected " + GetUnitName(u)+ "!")
        endif

        if (GetLocalPlayer() == p) then
            call ShowUnit(PreviewUnit, false)
        endif

        call ForceAddPlayer(PlayersWithHero, p)

        call PanCameraToTimedForPlayer(p, GetUnitX(u), GetUnitY(u),0)
        call SelectUnitForPlayerSingle(u, p)
        call HeroSelectorEnablePickPlayer(false, p) //only one pick for this player
        call HeroSelectorShowPlayer(false, p)

        call PlayerHeroSelected_SpawnedHeroActions(p, u)

        set p = null
        set u = null
    endfunction

    //happens when the banButton is pressed, player is the one having pressed the button
    function HeroSelectorUnitBaned takes nothing returns nothing
        local player p = HeroSelectorEventPlayer
        local integer playerIndex = GetPlayerId(p)
        local integer unitCode = HeroSelectorEventUnitCode
        call HeroSelectorEnableBanPlayer(false, p) //only one ban

        set p = null
        
    endfunction

    function HeroSelectorButtonSelected takes nothing returns nothing
        //player who pressed the button
        //unitCode the unitCode selected
        //this is not picked.
        local player p = HeroSelectorEventPlayer
        local integer playerIndex = GetPlayerId(p)
        local integer unitCode = HeroSelectorEventUnitCode
        local playercolor playersColor = GetPlayerColor(p)

        call HeroInfoButtonSelected(p, unitCode)

        if (GetLocalPlayer() == p) then
            call BlzSetUnitSkin(PreviewUnit, unitCode)
            call SetUnitColor(PreviewUnit, playersColor)
        endif

        set p = null
        set playersColor = null
    endfunction

    function HeroSelectorRepick takes unit u returns nothing
        local integer unitCode
        local player p = GetOwningPlayer(u)
        local integer playerIndex = GetPlayerId(p)
        call UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, u) //this is done to undo metamorph
        set unitCode = GetUnitTypeId(u)
        if unitCode == 0 then
            return
        endif

        call HeroSelectorCounterChangeUnitCode(unitCode, -1, p)

        call HeroSelectorShowPlayer(true, p)
        call HeroSelectorEnablePickPlayer(true, p)
        call RemoveUnit(u)
    endfunction



//This runs before the box is created with that the system has the needed data right when it is needed.
    //you can add units somewhere else but it is done after the box was created you have to use the update function to update the textures of shown buttons
    public function InitHeroes takes nothing returns nothing
        //create categories setuped in config
        local integer index
        local integer elementIndex
        local integer categoryMelee = 1 //autodetected
        local integer categoryRanged = 2 //autodetected
        local integer categoryStr = 4
        local integer categoryAgi = 8
        local integer categoryInt = 16

        local integer array elementFilters
        local integer array elementCategoryLookup

        set elementFilters[0] = Element_Fire
        set elementFilters[1] = Element_Water
        set elementFilters[2] = Element_Dark
        set elementFilters[3] = Element_Cold
        set elementFilters[4] = Element_Arcane
        set elementFilters[5] = Element_Wind
        set elementFilters[6] = Element_Earth
        set elementFilters[7] = Element_Wild
        set elementFilters[8] = Element_Blood
        set elementFilters[9] = Element_Light
        set elementFilters[10] = Element_Poison

        set elementCategoryLookup[0] = 32
        set elementCategoryLookup[1] = 64
        set elementCategoryLookup[2] = 128
        set elementCategoryLookup[3] = 256
        set elementCategoryLookup[4] = 512
        set elementCategoryLookup[5] = 1024
        set elementCategoryLookup[6] = 2048
        set elementCategoryLookup[7] = 4096
        set elementCategoryLookup[8] = 8192
        set elementCategoryLookup[9] = 16384
        set elementCategoryLookup[10] = 32768

        call HeroSelectorAddCategory("ReplaceableTextures\\CommandButtons\\BTNSteelMelee", "MELEE", true)                 //1, automatic detected when adding an unit
        call HeroSelectorAddCategory("ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpOne", "Ranged", true)         //2, automatic detected when adding an unit
        call HeroSelectorAddCategory("ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower", "STRENGTH", true)    //4
        call HeroSelectorAddCategory("ReplaceableTextures\\CommandButtons\\BTNSlippersOfAgility", "AGILITY", true)        //8
        call HeroSelectorAddCategory("ReplaceableTextures\\CommandButtons\\BTNMantleOfIntelligence", "INTELLECT", true)   //16

        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASbook1fire .blp", "Fire", false)   //32
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASbook1water .blp", "Water", false)   //64
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASDarkMagic.blp", "Dark", false)   //128
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASIceyBook.blp", "Cold", false)   //256
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASArcaneBooklet.blp", "Arcane", false)   //512
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASbook1wind .blp", "Wind", false)   //1024
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASEarthMagic.blp", "Earth", false)   //2048
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASbook1earth .blp", "Wild", false)   //4096
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASBloodBoundTome.blp", "Blood", false)   //8192
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASHolyMagic.blp", "Light", false)   //16384
        call HeroSelectorAddCategory("ReplaceableTextures\\PassiveButtons\\PASTomePowerPoison.BLP", "Poison", false)   //32768

        //read GUI, when the variable exist
        set HeroSelectorUnitCode[1] = ABOMINATION_UNIT_ID
        set HeroSelectorUnitCode[2] = ARENA_MASTER_UNIT_ID
        set HeroSelectorUnitCode[3] = AVATAR_SPIRIT_UNIT_ID
        set HeroSelectorUnitCode[4] = BANSHEE_UNIT_ID
        set HeroSelectorUnitCode[5] = BEAST_MASTER_UNIT_ID
        set HeroSelectorUnitCode[6] = BLADE_MASTER_UNIT_ID
        set HeroSelectorUnitCode[7] = BLOOD_MAGE_UNIT_ID
        set HeroSelectorUnitCode[8] = CENTAUR_ARCHER_UNIT_ID
        set HeroSelectorUnitCode[9] = COLD_KNIGHT_UNIT_ID
        set HeroSelectorUnitCode[10] = DARK_HUNTER_UNIT_ID
        set HeroSelectorUnitCode[11] = DEMON_HUNTER_UNIT_ID
        set HeroSelectorUnitCode[12] = DOOM_GUARD_UNIT_ID
        set HeroSelectorUnitCode[13] = DEADLORD_UNIT_ID
        set HeroSelectorUnitCode[14] = DRUID_OF_THE_CLAY_UNIT_ID
        set HeroSelectorUnitCode[15] = FALLEN_RANGER_UNIT_ID
        set HeroSelectorUnitCode[16] = GHOUL_UNIT_ID
        set HeroSelectorUnitCode[17] = GNOME_MASTER_UNIT_ID
        set HeroSelectorUnitCode[18] = GREEDY_GOBLIN_UNIT_ID
        set HeroSelectorUnitCode[19] = CRYPT_LORD_UNIT_ID
        set HeroSelectorUnitCode[20] = HUNTRESS_UNIT_ID
        set HeroSelectorUnitCode[21] = LICH_UNIT_ID
        set HeroSelectorUnitCode[22] = LIEUTENANT_UNIT_ID
        set HeroSelectorUnitCode[23] = MAULER_UNIT_ID
        set HeroSelectorUnitCode[24] = MEDIVH_UNIT_ID
        set HeroSelectorUnitCode[25] = MORTAR_TEAM_UNIT_ID
        set HeroSelectorUnitCode[26] = MYSTIC_UNIT_ID
        set HeroSelectorUnitCode[27] = NAGA_SIREN_UNIT_ID
        set HeroSelectorUnitCode[28] = OGRE_MAGE_UNIT_ID
        set HeroSelectorUnitCode[29] = OGRE_WARRIOR_UNIT_ID
        set HeroSelectorUnitCode[30] = ORC_CHAMPION_UNIT_ID
        set HeroSelectorUnitCode[31] = PIT_LORD_UNIT_ID
        set HeroSelectorUnitCode[32] = PYROMANCER_UNIT_ID
        set HeroSelectorUnitCode[33] = RANGER_UNIT_ID
        set HeroSelectorUnitCode[34] = ROCK_GOLEM_UNIT_ID
        set HeroSelectorUnitCode[35] = SATYR_TRICKSTER_UNIT_ID
        set HeroSelectorUnitCode[36] = SEER_UNIT_ID
        set HeroSelectorUnitCode[37] = SKELETON_BRUTE_UNIT_ID
        set HeroSelectorUnitCode[38] = SORCERER_UNIT_ID
        set HeroSelectorUnitCode[39] = TAUREN_UNIT_ID
        set HeroSelectorUnitCode[40] = THUNDER_WITCH_UNIT_ID
        set HeroSelectorUnitCode[41] = TIME_WARRIOR_UNIT_ID
        set HeroSelectorUnitCode[42] = TINKER_UNIT_ID
        set HeroSelectorUnitCode[43] = TROLL_BERSERKER_UNIT_ID
        set HeroSelectorUnitCode[44] = TROLL_HEADHUNTER_UNIT_ID
        set HeroSelectorUnitCode[45] = URSA_WARRIOR_UNIT_ID
        set HeroSelectorUnitCode[46] = WAR_GOLEM_UNIT_ID
        set HeroSelectorUnitCode[47] = WITCH_DOCTOR_UNIT_ID
        set HeroSelectorUnitCode[48] = WOLF_RIDER_UNIT_ID
        set HeroSelectorUnitCode[49] = MURLOC_WARRIOR_UNIT_ID
        set HeroSelectorUnitCode[50] = YETI_UNIT_ID
        //set HeroSelectorUnitCode[51] = GNOLL_WARDEN_UNIT_ID
        set HeroSelectorUnitCode[51] = STOMP_UNIT_ID

        set index = 1
        //add from index 1 all random only heroes
        loop
            exitwhen HeroSelectorRandomOnly[index] == 0
            call HeroSelectorAddUnit(HeroSelectorRandomOnly[index], true)
            set index = index + 1
        endloop

        set index = 1
        //copy the setuped field
        loop
            exitwhen index > HeroSelector_HeroButtonCount
            call HeroSelectorAddUnit(HeroSelectorUnitCode[index], false)
            if HeroSelectorCategory[index] != 0 then
                call HeroSelectorAddUnitCategory(HeroSelectorUnitCode[index], HeroSelectorCategory[index])
            endif
            set index = index + 1
        endloop

        // Add element category filters
        set index = 1
        loop
            exitwhen index > HeroSelector_HeroButtonCount

            set elementIndex = 0
            loop
                exitwhen elementIndex > 10

                if (GetObjectElementCount(HeroSelectorUnitCode[index], elementFilters[elementIndex]) > 0) then
                    call HeroSelectorAddUnitCategory(HeroSelectorUnitCode[index], elementCategoryLookup[elementIndex])
                endif

                set elementIndex = elementIndex + 1
            endloop

            set index = index + 1
        endloop

        // We have to manually specify the primary stat of each hero to improve loading times
        call HeroSelectorAddUnitCategory(LIEUTENANT_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(DARK_HUNTER_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(BLOOD_MAGE_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(MAULER_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(NAGA_SIREN_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(MORTAR_TEAM_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(ABOMINATION_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(DRUID_OF_THE_CLAY_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(RANGER_UNIT_ID, categoryAgi)
        call HeroSelectorAddUnitCategory(SORCERER_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(ARENA_MASTER_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(DOOM_GUARD_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(ROCK_GOLEM_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(LICH_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(GNOME_MASTER_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(CENTAUR_ARCHER_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(OGRE_WARRIOR_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(TIME_WARRIOR_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(OGRE_MAGE_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(MURLOC_WARRIOR_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(MEDIVH_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(GHOUL_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(BANSHEE_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(CRYPT_LORD_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(STOMP_UNIT_ID, categoryStr)
        //call HeroSelectorAddUnitCategory(GNOLL_WARDEN_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(SEER_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(FALLEN_RANGER_UNIT_ID, categoryAgi)
        call HeroSelectorAddUnitCategory(WAR_GOLEM_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(TROLL_HEADHUNTER_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(BLADE_MASTER_UNIT_ID, categoryAgi)
        call HeroSelectorAddUnitCategory(TINKER_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(SKELETON_BRUTE_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(BEAST_MASTER_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(URSA_WARRIOR_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(HUNTRESS_UNIT_ID, categoryAgi)
        call HeroSelectorAddUnitCategory(ORC_CHAMPION_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(COLD_KNIGHT_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(GREEDY_GOBLIN_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(TAUREN_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(THUNDER_WITCH_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(DEADLORD_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(AVATAR_SPIRIT_UNIT_ID, categoryAgi)
        call HeroSelectorAddUnitCategory(DEMON_HUNTER_UNIT_ID, categoryAgi)
        call HeroSelectorAddUnitCategory(PYROMANCER_UNIT_ID, categoryAgi)
        call HeroSelectorAddUnitCategory(WITCH_DOCTOR_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(PIT_LORD_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(MYSTIC_UNIT_ID, categoryInt)
        call HeroSelectorAddUnitCategory(TROLL_BERSERKER_UNIT_ID, categoryAgi)
        call HeroSelectorAddUnitCategory(YETI_UNIT_ID, categoryStr)
        call HeroSelectorAddUnitCategory(SATYR_TRICKSTER_UNIT_ID, categoryAgi)
        call HeroSelectorAddUnitCategory(WOLF_RIDER_UNIT_ID, categoryAgi)

        // This must be the last operation here. This will randomize the str/agi/int heroes that will be used to assign to players
        call RandomizeHeroArrays()

        return
        //adding further units when using the GUI Array does not make much sense, except you would add rows.

        call HeroSelectorAddUnit('Hgam', true) //antonidas is an only random Hero that can only be randomed by team 0 (for users 1).
        call HeroSelectorAddUnit('Eevi', true) //evil Illidan is an only random Hero that can only be randomed by team 1 (for users 2).
        
        //Adds requirments
        //when you have a ban phase it might be better to add the requirments after the ban phase is over, otherwise one can only ban own options.
        //human only work for human, as nightelf only for Nightelf
        call HeroSelectorSetUnitReqRace('Hpal', RACE_HUMAN)
        call HeroSelectorSetUnitReqTechLevel('Hpal', 'hfoo', categoryStr)
        call HeroSelectorSetUnitReqRace('Hamg', RACE_HUMAN)
        call HeroSelectorSetUnitReqRace('Hblm', RACE_HUMAN)
        call HeroSelectorSetUnitReqRace('Hmkg', RACE_HUMAN)
        //call HeroSelectorSetUnitReqRace('Ofar', RACE_ORC)
        //call HeroSelectorSetUnitReqRace('Oshd', RACE_ORC)
        //call HeroSelectorSetUnitReqRace('Otch', RACE_ORC)
        //call HeroSelectorSetUnitReqRace('Obla', RACE_ORC)
        call HeroSelectorSetUnitReqRace('Emoo', RACE_NIGHTELF)
        call HeroSelectorSetUnitReqRace('Edem', RACE_NIGHTELF)
        call HeroSelectorSetUnitReqRace('Ekee', RACE_NIGHTELF)
        call HeroSelectorSetUnitReqRace('Ewar', RACE_NIGHTELF)
        //call HeroSelectorSetUnitReqRace('Udea', RACE_UNDEAD)
        //call HeroSelectorSetUnitReqRace('Ulic', RACE_UNDEAD)
        //call HeroSelectorSetUnitReqRace('Udre', RACE_UNDEAD)
        //call HeroSelectorSetUnitReqRace('Ucrl', RACE_UNDEAD)
        
        call HeroSelectorAddUnitCategory('Hpal', categoryStr)
        call HeroSelectorAddUnitCategory('Hamg', categoryInt)
        call HeroSelectorAddUnitCategory('Hblm', categoryInt)
        call HeroSelectorAddUnitCategory('Hmkg', categoryStr)
        call HeroSelectorAddUnitCategory('Ofar', categoryInt)
        call HeroSelectorAddUnitCategory('Oshd', categoryAgi)
        call HeroSelectorAddUnitCategory('Otch', categoryStr)
        call HeroSelectorAddUnitCategory('Obla', categoryAgi)
        call HeroSelectorAddUnitCategory('Emoo', categoryAgi)
        call HeroSelectorAddUnitCategory('Edem', categoryAgi)
        call HeroSelectorAddUnitCategory('Ekee', categoryInt)
        call HeroSelectorAddUnitCategory('Ewar', categoryAgi)
        call HeroSelectorAddUnitCategory('Udea', categoryStr)
        call HeroSelectorAddUnitCategory('Ulic', categoryInt)
        call HeroSelectorAddUnitCategory('Udre', categoryStr)
        call HeroSelectorAddUnitCategory('Ucrl', categoryStr)

        call HeroSelectorSetUnitCategory('Hgam', categoryInt + categoryRanged)
        call HeroSelectorSetUnitCategory('Eevi', categoryAgi + categoryMelee)

        
        //call HeroSelectorAddUnit('Hpal', false) //add paladin as selectable Hero
        //call HeroSelectorAddUnit('Hamg', false)
        //call HeroSelectorAddUnit('Hblm', false)
        //call HeroSelectorAddUnit('Hmkg', false)
        //call HeroSelectorAddUnit('Obla', true) //this unit can only be randomed
        //call HeroSelectorAddUnit('Ofar', false)
        //call HeroSelectorAddUnit('Otch', true) //this unit can only be randomed
        //call HeroSelectorAddUnit(0,false) //this is an empty box. It still takes a slot.
        //call HeroSelectorAddUnit(0,false) //this is an empty box. It still takes a slot.
        //call HeroSelectorAddUnit('Oshd', false)
        //call HeroSelectorAddUnit('Edem', false)
        //call HeroSelectorAddUnit(0,false) //this is an empty box. It still takes a slot.
        //call HeroSelectorAddUnit(0,false) //this is an empty box. It still takes a slot.
        //call HeroSelectorAddUnit('Ekee', false)
        //call HeroSelectorAddUnit('Emoo', false)
        //call HeroSelectorAddUnit('Ewar', true)
        //call HeroSelectorAddUnit('Udea', false)
        //call HeroSelectorAddUnit('Ulic', false)
        //call HeroSelectorAddUnit('Udre', false)
        //call HeroSelectorAddUnit('Ucrl', true)
    endfunction

    private function Init takes nothing returns nothing
        local trigger trig
        set trig = CreateTrigger()
        call TriggerRegisterVariableEvent(trig, "HeroSelectorEvent", EQUAL, 2.0 )
        call TriggerAddAction(trig, function HeroSelectorButtonSelected)

        set trig = CreateTrigger()
        call TriggerRegisterVariableEvent(trig, "HeroSelectorEvent", EQUAL, 1.0 )
        call TriggerAddAction(trig, function HeroSelectorUnitCreated)

        set trig = CreateTrigger()
        call TriggerRegisterVariableEvent(trig, "HeroSelectorEvent", EQUAL, 3.0 )
        call TriggerAddAction(trig, function HeroSelectorUnitBaned)

        set PreviewUnit = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), HERO_PREVIEW_UNIT_ID, 470, -320, bj_UNIT_FACING)
    endfunction
endlibrary