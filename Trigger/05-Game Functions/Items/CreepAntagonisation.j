library CreepAntagonisation initializer init requires CustomState, CustomGameEvent

    globals
        Table CreepAntagonisationBonus
        boolean array CreepAntagonisationBought
    endglobals

    private function BuffCreep takes unit u, real multiplier returns nothing
        call SetUnitCustomState(u, BONUS_MAGICPOW, GetUnitCustomState(u, BONUS_MAGICPOW) * multiplier)
        call SetUnitCustomState(u, BONUS_EVASION, GetUnitCustomState(u, BONUS_EVASION) * multiplier)	
        call SetUnitCustomState(u, BONUS_BLOCK, GetUnitCustomState(u, BONUS_BLOCK) * multiplier)
        call BlzSetUnitArmor(u , BlzGetUnitArmor(u) * multiplier) 
        call BlzSetUnitBaseDamage(u, R2I(BlzGetUnitBaseDamage(u, 0) * multiplier), 0)
        call BlzSetUnitMaxHP(u, R2I(BlzGetUnitMaxHP(u) * multiplier))   
        call SetUnitCustomState(u, BONUS_MAGICRES, GetUnitCustomState(u, BONUS_MAGICRES) * multiplier)
        call SetWidgetLife(u, BlzGetUnitMaxHP(u))
    endfunction

    private function ExpBonus takes unit hero returns nothing
        call AddHeroXP(hero, R2I((50 *(GetHeroLevel(hero) + 3) * (GetHeroLevel(hero) + 4) - 110 - GetHeroXP(hero)) * 45) / 100, true) 
    endfunction

    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local integer pid = GetPlayerId(eventInfo.p)
        local integer i = 0
        local unit u = null
        if CreepAntagonisationBought[pid] then
            set CreepAntagonisationBought[pid] = false
            loop
                set u = BlzGroupUnitAt(PlayerRoundCreeps[eventInfo.roundNumber].group[pid], i)
                exitwhen u == null
                call BuffCreep(u, CreepAntagonisationBonus.real[pid] + 1)
                
                set i = i + 1
            endloop
            call ExpBonus(eventInfo.hero)
        endif
    endfunction

    private function init takes nothing returns nothing
        set CreepAntagonisationBonus = Table.create()
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.OnRoundStart)
    endfunction
endlibrary
