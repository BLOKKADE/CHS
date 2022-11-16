/*library XpBonusFrame initializer init

    globals
        framehandle XpBonusFrame = null 
        framehandle XpBonusFrameText = null 
        timer XpBonusTimer = null
    endglobals

    function ToggleXpBonusFrame takes boolean toggle returns nothing
        call BlzFrameSetVisible(XpBonusFrame, toggle)
        call BlzFrameSetVisible(XpBonusFrameText, toggle)
    endfunction

    private function UpdateXpBonusFrame takes nothing returns nothing
        local real duration = (T32_Tick - RoundStartTick) / 32
        local real playerCountSub = RMaxBJ(8 - (0.5 * duration), 0)
        local integer roundClearXpBonus = R2I(playerCountSub * (5 * Pow(RoundNumber, 2)))

        if GetUnitTypeId(PlayerHeroes[GetPlayerId(GetLocalPlayer())]) == TINKER_UNIT_ID then
            set roundClearXpBonus = roundClearXpBonus * 2
        endif

        call BlzFrameSetText(XpBonusFrameText, "|cff7bff00Clear exp bonus: " + I2S(roundClearXpBonus) + "|r")
    endfunction

    function ToggleXpBonusframeUpdate takes boolean toggle returns nothing
        if toggle and XpBonusTimer == null then
            set XpBonusTimer = NewTimer()
            call TimerStart(XpBonusTimer, 0.1, true, function UpdateXpBonusFrame)
            call UpdateXpBonusFrame()
        elseif XpBonusTimer != null then
            call ReleaseTimer(XpBonusTimer)
            set XpBonusTimer = null
        endif
    endfunction

    private function init takes nothing returns nothing
        // Load TOC-file
        call BlzLoadTOCFile("war3mapImported\\Templates.toc")

        //Textbox
        set XpBonusFrame = BlzCreateFrame("EscMenuEditBoxBackdropTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameSetSize(XpBonusFrame, 0.3, 0.03)
        call BlzFrameSetAbsPoint(XpBonusFrame, FRAMEPOINT_CENTER, 0., 0.5)
        call BlzFrameSetVisible(XpBonusFrame, false)

        //Text
        set XpBonusFrameText = BlzCreateFrameByType("TEXT", "", XpBonusFrame, "", 0)
        call BlzFrameSetSize(XpBonusFrameText, 0.27, 0.03)
        call BlzFrameSetAbsPoint(XpBonusFrameText, FRAMEPOINT_CENTER, 0.15, 0.49)
        call BlzFrameSetText(XpBonusFrameText, "")
        //call BlzFrameSetTextAlignment(XpBonusFrameText, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY)
        call BlzFrameSetVisible(XpBonusFrameText, false)
    endfunction
endlibrary
*/