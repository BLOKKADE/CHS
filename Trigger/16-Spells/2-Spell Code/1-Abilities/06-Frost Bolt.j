library FrostBolt requires RandomShit
    function UsOrderUTimer51 takes unit u1, unit u2, real dmg returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, GetUnitX(u1), GetUnitY(u1), GetUnitFacing(u1), 6)
        call dummy.addActiveAbility('A07Y', 1, 852095)
        call dummy.setAbilityRealField('A07Y', ABILITY_RLF_DAMAGE_CTB1, dmg)
        call dummy.target(u2)
    endfunction

    function realaisFrostBolt takes nothing returns nothing 
        local timer t = GetExpiredTimer()
        local unit u1 = LoadUnitHandle(HT,GetHandleId(t),3)
        local unit u2 = LoadUnitHandle(HT,GetHandleId(t),4)    
        local integer count = LoadInteger(HT,GetHandleId(t),1)
        
        
        
        if count == 0 then
            call FlushChildHashtable(HT,GetHandleId(t))
            call ReleaseTimer(t)
        else 
            set count = count - 1 
            call UsOrderUTimer51(u1,u2,LoadReal(HT,GetHandleId(t),2))   
            call SaveInteger(HT,GetHandleId(t),1,count)
        endif


        
        

        set t = null
        set u1 = null
        set u2 = null
    endfunction

    function UsFrostBolt takes unit u1, unit u2,real dmg, integer count returns nothing
        local timer t = NewTimer()
        call SaveInteger(HT,GetHandleId(t),1,count)
        call SaveReal(HT,GetHandleId(t),2,dmg)
        call SaveUnitHandle(HT,GetHandleId(t),3,u1)
        call SaveUnitHandle(HT,GetHandleId(t),4,u2)
        
        call TimerStart(t,0.1,true,function realaisFrostBolt)
        
        set t = null
    endfunction
endlibrary