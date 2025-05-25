library ShadowBootsHeroForm requires HideEffects
    globals
        hashtable HTSBforms = InitHashtable()
        integer FORM_SHADOWBOOTS = 1
    endglobals

    struct ShadowBootsHeroForm
        integer idForm = 0
        timer t = CreateTimer()
        unit u = null
        effect array eff[8]

        integer originalR = 255
        integer originalG = 255
        integer originalB = 255
        integer originalA = 255
    endstruct

    private function getShadowBootsForm takes unit u, integer id returns ShadowBootsHeroForm
        return LoadInteger(HTSBforms, GetHandleId(u), id)
    endfunction

    private function CreateShadowBootsForm takes unit u, integer id returns ShadowBootsHeroForm
        local ShadowBootsHeroForm f = ShadowBootsHeroForm.create()
        set f.u = u
        call SaveInteger(HTSBforms, GetHandleId(f.t), 1, f)
        call SaveInteger(HTSBforms, GetHandleId(u), id, f)
        return f
    endfunction

    function UnitHasShadowBootsForm takes unit u, integer id returns boolean
        return LoadInteger(HTSBforms, GetHandleId(u), id) != 0
    endfunction

    private function EndShadowBootsForm takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local ShadowBootsHeroForm f = LoadInteger(HTSBforms, GetHandleId(t), 1)
        local integer i = 0

        // Restore original vertex color
        call SetUnitVertexColor(f.u, f.originalR, f.originalG, f.originalB, f.originalA)

        loop
            exitwhen i > 8
            call DestroyEffect(f.eff[i])
            set i = i + 1
        endloop

        call SaveInteger(HTSBforms, GetHandleId(f.u), f.idForm, 0)
        call FlushChildHashtable(HTSBforms, GetHandleId(f.t))
        call DestroyTimer(f.t)
        set f.t = null

        call f.destroy()
        set t = null
    endfunction

    function UnitAddShadowBootsTimeForm takes unit u, integer formId, real duration returns nothing
        local ShadowBootsHeroForm f = getShadowBootsForm(u, formId)
        if f == 0 then
            return
        endif
        call TimerStart(f.t, TimerGetRemaining(f.t) + duration, false, function EndShadowBootsForm)
    endfunction

    function UnitAddShadowBootsForm takes unit u, integer formId, real duration returns nothing
        local ShadowBootsHeroForm f = getShadowBootsForm(u, formId)

        if f == 0 then
            set f = CreateShadowBootsForm(u, formId)
            set f.u = u

            if formId == FORM_SHADOWBOOTS then
                set f.idForm = FORM_SHADOWBOOTS

                // Save original color
                set f.originalR = 255
                set f.originalG = 255
                set f.originalB = 255
                set f.originalA = 255

                // Apply shadow tint
                call SetUnitVertexColor(u, 25, 25, 25, 255)

                set f.eff[0] = AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "hand left")
                set f.eff[1] = AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "hand right")
                set f.eff[2] = AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "weapon")
                set f.eff[3] = AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "foot left")
                set f.eff[4] = AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "foot right")
                set f.eff[5] = AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "chest")
                set f.eff[6] = AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "head")
                set f.eff[7] = null
            endif
        elseif duration < TimerGetRemaining(f.t) then
            set duration = TimerGetRemaining(f.t)
        endif

        call TimerStart(f.t, duration, false, function EndShadowBootsForm)
    endfunction
endlibrary

