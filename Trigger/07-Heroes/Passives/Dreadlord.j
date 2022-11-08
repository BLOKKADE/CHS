library Drealord initializer init requires require_libs
    private function DreadlordLifeSteal takes unit source, unit target returns nothing
        call SetUnitState(saource, UNIT_STATE_LIFE, GetUnitState(source, UNIT_STATE_LIFE) + (GetUnitState(source, UNIT_STATE_MAX_LIFE) * 0.1))
        call DestroyEffect(AddLocalizedSpecialEffectTarget("hand right", source, "Abilities\\Weapons\\HydraliskImpact\\HydraliskImpact.mdl"))
        call DestroyEffect(AddLocalizedSpecialEffectTarget("hand left", source, "Abilities\\Weapons\\HydraliskImpact\\HydraliskImpact.mdl"))
        call DestroyEffect(AddLocalizedSpecialEffectTarget("origin", target, "Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl"))
    endfunction
endlibrary
