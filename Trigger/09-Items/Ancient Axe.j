library AncientAxe requires DummyOrder, RandomShit
    private function CalculateDmg takes integer count returns real
        local integer i = 1
        local real cd = 2
        loop
            exitwhen i >= count
            set cd = cd * 1.2
            //call BJDebugMsg("aa dmg: " + R2S(cd) + " i: " + I2S(i))
            set i = i + 1
        endloop
        return cd
    endfunction

    function AncientAxe takes unit u returns nothing
        local integer abilId = 'A058'
        local DummyOrder dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 1)
        //call BJDebugMsg("ancient axe")
        call dummy.addActiveAbility(abilId, 1, 852127)
        call dummy.setAbilityRealField(abilId, ABILITY_RLF_DAMAGE_WRS1, GetHeroStr(u, true) * CalculateDmg(GetUnitItemTypeCount(u, ANCIENT_AXE_ITEM_ID)))
        call dummy.instant()
        call dummy.activate()
    endfunction
endlibrary