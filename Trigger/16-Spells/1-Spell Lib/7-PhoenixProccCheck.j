library CheckProcc requires GroupUtils

    globals
        private integer ProcCount = 0
        private player ProcOwner
    endglobals

    private function Filter takes nothing returns boolean
        local unit u = GetFilterUnit()
        if IsUnitEnemy(u, ProcOwner) == true and GetUnitAbilityLevel(u, 'Avul') == 0 and GetUnitAbilityLevel(u, 'B01A') == 0 and GetUnitAbilityLevel(u, 'Bams') == 0 and GetUnitAbilityLevel(u, 'Aloc') == 0 then
            set ProcCount = ProcCount + 1
        endif
        set u = null
        return false
    endfunction

    function CheckProc takes unit u, real area returns boolean
        local real x = GetUnitX(u)
        local real y = GetUnitY(u)
        set ProcCount = 0
        set ProcOwner = GetOwningPlayer(u)
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP, x, y, area, Condition(function Filter))
        if ProcCount > 0 then
            return true
        endif
        return false
    endfunction
    
endlibrary