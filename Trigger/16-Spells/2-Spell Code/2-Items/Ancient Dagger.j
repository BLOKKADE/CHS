library AncientDagger requires DummyOrder, RandomShit, BuffSystem
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
        local unit target = GetRandomUnit(GetUnitX(u), GetUnitY(u), 900, GetOwningPlayer(u), false, true, false)
        //call BJDebugMsg("ancient dagger")
        call SetBuff(target,5,10)
        call PeriodicDamage.create(u, target, CalculateDamage(GetHeroAgi(u, true)*0.5, UnitHasItemI(u, 'I06X')), true, 1., 10, 0, false, 'B01N')
        call AbilStartCD(u, 'A097', 30)
    endfunction
endlibrary