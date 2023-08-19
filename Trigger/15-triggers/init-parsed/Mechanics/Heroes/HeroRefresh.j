library HeroRefresh initializer init requires RandomShit

    function ResetHero takes unit u returns nothing
        if IsUnitType(u, UNIT_TYPE_HERO) then
            call RemoveItem(UnitItemInSlot(u, 0))
            call RemoveItem(UnitItemInSlot(u, 1))
            call RemoveItem(UnitItemInSlot(u, 2))
            call RemoveItem(UnitItemInSlot(u, 3))
            call RemoveItem(UnitItemInSlot(u, 4))
            call RemoveItem(UnitItemInSlot(u, 5))
    
            call RemoveHeroAbilities(u)
        endif

        call UnitRemoveAbility(u, REINCARNATION_ABILITY_ID)
    endfunction

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
