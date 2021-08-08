globals
    constant string DEESCRIPTION_LEVEL = "!LVL!" 
    
    constant string DEESCRIPTION_COOLDOWN = "!CD!"  
    
    constant string DEESCRIPTION_DURATION1 = "!DUR1!"
    constant string DEESCRIPTION_DURATION2 = "!DUR2!"
    constant string DEESCRIPTION_DURATION3 = "!DUR3!"
 
    constant string DEESCRIPTION_DURATION1_HERO = "!DURH1!"
    constant string DEESCRIPTION_DURATION2_HERO = "!DURH2!"
    constant string DEESCRIPTION_DURATION3_HERO = "!DURH3!"
    
    constant string DEESCRIPTION_AREA1 = "!AREA1!"   
    constant string DEESCRIPTION_AREA2 = "!AREA2!"  
    constant string DEESCRIPTION_AREA3 = "!AREA3!"  
    
    constant string DEESCRIPTION_RANGE1 = "!RANGE1!"      
    constant string DEESCRIPTION_RANGE2 = "!RANGE2!"
    constant string DEESCRIPTION_RANGE3 = "!RANGE3!"
    
    constant string DEESCRIPTION_Damage1 = "!DMG1!"  
    constant string DEESCRIPTION_Damage2 = "!DMG2!"  
    constant string DEESCRIPTION_Damage3 = "!DMG3!"  
    
    constant string DEESCRIPTION_Casting1 = "!CST1!"  
    constant string DEESCRIPTION_Casting2 = "!CST2!"  
    constant string DEESCRIPTION_Casting3 = "!CST3!"  
    
    constant string DEESCRIPTION_Cooldown1 = "!CD1!"  
    constant string DEESCRIPTION_Cooldown2 = "!CD2!"  
    constant string DEESCRIPTION_Cooldown3 = "!CD3!"  

    constant string DEESCRIPTION_Manacost1 = "!MANA1!"  
    constant string DEESCRIPTION_Manacost2 = "!MANA2!"  
    constant string DEESCRIPTION_Manacost3 = "!MANA3!"  
    
    constant string DEESCRIPTION_Param1 = "!PAR1!"
    constant string DEESCRIPTION_Param2 = "!PAR2!"
    constant string DEESCRIPTION_Param3 = "!PAR3!"
    constant string DEESCRIPTION_Param4 = "!PAR4!"
    constant string DEESCRIPTION_Param5 = "!PAR5!"
    constant string DEESCRIPTION_Param6 = "!PAR6!"

    
    hashtable HT_des = InitHashtable()
endglobals


function ReplaceText takes string s1, string s2, string s3 returns string
    local integer Lenght = StringLength(s1)
    local integer Lenght3 = StringLength(s3)
    local integer lp = 0
    loop
        exitwhen lp > Lenght3
        if SubString(s3,lp,lp+Lenght) == s1 then
            return SubString(s3,0,lp) + s2 + SubString(s3,lp+Lenght,Lenght3)
        endif
        set lp = lp + 1
    endloop
    return s3
endfunction


function GetDesriptionAbility takes integer id, integer lvl returns string
    if LoadStr(HT_abilsys,id,4) == null then
        call SaveStr(HT_abilsys,id,4,BlzGetAbilityExtendedTooltip(id,0))
    endif
    return LoadStr(HT_abilsys,id,4)
endfunction




function FixReal takes real r returns string
    if r == I2R(R2I(r)) then
        return I2S(R2I(r))
        
    elseif r*10 - I2R(R2I(r*10)) < 0.1 then
        return R2SW( r,1,1) 
    elseif r*100 - I2R(R2I(r*100)) < 0.1 then
        return R2SW( r,1,2) 
    else 
        return R2SW( r,1,3) 
    endif 
endfunction


function ChangeDesctiption1 takes string s, real r1, real r2, string desc returns string
    local string s2
    if r1 != NULL then
        if r2 > 0 then
            set s2 = FixReal(r1) + " + " + Green(FixReal(r2))
        elseif r2 < 0 then 
            set s2 = FixReal(r1)+ " - " + Red(FixReal(-r2))
        else
            set s2 =  FixReal(r1)
        endif
        set s = ReplaceText(desc,s2,s)
    endif
    return s 
