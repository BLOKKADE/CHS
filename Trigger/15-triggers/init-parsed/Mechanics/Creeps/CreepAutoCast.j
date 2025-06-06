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
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
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
            if (GetUnitAbilityLevel(creep, 'A01A') > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
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

            // Shockwave
            if (GetUnitAbilityLevel(creep, SHOCKWAVE_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
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

            // Hurl boulder
            if (GetUnitAbilityLevel(creep, HURL_BOULDER_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
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

            // Rejuvination
            if (GetUnitAbilityLevel(creep, REJUVENATION_CREEP_ABILITY_ID) > 0) then
                set RoundCreepAbilCastChance = GetRandomInt(1, 5)
                if (RoundCreepAbilCastChance == 1) then
                    if (GameModeShort == true) then
                        call SetUnitAbilityLevel(creep, REJUVENATION_CREEP_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, REJUVENATION_CREEP_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
                    endif

                    // Cast rejuvination on ally creep
                    set tempGroup = GetUnitsInRangeOfLocMatching(400.00, creepLocation, Condition(function RejuvinationUnitFilter))
                    call IssueTargetOrder(creep, "rejuvination", GroupPickRandomUnit(tempGroup))

                    // Cleanup
                    call DestroyGroup(tempGroup)
                endif
            endif

            // Slow
            if (GetUnitAbilityLevel(creep, 'A013') > 0) then
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
            if (GetUnitAbilityLevel(creep, 'A018') > 0 and (not UnitHasBuffBJ(creep, 'BOvd'))) then
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
                        call SetUnitAbilityLevel(creep, FAERIE_FIRE_CREEP_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, FAERIE_FIRE_CREEP_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
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
                        call SetUnitAbilityLevel(creep, THUNDER_CLAP_CREEP_ABILITY_ID, ((RoundNumber * 4) / RoundCreepNumber))
                    else
                        call SetUnitAbilityLevel(creep, THUNDER_CLAP_CREEP_ABILITY_ID, (((RoundNumber * 4) / RoundCreepNumber) / 2))
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
