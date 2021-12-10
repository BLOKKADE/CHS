library trigger88 initializer init requires RandomShit

    function Trig_Hint_Initialization_Func019C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Hint_Initialization_Actions takes nothing returns nothing
        set udg_strings01[1]= "There are hints showing in-game!"
        set udg_strings01[2]= "Wait a minute or two if you get stuck! The anti-stuck system is slow, but it'll get you out of there sooner or later."
        set udg_strings01[3]= "If you have overlapping hotkeys go to the menu > options > preset keybindings and set it to grid mode to fix it! (needs to be done in main menu)"
        set udg_strings01[4]= "Maximum level of ALL abilities is 30! Unless you're the Tauren."
        set udg_strings01[5]= "Not all abilities stack! Be sure to check if you have more than one unique attack modifier."
        set udg_strings01[6]= "Some items have attributes that stack, but not all do, if it has an [unique] tag it doesn't stack."
        set udg_strings01[8]= "You can turn off/on hints by using the -hint command."
        set udg_strings01[9]= "Creeps are stronger when they are fewer in number. Be sure to have both single target and area of effect damage."
        set udg_strings01[10]= "Press the Space Bar to center the screen on your hero."
        set udg_strings01[11]= "If enabled, you can buy creep upgrades at the Power Ups Shop II to get mroe gold per round at the cost of fighting stronger creeps."
        set udg_strings01[12]= "Xesil has a chance to instantly reset an abilities cooldown when it's used, you can buy the Xesil's Legacy item to replicate it with any hero."
        set udg_strings01[13]= "Grizwald may seem to be weak in the beginning, but he gets a lot of stats per level."
        set udg_integers12[1]= 13
        set udg_strings01[14]= "Won prizes will be added to your inventory as soon as you have an empty slot. Don't forget to collect it before the next PvP round!"
        if(Trig_Hint_Initialization_Func019C())then
            set udg_strings01[15]= "It's PvP every 5th level, in which the winner receives a prize."
        else
            set udg_strings01[15]= "It's PvP every 10th level, in which the winner receives a prize."
        endif
        set udg_integers12[2]= 15
        set udg_strings01[16]= "Players surviving all levels will settle the score in a battle royal."
        set udg_integers12[3]= 16
        call EnableTrigger(udg_trigger87)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger88 = CreateTrigger()
        call TriggerRegisterTimerEventSingle(udg_trigger88,30.00)
        call TriggerAddAction(udg_trigger88,function Trig_Hint_Initialization_Actions)*/
    endfunction


endlibrary
