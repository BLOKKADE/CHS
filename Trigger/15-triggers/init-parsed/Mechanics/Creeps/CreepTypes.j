library CreepTypes initializer init requires RandomShit

    private function CreepTypesActions takes nothing returns nothing
        set CreepUnitTypeIds[1] = 'n000' //Murloc Tiderunner
        set CreepUnitTypeIds[2] = 'n002' //Acolyte
        set CreepUnitTypeIds[3] = 'n008' //Bandit
        set CreepUnitTypeIds[4] = 'n009' //Centaur
        set CreepUnitTypeIds[5] = 'n006' //Dryad
        set CreepUnitTypeIds[6] = 'n00G' //Ogre
        set CreepUnitTypeIds[7] = 'n00F' //Treant
        set CreepUnitTypeIds[8] = 'n00H' //Quilboar
        set CreepUnitTypeIds[9] = 'n00N' //Forest Troll
        set CreepUnitTypeIds[10] = 'n007' //Ghoul
        set CreepUnitTypeIds[11] = 'n00X' //Gnoll
        set CreepUnitTypeIds[12] = 'n019' //Kobold
        set CreepUnitTypeIds[13] = 'n01B' //Militia
        set CreepUnitTypeIds[14] = 'n01C' //Pandaren
        set CreepUnitTypeIds[15] = 'n01A' //Skeleton Archer
        set CreepUnitTypeIds[16] = 'n018' //Spider Crab
        set CreepUnitTypeIds[17] = 'n01F' //Harpy
        set CreepUnitTypeIds[18] = 'n01K' //Night Elf Warrior
        set CreepUnitTypeIds[19] = 'n01J' //Orc Warlock
        set CreepUnitTypeIds[20] = 'n01I' //Satyr
        set CreepUnitTypeIds[21] = 'n01G' //Succubus
        set CreepUnitTypeIds[22] = 'n00W' //Wraith
        set CreepUnitTypeIds[23] = 'n01H' //Sludge minion
        
        set MaxCreepUnitTypes = 23
    endfunction

    private function init takes nothing returns nothing
        set CreepTypesTrigger = CreateTrigger()
        call TriggerAddAction(CreepTypesTrigger, function CreepTypesActions)
    endfunction

endlibrary
