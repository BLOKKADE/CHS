library Killing initializer init requires AllowCasting, HideEffects, AreaDamage, Dreadlord, BlackArrow, NecromancerArmy, Vampirism, TempStateBonus
    
    private function KillingActions takes nothing returns nothing
        local unit target = GetTriggerUnit()
        local integer targetId = GetHandleId(target)
        local unit killer = GetKillingUnit()
        local player targetPlayer = GetOwningPlayer(target)
        local player killingPlayer = GetOwningPlayer(killer)
        local integer targetPid = GetPlayerId(targetPlayer)
        local integer killingPid = GetPlayerId(killingPlayer)
        local unit targetHero = PlayerHeroes[targetPid]
        local unit killingHero = PlayerHeroes[killingPid]
        local integer i = 0
        local timer t
        local effect fx

        if GetUnitAbilityLevel(target, 'Aloc') > 0 or GetUnitTypeId(target) == 'uplg' or (killingPlayer != Player(11) and HasPlayerFinishedLevel(killer, killingPlayer)) or (targetPlayer != Player(11) and HasPlayerFinishedLevel(target, targetPlayer)) then
            set target = null
            set killer = null
            set killingHero = null
            set targetHero = null
            set targetPlayer = null
            set killingPlayer = null
            return
        endif

        //Incinerate
        if GetUnitAbilityLevel(target, 'A06L') > 0 then
            call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", target, "head"))
            call AreaDamage(LoadUnitHandle(HT, targetId, -300003), GetUnitX(target), GetUnitY(target), LoadInteger(HT, targetId, -300002), 300, true, INCINERATE_ABILITY_ID, true, false)
        endif

        //Dreadlord
        if GetUnitTypeId(killingHero) == DEADLORD_UNIT_ID then
            call DreadlordLifeSteal(killingHero, target)
        endif
        
        //Black Arrow
        set i = GetUnitAbilityLevel(killingHero, BLACK_ARROW_PASSIVE_ABILITY_ID)
        if i > 0 and killer != null and IsUnitEnemy(killer, targetPlayer) then
            call CastBlackArrow(killingHero, target, i)
        endif   

        if IsHeroUnitId(GetUnitTypeId(target)) == false then

            //Clockwerk Goblin
            if GetUnitTypeId(target) == CLOCKWORK_GOBLIN_1_UNIT_ID then
                call AreaDamage(target, GetUnitX(target), GetUnitY(target), GetUnitAbilityLevel(target, 'A00P') * 30, 250, false, 'A00P', true, false)
            endif

            //Skeleton Brute
            if GetUnitTypeId(targetHero) == SKELETON_BRUTE_UNIT_ID then
                call SetUnitState(targetHero, UNIT_STATE_LIFE, GetUnitState(targetHero, UNIT_STATE_LIFE) + ((0.02 + (0.0005 * GetHeroLevel(targetHero))) * BlzGetUnitMaxHP(targetHero)))
                call AreaDamage(targetHero, GetUnitX(target), GetUnitY(target), GetUnitDamage(target, 0) * (0.5 + (0.01 * GetHeroLevel(targetHero))), 400, false, SKELETON_BRUTE_UNIT_ID, true, false)
                set fx = AddLocalizedSpecialEffect("war3mapImported\\Arcane Explosion.mdx", GetUnitX(target), GetUnitY(target))
                call BlzSetSpecialEffectTimeScale(fx, 2)
                call DestroyEffect(fx)
                set fx = null
            endif

            //Packing Tape
            if UnitHasItemType(targetHero, PACKING_TAPE_ITEM_ID) and GetSummonSpell(GetUnitTypeId(target)) != 0 and RegisteredSummon.boolean[targetId] then
                call SetUnitState(targetHero, UNIT_STATE_LIFE, GetUnitState(targetHero, UNIT_STATE_LIFE) + GetUnitState(target, UNIT_STATE_MAX_LIFE) * 0.1) 
            endif
            
            //Necromancer's Army
            set i = GetUnitAbilityLevel(targetHero, NECROMANCERS_ARMY_ABILITY_ID)
            if i > 0 and IsUnitType(target, UNIT_TYPE_UNDEAD) == false then
                call ActivateNecromancerArmy(targetHero, target, i)
            endif

            //Strong Chest Mail
            set i = GetUnitItemTypeCount(killingHero, 'I079') 
            if i > 0 and killer != null then
                call Vamp(killingHero, target, BlzGetUnitMaxHP(killingHero)* 0.1 * I2R(i))
                call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", killingHero, "origin"))      
            endif

            //Amulet of the Night
            set i = GetUnitItemTypeCount(killingHero, 'I07E') 
            if i > 0 and GetOwningPlayer(target) == Player(11) then
                call TempBonus.create(killingHero, BONUS_MAGICPOW, i * 7, 10, 'I07E').activate()
            endif

            call RemoveSummonFromPlayerSummonGroup(targetHero, target)
        endif

        // Cleanup
        set t = null
        set target = null
        set killer = null
        set killingHero = null
        set targetHero = null
        set targetPlayer = null
        set killingPlayer = null
    endfunction

    private function init takes nothing returns nothing
        local trigger killingTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(killingTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddAction(killingTrigger, function KillingActions)
        set killingTrigger = null
    endfunction

endlibrary