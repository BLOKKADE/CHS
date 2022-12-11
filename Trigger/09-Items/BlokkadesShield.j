library BlokkadesShield initializer init requires RandomShit

    globals
        Table BlokShieldAttackCount
        Table BlokShieldCharges
        Table BlokShieldStartTick
        Table BlokShieldDmgReductionTick
    endglobals

    function SetBlokShieldCharges takes unit u, integer hid returns nothing
        call SetItemCharges(GetUnitItem(u, 'I0BD') , BlokShieldCharges[hid])
    endfunction

    function ActivateBlokkadeShield takes unit u returns nothing
        local integer hid = GetHandleId(u)
        if T32_Tick - BlokShieldDmgReductionTick[hid] > 64 and BlokShieldCharges[hid] > 0 then
            //call BJDebugMsg("bs activate")
            set BlokShieldCharges[hid] = BlokShieldCharges[hid] - 1
            set BlokShieldDmgReductionTick[hid] = T32_Tick
            call SetBlokShieldCharges(u, hid)
        endif
    endfunction

    private function init takes nothing returns nothing
        set BlokShieldAttackCount = Table.create()
        set BlokShieldCharges = Table.create()
        set BlokShieldStartTick = Table.create()
        set BlokShieldDmgReductionTick = Table.create()
    endfunction
endlibrary