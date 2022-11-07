library AbsoluteDarkDebuff initializer init requires RandomShit, UnitHelpers
    globals
        private group DebuffGroup = CreateGroup()
    endglobals


    struct AbsoluteDarkDebuf
        real block = 0
        real magick = 0
        real armor = 0
        real power = 0
        unit u = null
        timer t = null

    endstruct

    private function endAbsoluteDarkDebufT takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local AbsoluteDarkDebuf a = LoadInteger(HT, GetHandleId(t), 1)
        set a.power = 0
        call AddUnitBlock(a.u, a.block)
        set a.block = 0
        call AddUnitMagicDef(a.u, a.magick)
        set a.magick = 0
        call BlzSetUnitArmor(a.u, BlzGetUnitArmor(a.u) +a.armor)
        set a.armor = 0

        set a.t = null
        call FlushChildHashtable(HT,GetHandleId(t))
        call DestroyTimer(t)
        set t = null
    endfunction

    public function AbsoluteDarkDebuffExecute takes unit u returns nothing
        local unit u2 = null
        local AbsoluteDarkDebuf a = 0
        local real bonus = I2R(GetUnitAbilityLevel(u, ABSOLUTE_DARK_ABILITY_ID) * GetUnitElementCount(u, Element_Dark))/* * (1 + GetUnitAbsoluteEffective(u, Element_Dark))*/
        call EnumTargettableUnitsInRange(DebuffGroup, GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), false, Target_Enemy)
        loop
            set u2 = FirstOfGroup(DebuffGroup)
            exitwhen u2 == null
            set a = LoadInteger(HT,GetHandleId(u2), ABSOLUTE_DARK_ABILITY_ID)
            if a == 0 then
                set a = AbsoluteDarkDebuf.create()
                set a.u = u2
                call SaveInteger(HT,GetHandleId(u2),  ABSOLUTE_DARK_ABILITY_ID, a)
            endif

            if a.power < bonus then
                if a.t == null then
                    set a.t = CreateTimer()
                endif
                set a.power = bonus
                call SaveInteger(HT, GetHandleId(a.t), 1, a)

                set a.block = 5*bonus
                call AddUnitBlock(u2, -a.block)

                set a.magick = 0.2 * bonus
                call AddUnitMagicDef(u2, -a.magick)

                set a.armor = bonus
                call BlzSetUnitArmor(u2, BlzGetUnitArmor(u2) - a.armor)

                set a.u = u2
            endif

            call TimerStart(a.t, 0.3, false, function endAbsoluteDarkDebufT)
            call GroupRemoveUnit(DebuffGroup, u2)
        endloop
        set u2 = null
    endfunction

    private function checkUnits takes nothing returns nothing
        local integer II = 0
        local unit u = null
        loop
            exitwhen II > 8
            set u = PlayerHeroes[II]
            if GetUnitAbilityLevel(u, ABSOLUTE_DARK_ABILITY_ID) > 0 then
                call AbsoluteDarkDebuffExecute(u)
            endif
            set II = II + 1
        endloop

        set u = null
    endfunction



    private function init takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic( t, 0.2 )
        call TriggerAddAction( t, function checkUnits )
        set t = null
    endfunction
endlibrary