library UnitHelpers initializer init requires Utility, RandomShit
    globals
        boolexpr IsUnitSpellTargetFilter
        boolexpr IsUnitTargetFilter
        private player Owner
        private integer TargetType
    endglobals

    native UnitAlive takes unit id returns boolean

    function GetAttackDamage takes unit u returns real
        return GetUnitDamage(u, 0)
    endfunction

    function GetUnitTotalHpRegen takes unit u returns real
        return (BlzGetUnitRealField(u, ConvertUnitRealField('uhpr')) + GetUnitBonusReal(u, BONUS_HEALTH_REGEN) + (GetHeroStr(u, true) * 0.075) + GetSpellValue(0, 5, GetUnitAbilityLevel(u, UNHOLY_AURA_ABILITY_ID)) + (UnitHasItemI(u, 'I04N') * 1500))
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

    function IsUnitAllyOrEnemy takes unit u, player p, integer targetType returns boolean
        return ((targetType == Target_Any) or (targetType == Target_Ally and IsUnitAlly(GetFilterUnit(), p)) or (targetType == Target_Enemy and IsUnitEnemy(GetFilterUnit(), p)))
    endfunction

    function IsUnitTargetFilterFunc takes nothing returns boolean
        return IsUnitTargetCheck(GetFilterUnit(), Owner) and IsUnitAllyOrEnemy(GetFilterUnit(), Owner, TargetType)
    endfunction

    function IsUnitSpellTargetFilterFunc takes nothing returns boolean
        return IsUnitSpellTargetCheck(GetFilterUnit(), Owner) and IsUnitAllyOrEnemy(GetFilterUnit(), Owner, TargetType) 
    endfunction

    function EnumTargettableUnitsInRange takes group g, real x, real y, real range, player owner, boolean allowMagicImmune, integer targetType returns nothing
        set Owner = owner
        set TargetType = targetType
        if allowMagicImmune then
            call GroupEnumUnitsInArea(g, x, y, range, IsUnitTargetFilter)
        else
            call GroupEnumUnitsInArea(g, x, y, range, IsUnitSpellTargetFilter)
        endif
    endfunction

    private function init takes nothing returns nothing
        set IsUnitSpellTargetFilter = Filter(function IsUnitSpellTargetFilterFunc)
        set IsUnitTargetFilter = Filter(function IsUnitTargetFilterFunc)
    endfunction
endlibrary