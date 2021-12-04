scope NoAddSantaHatBets initializer init
    //===========================================================================
    globals
        boolean SantaHatOn = false
        weathereffect snow
    endglobals
    function SantaHat takes nothing returns nothing
        local integer i = 1

        if SantaHatOn then
            set SantaHatOn = false
        else
            set SantaHatOn = true
        endif

        call EnableWeatherEffect(snow, SantaHatOn)

        loop

            if GetUnitAbilityLevel(udg_units01[i], 'A0B1') == 0 then
                call UnitAddAbility(udg_units01[i], 'A0B1')
            else
                call UnitRemoveAbility(udg_units01[i], 'A0B1')
            endif

            set i = i + 1
            exitwhen i > 8
        endloop

        call DisplayTextToForce(GetPlayersAll(), "|cffff6161Merry Christmas!|r")
        
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        set snow = AddWeatherEffectSaveLast( gg_rct_EntireMapVariable, 'SNls' )
        call EnableWeatherEffect( snow, false)

        loop
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"christmas",false)
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"holidays",false)
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"santa",false)

            set i = i + 1
            exitwhen i > 8
        endloop
            
        call TriggerAddAction(trg, function SantaHat)
        set trg = null
    endfunction
endscope