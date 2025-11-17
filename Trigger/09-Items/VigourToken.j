library VigourToken requires UnitHelpers, ToggleDmgTxt

    function VigourTokenHpLoss takes unit u returns nothing
        local unit p = null
        local real dx
        local real dy
        local real dist
        local real stepFactor
        local real lossFactor

        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), false, Target_Enemy)

        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null

            set dx = GetUnitX(u) - GetUnitX(p)
            set dy = GetUnitY(u) - GetUnitY(p)
            set dist = SquareRoot(dx*dx + dy*dy)

            set stepFactor = (dist / 60.0)

            if stepFactor < 0 then
                set stepFactor = 0
            elseif stepFactor > 9 then
                set stepFactor = 9
            endif

            set lossFactor = 1.0 - (0.9/9.0) * stepFactor

            if GetUnitState(u, UNIT_STATE_LIFE) < GetUnitState(p, UNIT_STATE_LIFE) then
                call ShowLoggingText(false, ShowOtherDamageText(u, p, GetUnitState(p, UNIT_STATE_LIFE) * 0.1 * lossFactor, "Vigour Token"))
                call SetUnitState(p, UNIT_STATE_LIFE, GetUnitState(p, UNIT_STATE_LIFE) - (GetUnitState(p, UNIT_STATE_LIFE) * 0.1 * lossFactor))
                call CreateTextTagTimerColor("Vigour Token life loss!", 0.8, GetUnitX(p), GetUnitY(p), 80, 1, 255, 0, 0)
            endif

            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction

endlibrary