scope ToggleFx initializer init
    //===========================================================================
    function ToggleFx takes Args args returns nothing
        if GetTriggerPlayer() == GetLocalPlayer() then
            if EffectVisible then
                set EffectVisible = false
                call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccffdde31Disabled FX|r")
            else
                set EffectVisible = true
                call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccf61fd31Enabled FX|r")
            endif
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        call Command.create(CommandHandler.ToggleFx).name("DisableEffects").handles("DisableEffects").handles("de").help("de", "Toggles laggy fx on or off.")
    endfunction
endscope