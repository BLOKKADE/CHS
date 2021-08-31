function ResetSpell takes unit hero, integer SpellId, real time returns nothing
    local real cur_time
        
        if LoadBoolean(Elem,SpellId,4) then
            set cur_time = time*2
        else
            set cur_time = time
        endif 
        
        if BlzGetUnitAbilityCooldownRemaining(hero,SpellId)>0 then
            call BlzStartUnitAbilityCooldown(hero,SpellId,BlzGetUnitAbilityCooldownRemaining(hero,SpellId)-time )
            elseif  BlzGetUnitAbilityCooldownRemaining(hero,SpellId) <  time then
              call BlzEndUnitAbilityCooldown(hero,SpellId)
        endif
endfunction


function SandRefreshAbility takes unit hero, real time returns nothing
   local integer i1 = 0
   local integer SpellId = 0
   local real cur_time 
   
   loop
        exitwhen i1 > 10
        call ResetSpell(hero, GetInfoHeroSpell(hero ,i1), time)
        set i1 = i1 + 1
    endloop

    if GetUnitTypeId(hero) == 'H01C' then
        call ResetSpell(hero, 'A08U', time)
    endif
endfunction
