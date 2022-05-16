library trigger11 initializer init requires RandomShit

    function Trig_Devastating_Blow_Conditions takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A050',GetEventDamageSource())> 0))then
            return false
        endif
    
        if(not(   BlzGetUnitAbilityCooldownRemaining(GetEventDamageSource(),'A050')<= 0 ))then
            return false
        endif
        if(not(IsUnitAliveBJ(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))])==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Devastating_Blow_Actions takes nothing returns nothing
        local location unitLocation

        if GetUnitAbilityLevel(GetTriggerUnit(), 'B01D') == 0 and GetEventDamageSource() != GetTriggerUnit() then
            set unitLocation = GetUnitLoc(GetTriggerUnit())

            call DestroyEffectBJ(udg_effects01[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))])
            call DestroyEffectBJ(udg_effects02[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))])
            set udg_effects01[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))] = null
            set udg_effects02[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))] = null
            call AddSpecialEffectLocBJ(unitLocation,"Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call AddSpecialEffectLocBJ(unitLocation,"Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            //	call UnitDamageTargetBJ(GetEventDamageSource(),GetTriggerUnit(),(50.00*I2R(GetUnitAbilityLevelSwapped('Aimp',GetEventDamageSource()))),ATTACK_TYPE_HERO,DAMAGE_TYPE_NORMAL)
            call AbilStartCD(GetEventDamageSource(),'A050',5)
            call DisableTrigger(udg_trigger11)
            call UnitDamageTargetBJ(GetEventDamageSource(),GetTriggerUnit(),(0.08 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetTriggerUnit())) + (50.00 * I2R(GetUnitAbilityLevelSwapped('A050',GetEventDamageSource())))   ,ATTACK_TYPE_MAGIC,DAMAGE_TYPE_MAGIC)
            call EnableTrigger(udg_trigger11) 

            call RemoveLocation(unitLocation)
            set unitLocation = null
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger11 = CreateTrigger()
        call TriggerAddCondition(udg_trigger11,Condition(function Trig_Devastating_Blow_Conditions))
        call TriggerAddAction(udg_trigger11,function Trig_Devastating_Blow_Actions)
    endfunction


endlibrary
