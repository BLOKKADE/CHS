library DamageEngineHelpers

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
endlibrary