endfunction

function ChangeDesctiption2 takes string s, real r1, real r2, string desc returns string
    local string s2
    if r1 != NULL then
        if r2 > 0 then
            set s2 = FixReal(r1) + " + " + Red(FixReal(r2))
        elseif r2 < 0 then 
            set s2 = FixReal(r1)+ " - " + Green(FixReal(-r2))
        else
            set s2 =  FixReal(r1)
        endif
        set s = ReplaceText(desc,s2,s)
    endif
    return s 
endfunction

function ChangeDesctiption3 takes string s, real r1, real r2, boolean chance, string desc returns string
    local string s2
    local real r1New = r1
    local real r2New = r2
    if chance then
        set r1New = r1New * 100
        set r2New = r2New * 100
    endif
    if r1New != NULL then
        if r2New > 0 then
            set s2 = FixReal(r1New) + " + " + Red(FixReal(r2New))
        elseif r2New < 0 then 
            set s2 = FixReal(r1New)+ " - " + Green(FixReal(-r2New))
        else
            set s2 =  FixReal(r1New)
        endif
        set s = ReplaceText(desc,s2,s)
    endif
    return s 
endfunction

//! textmacro DesctiptionTextM takes TYPE
function Get$TYPE$Description takes AbilityData A returns string 
    local string s = FixReal(A.$TYPE$1)
    
    if A.Bonus$TYPE$1 > 0 then
        set s = s + " + " + Green(FixReal(A.Bonus$TYPE$1))
    elseif A.Bonus$TYPE$1 < 0 then
        set s = s + " - " + Red(FixReal(-A.Bonus$TYPE$1))
    endif 
    
    if A.$TYPE$2 != NULL then
        set s = s + "/" + (FixReal(A.$TYPE$2))
        if A.Bonus$TYPE$2 > 0 then
            set s = s + " + " + Green(FixReal(A.Bonus$TYPE$2))
        elseif A.Bonus$TYPE$2 < 0 then 
            set s = s + " - " + Red(FixReal(-A.Bonus$TYPE$2))
        endif 
    endif
    
    if A.$TYPE$3 != NULL then
        set s = s + "/" + (FixReal(A.$TYPE$3))
        if A.Bonus$TYPE$3 > 0 then
            set s = s + " + " + Green(FixReal(A.Bonus$TYPE$3))
        elseif A.Bonus$TYPE$3 < 0 then
            set s = s + " - " + Red(FixReal(-A.Bonus$TYPE$3))
        endif 
    endif
    
    return s
endfunction
//! endtextmacro


//! runtextmacro DesctiptionTextM("Range")
//! runtextmacro DesctiptionTextM("DurationHero")
//! runtextmacro DesctiptionTextM("DurationNormal")
//! runtextmacro DesctiptionTextM("Area")
//! runtextmacro DesctiptionTextM("Cost")
//! runtextmacro DesctiptionTextM("Cooldown")

