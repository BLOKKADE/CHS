library StatHelpers
    globals
        integer Stat_Strength = 0
        integer Stat_Agility = 1
        integer Stat_Intelligence = 2

        string Stat_Strength_Text = "Strength"
        string Stat_Agility_Text = "Agility"
        string Stat_Intelligence_Text = "Intelligence"

        string Stat_Strength_Colour_Text = "|cffff6e6eStrength|r"
        string Stat_Agility_Colour_Text = "|cffe4e74aAgility|r"
        string Stat_Intelligence_Colour_Text = "|cff4ae7dfIntelligence|r"
    endglobals

    function IsPrimaryStat takes unit u, integer stat returns boolean
        local integer i = BlzGetUnitIntegerField(u, UNIT_IF_PRIMARY_ATTRIBUTE)
        return (i == 1 and stat == 0) or (i == 2 and stat == 2) or (i == 3 and stat == 1)
    endfunction
    
    //Maps to the value used for bj_HEROSTAT
    function GetHeroPrimaryStat takes unit u returns integer
        local integer i = BlzGetUnitIntegerField(u, UNIT_IF_PRIMARY_ATTRIBUTE)
        if i == 1 then
            return 0 // Strength
        elseif i == 2 then
            return 2 // Intelligence
        else
            return 1 // Agility
        endif
    endfunction

    function GetHeroPrimaryStatText takes unit u, boolean colour returns string
        local integer i = BlzGetUnitIntegerField(u, UNIT_IF_PRIMARY_ATTRIBUTE)
        if colour then
            if (i == 1) then
                return Stat_Strength_Colour_Text
            elseif (i == 2) then
                return Stat_Agility_Colour_Text
            elseif (i == 3) then
                return Stat_Intelligence_Colour_Text
            endif
        else
            if (i == 1) then
                return Stat_Strength_Text
            elseif (i == 2) then
                return Stat_Agility_Text
            elseif (i == 3) then
                return Stat_Intelligence_Text
            endif
        endif

        return "Error"
    endfunction

    function SetStat takes unit u, integer stat, integer value, boolean permanent returns nothing
        if (stat == bj_HEROSTAT_STR) then
            call SetHeroStr(u, value, permanent)
        elseif (stat == bj_HEROSTAT_AGI) then
            call SetHeroAgi(u, value, permanent)
        elseif (stat == bj_HEROSTAT_INT) then
            call SetHeroInt(u, value, permanent)
        endif
    endfunction
endlibrary