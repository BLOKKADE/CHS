library MouseHoverInfo requires TimerUtils, GetClass, RandomShit

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

        call ClearTextMessages()
        set heroInfo = heroInfo + "|cffff0000" + GetObjectName(GetUnitTypeId( u )) +"|r\n"
        set temp = GetClassification(GetUnitTypeId( u ))

        if temp != "" then
            set heroInfo = heroInfo + temp + "\n"
        endif
        set heroInfo = heroInfo +  LoadStr(HT_data,GetUnitTypeId( u ),2 )   + "\n\n"
        set heroInfo = heroInfo + "|cff0000ffAttributes|r  \n"
        set heroInfo = heroInfo + "|cffe7544aStrength|r: " + I2S(GetHeroStr(u, false)) + ", +" + R2S(BlzGetUnitRealField( u,ConvertUnitRealField('ustp')))
        set heroInfo = heroInfo + "\n|cffd6e049Agility|r: " + I2S(GetHeroAgi(u, false)) + ", +" + R2S(BlzGetUnitRealField( u,ConvertUnitRealField('uagp')))
        set heroInfo = heroInfo + "\n|cff4daed4Intelligence|r: " + I2S(GetHeroInt(u, false)) + ", +" +  R2S(BlzGetUnitRealField( u,ConvertUnitRealField('uinp')))   
        set heroInfo = heroInfo + "\n|cff51d44dHp regen|r: " +  R2S(BlzGetUnitRealField( u,ConvertUnitRealField('uhpr')))
        set heroInfo = heroInfo + ", |cff51d44dMana regen|r: " + R2S(BlzGetUnitRealField(u,ConvertUnitRealField('umpr')))
        set heroInfo = heroInfo + "\n|cffd99ddfSelect this Hero twice to pick it.|r"

        call DisplayTextToPlayer(p, 0,0, heroInfo)
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