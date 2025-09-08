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
    local integer i = 0
    local real aoe
    local real damageFactor

    call ElemFuncStart(u, DEMONS_CURSE_ABILITY_ID)
    
    if UnitHasItemType(u, 'TSBB') then
        call AbilStartCD(u, DEMONS_CURSE_ABILITY_ID, 60)
    else
        call AbilStartCD(u, DEMONS_CURSE_ABILITY_ID, 120)
    endif

    loop
        exitwhen i >= 3

        if i == 0 then
            set aoe = 2000.0
            set damageFactor = 0.25
        elseif i == 1 then
            set aoe = 1000.0
            set damageFactor = 0.5
        else
            set aoe = 500.0
            set damageFactor = 1.0
        endif

        // Create dummy for this AoE tier
        set dummy = DummyOrder.create(u, x, y, GetUnitFacing(u), 6)
        call dummy.addActiveAbility(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, 1, 852588)
        call dummy.setAbilityIntegerField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_ILF_DEFENSE_INCREASE_ROA2, R2I(reduction * damageFactor))
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_HERO, duration)
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_NORMAL, duration)
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_AREA_OF_EFFECT, aoe)
        call dummy.instant()
        call dummy.activate()

        // Apply VioletPulse effect to enemies in range
        call GroupEnumUnitsInRange(g, x, y, aoe, null)
        loop
            set target = FirstOfGroup(g)
            exitwhen target == null
            call GroupRemoveUnit(g, target)
            if IsUnitEnemy(target, GetOwningPlayer(u)) and IsUnitAliveBJ(target) then
                call DestroyEffectAfterDelay(AddSpecialEffectTarget("war3mapImported\\VioletPulse.mdx", target, "origin"), 8.0 + (0.09 * heroLevel))
            endif
        endloop

        set i = i + 1
    endloop

    call DestroyGroup(g)
endfunction

endlibrary
