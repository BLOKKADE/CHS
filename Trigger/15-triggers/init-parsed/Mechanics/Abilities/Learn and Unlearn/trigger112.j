library trigger112 initializer init requires RandomShit

    function Trig_Set_Ability_Func001Func001001 takes nothing returns boolean
        return(GetItemTypeId(GetManipulatedItem())==udg_integers09[udg_integer44])
    endfunction


    function Trig_Set_Ability_Func001Func002C takes nothing returns boolean
        if(not(GetItemTypeId(GetManipulatedItem())==udg_integers09[udg_integer44]))then
            return false
        endif
        return true
    endfunction


    function Trig_Set_Ability_Actions takes nothing returns nothing
        set udg_integer44 = 1
        loop
            exitwhen udg_integer44 > udg_integer26
            if(Trig_Set_Ability_Func001Func001001())then
                set BoughtAbility = udg_integers08[udg_integer44]
            else
                call DoNothing()
            endif
            if(Trig_Set_Ability_Func001Func002C())then
                set BoughtAbility = udg_integers08[udg_integer44]
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
