library DiscordFrame initializer init requires FrameLoader

    globals
        private framehandle frameDiscordText
        private framehandle frameDiscordIcon
        private framehandle frameDiscordTip

        boolean array DiscordAdDisabled
    endglobals

    function ShowDiscordFramesAllPlayers takes boolean show returns nothing
        if (((not DiscordAdDisabled[GetPlayerId(GetLocalPlayer())]) and show) or not show) then
            call BlzFrameSetVisible(frameDiscordText, show)
            call BlzFrameSetVisible(frameDiscordIcon, show)
            call BlzFrameSetVisible(frameDiscordTip, show)
        endif
    endfunction

    function ShowDiscordFrames takes player p, boolean show returns nothing
        if GetLocalPlayer() == p and (((not DiscordAdDisabled[GetPlayerId(p)]) and show) or not show) then
            call BlzFrameSetVisible(frameDiscordText, show)
            call BlzFrameSetVisible(frameDiscordIcon, show)
            call BlzFrameSetVisible(frameDiscordTip, show)
        endif
    endfunction

    private function SetupDiscord takes nothing returns nothing
        // Load TOC-file
        call BlzLoadTOCFile("war3mapImported\\Templates.toc")
    
        // Add discord link text
        set frameDiscordText = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameClearAllPoints(frameDiscordText)
        call BlzFrameSetAbsPoint(frameDiscordText, FRAMEPOINT_CENTER, 0.4, 0.155)
        call BlzFrameSetSize(frameDiscordText, 0.2, 0.03)
        call BlzFrameSetText(frameDiscordText, "discord.gg/7DtQgxYBXw")
        call BlzFrameSetTextSizeLimit(frameDiscordText, StringLength("discord.gg/7DtQgxYBXw"))
        call BlzFrameSetVisible(frameDiscordText, false)
    
        // Add icon
        set frameDiscordIcon = BlzCreateFrameByType("BACKDROP", "frameDiscordIcon", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 1) 
        call BlzFrameSetAbsPoint(frameDiscordIcon, FRAMEPOINT_CENTER, 0.2875, 0.155)
        call BlzFrameSetSize(frameDiscordIcon, 0.025, 0.025)
        call BlzFrameSetTexture(frameDiscordIcon, "war3mapImported\\discord.dds", 0, true)
        call BlzFrameSetVisible(frameDiscordIcon, false)
    
        // Add tip
        set frameDiscordTip = BlzCreateFrame("TeamLabelTextTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameSetText(frameDiscordTip, "|cffFF2020Join our discord for updates, info and guides. Copy & paste link below.|r")
        call BlzFrameSetAbsPoint(frameDiscordTip, FRAMEPOINT_CENTER, 0.4, 0.185)
        call BlzFrameSetSize(frameDiscordTip, 0.22, 0.03)
        call BlzFrameSetVisible(frameDiscordTip, false)
    endfunction

    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(), 0, false, function SetupDiscord)
    endfunction

endlibrary