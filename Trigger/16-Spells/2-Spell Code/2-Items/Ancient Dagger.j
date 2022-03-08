library AncientDagger requires DummyOrder, RandomShit, BuffSystem, GetRandomUnit
    private function CalculateDamage takes real startingValue, integer count returns real
        local integer i = 1
        local real dmg = startingValue
        loop
            exitwhen i >= count
            set dmg = dmg * 1.5
            //call BJDebugMsg("ad dmg: " + R2S(dmg) + " i: " + I2S(i))
            set i = i + 1
        endloop
        return dmg
    endfunction

    function AncientDagger takes unit u returns nothing
        local unit target = GetRandomUnit(GetUnitX(u), GetUnitY(u), 900, GetOwningPlayer(u), Target_Enemy, true, false)
        //call BJDebugMsg("ancient dagger")
        call SetBuff(target,5,10)
        call PeriodicDamage.create(u, target, CalculateDamage(GetHeroAgi(u, true)* 0.5, UnitHasItemI(u, ANCIENT_DAGGER_ITEM_ID)), true, 1., 10, 0, false, ANCIENT_KNIFE_OF_THE_GODS_BUFF_ID, ANCIENT_DAGGER_ITEM_ID)
    endfunction
endlibrary