library CritDamage requires RandomShit

    function SetCritDamage takes nothing returns nothing
        local boolean magicDmgType = IsMagicDamage()

        local integer i = 0

        local real baseCritAmount = 0
        local real baseCritChance = 0

        local real Dmg = Damage.index.damage
        local real critDmg = 0
        local real lifesteal = 0
        local boolean critHalved = false

        //Ranger passive
        set i = GetUnitAbilityLevel(DamageSource,'A033') //HeroPassive
        if i > 0 then
            set baseCritAmount = baseCritAmount + 0.02 * I2R(GetHeroLevel(DamageSource))
            if GetRandomReal(0,100) <= 15 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + Dmg * 0.1
            endif
        endif 

        //Wanderers Cape
        if UnitHasItemS(DamageSource,'I082') then
            set baseCritAmount = baseCritAmount + 1.5
            set baseCritChance = baseCritChance + 5
            set lifesteal = 0.15
        endif

        //Aura of Vulnerability
        if GetUnitAbilityLevel(DamageTarget ,'B00E') > 0 then
            if GetRandomReal(0,100) <= 15 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + (Dmg * (0.5 + (0.05 * GetUnitAbilityLevel(DamageSourceHero, AURA_OF_VULNERABILITY_ABILITY_ID))))
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", DamageTarget, "chest"))
            endif
        endif

        set i = GetUnitAbilityLevel(DamageSource, POWER_OF_WATER_ABILITY_ID) //Power of water
        if  BlzGetUnitAbilityCooldownRemaining(DamageSource,POWER_OF_WATER_ABILITY_ID) <= 0 and i > 0 and GetRandomReal(0,100) <= 20 * DamageSourceLuck + baseCritChance then
           call AbilStartCD(DamageSource,POWER_OF_WATER_ABILITY_ID, 2)
            set critDmg = critDmg + 50*i + ((BlzGetUnitMaxMana(DamageSource)*i * 0.4)/100 )
            if not IsFxOnCooldownSet(DamageTargetId, 0, 1) then
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl", DamageTarget, "chest"))
            endif
        endif

        //PYromancer Scorched Earth
        if GetUnitAbilityLevel(DamageTarget, 'B027') > 0 then
            set baseCritChance = baseCritChance + (0.1 * GetHeroLevel(PlayerHeroes[ScorchedEarthSource[DamageSourceId] + 1]))
        endif

        if IsPhysDamage() then

            //Trident of Pain
            if UnitHasItemS(DamageSource, 'I061')  then
                if Damage.index.damageType ==  DAMAGE_TYPE_NORMAL then
                    if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08X') <= 0 then
                        call AbilStartCD(DamageSource, 'A08X', 12)
                        set critDmg = critDmg + Dmg
                    elseif BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08Y') <= 0 then
                        call AbilStartCD(DamageSource, 'A08Y', 12)
                        set critDmg = critDmg + Dmg
                    elseif BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08Z') <= 0 then
                        call AbilStartCD(DamageSource, 'A08Z', 12)
                        set critDmg = critDmg + Dmg
                    endif
                endif
            endif

            //Creep Critical Strike
            set i = GetUnitAbilityLevel(DamageSource,'ACct') //Critical Strike 
            if i > 0 and GetRandomReal(0,100) <= 10 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + Dmg
            endif

            //Blink Strike
            set i = GetUnitAbilityLevel(DamageSource,BLINK_STRIKE_ABILITY_ID) //Blink Strike
            if i > 0 and Damage.index.userType == DamageType_BlinkStrike then
                set critDmg = critDmg + (Dmg * (0.45 + (0.05 * i)))
            endif
            
            //Critical Strike
            set i = GetUnitAbilityLevel(DamageSource,CRITICAL_STRIKE_ABILITY_ID) //Critical Strike 
            if i > 0 and GetRandomReal(0,100) <= 20 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + Dmg *(0.9 + 0.1 * I2R(i))
            endif
            
            //Drunken Master
            set i = GetUnitAbilityLevel(DamageSource,DRUNKEN_MASTER_ABILITY_ID) //Drink
            if i > 0 and GetRandomReal(0,100) <= 30 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + ((i * 100) * (1 + 0.02 * GetHeroLevel(DamageSource)))
            endif
            
            //Frostmourne
            set i = GetUnitAbilityLevel(DamageSource,'A02C') //Frostmorn
            if i > 0 and GetRandomReal(0,100) <= 20 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + Dmg * 2
            endif    
            
            //Battle Axe
            set i = GetUnitAbilityLevel(DamageSource,'A05D')
            if i > 0 and IsUnitType(DamageTarget, UNIT_TYPE_HERO) == false and GetRandomReal(0,100) <= 20 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + Dmg * 2
            endif   
            
            //Aduxxor Legendary Blade
            set i = GetUnitAbilityLevel(DamageSource,'AIcs')
            if i > 0 and GetRandomReal(0,100) <= 20 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + Dmg
            endif

            //Yeti
            set i = GetUnitAbilityLevel(DamageTarget,'A092') 
            if i > 0 then
                set critDmg = 0
            endif    
            

        elseif magicDmgType then
            //Archmage Staff
            if UnitHasItemS(DamageSource,'I086') and GetRandomReal(0,100) <= 30 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + Dmg
            endif
            
            //Magic Critical Strike
            set i = GetUnitAbilityLevel(DamageSource,MAGIC_CRITICAL_HIT_ABILITY_ID)
            if i > 0 and GetRandomReal(0,100) <= 20 * DamageSourceLuck + baseCritChance then
                set critDmg = critDmg + Dmg *(0.5 + 0.08 * I2R(i))
            endif
        endif

        //Shadow Chain Mail
        if UnitHasItemS(DamageTarget,'I084') then
            if GetRandomReal(0,100) <= 50 * DamageSourceLuck then
                set critDmg = 0
            endif
            set critHalved = true
        endif

        //Anti-Magic Cape
        if UnitHasItemS(DamageSource,'I092')  then
            set critDmg = 0
        endif

        //Medivh
        if GetUnitTypeId(DamageSource) == MEDIVH_UNIT_ID then
            set critDmg = 0
        endif
        
        if critDmg != 0 then
            set critDmg = critDmg + baseCritAmount * Dmg
            
            if critHalved then
                set critDmg = critDmg / 2
            endif 

            if (DamageSourceTypeId != SEER_UNIT_ID and StaffOfPowerCritNegate) or (magicDmgType and GetUnitAbilityLevel(DamageSource, SUMMON_MAGIC_DMG_ABILITY_ID) > 0) then
                set critDmg = critDmg / 2
            endif

            //Mithril Helmet
            if UnitHasItemS(DamageTarget, 'I091') then
                if T32_Tick - MithrilHelmetCooldown[DamageTargetId] > 32 then
                    set MithrilHelmetCooldown[DamageTargetId] = T32_Tick
                else
                    set Dmg = 0
                    set critDmg = 0
                endif
            endif

            set Damage.index.damage = Dmg + critDmg

            set DamageShowText = true

            if lifesteal > 0 and critDmg > 0 then
                call Vamp(DamageSource, DamageTarget, critDmg * lifesteal)
            endif
        endif
    endfunction
endlibrary