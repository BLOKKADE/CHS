library DamageEngineHelpers

    function IsPhysDamage takes nothing returns boolean
        return Damage.index.damageType == DAMAGE_TYPE_NORMAL
    endfunction

    function IsMagicDamage takes nothing returns boolean
        return Damage.index.damageType == DAMAGE_TYPE_MAGIC
    endfunction

    function GetUnitEffectiveArmor takes unit u returns real
        return BlzGetUnitArmor(u) - Damage.index.armorPierced
    endfunction
endlibrary