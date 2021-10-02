library Hints initializer init
    globals
        string array Hints
        integer limit1
        integer limit2
        integer limit3
        boolean array DisableHint
        integer hintCount = 0
    endglobals

    private function DisplayHint takes nothing returns nothing
        local integer i = 0
        loop
            if DisableHint[i] != true then
                if udg_boolean04 then
                    call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cff4599ecHint: " + Hints[GetRandomInt(1,limit1)]+ "|r")
                else
                    if udg_boolean07 then
                        call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cff4599ecHint: " + Hints[GetRandomInt(1,limit2)]+ "|r")
                    else
                        call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cff4599ecHint: " + Hints[GetRandomInt(1,limit3)]+ "|r")
                    endif
                endif
            endif
            set i = i + 1
            exitwhen i > 8
        endloop
    endfunction

    private function HintTimer takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(CreateTrigger(), 60.00)
        call TriggerAddAction(trg, function DisplayHint)
    endfunction

    private function DisableHintCommand takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set DisableHint[pid] = DisableHint[pid] == false
        if DisableHint[pid] then
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|cff959697Display Hints: Off|r")
        else
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|cff959697Display Hints: On|r")
        endif
    endfunction

    private function HintDisableInit takes nothing returns nothing
        local integer i = 0
        local trigger trg = CreateTrigger()
        loop
            call TriggerRegisterPlayerChatEvent(trg, Player(i), "-hint", true)
            set i = i + 1
            exitwhen i > 8
        endloop
        call TriggerAddAction(trg, function DisableHintCommand)
    endfunction

    private function init takes nothing returns nothing
        set Hints[1]= "Hold shift while buying glory buffs, income or abilities to isntantly buy as much as you can!"
        set Hints[2]= "Wait a minute or two if you get stuck! The anti-stuck system is slow, but it'll get you out of there sooner or later."
        set Hints[3]= "If you have overlapping hotkeys go to the menu > options > preset keybindings and set it to grid mode to fix it! (needs to be done in main menu)"
        set Hints[4]= "Maximum level of ALL abilities is 30! Unless you're the Tauren."
        set Hints[5]= "Not all abilities stack! Be sure to check if you have more than one unique attack modifier."
        set Hints[6]= "Some items have attributes that stack, but not all do, if it has an [unique] tag it doesn't stack."
        set Hints[8]= "You can turn off/on hints by using the -hint command."
        set Hints[9]= "Creeps are stronger when they are fewer in number. Be sure to have both single target and area of effect damage."
        set Hints[10]= "Press the Space Bar to center the screen on your hero."
        set Hints[11]= "If enabled, you can buy creep upgrades at the Power Ups Shop II to get mroe gold per round at the cost of fighting stronger creeps."
        set Hints[12]= "Xesil has a chance to instantly reset an abilities cooldown when it's used, you can buy the Xesil's Legacy item to replicate it with any hero."
        set Hints[13]= "Grizwald may seem to be weak in the beginning, but he gets a lot of stats per level."
        set limit1 = 13
        set Hints[14]= "Won prizes will be added to your inventory as soon as you have an empty slot. Don't forget to collect it before the next PvP round!"
        if udg_boolean08 then
            set Hints[15]= "It's PvP every 5th level, in which the winner receives a prize."
        else
            set Hints[15]= "It's PvP every 10th level, in which the winner receives a prize."
        endif
        set limit2 = 15
        set Hints[16]= "Players surviving all levels will settle the score in a battle royal."
        set limit3 = 16
        call HintTimer()
        call HintDisableInit()
    endfunction
endlibrary