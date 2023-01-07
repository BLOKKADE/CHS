library BuffRepository initializer init requires Table
    globals
        HashTable BuffRepo

        integer BUFFTYPE_POSITIVE = 0
        integer BUFFTYPE_NEGATIVE = 1
        integer BUFFTYPE_BOTH = 2

        private integer BUFF_INDEX = 0
        private integer ABILITY_INDEX = 1
        private integer BUFFABILITY_INDEX = 2
        private integer BUFFTYPE_INDEX = 3
        private integer REMOVEABIL_INDEX = 4
        private integer BUFFUNPURGEABLE_INDEX = 5
    endglobals

    function IsBuff takes integer buffId returns boolean
        return BuffRepo[buffId].boolean[BUFF_INDEX]
    endfunction

    function IsBuffPurgeable takes integer buffId returns boolean
        return BuffRepo[buffId].boolean[BUFFUNPURGEABLE_INDEX]
    endfunction

    function GetBuffType takes integer buffId returns integer
        return BuffRepo[buffId].integer[BUFFTYPE_INDEX]
    endfunction

    function RemoveBuffAssociatedAbility takes integer buffId returns boolean
        return BuffRepo[buffId].boolean[REMOVEABIL_INDEX]
    endfunction

    function GetBuffAssociatedAbility takes integer buffId returns integer
        return BuffRepo[buffId].integer[ABILITY_INDEX]
    endfunction

    function SetupBuffAndBuffAbilAndAbil takes integer buffId, integer buffAbil, integer abilId, integer buffType, boolean unpurgeable, boolean removeAbil returns nothing
        set BuffRepo[buffId].boolean[BUFF_INDEX] = true
        set BuffRepo[buffId].integer[ABILITY_INDEX] = abilId
        set BuffRepo[buffId].integer[BUFFABILITY_INDEX] = buffAbil
        set BuffRepo[buffId].integer[BUFFTYPE_INDEX] = buffType
        set BuffRepo[buffId].boolean[BUFFUNPURGEABLE_INDEX] = unpurgeable
        set BuffRepo[buffId].boolean[REMOVEABIL_INDEX] = removeAbil
    endfunction

    //for storing the buff and the ability associated with the buff
    function SetupBuffAndAbil takes integer buffId, integer abilId, integer buffType, boolean unpurgeable returns nothing
        set BuffRepo[buffId].boolean[BUFF_INDEX] = true
        set BuffRepo[buffId].integer[ABILITY_INDEX] = abilId
        set BuffRepo[buffId].integer[BUFFTYPE_INDEX] = buffType
        set BuffRepo[buffId].boolean[BUFFUNPURGEABLE_INDEX] = unpurgeable
    endfunction

    private function init takes nothing returns nothing
        
    endfunction
endlibrary
