library Cooldown requires AbilityCooldown, DummySpell
    
    private struct timerData
        unit u
        integer abilId
        real defaultCd
    endstruct

    private function TimerExpires takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local timerData data = GetTimerData(t)
        local integer lvl = GetUnitAbilityLevel(data.u, data.abilId) - 1

        call BlzSetUnitAbilityCooldown(data.u, data.abilId, lvl, data.defaultCd)
        call BlzSetUnitAbilityCooldown(data.u, GetDummySpell(data.u, data.abilId), 0, data.defaultCd)
        
        call data.destroy()
        call ReleaseTimer(t)
        set t = null
    endfunction

    private function StartCooldownTimer takes unit u, integer abilId, real defaultCd returns nothing
        local timer t = NewTimer()
        local timerData data = timerData.create()
        
        set data.u = u
        set data.abilId = abilId
        set data.defaultCd = defaultCd

        call SetTimerData(t, data)
        call TimerStart(t, 0.01, false, function TimerExpires)

        set t = null
    endfunction
    
    // startCooldown is false if for example the caster is still casting the abbility
    // because cooldown cant be started while casting instead it temporarily sets the ability cooldown of the ablity itself and resets after 0.01 seconds
    // abilId should never be the dummy spell id, it should always be the original spell id
    function SetCooldown takes unit u, integer abilId, boolean startCooldown returns nothing 
        local integer lvl = GetUnitAbilityLevel(u, abilId) - 1
        local real currentCooldown = BlzGetAbilityCooldown(abilId,lvl)
        local real newCooldown = CalculateCooldown(u, abilId, currentCooldown, true)
        local boolean dummyAbil = HasDummySpell(u, abilId)

        if not startCooldown then
            // always set the cooldown of the original spell if cast by dummy
            if dummyAbil then
                call BlzStartUnitAbilityCooldown(u, abilId, newCooldown)
            endif

            if newCooldown != currentCooldown then
                call BlzSetUnitAbilityCooldown(u, abilId, lvl, newCooldown) 
    
                if dummyAbil then
                    call BlzSetUnitAbilityCooldown(u, GetDummySpell(u, abilId), 0, newCooldown)
                endif
                
                call StartCooldownTimer(u, abilId, currentCooldown)
            endif
        else
            call BlzStartUnitAbilityCooldown(u, abilId, newCooldown)

            if dummyAbil then
                call BlzStartUnitAbilityCooldown(u, GetDummySpell(u, abilId), newCooldown)
            endif
        endif
    endfunction
endlibrary