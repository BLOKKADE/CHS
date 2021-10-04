library Hints initializer init
    globals
        string array Hints
        integer limit1
        integer limit2
        integer limit3
        boolean array DisableHint
        integer hintCount = 0
    endglobals

    public function DisplayHint takes integer i returns nothing
            call DisplayTimedTextToPlayer(Player(i), 0, 0, 20, "Visit the Discord at: |cff45ec53customherosurvival.com|r")
            if DisableHint[i] != true then
                if udg_boolean04 then
                    call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cff4599ecHint|r: " + Hints[GetRandomInt(1,limit1)]+ "|r")
                else
                    if udg_boolean07 then
                        call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cff4599ecHint|r: " + Hints[GetRandomInt(1,limit2)]+ "|r")
                    else
                        call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cff4599ecHint|r: " + Hints[GetRandomInt(1,limit3)]+ "|r")
                    endif
                endif
            endif
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
        set Hints[1]= "Hold SHIFT while buying glory buffs, income or abilities to isntantly buy as much as you can!"
        set Hints[2]= "Wait a minute or two if you get stuck! The anti-stuck system is slow, but it'll get you out of there sooner or later."
        set Hints[3]= "Overlapping hotkeys? Menu > Options > Preset keybindings and set it to grid mode to fix it! (needs to be done in main menu)"
        set Hints[4]= "Maximum level of ALL abilities is 30! Unless you're playing as the Tauren."
        set Hints[5]= "Not all abilities stack! Be sure to check if you have more than one unique attack modifier."
        set Hints[6]= "Some items have attributes that stack, but not all do, if it has an [unique] tag it doesn't stack."
        set Hints[8]= "You can turn off/on hints by using the -hint command."
        set Hints[9]= "Creeps are stronger when they are fewer in number. Be sure to have both single target and area of effect damage."
        set Hints[10]= "Press the Space Bar to center the screen on your hero."
        set Hints[11]= "If enabled, you can buy creep upgrades at the Power Ups Shop II to get more gold per round at the cost of fighting stronger creeps."
        set Hints[12]= "Wraith and Sludge Minion creeps deal magic damage, be sure to protect yourself against them!"
        set Hints[13]= "The Rings in PVE Shop I are very useful early game, be sure to check them out."
        set limit1 = 13
        set Hints[14]= "You now get gold when you win in Pvp!"
        if udg_boolean08 then
            set Hints[15]= "It's PvP every 5th level, in which the winner receives a prize."
        else
            set Hints[15]= "It's PvP every 10th level, in which the winner receives a prize."
        endif
        set limit2 = 15
        set Hints[16]= "Players surviving all levels will settle the score in a battle royal."
        set limit3 = 16
        call HintDisableInit()
    endfunction
endlibrary