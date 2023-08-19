library Plague requires AreaDamage

    function CastPlague takes unit caster, real x, real y, integer level returns nothing
        local real bonus = 1
        local integer corpseLimit = 4
        local integer blackArrowLimit = 2
        local effect fx
        local integer i = 0
        local unit dummy
        local real dummyX
        local real dummyY
        local player p = GetOwningPlayer(caster)
        local unit hero = PlayerHeroes[GetPlayerId(p)]
        
        loop
            set dummyX = x + (GetRandomReal(-300, 300))
            set dummyY = y + (GetRandomReal(-300, 300))
            set dummy = CreateUnit(p, 'n01L', dummyX, dummyY, GetRandomDirectionDeg())
            call UnitApplyTimedLifeBJ(14.00, 'BTLF', dummy)
            call SetAbilityRealField(dummy, 'A0AG', 1, ABILITY_RLF_DAMAGE_PER_INTERVAL, (60 * level) * bonus)
            call AbilityModifiers.copy(caster, dummy).destroyTimer(14)
            call SetUnitTimeScalePercent(dummy, 50.00)
            set DummyAbilitySource[GetHandleId(dummy)] = PLAGUE_ABILITY_ID
            call SetPlayerAbilityAvailable(p, 'A0AG', false)
            call SetPlayerAbilityAvailable(p, 'A0AG', true)
            if i < corpseLimit then
                if i < blackArrowLimit and GetUnitAbilityLevel(hero, BLACK_ARROW_PASSIVE_ABILITY_ID) > 0 then
                    call CastBlackArrow(caster, dummy, GetUnitAbilityLevel(caster, 'A0AW'))
                endif

                if GetUnitAbilityLevel(hero, 'A0BA') > 0 then
                    call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + ( (0.02 + (0.0005 * GetHeroLevel(caster))) * BlzGetUnitMaxHP(caster)))
                    call AreaDamage(caster, x, y, 20 + (30 * GetHeroLevel(caster)), 400, false, 'N00O', true, false)
                    set fx = AddLocalizedSpecialEffect("war3mapImported\\Arcane Explosion.mdx", dummyX, dummyY)
                    call BlzSetSpecialEffectTimeScale(fx, 2)
                    call DestroyEffect(fx)
                endif
            endif
            set i = i + 1
            exitwhen i > 10
        endloop
    
        set p = null
        set fx = null
        set dummy = null
    endfunction
endlibrary