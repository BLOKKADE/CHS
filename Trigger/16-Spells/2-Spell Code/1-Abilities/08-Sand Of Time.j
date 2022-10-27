library SandOfTime requires RandomShit
    function ResetSpell takes unit hero, integer SpellId, real time, boolean earthBonus returns nothing
        local real cur_time
            
        if earthBonus and IsSpellElement(hero, SpellId,Element_Earth) then
            set cur_time = time * 2
        else
            set cur_time = time
        endif 

        if BlzGetUnitAbilityCooldownRemaining(hero,SpellId) - cur_time > 0 then
            call BlzStartUnitAbilityCooldown(hero,SpellId,BlzGetUnitAbilityCooldownRemaining(hero,SpellId)- cur_time )
        else
            call BlzEndUnitAbilityCooldown(hero,SpellId)
        endif
    endfunction

    function SandRefreshAbility takes unit hero, real time returns nothing
        local integer i1 = 0
        local integer SpellId = 0
        local integer dummyAbilId = 0
    
        loop
            exitwhen i1 > 10
            set SpellId = GetInfoHeroSpell(hero ,i1)
            if SpellId != 0 and IsSpellResettable(SpellId) then
                call ResetSpell(hero, CheckAssociatedSpell(hero, SpellId), time, true)
            endif
            set i1 = i1 + 1
        endloop

        //Ogre Warrior
        if GetUnitTypeId(hero) == OGRE_WARRIOR_UNIT_ID then
            call ResetSpell(hero, 'A08U', time, true)
        endif

        //Pit Lord
        /*if GetUnitTypeId(hero) == PIT_LORD_UNIT_ID then
            call ResetSpell(hero, 'A08V', time, true)
        endif*/

        //Centaur
        if GetUnitTypeId(hero) == CENTAUR_ARCHER_UNIT_ID then
            call ResetSpell(hero, 'A08T', time, true)
        endif

        //Thunder Witch
        if GetUnitTypeId(hero) == THUNDER_WITCH_UNIT_ID then
            call ResetSpell(hero, 'A08P', time, true)
        endif

        //Lich
        if GetUnitTypeId(hero) == LICH_UNIT_ID then
            call ResetSpell(hero, 'A08W', time, true)
        endif
    endfunction
endlibrary