globals
    hashtable HT_buff = InitHashtable()
    integer TypeDmg_b = 0 
    constant integer Buff_Type_passive = 2
endglobals


function Init_HtBUFF takes nothing returns nothing

    call SaveInteger(HT_buff,'B014',1,Buff_Type_passive)
    call SaveInteger(HT_buff,'B015',1,Buff_Type_passive)

endfunction