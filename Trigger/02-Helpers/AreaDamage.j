library AreaDamage requires DamageEngine, UnitHelpers
    function AreaDamage takes unit source, real x, real y, real damage, real area, boolean onHit, integer abilSourceId, boolean magicDamage returns nothing
        local integer i = 0
        local integer size = 0
        local unit p = null

        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, x, y, area, GetOwningPlayer(source), false, Target_Enemy)
        set size = BlzGroupGetSize(ENUM_GROUP)

        loop
            set p = BlzGroupUnitAt(ENUM_GROUP, 0)
            exitwhen p == null or i > size
                if onHit then
                    set udg_NextDamageType = DamageType_Onhit
                endif
                set udg_NextDamageAbilitySource = abilSourceId

                if magicDamage then
                    call Damage.applyMagic(source, p, damage, DAMAGE_TYPE_MAGIC)
                else
                    call Damage.applyPhys(source, p, damage, false, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                endif
                call GroupRemoveUnit(ENUM_GROUP, p)
            set i = i + 1
        endloop
        
        set p = null
    endfunction
endlibrary