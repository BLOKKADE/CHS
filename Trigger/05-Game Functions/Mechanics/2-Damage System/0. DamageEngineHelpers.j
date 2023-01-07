library DamageEngineHelpers requires TimerUtils

    function IsPhysDamage takes nothing returns boolean
        return Damage.index.damageType == DAMAGE_TYPE_NORMAL
    endfunction

    function IsMagicDamage takes nothing returns boolean
        return Damage.index.damageType == DAMAGE_TYPE_MAGIC
    endfunction

    function IsOnHitDamage takes nothing returns boolean
        return DamageIsOnHit > 0
    endfunction

    function IsNotOnHitOrIsDivineBubbleOnHit takes nothing returns boolean
        return DamageIsOnHit == 0 or DamageIsOnHit == 2
    endfunction

    function GetUnitEffectiveArmor takes unit u returns real
        return BlzGetUnitArmor(u) - Damage.index.armorPierced
    endfunction

    private struct DelayedDamageStruct
        unit source
        unit target
        real amount
        boolean attack
        boolean ranged
        attacktype attackType
        damagetype damageType
        weapontype weaponType
    endstruct

    private function DealDelayedDamage takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local DelayedDamageStruct dds = GetTimerData(t)

        call Damage.apply(dds.source, dds.target, dds.amount, dds.attack, dds.ranged, dds.attackType, dds.damageType, dds.weaponType)

        set dds.source = null
        set dds.target = null
        call ReleaseTimer(t)
        call dds.destroy()
        set t = null
    endfunction

    function DelayedDamage takes unit source, unit target, real amount, boolean attack, boolean ranged, attacktype attackType, damagetype damageType, weapontype weaponType returns nothing
        local timer t = NewTimer()
        local DelayedDamageStruct dds = DelayedDamageStruct.create()
        set dds.source = source
        set dds.target = target
        set dds.amount = amount
        set dds.attack = attack
        set dds.ranged = ranged
        set dds.attackType = attackType
        set dds.damageType = damageType
        set dds.weaponType = weaponType
        call SetTimerData(t, dds)
        call TimerStart(t, 0.0, false, function DealDelayedDamage)
        set t = null
    endfunction
endlibrary