function UpdateTooltipText takes unit u, integer id returns nothing
    local string s = GetDesriptionAbility(id,0)
    local string s2 = ""
    local string sduration
    local AbilityData A = GetAbilityData(u,id)



    set s = ChangeDesctiption1(s,A.Damage1,A.BonusDamage1,DEESCRIPTION_Damage1)
    set s = ChangeDesctiption1(s,A.Damage2,A.BonusDamage2,DEESCRIPTION_Damage2)
    set s = ChangeDesctiption1(s,A.Damage3,A.BonusDamage3,DEESCRIPTION_Damage3)
    
    set s = ChangeDesctiption3(s,A.Param1,A.BonusParam1, A.Param1Chance,DEESCRIPTION_Param1)
    set s = ChangeDesctiption3(s,A.Param2,A.BonusParam2, A.Param2Chance,DEESCRIPTION_Param2)
    set s = ChangeDesctiption3(s,A.Param3,A.BonusParam3, A.Param3Chance,DEESCRIPTION_Param3)    
    set s = ChangeDesctiption3(s,A.Param4,A.BonusParam4, A.Param4Chance,DEESCRIPTION_Param4)  
    set s = ChangeDesctiption3(s,A.Param5,A.BonusParam5, A.Param5Chance,DEESCRIPTION_Param5)  
    set s = ChangeDesctiption3(s,A.Param6,A.BonusParam6, A.Param6Chance,DEESCRIPTION_Param6)  
    
    set s = s + "\n"
    
    if A.Range1 != NULL then
        set s = s + "\n|cffd45e3aRange|r: " + GetRangeDescription(A) 
    endif 
    
    if A.GetDurationHero1() == A.GetDurationNormal1() and A.GetDurationHero2() == A.GetDurationNormal2() and A.GetDurationHero3() == A.GetDurationNormal3() then
        if A.DurationNormal1 != NULL then
            if A.DurationNormal1 == 1 then
                set sduration = " second"
            else
                set sduration = " seconds"
            endif
            set s = s + "\n|cffff5e44Duration|r: " + GetDurationNormalDescription(A) + sduration
        endif 
    else
        if A.DurationHero1 != NULL then
            if A.DurationHero1 == 1 then
                set sduration = " second"
            else
                set sduration = " seconds"
            endif
            set s = s + "\n|cffff5e44Duration(Hero)|r: " + GetDurationHeroDescription(A) + sduration
        endif 
        if A.DurationNormal1 != NULL then
            if A.DurationNormal1 == 1 then
                set sduration = " second"
            else
                set sduration = " seconds"
            endif
            set s = s + "\n|cffff5e44Duration(Normal)|r: " + GetDurationNormalDescription(A) + sduration
        endif 
    endif
    
    
    if A.Area1 != NULL then
        set s = s + "\n|cffd11e3aArea|r: " + GetAreaDescription(A) 
    endif 
    if A.Cooldown1 != NULL then
        set s = s + "\n|cffd49696Cooldown|r: " + GetCooldownDescription(A) 
    endif  
    
  //  cffd45e3aRange|r: !RANGE1! |n|cffff5e44Duration|r: !DUR1!/!DUR1H! seconds |n|cffd49696Cooldown|r:!CD1! seconds
    
 //   set s = ChangeDesctiption1(s,A.Area1,A.BonusArea1,DEESCRIPTION_AREA1)
 //   set s = ChangeDesctiption1(s,A.Area2,A.BonusArea2,DEESCRIPTION_AREA2)
 //   set s = ChangeDesctiption1(s,A.Area3,A.BonusArea3,DEESCRIPTION_AREA3)    
 //   set s = ChangeDesctiption2(s,A.Cooldown1,A.BonusCooldown1,DEESCRIPTION_Cooldown1)
 //   set s = ChangeDesctiption2(s,A.Cooldown2,A.BonusCooldown2,DEESCRIPTION_Cooldown2)
 //   set s = ChangeDesctiption2(s,A.Cooldown3,A.BonusCooldown3,DEESCRIPTION_Cooldown3)
 //   set s = ChangeDesctiption1(s,A.Area1,A.BonusArea1,DEESCRIPTION_AREA1)
 //   set s = ChangeDesctiption1(s,A.Area2,A.BonusArea2,DEESCRIPTION_AREA2)
 //   set s = ChangeDesctiption1(s,A.Area3,A.BonusArea3,DEESCRIPTION_AREA3)        
 //   set s = ChangeDesctiption1(s,A.DurationNormal1,A.BonusDurationNormal1,DEESCRIPTION_DURATION1)
 //   set s = ChangeDesctiption1(s,A.DurationHero1,A.BonusDurationHero1,DEESCRIPTION_DURATION1_HERO)    
 //   set s = ChangeDesctiption1(s,A.Range1,A.BonusRange1,DEESCRIPTION_RANGE1)   
    
    

    call BlzSetAbilityExtendedTooltip(id,s,0) 
    
    
    call BlzSetAbilityTooltip(id,LoadStr(HT_abilsys,id,5) + " - [|cffffcc00Level " + FixReal(A.Level) + "|r]" ,0)


endfunction


function GetClassification takes integer id returns string
    local string s = ""
    local integer i = 1
    loop
        exitwhen i > 15
        if LoadBoolean(Elem,id,i) then
            set s = s + ClassAbil[i]
        endif
        set i = i + 1
    endloop
    return s
endfunction
    