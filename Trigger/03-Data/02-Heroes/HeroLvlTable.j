
library HeroLvlTable initializer init requires Table, ReplaceTextLib
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

    // replaces ,0, of the description of a unit u's passive with the updated value
    function GetPassiveStr takes unit u returns string
        local string s = "|n"
        local integer i = 0
        local string bonusStr = ""
        local real value = 0
        local integer uid = GetUnitTypeId(u)
        loop
            set value = GetBonus(u, i)
            set bonusStr = GetBonusStr(uid, i)
            if bonusStr != "" and bonusStr != null then
                set s = s + "|n" + ReplaceText(",0,", R2S(value), bonusStr)
            endif
            set i = i + 1
            exitwhen i > 3 or bonusStr == null
        endloop

        return s
    endfunction

    // ,0, is what is edited
    private function SetupHeroEditableStats takes nothing returns nothing
        call SetBonusStr(LIEUTENANT_UNIT_ID, 0, "|cffe7544aStrength bonus|r: ,0,")
        call SetBonusStr(LIEUTENANT_UNIT_ID, 1, "|cffd6e049Agility bonus|r: ,0,")
        call SetBonusStr(LIEUTENANT_UNIT_ID, 2, "|cff4daed4Intelligence bonus|r: ,0,")
        call SetBonusStr(LIEUTENANT_UNIT_ID, 3, "|cff51d44dStats on level up|r: ,0,")

        call SetBonusStr(ABOMINATION_UNIT_ID, 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr(DRUID_OF_THE_CLAY_UNIT_ID, 0, "|cffe7544aSummon stat bonus|r: ,0,%%")

        call SetBonusStr(MAULER_UNIT_ID, 0, "|cffe7544aLight bonus|r: ,0,")

        call SetBonusStr(BLOOD_MAGE_UNIT_ID, 0, "|cffe7544aBonus Intelligence|r: ,0,")

        call SetBonusStr(MORTAR_TEAM_UNIT_ID, 0, "|cffe7544aDamage bonus|r: ,0,%%")

        call SetBonusStr(NAGA_SIREN_UNIT_ID, 0, "|cffe7544aSpell damage bonus|r: ,0,%%")
        call SetBonusStr(NAGA_SIREN_UNIT_ID, 1, "|cffd6e049Intelligence damage bonus|r: ,0,")

        call SetBonusStr(AVATAR_SPIRIT_UNIT_ID, 0, "[|cffd2d2d2Light|r]|cffe7544a Attack damage bonus |r: ,0,")
        call SetBonusStr(AVATAR_SPIRIT_UNIT_ID, 1, "[|cffd2d2d2Light|r]|cffd6e049 Armor bonus|r: ,0,%%")
        call SetBonusStr(AVATAR_SPIRIT_UNIT_ID, 2, "[|cff000000Dark|r]|cff4daed4 Magic power bonus|r: ,0,")
        call SetBonusStr(AVATAR_SPIRIT_UNIT_ID, 3, "[|cff000000Dark|r]|cff51d44d magic protection bonus|r: ,0,")

        call SetBonusStr(DEMON_HUNTER_UNIT_ID, 0, "|cffe7544aFeedback|r: ,0,")

        call SetBonusStr(DEADLORD_UNIT_ID, 0, "|cffe7544aLifesteal|r: ,0,%%")

        call SetBonusStr(PYROMANCER_UNIT_ID, 0, "|cffe7544aAttack damage bonus|r: ,0,")
        call SetBonusStr(PYROMANCER_UNIT_ID, 1, "|cffd6e049Scorched Earth miss chance|r: ,0,%%")
        call SetBonusStr(PYROMANCER_UNIT_ID, 2, "|cff4daed4Scorched Earth crit chance|r: ,0,%%")
        call SetBonusStr(PYROMANCER_UNIT_ID, 3, "|cff51d44dScorched Earth/Attack area|r: ,0,")

        call SetBonusStr(MYSTIC_UNIT_ID, 0, "|cffe7544aSummon damage bonus|r: ,0,")
        call SetBonusStr(MYSTIC_UNIT_ID, 1, "|cffd6e049Faerie Dragon attack speed|r: ,0,%%")

        call SetBonusStr(PIT_LORD_UNIT_ID, 0, "|cffe7544aAbsolute Fire magic power bonus|r: ,0,%%")

        call SetBonusStr(THUNDER_WITCH_UNIT_ID, 0, "|cffe7544aDamage|r: ,0,")
        call SetBonusStr(THUNDER_WITCH_UNIT_ID, 1, "|cffd6e049Targets|r: ,0,")

        call SetBonusStr(TAUREN_UNIT_ID, 0, "|cffe7544aRune power per active spell|r: ,0,")
        call SetBonusStr(TAUREN_UNIT_ID, 1, "|cffd6e049[Element] damage bonus|r: ,0,")

        call SetBonusStr(WOLF_RIDER_UNIT_ID, 0, "|cffe7544aTotal Agility bonus|r: ,0,")
        call SetBonusStr(WOLF_RIDER_UNIT_ID, 1, "|cffd6e049Agility bonus per round|r: ,0,")
        call SetBonusStr(WOLF_RIDER_UNIT_ID, 2, "|cff4daed4Round time limit|r: ,0,")

        call SetBonusStr(BLADE_MASTER_UNIT_ID, 0, "|cffe7544aDamage|r: ,0,")
        call SetBonusStr(BLADE_MASTER_UNIT_ID, 1, "|cffd6e049Area of effect|r: ,0,")
        call SetBonusStr(BLADE_MASTER_UNIT_ID, 2, "|cff4daed4Attacks required|r: ,0,")

        call SetBonusStr(ORC_CHAMPION_UNIT_ID, 0, "|cffe7544aArmor bonus|r: ,0,")
        call SetBonusStr(ORC_CHAMPION_UNIT_ID, 1, "|cffd6e049Hit point regeneration bonus|r: ,0,")
        call SetBonusStr(ORC_CHAMPION_UNIT_ID, 2, "|cff4daed4Strength damage bonus|r: ,0,%%")

        call SetBonusStr(TROLL_HEADHUNTER_UNIT_ID, 0, "|cffe7544aRegeneration bonus|r: ,0,%%")

        call SetBonusStr(TINKER_UNIT_ID, 0, "|cffe7544aTotal experience bonus|r: ,0,")

        call SetBonusStr(BEAST_MASTER_UNIT_ID, 0, "|cffe7544aSummon level bonus|r: ,0,")

        call SetBonusStr(FALLEN_RANGER_UNIT_ID, 0, "|cffe7544aArmor reduction|r: ,0,")

        call SetBonusStr(HUNTRESS_UNIT_ID, 0, "|cffe7544aChakrum damage|r: ,0,%%")

        call SetBonusStr(SKELETON_BRUTE_UNIT_ID, 0, "|cffe7544aDuration|r: ,0, seconds")
        call SetBonusStr(SKELETON_BRUTE_UNIT_ID, 1, "|cffd6e049Hit points restored|r: ,0,%%")
        call SetBonusStr(SKELETON_BRUTE_UNIT_ID, 2, "|cff4daed4Explosion damage|r: ,0,")

        call SetBonusStr(SORCERER_UNIT_ID, 0, "|cffd6e049Cooldown|r: ,0,")
        call SetBonusStr(SORCERER_UNIT_ID, 1, "|cffe7544aSpells Casted|r: ,0,")

        call SetBonusStr(URSA_WARRIOR_UNIT_ID, 0, "|cffe7544aAttack damage bonus|r: ,0,")

        call SetBonusStr(WAR_GOLEM_UNIT_ID, 0, "|cffe7544aHit point bonus|r: ,0,%%")

        call SetBonusStr(WITCH_DOCTOR_UNIT_ID, 0, "|cffe7544aAbsolute slot bonus|r: ,0,")

        call SetBonusStr(RANGER_UNIT_ID, 0, "|cffe7544aBase Crit bonus|r: ,0,%%")

        call SetBonusStr(DARK_HUNTER_UNIT_ID, 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr(DOOM_GUARD_UNIT_ID, 0, "|cffd6e049Damage per second|r: ,0,")

        call SetBonusStr(ROCK_GOLEM_UNIT_ID, 0, "|cffe7544aStone Edge block damage|r: ,0,%%")
        call SetBonusStr(ROCK_GOLEM_UNIT_ID, 1, "|cffe7544aBlock bonus|r: ,0,%%")

        call SetBonusStr(COLD_KNIGHT_UNIT_ID, 0, "|cffe7544aAttack speed reduction|r: ,0,%%")
        call SetBonusStr(COLD_KNIGHT_UNIT_ID, 1, "|cffd6e049Movespeed reduction|r: ,0,%%")

        call SetBonusStr(LICH_UNIT_ID, 0, "|cffe7544aDamage|r: ,0,%")

        call SetBonusStr(GREEDY_GOBLIN_UNIT_ID, 0, "|cffe7544aExperience per kill|r: ,0,")
        call SetBonusStr(GREEDY_GOBLIN_UNIT_ID, 1, "|cffd6e049Gold per kill|r: ,0,")

        call SetBonusStr(GNOME_MASTER_UNIT_ID, 0, "|cffe7544aDamage|r: ,0,")
        call SetBonusStr(GNOME_MASTER_UNIT_ID, 1, "|cffd6e049Cooldown|r: ,0, seconds")
        call SetBonusStr(GNOME_MASTER_UNIT_ID, 2, "|cff4daed4Hero Stun|r: ,0, seconds")
        call SetBonusStr(GNOME_MASTER_UNIT_ID, 3, "|cff51d44dCreep Stun|r: ,0, seconds")

        call SetBonusStr(CENTAUR_ARCHER_UNIT_ID, 0, "|cffe7544aDamage|r: ,0,%%")

        call SetBonusStr(OGRE_WARRIOR_UNIT_ID, 0, "|cffe7544aDamage|r: ,0,")

        call SetBonusStr(TIME_WARRIOR_UNIT_ID, 0, "|cffe7544aXesil's Legacy Chance|r: ,0,")
        call SetBonusStr(TIME_WARRIOR_UNIT_ID, 1, "|cffd6e049Mana bonus|r: ,0,")
        call SetBonusStr(TIME_WARRIOR_UNIT_ID, 2, "|cff4daed4Mana regeneration bonus|r: ,0,")

        call SetBonusStr(OGRE_MAGE_UNIT_ID, 0, "|cffe7544aChance|r: ,0,%%")

        call SetBonusStr(TROLL_BERSERKER_UNIT_ID, 0, "|cffe7544aAttack cooldown reduction bonus|r: ,0,%%")

        call SetBonusStr(YETI_UNIT_ID, 0, "|cffe7544aStrength bonus|r: ,0,")
        call SetBonusStr(YETI_UNIT_ID, 1, "|cffd6e049Armor limit|r: ,0,")

        call SetBonusStr(SATYR_TRICKSTER_UNIT_ID, 0, "|cffe7544aEvasion bonus|r: ,0,")
        call SetBonusStr(SATYR_TRICKSTER_UNIT_ID, 1, "|cffd6e049Counter damage|r: ,0,")

        call SetBonusStr(MURLOC_WARRIOR_UNIT_ID, 0, "|cffe7544aStat bonus per attack|r: ,0,")

        call SetBonusStr(MEDIVH_UNIT_ID, 0, "|cffe7544aMagic power bonus|r: ,0,")

        call SetBonusStr(GHOUL_UNIT_ID, 0, "|cffe7544aAttack damage bonus|r: ,0,%%")

        call SetBonusStr(GRUNT_UNIT_ID, 0, "|cffe7544aAttack damage|r: ,0,")
        call SetBonusStr(GRUNT_UNIT_ID, 1, "|cffd6e049Strength bonus|r: ,0,")
        call SetBonusStr(GRUNT_UNIT_ID, 2, "|cff4daed4Duration|r: ,0, seconds")

        call SetBonusStr(ARENA_MASTER_UNIT_ID, 0, "|cffe7544aTotal glory gained|r: ,0,")
    endfunction

    private function init takes nothing returns nothing
        set PassiveBonus = HashTable.create()
        set PassiveBonusStr = HashTable.create()
        set PassiveBonusIndex = Table.create()

        call SetupHeroEditableStats()
    endfunction
endlibrary