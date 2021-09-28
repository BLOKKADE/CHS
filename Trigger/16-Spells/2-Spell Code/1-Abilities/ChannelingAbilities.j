library ChannelingAbilities initializer init requires CastSpellOnTarget

    globals
        Table AssociatedAbil
    endglobals

    private function init takes nothing returns nothing
        set AssociatedAbil = Table.create()
        set AssociatedAbil['A09U'] = 'AHbz'//
        set AssociatedAbil['A09Z'] = 'Aclf'//
        set AssociatedAbil['A09Y'] = 'AEtq'//
        set AssociatedAbil['A0A1'] = 'AEsf'//
        set AssociatedAbil['A0A0'] = 'ANmo'//
        set AssociatedAbil['A09V'] = 'ANrf'//
        set AssociatedAbil['A09W'] = 'ANst'//
        set AssociatedAbil['A09X'] = 'ANvc'//
    endfunction

    function IsChannelAbility takes integer abilId returns boolean
    return abilId == 'A09X' or abilId == 'A09U' or abilId == 'A09Z' or abilId == 'A09Y' or abilId == 'A0A1' or abilId == 'A0A0' or abilId == 'A09V' or abilId == 'A09W'
  endfunction
  /*
  function Trig_Cast_Channeling_Ability_Func001C takes unit caster, integer abilId returns boolean
    if(not(IsUnitType(caster,UNIT_TYPE_HERO)==true))then
        return false
    endif
    if(not Trig_Cast_Channeling_Ability_Func001Func002C(abilId))then
        return false
    endif
    return true
  endfunction
  
  function IsAbilityChanneling takes unit caster, integer abilId returns boolean
    if(not Trig_Cast_Channeling_Ability_Func001C(caster, abilId))then
        return false
    endif
    return true
  endfunction*/
  
  
  function ChannelingAbility takes unit caster, integer abilId, location spellLoc returns nothing
    local integer order = GetUnitCurrentOrder(caster)
    local real manaCost = BlzGetAbilityManaCost(abilId, GetUnitAbilityLevel(caster, abilId))
    //call BJDebugMsg("channel: " + GetObjectName(abilId) + " : " + GetUnitName(caster) + " : " + I2S(order))
    if abilId != 'AEtq' and abilId != 'AEsf'then
        call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(caster),PolarProjectionBJ(spellLoc,256.00,AngleBetweenPoints(spellLoc,GetUnitLoc(caster))),bj_UNIT_FACING)
    else
        call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(caster),GetUnitLoc(caster),bj_UNIT_FACING)
    endif

    call UnitApplyTimedLifeBJ(60.00,'BTLF',GetLastCreatedUnit())
    call UnitAddAbilityBJ(abilId,GetLastCreatedUnit())
    call SetUnitAbilityLevelSwapped(abilId,GetLastCreatedUnit(),GetUnitAbilityLevelSwapped(abilId,caster))

    if order == 852183 or order == 852184 then
        call IssueImmediateOrderById(GetLastCreatedUnit(), order)
    else
        call IssuePointOrderById(GetLastCreatedUnit(), order, GetLocationX(spellLoc), GetLocationY(spellLoc))
    endif
    call IssueImmediateOrder(caster, "stop")
    /*
    if abilId=='ANmo' then
    call IssuePointOrderLocBJ(GetLastCreatedUnit(),"blizzard",spellLoc)
    elseif abilId=='ANmo' then
    call IssuePointOrderLocBJ(GetLastCreatedUnit(),"rainoffire",spellLoc)
        elseif abilId=='ANmo' then
    call IssuePointOrderLocBJ(GetLastCreatedUnit(),"stampede",spellLoc)
        elseif abilId=='ANmo' then
    call IssuePointOrderLocBJ(GetLastCreatedUnit(),"volcano",spellLoc)
        elseif abilId=='ANmo' then
    call IssueImmediateOrderBJ(GetLastCreatedUnit(),"tranquility")
        elseif abilId=='ANmo' then
    call IssuePointOrderLocBJ(GetLastCreatedUnit(),"cloudoffog",spellLoc)
    elseif abilId=='ANmo' then
    call IssuePointOrderLocBJ(GetLastCreatedUnit(),"monsoon",spellLoc)
    elseif 
    endif
    */
  endfunction

  function CastChannelAbility takes unit caster, integer abilId, real x, real y, integer level returns nothing
        call CastSpell(caster, null, AssociatedAbil[abilId], level, GetAbilityOrderType(abilId), x, y).activate()
  endfunction
endlibrary