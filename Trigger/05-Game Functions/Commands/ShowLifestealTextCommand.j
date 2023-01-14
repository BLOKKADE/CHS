library ToggleLifestealTxt initializer init requires GetPlayerNames
    //===========================================================================
    globals
        Table LifestealTextToggle
    endglobals

    function ShowLifestealText takes unit source, unit target, real amount returns nothing
        local integer sourcePid = GetPlayerId(GetOwningPlayer(source))
        local integer targetPid = GetPlayerId(GetOwningPlayer(target))
        local string output = GetPlayerNameColour(Player(sourcePid)) + " stole |ccfdb31fd" + R2S(amount) + "|r life from " + GetPlayerNameColour(Player(targetPid))

        if LifestealTextToggle.boolean[sourcePid] then
            call DisplayTimedTextToPlayer(Player(sourcePid), 0, 0, 20, output)
        endif

        if LifestealTextToggle.boolean[targetPid] then
            call DisplayTimedTextToPlayer(Player(targetPid), 0, 0, 20, output)
        endif
    endfunction

    function ToggleLifestealTxt takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if LifestealTextToggle.boolean[pid] then
            set LifestealTextToggle.boolean[pid] = false
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccffdde31Disabled lifesteal text|r")
        else
            set LifestealTextToggle.boolean[pid] = true
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccf61fd31Enabled lifesteal text|r")
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        set LifestealTextToggle = Table.create()
        call Command.create(CommandHandler.ToggleLifestealTxt).name("Lifestealtext").handles("lifestealtext").handles("lst").help("lst", "Toggles text display for lifesteal used by and on your hero. (can lag)")
    endfunction
endlibrary