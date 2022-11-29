scope SantaHat initializer init
    //===========================================================================
    globals
        boolean SantaHatOn = false
        weathereffect snow
    endglobals

    function SantaHat takes Args args returns nothing
        if SantaHatOn then
            set SantaHatOn = false
        else
            set SantaHatOn = true
        endif

        call EnableWeatherEffect(snow, SantaHatOn)

        call DisplayTextToForce(GetPlayersAll(), "|cffff6161Merry Christmas!|r")
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        set snow = AddWeatherEffect(GetPlayableMapRect(), 'SNhs')
        call EnableWeatherEffect(snow, false)
        call Command.create(CommandHandler.SantaHat).name("SantaMode").handles("santa").handles("christmas").handles("holidays").help("santa", "Toggles christmas mode.")
    endfunction
endscope