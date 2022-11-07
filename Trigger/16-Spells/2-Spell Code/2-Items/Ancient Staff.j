library AncientStaff requires DummyOrder, RandomShit, CustomState, GetRandomUnit
    private function CalculateReduction takes integer count returns real
        local integer i = 1
        local real mr = 0.3
        loop
            exitwhen i >= count
            set mr = mr * 1.2
            //call BJDebugMsg("as mr: " + R2S(mr) + " i: " + I2S(i))
            set i = i + 1
        endloop
        return mr
    endfunction

    function AncientStaff takes unit u returns nothing
        local integer abilId = 'A055'
        local unit target = GetRandomUnit(GetUnitX(u), GetUnitY(u), 900, GetOwningPlayer(u), Target_Enemy, true, false)
        local DummyOrder dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 1)
        //call BJDebugMsg("ancient staff")
        call dummy.addActiveAbility(abilId, 1, 852231)
        call dummy.setAbilityRealField(abilId, ABILITY_RLF_DAMAGE_HTB1, GetHeroInt(u, true) * 3)
        call dummy.target(target)
        call dummy.activate()
        call AbilStartCD(u, 'A094', 30)
        call TempBonus.create(target, BONUS_MAGICRES, 0 - (GetUnitMagicDef(target)* CalculateReduction(GetUnitITemTypeCount(u, ANCIENT_STAFF_ITEM_ID))), 5, 'A094')
        set target = null
    endfunction
endlibrary