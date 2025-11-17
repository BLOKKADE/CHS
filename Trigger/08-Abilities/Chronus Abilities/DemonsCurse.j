library DemonsCurse requires DummySpell, AbilityCooldown, RandomShit

globals
    hashtable udg_EffectHash = InitHashtable()
endglobals

function DestroyEffectCallback takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local effect e = LoadEffectHandle(udg_EffectHash, GetHandleId(t), 0)
    call DestroyEffect(e)
    call FlushChildHashtable(udg_EffectHash, GetHandleId(t))
    call DestroyTimer(t)
endfunction

function DestroyEffectAfterDelay takes effect e, real delay returns nothing
    local timer t = CreateTimer()
    call SaveEffectHandle(udg_EffectHash, GetHandleId(t), 0, e)
    call TimerStart(t, delay, false, function DestroyEffectCallback)
endfunction

function CastDemonsCurse takes unit u, real chronusBonus, integer abilLevel, integer heroLevel returns nothing
    local DummyOrder dummy
    local real reduction = ((10 * abilLevel) * (1 + 0.02 * heroLevel))
    local real duration = (8.0 + (0.09 * heroLevel)) * chronusBonus
    local group g = CreateGroup()
    local unit target
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local real aoe = 2000.0
    local real dist
    local real factor

    call ElemFuncStart(u, DEMONS_CURSE_ABILITY_ID)

    if UnitHasItemType(u, 'TSBB') then
        call AbilStartCD(u, DEMONS_CURSE_ABILITY_ID, 60)
    else
        call AbilStartCD(u, DEMONS_CURSE_ABILITY_ID, 120)
    endif

    // Create dummy covering full 2000 AoE
    set dummy = DummyOrder.create(u, x, y, GetUnitFacing(u), 6)
    call dummy.addActiveAbility(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, 1, 852588)
    call dummy.setAbilityIntegerField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_ILF_DEFENSE_INCREASE_ROA2, R2I(reduction)) // base reduction
    call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_HERO, duration)
    call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_NORMAL, duration)
    call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_AREA_OF_EFFECT, aoe)
    call dummy.instant()
    call dummy.activate()

    // Apply VioletPulse effect to enemies in range with tapering
    call GroupEnumUnitsInRange(g, x, y, aoe, null)
    loop
        set target = FirstOfGroup(g)
        exitwhen target == null
        call GroupRemoveUnit(g, target)
        if IsUnitEnemy(target, GetOwningPlayer(u)) and IsUnitAliveBJ(target) then
            set dist = SquareRoot((GetUnitX(target)-x)*(GetUnitX(target)-x) + (GetUnitY(target)-y)*(GetUnitY(target)-y))
            set factor = Pow(0.7, R2I(dist/300.0)) // tapering: 0.7^steps
            // Apply effect scaled by factor
            call DestroyEffectAfterDelay(AddSpecialEffectTarget("war3mapImported\\VioletPulse.mdx", target, "origin"), duration)
            call CreateTextTagTimerColor("Demon's Curse!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)
            // Example: you could apply scaled reduction here if needed
            // call UnitAddBonusArmor(target, R2I(reduction * factor))
        endif
    endloop

    call DestroyGroup(g)
endfunction

endlibrary
