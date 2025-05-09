library Evasion requires CustomState, RandomShit, LuckyPants, UnitHelpers, HeroForm, Fan

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

    function GetEvasionChance takes nothing returns real

        if UnitHasForm(DamageSource, FORM_SHADOW) and GetUnitAbilityLevel(DamageSource, SHADOW_DANCE_ABILITY_ID) > 0 then
            return  1 - (50 /(50 + GetUnitCustomState(DamageTarget, BONUS_EVASION) / 2)) 
        endif

        return  1 - (50 /(50 + GetUnitCustomState(DamageTarget, BONUS_EVASION))) 
    endfunction

    function Evade takes nothing returns nothing
        local real returnDamage = Damage.index.damage
        local integer abilLvl = 0

        if GetUnitCustomState(DamageSource, BONUS_MISSCHANCE) > 0 and GetRandomReal(0, 100) > GetUnitCustomState(DamageSource, BONUS_MISSCHANCE) then
            return
        endif

        //Scorched Earth
        if GetUnitAbilityLevel(DamageSource, 'B027') > 0 then
            if GetRandomReal(0, 100) > GetHeroLevel(PlayerHeroes[ScorchedEarthSource[GetHandleId(DamageSource)]]) * 0.5 then
                return
            endif
        endif

        if GetUnitCustomState(DamageTarget, BONUS_EVASION) > 0 and GetRandomReal(0, 100) > GetEvasionChance() * 100 then
            return
        else

            //Fan
            if UnitHasItemType(DamageTarget,'I08Z') and BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A0DC') == 0 then
                call ActivateFan(DamageTarget)
            endif

            //Lucky Pants
            if UnitHasItemType(DamageTarget, LUCKY_PANTS_ITEM_ID) then
                call ActivateLuckyPants(DamageTarget)
            endif

            //Trickster
            if DamageTargetTypeId == SATYR_TRICKSTER_UNIT_ID and GetRandomReal(0,100) <= 50 * GetUnitCustomState(DamageTarget, BONUS_LUCK) then
                //set TypeDmg_b = 2
                //set DamageIsAttack = true
                //set GLOB_typeDmg = 2
                //set udg_NextDamageIsAttack = true
                set udg_NextDamageType = DamageType_Onhit
                set udg_NextDamageAbilitySource = SATYR_TRICKSTER_UNIT_ID
                call Damage.applyPhys(DamageTarget, DamageSource, GetAttackDamage(DamageTarget) * (0.5 + (0.01 * GetHeroLevel(DamageTarget))), true, false, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            endif
        endif

        //Trueshot aura
        set abilLvl = GetUnitAbilityLevel(DamageSourceHero, TRUESHOT_AURA_ABILITY_ID)
        if abilLvl > 0 then
            set returnDamage = returnDamage * (0.005 * abilLvl)
            set DamageIsTrue = true
        endif

        //Speed Blade and Arcane infused sword 
        if (UnitHasItemType(DamageSource, SPEED_BLADE_ITEM_ID) or UnitHasItemType(DamageSource, ARCANE_INFUSED_SWORD_ITEM_ID)) and GetUnitAbilityLevel(DamageSourceHero, TRUESHOT_AURA_ABILITY_ID) == 0 then
            set returnDamage = returnDamage * 0.1
            set DamageIsTrue = true
        endif

        call EvasionCheck(returnDamage)
    endfunction
endlibrary