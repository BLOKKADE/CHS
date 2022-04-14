scope DiscordAdCommand initializer init
    //===========================================================================
    globals
        integer array DiscordAdTimeout
    endglobals

    function HideDiscordAd takes nothing returns nothing
        call ReleaseTimer(GetExpiredTimer())
        call ShowDiscordFramesAllPlayers(false)
    endfunction

    function ShowDiscordAd takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if T32_Tick - DiscordAdTimeout[pid] > 20 * 32 then
            call ShowDiscordFramesAllPlayers(true)
            call TimerStart(NewTimer(), 20, false, function HideDiscordAd)
            set DiscordAdTimeout[pid] = T32_Tick

            if not DiscordAdDisabled[GetPlayerId(GetLocalPlayer())] then
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "You can disable the Discord ad (forever) by typing -togglead")
            endif
        endif
    endfunction

    function ToggleDiscordAd takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local PlayerStats ps = PlayerStats.forPlayer(GetTriggerPlayer())
        set DiscordAdDisabled[pid] = DiscordAdDisabled[pid] != true

        call ShowDiscordFrames(GetTriggerPlayer(), false)

        if DiscordAdDisabled[pid] then
            call ps.setDiscordAdToggle(1)
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "Discard ad disabled")
        else
            call ps.setDiscordAdToggle(0)
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "Discard ad enabled")
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0

        loop
            call TriggerRegisterPlayerChatEvent(trg, Player(i), "discord", false)
            call TriggerRegisterPlayerChatEvent(trg, Player(i), "Discord", false)
            set i = i + 1
            exitwhen i > 7
        endloop
        call TriggerAddAction(trg, function ShowDiscordAd)
        call Command.create(CommandHandler.ToggleDiscordAd).name("ToggleAd").handles("togglead").handles("tad").help("Toggle Discord Ad", "Toggles whether the discord ad will display for you.")
        set trg = null
    endfunction
endscope