library AoeDamage requires Vampirism, DivineBubble, DamageEngine
    globals
        unit Aoe_Source = null
        real Aoe_DamageAmount = 0
        integer Aoe_AbilitySource = 0
        private boolean Aoe_OnHit = false
        
        boolexpr array BoolArray
        boolean GLOB_LIFESTEAL = false
    endglobals



    function DamageRealase takes nothing returns boolean
        if IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(Aoe_Source)) and IsUnitSpellTargetCheck(GetFilterUnit(), GetOwningPlayer(Aoe_Source)) then
            if Aoe_OnHit then
                set udg_NextDamageType = DamageType_Onhit
            endif
            set udg_NextDamageAbilitySource = Aoe_AbilitySource
            call Damage.applyMagic(Aoe_Source,GetFilterUnit(),Aoe_DamageAmount, DAMAGE_TYPE_MAGIC)
        endif

        return false
    endfunction

    function AreaDamageTimer takes nothing returns nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local unit Sourse = LoadUnitHandle(HT,i,1)
        local real x1 = LoadReal(HT,i,2)
        local real y1 = LoadReal(HT,i,3)
        local real Dmg = LoadReal(HT,i,4)
        local real Area = LoadReal(HT,i,5)
        local integer AbilId = LoadInteger(HT,i,6)
        set Aoe_OnHit = LoadBoolean(HT, i, 7)
        
        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        
        set Aoe_Source = Sourse
        set Aoe_DamageAmount = Dmg
        set Aoe_AbilitySource = AbilId
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP,x1,y1,Area,BoolArray[0])    
        
        set t = null
        set Sourse = null
    endfunction

    function AreaDamage takes unit Sourse,real x1,real y1, real Dmg, real Area, boolean onHit, integer AbilId returns nothing
        local timer t
        local integer i
        if Sourse != null then
            set t = NewTimer()
            set i = GetHandleId(t)
            
            call SaveUnitHandle(HT,i,1,Sourse)
            call SaveReal(HT,i,2,x1)
            call SaveReal(HT,i,3,y1)
            call SaveReal(HT,i,4,Dmg)
            call SaveReal(HT,i,5,Area)
            call SaveBoolean(HT,i,7,onHit)

            call SaveInteger(HT,i,6,AbilId)
            call TimerStart(t,0,false,function AreaDamageTimer)
        endif
        
        set t = null
    endfunction





    function DamageRealasePhys takes nothing returns boolean
        if IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(Aoe_Source)) and GetWidgetLife(GetFilterUnit()) > 0.405 then
            //set Attack_AbilId = Aoe_AbilitySource 
            //set GLOB_typeDmg = 2
            set udg_NextDamageAbilitySource = Aoe_AbilitySource
            call Damage.applyPhys(Aoe_Source,GetFilterUnit(),Aoe_DamageAmount, false, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        endif

        return false
    endfunction

    function AreaDamageTimerPhys takes nothing returns nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local unit Sourse = LoadUnitHandle(HT,i,1)
        local real x1 = LoadReal(HT,i,2)
        local real y1 = LoadReal(HT,i,3)
        local real Dmg = LoadReal(HT,i,4)
        local real Area = LoadReal(HT,i,5)
        local integer AbilId = LoadInteger(HT,i,6)
        
        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        
        set Aoe_Source = Sourse
        set Aoe_DamageAmount = Dmg
        set Aoe_AbilitySource = AbilId
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP,x1,y1,Area,BoolArray[103])    
        
        set t = null
        set Sourse = null
    endfunction

    function AreaDamagePhys takes unit Sourse,real x1,real y1, real Dmg, real Area,integer AbilId returns nothing
        local timer t
        local integer i
        if Sourse != null then
            set t = NewTimer()
            set i = GetHandleId(t)
            
            call SaveUnitHandle(HT,i,1,Sourse)
            call SaveReal(HT,i,2,x1)
            call SaveReal(HT,i,3,y1)
            call SaveReal(HT,i,4,Dmg)
            call SaveReal(HT,i,5,Area)
            call SaveInteger(HT,i,6,AbilId)
            call TimerStart(t,0,false,function AreaDamageTimerPhys)
        endif
        
        set t = null
    endfunction






    function DrainRealase takes nothing returns boolean
        local real hp
        local real dmg
        if IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(Aoe_Source)) and GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitDivineBubbled(GetFilterUnit()) == false and GetUnitAbilityLevel(GetFilterUnit(), BLOODSTONE_BUFF_ID) == 0 and GetUnitAbilityLevel(GetFilterUnit(), 'B022') == 0 then
            set hp = GetWidgetLife(GetFilterUnit())
            set dmg = Aoe_DamageAmount
            if GLOB_LIFESTEAL then
                set dmg = dmg * BlzGetUnitMaxHP(GetFilterUnit())
            endif
            
            if hp - 0.405 <= dmg then
                set dmg = hp
                call SetWidgetLife(GetFilterUnit(),1)
            else
                call SetWidgetLife(GetFilterUnit(),hp - dmg)
            endif
            
            if GLOB_LIFESTEAL then
                
                if IsHeroUnitId(GetUnitTypeId(GetFilterUnit())) then
                
                    call Vamp(Aoe_Source,GetFilterUnit(),dmg)
                else
                    call Vamp(Aoe_Source,GetFilterUnit(),dmg / 5)
                endif
            endif
            
            
        endif
        return false
        
    endfunction

    function AoeDrainAura takes unit u, real hp, real Area, boolean lifesteal returns nothing
        set Aoe_Source = u
        set Aoe_DamageAmount = hp
        set GLOB_LIFESTEAL = lifesteal
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP,GetUnitX(u),GetUnitY(u),Area,BoolArray[104])    
    endfunction




    function DrainRealase2 takes nothing returns boolean
        local real hp
        local real dmg
        if IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(Aoe_Source)) and GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitDivineBubbled(GetFilterUnit()) == false and GetUnitAbilityLevel(GetFilterUnit(), BLOODSTONE_BUFF_ID) == 0 and GetUnitAbilityLevel(GetFilterUnit(), 'B022') == 0  then

            set hp = GetWidgetLife(GetFilterUnit())
            set dmg = Aoe_DamageAmount * hp / 100
                
            if hp - 0.405 <= dmg then
                set dmg = hp
                call SetWidgetLife(GetFilterUnit(),1)
            else
                call SetWidgetLife(GetFilterUnit(),hp - dmg)
            endif
            
            if GLOB_LIFESTEAL then
                if IsHeroUnitId(GetUnitTypeId(GetFilterUnit())) then
                
                    call Vamp(Aoe_Source,GetFilterUnit(),dmg)
                else
                    call Vamp(Aoe_Source,GetFilterUnit(),dmg / 5)
                endif
            endif
            
            
        endif
        return false
        
    endfunction

    function AoeDrainAura2 takes unit u, real hp, real Area, boolean lifesteal returns nothing
        set Aoe_Source = u
        set Aoe_DamageAmount = hp
        set GLOB_LIFESTEAL = lifesteal
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP,GetUnitX(u),GetUnitY(u),Area,BoolArray[105])    
    endfunction



    function InitDamageArea takes nothing returns nothing


        set BoolArray[0] = Condition(function DamageRealase)
        set BoolArray[103] = Condition(function DamageRealasePhys)
        set BoolArray[104] = Condition(function DrainRealase)
        set BoolArray[105] = Condition(function DrainRealase2)
    endfunction
endlibrary