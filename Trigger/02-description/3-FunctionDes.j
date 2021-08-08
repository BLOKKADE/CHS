function GetClassification takes integer id returns string
    local string s = ""
    local integer i = 1
    loop
        exitwhen i > 15
        if LoadBoolean(Elem,id,i) then
            set s = s + ClassAbil[i]
        endif
        set i = i + 1
    endloop
    return s
endfunction