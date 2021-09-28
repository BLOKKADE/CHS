library Vampirism requires RandomShit
    function Vamp takes unit u1, unit u2,real vamp returns nothing
        local real V1 = 0
        local real V2 = 0
        local integer i1 = 0
        
        //Bloodstone passive
        if UnitHasItemS(u2, 'I0AK') then
            set vamp = vamp * 0.7
        endif

        //Bloodstone target & Divine Bubble
        if GetUnitAbilityLevel(u1, 'B01V') > 0 or IsUnitDivineBubbled(u2) or GetUnitAbilityLevel(u1, 'B022') > 0 then
            return
        endif

        //Ancient Blood
        set i1 = GetUnitAbilityLevel(u1,'A07R')
        if i1 > 0 then
        
            set V1 = LoadReal(HT,GetHandleId(u1),-93000)
            set V2 = LoadReal(HT,GetHandleId(u1),-93001)
            
            if V2 == 0 then
                set V2 = 50
            endif
            
            set V1 = vamp + V1
            
            loop
                exitwhen V2 > V1 
                set V1 = V1 - V2 
                set V2 = V2 + 1
                call BlzSetUnitMaxHP(u1,BlzGetUnitMaxHP(u1)+4)
            endloop
            
            call SaveReal(HT,GetHandleId(u1),-93000,V1)
            call SaveReal(HT,GetHandleId(u1),-93001,V2) 
        endif

        call SetWidgetLife(u1,GetWidgetLife(u1)+ vamp )
        set u1 = null
        set u2 = null
    endfunction
endlibrary