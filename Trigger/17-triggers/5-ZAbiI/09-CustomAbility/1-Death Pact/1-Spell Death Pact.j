function CastDeathPact takes unit u, unit target, real lvl returns nothing
    local AbilityData A = AbilityDataOrTempAD(u,'A00M',lvl)
    local real healAmount = GetWidgetLife(target) * A.GetParam1()

    call HealUnit(u, target, healAmount)
    
    call AddSpecialEffectTargetTimer( "Abilities\\Spells\\Undead\\DeathPact\\DeathPactCaster.mdl", u, "origin", 2)
    call AddSpecialEffectTargetTimer( "Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl", target, "origin", 2)
    
    call A.MayByRemove() 
endfunction