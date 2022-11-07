library AncientTeaching initializer init requires RandomShit, StableSpells, ToggleSpell
    function ResetAbility_A05U takes unit u,integer abilId returns nothing
        local integer OgAbilId = GetAssociatedSpell(u, abilId)
        local integer tempAbilId = abilId

        if OgAbilId != 0 then
            set tempAbilId = OgAbilId
        endif
        
        //call BJDebugMsg(GetObjectName(OgAbilId) + " : " + GetObjectName(abilId))
        if BlzGetUnitAbilityCooldownRemaining(u,ANCIENT_TEACHING_ABILITY_ID)<= 0.001 and GetUnitAbilityLevel(u,ANCIENT_TEACHING_ABILITY_ID) > 0 and IsSpellResettable(tempAbilId) then
            call AbilStartCD(u,ANCIENT_TEACHING_ABILITY_ID,BlzGetUnitAbilityCooldownRemaining(u,abilId)*(4 - 0.1 * I2R(GetUnitAbilityLevel(u,ANCIENT_TEACHING_ABILITY_ID)))) 
            call BlzEndUnitAbilityCooldown(u,abilId)

            if OgAbilId != 0 then
                call BlzEndUnitAbilityCooldown(u, OgAbilId)
            endif
        endif
    endfunction

    function ResetAbilit_Ec takes nothing returns nothing
        call ResetAbility_A05U(Global_u,Global_i)
    endfunction

    function A05U_Reset_Timer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HT,GetHandleId(t),2)
        local integer abilId = LoadInteger(HT,GetHandleId(t),1)

        call ResetAbility_A05U(u,abilId)

        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set t = null
        set u = null
    endfunction

    function Trig_Ancient_Teaching_Actions takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer abilId = GetSpellAbilityId()
        local timer t = null

        if abilId != RESET_TIME_ABILITY_ID then
            if GetUnitAbilityLevel(u,ANCIENT_TEACHING_ABILITY_ID)> 0 and BlzGetUnitAbilityCooldownRemaining(u,ANCIENT_TEACHING_ABILITY_ID)<= 0.001 then
                set t = NewTimer()
                call SaveInteger(HT,GetHandleId(t),1,abilId)
                call SaveUnitHandle(HT,GetHandleId(t),2, u)
                call TimerStart(t,0,false,function A05U_Reset_Timer)
                
            endif
        endif

        set u = null
        set t = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddAction( trg, function Trig_Ancient_Teaching_Actions )
        set trg = null
    endfunction
endlibrary