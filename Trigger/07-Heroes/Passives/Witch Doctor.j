library WitchDoctor initializer init requires Table, AbsoluteElements, HeroLvlTable, CustomState, AbsoluteLimit
    globals
        HashTable WitchDoctorAbsoluteLevel
    endglobals

    function GetWitchDoctorAbsoluteLevel takes unit u, integer elementId returns integer
        return WitchDoctorAbsoluteLevel[GetHandleId(u)].integer[elementId]
    endfunction

    function AddWitchDoctorAbsoluteLevel takes unit u, integer elementId returns nothing
        set WitchDoctorAbsoluteLevel[GetHandleId(u)].integer[elementId] = WitchDoctorAbsoluteLevel[GetHandleId(u)].integer[elementId] + 1
        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,(GetFullElementText(elementId) + " |cffffcc00bonus acquired"))
    endfunction
    
    function WitchDoctorHasAbsolute takes unit u, integer elementId returns boolean
        return GetUnitAbilityLevel(u, GetElementAbsolute(elementId)) > 0
    endfunction

    function WitchDoctorLevelup takes unit u, integer prevLevel, integer heroLevel returns nothing
        local integer i = prevLevel
        local integer j = 0

        loop
            if ModuloInteger(i, 25) == 0 then
                call AddHeroMaxAbsoluteAbility(u)
                call UpdateBonus(u, 0, 1)
            endif

            if ModuloInteger(i, 30) == 0 then
                set j = 0
                loop
                    set j = j + 1
                    exitwhen j > 15

                    if WitchDoctorHasAbsolute(u, j) then
                        call AddWitchDoctorAbsoluteLevel(u, j)
                    endif                
                endloop
            endif

            set i = i + 1
            exitwhen i >= heroLevel
        endloop
    endfunction

    private function init takes nothing returns nothing
        set WitchDoctorAbsoluteLevel = HashTable.create()
    endfunction
endlibrary