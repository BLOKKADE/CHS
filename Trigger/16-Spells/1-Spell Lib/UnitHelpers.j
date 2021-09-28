library UnitHelpers initializer init
    globals
        boolexpr IsUnitSpellTargetFilter
        boolexpr IsUnitTargetFilter
        player VisibilityOwner
    endglobals

    native UnitAlive takes unit id returns boolean

    function GetAttackDamage takes unit u returns real
        return SpellData[GetHandleId(u)].real[7]
    endfunction

    function IsUnitMagicImmune takes unit u returns boolean
        return IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE)
    endfunction

    function IsUnitTargettable takes unit u returns boolean
        return GetUnitAbilityLevel(u, 'Aloc') == 0 and GetUnitAbilityLevel(u, 'Avul') == 0
    endfunction

    function IsUnitTarget takes unit u returns boolean
        return IsUnitTargettable(u) and UnitAlive(u)
    endfunction

    function IsUnitTargetCheck takes unit u, player p returns boolean
        return IsUnitTargettable(u) and UnitAlive(u) and IsUnitVisible(u, p)
    endfunction

    function IsUnitSpellTargetCheck takes unit u, player p returns boolean
        return IsUnitTargettable(u) and UnitAlive(u) and IsUnitVisible(u, p) and not IsUnitMagicImmune(u)
    endfunction

    function IsUnitTargetFilterFunc takes nothing returns boolean
        return IsUnitTargetCheck(GetFilterUnit(), VisibilityOwner)
    endfunction

    function IsUnitSpellTargetFilterFunc takes nothing returns boolean
        return IsUnitSpellTargetCheck(GetFilterUnit(), VisibilityOwner)
    endfunction

    function EnumTargettableUnitsInRange takes group g, real x, real y, real range, player owner, boolean allowMagicImmune returns nothing
        set VisibilityOwner = owner
        if allowMagicImmune then
            call GroupEnumUnitsInRange(g, x, y, range, IsUnitTargetFilter)
        else
        call GroupEnumUnitsInRange(g, x, y, range, IsUnitSpellTargetFilter)
        endif
    endfunction

    private function init takes nothing returns nothing
        set IsUnitSpellTargetFilter = Filter(function IsUnitSpellTargetFilterFunc)
        set IsUnitTargetFilter = Filter(function IsUnitTargetFilterFunc)
    endfunction
endlibrary