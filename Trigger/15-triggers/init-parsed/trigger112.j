library trigger112 initializer init requires RandomShit

    function Trig_Set_Ability_Actions takes nothing returns nothing
        set udg_integer44 = 1
        loop
            exitwhen udg_integer44 > udg_integer26
            if(Trig_Set_Ability_Func001Func001001())then
                set udg_integer01 = udg_integers08[udg_integer44]
            else
                call DoNothing()
            endif
            if(Trig_Set_Ability_Func001Func002C())then
                set udg_integer01 = udg_integers08[udg_integer44]
                return
            else
            endif
            set udg_integer44 = udg_integer44 + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger112 = CreateTrigger()
        call TriggerAddAction(udg_trigger112,function Trig_Set_Ability_Actions)
    endfunction


endlibrary
