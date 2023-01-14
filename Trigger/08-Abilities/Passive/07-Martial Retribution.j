library MartialRetribution initializer init requires AreaDamage, HideEffects, AbilityDescription, AbilityCooldown
    globals
        Table MartialRetributionStorage
    endglobals

    function UpdateMartialRetributionText takes integer handleId, player p, integer abilLvl, integer heroLvl returns nothing
        local string s = UpdateAbilityDescription(GetAbilityDescription(MARTIAL_RETRIBUTION_ABILITY_ID, abilLvl - 1), p, MARTIAL_RETRIBUTION_ABILITY_ID, ",s00,", R2I(MartialRetributionStorage.real[handleId]), abilLvl)
        call UpdateAbilityDescription(s, p, MARTIAL_RETRIBUTION_ABILITY_ID, ",s01,", R2I((300 * abilLvl) * (1 + 0.02 * heroLvl)), abilLvl)
    endfunction

    function MartialRetributionDamage takes unit source, integer handleId, real damage returns nothing
        local effect fx
        
        call AreaDamage(source, GetUnitX(source), GetUnitY(source), damage, 600, false, MARTIAL_RETRIBUTION_ABILITY_ID, false)
        set fx = AddLocalizedSpecialEffect("war3mapImported\\EarthNova.mdx", GetUnitX(source), GetUnitY(source))
        call BlzSetSpecialEffectScale(fx, 0.5)
        call DestroyEffect(fx)
        set MartialRetributionStorage.real[handleId] = MartialRetributionStorage.real[handleId] - damage 
        
        set fx = null
    endfunction

    function MartialRetributionCheck takes unit source, integer handleId, integer lvl returns nothing
        local real max = (300 * lvl) * (1 + 0.02 * GetHeroLevel(source))
        
        if MartialRetributionStorage.real[handleId] >= max then
            set MartialRetributionStorage.real[handleId] = max
            call MartialRetributionDamage(source, handleId, max)
            call AbilStartCD(source, MARTIAL_RETRIBUTION_ABILITY_ID, 2)
        endif
    endfunction

    function MartialRetributionStore takes unit source, real damage returns nothing
        local integer lvl = GetUnitAbilityLevel(source, MARTIAL_RETRIBUTION_ABILITY_ID)
        local integer handleId = GetHandleId(source)

        if damage > 0 then
            set MartialRetributionStorage.real[handleId] = MartialRetributionStorage.real[handleId] + damage
        endif
        
        call MartialRetributionCheck(source, handleId, lvl)
        call UpdateMartialRetributionText(handleId, GetOwningPlayer(source), lvl, GetHeroLevel(source))
    endfunction

    private function init takes nothing returns nothing
        set MartialRetributionStorage = Table.create()
    endfunction
endlibrary