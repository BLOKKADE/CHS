library ContractLiving initializer init requires TempAbilSystem, RandomShit, HeroAbilityCooldown

    globals
        Table ContractLivingTick
    endglobals

    function IsContractLivingAvailable takes unit u, real damage returns boolean
        return GetUnitAbilityLevel(u, CONTRACT_LIVING_ABIL_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(u, CONTRACT_LIVING_ABIL_ID) == 0 and (GetUnitState(u, UNIT_STATE_LIFE) - damage) / GetUnitState(u, UNIT_STATE_MAX_LIFE) * 100.0 < 50
    endfunction

    function ActivateContractLiving takes unit u returns nothing
        local ability abil = BlzGetUnitAbility(u, CONTRACT_LIVING_ABIL_ID)
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_MAX_LIFE))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", GetUnitX(u), GetUnitY(u)))
        call AbilStartCD(u, CONTRACT_LIVING_ABIL_ID, 90 + GetAbilityCooldownBonus(abil))
        call SetAbilityCooldownBonus(abil, 5)
        call TempAbil.create(u, CONTRACT_LIVING_BUFF_ID, 5)
    endfunction

    private function init takes nothing returns nothing
        set ContractLivingTick = Table.create()
    endfunction
endlibrary
