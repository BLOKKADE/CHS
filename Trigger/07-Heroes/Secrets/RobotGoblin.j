library RoboGoblinSkin initializer init

    globals
        Table RoboGoblinSkinEnabled
    endglobals

    public function CheckAbilitiesAndItems takes unit u returns nothing
        local integer roboGoblinCounter = 0

        if not RoboGoblinSkinEnabled.boolean[GetHandleId(u)] then

            if GetUnitAbilityLevel(u, CLUSTER_ROCKETS_ABILITY_ID) > 0 then
                set roboGoblinCounter = roboGoblinCounter + 1
            endif

            if GetUnitAbilityLevel(u, DEMOLISH_ABILITY_ID) > 0 then
                set roboGoblinCounter = roboGoblinCounter + 1
            endif

            if GetUnitAbilityLevel(u, SLOW_AURA_ABILITY_ID) > 0 then
                set roboGoblinCounter = roboGoblinCounter + 1
            endif

            if GetUnitAbilityLevel(u, POCKET_FACTORY_ABILITY_ID) > 0 then
                set roboGoblinCounter = roboGoblinCounter + 1
            endif

            if GetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_LUMBER) > 3000 then
                set roboGoblinCounter = roboGoblinCounter + 1
            endif

            if roboGoblinCounter >= 5 then
                set RoboGoblinSkinEnabled.boolean[GetHandleId(u)] = true
                call BlzSetUnitSkin(u, 'ngir')
                call PlaySoundOnUnitBJ(udg_sounds01[GetConvertedPlayerId(GetOwningPlayer(u))], 100, u) 
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set RoboGoblinSkinEnabled = Table.create()
    endfunction
endlibrary