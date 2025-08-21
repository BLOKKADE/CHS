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


            call SetHeroStr(u, 10, true)
            call SetHeroAgi(u, 10, true)
            call SetHeroInt(u, 10, true)
            call BlzSetUnitMaxHP(u, 10)
            call BlzSetUnitBaseDamage(u, 1, 0)
            call BlzSetUnitArmor(u, 1)


            call SetUnitCustomState(u, BONUS_MAGICPOW, 1)
            call SetUnitCustomState(u, BONUS_MAGICRES, 1)
            call SetUnitCustomState(u, BONUS_EVASION, 1)
            call SetUnitCustomState(u, BONUS_BLOCK, 1)
            call SetUnitCustomState(u, BONUS_PVP, 1)
            call SetUnitBonusReal(u, BONUS_HEALTH_REGEN, 1)
            call SetUnitBonusReal(u, BONUS_MANA_REGEN, 1)
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
