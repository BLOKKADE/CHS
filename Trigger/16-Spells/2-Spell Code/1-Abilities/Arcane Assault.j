library ArcaneAssault requires MathRound, CastSpellOnTarget, RandomShit
    globals
        group ArcaneAssaultGroup = CreateGroup()
        string FX_AA = "war3mapImported\\Climax Teal.mdx"
    endglobals

    function IsDamageArcaneAssault takes unit damageSource returns boolean
        return SpellData[GetHandleId(damageSource)].boolean[8]
    endfunction

    function ArcaneAssault takes unit damageSource, unit damageTarget, real damage returns nothing
        local real fullValue = 0.7 + (GetUnitAbilityLevel(damageSource, ARCANE_ASSAUL_ABILITY_ID) * 0.3)
        local real fullDamageCount = MathRound_floor(fullValue)
        local real damageBonus = fullValue - fullDamageCount
        local integer targets = MathRound_round(fullDamageCount)
        local unit target
        local player p = GetOwningPlayer(damageSource)
        local real x = GetUnitX(damageSource)
        local real y = GetUnitY(damageSource)

        call ElemFuncStart(damageSource, ARCANE_ASSAUL_ABILITY_ID)
        if GetUnitAbilityLevel(damageSource, CLEAVING_ATTACK_ABILITY_ID) > 0 or GetUnitAbilityLevel(damageSource, MULTISHOT_ABILITY_ID) > 0 then
            set p = null
            return
        endif

        //call BJDebugMsg("aa: targets: " + I2S(targets) + " fd: " + R2S(fullDamageCount) + " fv: " + R2S(fullValue) + " dmgb: " + R2S(damageBonus))
        if damageBonus != 0 then
            set targets = targets + 1
        endif

        call GroupClear(ArcaneAssaultGroup)
        call GroupAddUnit(ArcaneAssaultGroup, damageTarget)
        call RUH.reset().excludeGroup(ArcaneAssaultGroup).EnumUnits(x, y, 600, p)

        loop
            set target = RUH.GetRandomUnit(false)
            exitwhen targets == 0 or target == null
            if not IsUnitInGroup(target, ArcaneAssaultGroup) then
                set targets = targets - 1
                call GroupAddUnit(ArcaneAssaultGroup, target)
            endif
        endloop

        call GroupRemoveUnit(ArcaneAssaultGroup, damageTarget)
        set targets = MathRound_round(fullDamageCount)
        set SpellData[GetHandleId(damageSource)].boolean[8] = true
        loop
            set target = FirstOfGroup(ArcaneAssaultGroup)
            exitwhen target == null
            
            call DestroyEffect(AddSpecialEffectTargetFix(FX_AA, target, "chest"))
            if targets > 0 then
                set targets = targets - 1
                //set GLOB_typeDmg = 2
                //set DamageIsAttack = true
                set udg_NextDamageAbilitySource = ARCANE_ASSAUL_ABILITY_ID
                call Damage.applyAttack(damageSource, target, damage, IsUnitType(damageSource, UNIT_TYPE_RANGED_ATTACKER), ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                //call BJDebugMsg("full aa" + I2S(GetHandleId(target)) + " targets: " + I2S(targets))
            elseif damageBonus != 0 then
                //set GLOB_typeDmg = 2
                //set DamageIsAttack = true
                set udg_NextDamageAbilitySource = ARCANE_ASSAUL_ABILITY_ID
                call Damage.applyAttack(damageSource, target, damage * damageBonus, IsUnitType(damageSource, UNIT_TYPE_RANGED_ATTACKER), ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                //call BJDebugMsg("db aa" + I2S(GetHandleId(target)) + " dmg: " + R2S(damage * damageBonus) + " targets: " + I2S(targets))
                call GroupClear(ArcaneAssaultGroup)
            endif
            call GroupRemoveUnit(ArcaneAssaultGroup, target)
        endloop
        set SpellData[GetHandleId(damageSource)].boolean[8] = false
        set p = null
    endfunction
endlibrary