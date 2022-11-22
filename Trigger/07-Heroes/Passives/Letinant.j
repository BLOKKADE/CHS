library Letinant initializer init requires HeroLvlTable

    globals
        Table LetinantStatBonus
    endglobals

    function LetinantBonus takes unit u, integer levels returns nothing
        local integer stat = 0
        local integer i = 0
        local integer bonus = 0

        set LetinantStatBonus[GetHandleId(u)] = 5 + (((GetHeroLevel(u) - ModuloInteger(GetHeroLevel(u), 10)) / 10))
        set bonus = LetinantStatBonus[GetHandleId(u)]
        call SetBonus(u, 3, bonus)

        loop
            set stat = GetRandomInt(1,3)
            if stat == 1 then
                call SetHeroStr(u,GetHeroStr(u,false)+ bonus,false) 
                call UpdateBonus(u, 0, bonus)
            elseif stat == 2 then
                call SetHeroAgi(u,GetHeroAgi(u,false)+ bonus,false)  
                call UpdateBonus(u, 1, bonus) 
            elseif stat == 3 then    
                call SetHeroInt(u,GetHeroInt(u,false)+ bonus,false) 
                call UpdateBonus(u, 2, bonus)  
            endif
            set stat = GetRandomInt(1,3)
            if stat == 1 then
                call SetHeroStr(u,GetHeroStr(u,false)+ bonus,false) 
                call UpdateBonus(u, 0, bonus)
            elseif stat == 2 then
                call SetHeroAgi(u,GetHeroAgi(u,false)+ bonus,false)   
                call UpdateBonus(u, 1, bonus)
            elseif stat == 3 then    
                call SetHeroInt(u,GetHeroInt(u,false)+ bonus,false)   
                call UpdateBonus(u, 2, bonus)
            endif
            
            set i = i + 1
            exitwhen i >= levels
        endloop
    endfunction

    private function init takes nothing returns nothing
        set LetinantStatBonus = Table.create()
    endfunction
endlibrary
