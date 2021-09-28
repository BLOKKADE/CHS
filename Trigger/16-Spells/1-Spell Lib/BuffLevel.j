library BuffLevel initializer Init requires Table
    //allows buffs to have levels so they can stack
        globals
            HashTable buffTable
        endglobals
    
        function GetBuffLevel takes unit u, integer buffId returns integer
            local integer uid = GetHandleId(u)
            if buffTable.has(uid) and buffTable[uid].has(buffId) then
                return buffTable[uid][buffId]
            endif
            return 0
        endfunction
    
        function RegisterBuff takes unit u, integer buffId returns nothing
            local integer uid = GetHandleId(u)
            set buffTable[uid][buffId] = buffTable[uid][buffId] + 1
            //call BJDebugMsg("buff level: " + I2S(buffTable[uid][buffId]))
        endfunction
    
        function RemoveBuff takes unit u, integer buffId returns boolean
            local integer uid = GetHandleId(u)
            if buffTable.has(uid) then
                //call BJDebugMsg("unit is in table")
                if buffTable[uid].has(buffId) then
                    //call BJDebugMsg("buff is in table")
                    set buffTable[uid][buffId] = buffTable[uid][buffId] - 1
                    if buffTable[uid][buffId] == 0 then
                        //call BJDebugMsg("0 levels of buff, removing")
                        call UnitRemoveAbility(u, buffId)
                        return true
                    endif
                endif
            endif
            return false
        endfunction
    
        private function Init takes nothing returns nothing
            set buffTable = buffTable.create()
        endfunction
    endlibrary