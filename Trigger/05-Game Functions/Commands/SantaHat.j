scope NoAddSantaHatBets initializer init
    //===========================================================================
    globals
        boolean SantaHatOn = false
        weathereffect snow
    endglobals
    function SantaHat takes Args args returns nothing
        local integer i = 1

        if SantaHatOn then
            set SantaHatOn = false
        else
            set SantaHatOn = true
        endif

        call EnableWeatherEffect(snow, SantaHatOn)

        loop

            if GetUnitAbilityLevel(PlayerHeroes[i], 'A0B1') == 0 then
                call UnitAddAbility(PlayerHeroes[i], 'A0B1')
            else
                call UnitRemoveAbility(PlayerHeroes[i], 'A0B1')
            endif

            set i = i + 1
            exitwhen i > 8
        endloop

        call DisplayTextToForce(GetPlayersAll(), "|cffff6161Merry Christmas!|r")
        
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        //call Command.create(CommandHandler.NoIncomeSpam).name("SantaMode").handles("santa").handles("christmas").handles("holidays").help("santa", "Toggles christmas mode.")
    endfunction
endscope