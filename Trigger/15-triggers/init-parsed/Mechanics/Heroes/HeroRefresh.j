library HeroRefresh initializer init requires RandomShit, NewBonus, CustomState

    function ResetHero takes unit u returns nothing
        local integer i = 11
        
        if IsUnitType(u, UNIT_TYPE_HERO) then
            call RemoveItem(UnitItemInSlot(u, 0))
            call RemoveItem(UnitItemInSlot(u, 1))
            call RemoveItem(UnitItemInSlot(u, 2))
            call RemoveItem(UnitItemInSlot(u, 3))
            call RemoveItem(UnitItemInSlot(u, 4))
            call RemoveItem(UnitItemInSlot(u, 5))
    
            call RemoveHeroAbilities(u)

            call ResetUnitCustomState(u)

            call RemoveUnitBonus(u, BONUS_DAMAGE)
            call RemoveUnitBonus(u, BONUS_ARMOR)
            call RemoveUnitBonus(u, BONUS_AGILITY)
            call RemoveUnitBonus(u, BONUS_STRENGTH)
            call RemoveUnitBonus(u, BONUS_INTELLIGENCE)
            call RemoveUnitBonus(u, BONUS_HEALTH)
            call RemoveUnitBonus(u, BONUS_MANA)
            call RemoveUnitBonusReal(u, BONUS_HEALTH_REGEN)
            call RemoveUnitBonusReal(u, BONUS_MANA_REGEN)
            call RemoveUnitBonusReal(u, BONUS_ATTACK_SPEED)
            call RemoveUnitBonus(u, BONUS_MOVEMENT_SPEED)
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
