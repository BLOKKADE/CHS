library Evasion requires CustomState, RandomShit, LuckyPants

    function EvasionCheck takes real returnDamage returns nothing
        local real percentage = (1 - (returnDamage / Damage.index.damage)) * 100
        local texttag tx = CreateTextTag()

        if returnDamage != Damage.index.damage then
            call SetTextTagText(tx,R2SW(percentage, 1, 0) + "%% miss", TEXT_SIZE)
        else
            call SetTextTagText(tx, "miss", TEXT_SIZE)
            set returnDamage = 0
            call BlzSetEventWeaponType(WEAPON_TYPE_WHOKNOWS)
        endif
        call SetTextTagPosUnit(tx, DamageSource, - 15)
        call SetTextTagColor(tx, 255, 0, 0, 255)
        call SetTextTagLifespan(tx, 1.5)
        call SetTextTagFadepoint(tx, 1.2)
        call SetTextTagVelocity(tx, 0.0, 0.0355)
        call SetTextTagPermanent(tx, false)

        set tx = null
        set Damage.index.damage = returnDamage
    endfunction

    function Evade takes nothing returns nothing
        local real returnDamage = Damage.index.damage
        local integer abilLvl = 0

        if GetUnitMissChance(DamageSource) > 0 and GetRandomReal(0, 100) > GetUnitMissChance(DamageSource) then
            return
        endif

        if GetUnitAbilityLevel(DamageSource, 'B027') > 0 then
            if GetRandomReal(0, 100) > GetHeroLevel(udg_units01[ScorchedEarthSource[GetHandleId(DamageSource)] + 1]) * 0.5 then
                return
            endif
        endif

        if GetUnitEvasion(DamageTarget) > 0 and GetRandomReal(0, 100) > GetUnitRealEvade(DamageTarget) * 100 then
            return
        else
            //Lucky Pants
            if UnitHasItemS(DamageTarget, LUCKY_PANTS_ITEM_ID) then
                call ActivateLuckyPants(DamageTarget)
            endif

            //Trickster
            if GetUnitTypeId(DamageTarget) == SATYR_TRICKSTER_UNIT_ID then
                //set TypeDmg_b = 2
                //set DamageIsAttack = true
                //set GLOB_typeDmg = 2
                //set udg_NextDamageIsAttack = true
                set udg_NextDamageType = DamageType_Onhit
                set udg_NextDamageAbilitySource = SATYR_TRICKSTER_UNIT_ID
                set udg_NextDamageIsAttack = true
                call Damage.applyPhys(DamageTarget, DamageSource, GetAttackDamage(DamageTarget) * 1 + (0.02 * GetHeroLevel(DamageTarget)), false, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            endif
        endif

        //Trueshot aura
        set abilLvl = GetUnitAbilityLevel(DamageSourceHero, TRUESHOT_AURA_ABILITY_ID)
        if abilLvl > 0 then
            set returnDamage = returnDamage * (0.005 * abilLvl)
            set DamageIsTrue = true
        endif

        call EvasionCheck(returnDamage)
    endfunction
endlibrary