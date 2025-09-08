library CreepAutoCast initializer init requires RandomShit

    private function ManaBurnUnitFilter takes nothing returns boolean
        local unit filterUnit = GetFilterUnit()
        local boolean isValidUnit = (UnitAlive(filterUnit) == true) and (IsUnitType(filterUnit, UNIT_TYPE_MAGIC_IMMUNE) != true) and (IsUnitEnemy(filterUnit, GetOwningPlayer(GetEnumUnit())) == true) and (GetUnitState(filterUnit, UNIT_STATE_MANA) >= 10.00)
        
        // Cleanup
        set filterUnit = null

        return isValidUnit
    endfunction
    
    private function BlinkUnitFilter takes nothing returns boolean
        local unit filterUnit = GetFilterUnit()
        local player creepOwningPlayer = GetOwningPlayer(GetEnumUnit())
        local boolean isValidUnit = (UnitAlive(filterUnit) == true) and (IsUnitType(filterUnit, UNIT_TYPE_GROUND) == true) and (IsUnitEnemy(filterUnit, creepOwningPlayer) == true) and (IsUnitType(filterUnit, UNIT_TYPE_HERO) == true) and (IsUnitVisible(filterUnit, creepOwningPlayer) == true)
        
        // Cleanup
        set filterUnit = null
        set creepOwningPlayer = null

        return isValidUnit
    endfunction
    
    private function ShockwaveUnitFilter takes nothing returns boolean
        local unit filterUnit = GetFilterUnit()
        local player creepOwningPlayer = GetOwningPlayer(GetEnumUnit())
        local boolean isValidUnit = (UnitAlive(filterUnit) == true) and (IsUnitType(filterUnit, UNIT_TYPE_MAGIC_IMMUNE) != true) and (IsUnitType(filterUnit, UNIT_TYPE_GROUND) == true) and (IsUnitEnemy(filterUnit, creepOwningPlayer) == true) and (IsUnitVisible(filterUnit, creepOwningPlayer) == true)
    
        // Cleanup
        set filterUnit = null
        set creepOwningPlayer = null

        return isValidUnit
    endfunction
    
    private function HurlBoulderUnitFilter takes nothing returns boolean
        local unit filterUnit = GetFilterUnit()
        local boolean isValidUnit = (UnitAlive(filterUnit) == true) and (IsUnitType(filterUnit, UNIT_TYPE_MAGIC_IMMUNE) != true) and (IsUnitEnemy(filterUnit, GetOwningPlayer(GetEnumUnit())) == true)

        // Cleanup
        set filterUnit = null

        return isValidUnit
    endfunction
    
    private function RejuvinationUnitFilter takes nothing returns boolean
        local unit filterUnit = GetFilterUnit()
        local boolean isValidUnit = (UnitAlive(filterUnit) == true) and (IsUnitType(filterUnit, UNIT_TYPE_MAGIC_IMMUNE) != true) and (IsUnitAlly(filterUnit, GetOwningPlayer(GetEnumUnit())) == true) and (GetUnitLifePercent(filterUnit) <= 75.00)
        
        // Cleanup
        set filterUnit = null
        
        return isValidUnit
    endfunction

    private function BloodlustUnitFilter takes nothing returns boolean
        local unit filterUnit = GetFilterUnit()
        local boolean isValidUnit = (UnitAlive(filterUnit) == true) and (IsUnitType(filterUnit, UNIT_TYPE_MAGIC_IMMUNE) != true) and (IsUnitAlly(filterUnit, GetOwningPlayer(GetEnumUnit())) == true)
        
        // Cleanup
        set filterUnit = null
        
        return isValidUnit
    endfunction
    
    private function SlowUnitFilter takes nothing returns boolean
        local unit filterUnit = GetFilterUnit()
        local boolean isValidUnit = (UnitAlive(filterUnit) == true) and (IsUnitType(filterUnit, UNIT_TYPE_MAGIC_IMMUNE) != true) and (IsUnitEnemy(filterUnit, GetOwningPlayer(GetEnumUnit())) == true)

        // Cleanup
        set filterUnit = null
        
        return isValidUnit
    endfunction
    
    private function VoodooUnitFilter takes nothing returns boolean
        return (UnitAlive(GetFilterUnit()) == true) and (GetOwningPlayer(GetFilterUnit()) == GetOwningPlayer(GetEnumUnit()))
    endfunction
    
    private function FaerieFireUnitFilter takes nothing returns boolean
        local unit filterUnit = GetFilterUnit()
        local boolean isValidUnit = (UnitAlive(filterUnit) == true) and (IsUnitType(filterUnit, UNIT_TYPE_MAGIC_IMMUNE) != true) and (IsUnitEnemy(filterUnit, GetOwningPlayer(GetEnumUnit())) == true)

        // Cleanup
        set filterUnit = null

        return isValidUnit
    endfunction
    
    private function ThunderClapUnitFilter takes nothing returns boolean
        local unit filterUnit = GetFilterUnit()
        local player creepOwningPlayer = GetOwningPlayer(GetEnumUnit())
        local boolean isValidUnit = (UnitAlive(filterUnit) == true) and (IsUnitType(filterUnit, UNIT_TYPE_MAGIC_IMMUNE) != true) and (IsUnitType(filterUnit, UNIT_TYPE_GROUND) == true) and (IsUnitEnemy(filterUnit, creepOwningPlayer) == true) and (IsUnitVisible(filterUnit, creepOwningPlayer) == true)

        // Cleanup
        set filterUnit = null
        set creepOwningPlayer = null

        return isValidUnit
    endfunction
    
    private function CreepAutoCastAction takes nothing returns nothing
        local unit creep = GetEnumUnit()
        local location creepLocation
        local location randomUnitLocation
        local location offsetLocation
        local group tempGroup

        if (UnitAlive(creep) == true) then
            set creepLocation = GetUnitLoc(creep)
    
            // Mana burn
            if (GetUnitAbilityLevel(creep, MANA_BURN_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 3)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, MANA_BURN_CREEP_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, MANA_BURN_CREEP_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    // Use mana burn on random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(300.00, creepLocation, Condition(function ManaBurnUnitFilter))
                    call IssueTargetOrder(creep, "manaburn", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Blink
            if (GetUnitAbilityLevel(creep, BLINK_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 4)
                if (RoundCreepAbilCastChance == 1) then
                    // Blink to random unit with an offset
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function BlinkUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))
                    set offsetLocation = OffsetLocation(randomUnitLocation, GetRandomReal(-100.00, 100.00), GetRandomReal(-100.00, 100.00))

                    call IssuePointOrderLoc(creep, "blink", offsetLocation)
                    
                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                    call RemoveLocation(offsetLocation)
                endif
            endif

            // Healing Wave
            if (GetUnitAbilityLevel(creep, HEALING_WAVE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 2)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, HEALING_WAVE_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, HEALING_WAVE_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    // Cast healing wave on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(400.00, creepLocation, Condition(function RejuvinationUnitFilter))
                    call IssueTargetOrder(creep, "healingwave", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Rain of Fire
            if (GetUnitAbilityLevel(creep, RAIN_OF_FIRE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 4)
                if (RoundCreepAbilCastChance == 1) then
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function BlinkUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))
                    set offsetLocation = OffsetLocation(randomUnitLocation, GetRandomReal(-100.00, 100.00), GetRandomReal(-100.00, 100.00))

                    call IssuePointOrderLoc(creep, "rainoffire", offsetLocation)
                    
                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                    call RemoveLocation(offsetLocation)
                endif
            endif

            // Blizzard
            if (GetUnitAbilityLevel(creep, BLIZZARD_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 6)
                if (RoundCreepAbilCastChance == 1) then
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function BlinkUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))
                    set offsetLocation = OffsetLocation(randomUnitLocation, GetRandomReal(-100.00, 100.00), GetRandomReal(-100.00, 100.00))

                    call IssuePointOrderLoc(creep, "blizzard", offsetLocation)
                    
                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                    call RemoveLocation(offsetLocation)
                endif
            endif

            // Cyclone
            if (GetUnitAbilityLevel(creep, CYCLONE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 6)
                if (RoundCreepAbilCastChance == 1) then
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function BlinkUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))
                    set offsetLocation = OffsetLocation(randomUnitLocation, GetRandomReal(-100.00, 100.00), GetRandomReal(-100.00, 100.00))

                    call IssuePointOrderLoc(creep, "cyclone", offsetLocation)
                    
                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                    call RemoveLocation(offsetLocation)
                endif
            endif

            // Stasis Trap
            if (GetUnitAbilityLevel(creep, STASIS_TRAP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 10)
                if (RoundCreepAbilCastChance == 1) then
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function BlinkUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))
                    set offsetLocation = OffsetLocation(randomUnitLocation, GetRandomReal(-100.00, 100.00), GetRandomReal(-100.00, 100.00))

                    call IssuePointOrderLoc(creep, "stasistrap", offsetLocation)
                    
                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                    call RemoveLocation(offsetLocation)
                endif
            endif

            // Death and Decay
            if (GetUnitAbilityLevel(creep, DEATH_AND_DECAY_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 4)
                if (RoundCreepAbilCastChance == 1) then
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function BlinkUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))
                    set offsetLocation = OffsetLocation(randomUnitLocation, GetRandomReal(-100.00, 100.00), GetRandomReal(-100.00, 100.00))

                    call IssuePointOrderLoc(creep, "deathanddecay", offsetLocation)
                    
                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                    call RemoveLocation(offsetLocation)
                endif
            endif

            // Silence
            if (GetUnitAbilityLevel(creep, SILENCE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 4)
                if (RoundCreepAbilCastChance == 1) then
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function BlinkUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))
                    set offsetLocation = OffsetLocation(randomUnitLocation, GetRandomReal(-100.00, 100.00), GetRandomReal(-100.00, 100.00))

                    call IssuePointOrderLoc(creep, "silence", offsetLocation)
                    
                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                    call RemoveLocation(offsetLocation)
                endif
            endif

            // Shockwave
            if (GetUnitAbilityLevel(creep, SHOCKWAVE_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 4)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, SHOCKWAVE_CREEP_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, SHOCKWAVE_CREEP_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    // Use shockwave on random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function ShockwaveUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))

                    call IssuePointOrderLoc(creep, "shockwave", randomUnitLocation)

                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                endif
            endif

            // Icy Breath
            if (GetUnitAbilityLevel(creep, ICY_BREATH_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 6)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, ICY_BREATH_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, ICY_BREATH_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    // Use icy breath on random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(400.00, creepLocation, Condition(function ShockwaveUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))

                    call IssuePointOrderLoc(creep, "breathoffire", randomUnitLocation)

                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                endif
            endif

            // Crushing wave
            if (GetUnitAbilityLevel(creep, CARRION_SWARM_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 4)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, CARRION_SWARM_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, CARRION_SWARM_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function ShockwaveUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))

                    call IssuePointOrderLoc(creep, "carrionswarm", randomUnitLocation)

                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                endif
            endif

            // Impale
            if (GetUnitAbilityLevel(creep, IMPALE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 4)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, IMPALE_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, IMPALE_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function ShockwaveUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))

                    call IssuePointOrderLoc(creep, "impale", randomUnitLocation)

                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                endif
            endif

            // Carrion Swarm
            if (GetUnitAbilityLevel(creep, CRUSHING_WAVE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 4)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, CRUSHING_WAVE_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, CRUSHING_WAVE_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    // Use carrionswarm on random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function ShockwaveUnitFilter))
                    set randomUnitLocation = GetUnitLoc(GroupPickRandomUnit(tempGroup))

                    call IssuePointOrderLoc(creep, "carrionswarm", randomUnitLocation)

                    // Cleanup
                    call DestroyGroup(tempGroup)
                    call RemoveLocation(randomUnitLocation)
                endif
            endif

            // Hurl boulder
            if (GetUnitAbilityLevel(creep, HURL_BOULDER_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 4)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, HURL_BOULDER_CREEP_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, HURL_BOULDER_CREEP_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    // Hurl boulder to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "creepthunderbolt", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Shadow Strike
            if (GetUnitAbilityLevel(creep, SHADOW_STRIKE_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 2)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, SHADOW_STRIKE_CREEP_ABILITY_ID, R2I(RoundNumber * 0.8))
                    else
                        call SetUnitAbilityLevel(creep, SHADOW_STRIKE_CREEP_ABILITY_ID, R2I(RoundNumber * 0.4))
                    endif

                    // Shadow Strike to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "shadowstrike", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Entangling Roots
            if (GetUnitAbilityLevel(creep, ENTAGLING_ROOTS_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 9)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, ENTAGLING_ROOTS_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, ENTAGLING_ROOTS_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "entanglingroots", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Finger of Death
            if (GetUnitAbilityLevel(creep, FINGER_OF_DEATH_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, FINGER_OF_DEATH_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, FINGER_OF_DEATH_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "fingerofdeath", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Finger of Pain
            if (GetUnitAbilityLevel(creep, FINGEROFPAIN_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, FINGEROFPAIN_CREEP_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, FINGEROFPAIN_CREEP_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "fingerofdeath", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Soul burn
            if (GetUnitAbilityLevel(creep, SOUL_BURN_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, SOUL_BURN_ABILITY_ID, R2I(RoundNumber * 0.4))
                    else
                        call SetUnitAbilityLevel(creep, SOUL_BURN_ABILITY_ID, R2I(RoundNumber * 0.2))
                    endif

                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "soulburn", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Banish
            if (GetUnitAbilityLevel(creep, BANISH_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 15)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, BANISH_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, BANISH_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "banish", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Frost Nova
            if (GetUnitAbilityLevel(creep, FROST_NOVA_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 2)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, FROST_NOVA_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, FROST_NOVA_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Frost Nova to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "frostnova", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Storm Bolt
            if (GetUnitAbilityLevel(creep, STORM_BOLT_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 7)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, STORM_BOLT_ABILITY_ID, R2I(RoundNumber * 0.6))
                    else
                        call SetUnitAbilityLevel(creep, STORM_BOLT_ABILITY_ID, R2I(RoundNumber * 0.3))
                    endif

                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "thunderbolt", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Ensnare
            if (GetUnitAbilityLevel(creep, ENSNARE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, ENSNARE_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, ENSNARE_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    // Shadow Strike to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "ensnare", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Purge
            if (GetUnitAbilityLevel(creep, PURGE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, PURGE_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, PURGE_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    // Purge to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "slow", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Chain Lightning
            if (GetUnitAbilityLevel(creep, CHAIN_LIGHTNING_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, CHAIN_LIGHTNING_ABILITY_ID, R2I(RoundNumber * 0.8))
                    else
                        call SetUnitAbilityLevel(creep, CHAIN_LIGHTNING_ABILITY_ID, R2I(RoundNumber * 0.4))
                    endif

                    // Chain Lightning to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "chainlightning", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Cripple
            if (GetUnitAbilityLevel(creep, CRIPPLE_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, CRIPPLE_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, CRIPPLE_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cripple to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "cripple", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Holy Light on enemies
            if (GetUnitAbilityLevel(creep, HOLY_LIGHT_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 6)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, HOLY_LIGHT_ABILITY_ID, R2I(RoundNumber * 0.8))
                    else
                        call SetUnitAbilityLevel(creep, HOLY_LIGHT_ABILITY_ID, R2I(RoundNumber * 0.4))
                    endif

                    // holy light to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "holybolt", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Sleep
            if (GetUnitAbilityLevel(creep, SLEEP_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, SLEEP_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, SLEEP_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Sleep to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "sleep", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Frost bolt
            if (GetUnitAbilityLevel(creep, FROSTBOLT_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, FROSTBOLT_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, FROSTBOLT_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Sleep to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "thunderbolt", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Hex
            if (GetUnitAbilityLevel(creep, HEX_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, HEX_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, HEX_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Hex to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "hex", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Death Coil
            if (GetUnitAbilityLevel(creep, DEATHCOIL_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, DEATHCOIL_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, DEATHCOIL_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Death Coil to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "deathcoil", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Firebolt
            if (GetUnitAbilityLevel(creep, FIREBOLT_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, FIREBOLT_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, FIREBOLT_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Firebolt to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "firebolt", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Aerial Shackles
            if (GetUnitAbilityLevel(creep, AERIALSHACKLES_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, AERIALSHACKLES_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, AERIALSHACKLES_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Aerial Shackles to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "magicleash", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Curse
            if (GetUnitAbilityLevel(creep, CURSE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, CURSE_ABILITY_ID, R2I(RoundNumber * 0.6))
                    else
                        call SetUnitAbilityLevel(creep, CURSE_ABILITY_ID, R2I(RoundNumber * 0.3))
                    endif

                    // Curse to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "curse", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Forked Lightning
            if (GetUnitAbilityLevel(creep, FORKED_LIGHTNING_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, FORKED_LIGHTNING_ABILITY_ID, R2I(RoundNumber * 0.4))
                    else
                        call SetUnitAbilityLevel(creep, FORKED_LIGHTNING_ABILITY_ID, R2I(RoundNumber * 0.8))
                    endif

                    // Forked Lightning to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function HurlBoulderUnitFilter))

                    call IssueTargetOrder(creep, "forkedlightning", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Random Spell
            /*if (GetUnitAbilityLevel(creep, RANDOM_SPELL_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 3)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, RANDOM_SPELL_ABILITY_ID, RoundNumber * 1)
                    else
                        call SetUnitAbilityLevel(creep, RANDOM_SPELL_ABILITY_ID, RoundNumber * 2)
                    endif

                    // Random Spell to random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(400.00, creepLocation, Condition(function SlowUnitFilter))

                    call IssueTargetOrder(creep, "slow", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif*/

            // Rejuvination
            if (GetUnitAbilityLevel(creep, REJUVENATION_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, REJUVENATION_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, REJUVENATION_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast rejuvination on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(400.00, creepLocation, Condition(function RejuvinationUnitFilter))
                    call IssueTargetOrder(creep, "rejuvination", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Holy Light on allies
            if (GetUnitAbilityLevel(creep, HOLY_LIGHT_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, HOLY_LIGHT_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, HOLY_LIGHT_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast holy light on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(400.00, creepLocation, Condition(function RejuvinationUnitFilter))
                    call IssueTargetOrder(creep, "holybolt", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Bloodlust
            if (GetUnitAbilityLevel(creep, BLOODLUST_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 1)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, BLOODLUST_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, BLOODLUST_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast Bloodlust on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(600.00, creepLocation, Condition(function BloodlustUnitFilter))
                    call IssueTargetOrder(creep, "bloodlust", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Inner Fire
            if (GetUnitAbilityLevel(creep, INNER_FIRE_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 1)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, INNER_FIRE_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, INNER_FIRE_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast inner fire on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(600.00, creepLocation, Condition(function BloodlustUnitFilter))
                    call IssueTargetOrder(creep, "innerfire", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Frost Armor
            if (GetUnitAbilityLevel(creep, FROST_ARMOR_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, FROST_ARMOR_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, FROST_ARMOR_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast frost armor on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(600.00, creepLocation, Condition(function BloodlustUnitFilter))
                    call IssueTargetOrder(creep, "frostarmor", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Lightning Shield
            if (GetUnitAbilityLevel(creep, LIGHTNING_SHIELD_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 1)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, LIGHTNING_SHIELD_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, LIGHTNING_SHIELD_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast lightning shield on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(600.00, creepLocation, Condition(function BloodlustUnitFilter))
                    call IssueTargetOrder(creep, "slow", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Guardian Spirit
            if (GetUnitAbilityLevel(creep, GUARDIAN_SPIRIT_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 1)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, GUARDIAN_SPIRIT_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, GUARDIAN_SPIRIT_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast guardian spirit on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(600.00, creepLocation, Condition(function BloodlustUnitFilter))
                    call IssueTargetOrder(creep, "rejuvination", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Anti-Magic Shell
            if (GetUnitAbilityLevel(creep, ANTI_MAGIC_SHEL_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 2)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, ANTI_MAGIC_SHEL_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, ANTI_MAGIC_SHEL_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast anti magic shell on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(600.00, creepLocation, Condition(function BloodlustUnitFilter))
                    call IssueTargetOrder(creep, "antimagicshell", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Divine Shield
            if (GetUnitAbilityLevel(creep, 'ACds') > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, 'ACds', R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, 'ACds', R2I(RoundNumber * 0.6))
                    endif
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function VoodooUnitFilter))

                    if (CountUnitsInGroup(tempGroup) > 1) then
                        call IssueImmediateOrder(creep, "divineshield")
                    endif

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Avatar
            if (GetUnitAbilityLevel(creep, ACTIVATE_AVATAR_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, ACTIVATE_AVATAR_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, ACTIVATE_AVATAR_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function VoodooUnitFilter))

                    if (CountUnitsInGroup(tempGroup) > 1) then
                        call IssueImmediateOrder(creep, "avatar")
                    endif

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Tranquility
            if (GetUnitAbilityLevel(creep, TRANQUILITY_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, TRANQUILITY_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, TRANQUILITY_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function VoodooUnitFilter))

                    if (CountUnitsInGroup(tempGroup) > 1) then
                        call IssueImmediateOrder(creep, "tranquility")
                    endif

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Slow
            if (GetUnitAbilityLevel(creep, SLOW_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    // Cast slow on a random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(600.00, creepLocation, Condition(function SlowUnitFilter))

                    call IssueTargetOrder(creep, "slow", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Voodoo
            if (GetUnitAbilityLevel(creep, BIGBADVOODOO_CREEP_ABILITY_ID) > 0 and (not UnitHasBuffBJ(creep, 'BOvd'))) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    // Cast voodoo if there is an ally nearby
                    set tempGroup = GetUnitsInRangeOfLocMatching(800.00, creepLocation, Condition(function VoodooUnitFilter))

                    if (CountUnitsInGroup(tempGroup) > 1) then
                        call IssueImmediateOrder(creep, "voodoo")
                    endif

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Faerie fire
            if (GetUnitAbilityLevel(creep, FAERIE_FIRE_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, FAERIE_FIRE_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, FAERIE_FIRE_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast Faerie fire on a random unit
                    set tempGroup = GetUnitsInRangeOfLocMatching(700.00, creepLocation, Condition(function FaerieFireUnitFilter))

                    call IssueTargetOrder(creep, "faeriefire", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Thunder clap
            if (GetUnitAbilityLevel(creep, THUNDER_CLAP_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, THUNDER_CLAP_CREEP_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, THUNDER_CLAP_CREEP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast thunder clap if there is a unit nearby
                    set tempGroup = GetUnitsInRangeOfLocMatching(250.00, creepLocation, Condition(function ThunderClapUnitFilter))

                    if (CountUnitsInGroup(tempGroup) >= 1) then
                        call IssueImmediateOrder(creep, "thunderclap")
                    endif

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // War Stomp
            if (GetUnitAbilityLevel(creep, WAR_STOMP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, WAR_STOMP_ABILITY_ID, R2I(RoundNumber * 0.6))
                    else
                        call SetUnitAbilityLevel(creep, WAR_STOMP_ABILITY_ID, R2I(RoundNumber * 0.3))
                    endif

                    // Cast war stomp if there is a unit nearby
                    set tempGroup = GetUnitsInRangeOfLocMatching(250.00, creepLocation, Condition(function ThunderClapUnitFilter))

                    if (CountUnitsInGroup(tempGroup) >= 1) then
                        call IssueImmediateOrder(creep, "stomp")
                    endif

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Howl of Terror
            if (GetUnitAbilityLevel(creep, HOWL_OF_TERROR_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, HOWL_OF_TERROR_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, HOWL_OF_TERROR_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast howl of terror if there is a unit nearby
                    set tempGroup = GetUnitsInRangeOfLocMatching(250.00, creepLocation, Condition(function ThunderClapUnitFilter))

                    if (CountUnitsInGroup(tempGroup) >= 1) then
                        call IssueImmediateOrder(creep, "howlofterror")
                    endif

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Battle Roar
            if (GetUnitAbilityLevel(creep, BATTLE_ROAR_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, BATTLE_ROAR_ABILITY_ID, R2I(RoundNumber * 1.2))
                    else
                        call SetUnitAbilityLevel(creep, BATTLE_ROAR_ABILITY_ID, R2I(RoundNumber * 0.6))
                    endif

                    // Cast battle roar if there is a unit nearby
                    set tempGroup = GetUnitsInRangeOfLocMatching(250.00, creepLocation, Condition(function ThunderClapUnitFilter))

                    if (CountUnitsInGroup(tempGroup) >= 1) then
                        call IssueImmediateOrder(creep, "battleroar")
                    endif

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif
    
            // Cleanup
            set creepLocation = null
            set randomUnitLocation = null
            set offsetLocation = null
            set tempGroup = null
        endif

        // Cleanup
        set creep = null
    endfunction
    
    private function CreepAutoCastActions takes nothing returns nothing
        // Get all creep units
        local group creeps = GetUnitsOfPlayerMatching(Player(11), null)

        // Autocast!
        call ForGroup(creeps, function CreepAutoCastAction)

        // Cleanup
        call DestroyGroup(creeps)
        set creeps = null
    endfunction

    private function init takes nothing returns nothing
        set CreepAutoCastTrigger = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(CreepAutoCastTrigger, 1.00)
        call TriggerAddAction(CreepAutoCastTrigger, function CreepAutoCastActions)
    endfunction

endlibrary
