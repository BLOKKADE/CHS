library HeroRefresh initializer init requires RandomShit

    private function HeroRefreshActions takes nothing returns nothing
        call SetUnitLifePercentBJ(TempUnit, 100)
        call SetUnitManaPercentBJ(TempUnit, 100)
        call UnitResetCooldown(TempUnit)
        call RemoveUnitBuffs(TempUnit, BUFFTYPE_BOTH, true)
    endfunction

    private function init takes nothing returns nothing
        set HeroRefreshTrigger = CreateTrigger()
        call TriggerAddAction(HeroRefreshTrigger, function HeroRefreshActions)
    endfunction

endlibrary
