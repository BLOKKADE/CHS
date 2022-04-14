library RuneInit initializer init requires RandomShit, ChaosRune, WindRune, LifeRune, EarthRune, AttackRune, PowerRune
    globals
        Table RuneIndex
        integer array Runes
        trigger array RunesTriggers
        string array RunesName
        integer RuneCount = 16

        unit GLOB_RUNE_U = null
        real GLOB_RUNE_POWER = 0

        integer Defense_Rune_Id = 1
        integer Chaos_Rune_Id = 2
        integer Fire_Rune_Id = 3
        integer Life_Rune_Id = 4
        integer Time_Rune_Id = 5
        integer Healing_Rune_Id = 6
        integer Power_Rune_Id = 7
        integer Earth_Rune_Id = 8
        integer Water_Rune_Id = 9
        integer Wind_Rune_Id = 10
        integer Blood_Rune_Id = 11
        integer Dark_Rune_Id = 12
        integer Light_Rune_Id = 13
        integer Poison_Rune_Id = 14
        integer Wild_Rune_Id = 15
        integer Might_Rune_Id = 16
    endglobals
    
    function GetRunePower takes item i returns real 
        return 1. + LoadReal(HT,GetHandleId(i),2)/ 100
    endfunction

    function AddRunePower takes item it, real value returns nothing
        call SaveReal(HT,GetHandleId(it),2, LoadReal(HT,GetHandleId(it),2) + value)
    endfunction

    function SetRunePower takes item it, real value returns nothing
        call SaveReal(HT,GetHandleId(it),2, value)
    endfunction
    
    function GetUnitPowerRune takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),6)
    endfunction

    function CreateRune takes item rune, real power, real x, real y, unit owner, integer id returns item
        local player p = GetOwningPlayer(owner)
        local integer pid = GetPlayerId(p)
        set rune = CreateItem( Runes[id], x, y)
        set RuneIndex[GetHandleId(rune)] = pid
        //call BJDebugMsg("rune: " + R2S(power) + "source: " + R2S(GetUnitPowerRune(owner)) + " lvl: " + I2S(GetHeroLevel(owner)) + " id: " + I2S(RuneIndex[GetHandleId(rune)]))
        call SetRunePower(rune, power + GetUnitPowerRune(owner) + GetHeroLevel(owner))
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
            call CreateTextTagTimerColor( RunesName[IdRune] + ": " + I2S(R2I(GLOB_RUNE_POWER * 100))+ "%"  ,1,GetUnitX(GLOB_RUNE_U),GetUnitY(GLOB_RUNE_U),50 + GetRandomInt(0,150),1,122,50,255)
            call TriggerEvaluate(RunesTriggers[IdRune])
        endif
    endfunction

    function AddRune takes integer i, code c, string s, integer id returns nothing
        local trigger t = CreateTrigger()
        set Runes[id] = i
        set RunesName[id] = s
        call SaveInteger(HT, i, 1, id)
        call TriggerAddCondition(t, Condition(c))
        set RunesTriggers[id] = t
        set t = null
    endfunction

    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_DROP_ITEM)
        call TriggerAddAction( trg, function InitialiseRune )
        set trg = null
        
        set StatRuneBonus = HashTable.create()
        set RuneIndex = Table.create()

        call AddRune('I08D',function DefenseRune, "Defense Rune", Defense_Rune_Id)
        call AddRune('I08J',function RuneOfChaos, "Chaos Rune", Chaos_Rune_Id)
        call AddRune('I08G',function RuneOfFire, "Fire Rune", Fire_Rune_Id)
        call AddRune('I088',function RuneOfLife, "Life Rune", Life_Rune_Id)
        call AddRune('I08B',function RuneOfMagic, "Time Rune", Time_Rune_Id)    
        call AddRune('I08F',function RuneOfHealing, "Healing Rune", Healing_Rune_Id)
        call AddRune('I08C',function RuneOfPower, "Power Rune", Power_Rune_Id)
        call AddRune('I08H',function RuneOfEarth, "Earth Rune", Earth_Rune_Id)
        set RuneOfStorm_b = Condition(function CastRuneOfStorm)
        call AddRune('I08I',function RuneOfStorm, "Water Rune", Water_Rune_Id)
        set RuneOfWinds_b = Condition(function CastRuneOfWinds)    
        call AddRune('I08O',function RuneOfWinds, "Wind Rune", Wind_Rune_Id)   
        call AddRune('I0AY',function BloodRune, "Blood Rune", Blood_Rune_Id)
        //call AddRune('I0AZ',function SpiritRune, "Spirit Rune")
        call AddRune('I0AV',function DarkRune, "Dark Rune", Dark_Rune_Id)
        call AddRune('I0AW',function LightRune, "Light Rune", Light_Rune_Id)
        call AddRune('I0AX',function PoisonRune, "Poison Rune", Poison_Rune_Id)
        call AddRune('I0AU',function WildRune, "Wild Rune", Wild_Rune_Id)
        call AddRune('I0C3',function MightRune, "Might Rune", Might_Rune_Id)
    endfunction
endlibrary