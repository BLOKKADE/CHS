library trigger148 initializer init requires RandomShit

    function Trig_Unhide_Shops_Func001Func001Func001Func002C takes nothing returns boolean
        if(not(udg_boolean05!=true))then
            return false
        endif
        if(not(udg_integers10[udg_integer36]!='n016'))then
            return false
        endif
        return true
    endfunction


    function Trig_Unhide_Shops_Func001Func001Func001C takes nothing returns boolean
        if((udg_boolean05==true))then
            return true
        endif
        if(Trig_Unhide_Shops_Func001Func001Func001Func002C())then
            return true
        endif
        return false
    endfunction


    function Trig_Unhide_Shops_Func001Func001C takes nothing returns boolean
        if(not Trig_Unhide_Shops_Func001Func001Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Unhide_Shops_Func001Func001Func003C takes nothing returns boolean
        if(not(GetUnitTypeId(GetLastCreatedUnit())=='n012'))then
            return false
        endif
        return true
    endfunction


    function Trig_Unhide_Shops_Actions takes nothing returns nothing
        set udg_integer36 = 1
        loop
            exitwhen udg_integer36 > udg_integer35
            if(Trig_Unhide_Shops_Func001Func001C())then
                call CreateNUnitsAtLoc(1,udg_integers10[udg_integer36],Player(PLAYER_NEUTRAL_PASSIVE),udg_locations01[udg_integer36],bj_UNIT_FACING)
                if(Trig_Unhide_Shops_Func001Func001Func003C())then
                    call TriggerRegisterUnitInRangeSimple(udg_trigger149,300.00,GetLastCreatedUnit())
                    set udg_unit04 = GetLastCreatedUnit()
                else
                endif
            else
            endif
            set udg_integer36 = udg_integer36 + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger148 = CreateTrigger()
        call TriggerAddAction(udg_trigger148,function Trig_Unhide_Shops_Actions)
    endfunction


endlibrary
