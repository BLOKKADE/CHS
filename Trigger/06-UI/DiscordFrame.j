library DiscordFrame initializer init requires FrameLoader

    globals
        private framehandle FrameDiscordText
        private framehandle FrameDiscordIcon
        private framehandle FrameDiscordTip
        private framehandle FrameDiscordClose
        private framehandle FrameDiscordCloseIcon

        private constant string CLOSE_BUTTON_ICON = "ReplaceableTextures\\CommandButtons\\BTNuncheck.blp"
        private constant real ICON_WIDTH = 0.024
        private trigger CloseEventTrigger

        boolean array DiscordAdDisabled
    endglobals

    function ShowDiscordFramesAllPlayers takes boolean show returns nothing
        if (((not DiscordAdDisabled[GetPlayerId(GetLocalPlayer())]) and show) or not show) then
            call BlzFrameSetVisible(FrameDiscordText, show)
            call BlzFrameSetVisible(FrameDiscordIcon, show)
            call BlzFrameSetVisible(FrameDiscordTip, show)
            call BlzFrameSetVisible(FrameDiscordClose, show)
        endif
    endfunction

    function ShowDiscordFrames takes player p, boolean show returns nothing
        if GetLocalPlayer() == p and (((not DiscordAdDisabled[GetPlayerId(p)]) and show) or not show) then
            call BlzFrameSetVisible(FrameDiscordText, show)
            call BlzFrameSetVisible(FrameDiscordIcon, show)
            call BlzFrameSetVisible(FrameDiscordTip, show)
            call BlzFrameSetVisible(FrameDiscordClose, show)
        endif
    endfunction

    private function SetupDiscord takes nothing returns nothing
        // Load TOC-file
        call BlzLoadTOCFile("war3mapImported\\Templates.toc")
    
        // Add discord link text
        set FrameDiscordText = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameClearAllPoints(FrameDiscordText)
        call BlzFrameSetAbsPoint(FrameDiscordText, FRAMEPOINT_CENTER, 0.4, 0.155)
        call BlzFrameSetSize(FrameDiscordText, 0.2, 0.03)
        call BlzFrameSetText(FrameDiscordText, "discord.gg/7DtQgxYBXw")
        call BlzFrameSetTextSizeLimit(FrameDiscordText, StringLength("discord.gg/7DtQgxYBXw"))
        call BlzFrameSetVisible(FrameDiscordText, false)
    
        // Add icon
        set FrameDiscordIcon = BlzCreateFrameByType("BACKDROP", "FrameDiscordIcon", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 1) 
        call BlzFrameSetAbsPoint(FrameDiscordIcon, FRAMEPOINT_CENTER, 0.2875, 0.155)
        call BlzFrameSetSize(FrameDiscordIcon, 0.025, 0.025)
        call BlzFrameSetTexture(FrameDiscordIcon, "war3mapImported\\discord.dds", 0, true)
        call BlzFrameSetVisible(FrameDiscordIcon, false)
    
        // Add tip
        set FrameDiscordTip = BlzCreateFrame("TeamLabelTextTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameSetText(FrameDiscordTip, "|cffFF2020Join our discord for updates, info and guides. Copy & paste link below.|r")
        call BlzFrameSetAbsPoint(FrameDiscordTip, FRAMEPOINT_CENTER, 0.4, 0.185)
        call BlzFrameSetSize(FrameDiscordTip, 0.22, 0.03)
        call BlzFrameSetVisible(FrameDiscordTip, false)

        // Add the close button
        set FrameDiscordClose = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        set FrameDiscordCloseIcon = BlzCreateFrameByType("BACKDROP", "Backdrop", FrameDiscordClose, "", 1)
        call BlzFrameSetPoint(FrameDiscordClose, FRAMEPOINT_LEFT, FrameDiscordText, FRAMEPOINT_RIGHT, 0.004, 0)
        call BlzFrameSetAllPoints(FrameDiscordCloseIcon, FrameDiscordClose) 
        call BlzFrameSetTexture(FrameDiscordCloseIcon, CLOSE_BUTTON_ICON, 0, true) 
        call BlzFrameSetSize(FrameDiscordClose, ICON_WIDTH, ICON_WIDTH)
        call BlzFrameSetVisible(FrameDiscordClose, false)
        call BlzTriggerRegisterFrameEvent(CloseEventTrigger, FrameDiscordClose, FRAMEEVENT_CONTROL_CLICK)
    endfunction

    private function CloseDiscordEventActions takes nothing returns nothing
        local framehandle currentFrameHandle = BlzGetTriggerFrame()
        local player triggerPlayer = GetTriggerPlayer()

        if (BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK) then
            if (GetLocalPlayer() == triggerPlayer) then	
				call BlzFrameSetEnable(currentFrameHandle, false)
				call BlzFrameSetEnable(currentFrameHandle, true)
			endif

            // Close
            set DiscordAdDisabled[GetPlayerId(triggerPlayer)] = true
            call PlayerStats.forPlayer(triggerPlayer).setDiscordAdToggle(1)
            call DisplayTimedTextToPlayer(triggerPlayer, 0, 0, 5, "Discord ad disabled")
            call ShowDiscordFrames(triggerPlayer, false)
        endif

        // Cleanup
        set currentFrameHandle = null
        set triggerPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set CloseEventTrigger = CreateTrigger()
        call TriggerAddAction(CloseEventTrigger, function CloseDiscordEventActions)

        call TimerStart(CreateTimer(), 0, false, function SetupDiscord)
    endfunction

endlibrary