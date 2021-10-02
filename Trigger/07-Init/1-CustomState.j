library CustomState requires TimerUtils
    globals
        hashtable HT_unitstate = InitHashtable()

        integer CustomState_MagicPow = 1
        integer CustomState_MagicRes = 2
        integer CustomState_Evasion = 3
        integer CustomState_Block = 4
        integer CustomState_Luck = 5
        integer CustomState_RunePow = 6
        integer CustomState_SummonPow = 7
        integer CustomState_PvpBonus = 8
    endglobals

    function SetUnitMagicDmg takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),1,r)
    endfunction

    function GetUnitMagicDmg takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),1)
    endfunction

    function AddUnitMagicDmg takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),1,LoadReal(HT_unitstate,GetHandleId(u),1)+ r)
    endfunction

    function SetUnitMagicDef takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),2,r)
    endfunction


    function GetUnitMagicDef takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),2)
    endfunction

    function AddUnitMagicDef takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),2,LoadReal(HT_unitstate,GetHandleId(u),2)+ r)
    endfunction

    function SetUnitEvasion takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),3,r)
    endfunction

    function AddUnitEvasion takes unit u,real r returns nothing
        set r = LoadReal(HT_unitstate,GetHandleId(u),3)+ r
        call SaveReal(HT_unitstate,GetHandleId(u),3,r)    
    endfunction

    function GetUnitEvasion takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),3)
    endfunction

    function GetUnitRealEvade takes unit u returns real
        return  1 - (50 /(50 + LoadReal(HT_unitstate,GetHandleId(u),3))) 
    endfunction



    function SetUnitBlock takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),4,r)
    endfunction

    function GetUnitBlock takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),4)
    endfunction

    function AddUnitBlock takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),4,LoadReal(HT_unitstate,GetHandleId(u),4)+ r)
    endfunction


    function SetUnitLuck takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),1,5)
    endfunction

    //function GetUnitLuck takes unit u returns real
    //    return LoadReal(HT_unitstate,GetHandleId(u),5)+1
    //endfunction

    function AddUnitLuck takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),5,LoadReal(HT_unitstate,GetHandleId(u),5)+ r)
    endfunction


    function SetUnitPowerRune takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),6,r)
    endfunction

    //function GetUnitPowerRune takes unit u returns real
    //    return LoadReal(HT_unitstate,GetHandleId(u),6)
    //endfunction

    function AddUnitPowerRune takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),6,LoadReal(HT_unitstate,GetHandleId(u),6)+ r)
    endfunction



    function SetUnitSummonStronger takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),7,r)
    endfunction

    function GetUnitSummonStronger takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),7)
    endfunction

    function AddUnitSummonStronger takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),7,LoadReal(HT_unitstate,GetHandleId(u),7)+ r)
    endfunction



    function SetUnitPvpBonus takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),8,r)
    endfunction

    function GetUnitPvpBonus takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),8)
    endfunction

    function AddUnitPvpBonus takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),8,LoadReal(HT_unitstate,GetHandleId(u),8)+ r)
    endfunction


    function endTimerState takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = LoadInteger(HT,GetHandleId(t),1)
        local real r = LoadReal(HT,GetHandleId(t),2)
        local unit u = LoadUnitHandle(HT,GetHandleId(t),3)

        call SaveReal(HT_unitstate,GetHandleId(u),i,LoadReal(HT_unitstate,GetHandleId(u),i) - r  )   
            
        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set u = null
        set t = null
    endfunction

    function AddStateTemp takes unit u,integer i, real r, real time returns nothing
        local timer t = NewTimer()
        
        call SaveInteger(HT,GetHandleId(t),1,i)
        call SaveReal(HT,GetHandleId(t),2,r)  
        call SaveUnitHandle(HT,GetHandleId(t),3,u)
        
        call SaveReal(HT_unitstate,GetHandleId(u),i,LoadReal(HT_unitstate,GetHandleId(u),i)+ r)   

        call TimerStart(t,time,false,function endTimerState)
        set t = null
    endfunction

    struct CustomStateBonus extends array
        unit source
        real bonus
        boolean stop
        integer state
        integer endTick

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or (not UnitAlive(this.source)) or this.stop then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        static method create takes unit source, integer state, real bonus, real duration returns thistype
            local thistype this

            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.stop = false
            set this.source = source
            set this.bonus = bonus
            set this.state = state
            call SaveReal(HT_unitstate, GetHandleId(source), state, LoadReal(HT_unitstate, GetHandleId(source), state) + bonus)   

            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call SaveReal(HT_unitstate, GetHandleId(this.source), this.state, LoadReal(HT_unitstate, GetHandleId(this.source), this.state) - this.bonus)
            set this.source = null
            set this.stop = true
            set this.bonus = 0
            set recycleNext = recycle
            set recycle = this
        endmethod

        implement T32x
    endstruct

    function GetHeroMaxAbsoluteAbility takes unit u returns integer
        return LoadInteger(HT,GetHandleId(u),- 8852352)
    endfunction

    function AddHeroMaxAbsoluteAbility takes unit u returns boolean 
        if GetHeroMaxAbsoluteAbility(u) < 10 then

            call SaveInteger(HT,GetHandleId(u),- 8852352,LoadInteger(HT,GetHandleId(u),- 8852352)+ 1)
            call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,("|cffffcc00An extra Absolute Ability slot is available."))
            return true
        else
            return false

        endif
    endfunction
endlibrary
