library MouseHoverInfo requires TimerUtils, GetObjectElement, RandomShit

    globals
        timer MouseHoverTimer = null
    endglobals

    public function DisableMouseHover takes nothing returns nothing
        if MouseHoverTimer != null then
            call ReleaseTimer(MouseHoverTimer)
            set MouseHoverTimer = null
        endif
    endfunction

    private function DisplayText takes player p, unit u returns nothing
        local string heroInfo = "" 
        local string temp = ""

        if PlayerHeroes[GetPlayerId(p) + 1] == null then
            call ClearTextMessages()
            set heroInfo = heroInfo + "|cff56fc6c" + GetHeroProperName(u) + "|r the |cff00c3ff" + GetObjectName(GetUnitTypeId( u )) + "|r\n"
            set temp = GetObjectelementsAsString(u, GetUnitTypeId( u ), false)
            if temp != "" then
                set heroInfo = heroInfo + temp + "\n"
            endif
            set temp = LoadStr(HT_data, GetUnitTypeId(u), 2)
            if temp != "" and temp != null then
                set heroInfo = heroInfo + temp + "\n"
            endif

            set temp = LoadStr(HT_data, GetUnitTypeId(u), 3)
            if temp != "" and temp != null then
                set heroInfo = heroInfo + temp
            endif

            set heroInfo = heroInfo + "\n\n"
            set heroInfo = heroInfo + "|cff0000ffAttributes|r  \n"
            set heroInfo = heroInfo + "|cffe7544aStrength|r: " + I2S(GetHeroStr(u, false)) + ", +" + R2S(BlzGetUnitRealField( u,ConvertUnitRealField('ustp')))
            set heroInfo = heroInfo + "\n|cffd6e049Agility|r: " + I2S(GetHeroAgi(u, false)) + ", +" + R2S(BlzGetUnitRealField( u,ConvertUnitRealField('uagp')))
            set heroInfo = heroInfo + "\n|cff4daed4Intelligence|r: " + I2S(GetHeroInt(u, false)) + ", +" + R2S(BlzGetUnitRealField( u,ConvertUnitRealField('uinp')))   
            set heroInfo = heroInfo + "\n|cffd99ddfSelect this Hero twice to pick it.|r"

            call DisplayTextToPlayer(p, 0,0, heroInfo)
        endif
    endfunction

    private function MouseHoverCheck takes nothing returns nothing
        local unit u = BlzGetMouseFocusUnit()
        if u != null and IsUnitType(u, UNIT_TYPE_HERO) and GetOwningPlayer(u) == Player(8) then
            call DisplayText(GetLocalPlayer(), u)
        endif
        set u = null
    endfunction

    public function ActivateMouseHover takes nothing returns nothing
        set MouseHoverTimer = NewTimer()
        call TimerStart(MouseHoverTimer, 0.03, true, function MouseHoverCheck)
    endfunction
endlibrary