library ScrollOfTransformation initializer init requires Table
    globals
        HashTable ScrollOfTransformationTable
    endglobals
    
    private function EndTimerTr takes nothing returns nothing
        local timer Tr = GetExpiredTimer()
        local unit u = ScrollOfTransformationTable[GetHandleId(Tr)].unit[0]
        local integer i1 = ScrollOfTransformationTable[GetHandleId(Tr)].integer[1]
        local integer i2 = ScrollOfTransformationTable[GetHandleId(Tr)].integer[2]
        
        call SetHeroAgi(u,GetHeroAgi(u,false)+ i1,false)
        call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0) - i2 ,0) 
        
        set ScrollOfTransformationTable[GetHandleId(Tr)].unit[0] = null
        call ScrollOfTransformationTable.remove(GetHandleId(Tr))
        call ReleaseTimer(Tr)
        set Tr = null
        set u = null
    endfunction

    function CastScrollOfTransformation takes unit caster returns nothing
        local timer Tr = null
        local integer i1 = 0
        local integer i2 = 0

        set i1 = GetHeroAgi(caster,true)* 3
        set i2 = i1 * 2
        
        call SetHeroAgi(caster,GetHeroAgi(caster,false)- i1,false)
        call BlzSetUnitBaseDamage(caster,BlzGetUnitBaseDamage(caster,0) + i2 ,0)

        set Tr = NewTimer()
        set ScrollOfTransformationTable[GetHandleId(Tr)].unit[0] = caster
        set ScrollOfTransformationTable[GetHandleId(Tr)].integer[1] = i1
        set ScrollOfTransformationTable[GetHandleId(Tr)].integer[2] = i2
        call TimerStart(Tr,15,false,function EndTimerTr )      
        set Tr = null
    endfunction

    private function init takes nothing returns nothing
        set ScrollOfTransformationTable = HashTable.create()
    endfunction
endlibrary