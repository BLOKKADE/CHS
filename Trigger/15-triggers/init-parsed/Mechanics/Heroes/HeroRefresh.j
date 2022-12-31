library HeroRefresh initializer init requires RandomShit

    private function HeroRefreshActions takes nothing returns nothing
        call SetUnitLifePercentBJ(udg_unit01, 100)
        call SetUnitManaPercentBJ(udg_unit01, 100)
        call UnitResetCooldown(udg_unit01)
        call UnitRemoveAbility(udg_unit01, 'Bvul')
        call UnitRemoveAbility(udg_unit01, 'Bam2')
        call UnitRemoveAbility(udg_unit01, 'BHav')
        call UnitRemoveAbility(udg_unit01, 'BHbn')
        call UnitRemoveAbility(udg_unit01, 'BNbr')
        call UnitRemoveAbility(udg_unit01, 'Bbsk')
        call UnitRemoveAbility(udg_unit01, 'Bapl')
        call UnitRemoveAbility(udg_unit01, 'Bplg')
        call UnitRemoveAbility(udg_unit01, 'Bena')
        call UnitRemoveAbility(udg_unit01, 'Beng')
        call UnitRemoveAbility(udg_unit01, 'BEer')
        call UnitRemoveAbility(udg_unit01, 'Bfae')
        call UnitRemoveAbility(udg_unit01, 'BUfa')
        call UnitRemoveAbility(udg_unit01, 'Binf')
        call UnitRemoveAbility(udg_unit01, 'Blsh')
        call UnitRemoveAbility(udg_unit01, 'Bliq')
        call UnitRemoveAbility(udg_unit01, 'Bpoi')
        call UnitRemoveAbility(udg_unit01, 'Bpsd')
        call UnitRemoveAbility(udg_unit01, 'Brej')
        call UnitRemoveAbility(udg_unit01, 'Bdef')
        call UnitRemoveAbility(udg_unit01, 'B002')
        call UnitRemoveAbility(udg_unit01, 'Bslo')
        call UnitRemoveAbility(udg_unit01, 'Bspl')
        call UnitRemoveAbility(udg_unit01, 'BSTN')
        call UnitRemoveAbility(udg_unit01, 'BPSE')
        call UnitRemoveAbility(udg_unit01, 'BHtc')
        call UnitRemoveAbility(udg_unit01, 'Buhf')
        call RemoveDebuff(udg_unit01, 0)
    endfunction

    private function init takes nothing returns nothing
        set HeroRefreshTrigger = CreateTrigger()
        call TriggerAddAction(HeroRefreshTrigger, function HeroRefreshActions)
    endfunction

endlibrary
