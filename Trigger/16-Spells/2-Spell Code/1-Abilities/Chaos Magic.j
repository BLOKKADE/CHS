library ChaosMagic requires UnitHelpers, AbilityData, CastSpellOnTarget, RandomShit
    globals
        location RandomSpellLoc
    endglobals

    function CastRandomSpell takes unit caster, integer abilCast, unit target, location spellLoc, boolean banInstant, integer chaosLevel returns nothing
        local real    targetX
        local real    targetY
        local integer orderType = 0
        local integer abilId
        local integer ally = Target_Enemy

        if target != null and IsUnitTargettable(target) then
            set orderType = Order_Target
            set targetX = GetUnitX(target)
            set targetY = GetUnitY(target)
            if abilCast != 0 and GetAbilityTargetType(abilCast) then
                set ally = Target_Ally
            else
                set ally = Target_Enemy
            endif
            set abilId = GetRandomChaosAbility(Order_Target, ally)
            call CreateTextTagTimerColor(GetObjectName(abilId) + "!?", 1, GetUnitX(caster), GetUnitY(caster), 50, 1, GetRandomInt(100,255), GetRandomInt(100,255),GetRandomInt(100,255))
            call CastSpell(caster, target, abilId, chaosLevel, orderType, targetX, targetY).activate()
        else
            set orderType = 1
            if spellLoc == null and banInstant == false then
                set orderType = Order_Instant
                set targetX = GetUnitX(caster)
                set targetY = GetUnitY(caster)
                set abilId = GetRandomChaosAbility(Order_Instant, ally) 
            else
                set orderType = Order_Point
                set targetX = GetLocationX(spellLoc)
                set targetY = GetLocationY(spellLoc)
                set abilId = GetRandomChaosAbility(Order_Point, ally)
            endif
            call CreateTextTagTimerColor(GetObjectName(abilId) + "!?", 1, GetUnitX(caster), GetUnitY(caster), 50, 1, GetRandomInt(100,255), GetRandomInt(100,255),GetRandomInt(100,255))
            call CastSpell(caster, null, abilId, chaosLevel, orderType, targetX, targetY).activate()
        endif
    endfunction
endlibrary