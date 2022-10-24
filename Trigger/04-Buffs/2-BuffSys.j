library BuffSystem initializer init requires TimerUtils
    globals
        constant integer IdBuffUnit = PRIEST_1_UNIT_ID
        
        integer array BufLvl
        integer array DeBufLvl
        integer array DeBufLvlA
    endglobals

    function TimerBuff1 takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local integer abil = LoadInteger(HT,i,1)
        local integer abilA = LoadInteger(HT,i,2)
        local unit u = LoadUnitHandle(HT,i,3)
        

        call UnitRemoveAbility(u,abilA)
        call UnitRemoveAbility(u,abil)
        call RemoveSavedHandle(HT,GetHandleId(u),abilA)
        
        call FlushChildHashtable(HT,i)
        call ReleaseTimer(t)
        set t = null
        set u = null
    endfunction

    function SetBuff takes unit u, integer level,real time returns nothing

        local timer t = LoadTimerHandle(HT,GetHandleId(u),DeBufLvlA[level])
        if GetUnitAbilityLevel(u,DeBufLvl[level]) == 0 then
            if t == null then
                set t = NewTimer()

                call SaveInteger(HT,GetHandleId(t),1,DeBufLvl[level])
                call SaveInteger(HT,GetHandleId(t),2,DeBufLvlA[level])
                call SaveUnitHandle(HT,GetHandleId(t),3,u)
                call SaveTimerHandle(HT,GetHandleId(u),DeBufLvlA[level],t)
                call UnitAddAbility(u,DeBufLvlA[level])
                // call BlzUnitHideAbility(u,DeBufLvlA[level],false)
                call BlzUnitDisableAbility(u,DeBufLvlA[level],false,true)
                call TimerStart(t,time,false,function TimerBuff1)
            else
                call SaveInteger(HT,GetHandleId(t),1,DeBufLvl[level])
                call SaveInteger(HT,GetHandleId(t),2,DeBufLvlA[level])
                call SaveUnitHandle(HT,GetHandleId(t),3,u)
                call SaveTimerHandle(HT,GetHandleId(u),DeBufLvlA[level],t)
                call UnitAddAbility(u,DeBufLvlA[level])
                call TimerStart(t,time,false,function TimerBuff1)
            endif
        else
            if t != null then
                call TimerStart(t,time,false,function TimerBuff1)
            endif
        endif
        
        set t = null
        set u = null
    endfunction

    private function init takes nothing returns nothing
        set DeBufLvlA[1] = 'A06L'
        set DeBufLvl[1] = INCINERATE_CUSTOM_BUFF_ID

        set DeBufLvlA[2] = 'A06P'
        set DeBufLvl[2] = POISON_NON_STACKING_CUSTOM_BUFF_ID

        set DeBufLvlA[3] = 'A06R'
        set DeBufLvl[3] = LIQUID_FIRE_CUSTOM_BUFF_ID

        set DeBufLvlA[4] = 'A08O'
        set DeBufLvl[4] = BLEED_BUFF_ID

        set DeBufLvlA[5] = 'A095'
        set DeBufLvl[5] = ANCIENT_KNIFE_OF_THE_GODS_BUFF_ID

        set DeBufLvlA[6] = 'A09B'
        set DeBufLvl[6] = FLIMSY_TOKEN_BUFF_ID

        set DeBufLvlA[7] = 'A09H'
        set DeBufLvl[7] = LUCKY_PANTS_BUFF_ID

        set DeBufLvlA[8] = 'A09R'
        set DeBufLvl[8] = MANA_STARVATION_BUFF_ID

        set DeBufLvlA[9] = 'A09S'
        set DeBufLvl[9] = WISDOM_CHESTPLATE_BUFF_ID

        set DeBufLvlA[10] = ERUPTION_IMMUNE_ABILITY_ID
        set DeBufLvl[10] = ERUPTION_IMMUNE_BUFF_ID
    endfunction
endlibrary