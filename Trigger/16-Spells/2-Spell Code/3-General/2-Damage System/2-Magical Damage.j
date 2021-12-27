function TakeMagickDmg takes unit damageSource ,unit damageTarget, unit damageSourceHero, unit damageTargetHero, boolean AbilA returns nothing
    local integer i = 0
    local real luck = 1
    local real BaseCrit = 0
    local real BaseChCr = 0
    local real area = 0 
    local real Dmg = GetEventDamage()
    local real CritDmg = 0
    local real lifesteal = 0
    local timer t = null
    local boolean Halfcr = false

    
    //PYromancer Scorched Earth
    if GetUnitAbilityLevel(damageTarget, 'B027') > 0 then
        set BaseChCr = BaseChCr + (0.1 * GetHeroLevel(udg_units01[ScorchedEarthSource[GetHandleId(damageSource)] + 1]))
    endif
    
    //Ranger Passive
    set i = GetUnitAbilityLevel(damageSource,'A033') //HeroPassive
    if i > 0 then
        set BaseCrit = BaseCrit + 0.05 * I2R(GetHeroLevel(damageSource))
    endif

    //Aura of Vulnerability
    if GetUnitAbilityLevel(damageTarget ,'B00E') > 0 then
        if GetRandomReal(0,100) <= 5 * luck then
            set CritDmg = CritDmg + (Dmg * 1 + (0.5 * GetUnitAbilityLevel(damageSourceHero  ,AURA_OF_VULNERABILITY_ABILITY_ID)))
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", damageTarget, "chest"))
        endif
    endif
    
    //Wanderers Cape
    if UnitHasItemS(damageSource,'I082') then
        set BaseCrit = BaseCrit + 1.5
        set BaseChCr = BaseChCr + 5
        set lifesteal = 0.05
    endif

    
    set luck = GetUnitLuck(damageSource)
    
    //Archmage Staff
    if UnitHasItemS(damageSource,'I086') and GetRandomReal(0,100) <= 30 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg * 1.5
    endif
    
    //Magic Critical Strike
    set i = GetUnitAbilityLevel(damageSource,MAGIC_CRITICAL_HIT_ABILITY_ID)
    if i > 0 and GetRandomReal(0,100) <= 20 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg *(1.9 + 0.17 * I2R(i))
    endif

    //Shadow Chain Mail
    if UnitHasItemS(damageTarget,'I084')  then
        if GetRandomReal(0,100) <= 50 * luck then
            set CritDmg = 0
        endif
        set Halfcr = true

    endif

    //Anti-Magic Cape
    if UnitHasItemS(damageSource,'I092')  then
        set CritDmg = 0
    endif
        
    if CritDmg != 0 then
        set CritDmg = CritDmg + BaseCrit * Dmg
        if Halfcr then
            set CritDmg = CritDmg / 2
        endif 

        //Mithril Helmet
        if UnitHasItemS(damageTarget,'I091') and BlzGetUnitAbilityCooldownRemaining(damageTarget,'A07J') <= 0.001  then
            call AbilStartCD(damageTarget,'A07J',8 ) 
            set Dmg = 0
            set CritDmg = 0
        endif

        call BlzSetEventDamage(Dmg + CritDmg)
        call CreateTextTagTimerColor( I2S(R2I(Dmg + CritDmg)) + "!",1,GetUnitX(damageTarget),GetUnitY(damageTarget),50,1,0,0,177)
        
        if lifesteal > 0 then
            call SetWidgetLife(damageSource, GetWidgetLife(damageSource) + GetEventDamage()* lifesteal )
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", damageSource, "chest")) 
        endif
    endif
    
endfunction