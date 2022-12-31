library BonusExp initializer init requires RandomShit

    private function BonusExpConditions takes nothing returns boolean
        return (GetOwningPlayer(GetTriggerUnit()) == Player(11)) and (IsUnitIllusion(GetTriggerUnit()) != true)
    endfunction

    private function HeroFilter takes nothing returns boolean
        return (IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true)
    endfunction

    private function ShortGameModeActions takes nothing returns nothing
        local real bonus = 1
        //call BJDebugMsg("be xp bonus pre: " + R2S(bonus))
        set bonus = bonus + GetLearnabilityBonus(GetEnumUnit()) + GetMagicNecklaceBonus(GetEnumUnit(), GetTriggerUnit())
        //call BJDebugMsg("be xp bonus post: " + R2S(bonus))

        call AddHeroXP(GetEnumUnit(), R2I(((RoundCreepPower) * 55) * bonus), true)
    endfunction

    private function LongGameModeActions takes nothing returns nothing
        local real bonus = 1 
        //call BJDebugMsg("be xp bonus pre: " + R2S(bonus))
        set bonus = bonus + GetLearnabilityBonus(GetEnumUnit()) + GetMagicNecklaceBonus(GetEnumUnit(), GetTriggerUnit())
        //call BJDebugMsg("be xp bonus post: " + R2S(bonus))

        call AddHeroXP(GetEnumUnit(), R2I(((RoundCreepPower) * 35) * bonus), true)
    endfunction

    private function BonusExpActions takes nothing returns nothing
        local group killingPlayerUnits = GetUnitsOfPlayerMatching(GetOwningPlayer(GetKillingUnit()), Condition(function HeroFilter))

        if (GameModeShort == true) then
            call ForGroup(killingPlayerUnits, function ShortGameModeActions)
        else
            call ForGroup(killingPlayerUnits, function LongGameModeActions)
        endif

        // Cleanup
        call DestroyGroup(killingPlayerUnits)
        set killingPlayerUnits = null
    endfunction

    private function init takes nothing returns nothing
        set BonusExpTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(BonusExpTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(BonusExpTrigger, Condition(function BonusExpConditions))
        call TriggerAddAction(BonusExpTrigger, function BonusExpActions)
    endfunction

endlibrary
