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
        set Hints[1]= "Hold |cff45ec53SHIFT|r while buying |cff45c5ecglory buffs|r, |cffe9ec45income|r or |cffec6645abilities|r to instantly buy as much as you can!"
        set Hints[2]= "Just don't die."
        set Hints[3]= "Overlapping hotkeys? |cff45ec53Menu|r > |cff45c5ecOptions|r > |cffe9ec45Preset keybindings|r and set it to grid mode to fix it! (needs to be done in main menu)"
        set Hints[4]= "The |cffec6645Maximum level|r of all abilities is |cff45ec5330|r!"
        set Hints[5]= "Buy the |cff45ec53Non-lucrative Tome|r to unlearn all [|cffe9ec45Economic|r] skills such as |cff45c5ecPillage|r and |cff45c5ecLearnability|r to make place for more!"
        set Hints[6]= "If an item has the [|cffecb745Unique|r] tag, everything |cffec6645after|r it in the description |cff45c5ecdoes not stack|r."
        set Hints[8]= "You can turn |cff45c5ecoff/on|r hints by using the |cff45ec53-hint|r command."
        set Hints[9]= "Creeps are |cff45ec53stronger|r when they are fewer in number. Be sure to have both |cff45c5ecsingle target|r and |cffe9ec45area|r damage."
        set Hints[10]= "Press the |cffe9ec45space bar|r to |cff45ec53center the screen|r on your hero."
        set Hints[11]= "|cff45c5ecAll|r abilities deal |cff45ec53magic damage|r unless mentioned otherwise."
        set Hints[12]= "|cff45c5ecWraith|r and |cffca45ecSludge Minion|r creeps deal |cff45ec53magic damage|r, be sure to protect yourself against them!"
        set Hints[13]= "The |cff45ec53Rings|r in |cff45c5ecPVE Shop I|r are very useful early game, be sure to check them out."
        set Hints[14]= "|cffe9ec45Thorns/Reflection/Wizardbane|r wave incoming? Look into |cff45ec53magic immunity|r! For example the |cff45c5ecAnti-Magic Flag|r item."
        set Hints[15]= "We have a |cffecb745wiki|r containing lists and descriptions of all |cff45ec53heroes|r, |cffec6645abilities|r and |cff45c5ecitems|r. Go to |cffca45ecchs-wiki.com|r."
        set Hints[16]= "Items |cffca45ecdropped on the ground|r during |cffecb745creep rounds|r will |cff45c5ecautomatically be sold|r for you at the |cff45ec53start of the next round|r."
        set limit1 = 16
        set Hints[17]= "You receive gold when you win in Pvp!"
        set limit2 = 17
        set Hints[18]= "Players surviving all levels will settle the score in a battle royal."
        set limit3 = 18
        call HintDisableInit()
    endfunction
endlibrary