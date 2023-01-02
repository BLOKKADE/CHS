library FixUnit initializer init

    private function FixUnitActions takes nothing returns nothing
        if GetUnitTypeId(GetTriggerUnit()) == COLD_KNIGHT_UNIT_ID then
            call BlzSetUnitSkin(GetTriggerUnit(), 'nrvs')
        endif

        if GetUnitTypeId(GetTriggerUnit()) == URSA_WARRIOR_UNIT_ID then
            call BlzSetUnitSkin(GetTriggerUnit(), 'nfrl')
        endif
    endfunction

    private function init takes nothing returns nothing
        local trigger fixUnitTrigger = CreateTrigger()
        call TriggerRegisterEnterRectSimple(fixUnitTrigger, GetEntireMapRect())
        call TriggerAddAction(fixUnitTrigger, function FixUnitActions)
        set fixUnitTrigger = null
    endfunction

endlibrary