library HolyEnlightenment initializer init requires RandomShit
    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local integer abilLevel = GetUnitAbilityLevel(eventInfo.hero, HOLY_ENLIGHTENMENT_ABILITY_ID)
        local integer heroLevel = GetHeroLevel(eventInfo.hero)
        local real BonusExp = 0
        local real currentExp = 0
        

        if abilLevel > 0 then
            call ElemFuncStart(eventInfo.hero,HOLY_ENLIGHTENMENT_ABILITY_ID)
            set BonusExp = 50 *(heroLevel + 3) * (heroLevel + 4) - 110  
            set currentExp = GetHeroXP(eventInfo.hero)

            if GetUnitAbilityLevel(eventInfo.hero, PILLAGE_ABILITY_ID) > 0 then   
                call AddHeroXP(eventInfo.hero, R2I((BonusExp - currentExp) * (abilLevel * 1.5)) / 200, true) 
            else
                call AddHeroXP(eventInfo.hero, R2I((BonusExp - currentExp) * (abilLevel * 1.5)) / 100, true) 
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.OnRoundStart)
    endfunction 
endlibrary
