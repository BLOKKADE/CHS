/*library trigger93 initializer init requires RandomShit

    function Trig_Moonstone_Conditions takes nothing returns boolean
        if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03O')==true))then
            return false
        endif
        if(not(GetSpellAbilityId()!='AIdb'))then
            return false
        endif
        return true
    endfunction


    function Trig_Moonstone_Actions takes nothing returns nothing
        call TriggerSleepAction(0.00)
        call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())+(GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetTriggerUnit())* 0.04)))
        call AddSpecialEffectTargetUnitBJ("weapon",GetTriggerUnit(),"Abilities\\Spells\\Undead\\ReplenishMana\\SpiritTouchTarget.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger93 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger93,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(udg_trigger93,Condition(function Trig_Moonstone_Conditions))
        call TriggerAddAction(udg_trigger93,function Trig_Moonstone_Actions)
    endfunction


endlibrary
*/