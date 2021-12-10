library trigger104 initializer init requires RandomShit

    function Trig_Unit_Type_Actions takes nothing returns nothing
        set udg_integers02[1]= 'n000'
        set udg_integers02[2]= 'n002'
        set udg_integers02[3]= 'n008'
        set udg_integers02[4]= 'n009'
        set udg_integers02[5]= 'n006'
        set udg_integers02[6]= 'n00G'
        set udg_integers02[7]= 'n00F'
        set udg_integers02[8]= 'n00H'
        set udg_integers02[9]= 'n00N'
        set udg_integers02[10]= 'n007'
        set udg_integers02[11]= 'n00X'
        set udg_integers02[12]= 'n019'
        set udg_integers02[13]= 'n01B'
        set udg_integers02[14]= 'n01C'
        set udg_integers02[15]= 'n01A'
        set udg_integers02[16]= 'n018'
        set udg_integers02[17]= 'n01F'
        set udg_integers02[18]= 'n01K'
        set udg_integers02[19]= 'n01J'
        set udg_integers02[20]= 'n01I'
        set udg_integers02[21]= 'n01G'
        set udg_integers02[22]= 'n00W'
        set udg_integers02[23]= 'n01H'
        set udg_integer22 = 23
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger104 = CreateTrigger()
        call TriggerAddAction(udg_trigger104,function Trig_Unit_Type_Actions)
    endfunction


endlibrary
