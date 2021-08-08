function LossHp takes unit u1, unit u2, real hp returns nothing

    if hp < GetWidgetLife(u2)+0.405 then
        call SetWidgetLife(u2,GetWidgetLife(u2) - hp)
    else
        call SetWidgetLife(u2,1)
    endif

    set u1 = null
    set u2 = null
endfunction