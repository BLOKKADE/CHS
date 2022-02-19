library DamageEngineHelpers

    function IsPhysDamage takes nothing returns boolean
        return Damage.index.damageType == DAMAGE_TYPE_NORMAL
    endfunction

    function IsMagicDamage takes nothing returns boolean
        return Damage.index.damageType == DAMAGE_TYPE_MAGIC
    endfunction
endlibrary