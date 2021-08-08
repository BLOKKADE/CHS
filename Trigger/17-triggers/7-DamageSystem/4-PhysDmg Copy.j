


function TakePhysDmg takes unit u_a ,unit u_t returns nothing
    local integer i = 0
    local real lvl = 0
    local real luck = 1
    local real BaseCrit = 0
    local real BaseChCr = 0
    local real area = 0 
    local real AbilDamage = 0 
    local real Dmg = GetEventDamage()
    local real lifesteal = 0
    local real CritDmg = 0
    local timer t = null
    local boolean Halfcr = false
    local boolean AbilA = true
    local AbilityData A 
    
    if TypeDmg_b == 2 then
        set AbilA = false
    endif
 
 
    set luck = GetUnitLuck(u_a)
 
    

    set lvl = GetUnitSpell(u_a,'Awar')
    if lvl > 0 and AbilA  then
       set A = GetAbilityData(u_a,'Awar')
        if    GetRandomReal(0,100) <= A.Param1*luck then
           call DestroyEffect(AddSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(u_a),GetUnitY(u_a) ))
           call AreaDamage(u_a,GetUnitX(u_a),GetUnitY(u_a),A.GetDamage1(),A.GetArea1(),'Awar')
       endif
    endif
    
    set lvl = GetUnitSpell(u_a,'ACpv')
    if lvl > 0  and AbilA then
        set A = GetAbilityData(u_a,'ACpv')
        if  GetRandomReal(0,100) <= A.Param1*luck then
           call DestroyEffect(AddSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(u_t),GetUnitY(u_t) ))
           call AreaDamage(u_a,GetUnitX(u_t),GetUnitY(u_t),A.GetDamage1(),A.GetArea1(),'ACpv')
        endif
    endif
    
    
    set lvl = GetUnitSpell(u_a,'A06S')  //bash 
	 if lvl > 0 and GetRandomReal(0,100) <= lvl*luck and AbilA  and GetUnitAbilityLevel(u_t,'BSTN') == 0 then
    	call UsOrderU(u_a,u_t,GetUnitX(u_t),GetUnitY(u_t),'A06T',"thunderbolt",  lvl*100+GetHeroStr(u_a,true)/2, ABILITY_RLF_DAMAGE_HTB1 )
    endif
    
    
    
    //Critt
    set lvl = GetUnitSpell(u_a,'A033') //HeroPassive
    if lvl > 0 then
        set BaseCrit = BaseCrit +   0.05*I2R(GetHeroLevel(u_a))
        if GetRandomReal(0,100) <= 11*luck + BaseChCr then
            set CritDmg = CritDmg + Dmg*0.05
        endif
    endif     
    
    if UnitHasItemS(u_a,'I082') then
        set BaseCrit = BaseCrit + 1.5
        set BaseChCr = BaseChCr + 5
        set lifesteal = 0.05
    endif
    
    
    set lvl = GetUnitSpell(u_a,'AOcr') //Critical Strike 
    if lvl > 0 and GetRandomReal(0,100) <= 20*luck + BaseChCr then
        set CritDmg = CritDmg +  Dmg*(1.7+0.3*lvl)
    endif
    
    
    set lvl = GetUnitSpell(u_a,'Acdb') //Drink
    if lvl > 0 and GetRandomReal(0,100) <= 30*luck + BaseChCr then
        set CritDmg = CritDmg +  i*100
    endif
    
    set lvl = GetUnitSpell(u_a,'A02C') //Frostmorn
    if lvl > 0 and GetRandomReal(0,100) <= 5*luck + BaseChCr then
        set CritDmg = CritDmg +  Dmg*9
    endif    
    
    set lvl = GetUnitSpell(u_a,'A05D') //creep
    if lvl > 0 and GetRandomReal(0,100) <= 20*luck + BaseChCr then
        set CritDmg = CritDmg +  Dmg
    endif   
    
    set lvl = GetUnitSpell(u_a,'AIcs') //Item
    if lvl > 0 and GetRandomReal(0,100) <= 20*luck + BaseChCr then
        set CritDmg = CritDmg +  Dmg
    endif     
    
    
    if UnitHasItemS(u_a,'I084') then
            if GetRandomReal(0,100) <= 50*luck then
                set CritDmg = 0
            endif
            set Halfcr = true

    endif
    
    if UnitHasItemS(u_a,'I092')  then
        set CritDmg = 0
    endif

    if CritDmg != 0 then
        set CritDmg = CritDmg + BaseCrit*Dmg
        if Halfcr then
            set CritDmg = CritDmg/2
        endif 
        if UnitHasItemS(u_t,'I091') and BlzGetUnitAbilityCooldownRemaining(u_t,'A07J') <= 0.001  then
            call AbilStartCD(u_t,'A07J',8 ) 
            set Dmg = 0
            set CritDmg = 0
        endif
        call BlzSetEventDamage(Dmg+CritDmg)
        call CreateTextTagTimerColor( I2S(R2I(Dmg+CritDmg)) + "!",1,GetUnitX(u_t),GetUnitY(u_t),50,1,177,0,0)
        if lifesteal > 0 then
            call SetWidgetLife(u_a, GetWidgetLife(u_a) + GetEventDamage()*lifesteal )
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", u_a, "chest")) 
        endif
    endif
    
    set t = null

endfunction