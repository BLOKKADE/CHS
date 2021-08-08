function HealUnit takes unit u1, unit u2, real hp returns nothing


    call SetWidgetLife(u2,GetWidgetLife(u2)+hp)
endfunction