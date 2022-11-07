library HeroForm initializer init
    globals
        hashtable HTforms = InitHashtable()

        integer FORM_SHADOW = 1
    endglobals


    struct HeroForm
        integer idForm = 0
        timer t = CreateTimer()
        unit u = null
        effect array eff[8] 



    endstruct

    private function getForm takes unit u, integer id returns HeroForm
        return LoadInteger(HTforms, GetHandleId(u), id)
    endfunction

    private function CreateForm takes unit u, integer id returns HeroForm
        local HeroForm f = HeroForm.create()
        set f.u = u
        call SaveInteger(HTforms, GetHandleId(f.t), 1, f)
        call SaveInteger(HTforms, GetHandleId(u), id, f)
        return f
    endfunction

    function UnitHasForm takes unit u, integer id returns boolean
        return LoadInteger(HTforms, GetHandleId(u), id) != 0
    endfunction


    private function EndForm takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local HeroForm f = LoadInteger(HTforms, GetHandleId(t), 1)
        local integer i = 0

        loop
            exitwhen i > 8
            call DestroyEffect(f.eff[i])
            set i = i + 1
        endloop
        call SaveInteger(HTforms, GetHandleId(f.u), f.idForm, 0)
        call FlushChildHashtable(HTforms, GetHandleId(f.t))
        call DestroyTimer(f.t)
        set f.t = null

        call f.destroy()
        set t = null
    endfunction


    function UnitAddTimeForm takes unit u, integer formId, real duration returns nothing
        local HeroForm f = getForm(u, formId)

        if f == 0 then
            return
        endif

        call TimerStart(f.t, TimerGetRemaining(f.t) + duration, false, function EndForm )
    endfunction 

    function UnitAddForm takes unit u, integer formId, real duration returns nothing
        local HeroForm f = getForm(u, formId)

        if f == 0 then
            set f = CreateForm(u, formId)
            set f.u = u

            if formId == FORM_SHADOW then
                set f.idForm = FORM_SHADOW
                set f.eff[0] = AddSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "hand left")
                set f.eff[1] = AddSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "hand right")
                set f.eff[2] = AddSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "weapon")
                set f.eff[3] = AddSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "foot left")
                set f.eff[4] = AddSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "foot right")
                set f.eff[5] = AddSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "chest")
                set f.eff[6] = AddSpecialEffectTarget("Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl", u, "head")
                set f.eff[7] = null
            endif
        elseif duration < TimerGetRemaining(f.t) then
            set duration = TimerGetRemaining(f.t)
        endif

        call TimerStart(f.t, duration, false, function EndForm )
    endfunction

    private function init takes nothing returns nothing

    endfunction
endlibrary