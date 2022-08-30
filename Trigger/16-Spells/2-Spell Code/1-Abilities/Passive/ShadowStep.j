library ShadowStep initializer init requires RandomShit, CustomEvent

    private function teleport takes unit u1, widget u2 returns nothing
        local effect e1 = null
        local effect e2 = null
        local real dist = 0
        local integer lvl = GetUnitAbilityLevel(u1, SHADOW_STEP_ABILITY_ID)

        if lvl > 0 then
            set dist =  CalculateDistance(GetUnitX(u1), GetWidgetX(u2), GetUnitY(u1), GetWidgetY(u2))
            if GetWidgetLife(u2) > 0.025 and u2 != null and dist <= 900 and dist >= 125 and (BlzGetUnitAbilityCooldownRemaining(u1, SHADOW_STEP_ABILITY_ID) <= 0 or UnitHasForm(u1, FORM_SHADOW)) then
                set e1 = AddSpecialEffectTargetFix("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u1, "hand right")
                set e2 = AddSpecialEffectTargetFix("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u1, "hand left")
                call SetUnitX(u1, GetWidgetX(u2) - 65 * CosBJ(GetUnitFacing(u1)))
                call SetUnitY(u1, GetWidgetY(u2) - 65 * SinBJ(GetUnitFacing(u1)))
                call DestroyEffect(e1) 
                call DestroyEffect(e2)

                if not UnitHasForm(u1, FORM_SHADOW) then
                 call AbilStartCD(u1,SHADOW_STEP_ABILITY_ID, 9.25 - (I2R(lvl)*0.25) ) 
                endif
            endif 
        endif


        set e1 = null
        set e2 = null
    endfunction



    private function checkShadowStep takes nothing returns nothing
        local unit u1 = GetTriggerUnit()
        local widget u2 = GetOrderTarget()
        local integer lvl = 0
        local timer t = null

        set t = LoadTimerHandle(HT,GetHandleId(u1), SHADOW_STEP_ABILITY_ID)
        if t != null then


            if u2 == null then
                call RemoveSavedHandle(HT, GetHandleId(t), 2)
            else 
                call SaveWidgetHandle(HT,GetHandleId(t), 2, u2)
            endif 
        endif

        call teleport(u1,u2)
        set u1 = null
        set u2 = null
    endfunction

    private function CheckUnitOrder takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u1 = LoadUnitHandle(HT,GetHandleId(t), 1)
        local widget u2 = LoadWidgetHandle(HT,GetHandleId(t), 2)

        call teleport(u1,u2)

        set t = null
        set u1 = null
        set u2 = null
    endfunction

    private function LearnAbility takes nothing returns boolean
        local timer t = null
        local customEvent e = GetTriggerCustomEvent(GetTriggeringTrigger())
        if e.EventSpellId == SHADOW_STEP_ABILITY_ID and e.LearnedAbilityIsNew then
            set t = CreateTimer()
            call SaveUnitHandle(HT, GetHandleId(t), 1, e.EventUnit)
            call SaveTimerHandle(HT, GetHandleId(e.EventUnit), SHADOW_STEP_ABILITY_ID, t)
            call TimerStart(t, 0.10, true, function CheckUnitOrder)
        endif
        set t = null 

        return false
    endfunction



    private function init takes nothing returns nothing
        local trigger t = CreateTrigger(  )
        call EventSubscriber(CUSTOM_EVENT_LEARN_ABILITY, function LearnAbility)

        call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER  )
        call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER  )
        call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER  )
        call TriggerAddAction(t, function checkShadowStep )
    endfunction
endlibrary