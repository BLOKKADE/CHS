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
        endif
    endfunction
endlibrary