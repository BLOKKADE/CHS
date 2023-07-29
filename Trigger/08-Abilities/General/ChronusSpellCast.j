library ChronusSpellCast requires DummySpell, HeroBuff, AbilityCooldown, TempInvis, TempPower, CheaterMagic, BlessedProtection, BoneArmor, FearlessDefenders
    //ignoreCd is used by timemanipulation
    // these spells use GetDummySpell because the real abilities cant have cd and instead it use a dummy ability
    function CastChronusSpells takes unit u, integer hid, boolean ignoreCd returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        local real abilLevel = 0
        local real heroLevel = GetHeroLevel(u)
        local real ChronusLevel = 1 + (0.05 * I2R(GetUnitAbilityLevel(u,CHRONUS_WIZARD_ABILITY_ID)))
        local integer abilId = 0

        //Hero Buff
        set abilId = GetDummySpell(u, HERO_BUFF_ABILITY_ID)
        set abilLevel = GetUnitAbilityLevel(u, HERO_BUFF_ABILITY_ID)
        if abilLevel > 0 and (BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 or ignoreCd) then
            call HeroBuffCast(u, R2I(abilLevel), R2I(heroLevel), ChronusLevel, (10 + (heroLevel * 0.02)) * ChronusLevel)
            call AbilStartCD(u, HERO_BUFF_ABILITY_ID, 120)
        endif

        //Temporary Inisibility
        set abilId = GetDummySpell(u, TEMPORARY_INVISIBILITY_ABILITY_ID)
        set abilLevel = GetUnitAbilityLevel(u, TEMPORARY_INVISIBILITY_ABILITY_ID)    
        if abilLevel > 0 and (BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 or ignoreCd) then
            call TempInvisStruct.create(u, (1.8 + (0.2 * abilLevel)) * ChronusLevel)
            call AbilStartCD(u, TEMPORARY_INVISIBILITY_ABILITY_ID, 120)
        endif

        //Temporary Power
        set abilId = GetDummySpell(u, TEMPORARY_POWER_ABILITY_ID)
        set abilLevel = GetUnitAbilityLevel(u, TEMPORARY_POWER_ABILITY_ID)    
        if abilLevel > 0 and (BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 or ignoreCd) then
            call TempPowerCast(u, (10 + (0.02 * heroLevel)) * ChronusLevel)
            call AbilStartCD(u, TEMPORARY_POWER_ABILITY_ID, 120)
        endif

        //Cheater Magic
        set abilId = GetDummySpell(u, CHEATER_MAGIC_ABILITY_ID)
        set abilLevel = GetUnitAbilityLevel(u, CHEATER_MAGIC_ABILITY_ID)    
        if abilLevel > 0 and (BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 or ignoreCd) then
            call CheaterMagicStruct.create(u, (2.75 + (0.25 * abilLevel)) * ChronusLevel)
            call AbilStartCD(u, CHEATER_MAGIC_ABILITY_ID, 120)
        endif
            
        //Blessed Protection
        set abilId = GetDummySpell(u, BLESSED_PROTECTIO_ABILITY_ID)
        set abilLevel = GetUnitAbilityLevel(u, BLESSED_PROTECTIO_ABILITY_ID)    
        if abilLevel > 0 and (BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 or ignoreCd) then
            call BlessedProtectionStruct.create(u, (2.70 + (0.3 * abilLevel)) * ChronusLevel)
            call AbilStartCD(u, BLESSED_PROTECTIO_ABILITY_ID, 120)
        endif

        //Bone Armor
        set abilId = 'A0EF' // TODO
        if UnitHasItemType(u, 'I07O') and (BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 or ignoreCd) then
            call StartBoneArmor(u, abilId, 40 * ChronusLevel)
            call AbilStartCD(u, 'A0EF', 120)
        endif
            
        //Fearless Defenders
        set abilId = GetDummySpell(u, FEARLESS_DEFENDERS_ABILITY_ID)
        set abilLevel = GetUnitAbilityLevel(u, FEARLESS_DEFENDERS_ABILITY_ID)   
        if abilLevel > 0 and (BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 or ignoreCd) then
            call StartFearlessDefenders(u, abilId, (8 + (heroLevel * 0.09)) * ChronusLevel)
            call AbilStartCD(u, FEARLESS_DEFENDERS_ABILITY_ID, 120)
        endif

        //Rapid Recovery
        set abilId = GetDummySpell(u, RAPID_RECOVERY_ABILITY_ID)
        set abilLevel = GetUnitAbilityLevel(u,RAPID_RECOVERY_ABILITY_ID)
        if abilLevel > 0 and (BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 or ignoreCd) then
            call ElemFuncStart(u,RAPID_RECOVERY_ABILITY_ID)
            call DummyInstantCast4(u, GetUnitX(u), GetUnitY(u), 'A03W', "battleroar", (BlzGetUnitMaxHP(u) * 0.002 * abilLevel) * (1 + 0.02 * heroLevel), ABILITY_RLF_LIFE_REGENERATION_RATE, (GetUnitState(u, UNIT_STATE_MAX_MANA) * 0.002 * abilLevel) * (1 + 0.02 * heroLevel), ABILITY_RLF_MANA_REGEN, (10 + (heroLevel * 0.02)) * ChronusLevel, ABILITY_RLF_DURATION_HERO, (10 + (heroLevel * 0.02)) * ChronusLevel, ABILITY_RLF_DURATION_NORMAL)
            call AbilStartCD(u, RAPID_RECOVERY_ABILITY_ID, 120)
        endif
            
        //Demon Curse
        set abilId = GetDummySpell(u, DEMONS_CURSE_ABILITY_ID)
        set abilLevel = GetUnitAbilityLevel(u,DEMONS_CURSE_ABILITY_ID)    
        if abilLevel > 0 and (BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 or ignoreCd) then
            call ElemFuncStart(u,DEMONS_CURSE_ABILITY_ID)
            call DummyInstantCast4(u, GetUnitX(u), GetUnitY(u), 'A043', "howlofterror", 0, ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1, (10 * abilLevel) * (1 + 0.02 * heroLevel), ABILITY_RLF_DAMAGE_HBZ2, (8 + (heroLevel * 0.09)) * ChronusLevel, ABILITY_RLF_DURATION_HERO, (8 + (heroLevel * 0.09)) * ChronusLevel, ABILITY_RLF_DURATION_NORMAL)
            call AbilStartCD(u, DEMONS_CURSE_ABILITY_ID, 120)
        endif
    endfunction
endlibrary
