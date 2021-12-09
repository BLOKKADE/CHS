library trigger54 initializer init requires RandomShit

    function Trig_Betting_Complete_Conditions takes nothing returns boolean
        if(not(udg_boolean13==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Betting_Complete_Func002A takes nothing returns nothing
        if(Trig_Betting_Complete_Func002Func001C())then
            if(Trig_Betting_Complete_Func002Func001Func001C())then
                set udg_string01 =(GetPlayerNameColour(GetEnumPlayer()))
                set udg_string01 =(udg_string01 + " won: ")
                call AddSpecialEffectTargetUnitBJ("origin",udg_units01[GetConvertedPlayerId(GetEnumPlayer())],"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
                if(Trig_Betting_Complete_Func002Func001Func001Func006C())then
                    call AdjustPlayerStateBJ((udg_integers15[GetConvertedPlayerId(GetEnumPlayer())]* 2),GetEnumPlayer(),PLAYER_STATE_RESOURCE_GOLD)
                    call ResourseRefresh(  GetEnumPlayer()    )
                    set udg_string01 =(udg_string01 + I2S((udg_integers15[GetConvertedPlayerId(GetEnumPlayer())]* 2)))
                    if(Trig_Betting_Complete_Func002Func001Func001Func006Func003C())then
                        set udg_string01 =(udg_string01 + " gold and ")
                    else
                    endif
                else
                endif
                if(Trig_Betting_Complete_Func002Func001Func001Func007C())then
                    call AdjustPlayerStateBJ((udg_integers16[GetConvertedPlayerId(GetEnumPlayer())]* 2),GetEnumPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh( GetEnumPlayer()   )
                    set udg_string01 =(udg_string01 + I2S((udg_integers16[GetConvertedPlayerId(GetEnumPlayer())]* 2)))
                    set udg_string01 =(udg_string01 + " lumber!")
                else
                    set udg_string01 =(udg_string01 + " gold!")
                endif
                call DisplayTimedTextToForce(GetPlayersAll(),5.00,udg_string01)
            else
            endif
        else
        endif
        set udg_integers11[GetConvertedPlayerId(GetEnumPlayer())]= 0
        set udg_integers15[GetConvertedPlayerId(GetEnumPlayer())]= 0
        set udg_integers16[GetConvertedPlayerId(GetEnumPlayer())]= 0
        set udg_booleans04[GetConvertedPlayerId(GetEnumPlayer())]= false
        set udg_booleans05[GetConvertedPlayerId(GetEnumPlayer())]= false
    endfunction


    function Trig_Betting_Complete_Actions takes nothing returns nothing
        call ForForce(GetPlayersAll(),function Trig_Betting_Complete_Func002A)
        call ForceClear(udg_force04)
        call ForceClear(udg_force05)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger54 = CreateTrigger()
        call TriggerAddCondition(udg_trigger54,Condition(function Trig_Betting_Complete_Conditions))
        call TriggerAddAction(udg_trigger54,function Trig_Betting_Complete_Actions)
    endfunction


endlibrary
