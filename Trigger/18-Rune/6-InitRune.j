globals
    integer array Runes
    trigger array RunesTriggers
    string array RunesName
    integer RuneCount = 0
    

endglobals

function AddRune takes integer i,code c,string s returns nothing
    set RuneCount = RuneCount + 1
    set Runes[RuneCount] = i
    set RunesName[RuneCount] = s
    call SaveInteger(HT,i,1,RuneCount)
    set RunesTriggers[RuneCount] = CreateRuneAction(c)

    
endfunction

function InitRuneId takes nothing returns nothing

    call AddRune('I08D',function RuneOfAttack,"Rune of attack")
    call AddRune('I08J',function RuneOfChaos, "Rune of chaos")
    call AddRune('I08G',function RuneOfFire, "Rune of fire")
    call AddRune('I088',function RuneOfLife, "Rune of life")
    call AddRune('I08B',function RuneOfMagic, "Rune of magic")    
    call AddRune('I08F',function RuneOfHealing, "Rune of Healing")
    call AddRune('I08C',function RuneOfPower, "Rune of power")
    call AddRune('I08H',function RuneOfEarth, "Rune of earth")
    set RuneOfStorm_b = Condition(function CastRuneOfStorm)
    call AddRune('I08I',function RuneOfStorm,  "Rune of the Storm")
    set RuneOfWinds_b = Condition(function CastRuneOfWinds)    
    call AddRune('I08O',function RuneOfWinds,  "Rune of the winds")
        
endfunction