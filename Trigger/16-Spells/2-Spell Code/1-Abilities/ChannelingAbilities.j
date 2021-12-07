library ChannelingAbilities initializer init requires CastSpellOnTarget

    globals
        Table AssociatedAbil
    endglobals

    private function init takes nothing returns nothing
        set AssociatedAbil = Table.create()
        set AssociatedAbil['A09U'] = 'AHbz'//Blizzard
        set AssociatedAbil['A09Z'] = 'Aclf'//Fog
        set AssociatedAbil['A09Y'] = 'AEtq'//Tranquility
        set AssociatedAbil['A0A1'] = 'AEsf'//Starfall
        set AssociatedAbil['A0A0'] = 'ANmo'//Monsoon
        set AssociatedAbil['A09V'] = 'ANrf'//Rain of Fire
        set AssociatedAbil['A09W'] = 'ANst'//Stampede
        set AssociatedAbil[VOLCANO_ABILITY_ID] = 'ANvc'//Volcano
        set AssociatedAbil[CLUSTER_ROCKETS_ABILITY_ID] = 'ANcs'//Cluster Rockets
        set AssociatedAbil['A0B3'] = 'ANhs'//Acid Spray
    endfunction

    function IsChannelAbility takes integer abilId returns boolean
        return AssociatedAbil[abilId] != 0
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
    endfunction */
  
  
    function ChannelingAbility takes unit caster, integer abilId, location spellLoc returns nothing
        local integer order = GetUnitCurrentOrder(caster)
        local real manaCost = BlzGetAbilityManaCost(abilId, GetUnitAbilityLevel(caster, abilId))
        //call BJDebugMsg("channel: " + GetObjectName(abilId) + " : " + GetUnitName(caster) + " : " + I2S(order))
        if abilId != 'AEtq' and abilId != 'AEsf'then
            call CreateNUnitsAtLoc(1,PRIEST_1_UNIT_ID,GetOwningPlayer(caster),PolarProjectionBJ(spellLoc,256.00,AngleBetweenPoints(spellLoc,GetUnitLoc(caster))),bj_UNIT_FACING)
        else
            call CreateNUnitsAtLoc(1,PRIEST_1_UNIT_ID,GetOwningPlayer(caster),GetUnitLoc(caster),bj_UNIT_FACING)
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