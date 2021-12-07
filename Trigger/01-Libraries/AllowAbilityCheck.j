library AllowCastCheck
    private function CheckUnitGroup takes unit u returns boolean
        if(not(IsUnitInGroup(u,udg_group02)!=true))then
            return false
        endif
        if(not(IsPlayerInForce(GetOwningPlayer(u),udg_force03)==true))then
            return false
        endif
        return true
    endfunction
    
    private function CheckUnit takes unit u returns boolean
        if((u==udg_unit05))then
            return true
        endif
        if((RectContainsUnit(udg_rect09,u)==true))then
            return true
        endif
        if(CheckUnitGroup(u))then
            return true
        endif
        return false
    endfunction
    
    function CheckIfCastAllowed takes unit u returns boolean
        if(not(udg_boolean02==false))then
            return false
        endif
        if(not(udg_boolean03==false))then
            return false
        endif
        if(not CheckUnit(u))then
            return false
        endif
        if(not(GetUnitTypeId(u)!='n00V'))then
            return false
        endif
        if(not(GetUnitTypeId(u)!=PRIEST_1_UNIT_ID))then
            return false
        endif	
        if(not(GetUnitTypeId(u)!='h014'))then
            return false
        endif		
        return true
    endfunction
    
    function Trig_Disable_Abilities_Func001C takes unit u returns boolean
        return CheckIfCastAllowed(u)
    endfunction
endlibrary