library trigger23 initializer init requires RandomShit

    function Trig_Plague_Conditions takes nothing returns boolean
        if(not(GetSpellAbilityId()=='A017'))then
            return false
        endif
        if(not Trig_Plague_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Plague_Actions takes nothing returns nothing
        local real bonus = 1
        local integer corpseLimit = 4
        local unit caster = GetTriggerUnit()
        local real x
        local real y
        local effect fx
        set udg_integer52 = 1
        if PoisonBonus.real[GetHandleId(caster)] != 0 then
            set bonus = PoisonBonus.real[GetHandleId(caster)]
        endif
        loop
            exitwhen udg_integer52 > 10
            call CreateNUnitsAtLoc(1,'n01L',GetOwningPlayer(caster),OffsetLocation(GetSpellTargetLoc(),GetRandomReal(- 300.00,300.00),GetRandomReal(- 300.00,300.00)),GetRandomDirectionDeg())
            set x = GetUnitX(GetLastCreatedUnit())
            set y = GetUnitY(GetLastCreatedUnit())
            call UnitApplyTimedLifeBJ(14.00,'BTLF',GetLastCreatedUnit())
            call UnitAddAbility(GetLastCreatedUnit(), 'A0AG')
            call IncUnitAbilityLevel(GetLastCreatedUnit(), 'A0AG')
            call BlzSetAbilityRealLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A0AG'), ABILITY_RLF_DAMAGE_PER_INTERVAL, 0, (60 * GetUnitAbilityLevel(caster, 'A017')) * bonus)
            call DecUnitAbilityLevel(GetLastCreatedUnit(), 'A0AG')
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0AG', false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0AG', true)
            call SetUnitTimeScalePercent(GetLastCreatedUnit(),50.00)
            if udg_integer52 <= corpseLimit then
                call CreateCorpseLocBJ(ChooseRandomCreepBJ(- 1),GetOwningPlayer(GetTriggerUnit()),OffsetLocation(GetSpellTargetLoc(),GetRandomReal(- 300.00,300.00),GetRandomReal(- 300.00,300.00)))
                if GetUnitAbilityLevel(caster, 'A0AW') > 0 then
                    call CastBlackArrow(caster, GetLastCreatedUnit(), GetUnitAbilityLevel(caster, 'A0AW'))
                endif
                if GetUnitAbilityLevel(caster, 'A0BA') > 0 then
                    call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + ( (0.02 + (0.0005 * GetHeroLevel(caster))) * BlzGetUnitMaxHP(caster)))
                    call AreaDamage(caster, x, y, 20 + (30 * GetHeroLevel(caster)), 400, false, 'N00O')
                    set fx = AddSpecialEffect("war3mapImported\\Arcane Explosion.mdx", x, y)
                    call BlzSetSpecialEffectTimeScale(fx, 2)
                    call DestroyEffect(fx)
                endif
            endif
            set udg_integer52 = udg_integer52 + 1
        endloop
    
        set fx = null
        set caster = null
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger23 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger23,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(udg_trigger23,Condition(function Trig_Plague_Conditions))
        call TriggerAddAction(udg_trigger23,function Trig_Plague_Actions)
    endfunction


endlibrary
