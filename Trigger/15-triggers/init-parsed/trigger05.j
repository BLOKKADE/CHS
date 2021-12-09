library trigger05 initializer init requires RandomShit

    function Trig_Corrosive_Skin_Conditions takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A00Q',GetAttackedUnitBJ())> 0))then
            return false
        endif
        return true
    endfunction


    function Trig_Corrosive_Skin_Actions takes nothing returns nothing
        local real luck = GetUnitLuck(GetTriggerUnit())
        local real bonus
        if GetRandomReal(0,100) <= 35 * luck then
            set bonus = PoisonBonus[GetHandleId(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))])]
            if bonus == 0 then
                set bonus = 1
            endif
            call DummyOrder.create(GetAttackedUnitBJ(), GetUnitX(GetAttackedUnitBJ()), GetUnitY(GetAttackedUnitBJ()), GetUnitFacing(GetAttackedUnitBJ()), 4).addActiveAbility('A00R', 1, 852231).setAbilityRealField('A00R', ABILITY_RLF_DAMAGE_HTB1, (80 * GetUnitAbilityLevel(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))], 'A00Q')) * bonus).target(GetAttacker()).activate()
            call PoisonSpellCast(GetAttackedUnitBJ(), GetAttacker())
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger05 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger05,EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(udg_trigger05,Condition(function Trig_Corrosive_Skin_Conditions))
        call TriggerAddAction(udg_trigger05,function Trig_Corrosive_Skin_Actions)
    endfunction


endlibrary
