library InitializeBettingDialogs initializer init

    globals
        button array BettingDialogButtons
        dialog array BettingDialogs
    endglobals

    private function init takes nothing returns nothing
        local integer i

        set i = 0
        loop
            exitwhen(i > 4)
            set BettingDialogs[i] = DialogCreate()
        endloop
    endfunction

endlibrary
