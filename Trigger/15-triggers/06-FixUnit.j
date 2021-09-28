library FixUnit initializer init
    function Trig_FixUnit_Actions takes nothing returns nothing
        if GetUnitTypeId(GetTriggerUnit()) == 'N02K' then
            call BlzSetUnitSkin(GetTriggerUnit(),'nrvs')
        endif

        if GetUnitTypeId(GetTriggerUnit()) == 'N00Q' then
            call BlzSetUnitSkin(GetTriggerUnit(),'nfrl')
        endif
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterEnterRectSimple( trg, GetEntireMapRect() )
        call TriggerAddAction( trg, function Trig_FixUnit_Actions )
        set trg = null
    endfunction
endlibrary