function Trig_Whirlwind_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A025'
endfunction

function Trig_Whirlwind_Damage_Func012C takes nothing returns boolean
    if ( not ( udg_MaxStat > udg_MaxBaseStat ) ) then
        return false
    endif
    return true
endfunction

function Whirlwind_Description takes unit source, real damage returns nothing
    local integer lvl = GetUnitAbilityLevel(source, 'A025')
    local real totalDamage = RMaxBJ(damage * (0.45 + (0.05 * lvl)), lvl * 50)
    local string s = GetDesriptionAbility('A025' , lvl - 1)
    
    set s = ReplaceText(",w00,", I2S(R2I(totalDamage)), s)
    
    if GetLocalPlayer() == GetOwningPlayer(source) then
        call BlzSetAbilityExtendedTooltip('A025', s, lvl - 1)
    endif
endfunction


function Trig_Whirlwind_Damage_Func030Func001C takes nothing returns boolean
    if ( not ( IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(GetTriggerUnit())) == true ) ) then
        return false
    endif
    return true
endfunction

function IsDamageWhirlwind takes unit u returns boolean
    return SpellData[GetHandleId(u)].boolean[4]
endfunction

function Trig_Whirlwind_Damage_Func030A takes nothing returns nothing
    if ( Trig_Whirlwind_Damage_Func030Func001C() ) then
        call UnitDamageTargetBJ( GetTriggerUnit(), GetEnumUnit(), I2R(udg_WhirlwindDamage), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC )
    else
    endif
endfunction

function Trig_Whirlwind_Actions takes nothing returns nothing
    local unit caster = GetTriggerUnit()
    local integer lastDamage = R2I(GetAttackDamage(caster))
    if lastDamage != 0 then
        set udg_WhirlwindDamage = lastDamage
    else
        set udg_WhirlwindDamage = BlzGetUnitBaseDamage(caster, 1)
    endif

    set udg_WhirlwindLevel = GetUnitAbilityLevelSwapped(GetSpellAbilityId(), caster)
    set udg_WhirlwindLevelMultiplier = ( 45 + (udg_WhirlwindLevel * 5))
    set udg_WhirlwindDamage = ( udg_WhirlwindDamage * udg_WhirlwindLevelMultiplier )
    set udg_WhirlwindDamage = ( udg_WhirlwindDamage / 100 )
    set udg_WhirlwindBaseDamage = ( udg_WhirlwindLevel * 50)
    set udg_WhirlwindDamage = IMaxBJ(udg_WhirlwindBaseDamage, udg_WhirlwindDamage)
    call CreateTextTagTimer(I2S(udg_WhirlwindDamage) + "!" , 1 , GetUnitX(caster) , GetUnitY(caster) , 50 , 1)
    set SpellData[GetHandleId(caster)].boolean[4] = true
    call ForGroupBJ( GetUnitsInRangeOfLocAll(500.00, GetUnitLoc(caster)), function Trig_Whirlwind_Damage_Func030A )
    set SpellData[GetHandleId(caster)].boolean[4] = false
endfunction

//===========================================================================
function InitTrig_Whirlwind takes nothing returns nothing
    set gg_trg_Whirlwind = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Whirlwind, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Whirlwind, Condition( function Trig_Whirlwind_Conditions ) )
    call TriggerAddAction( gg_trg_Whirlwind, function Trig_Whirlwind_Actions )
endfunction

