function HolyLight takes unit u, unit u2, real lvl returns nothing
    local AbilityData A = AbilityDataOrTempAD(u,'A084',lvl)

    if IsUnitEnemy(u,GetOwningPlayer(u2)) then
        call MagicDamage(u,u2,A.GetDamage1(),'A084')
    else
        call HealUnit(u,u2,A.GetParam1())
    endif
    call AddSpecialEffectTargetTimer( "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", u2, "chest",2)

    call A.MayByRemove() 
endfunction