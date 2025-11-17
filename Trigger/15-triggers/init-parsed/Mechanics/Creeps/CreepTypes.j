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

        //magic creeps:
        set CreepUnitTypeIds[38] = DRAENEI_MAGE_CREEP_UNIT_ID     
        set CreepUnitTypeIds[39] = SLUDGE_MINION_CREEP_UNIT_ID     
        set CreepUnitTypeIds[40] = WIND_SERPENT_CREEP_UNIT_ID           //ranged
        set CreepUnitTypeIds[41] = WRAITH_CREEP_UNIT_ID                 //ranged

        //boss creeps:
        set CreepUnitTypeIds[42] = MAGNATAUR_CREEP_UNIT_ID   
        set CreepUnitTypeIds[43] = BURNING_ARCHER_CREEP_UNIT_ID         //ranged
        set CreepUnitTypeIds[44] = HOLY_DEFENDER_CREEP_UNIT_ID   
        set CreepUnitTypeIds[45] = DRAGON_TURTLE_CREEP_UNIT_ID     
        set CreepUnitTypeIds[46] = CHAOS_WARLORD_CREEP_UNIT_ID    
        set CreepUnitTypeIds[47] = THUNDER_LIZARD_CREEP_UNIT_ID         //ranged
        set CreepUnitTypeIds[48] = BLACK_DRAGON_CREEP_UNIT_ID           //ranged 
        set CreepUnitTypeIds[49] = GREEN_DRAGON_CREEP_UNIT_ID           //ranged
        set CreepUnitTypeIds[50] = OGRE_LORD_CREEP_UNIT_ID     
        set CreepUnitTypeIds[51] = HARPY_QUEEN_CREEP_UNIT_ID            //ranged
        set CreepUnitTypeIds[52] = STOMP_TREE_UNIT_ID 
        
        set MaxCreepUnitTypes = 41
    endfunction

    private function init takes nothing returns nothing
        set CreepTypesTrigger = CreateTrigger()
        call TriggerAddAction(CreepTypesTrigger, function CreepTypesActions)
    endfunction

endlibrary
