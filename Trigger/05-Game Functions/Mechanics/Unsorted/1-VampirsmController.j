library Vampirism requires UnitItems, DivineBubble
    function Vamp takes unit source, unit target, real amount returns nothing
        local real V1 = 0
        local real V2 = 0
        local integer i1 = 0
        
        //Bloodstone passive
        if UnitHasItemType(target, 'I0AK') then
            set amount = amount * 0.4
        endif

        set i1 = GetUnitAbilityLevel(target, WILD_DEFENSE_SUMMON_ABILITY_ID)
        if i1 > 0 then
            set amount = amount * (1 - (0.175 + (0.0175 * i1)))
        endif

        //Bloodstone target & Divine Bubble
        if amount <= 0 or GetUnitAbilityLevel(source, BLOODSTONE_BUFF_ID) > 0 or IsUnitDivineBubbled(target) or GetUnitAbilityLevel(source, 'B022') > 0 then
            return
        endif

        //Absolute Blood
        set i1 = GetUnitAbilityLevel(source,ABSOLUTE_BLOOD_ABILITY_ID)
        if i1 > 0 then
        
            set V1 = LoadReal(HT,GetHandleId(source),- 93000)
            set V2 = LoadReal(HT,GetHandleId(source),- 93001)
            
            if V2 == 0 then
                set V2 = 50
            endif
            
            set V1 = amount + V1
            
            loop
                exitwhen V2 > V1 
                set V1 = V1 - V2 
                set V2 = V2 + 1
                call BlzSetUnitMaxHP(source,BlzGetUnitMaxHP(source)+ 4)
            endloop
            
            call SaveReal(HT,GetHandleId(source),- 93000,V1)
            call SaveReal(HT,GetHandleId(source),- 93001,V2) 
        endif

        call ShowLifestealText(source, target, amount)

        call SetWidgetLife(source,GetWidgetLife(source)+ amount )
    endfunction
endlibrary