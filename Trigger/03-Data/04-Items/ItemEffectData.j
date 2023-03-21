library ItemEffectdata initializer init requires ItemEffects

    function ArmorofTheGoddessEffect takes ItemAbilData data returns nothing
        call SetupItemAbility('I01D', 'ACev', 0, 0, 0)
        call AddUnitBonus(data.source, BONUS_STRENGTH, data.itemDiff * 12)
        call AddUnitBonus(data.source, BONUS_AGILITY, data.itemDiff * 12)
        call AddUnitBonus(data.source, BONUS_INTELLIGENCE, data.itemDiff * 12)
        call AddUnitBonus(data.source, BONUS_ARMOR, data.itemDiff * 10)
    endfunction

    function BlokkadeshieldEffect takes ItemAbilData data returns nothing
        call AddUnitCustomState(data.source, BONUS_BLOCK, 1000 * data.itemUniqueDiff)
		call AddUnitCustomState(data.source, BONUS_MAGICRES, 30 * data.itemUniqueDiff)
    endfunction

    function ContractOflivingEffect takes ItemAbilData data returns nothing
        call AddUnitCustomState(data.source, BONUS_MAGICRES, 30 * data.itemUniqueDiff)
    endfunction

    function FishingRodEffect takes ItemAbilData data returns nothing
        call AddUnitCustomState(data.source, BONUS_EVASION, 10 * data.itemUniqueDiff)
        call AddUnitBonus(data.source, BONUS_DAMAGE, 800 * data.itemUniqueDiff)
        call BlzSetUnitWeaponIntegerField(data.source, ConvertUnitWeaponIntegerField('ua1r'), 0, BlzGetUnitWeaponIntegerField(data.source, ConvertUnitWeaponIntegerField('ua1r'), 0) + 1128 * data.itemUniqueDiff)
        call AddUnitAbsoluteBonusCount(data.source, Element_Wind, data.itemUniqueDiff)
    endfunction

    function SnowwwsWandEffect takes ItemAbilData data returns nothing
        call AddUnitCustomState(data.source, BONUS_MAGICPOW, 60 * data.itemUniqueDiff)
		call AddUnitAbsoluteBonusCount(data.source, Element_Arcane, data.itemUniqueDiff)
    endfunction

    private function init takes nothing returns nothing
        call AddItemEffect('I07T', ItemEffect.FishingRodEffect)
        call AddItemEffect('I07V', ItemEffect.BlokkadeshieldEffect)
        call AddItemEffect(CONTRACT_LIVING_ITEM_ID, ItemEffect.ContractOflivingEffect)
        call AddItemEffect(BLOKKADE_SHIELD_ITEM_ID, ItemEffect.SnowwwsWandEffect)
    endfunction
endlibrary
