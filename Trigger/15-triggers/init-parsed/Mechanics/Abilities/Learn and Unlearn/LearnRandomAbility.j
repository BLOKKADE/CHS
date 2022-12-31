library LearnRandomAbility initializer init requires RandomShit

    function Trig_Learn_Random_Ability_Func004Func003Func003Func001C takes nothing returns boolean
        if(not(HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(udg_unit01))]< 10))then
            return false
        endif
        if(not(GetUnitTypeId(udg_unit01)=='O000'))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004Func003Func003Func002C takes nothing returns boolean
        if(not(HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(udg_unit01))]< 10))then
            return false
        endif
        if(not(GetUnitTypeId(udg_unit01)!='O000'))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004Func003Func003C takes nothing returns boolean
        if(Trig_Learn_Random_Ability_Func004Func003Func003Func001C())then
            return true
        endif
        if(Trig_Learn_Random_Ability_Func004Func003Func003Func002C())then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Random_Ability_Func004Func003C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped(GetAbilityFromItem(RoundCreepAbilCastChance),udg_unit01)==0))then
            return false
        endif
        if(not(RoundCreepAbilCastChance!=GetItemTypeId(null)))then
            return false
        endif
        if(not Trig_Learn_Random_Ability_Func004Func003Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004C takes nothing returns boolean
        if(not Trig_Learn_Random_Ability_Func004Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004Func002C takes nothing returns boolean
        if(not(ArNotLearningAbil==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004Func001Func005Func001Func001C takes nothing returns boolean
        if(not(HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(udg_unit01))]>= 10))then
            return false
        endif
        if(not(GetUnitTypeId(udg_unit01)=='O000'))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004Func001Func005Func001Func002C takes nothing returns boolean
        if(not(HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(udg_unit01))]>= 10))then
            return false
        endif
        if(not(GetUnitTypeId(udg_unit01)!='O000'))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004Func001Func005Func001C takes nothing returns boolean
        if(Trig_Learn_Random_Ability_Func004Func001Func005Func001Func001C())then
            return true
        endif
        if(Trig_Learn_Random_Ability_Func004Func001Func005Func001Func002C())then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Random_Ability_Func004Func001Func005C takes nothing returns boolean
        if(not Trig_Learn_Random_Ability_Func004Func001Func005Func001C())then
            return false
        endif
        if(not(GetUnitAbilityLevelSwapped(GetAbilityFromItem(RoundCreepAbilCastChance),udg_unit01)> 0))then
            return false
        endif
        if(not(GetUnitAbilityLevelSwapped(GetAbilityFromItem(RoundCreepAbilCastChance),udg_unit01)< 30))then
            return false
        endif
        if(not(UnknownInteger02 <= 500))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004Func001C takes nothing returns boolean
        if(not Trig_Learn_Random_Ability_Func004Func001Func005C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004Func001Func002C takes nothing returns boolean
        if(not(ArNotLearningAbil==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Func004Func001Func001C takes nothing returns boolean
        if(not(UnknownInteger02 > 500))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Random_Ability_Actions takes nothing returns nothing
        set udg_player02 = GetOwningPlayer(udg_unit01)
        set RoundCreepAbilCastChance = GetItemFromAbility(GetRandomAbility())
        if(Trig_Learn_Random_Ability_Func004C())then
            if(Trig_Learn_Random_Ability_Func004Func002C())then
                set ArNotLearningAbil = false
                set ARLearningAbil = true
                call UnitAddItemByIdSwapped(RoundCreepAbilCastChance,PlayerHeroes[GetConvertedPlayerId(udg_player02)])
                set ARLearningAbil = false
                set ArNotLearningAbil = true
            else
                call UnitAddItemByIdSwapped(RoundCreepAbilCastChance,PlayerHeroes[GetConvertedPlayerId(udg_player02)])
            endif
        else
            if(Trig_Learn_Random_Ability_Func004Func001C())then
                if(Trig_Learn_Random_Ability_Func004Func001Func002C())then
                    set ArNotLearningAbil = false
                    set ARLearningAbil = true
                    call UnitAddItemByIdSwapped(RoundCreepAbilCastChance,PlayerHeroes[GetConvertedPlayerId(udg_player02)])
                    set ARLearningAbil = false
                    set ArNotLearningAbil = true
                else
                    call AdjustPlayerStateBJ(5,GetOwningPlayer(udg_unit01),PLAYER_STATE_RESOURCE_LUMBER)
    
                    call ResourseRefresh(GetOwningPlayer(udg_unit01) )
                    call ForceAddPlayerSimple(GetOwningPlayer(udg_unit01),bj_FORCE_PLAYER[11])
                    call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to learn!")
                    call ForceRemovePlayerSimple(GetOwningPlayer(udg_unit01),bj_FORCE_PLAYER[11])
                    return
                endif
            else
                if(Trig_Learn_Random_Ability_Func004Func001Func001C())then
                    call AdjustPlayerStateBJ(5,GetOwningPlayer(udg_unit01),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(udg_unit01) )
    
                    call ForceAddPlayerSimple(GetOwningPlayer(udg_unit01),bj_FORCE_PLAYER[11])
                    call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to learn!")
                    call ForceRemovePlayerSimple(GetOwningPlayer(udg_unit01),bj_FORCE_PLAYER[11])
                    return
                else
                endif
                set UnknownInteger02 =(UnknownInteger02 + 1)
                call ConditionalTriggerExecute(GetTriggeringTrigger())
            endif
        endif
    endfunction


    private function init takes nothing returns nothing
        set LearnRandomAbilityTrigger = CreateTrigger()
        call TriggerAddAction(LearnRandomAbilityTrigger,function Trig_Learn_Random_Ability_Actions)
    endfunction


endlibrary
