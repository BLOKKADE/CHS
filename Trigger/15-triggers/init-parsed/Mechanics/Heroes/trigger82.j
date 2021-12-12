library trigger82 initializer init requires RandomShit

    function Trig_Hero_Refresh_Actions takes nothing returns nothing
        call SetUnitLifePercentBJ(udg_unit01,100)
        call SetUnitManaPercentBJ(udg_unit01,100)
        call UnitResetCooldown(udg_unit01)
        call UnitRemoveBuffBJ('Bvul',udg_unit01)
        call UnitRemoveBuffBJ('Bam2',udg_unit01)
        call UnitRemoveBuffBJ('BHav',udg_unit01)
        call UnitRemoveBuffBJ('BHbn',udg_unit01)
        call UnitRemoveBuffBJ('BNbr',udg_unit01)
        call UnitRemoveBuffBJ('Bbsk',udg_unit01)
        call UnitRemoveBuffBJ('Bapl',udg_unit01)
        call UnitRemoveBuffBJ('Bplg',udg_unit01)
        call UnitRemoveBuffBJ('Bena',udg_unit01)
        call UnitRemoveBuffBJ('Beng',udg_unit01)
        call UnitRemoveBuffBJ('BEer',udg_unit01)
        call UnitRemoveBuffBJ('Bfae',udg_unit01)
        call UnitRemoveBuffBJ('BUfa',udg_unit01)
        call UnitRemoveBuffBJ('Binf',udg_unit01)
        call UnitRemoveBuffBJ('Blsh',udg_unit01)
        call UnitRemoveBuffBJ('Bliq',udg_unit01)
        call UnitRemoveBuffBJ('Bpoi',udg_unit01)
        call UnitRemoveBuffBJ('Bpsd',udg_unit01)
        call UnitRemoveBuffBJ('Brej',udg_unit01)
        call UnitRemoveBuffBJ('Bdef',udg_unit01)
        call UnitRemoveBuffBJ('B002',udg_unit01)
        call UnitRemoveBuffBJ('Bslo',udg_unit01)
        call UnitRemoveBuffBJ('Bspl',udg_unit01)
        call UnitRemoveBuffBJ('BSTN',udg_unit01)
        call UnitRemoveBuffBJ('BPSE',udg_unit01)
        call UnitRemoveBuffBJ('BHtc',udg_unit01)
        call UnitRemoveBuffBJ('Buhf',udg_unit01)
        call RemoveDebuff(udg_unit01, 0)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger82 = CreateTrigger()
        call TriggerAddAction(udg_trigger82,function Trig_Hero_Refresh_Actions)
    endfunction


endlibrary
