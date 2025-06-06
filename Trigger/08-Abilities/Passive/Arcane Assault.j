library ArcaneAssault requires MathRound, CastSpellOnTarget, RandomShit
    globals
        string FX_AA = "war3mapImported\\Climax Teal.mdx"
    endglobals

    function ArcaneAssault takes unit damageSource, unit damageTarget, integer damageSourceAbility, real damage, integer level returns nothing
        local real fullValue = 0.7 + (level * 0.3)
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

        if damageBonus != 0 then
            set targets = targets + 1
        endif

        call GroupClear(ENUM_GROUP)
        call GroupAddUnit(ENUM_GROUP, damageTarget)
        call RUH.reset().excludeGroup(ENUM_GROUP).EnumUnits(x, y, 600, Target_Enemy, p)

        loop
            set target = RUH.GetRandomUnit(false)
            exitwhen targets == 0 or target == null
            if not IsUnitInGroup(target, ENUM_GROUP) then
                set targets = targets - 1
                call GroupAddUnit(ENUM_GROUP, target)
            endif
        endloop

        call GroupRemoveUnit(ENUM_GROUP, damageTarget)
        set targets = MathRound_round(fullDamageCount)
        //call BJDebugMsg("aa: targets: " + I2S(targets) + " fd: " + R2S(fullDamageCount) + " fv: " + R2S(fullValue) + " dmgb: " + R2S(damageBonus))
        loop
            set target = FirstOfGroup(ENUM_GROUP)
            exitwhen target == null
            
            call DestroyEffect(AddLocalizedSpecialEffectTarget(FX_AA, target, "chest"))
            if targets > 0 then
                set targets = targets - 1
                //set GLOB_typeDmg = 2
                //set DamageIsAttack = true
                set udg_NextDamageAbilitySource = ARCANE_ASSAUL_ABILITY_ID
                set udg_NextDamageIsAttack = true
                call Damage.applyPhys(damageSource, target, damage, true, IsUnitType(damageSource, UNIT_TYPE_RANGED_ATTACKER), ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                //call BJDebugMsg("full aa" + I2S(GetHandleId(target)) + " targets: " + I2S(targets))
            elseif damageBonus != 0 then
                //set GLOB_typeDmg = 2
                //set DamageIsAttack = true
                set udg_NextDamageAbilitySource = ARCANE_ASSAUL_ABILITY_ID
                set udg_NextDamageIsAttack = true
                call Damage.applyPhys(damageSource, target, damage * damageBonus, true, IsUnitType(damageSource, UNIT_TYPE_RANGED_ATTACKER), ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                //call BJDebugMsg("db aa" + I2S(GetHandleId(target)) + " dmg: " + R2S(damage * damageBonus) + " targets: " + I2S(targets))
                call GroupClear(ENUM_GROUP)
            endif
            call GroupRemoveUnit(ENUM_GROUP, target)
        endloop
        set p = null
    endfunction
endlibrary