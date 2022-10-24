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
        //set AssociatedAbil[VOLCANO_ABILITY_ID] = VOLCANO_DUMMY_ABILITY_ID//Volcano
        set AssociatedAbil[CLUSTER_ROCKETS_ABILITY_ID] = CLUSTER_ROCKETS_DUMMY_ABILITY_ID//Cluster Rockets
        set AssociatedAbil[ACID_SPRAY_ABILITY_ID] = ACID_SPRAY_DUMMY_ABILITY_ID//Acid Spray
    endfunction

    function IsChannelAbility takes integer abilId returns boolean
        return AssociatedAbil[abilId] != 0
    endfunction

    function CastChannelAbility takes unit caster, integer abilId, real x, real y, integer level returns nothing
        call CastSpell(caster, null, AssociatedAbil[abilId], level, GetAbilityOrderType(abilId), x, y).activate()
    endfunction
endlibrary