library DrainAura requires Vampirism, DivineBubble
    private function UnitLifeDrain takes unit source, unit target, real amount, boolean maxHp returns nothing
        local real hp
        if (not IsUnitDivineBubbled(target)) and GetUnitAbilityLevel(target, BLOODSTONE_BUFF_ID) == 0 and GetUnitAbilityLevel(target, 'B022') == 0 then
            set hp = GetWidgetLife(target)

            if maxHp then
                set amount = amount * BlzGetUnitMaxHP(target)
            else
                set amount = amount * hp
            endif
            set amount = amount / 100
            
            if hp - 0.405 <= amount then
                set amount = hp
                call SetWidgetLife(target, 1)
            else
                call SetWidgetLife(target, hp - amount)
            endif

            if IsHeroUnitId(GetUnitTypeId(target)) then
                call Vamp(source, target, amount)
            else
                call Vamp(source, target, amount * 0.2)
            endif
        endif
    endfunction

    function ActivateDrainAura takes unit source, real x, real y, real amount, real area, boolean maxHp returns nothing
        local integer i = 0
        local integer size = 0
        local unit p = null

        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, x, y, area, GetOwningPlayer(source), false, Target_Enemy)
        set size = BlzGroupGetSize(ENUM_GROUP)

        loop
            set p = BlzGroupUnitAt(ENUM_GROUP, 0)
            exitwhen p == null or i > size
                call UnitLifeDrain(source, p, amount, maxHp)
                call GroupRemoveUnit(ENUM_GROUP, p)
            set i = i + 1
        endloop
        
        set p = null
    endfunction
endlibrary
