library FireRune requires RandomShit
    globals
        constant real RuneOfFire_base_dmg = 4000
        constant real RuneOfFire_base_range = 650    
    endglobals


    function RuneOfFire takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 



        call USOrderA(u,GetUnitX(u),GetUnitY(u),'A02V',"fanofknives",  R2I(4000 * power), ConvertAbilityRealLevelField('Ocl1') )

        set u = null
        return false
    endfunction
endlibrary