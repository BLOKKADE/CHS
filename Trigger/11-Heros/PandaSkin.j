library PandaSkin initializer init requires RandomShit

    globals
        Table PandaSkinEnabled
    endglobals

    public function CheckAbilitiesAndItems takes unit u returns nothing
        local integer pandaCounter = 0

        if not PandaSkinEnabled.boolean[GetHandleId(u)] then

            if GetUnitAbilityLevel(u, DRUNKEN_MASTER_ABILITY_ID) > 0 then
                set pandaCounter = pandaCounter + 1
            endif

            if GetUnitAbilityLevel(u, DRUNKEN_HAZE_ABILITY_ID) > 0 then
                set pandaCounter = pandaCounter + 1
            endif

            if GetUnitAbilityLevel(u, BREATH_OF_FIRE_ABILITY_ID) > 0 then
                set pandaCounter = pandaCounter + 1
            endif

            if GetUnitAbilityLevel(u, 'A03M') > 0 then
                set pandaCounter = pandaCounter + 1
            endif

            if GetUnitAbilityLevel(u, CONQ_BAMBOO_STICK_ABILITY_ID) > 0 then
                set pandaCounter = pandaCounter + 1
            endif

            if pandaCounter >= 5 then
                set PandaSkinEnabled.boolean[GetHandleId(u)] = true
                call BlzSetUnitSkin(u, 'Npbm')
                call PlaySoundOnUnitBJ(udg_sounds01[GetConvertedPlayerId(GetOwningPlayer(u))], 100, u) 
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set PandaSkinEnabled = Table.create()
    endfunction
endlibrary