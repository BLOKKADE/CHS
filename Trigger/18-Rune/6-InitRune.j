library RuneInit initializer init requires RandomShit, ChaosRune, WindRune, LifeRune, EarthRune, AttackRune, PowerRune
    globals
        Table RunesIndex
        HashTable PlayerRunes
        integer array Runes
        trigger array RunesTriggers
        string array RunesName
        integer RuneCount = 0

        unit GLOB_RUNE_U = null
        real GLOB_RUNE_POWER = 0
    endglobals
    
    function GetRunePower takes item i returns real 
        return 1. + LoadReal(HT,GetHandleId(i),2)/100
    endfunction
    
    function GetUnitPowerRune takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),6)
    endfunction

    function CreateRune takes item rune, real power, real x, real y, unit owner, integer id returns item
        local player p = GetOwningPlayer(owner)
        local integer pid = GetPlayerId(p)
        local integer runeIndex = PlayerRunes[pid].integer[0] + 1
        set rune = CreateItem( Runes[id], x, y)
        set RunesIndex[0] = RunesIndex[0] + 1
        set RunesIndex.item[RunesIndex[0]] = rune
        set PlayerRunes[pid].integer[runeIndex] = RunesIndex[0]
        set PlayerRunes[pid].integer[0] = runeIndex
        call SaveReal(HT,GetHandleId(rune),2,power+GetUnitPowerRune(owner) + GetHeroLevel(owner) )
        if GetLocalPlayer() != p then
            call BlzSetItemSkin(rune,'I06F')
        endif
        return rune
    endfunction

    function CreateRandomRune takes real power, real x, real y, unit owner returns item
        return CreateRune(null, power, x, y, owner, GetRandomInt(1,RuneCount))
    endfunction 

    function InitialiseRune takes nothing returns nothing
        local integer IdRune = 0
        set IdRune = LoadInteger(HT,GetItemTypeId(GetManipulatedItem()),1)
        if IdRune > 0 then
            set GLOB_RUNE_U = GetTriggerUnit()
            set GLOB_RUNE_POWER = GetRunePower(GetManipulatedItem())
            call CreateTextTagTimerColor( RunesName[IdRune] + ": " + I2S(R2I(GLOB_RUNE_POWER*100))+"%"  ,1,GetUnitX(GLOB_RUNE_U),GetUnitY(GLOB_RUNE_U),50+GetRandomInt(0,150),1,122,50,255)
            call TriggerEvaluate(RunesTriggers[IdRune])
        endif
    endfunction

    function AddRune takes integer i, code c, string s returns nothing
        local trigger t = CreateTrigger()
        set RuneCount = RuneCount + 1
        set Runes[RuneCount] = i
        set RunesName[RuneCount] = s
        call SaveInteger(HT, i, 1, RuneCount)
        call TriggerAddCondition(t, Condition(c))
        set RunesTriggers[RuneCount] = t
        set t = null
    endfunction

    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_DROP_ITEM)
        call TriggerAddAction( trg, function InitialiseRune )
        set trg = null

        set PlayerRunes = HashTable.create()
        set RunesIndex = Table.create()

        call AddRune('I08D',function RuneOfAttack, "Battle Rune")
        call AddRune('I08J',function RuneOfChaos, "Chaos Rune")
        call AddRune('I08G',function RuneOfFire, "Fire Rune")
        call AddRune('I088',function RuneOfLife, "Life Rune")
        call AddRune('I08B',function RuneOfMagic, "Magic Rune")    
        call AddRune('I08F',function RuneOfHealing, "Healing Rune")
        call AddRune('I08C',function RuneOfPower, "Power Rune")
        call AddRune('I08H',function RuneOfEarth, "Earth Rune")
        set RuneOfStorm_b = Condition(function CastRuneOfStorm)
        call AddRune('I08I',function RuneOfStorm, "Water Rune")
        set RuneOfWinds_b = Condition(function CastRuneOfWinds)    
        call AddRune('I08O',function RuneOfWinds, "Wind Rune")   
        call AddRune('I0AY',function BloodRune, "Blood Rune")
        //call AddRune('I0AZ',function SpiritRune, "Spirit Rune")
        call AddRune('I0AV',function DarkRune, "Dark Rune")
        call AddRune('I0AW',function LightRune, "Light Rune")
        call AddRune('I0AX',function PoisonRune, "Poison Rune")
        call AddRune('I0AU',function WildRune, "Wild Rune")
    endfunction
endlibrary