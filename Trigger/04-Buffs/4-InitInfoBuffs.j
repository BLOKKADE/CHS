globals
    hashtable HT_buff = InitHashtable()
    integer TypeDmg_b = 0 
    constant integer Buff_Type_passive = 2
endglobals


function Init_HtBUFF takes nothing returns nothing

    call SaveInteger(HT_buff,INCINERATE_CUSTOM_BUFF_ID,1,Buff_Type_passive)
    call SaveInteger(HT_buff,POISON_NON_STACKING_CUSTOM_BUFF_ID,1,Buff_Type_passive)

endfunction