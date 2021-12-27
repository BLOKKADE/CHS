


function TakePhysDmg takes unit damageSource ,unit damageTarget, boolean AbilA returns nothing
    local integer i = 0
    local real luck = 1
    local real BaseCrit = 0
    local real BaseChCr = 0
    local real area = 0 
    local real Dmg = GetEventDamage()
    local real lifesteal = 0
    local real CritDmg = 0
    local timer t = null
    local boolean Halfcr = false
 
 
    set luck = GetUnitLuck(damageSource)
 
    if AbilA then

        //Pulverize
        set i = GetUnitAbilityLevel(damageSource,PULVERIZE_ABILITY_ID)
        if i > 0 and GetRandomReal(0,100) <= 20 * luck then
            call DestroyEffect(AddSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(damageTarget),GetUnitY(damageTarget) ))
            set area = BlzGetAbilityRealLevelField(BlzGetUnitAbility(damageSource,PULVERIZE_ABILITY_ID), ABILITY_RLF_AREA_OF_EFFECT,i - 1)
            call AreaDamage(damageSource,GetUnitX(damageTarget),GetUnitY(damageTarget),100 * i,area, true, PULVERIZE_ABILITY_ID)

        endif

        //Destruction
        set i = GetUnitAbilityLevel(damageSource,DESTRUCTION_ABILITY_ID) 
        if i > 0 and GetRandomReal(0,100) <= 15 * luck then
            call DestroyEffect(AddSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(damageTarget),GetUnitY(damageTarget) ))
            set area = BlzGetAbilityRealLevelField(BlzGetUnitAbility(damageSource,DESTRUCTION_ABILITY_ID), ABILITY_RLF_AREA_OF_EFFECT,i - 1)

            call AreaDamage(damageSource,GetUnitX(damageTarget),GetUnitY(damageTarget),400 * i,area, true, DESTRUCTION_ABILITY_ID)

        endif
        
        //Bash
        set i = GetUnitAbilityLevel(damageSource,BASH_ABILITY_ID)  
        if i > 0 and GetRandomReal(0,100) <= I2R(i)* luck and GetUnitAbilityLevel(damageTarget,STUNNED_BUFF_ID) == 0 then
            call UsOrderU(damageSource,damageTarget,GetUnitX(damageTarget),GetUnitY(damageTarget),'A06T',"thunderbolt",  i * 100 + GetHeroStr(damageSource,true)/ 2, ABILITY_RLF_DAMAGE_HTB1 )
        endif
    endif

    //Crit
    //Creep Critical Strike
    set i = GetUnitAbilityLevel(damageSource,'ACct') //Critical Strike 
    if i > 0 and GetRandomReal(0,100) <= 10 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg
    endif

    //Aura of Vulnerability
    if GetUnitAbilityLevel(damageTarget ,'B00E') > 0 then
        if GetRandomReal(0,100) <= 5 * luck then
            set CritDmg = CritDmg + (Dmg * 1 + (0.5 * GetUnitAbilityLevel(damageSourceHero  ,AURA_OF_VULNERABILITY_ABILITY_ID))))
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", damageTarget, "chest"))
        endif
    endif

    //PYromancer Scorched Earth
    if GetUnitAbilityLevel(damageTarget, 'B027') > 0 then
        set BaseChCr = BaseChCr + (0.1 * GetHeroLevel(udg_units01[ScorchedEarthSource[GetHandleId(damageSource)] + 1]))
    endif

    //Blink Strike
    set i = GetUnitAbilityLevel(damageSource,BLINK_STRIKE_ABILITY_ID) //Blink Strike
    if i > 0 then
        set CritDmg = CritDmg + (Dmg * (0.45 + (0.05 * i)))
    endif
    

    //Ranger passive
    set i = GetUnitAbilityLevel(damageSource,'A033') //HeroPassive
    if i > 0 then
        set BaseCrit = BaseCrit + 0.05 * I2R(GetHeroLevel(damageSource))
        if GetRandomReal(0,100) <= 11 * luck + BaseChCr then
            set CritDmg = CritDmg + Dmg * 0.05
        endif
    endif     
    
    //Wanderers Cape
    if UnitHasItemS(damageSource,'I082') then
        set BaseCrit = BaseCrit + 1.5
        set BaseChCr = BaseChCr + 5
        set lifesteal = 0.05
    endif
    
    //Critical Strike
    set i = GetUnitAbilityLevel(damageSource,CRITICAL_STRIKE_ABILITY_ID) //Critical Strike 
    if i > 0 and GetRandomReal(0,100) <= 20 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg *(1.7 + 0.3 * I2R(i))
    endif
    
    //Drunken Haze
    set i = GetUnitAbilityLevel(damageSource,DRUNKEN_MASTER_ABILITY_ID) //Drink
    if i > 0 and GetRandomReal(0,100) <= 30 * luck + BaseChCr then
        set CritDmg = CritDmg + ((i * 100) * (1 + 0.02 * GetHeroLevel(damageSource)))
    endif
    
    //Frostmourne
    set i = GetUnitAbilityLevel(damageSource,'A02C') //Frostmorn
    if i > 0 and GetRandomReal(0,100) <= 5 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg * 9
    endif    
    
    //Battle Axe
    set i = GetUnitAbilityLevel(damageSource,'A05D')
    if i > 0 and IsUnitType(damageTarget, UNIT_TYPE_HERO) == false and GetRandomReal(0,100) <= 20 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg * 4
    endif   
    
    //Aduxxor Legendary Blade
    set i = GetUnitAbilityLevel(damageSource,'AIcs')
    if i > 0 and GetRandomReal(0,100) <= 20 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg
    endif     
    
    //Shadow Chain Mail
    if UnitHasItemS(damageTarget,'I084') then
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
        call CreateTextTagTimerColor( I2S(R2I(Dmg + CritDmg)) + "!",1,GetUnitX(damageTarget),GetUnitY(damageTarget),50,1,177,0,0)
        if lifesteal > 0 then
            call SetWidgetLife(damageSource, GetWidgetLife(damageSource) + GetEventDamage()* lifesteal )
        endif
    endif
    
    set t = null

endfunction