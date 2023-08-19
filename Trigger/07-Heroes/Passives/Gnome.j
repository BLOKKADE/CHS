library Gnome initializer init requires AbilityCooldown, TempAbilSystem

    globals
        Table GnomeCharges
        Table GnomePassiveFx
    endglobals

    function GnomeIncreaseCharge takes unit u returns nothing
        local integer hid = GetHandleId(u)
        if GnomeCharges.integer[hid] < 20 then
            set GnomeCharges[hid] = GnomeCharges[hid] + 1
            call SetBonus(u, 1, GnomeCharges[hid])
        elseif GnomeCharges.integer[hid] == 20 then
            set GnomePassiveFx.effect[hid] = AddSpecialEffectTarget("Abilities\\Spells\\Orc\\Bloodlust\\BloodlustTarget.mdl", u, "overhead")
            set GnomeCharges[hid] = 21
        endif
    endfunction

    struct GnomeStruct extends array
        unit source
        integer charges
        integer nexttick
        integer endTick
        integer pid

        private method doDamage takes nothing returns nothing
            local integer level = GetHeroLevel(this.source)
            local DummyOrder dummy = DummyOrder.create(this.source, GetUnitX(this.source), GetUnitY(this.source), GetUnitFacing(this.source), 1.5)
            call dummy.addActiveAbility(GNOME_MASTER_PASSIVE_DUMMY_ABILITY_ID, 1, 852096)
            call dummy.setAbilityRealField(GNOME_MASTER_PASSIVE_DUMMY_ABILITY_ID, ABILITY_RLF_AOE_DAMAGE, 10 * level * this.charges)
            call dummy.setAbilityRealField(GNOME_MASTER_PASSIVE_DUMMY_ABILITY_ID, ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HTC3, 0.03 * this.charges)
            call dummy.instant()
            call dummy.activate()
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick > this.nexttick then
                set this.nexttick = T32_Tick + 32
                call this.doDamage()
            endif
            if T32_Tick > this.endTick or (not UnitAlive(this.source)) or CurrentlyFighting[this.pid] == false then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 
    
        static method create takes unit source, integer charges returns thistype
            local thistype this = thistype.setup()

            set this.source = source
            set this.charges = charges
            set this.pid = GetPlayerId(GetOwningPlayer(source))
            set this.endTick = T32_Tick + (R2I((this.charges - ModuloInteger(this.charges, 4)) / 4) * 32)
            set this.nexttick = T32_Tick + 32

            if charges >= 20 then
                call TempAbil.create(this.source, 'A0AD', 3)
            endif            

            call this.doDamage()
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function CastGnomePassive takes unit u returns nothing
        local integer hid = GetHandleId(u)
        local integer charges = GnomeCharges[hid]

        if charges > 0 and BlzGetUnitAbilityCooldownRemaining(u, GNOME_MASTER_PASSIVE_ABILITY_ID) == 0 then
            call BJDebugMsg("Gnome passive casted")
            if GnomePassiveFx.effect[hid] != null then
                call DestroyEffect(GnomePassiveFx.effect[hid])
                set GnomePassiveFx.effect[hid] = null
            endif

            set GnomeCharges[hid] = 0

            if charges >= 20 then
                set charges = 20
            endif

            call GnomeStruct.create(u, charges)
            call BlzStartUnitAbilityCooldown(u, GNOME_MASTER_PASSIVE_ABILITY_ID, 1)
        endif
    endfunction

    private function OnRoundStart takes EventInfo eventInfo returns nothing

        if GetUnitTypeId(eventInfo.hero) == GNOME_MASTER_UNIT_ID then
            set GnomeCharges[GetHandleId(eventInfo.hero)] = 0
        endif
    endfunction

    private function init takes nothing returns nothing
        set GnomeCharges = Table.create()
        set GnomePassiveFx = Table.create()
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.OnRoundStart)
    endfunction
endlibrary