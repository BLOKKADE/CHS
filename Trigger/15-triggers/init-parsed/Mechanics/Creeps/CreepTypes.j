library CreepTypes initializer init requires RandomShit

    function IsCreepUnitType takes integer unitId returns boolean
        local integer i = 1
        loop
            exitwhen i > MaxCreepUnitTypes
            if unitId == CreepUnitTypeIds[i] then
                return true
            endif
            set i = i + 1
        endloop
        return false
    endfunction

    private function CreepTypesActions takes nothing returns nothing

        //spellcaster creeps:
        set CreepUnitTypeIds[1]  = SUCCUBUS_CREEP_UNIT_ID     
        set CreepUnitTypeIds[2]  = GNOLL_WARDEN_CREEP_UNIT_ID          //ranged
        set CreepUnitTypeIds[3]  = ORC_WARLOCK_CREEP_UNIT_ID          
        set CreepUnitTypeIds[4]  = OGRE_MAGI_CREEP_UNIT_ID             
        set CreepUnitTypeIds[5]  = BANDIT_MAGE_CREEP_UNIT_ID           //ranged
        set CreepUnitTypeIds[6]  = DEMONESS_CREEP_UNIT_ID              //ranged
        set CreepUnitTypeIds[7]  = VOID_WALKER_CREEP_UNIT_ID           //ranged
        set CreepUnitTypeIds[8]  = SHAMAN_CREEP_UNIT_ID                //ranged
        set CreepUnitTypeIds[9]  = CHAOS_WARLOCK_2_CREEP_UNIT_ID       //ranged
        set CreepUnitTypeIds[10] = SASQUATCH_SHAMAN_CREEP_UNIT_ID 
        set CreepUnitTypeIds[11] = WATCHER_CREEP_UNIT_ID        
        set CreepUnitTypeIds[12] = HARPY_WITCH_CREEP_UNIT_ID           //ranged

        //melee auto attacker creeps:
        set CreepUnitTypeIds[13] = MURLOC_TIDERUNNER_CREEP_UNIT_ID  
        set CreepUnitTypeIds[14] = ACOLYTE_CREEP_UNIT_ID          
        set CreepUnitTypeIds[15] = BANDIT_CREEP_UNIT_ID          
        set CreepUnitTypeIds[16] = CENTAUR_CREEP_UNIT_ID          
        set CreepUnitTypeIds[17] = OGRE_CREEP_UNIT_ID          
        set CreepUnitTypeIds[18] = TREANT_CREEP_UNIT_ID          
        set CreepUnitTypeIds[19] = QUILBOAR_CREEP_UNIT_ID       
        set CreepUnitTypeIds[20] = FOREST_TROLL_CREEP_UNIT_ID      
        set CreepUnitTypeIds[21] = GHOUL_CREEP_UNIT_ID            
        set CreepUnitTypeIds[22] = GNOLL_CREEP_UNIT_ID         
        set CreepUnitTypeIds[23] = KOBOLD_CREEP_UNIT_ID          
        set CreepUnitTypeIds[24] = MILITIA_CREEP_UNIT_ID       
        set CreepUnitTypeIds[25] = PANDAREN_CREEP_UNIT_ID        
        set CreepUnitTypeIds[26] = SPIDER_CRAB_CREEP_UNIT_ID        
        set CreepUnitTypeIds[27] = NIGHT_ELF_WARRIOR_CREEP_UNIT_ID    
        set CreepUnitTypeIds[28] = SATYR_CREEP_UNIT_ID              
        set CreepUnitTypeIds[29] = SASQUATCH_CREEP_UNIT_ID         
        set CreepUnitTypeIds[30] = FURBOLG_CREEP_UNIT_ID             
        set CreepUnitTypeIds[31] = DARK_TROLL_BERSERKER_CREEP_UNIT_ID  
        set CreepUnitTypeIds[32] = TUSKAR_CREEP_UNIT_ID            

        //ranged auto attacker creeps:
        set CreepUnitTypeIds[33] = HARPY_CREEP_UNIT_ID                  //ranged
        set CreepUnitTypeIds[34] = DRYAD_CREEP_UNIT_ID                  //ranged
        set CreepUnitTypeIds[35] = BANDIT_SPEAR_THROWER_CREEP_UNIT_ID   //ranged
        set CreepUnitTypeIds[36] = CENTAUR_IMPALER_CREEP_UNIT_ID        //ranged
        set CreepUnitTypeIds[37] = SKELETON_ARCHER_CREEP_UNIT_ID        //ranged
        set CreepUnitTypeIds[38] = FOREST_SPIDER_CREEP_UNIT_ID          //ranged

        //magic creeps:
        set CreepUnitTypeIds[39] = DRAENEI_MAGE_CREEP_UNIT_ID     
        set CreepUnitTypeIds[40] = SLUDGE_MINION_CREEP_UNIT_ID     
        set CreepUnitTypeIds[41] = WIND_SERPENT_CREEP_UNIT_ID           //ranged
        set CreepUnitTypeIds[42] = WRAITH_CREEP_UNIT_ID                 //ranged

        //mini bosses
        set CreepUnitTypeIds[43] = OGRE_LORD_CREEP_UNIT_ID     
        set CreepUnitTypeIds[44] = HARPY_QUEEN_CREEP_UNIT_ID            //ranged
        set CreepUnitTypeIds[45] = ARCHMAGE_CREEP_UNIT_ID               //ranged magic


        //boss creeps:
        set CreepUnitTypeIds[46] = MAGNATAUR_CREEP_UNIT_ID   
        set CreepUnitTypeIds[47] = BURNING_ARCHER_CREEP_UNIT_ID         //ranged
        set CreepUnitTypeIds[45] = HOLY_DEFENDER_CREEP_UNIT_ID   
        set CreepUnitTypeIds[46] = DRAGON_TURTLE_CREEP_UNIT_ID     
        set CreepUnitTypeIds[47] = CHAOS_WARLORD_CREEP_UNIT_ID    
        set CreepUnitTypeIds[48] = THUNDER_LIZARD_CREEP_UNIT_ID         //ranged
        set CreepUnitTypeIds[49] = BLACK_DRAGON_CREEP_UNIT_ID           //ranged 
        set CreepUnitTypeIds[50] = GREEN_DRAGON_CREEP_UNIT_ID           //ranged
        
        set MaxCreepUnitTypes = 42
    endfunction

    function IsSpellcasterCreep takes integer unitId returns boolean
        if unitId == SUCCUBUS_CREEP_UNIT_ID then
            return true
        elseif unitId == GNOLL_WARDEN_CREEP_UNIT_ID then
            return true
        elseif unitId == ORC_WARLOCK_CREEP_UNIT_ID then
            return true
        elseif unitId == OGRE_MAGI_CREEP_UNIT_ID then
            return true
        elseif unitId == BANDIT_MAGE_CREEP_UNIT_ID then
            return true
        elseif unitId == DEMONESS_CREEP_UNIT_ID then
            return true
        elseif unitId == VOID_WALKER_CREEP_UNIT_ID then
            return true
        elseif unitId == SHAMAN_CREEP_UNIT_ID then
            return true
        elseif unitId == CHAOS_WARLOCK_2_CREEP_UNIT_ID then
            return true
        elseif unitId == SASQUATCH_SHAMAN_CREEP_UNIT_ID then
            return true
        elseif unitId == WATCHER_CREEP_UNIT_ID then
            return true
        elseif unitId == HARPY_WITCH_CREEP_UNIT_ID then
            return true
        endif
        return false
    endfunction

    function IsMeleeCreep takes integer unitId returns boolean
        if unitId == MURLOC_TIDERUNNER_CREEP_UNIT_ID then
            return true
        elseif unitId == ACOLYTE_CREEP_UNIT_ID then
            return true
        elseif unitId == BANDIT_CREEP_UNIT_ID then
            return true
        elseif unitId == CENTAUR_CREEP_UNIT_ID then
            return true
        elseif unitId == OGRE_CREEP_UNIT_ID then
            return true
        elseif unitId == TREANT_CREEP_UNIT_ID then
            return true
        elseif unitId == QUILBOAR_CREEP_UNIT_ID then
            return true
        elseif unitId == FOREST_TROLL_CREEP_UNIT_ID then
            return true
        elseif unitId == GHOUL_CREEP_UNIT_ID then
            return true
        elseif unitId == GNOLL_CREEP_UNIT_ID then
            return true
        elseif unitId == KOBOLD_CREEP_UNIT_ID then
            return true
        elseif unitId == MILITIA_CREEP_UNIT_ID then
            return true
        elseif unitId == PANDAREN_CREEP_UNIT_ID then
            return true
        elseif unitId == SPIDER_CRAB_CREEP_UNIT_ID then
            return true
        elseif unitId == NIGHT_ELF_WARRIOR_CREEP_UNIT_ID then
            return true
        elseif unitId == SATYR_CREEP_UNIT_ID then
            return true
        elseif unitId == SASQUATCH_CREEP_UNIT_ID then
            return true
        elseif unitId == FURBOLG_CREEP_UNIT_ID then
            return true
        elseif unitId == DARK_TROLL_BERSERKER_CREEP_UNIT_ID then
            return true
        elseif unitId == TUSKAR_CREEP_UNIT_ID then
            return true
        endif
        return false
    endfunction

    function IsRangedCreep takes integer unitId returns boolean
        if unitId == HARPY_CREEP_UNIT_ID then
            return true
        elseif unitId == DRYAD_CREEP_UNIT_ID then
            return true
        elseif unitId == BANDIT_SPEAR_THROWER_CREEP_UNIT_ID then
            return true
        elseif unitId == CENTAUR_IMPALER_CREEP_UNIT_ID then
            return true
        elseif unitId == SKELETON_ARCHER_CREEP_UNIT_ID then
            return true
        elseif unitId == FOREST_SPIDER_CREEP_UNIT_ID then
            return true
        endif
        return false
    endfunction

    function IsMagicCreep takes integer unitId returns boolean
        if unitId == DRAENEI_MAGE_CREEP_UNIT_ID then
            return true
        elseif unitId == SLUDGE_MINION_CREEP_UNIT_ID then
            return true
        elseif unitId == WIND_SERPENT_CREEP_UNIT_ID then
            return true
        elseif unitId == WRAITH_CREEP_UNIT_ID then
            return true
        endif
        return false
    endfunction

    function IsBossCreep takes integer unitId returns boolean
        if unitId == MAGNATAUR_CREEP_UNIT_ID then
            return true
        elseif unitId == BURNING_ARCHER_CREEP_UNIT_ID then
            return true
        elseif unitId == HOLY_DEFENDER_CREEP_UNIT_ID then
            return true
        elseif unitId == DRAGON_TURTLE_CREEP_UNIT_ID then
            return true
        elseif unitId == CHAOS_WARLORD_CREEP_UNIT_ID then
            return true
        elseif unitId == THUNDER_LIZARD_CREEP_UNIT_ID then
            return true
        elseif unitId == BLACK_DRAGON_CREEP_UNIT_ID then
            return true
        elseif unitId == GREEN_DRAGON_CREEP_UNIT_ID then
            return true
        elseif unitId == OGRE_LORD_CREEP_UNIT_ID then
            return true
        elseif unitId == HARPY_QUEEN_CREEP_UNIT_ID then
            return true
        endif
        return false
    endfunction

    private function init takes nothing returns nothing
        set CreepTypesTrigger = CreateTrigger()
        call TriggerAddAction(CreepTypesTrigger, function CreepTypesActions)
    endfunction

endlibrary
