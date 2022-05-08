library trigger148 initializer init requires RandomShit

    function Trig_Unhide_Shops_Func001Func001Func001Func002C takes nothing returns boolean
        if(not(ArNotLearningAbil!=true))then
            return false
        endif
        if(not(ShopIds[HideShopsIndex]!='n016'))then
            return false
        endif
        return true
    endfunction


    function Trig_Unhide_Shops_Func001Func001Func001C takes nothing returns boolean
        if((ArNotLearningAbil==true))then
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

    function Trig_Unhide_Shops_Actions takes nothing returns nothing
        set HideShopsIndex = 1
        loop
            exitwhen HideShopsIndex > HideShopsCount
            if(Trig_Unhide_Shops_Func001Func001C())then
                call CreateNUnitsAtLoc(1,ShopIds[HideShopsIndex],Player(PLAYER_NEUTRAL_PASSIVE),udg_locations01[HideShopsIndex],bj_UNIT_FACING)
            else
            endif
            set HideShopsIndex = HideShopsIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger148 = CreateTrigger()
        call TriggerAddAction(udg_trigger148,function Trig_Unhide_Shops_Actions)
    endfunction


endlibrary
