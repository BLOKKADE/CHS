function TakeMagickDmg takes unit Dealing ,unit Trigger returns nothing
    local integer i = 0
    local real luck = 1
    local real BaseCrit = 0
    local real BaseChCr = 0
    local real area = 0 
    local real Dmg = GetEventDamage()
    local real CritDmg = 0
    local real lifesteal = 0
    local timer t = null
    local boolean AbilA = true
    local boolean Halfcr = false
    
    if TypeDmg_b == 2 then
        set AbilA = false
    endif
    
    //Ranger Passive
    set i = GetUnitAbilityLevel(Dealing,'A033') //HeroPassive
    if i > 0 then
        set BaseCrit = BaseCrit +   0.05*I2R(GetHeroLevel(Dealing))
    endif
    
    //Wanderers Cape
    if UnitHasItemS(Dealing,'I082') then
        set BaseCrit = BaseCrit + 1.5
        set BaseChCr = BaseChCr + 5
        set lifesteal = 0.05
    endif

    
    set luck = GetUnitLuck(Dealing)
    
    //Archmage Staff
    if UnitHasItemS(Dealing,'I086') and  GetRandomReal(0,100) <= 30*luck + BaseChCr then
        set CritDmg = CritDmg + Dmg*1.5
    endif
    
    //Magic Critical Strike
    set i = GetUnitAbilityLevel(Dealing,'A06U')
    if i > 0 and GetRandomReal(0,100) <= 20*luck + BaseChCr then
        set CritDmg = CritDmg +  Dmg*(1.4+0.12*I2R(i))
    endif

    //Shadow Chain Mail
    if UnitHasItemS(Dealing,'I084')  then
            if GetRandomReal(0,100) <= 50*luck then
                set CritDmg = 0
            endif
            set Halfcr = true

    endif

    //Anti-Magic Cape
    if UnitHasItemS(Dealing,'I092')  then
        set CritDmg = 0
    endif
        
    if CritDmg != 0 then
        set CritDmg = CritDmg + BaseCrit*Dmg
        if Halfcr then
            set CritDmg = CritDmg/2
        endif 

        //Mithril Helmet
        if UnitHasItemS(Trigger,'I091') and BlzGetUnitAbilityCooldownRemaining(Trigger,'A07J') <= 0.001  then
            call AbilStartCD(Trigger,'A07J',8 ) 
            set Dmg = 0
            set CritDmg = 0
        endif

        call BlzSetEventDamage(Dmg+CritDmg)
        call CreateTextTagTimerColor( I2S(R2I(Dmg+CritDmg)) + "!",1,GetUnitX(Trigger),GetUnitY(Trigger),50,1,0,0,177)
        
        if lifesteal > 0 then
            call SetWidgetLife(Dealing, GetWidgetLife(Dealing) + GetEventDamage()*lifesteal )
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", Dealing, "chest")) 
        endif
    endif
    
endfunction