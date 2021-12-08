library ChannelingAbilities initializer init requires CastSpellOnTarget

    globals
        Table AssociatedAbil
    endglobals

    private function init takes nothing returns nothing
        set AssociatedAbil = Table.create()
        set AssociatedAbil[BLIZZARD_ABILITY_ID] = BLIZZARD_DUMMY_ABILITY_ID//Blizzard
        set AssociatedAbil[FOG_ABILITY_ID] = CLOUD_DUMMY_ABILITY_ID//Fog
        set AssociatedAbil[TRANQUILITY_ABILITY_ID] = TRANQUILITY_DUMMY_ABILITY_ID//Tranquility
        set AssociatedAbil[STARFALL_ABILITY_ID] = STARFALL_DUMMY_ABILITY_ID//Starfall
        set AssociatedAbil[MONSOON_ABILITY_ID] = MONSOON_DUMMY_ABILITY_ID//Monsoon
        set AssociatedAbil[RAIN_OF_FIRE_ABILITY_ID] = RAIN_OF_FIRE_DUMMY_ABILITY_ID//Rain of Fire
        set AssociatedAbil[STAMPEDE_ABILITY_ID] = STAMPEDE_DUMMY_ABILITY_ID//Stampede
        set AssociatedAbil[VOLCANO_ABILITY_ID] = VOLCANO_DUMMY_ABILITY_ID//Volcano
        set AssociatedAbil[CLUSTER_ROCKETS_ABILITY_ID] = CLUSTER_ROCKETS_DUMMY_ABILITY_ID//Cluster Rockets
        set AssociatedAbil[ACID_SPRAY_ABILITY_ID] = ACID_SPRAY_DUMMY_ABILITY_ID//Acid Spray
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
        if abilId != TRANQUILITY_DUMMY_ABILITY_ID and abilId != STARFALL_DUMMY_ABILITY_ID then
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
        if abilId==MONSOON_DUMMY_ABILITY_ID then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"blizzard",spellLoc)
        elseif abilId==MONSOON_DUMMY_ABILITY_ID then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"rainoffire",spellLoc)
        elseif abilId==MONSOON_DUMMY_ABILITY_ID then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"stampede",spellLoc)
        elseif abilId==MONSOON_DUMMY_ABILITY_ID then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"volcano",spellLoc)
        elseif abilId==MONSOON_DUMMY_ABILITY_ID then
            call IssueImmediateOrderBJ(GetLastCreatedUnit(),"tranquility")
        elseif abilId==MONSOON_DUMMY_ABILITY_ID then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"cloudoffog",spellLoc)
        elseif abilId==MONSOON_DUMMY_ABILITY_ID then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"monsoon",spellLoc)
        elseif 
        endif
        */
    endfunction

    function CastChannelAbility takes unit caster, integer abilId, real x, real y, integer level returns nothing
        call CastSpell(caster, null, AssociatedAbil[abilId], level, GetAbilityOrderType(abilId), x, y).activate()
    endfunction
endlibrary