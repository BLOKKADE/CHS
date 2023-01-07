library HeroRefresh initializer init requires RandomShit

    private function HeroRefreshActions takes nothing returns nothing
        call SetUnitLifePercentBJ(TempUnit, 100)
        call SetUnitManaPercentBJ(TempUnit, 100)
        call UnitResetCooldown(TempUnit)
        call UnitRemoveAbility(TempUnit, 'Bvul')
        call UnitRemoveAbility(TempUnit, 'Bam2')
        call UnitRemoveAbility(TempUnit, 'BHav')
        call UnitRemoveAbility(TempUnit, 'BHbn')
        call UnitRemoveAbility(TempUnit, 'BNbr')
        call UnitRemoveAbility(TempUnit, 'Bbsk')
        call UnitRemoveAbility(TempUnit, 'Bapl')
        call UnitRemoveAbility(TempUnit, 'Bplg')
        call UnitRemoveAbility(TempUnit, 'Bena')
        call UnitRemoveAbility(TempUnit, 'Beng')
        call UnitRemoveAbility(TempUnit, 'BEer')
        call UnitRemoveAbility(TempUnit, 'Bfae')
        call UnitRemoveAbility(TempUnit, 'BUfa')
        call UnitRemoveAbility(TempUnit, 'Binf')
        call UnitRemoveAbility(TempUnit, 'Blsh')
        call UnitRemoveAbility(TempUnit, 'Bliq')
        call UnitRemoveAbility(TempUnit, 'Bpoi')
        call UnitRemoveAbility(TempUnit, 'Bpsd')
        call UnitRemoveAbility(TempUnit, 'Brej')
        call UnitRemoveAbility(TempUnit, 'Bdef')
        call UnitRemoveAbility(TempUnit, 'B002')
        call UnitRemoveAbility(TempUnit, 'Bslo')
        call UnitRemoveAbility(TempUnit, 'Bspl')
        call UnitRemoveAbility(TempUnit, 'BSTN')
        call UnitRemoveAbility(TempUnit, 'BPSE')
        call UnitRemoveAbility(TempUnit, 'BHtc')
        call UnitRemoveAbility(TempUnit, 'Buhf')
        call RemoveUnitBuffs(TempUnit, 0)
    endfunction

    private function init takes nothing returns nothing
        set HeroRefreshTrigger = CreateTrigger()
        call TriggerAddAction(HeroRefreshTrigger, function HeroRefreshActions)
    endfunction

endlibrary
