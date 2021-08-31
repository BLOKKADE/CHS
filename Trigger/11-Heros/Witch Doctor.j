library WitchDoctor initializer init requires Table, AbsoluteElements
    globals
        HashTable WitchDoctorAbsoluteLevel
    endglobals

    function GetWitchDoctorAbsoluteLevel takes unit u, integer elementId returns integer
        return WitchDoctorAbsoluteLevel[GetHandleId(u)].integer[elementId]
    endfunction

    function AddWitchDoctorAbsoluteLevel takes unit u, integer elementId returns nothing
        set WitchDoctorAbsoluteLevel[GetHandleId(u)].integer[elementId] = WitchDoctorAbsoluteLevel[GetHandleId(u)].integer[elementId] + 1
        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,(ClassAbil[elementId] + " |cffffcc00bonus acquired"))
    endfunction
    
    function WitchDoctorHasAbsolute takes unit u, integer elementId returns boolean
        return GetUnitAbilityLevel(u, GetElementAbsolute(elementId)) > 0
    endfunction

    private function init takes nothing returns nothing
        set WitchDoctorAbsoluteLevel = HashTable.create()
    endfunction
endlibrary