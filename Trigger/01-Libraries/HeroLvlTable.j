
library HeroLvlTable initializer init requires Table, RandomShit
    globals
        HashTable PassiveBonus
        HashTable PassiveBonusStr
        Table PassiveBonusIndex
    endglobals

    function UpdateBonus takes unit u, integer index, real value returns nothing
        set PassiveBonus[GetHandleId(u)].real[index] = PassiveBonus[GetHandleId(u)].real[index] + value
    endfunction

    function SetBonus takes unit u, integer index, real value returns nothing
        set PassiveBonus[GetHandleId(u)].real[index] = value
    endfunction

    function GetBonus takes unit u, integer index returns real
        return PassiveBonus[GetHandleId(u)].real[index]
    endfunction

    function SetBonusStr takes integer uid, integer index, string value returns nothing
        set PassiveBonusStr[uid].string[index] = value
    endfunction

    function GetBonusStr takes integer uid, integer index returns string
        return PassiveBonusStr[uid].string[index]
    endfunction

    function GetPassiveStr takes unit u returns string
        local string s = "\n"
        local integer i = 0
        local string bonusStr = ""
        local real value = 0
        local integer uid = GetUnitTypeId(u)
        loop
            set value = GetBonus(u, i)
            set bonusStr = GetBonusStr(uid, i)
            if bonusStr != "" then
                set s = s + "\n" + ReplaceText(",0,", R2S(value), bonusStr)
            endif
            set i = i + 1
            exitwhen i > 2
        endloop

        return s
    endfunction

    private function init takes nothing returns nothing
        set PassiveBonus = HashTable.create()
        set PassiveBonusStr = HashTable.create()
        set PassiveBonusIndex = Table.create()

        //,0, for entry
        call SetBonusStr('E000', 0, "|cffe7544aStrength bonus|r: ,0,")
        call SetBonusStr('E000', 1, "|cffd6e049Agility bonus|r: ,0,")
        call SetBonusStr('E000', 2, "|cff4daed4Intelligence bonus|r: ,0,")

        call SetBonusStr('H005', 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr('H006', 0, "|cffe7544aSummon hit point bonus|r: ,0,")
        call SetBonusStr('H006', 1, "|cffd6e049Summon armor bonus|r: ,0,")

        call SetBonusStr('H002', 0, "|cffe7544aLight bonus|r: ,0,")

        call SetBonusStr('H001', 0, "|cffe7544aMana bonus|r: ,0,")

        call SetBonusStr('H004', 0, "|cffe7544aDamage bonus|r: ,0,%%")

        call SetBonusStr('H003', 0, "|cffe7544aIntelligence bonus|r: ,0,")

        call SetBonusStr('O003', 0, "|cffe7544aStrength bonus|r: ,0,")
        call SetBonusStr('O003', 1, "|cffd6e049Agility bonus|r: ,0,")
        call SetBonusStr('O003', 2, "|cff4daed4Intelligence bonus|r: ,0,")

        call SetBonusStr('O004', 0, "|cffe7544aFeedback|r: ,0,")

        call SetBonusStr('O002', 0, "|cffe7544aLifesteal|r: ,0,%%")

        call SetBonusStr('O005', 0, "|cffe7544aAttack damage bonus|r: ,0,")

        call SetBonusStr('O008', 0, "|cffe7544aSummon damage bonus|r: ,0,")
        call SetBonusStr('O008', 1, "|cffd6e049Faerie Dragon damage|r: ,0,")

        call SetBonusStr('O007', 0, "|cffe7544aInitial damage|r: ,0,")
        call SetBonusStr('O007', 1, "|cffd6e049Damage per second|r: ,0,")

        call SetBonusStr('O001', 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr('O001', 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr('U000', 0, "|cffe7544aAgility bonus|r: ,0,")

        call SetBonusStr('N00K', 0, "|cffe7544aDamage|r: ,0,")
        call SetBonusStr('N00K', 1, "|cffd6e049Area of effect|r: ,0,")

        call SetBonusStr('N024', 0, "|cffe7544aArmor bonus|r: ,0,")
        call SetBonusStr('N024', 1, "|cffd6e049hit point regeneration bonus|r: ,0,")

        call SetBonusStr('N00I', 0, "|cffe7544aRegeneration bonus|r: ,0,%%")

        call SetBonusStr('N00L', 0, "|cffe7544aTotal experience bonus|r: ,0,")

        call SetBonusStr('N00P', 0, "|cffe7544aSummon level bonus|r: ,0,")

        call SetBonusStr('N00B', 0, "|cffe7544aArmor reduction|r: ,0,")

        call SetBonusStr('N00R', 0, "|cffe7544aChakrum damage|r: ,0,%%")

        call SetBonusStr('N00O', 0, "|cffe7544aArmor bonus|r: ,0,")
        call SetBonusStr('N00O', 1, "|cffd6e049Summon armor bonus|r: ,0,")

        call SetBonusStr('H008', 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr('N00Q', 0, "|cffe7544aAttack damage bonus|r: ,0,")

        call SetBonusStr('N00C', 0, "|cffe7544aHit point bonus|r: ,0,")

        call SetBonusStr('O006', 0, "|cffe7544aAbsolute slot bonus|r: ,0,")

        call SetBonusStr('H007', 0, "|cffe7544aBase Crit bonus|r: ,0,%%")

        call SetBonusStr('H000', 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr('H016', 0, "|cffe7544aInitial damage|r: ,0,")
        call SetBonusStr('H016', 1, "|cffd6e049Damage per second|r: ,0,")

        call SetBonusStr('H017', 0, "|cffe7544aBlock bonus|r: ,0,")

        call SetBonusStr('N02K', 0, "|cffe7544aAttack speed reduction|r: ,0,")

        call SetBonusStr('H018', 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr('N02P', 0, "|cffe7544aExperience per kill|r: ,0,")
        call SetBonusStr('N02P', 1, "|cffd6e049Gold per kill|r: ,0,")

        call SetBonusStr('H019', 0, "|cffe7544aDamage|r: ,0,")
        call SetBonusStr('H019', 1, "|cffd6e049Hero Stun|r: ,0, seconds")
        call SetBonusStr('H019', 2, "|cff4daed4Creep Stun|r: ,0, seconds")

        call SetBonusStr('H01B', 0, "|cffe7544aDamage|r: ,0,%%")

        call SetBonusStr('H01C', 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr('H01D', 0, "|cffe7544aXesil's Legacy Chance|r: ,0,")
        call SetBonusStr('H01D', 1, "|cffd6e049Mana bonus|r: ,0,")
        call SetBonusStr('H01D', 2, "|cff4daed4Mana regeneration bonus|r: ,0,")

        call SetBonusStr('H01E', 0, "|cffe7544aChance|r: ,0,%%")

        call SetBonusStr('O00A', 0, "|cffe7544aAttack speed bonus|r: ,0,%%")

        call SetBonusStr('O00B', 0, "|cffe7544aStrength bonus|r: ,0,")
        call SetBonusStr('O00B', 1, "|cffd6e049Armor limit|r: ,0,")

        call SetBonusStr('O00C', 0, "|cffe7544aEvasion bonus|r: ,0,")
        call SetBonusStr('O00C', 1, "|cffd6e049Counter damage|r: ,0,")

        call SetBonusStr('H01F', 0, "|cffe7544aStat bonus per attack|r: ,0,")

        call SetBonusStr('H01G', 0, "|cffe7544aMagic power bonus|r: ,0,")

        call SetBonusStr('H01H', 0, "|cffe7544aAttack damage bonus|r: ,0,%%")

        call SetBonusStr('H01J', 0, "|cffe7544aAttack damage|r: ,0,")
        call SetBonusStr('H01J', 1, "|cffd6e049Strength bonus|r: ,0,")
        call SetBonusStr('H01J', 2, "|cff4daed4Duration|r: ,0, seconds")

        call SetBonusStr('H00A', 0, "|cffe7544aTotal glory gained|r: ,0,")
    endfunction
endlibrary