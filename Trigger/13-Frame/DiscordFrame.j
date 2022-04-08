library DiscordFrame initializer init

    globals
        private framehandle frameDiscordText
        private framehandle frameDiscordIcon
        private framehandle frameDiscordTip
    endglobals

    private function init takes nothing returns nothing
        // Load TOC-file
        call BlzLoadTOCFile("war3mapImported\\templates.toc")
    
        // Add discord link text
        set frameDiscordText = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameClearAllPoints(frameDiscordText)
        call BlzFrameSetAbsPoint(frameDiscordText, FRAMEPOINT_CENTER, 0.4, 0.155)
        call BlzFrameSetSize(frameDiscordText, 0.2, 0.03)
        call BlzFrameSetText(frameDiscordText, "discord.gg/7DtQgxYBXw")
        call BlzFrameSetTextSizeLimit(frameDiscordText, StringLength("discord.gg/7DtQgxYBXw"))
        // set frameDiscordTextHandle = tostring(frameDiscordText)
    
        // Add icon
        set frameDiscordIcon = BlzCreateFrame("QuestButtonBackdropTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameClearAllPoints(frameDiscordIcon)
        call BlzFrameSetAbsPoint(frameDiscordIcon, FRAMEPOINT_CENTER, 0.2875, 0.155)
        call BlzFrameSetSize(frameDiscordIcon, 0.03, 0.03)
        call BlzFrameSetTexture(frameDiscordIcon, "ReplaceableTextures\\CommandButtons\\Discord.blp", 0, false)
    
        // Add tip
        set frameDiscordTip = BlzCreateFrame("TeamLabelTextTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameSetText(frameDiscordTip, "|cffFF2020Join our discord for latest updates and additional info. Copy & Paste link below.|r")
        call BlzFrameSetAbsPoint(frameDiscordTip, FRAMEPOINT_CENTER, 0.4, 0.185)
        call BlzFrameSetSize(frameDiscordTip, 0.22, 0.03)
    endfunction

endlibrary