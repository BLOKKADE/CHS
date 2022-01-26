library ElementDamage requires RandomShit, Pyromancer
    function ElementalDamage takes nothing returns nothing
        local integer spellType = 0
        local integer unitTypeId = GetUnitTypeId(DamageSource)
        
        local integer i = 0

        local real r1 = 0
        local integer i1 = 0

        //Dousing Hex
        if GetUnitAbilityLevel(DamageSource, DOUSING_HEX_BUFF_ID) > 0 and IsSpellElement(DamageSource, DamageSourceAbility, Element_Fire) then
            set Damage.index.damage = Damage.index.damage * DousingHexReduction.real[DamageSourceId]
        endif

        //Absolute Poison
        set i = GetUnitAbilityLevel(DamageSource, ABSOLUTE_POISON_ABILITY_ID)
        if i > 0 and IsSpellElement(DamageSource, DamageSourceAbility, Element_Poison) then
            set Damage.index.damage = Damage.index.damage * (1 + ((i * 0.01) * GetClassUnitSpell(DamageSource, Element_Poison)))
        endif

        //Tauren
        if unitTypeId == TAUREN_UNIT_ID then
            
            set i1 = GetHeroLevel(DamageSource)
            loop
                if IsSpellElement(DamageSource, DamageSourceAbility, i) then
                    set r1 = r1 + ((0.05 + (0.0005 * i1)) * GetSpellElementCount(DamageSource, DamageSourceAbility, i))
                endif
                set i = i + 1
                exitwhen i > 12
            endloop

            set Damage.index.damage = Damage.index.damage * (1 + r1)
        
        //Pyromancer
        elseif unitTypeId == PYROMANCER_UNIT_ID  and IsSpellElement(DamageSource, DamageSourceAbility, Element_Fire) then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A0B6') == 0 then
                call CreateScorches(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 149 + (1 * GetHeroLevel(DamageSource)))
            endif
        
        //Ogre Warrior
        elseif unitTypeId == OGRE_WARRIOR_UNIT_ID and DamageSourceAbility != 'A047' and (Damage.index.damageType == DAMAGE_TYPE_NORMAL or IsSpellElement(DamageSource, DamageSourceAbility, Element_Earth)) then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08U') <= 0 then
                call ElemFuncStart(DamageSource,OGRE_WARRIOR_UNIT_ID)
                call CheckProc(DamageSource, 400)
                set r1 = 6 - (0.5 * GetProcCheckCount())
                if r1 > 0 then
                    call AbilStartCD(DamageSource, 'A08U', 6)
                endif
                call USOrder4field(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 'A047', "stomp", GetHeroStr(DamageSource,true) + (60 * GetHeroLevel(DamageSource)), ABILITY_RLF_DAMAGE_INCREASE, 400, ABILITY_RLF_CAST_RANGE, 1, ABILITY_RLF_DURATION_HERO, 1, ABILITY_RLF_DURATION_NORMAL)
            endif

        //Lich
        elseif unitTypeId == LICH_UNIT_ID  and (IsSpellElement(DamageSource, DamageSourceAbility, Element_Cold) or IsSpellElement(DamageSource, DamageSourceAbility, Element_Dark) or IsSpellElement(DamageSource, DamageSourceAbility, Element_Water)) and GetRandomInt(1, 100) < 25 * DamageSourceLuck then
            call ElemFuncStart(DamageSource,LICH_UNIT_ID)
            call UsOrderU2 (DamageSource,DamageTarget,GetUnitX(DamageSource),GetUnitY(DamageSource),'A03J',"frostnova", GetHeroInt(DamageSource, true) + (GetHeroLevel(DamageSource)* 60), GetHeroInt(DamageSource, true) * (1 + (0.01 * GetHeroLevel(DamageSource))), ABILITY_RLF_AREA_OF_EFFECT_DAMAGE,ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2)
        endif
    endfunction
endlibrary