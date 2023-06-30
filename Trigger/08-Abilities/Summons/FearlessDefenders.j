library FearlessDefenders requires CustomState, SpellFormula, RandomShit, HideEffects
    
    function StartFearlessDefenders takes unit caster, integer abilId, real duration returns nothing
        local unit summon = null

        call ElemFuncStart(caster,abilId)
        set summon = CreateUnit(GetOwningPlayer(caster), FEARLESS_DEFENDER_CAPTAIN_UNIT_ID, GetUnitX(caster) + 40 * CosBJ(- 30 + GetUnitFacing(caster)), GetUnitY(caster) + 40 * SinBJ(-30 + GetUnitFacing(caster)), GetUnitFacing(caster))
        call BlzSetUnitName(summon, "Jeremy The Fearless")
        call UnitApplyTimedLife(summon, abilId, duration)
        call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", summon, "head"))

        set summon = CreateUnit(GetOwningPlayer(caster), FEARLESS_DEFENDER_CAPTAIN_UNIT_ID, GetUnitX(caster) + 40 * CosBJ(30 + GetUnitFacing(caster)), GetUnitY(caster) + 40 * SinBJ(30 + GetUnitFacing(caster)), GetUnitFacing(caster))
        call BlzSetUnitName(summon, "Julian The Gallant")
        call UnitApplyTimedLife(summon, abilId, duration)
        call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", summon, "head"))

        set summon = null
    endfunction

    function FearlessDefendersStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)
        local integer heroLevel = GetHeroLevel(PlayerHeroes[GetPlayerId(GetOwningPlayer(u))])

        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + R2I((totalLevel * 10000)*(1 +(heroLevel * 0.038) )) )
        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) - 10 + R2I((totalLevel * 100)*(1 +(heroLevel * 0.038)) ),0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + (totalLevel / 2))), 0)

        /*call UnitAddAbility(u, 'A06I')
        call SetUnitAbilityLevel(u, 'A06I', IMinBJ(R2I(totalLevel / 3), 60))*/
    endfunction
endlibrary