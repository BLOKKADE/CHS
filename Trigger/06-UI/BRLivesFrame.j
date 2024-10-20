library BRLivesFrame initializer init requires PlayerTracking, Utility

    globals
        framehandle BRLivesFrameHandle // BR Lives main frame

        private constant string BR_LIVES_TITLE_TEXT                     = "|cff27ffc9BR Lives|r"
        private constant string LIVES_TITLE_TEXT                        = "|cff48ff00Lives|r"

        // Specifications for the text
        private constant real BR_LIVES_TEXT_HEIGHT                      = 0.016
        private constant real BR_LIVES_TITLE_TEXT_WIDTH                 = 0.058

        // The X,Y coordinate for the top left of the main frame
        private constant real MAIN_FRAME_TOP_LEFT_X                     = 0.0
        private constant real MAIN_FRAME_TOP_LEFT_Y                     = 0.525
        private constant real MAIN_FRAME_X_MARGIN                       = 0.02
        private constant real MAIN_FRAME_Y_TOP_MARGIN                   = 0.01
        private constant real MAIN_FRAME_Y_BOTTOM_MARGIN                = 0.01

        private framehandle BRLivesTextFrameHandle
    endglobals

    private function GetTopLeftX takes nothing returns real
        return MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN
    endfunction

    private function GetTopLeftY takes nothing returns real
        return MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN
    endfunction

    function UpdateLivesForPlayer takes player p, integer lives, boolean isBr returns nothing
        if (GetLocalPlayer() == p) then
            if (isBr) then
                call BlzFrameSetText(BRLivesTextFrameHandle, BR_LIVES_TITLE_TEXT + ": " + I2S(lives))
            else
                call BlzFrameSetText(BRLivesTextFrameHandle, LIVES_TITLE_TEXT + ": " + I2S(lives))
            endif
        endif
    endfunction

    private function InitializeBrLives takes nothing returns nothing
        local real mainFrameBottomRightX
        local real mainFrameBottomRightY

        // Create the main frame. All elements use this frame as the parent
        set BRLivesFrameHandle = BlzCreateFrame("CheckListBox", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        set BRLivesTextFrameHandle = BlzCreateFrameByType("TEXT", "BRLivesText", BRLivesFrameHandle, "", 0) 

        call BlzFrameSetLevel(BRLivesFrameHandle, 1)
        call BlzFrameSetVisible(BRLivesFrameHandle, false) 
        
        // BR Lives Text Title
        call BlzFrameSetAbsPoint(BRLivesTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY())
        call BlzFrameSetAbsPoint(BRLivesTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + BR_LIVES_TITLE_TEXT_WIDTH, GetTopLeftY() - BR_LIVES_TEXT_HEIGHT) 
        call BlzFrameSetEnable(BRLivesTextFrameHandle, true) 
        call BlzFrameSetScale(BRLivesTextFrameHandle, 1.12) 
        call BlzFrameSetTextAlignment(BRLivesTextFrameHandle, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER) 
        call BlzFrameSetText(BRLivesTextFrameHandle, LIVES_TITLE_TEXT + ": 1") // Initial lives

        // Finalize the main window
        // Width
        set mainFrameBottomRightX = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN + BR_LIVES_TITLE_TEXT_WIDTH + MAIN_FRAME_X_MARGIN
        // Height
        set mainFrameBottomRightY = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - BR_LIVES_TEXT_HEIGHT - MAIN_FRAME_Y_BOTTOM_MARGIN

        // Set the frame for the backdrop of the entire rewards
        call BlzFrameSetAbsPoint(BRLivesFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X, MAIN_FRAME_TOP_LEFT_Y) 
        call BlzFrameSetAbsPoint(BRLivesFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 
    endfunction

    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(), 1, false, function InitializeBrLives)
    endfunction

endlibrary
