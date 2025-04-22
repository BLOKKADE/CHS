library FireRune requires RandomShit
    globals
        constant real RuneOfFire_base_dmg = 2000
    endglobals


    function RuneOfFire takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        call DummyInstantCast1(u,GetUnitX(u),GetUnitY(u),'A02V',"fanofknives",  R2I(RuneOfFire_base_dmg * power), ConvertAbilityRealLevelField('Ocl1'), 4)

        set u = null
        return false
    endfunction
endlibrary