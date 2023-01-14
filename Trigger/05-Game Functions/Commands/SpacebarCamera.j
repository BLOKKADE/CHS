library SpacebarCamera initializer init requires RandomShit

    private function HeroFilter takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true)
    endfunction

    private function MoveCameraToHero takes nothing returns nothing
        local location unitLocation = GetUnitLoc(GetEnumUnit())

        call SetCameraQuickPositionLocForPlayer(GetOwningPlayer(GetEnumUnit()), unitLocation)

        // Cleanup
        call RemoveLocation(unitLocation)
        set unitLocation = null
    endfunction

    private function SpacebarCameraActions takes nothing returns nothing
        local group playerHeroes = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function HeroFilter))
        
        call ForGroup(playerHeroes, function MoveCameraToHero)
        
        // Cleanup
        call DestroyGroup(playerHeroes)
        set playerHeroes = null
    endfunction

    private function init takes nothing returns nothing
        set SpacebarCameraTrigger = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(SpacebarCameraTrigger, 4)
        call TriggerAddAction(SpacebarCameraTrigger, function SpacebarCameraActions)
    endfunction

endlibrary
