library trigger54 initializer init requires RandomShit

    function Trig_Betting_Complete_Conditions takes nothing returns boolean
        return BettingEnabled==true
    endfunction


    function Trig_Betting_Complete_Func002A takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer convertedPlayerId = GetConvertedPlayerId(currentPlayer)
        local string winMessage

        if (udg_integers15[convertedPlayerId] > 0 or udg_integers16[convertedPlayerId] > 0) then
            //if ((IsUnitInGroup(DuelingHeroes[1], DuelWinnerDisabled)==true) and IsPlayerInForce(currentPlayer,udg_force04)==true) or ((IsUnitInGroup(DuelingHeroes[2], DuelWinnerDisabled)==true) and IsPlayerInForce(currentPlayer,udg_force05)==true))then
                set winMessage = GetPlayerNameColour(currentPlayer)
                set winMessage = winMessage + " won: "
                call AddSpecialEffectTargetUnitBJ("origin",PlayerHeroes[convertedPlayerId],"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
                
                if(udg_booleans04[convertedPlayerId]==true)then
                    call AdjustPlayerStateBJ((udg_integers15[convertedPlayerId] * 2),currentPlayer,PLAYER_STATE_RESOURCE_GOLD)
                    call ResourseRefresh(currentPlayer)
                    set winMessage = winMessage + I2S((udg_integers15[convertedPlayerId]* 2))
                    
                    if(udg_booleans05[convertedPlayerId]==true)then
                        set winMessage = winMessage + " gold and "
                    endif
                endif

                if(udg_booleans05[convertedPlayerId]==true)then
                    call AdjustPlayerStateBJ((udg_integers16[convertedPlayerId]* 2),currentPlayer,PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(currentPlayer)
                    set winMessage = winMessage + I2S((udg_integers16[convertedPlayerId] * 2))
                    set winMessage = winMessage + " lumber!"
                else
                    set winMessage = winMessage + " gold!"
                endif

                call DisplayTimedTextToForce(GetPlayersAll(),5.00,winMessage)
            //endif
        endif

        set udg_integers11[convertedPlayerId] = 0
        set udg_integers15[convertedPlayerId] = 0
        set udg_integers16[convertedPlayerId] = 0
        set udg_booleans04[convertedPlayerId] = false
        set udg_booleans05[convertedPlayerId] = false

        set currentPlayer = null
    endfunction


    function Trig_Betting_Complete_Actions takes nothing returns nothing
        call ForForce(GetPlayersAll(),function Trig_Betting_Complete_Func002A)
        call ForceClear(udg_force04)
        call ForceClear(udg_force05)
    endfunction


    private function init takes nothing returns nothing
        set DistributeBetsTrigger = CreateTrigger()
        call TriggerAddCondition(DistributeBetsTrigger,Condition(function Trig_Betting_Complete_Conditions))
        call TriggerAddAction(DistributeBetsTrigger,function Trig_Betting_Complete_Actions)
    endfunction


endlibrary
