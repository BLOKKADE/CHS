globals
    hashtable HT_abilsys = InitHashtable()
    
    integer STOP_0
    integer STOPING = 0
    

    constant real  NULL = -9999.999
endglobals

function STOP takes nothing returns nothing
    set STOPING = STOP_0
endfunction 


function GetUnitSpell takes unit u, integer id returns real
    local AbilityData A = LoadInteger(HT_abilsys,GetHandleId(u),id)
    if A != 0 and A.GedLevel() != 0  then
        return  A.GedLevel()
    endif

    return I2R(GetUnitAbilityLevel(u,id))
endfunction 

function GetAbilityData takes unit u, integer id returns AbilityData
    local AbilityData A =  LoadInteger(HT_abilsys,GetHandleId(u),id)
    if A == 0 then
        call DisplayTextToPlayer(GetLocalPlayer(),0,0,"ERROR: " + I2S(id) )
        call STOP()
    endif
    
    return A 
endfunction




struct AbilityData
    integer id
    
    real Level = 0

    real DurationNormal1 = NULL
    real DurationNormal2 = NULL
    real DurationNormal3 = NULL
    real DurationHero1 = NULL
    real DurationHero2 = NULL
    real DurationHero3 = NULL
    real CastingTime1 = NULL
    real Area1 = NULL
    real Area2 = NULL
    real Area3 = NULL
    real Damage1 = NULL
    real Damage2 = NULL
    real Damage3 = NULL
    real Param1 = NULL
    real Param2 = NULL
    real Param3 = NULL
    real Param4 = NULL
    real Param5 = NULL
    real Param6 = NULL
    
    integer Param1Field = 0
    integer Param2Field = 0
    integer Param3Field = 0
    integer Param4Field = 0
    integer Param5Field = 0
    integer Param6Field = 0
    
    integer Param1FieldType = 0
    integer Param2FieldType = 0
    integer Param3FieldType = 0
    integer Param4FieldType = 0
    integer Param5FieldType = 0
    integer Param6FieldType = 0
    
    boolean Param1Chance = false
    boolean Param2Chance = false
    boolean Param3Chance = false
    boolean Param4Chance = false
    boolean Param5Chance = false
    boolean Param6Chance = false
    
    real Cooldown1 = NULL
    real Cooldown2 = NULL
    real Cooldown3 = NULL    
    real Cost1 = NULL
    real Cost2 = NULL
    real Cost3 = NULL
    real Range1 = NULL
    real Range2 = NULL
    real Range3 = NULL
    integer SummonId1 = 0
    integer SummonId2 = 0
    
    real BonusLevel
    real BonusDurationNormal1 = 0
    real BonusDurationNormal2 = 0
    real BonusDurationNormal3 = 0
    real BonusDurationHero1 = 0
    real BonusDurationHero2 = 0
    real BonusDurationHero3 = 0
    real BonusCastingTime1 = 0
    real BonusArea1 = 0
    real BonusArea2 = 0
    real BonusArea3 = 0
    real BonusDamage1 = 0
    real BonusDamage2 = 0 
    real BonusDamage3 = 0 
    real BonusParam1 = 0
    real BonusParam2 = 0 
    real BonusParam3 = 0 
    real BonusParam4 = 0
    real BonusParam5 = 0 
    real BonusParam6 = 0 
    real BonusCooldown1 = 0
    real BonusCooldown2 = 0
    real BonusCooldown3 = 0
    real BonusCost1 = 0
    real BonusCost2 = 0
    real BonusCost3 = 0
    real BonusRange1 = 0
    real BonusRange2 = 0
    real BonusRange3 = 0
    
    boolean isDestroy = false 
    
    public method MayByRemove takes nothing returns nothing
        if this.isDestroy then
            call this.destroy() 
        endif
    endmethod

    public method GetCooldown1 takes nothing returns real 
        local real r = this.Cooldown1 + this.BonusCooldown1 
        if r < 0 then
            return .0
        endif
        
        return r
        
    endmethod
    
    public method GetCooldown2 takes nothing returns real 
        local real r = this.Cooldown2 + this.BonusCooldown2 
        if r < 0 then
            return .0
        endif
        return r
    endmethod
    
    public method GetCooldown3 takes nothing returns real 
        local real r = this.Cooldown3 + this.BonusCooldown3
        if r < 0 then
            return .0
        endif
        return r
    endmethod
    
    public method GetCastingTime1 takes nothing returns real 
        local real r = this.CastingTime1 + this.BonusCastingTime1 
        if r < 0 then
            return .0
        endif
        
        return r
        
    endmethod
    
    public method GedLevel takes nothing returns real
        return this.Level + this.BonusLevel 
    endmethod 
    
    public method GetRange1 takes nothing returns real 
        return this.Range1+this.BonusRange1
    endmethod
    
    public method GetRange2 takes nothing returns real 
        return this.Range2+this.BonusRange2
    endmethod
    
    public method GetRange3 takes nothing returns real 
        return this.Range3+this.BonusRange3
    endmethod
    
    public method GetCost1 takes nothing returns real 
        return this.Cost1+this.BonusCost1
    endmethod
    
    public method GetCost2 takes nothing returns real 
        return this.Cost2+this.BonusCost2
    endmethod
    
    public method GetCost3 takes nothing returns real 
        return this.Cost3+this.BonusCost3
    endmethod
    
    public method GetArea1 takes nothing returns real 
        return this.Area1+this.BonusArea1
    endmethod
    
    public method GetArea2 takes nothing returns real 
        return this.Area2+this.BonusArea2
    endmethod
    
    public method GetArea3 takes nothing returns real 
        return this.Area3+this.BonusArea3
    endmethod
    
    public method GetDamage1 takes nothing returns real
        return this.Damage1 + this.BonusDamage1
    endmethod
    
    public method GetDamage2 takes nothing returns real
        return this.Damage2 + this.BonusDamage2
    endmethod   
    
    public method GetDamage3 takes nothing returns real
        return this.Damage3 + this.BonusDamage1
    endmethod
    
    public method GetDurationNormal1 takes nothing returns real 
        return this.DurationNormal1 + this.BonusDurationNormal1
    endmethod 

    public method GetDurationNormal2 takes nothing returns real 
        return this.DurationNormal2 + this.BonusDurationNormal2
    endmethod 
    
    public method GetDurationNormal3 takes nothing returns real 
        return this.DurationNormal3 + this.BonusDurationNormal3
    endmethod 

    public method GetDurationHero1 takes nothing returns real 
        return this.DurationHero1 + this.BonusDurationHero1
    endmethod 
    public method GetDurationHero2 takes nothing returns real 
        return this.DurationHero2 + this.BonusDurationHero2
    endmethod 
    public method GetDurationHero3 takes nothing returns real 
        return this.DurationHero3 + this.BonusDurationHero3
    endmethod 
    
    public method GetParam1 takes nothing returns real 
        return this.Param1 + this.BonusParam1
    endmethod
    public method GetParam2 takes nothing returns real 
        return this.Param2 + this.BonusParam2
    endmethod
    public method GetParam3 takes nothing returns real 
        return this.Param3 + this.BonusParam3
    endmethod
    public method GetParam4 takes nothing returns real 
        return this.Param4 + this.BonusParam4
    endmethod
        public method GetParam5 takes nothing returns real 
        return this.Param5 + this.BonusParam5
    endmethod
        public method GetParam6 takes nothing returns real 
        return this.Param6 + this.BonusParam6
    endmethod
endstruct



