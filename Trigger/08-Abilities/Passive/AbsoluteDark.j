library AbsoluteDark initializer init requires RandomShit, UnitHelpers

    globals
        HashTable AbsDarkBonusTable
    endglobals

    private function GetAbsDarkBonus takes unit source, unit target returns AbsDarkBonuses
        return AbsDarkBonusTable[GetHandleId(source)].integer[GetHandleId(target)]
    endfunction 

    struct AbsDarkBonuses
        TempBonus blockBonus
        TempBonus magicProtBonus
        TempBonus armorBonus

        method setTempBonus takes TempBonus tempBonus returns nothing
            if tempBonus.state == BONUS_BLOCK then
                set this.blockBonus = tempBonus
            elseif tempBonus.state == BONUS_MAGICRES then
                set this.magicProtBonus = tempBonus
            elseif tempBonus.state == BONUS_ARMOR then
                set this.armorBonus = tempBonus
            endif
        endmethod

        method getTempBonus takes integer state returns TempBonus
            if state == BONUS_BLOCK then
                return this.blockBonus
            elseif state == BONUS_MAGICRES then
                return this.magicProtBonus
            elseif state == BONUS_ARMOR then
                return this.armorBonus
            endif

            return 0
        endmethod
    endstruct

    private function ApplyAbsDarkBonus takes AbsDarkBonuses absDarkBonuses, unit target, integer state, real value returns nothing
        local TempBonus tempBonus = absDarkBonuses.getTempBonus(state)

        if tempBonus != 0 then
            if tempBonus.bonus != 0 - value then
                //call BJDebugMsg("!= new: " + R2S(tempBonus.bonus) + ", value: " + R2S(value))
                call tempBonus.destroy()
                call absDarkBonuses.setTempBonus(TempBonus.create(target, state,0 - value, 2, ABSOLUTE_DARK_ABILITY_ID).activate())
            else
                //call BJDebugMsg("== extend")
                set tempBonus.endTick = T32_Tick + R2I(2 * 32)
            endif
        else
            //call BJDebugMsg("new: " + I2S(state) + ", value: " + R2S(value))
            call absDarkBonuses.setTempBonus(TempBonus.create(target, state,0 - value, 2, ABSOLUTE_DARK_ABILITY_ID).activate())
        endif
    endfunction

    private function SetupAbsDarkBonus takes unit source, unit target, real bonus returns nothing
        local AbsDarkBonuses absDarkBonuses = GetAbsDarkBonus(source, target)

        if absDarkBonuses == 0 then
            set absDarkBonuses = AbsDarkBonuses.create()
            //call BJDebugMsg("created")
        else
            //call BJDebugMsg("found")
        endif

        call ApplyAbsDarkBonus(absDarkBonuses, target, BONUS_BLOCK, 5 * bonus)
        call ApplyAbsDarkBonus(absDarkBonuses, target, BONUS_MAGICRES, 0.2 * bonus)
        call ApplyAbsDarkBonus(absDarkBonuses, target, BONUS_ARMOR, 2 * bonus)

        set AbsDarkBonusTable[GetHandleId(source)].integer[GetHandleId(target)] = absDarkBonuses
    endfunction

    function CastAbsoluteDark takes unit u returns nothing
        local unit target = null
        local real bonus = I2R(GetUnitAbilityLevel(u, ABSOLUTE_DARK_ABILITY_ID) * GetUnitElementCount(u, Element_Dark))/* * (1 + GetUnitAbsoluteEffective(u, Element_Dark))*/
        
        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), false, Target_Enemy)
        
        loop
            set target = FirstOfGroup(ENUM_GROUP)
            exitwhen target == null

            call SetupAbsDarkBonus(u, target, bonus)

            call GroupRemoveUnit(ENUM_GROUP, target)
        endloop

        set target = null
    endfunction

    private function init takes nothing returns nothing
        set AbsDarkBonusTable = HashTable.create()
    endfunction
endlibrary