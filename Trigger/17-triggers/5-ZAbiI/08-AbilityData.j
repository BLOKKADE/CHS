function  AbilityDataOrTempAD takes unit u, integer id, real lvl returns AbilityData
    if GetUnitAbilityLevel(u,id) > 0 then
        return GetAbilityData(u,id)
    else
        return TempAbilityData(id,lvl)
    endif
endfunction