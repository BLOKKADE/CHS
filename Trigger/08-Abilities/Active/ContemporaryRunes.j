library ContemporaryRunes requires RuneInit, AbsoluteElements, HeroAbilityTable
    private function PickElement takes unit caster returns integer
        local integer absoluteCount = LoadInteger(HT, GetHandleId(caster), 941561)

        if absoluteCount > 0 then
            return GetAbsoluteElement(GetHeroSpellAtPosition(caster, (10) + GetRandomInt(1, absoluteCount)))
        else
            return GetRandomInt(1, Element_Maximum)
        endif
    endfunction

    function CastContemporaryRunes takes unit caster, integer level returns nothing
        local real max = 1 + R2I(level / 10)
        local integer i = 0
        local integer element = 0

        loop
            set element = PickElement(caster)
            call BJDebugMsg("element: " + I2S(element))
            call UnitAddItem(caster, CreateRune(null, 0, 0, 0, caster, element))
            set i = i + 1
            exitwhen i >= max
        endloop
    endfunction
endlibrary