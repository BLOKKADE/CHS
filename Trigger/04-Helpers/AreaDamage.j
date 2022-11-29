library AreaDamage requires DamageEngine, UnitHelpers
    
    private struct AreaDamageData
        unit source
        real x
        real y
        real damage
        real area
        boolean onHit
        integer abilSourceId
        boolean magicDamage
    endstruct

    private function DealAreaDamage takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local AreaDamageData data = GetTimerData(t)
        local integer i = 0
        local integer size = 0
        local unit p = null

        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, data.x, data.y, data.area, GetOwningPlayer(data.source), false, Target_Enemy)
        set size = BlzGroupGetSize(ENUM_GROUP)

        loop
            set p = FirstOfGroup(ENUM_GROUP)
            //call BJDebugMsg("i: " + I2S(i) + ", size: " + I2S(size) + ", p: " + I2S(GetHandleId(p)))
            exitwhen p == null or i > size
            if data.onHit then
                set udg_NextDamageType = DamageType_Onhit
            endif
            set udg_NextDamageAbilitySource = data.abilSourceId

            if data.magicDamage then
                call Damage.applyMagic(data.source, p, data.damage, DAMAGE_TYPE_MAGIC)
            else
                call Damage.applyPhys(data.source, p, data.damage, false, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            endif
            call GroupRemoveUnit(ENUM_GROUP, p)
            set i = i + 1
        endloop

        set t = null
        set data.source = null
        call data.destroy()

        set p = null
    endfunction

    function AreaDamage takes unit source, real x, real y, real damage, real area, boolean onHit, integer abilSourceId, boolean magicDamage returns nothing
        local timer t = NewTimer()
        local AreaDamageData timerData = AreaDamageData.create()
        set timerData.source = source
        set timerData.x = x
        set timerData.y = y
        set timerData.damage = damage
        set timerData.area = area
        set timerData.onHit = onHit
        set timerData.abilSourceId = abilSourceId
        set timerData.magicDamage = magicDamage

        call SetTimerData(t, timerData)
        call TimerStart(t, 0, false, function DealAreaDamage)

        set t = null
    endfunction
endlibrary