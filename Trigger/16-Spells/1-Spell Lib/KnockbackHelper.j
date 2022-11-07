library KnockbackHelper initializer init requires Knockback, GroupUtils

    globals
        Table KnockbackImmunityLevel
    endglobals

    function EndKnockbackImmunity takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer hid = GetTimerData(t)

        set KnockbackImmunityLevel.integer[hid] = KnockbackImmunityLevel.integer[hid] - 1
        if KnockbackImmunityLevel.integer[hid] < 1 then
            set KnockbackImmunity.boolean[hid] = false
        endif

        call ReleaseTimer(t)
        set t = null
    endfunction

    function AddTempKnockbackImmunity takes unit u, real duration returns nothing
        local integer hid = GetHandleId(u)
        set KnockbackImmunityLevel.integer[hid] = KnockbackImmunityLevel.integer[hid] + 1
        if KnockbackImmunityLevel.integer[hid] > 0 then
            set KnockbackImmunity.boolean[hid] = true
        endif
        call TimerStart(NewTimerEx(hid), duration, false, function EndKnockbackImmunity)
    endfunction

//this is copied from the pre-remake AAA, I'm not sure what to name r2, r3, r4
    function MoveToPointAoE takes unit u,real x,real y,real area, boolean allowMagicImmune, integer Target_Type, boolean OverrideKnockback returns nothing
        local unit p
        local real angle
        local real r2
        local real newX
        local real newY
        
        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, x, y, area, GetOwningPlayer(u), false, Target_Type)
        loop
            set p=FirstOfGroup(ENUM_GROUP)
            exitwhen p == null

            set angle=( 57.29582 * Atan2(GetUnitY(p) - y, GetUnitX(p) - x) ) + 180.
            set newX=x - GetUnitX(p)
            set newY=y - GetUnitY(p)
            set r2=SquareRoot(newX * newX + newY * newY)
            if r2 > 25. then
                if OverrideKnockback then
                    call KnockbackTarget(u , p , angle , r2 * 2 , r2 * 2.4 , false , false , false , false)
                else
                    if not IsKnockedBack(p) then
                        call KnockbackTarget(u , p , angle , r2 * 2 , r2 * 2.4 , false , false , false , false)
                    endif
                endif
            endif

            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
        set p=null
    endfunction

    //this is copied from the pre-remake AAA
    function MoveFromPointAoE takes unit u,real x,real y,real area,real startspeed,real decrement, boolean allowMagicImmune, integer Target_Type, boolean OverrideKnockback returns nothing
        local unit p
        local real angle
        
        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, x, y, area, GetOwningPlayer(u), false, Target_Type)
        loop
            set p=FirstOfGroup(ENUM_GROUP)
            exitwhen p == null
            set angle=57.29582 * Atan2(GetUnitY(p) - y, GetUnitX(p) - x)
            if OverrideKnockback then
                call KnockbackTarget(u , p , angle , startspeed , decrement , false , false , false , false)
            else
                if not IsKnockedBack(p) then
                    call KnockbackTarget(u , p , angle , startspeed , decrement , false , false , false , false)
                endif
            endif
            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
        set p=null
    endfunction

    //this is copied from the pre-remake AAA
    function MoveToPoint takes unit source,unit target,real x,real y returns nothing
        local real angle
        local real r2
        local real r3
        local real r4

        set angle=( 57.29582 * Atan2(GetUnitY(target) - y, GetUnitX(target) - x) ) + 180.
        set r3=x - GetUnitX(target)
        set r4=y - GetUnitY(target)
        set r2=SquareRoot(r3 * r3 + r4 * r4)
        if r2 > 25. then
            call KnockbackTarget(source , target , angle , r2 * 2 , r2 * 2.4 , false , false , false , false)
        endif
    endfunction

    private function init takes nothing returns nothing
        set KnockbackImmunityLevel = Table.create()
    endfunction
endlibrary