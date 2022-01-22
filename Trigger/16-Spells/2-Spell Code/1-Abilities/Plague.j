library Plague requires AoeDamage

    function CastPlague takes unit caster, real x, real y, integer level returns nothing
        local real bonus = 1
        local integer corpseLimit = 4
        local integer blackArrowLimit = 2
        local effect fx
        local integer i = 0
        local unit dummy
        local real dummyX
        local real dummyY
        
        loop
            set dummyX = x + (GetRandomReal(-300, 300))
            set dummyY = y + (GetRandomReal(-300, 300))
            set dummy = CreateUnit(GetOwningPlayer(caster), 'n01L', dummyX, dummyY, GetRandomDirectionDeg())
            call UnitApplyTimedLifeBJ(14.00, 'BTLF', dummy)
            call SetAbilityRealField(dummy, 'A0AG', 1, ABILITY_RLF_DAMAGE_PER_INTERVAL, (60 * level) * bonus)
            call SetUnitTimeScalePercent(dummy, 50.00)
            if i < corpseLimit then
                call CreateCorpse(GetOwningPlayer(caster), ChooseRandomCreepBJ(- 1), dummyX, dummyY, GetRandomReal(0, 360))

                if i < blackArrowLimit and GetUnitAbilityLevel(caster, BLACK_ARROW_PASSIVE_ABILITY_ID) > 0 then
                    call CastBlackArrow(caster, dummy, GetUnitAbilityLevel(caster, 'A0AW'))
                endif

                if GetUnitAbilityLevel(caster, 'A0BA') > 0 then
                    call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + ( (0.02 + (0.0005 * GetHeroLevel(caster))) * BlzGetUnitMaxHP(caster)))
                    call AreaDamage(caster, x, y, 20 + (30 * GetHeroLevel(caster)), 400, false, 'N00O')
                    set fx = AddSpecialEffect("war3mapImported\\Arcane Explosion.mdx", dummyX, dummyY)
                    call BlzSetSpecialEffectTimeScale(fx, 2)
                    call DestroyEffect(fx)
                endif
            endif
            set i = i + 1
            exitwhen i > 10
        endloop
    
        set fx = null
        set dummy = null
    endfunction
endlibrary