library ShadowStep initializer init requires AbilityCooldown, CustomGameEvent
    globals
        private constant trigger ShadowStepTrigger = CreateTrigger()
    endglobals

    private function Teleport takes unit u1, unit u2 returns nothing
        local effect e1 = null
        local effect e2 = null
        local real dist = 0
        local real x = GetUnitX(u2) - 65 * CosBJ(GetUnitFacing(u1) + 180)
        local real y = GetUnitY(u2) - 65 * SinBJ(GetUnitFacing(u1) + 180)
        local integer lvl = GetUnitAbilityLevel(u1, SHADOW_STEP_ABILITY_ID)

        if lvl > 0 and IsCastingAllowed(u1) and IsUnitEnemy(u2, GetOwningPlayer(u1)) and IsTerrainWalkable(x, y) then
            set dist =  CalculateDistance(GetUnitX(u1), GetUnitX(u2), GetUnitY(u1), GetUnitY(u2))

            if GetWidgetLife(u2) > 0.025 and u2 != null and dist <= 900 and dist >= 125 and (BlzGetUnitAbilityCooldownRemaining(u1, SHADOW_STEP_ABILITY_ID) <= 0 or UnitHasForm(u1, FORM_SHADOW)) then
                set e1 = AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u1, "hand right")
                set e2 = AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u1, "hand left")
                call SetUnitX(u1, TerrainPathability_X)
                call SetUnitY(u1, TerrainPathability_Y)
                call BlzSetUnitFacingEx(u1, Atan2(GetUnitY(u2) - GetUnitY(u1), GetUnitX(u2) - GetUnitX(u1)) * bj_RADTODEG)
                call DestroyEffect(e1) 
                call DestroyEffect(e2)

                if not UnitHasForm(u1, FORM_SHADOW) then
                    call AbilStartCD(u1,SHADOW_STEP_ABILITY_ID, 15.3 - (I2R(lvl)*0.3) ) 
                endif
            endif 
        endif

        set e1 = null
        set e2 = null
    endfunction

    private function CheckShadowStep takes nothing returns nothing
        if GetOrderTargetUnit() != null then
            call Teleport(GetTriggerUnit(), GetOrderTargetUnit())
        endif
    endfunction

    private function LearnAbility takes EventInfo eventInfo returns nothing
        if eventInfo.abilId == SHADOW_STEP_ABILITY_ID then
            call TriggerRegisterUnitEvent(ShadowStepTrigger, eventInfo.hero, EVENT_UNIT_ISSUED_ORDER)
            call TriggerRegisterUnitEvent(ShadowStepTrigger, eventInfo.hero, EVENT_UNIT_ISSUED_TARGET_ORDER)
            call TriggerRegisterUnitEvent(ShadowStepTrigger, eventInfo.hero, EVENT_UNIT_ISSUED_POINT_ORDER)
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_LEARN_ABILITY, CustomEvent.LearnAbility)
        call TriggerAddAction(ShadowStepTrigger, function CheckShadowStep)
    endfunction
endlibrary