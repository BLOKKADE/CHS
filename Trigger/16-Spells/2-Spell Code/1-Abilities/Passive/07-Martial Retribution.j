library MartialRetribution requires AoeDamage, RandomShit, AbilityDescription
    function MartialRetributionDamage takes unit source, integer handleId, real damage returns nothing
        local effect fx
        
        call AreaDamagePhys(source, GetUnitX(source), GetUnitY(source), damage, 600, MARTIAL_RETRIBUTION_ABILITY_ID)
        set fx = AddSpecialEffect("war3mapImported\\EarthNova.mdx", GetUnitX(source), GetUnitY(source))
        call BlzSetSpecialEffectScale(fx, 0.5)
        call DestroyEffect(fx)
        set SpellData[handleId].real[3] = SpellData[handleId].real[3] - damage 
        
        set fx = null
    endfunction

    function MartialRetributionCheck takes unit source, integer handleId, integer lvl returns nothing
        local real max = (300 * lvl) * (1 + 0.02 * GetHeroLevel(source))
        
        if SpellData[handleId].real[3] >= max then
            set SpellData[handleId].real[3] = max
            call MartialRetributionDamage(source, handleId, max)
            call AbilStartCD(source, MARTIAL_RETRIBUTION_ABILITY_ID, 2)
        endif
    endfunction

    function MartialRetributionStore takes unit source, real damage returns nothing
        local integer lvl = GetUnitAbilityLevel(source, MARTIAL_RETRIBUTION_ABILITY_ID)
        local integer handleId = GetHandleId(source)
        local string s = GetAbilityDescription(MARTIAL_RETRIBUTION_ABILITY_ID, lvl - 1)
        local real max = (300 * lvl) * (1 + 0.02 * GetHeroLevel(source))
        set SpellData[handleId].real[3] = SpellData[handleId].real[3] + damage
        
        call MartialRetributionCheck(source, handleId, lvl)
        
        set s = UpdateAbilityDescription(s, GetOwningPlayer(source), MARTIAL_RETRIBUTION_ABILITY_ID, ",s00,", R2I(SpellData[handleId].real[3]), lvl)
        call UpdateAbilityDescription(s, GetOwningPlayer(source), MARTIAL_RETRIBUTION_ABILITY_ID, ",s01,", R2I(max), lvl)
    endfunction
endlibrary