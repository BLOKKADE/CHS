library PetDeath initializer init requires RandomShit

    private function HeroDiesConditions takes nothing returns boolean
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
            return false
        endif

        return true
    endfunction

    private function HeroDiesActions takes nothing returns nothing
        local unit u = GetDyingUnit()
        local PlayerStats ps = PlayerStats.forPlayer(GetOwningPlayer(u))

        call BJDebugMsg("Triggering pet death")

        if (ps.getPet() != null) then
            call ps.setPet(null)
        endif

        set u = null
    endfunction

    private function init takes nothing returns nothing
        local trigger heroDiesTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(heroDiesTrigger,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(heroDiesTrigger,Condition(function HeroDiesConditions))
        call TriggerAddAction(heroDiesTrigger,function HeroDiesActions)

        set heroDiesTrigger = null
    endfunction


endlibrary
