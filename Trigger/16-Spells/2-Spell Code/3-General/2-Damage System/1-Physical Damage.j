


function TakePhysDmg takes unit Dealing ,unit Trigger, boolean AbilA returns nothing
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
 
 
    set luck = GetUnitLuck(Dealing)
 
    if AbilA then

        //Pulverize
        set i = GetUnitAbilityLevel(Dealing,'Awar')
        if i > 0 and GetRandomReal(0,100) <= 20 * luck then
            call DestroyEffect(AddSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(Trigger),GetUnitY(Trigger) ))
            set area = BlzGetAbilityRealLevelField(BlzGetUnitAbility(Dealing,'Awar'), ABILITY_RLF_AREA_OF_EFFECT,i - 1)
            call AreaDamage(Dealing,GetUnitX(Trigger),GetUnitY(Trigger),100 * i,area, true, 'Awar')

        endif

        //Destruction
        set i = GetUnitAbilityLevel(Dealing,'ACpv') 
        if i > 0 and GetRandomReal(0,100) <= 15 * luck then
            call DestroyEffect(AddSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(Trigger),GetUnitY(Trigger) ))
            set area = BlzGetAbilityRealLevelField(BlzGetUnitAbility(Dealing,'ACpv'), ABILITY_RLF_AREA_OF_EFFECT,i - 1)

            call AreaDamage(Dealing,GetUnitX(Trigger),GetUnitY(Trigger),400 * i,area, true, 'ACpv')

        endif
        
        //Bash
        set i = GetUnitAbilityLevel(Dealing,'A06S')  
        if i > 0 and GetRandomReal(0,100) <= I2R(i)* luck and GetUnitAbilityLevel(Trigger,'BSTN') == 0 then
            call UsOrderU(Dealing,Trigger,GetUnitX(Trigger),GetUnitY(Trigger),'A06T',"thunderbolt",  i * 100 + GetHeroStr(Dealing,true)/ 2, ABILITY_RLF_DAMAGE_HTB1 )
        endif
    endif

    //Crit
    //Creep Critical Strike
    set i = GetUnitAbilityLevel(Dealing,'ACct') //Critical Strike 
    if i > 0 and GetRandomReal(0,100) <= 10 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg
    endif

    //Blink Strike
    set i = GetUnitAbilityLevel(Dealing,'A08J') //Blink Strike
    if i > 0 and BlinkStrikeEnabled.boolean[GetHandleId(Dealing)] then
        set CritDmg = CritDmg + (Dmg * (0.45 + (0.05 * i)))
        set BaseChCr = BaseChCr + 100
    endif

    //Ranger passive
    set i = GetUnitAbilityLevel(Dealing,'A033') //HeroPassive
    if i > 0 then
        set BaseCrit = BaseCrit + 0.05 * I2R(GetHeroLevel(Dealing))
        if GetRandomReal(0,100) <= 11 * luck + BaseChCr then
            set CritDmg = CritDmg + Dmg * 0.05
        endif
    endif     
    
    //Wanderers Cape
    if UnitHasItemS(Dealing,'I082') then
        set BaseCrit = BaseCrit + 1.5
        set BaseChCr = BaseChCr + 5
        set lifesteal = 0.05
    endif
    
    //Critical Strike
    set i = GetUnitAbilityLevel(Dealing,'AOcr') //Critical Strike 
    if i > 0 and GetRandomReal(0,100) <= 20 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg *(1.7 + 0.3 * I2R(i))
    endif
    
    //Drunken Haze
    set i = GetUnitAbilityLevel(Dealing,'Acdb') //Drink
    if i > 0 and GetRandomReal(0,100) <= 30 * luck + BaseChCr then
        set CritDmg = CritDmg + ((i * 100) * (1 + 0.02 * GetHeroLevel(Dealing)))
    endif
    
    //Frostmourne
    set i = GetUnitAbilityLevel(Dealing,'A02C') //Frostmorn
    if i > 0 and GetRandomReal(0,100) <= 5 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg * 9
    endif    
    
    //Battle Axe
    set i = GetUnitAbilityLevel(Dealing,'A05D')
    if i > 0 and IsUnitType(Trigger, UNIT_TYPE_HERO) == false and GetRandomReal(0,100) <= 20 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg * 4
    endif   
    
    //Aduxxor Legendary Blade
    set i = GetUnitAbilityLevel(Dealing,'AIcs')
    if i > 0 and GetRandomReal(0,100) <= 20 * luck + BaseChCr then
        set CritDmg = CritDmg + Dmg
    endif     
    
    //Shadow Chain Mail
    if UnitHasItemS(Trigger,'I084') then
        if GetRandomReal(0,100) <= 50 * luck then
            set CritDmg = 0
        endif
        set Halfcr = true

    endif
    
    //Anti-Magic Cape
    if UnitHasItemS(Dealing,'I092')  then
        set CritDmg = 0
    endif

    if CritDmg != 0 then
        set CritDmg = CritDmg + BaseCrit * Dmg
        if Halfcr then
            set CritDmg = CritDmg / 2
        endif 

        //Mithril Helmet
        if UnitHasItemS(Trigger,'I091') and BlzGetUnitAbilityCooldownRemaining(Trigger,'A07J') <= 0.001  then
            call AbilStartCD(Trigger,'A07J',8 ) 
            set Dmg = 0
            set CritDmg = 0
        endif

        call BlzSetEventDamage(Dmg + CritDmg)
        call CreateTextTagTimerColor( I2S(R2I(Dmg + CritDmg)) + "!",1,GetUnitX(Trigger),GetUnitY(Trigger),50,1,177,0,0)
        if lifesteal > 0 then
            call SetWidgetLife(Dealing, GetWidgetLife(Dealing) + GetEventDamage()* lifesteal )
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", Dealing, "chest")) 
        endif
    endif
    
    set t = null

endfunction