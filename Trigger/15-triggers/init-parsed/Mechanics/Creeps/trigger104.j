library trigger104 initializer init requires RandomShit

    function Trig_Unit_Type_Actions takes nothing returns nothing
        set CreepUnitTypeIds[1]= 'n000'
        set CreepUnitTypeIds[2]= 'n002'
        set CreepUnitTypeIds[3]= 'n008'
        set CreepUnitTypeIds[4]= 'n009'
        set CreepUnitTypeIds[5]= 'n006'
        set CreepUnitTypeIds[6]= 'n00G'
        set CreepUnitTypeIds[7]= 'n00F'
        set CreepUnitTypeIds[8]= 'n00H'
        set CreepUnitTypeIds[9]= 'n00N'
        set CreepUnitTypeIds[10]= 'n007'
        set CreepUnitTypeIds[11]= 'n00X'
        set CreepUnitTypeIds[12]= 'n019'
        set CreepUnitTypeIds[13]= 'n01B'
        set CreepUnitTypeIds[14]= 'n01C'
        set CreepUnitTypeIds[15]= 'n01A'
        set CreepUnitTypeIds[16]= 'n018'
        set CreepUnitTypeIds[17]= 'n01F'
        set CreepUnitTypeIds[18]= 'n01K'
        set CreepUnitTypeIds[19]= 'n01J'
        set CreepUnitTypeIds[20]= 'n01I'
        set CreepUnitTypeIds[21]= 'n01G'
        set CreepUnitTypeIds[22]= 'n00W'
        set CreepUnitTypeIds[23]= 'n01H'
        set MaxCreepUnitTypes = 23
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger104 = CreateTrigger()
        call TriggerAddAction(udg_trigger104,function Trig_Unit_Type_Actions)
    endfunction


endlibrary
