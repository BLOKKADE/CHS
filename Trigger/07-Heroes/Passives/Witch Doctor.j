library WitchDoctor initializer init requires Table, AbsoluteElements, HeroLvlTable, CustomState, AbsoluteLimit

    globals
        HashTable WitchDoctorAbsoluteLevel
        HashTable WitchDoctorAssignedElements
    endglobals

    function GetWitchDoctorAbsoluteLevel takes unit u, integer elementId returns integer
        return WitchDoctorAbsoluteLevel[GetHandleId(u)].integer[elementId]
    endfunction

    function AddWitchDoctorAbsoluteLevel takes unit u, integer elementId returns nothing
        set WitchDoctorAbsoluteLevel[GetHandleId(u)].integer[elementId] = WitchDoctorAbsoluteLevel[GetHandleId(u)].integer[elementId] + 1
        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10, GetFullElementText(elementId) + " |cffffcc00bonus acquired")
    endfunction

    function WitchDoctorHasAbsolute takes unit u, integer elementId returns boolean
        return GetUnitAbilityLevel(u, GetElementAbsolute(elementId)) > 0
    endfunction

    function WitchDoctorLevelup takes unit u, integer prevLevel, integer heroLevel returns nothing
        local integer i = prevLevel + 1
        local integer j
        local integer poolSize = 11
        local integer index
        local integer abilityId
        local boolean found
        local integer attempts
        local integer elementId

        // Simulated ability pool
        local integer a0 = ABSOLUTE_ARCANE_ABILITY_ID
        local integer a1 = ABSOLUTE_BLOOD_ABILITY_ID
        local integer a2 = ABSOLUTE_COLD_ABILITY_ID 
        local integer a3 = ABSOLUTE_DARK_ABILITY_ID
        local integer a4 = ABSOLUTE_EARTH_ABILITY_ID
        local integer a5 = ABSOLUTE_FIRE_ABILITY_ID
        local integer a6 = ABSOLUTE_LIGHT_ABILITY_ID 
        local integer a7 = ABSOLUTE_POISON_ABILITY_ID
        local integer a8 = ABSOLUTE_WILD_ABILITY_ID  
        local integer a9 = ABSOLUTE_WIND_ABILITY_ID
        local integer a10 = ABSOLUTE_WATER_ABILITY_ID

        // Normal level-up logic
        loop
            if ModuloInteger(i, 25) == 0 then
                call UpdateBonus(u, 0, 1)

                set found = false
                set attempts = 0
                loop
                    set index = GetRandomInt(0, poolSize - 1)
                    if index == 0 then
                        set abilityId = a0
                    elseif index == 1 then
                        set abilityId = a1
                    elseif index == 2 then
                        set abilityId = a2
                    elseif index == 3 then
                        set abilityId = a3
                    elseif index == 4 then
                        set abilityId = a4
                    elseif index == 5 then
                        set abilityId = a5
                    elseif index == 6 then
                        set abilityId = a6
                    elseif index == 7 then
                        set abilityId = a7
                    elseif index == 8 then
                        set abilityId = a8
                    elseif index == 9 then
                        set abilityId = a9
                    elseif index == 10 then
                        set abilityId = a10
                    endif

                    set elementId = 1
                    loop
                        exitwhen elementId > 10
                        if GetElementAbsolute(elementId) == abilityId then
                            exitwhen true
                        endif
                        set elementId = elementId + 1
                    endloop

                    if GetUnitAbilityLevel(u, abilityId) == 0 and WitchDoctorAssignedElements[GetHandleId(u)].boolean[elementId] == false then
                        call UnitAddAbility(u, abilityId)
                        call SetUnitAbilityLevel(u, abilityId, 1)
                        call BlzUnitDisableAbility(u, abilityId, false, true)
                        call UpdateHeroSpellList(abilityId, u, 1)
                        call SaveInteger(HT, GetHandleId(u), abilityId, 1)
                        set WitchDoctorAssignedElements[GetHandleId(u)].boolean[elementId] = true

                        // Notify player of learned element
                        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10, GetFullElementText(elementId) + " absolute ability |cffffcc00acquired.|r")

                        set found = true
                    endif

                    set attempts = attempts + 1
                    exitwhen found or attempts > 50
                endloop
            endif

            if ModuloInteger(i, 30) == 0 then
                set j = 1
                loop
                    exitwhen j > 15
                    if WitchDoctorHasAbsolute(u, j) then
                        call AddWitchDoctorAbsoluteLevel(u, j)
                    endif
                    set j = j + 1
                endloop
            endif

            set i = i + 1
            exitwhen i > heroLevel
        endloop
    endfunction

    private function init takes nothing returns nothing
        set WitchDoctorAbsoluteLevel = HashTable.create()
        set WitchDoctorAssignedElements = HashTable.create()
    endfunction

endlibrary
