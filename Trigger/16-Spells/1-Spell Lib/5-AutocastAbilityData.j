globals

    integer array ListAAT
    integer CountAAT 
    
    
    integer array HolyShieldS
    integer CountHolyShieldS 
endglobals


function InitArcaneTalant takes nothing returns nothing
    set ListAAT[0] = 'AHbn'
    set ListAAT[1] = 'AHfs'
    set ListAAT[2] = 'AHbz'
    set ListAAT[3] = 'Ainf'
    set ListAAT[4] = 'AOhw'
    set ListAAT[5] = 'AOsw'
    set ListAAT[6] = 'AOsh'
    set ListAAT[7] = 'Asta'
    set ListAAT[8] = 'AUin'    
    set ListAAT[9] = 'AUfu'
    set ListAAT[10] = 'AUdd'
    set ListAAT[11] = 'AUcs'
    set ListAAT[12] = 'AUim'
    set ListAAT[13] = 'Aam2'
    set ListAAT[14] = 'Auhf'
    set ListAAT[15] = 'Arej'
    set ListAAT[16] = 'ANhs'    
    set ListAAT[17] = 'ANvc'    
    set ListAAT[18] = 'ANst'    
    set ListAAT[18] = 'ANst'  
    set ListAAT[19] = 'ANcs'  
    set ListAAT[20] = 'ANsi'
    set ListAAT[21] = 'ANrf'
    set ListAAT[22] = 'ANbf'
    set ListAAT[23] = 'ANsy'
    set ListAAT[24] = 'ACls' 
    set ListAAT[25] = 'A046'   
    set ListAAT[26] = 'A017'  
    set ListAAT[27] = 'A05X'  
    set ListAAT[28] = 'Ablo'
    set ListAAT[29] = 'Ahwd'   
    set ListAAT[30] = 'ANmo' 
    set ListAAT[31] = 'Aclf'     
    set ListAAT[32] = 'AHhb'
    set ListAAT[33] = 'Arej'    
    set CountAAT = 33
    
    
    set HolyShieldS[0] = 'AHhb'
    set HolyShieldS[1] = 'Ahwd'
    set HolyShieldS[2] = 'AOhw'
    set HolyShieldS[3] = 'Arej'
    
    set CountHolyShieldS = 3
endfunction


function CastAbility takes unit u, integer sp, integer lvl returns nothing
    local unit DummyU = CreateUnit(GetOwningPlayer(u),'h015',GetUnitX(u),GetUnitY(u),GetUnitFacing(u))
    local integer Type = LoadInteger(HT_AbilityData,sp,1) 
    local string  Order = LoadStr(HT_AbilityData,sp,2)
    local boolean CAST = false
    

    
    
    call UnitAddAbility(DummyU,sp) 
    call SetUnitAbilityLevel(DummyU,sp,lvl)
    call BlzSetAbilityRealLevelField(BlzGetUnitAbility(DummyU,sp),ConvertAbilityRealLevelField('aran'),lvl-1,9999999)


    call UnitApplyTimedLife(DummyU,  'BTLF', 21) 
    set CAST =  IssueTargetOrder(DummyU,Order,u)  
        
    if CAST == false then
        set CAST =  IssuePointOrder(DummyU,Order,GetUnitX(u),GetUnitY(u)) 
        
        if CAST == false then
            set CAST = IssuePointOrderById(DummyU,OrderId(Order),GetUnitX(u),GetUnitY(u)  )
        endif
    endif
       


    
     set Order = null
     set DummyU = null
endfunction



function UseSpellsAT takes unit u returns nothing
local integer i = 0

    loop
        exitwhen i > CountAAT
        
        if   GetNumHeroSpell(u, ListAAT[i]) != 0 then
          call CastAbility(u,ListAAT[i],GetUnitAbilityLevel(u,ListAAT[i]))
        endif
        
        
        set i = i + 1
    endloop


endfunction



function UseSpellsHolyShield takes unit u returns nothing
local integer i = 0

    loop
        exitwhen i > CountHolyShieldS
        
        if   GetNumHeroSpell(u, HolyShieldS[i]) != 0 then
          call CastAbility(u,HolyShieldS[i],GetUnitAbilityLevel(u,HolyShieldS[i]))
        endif
        
        
        set i = i + 1
    endloop


endfunction
