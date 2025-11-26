library Purge requires RandomShit, TimerUtils

    /*struct SpeedReset
        unit u
        real originalSpeed

        static method onExpire takes nothing returns nothing
            local timer t = GetExpiredTimer()
            local SpeedReset this = GetTimerData(t)

            if IsUnitAliveBJ(this.u) then
                call SetUnitMoveSpeed(this.u, RMaxBJ(100.0, RMinBJ(this.originalSpeed, 522.0)))
            endif

            call ReleaseTimer(t)
            call this.destroy()
        endmethod

        static method apply takes unit u, real newSpeed returns nothing
            local SpeedReset this = SpeedReset.create()
            local timer t = NewTimer()

            set this.u = u
            set this.originalSpeed = GetUnitMoveSpeed(u) // Store BEFORE changing

            call SetUnitMoveSpeed(u, RMaxBJ(100.0, RMinBJ(newSpeed, 522.0)))
            call SetTimerData(t, this)
            call TimerStart(t, 5.0, false, function SpeedReset.onExpire)
        endmethod
    endstruct

    function PurgeSingle takes unit source, unit target, integer lvl returns nothing
        local player owner = GetOwningPlayer(source)
        local boolean isAlly = IsPlayerAlly(GetOwningPlayer(target), owner)
        local integer targetId = GetUnitTypeId(target)
        local real dmg = BlzGetUnitMaxHP(target) * 0.50
        local real currentSpeed = GetUnitMoveSpeed(target)

        if GetUnitAbilityLevel(target, 'B00N') >= 1 then
            set dmg = dmg * 0.5
        endif

        if not isAlly and not IsCreepUnitType(targetId) and (IsUnitIllusion(target) or not IsUnitType(target, UNIT_TYPE_HERO) or targetId == STOMP_TREE_UNIT_ID) then
            set udg_NextDamageAbilitySource = PURGE_ABILITY_ID
            call Damage.apply(source, target, dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
        endif

        if isAlly then
            call RemoveUnitBuffs(target, BUFFTYPE_NEGATIVE, false)
            call SpeedReset.apply(target, currentSpeed + 1000.0)
        else
            call RemoveUnitBuffs(target, BUFFTYPE_POSITIVE, false)
            call SpeedReset.apply(target, currentSpeed * 0.5)
        endif

        call TempFx.target("Abilities\\Spells\\Items\\AIlb\\AIlbTarget.mdl", target, "overhead", 1.0, false)
    endfunction

    function Purge takes unit source, unit target, integer lvl returns nothing
        local integer i = 0
        local group g
        local unit u
        local boolean targetIsAlly = IsPlayerAlly(GetOwningPlayer(target), GetOwningPlayer(source))

        if UnitHasItemOfTypeBJ(source, 'I0A0') then
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, GetUnitX(source), GetUnitY(source), 700.0, null)

            loop
                set u = FirstOfGroup(g)
                exitwhen u == null or i >= 10
                call GroupRemoveUnit(g, u)

                if IsUnitAliveBJ(u) and IsPlayerAlly(GetOwningPlayer(u), GetOwningPlayer(source)) == targetIsAlly then
                    call PurgeSingle(source, u, lvl)
                    set i = i + 1
                endif
            endloop

            call DestroyGroup(g)
        else
            call PurgeSingle(source, target, lvl)
        endif

        set g = null
        set u = null
    endfunction*/

endlibrary
