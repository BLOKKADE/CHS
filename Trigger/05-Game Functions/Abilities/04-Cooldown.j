library Cooldown requires  HeroAbilityCooldown, DummyActiveSpell
    globals
        hashtable HT_SPELC = InitHashtable()
    endglobals

    function RefreshSpellO takes nothing returns nothing
        local timer TimerT = GetExpiredTimer()
        local unit u = LoadUnitHandle(HT_SPELC,GetHandleId(TimerT),2)
        local integer id = LoadInteger(HT_SPELC,GetHandleId(TimerT),1)
        local real time = LoadReal(HT_SPELC,GetHandleId(TimerT),3) 
        local boolean dummyAbil = LoadBoolean(HT_SPELC, GetHandleId(TimerT), 4)

        //call BlzSetAbilityRealLevelField(BlzGetUnitAbility(LoadUnitHandle(HT_SPELC,GetHandleId(TimerT),2), ),ConvertAbilityRealLevelField('acdn'),GetUnitAbilityLevel(t,Aid)-1,timeT*ResCD)

        call BlzSetUnitAbilityCooldown(u,id, GetUnitAbilityLevel(u,id)- 1,  time  ) 

        if dummyAbil then
            call BlzSetUnitAbilityCooldown(u, GetAssociatedSpell(u, id), 0, time)
        endif

        call FlushChildHashtable(HT_SPELC,GetHandleId(TimerT))
        call ReleaseTimer(TimerT)
        set TimerT = null
        set u = null
    endfunction

    function SetCooldown takes unit u, integer Aid, boolean startCooldown returns nothing 
        local timer TimerT = null
        local integer lvl = GetUnitAbilityLevel(u,Aid) - 1
        local real timeT = 0
        local real cd = 0
        local boolean dummyAbil = GetAssociatedSpell(u, Aid) != 0
        

        set timeT = BlzGetAbilityCooldown(Aid,lvl)
        set cd = CalculateCooldown(u, Aid, timeT, true)
        //call BJDebugMsg("cd default: " + R2S(timeT) + " new cd: " + R2S(cd))
        //call BJDebugMsg(GetUnitName(u) + " : " + GetObjectName(Aid))
        if cd != timeT then
            //call BlzSetAbilityRealLevelField(GetSpellAbility(),ConvertAbilityRealLevelField('acdn'),GetUnitAbilityLevel(t,Aid)-1,timeT*ResCD)
            call BlzSetUnitAbilityCooldown(u, Aid, lvl, cd) 
            if dummyAbil then
                call BlzSetUnitAbilityCooldown(u, GetAssociatedSpell(u, Aid), 0, cd)
            endif
            set TimerT = NewTimer()
            call SaveInteger(HT_SPELC,GetHandleId(TimerT),1,Aid  )
            call SaveUnitHandle(HT_SPELC,GetHandleId(TimerT),2, u )
            call SaveReal(HT_SPELC,GetHandleId(TimerT),3,  timeT)
            call SaveBoolean(HT_SPELC, GetHandleId(TimerT), 4, dummyAbil)

            call TimerStart(TimerT,0.01,false,function RefreshSpellO)
            set TimerT = null
        endif

        if startCooldown then
            call BlzStartUnitAbilityCooldown(u, Aid, cd)

            if dummyAbil then
                call BlzStartUnitAbilityCooldown(u, GetAssociatedSpell(u, Aid), cd)
            endif
        endif
        //call BJDebugMsg("cdset")
        set u = null
    endfunction
endlibrary