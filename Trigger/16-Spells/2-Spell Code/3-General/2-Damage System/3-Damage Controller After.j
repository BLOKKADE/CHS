scope DamageControllerAfter initializer init

    globals
        boolean OnHitDamage = false
    endglobals

    function Trig_Damage_Controller_After_Actions takes nothing returns nothing
        local unit damageTarget = GetTriggerUnit()
        local unit damageSource = GetEventDamageSource()
        local integer CuId = GetUnitTypeId(damageSource)
        local unit damageSourceHero = udg_units01[GetConvertedPlayerId(GetOwningPlayer( damageSource) ) ]
        local unit damageTargetHero = udg_units01[GetConvertedPlayerId(GetOwningPlayer( damageTarget) ) ]
        local integer i = 0
        local real r3 = 0
        local integer targetPid = GetPlayerId(GetOwningPlayer(damageTarget))
        local real r2 = 0
        local integer vampCount = 0
        local real r1 = 0
        local integer i1 = 0
        local integer i2 = 0
        local timer tim
        local real luck = 1
        local boolean attack = BlzGetEventIsAttack()
        local unit CrUnitS = damageSource
        local boolean unlimitedAgony = false
        local boolean onHit = false
        local damagetype dmgType = BlzGetEventDamageType()

        if OnHitDamage then
            set onHit = true
            set OnHitDamage = false
        endif

        if CuId == 'h015' or CuId == 'h014' or CuId == 'h00T' or CuId == 'n00V' then
            set damageSource = damageSourceHero
            set CrUnitS = damageSourceHero
        endif
        


        if GetEventDamage() == 0 then
            set damageSourceHero = null
            set damageTargetHero = null
            set CrUnitS = null
            return
        endif
        
        
        set luck = GetUnitLuck(damageSource)
        
        if damageSource == null then
            set damageSourceHero = null
        endif

        set i = GetUnitAbilityLevel(damageSource, 'A0AQ')
        if i > 0 and UnlimitedAgonyActivated.boolean[GetHandleId(damageSource)] then
            set unlimitedAgony = true
            set UnlimitedAgonyActivated.boolean[GetHandleId(damageSource)] = false
            //call BJDebugMsg("unlimited agony pt2")
        endif

        if not unlimitedAgony then
            //Titanium Armor
            if UnitHasItemS(damageTarget,'I07M') then
                set r1 = I2R(GetHeroStr(damageTarget,true))* 0.08
                
                if r1 >= GetEventDamage() then
                    call BlzSetEventDamage( 0 )
                    set damageSourceHero = null
                    set damageTargetHero = null
                    return
                else
                    call BlzSetEventDamage( GetEventDamage()- r1 )
                endif
            endif

            //Strong Chest Mail
            if UnitHasItemS(damageTarget,'I07P') and IsHeroUnitId(GetUnitTypeId(damageSource)) == false and dmgType ==  DAMAGE_TYPE_NORMAL then   
                call BlzSetEventDamage(  GetEventDamage()/ 2 ) 
            endif
        endif

        //Fishing Rod
        if (not onHit) and UnitHasItemS(damageSource,'I07T') and dmgType ==  DAMAGE_TYPE_NORMAL and DistanceBetweenUnits(damageSource, damageTarget) < 1200 then
            call SetUnitX(damageSource,GetUnitX(damageTarget) )
            call SetUnitY(damageSource,GetUnitY(damageTarget) )
        endif

        //Aura of Vulnerability
        if GetUnitAbilityLevel(damageTarget ,'B00E') >= 1 then
            if GetRandomReal(0,100) <= 5 * luck then
                call BlzSetEventDamage(  GetEventDamage()  +   (GetEventDamage()*(GetUnitAbilityLevel(damageSourceHero  ,'A02M')/ 2))  )
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", damageTarget, "chest"))
            endif
        endif

        //Medal of Honor
        if LoadInteger(HTi,GetHandleId(damageTargetHero),2) == 1 then 
            call BlzSetEventDamage(   GetEventDamage()* 0.66 )
        endif 

        //Medal of Honor
        if LoadInteger(HTi,GetHandleId(damageSourceHero),2) == 1 then 
            call BlzSetEventDamage(   GetEventDamage()* 0.66 )
        endif 

        //Mask of Death
        if LoadInteger(HTi,GetHandleId(damageSourceHero),1) == 1 then
            set r2 = (GetEventDamage()/ 4)
            call Vamp(damageSource,damageTarget,r2)
            set vampCount = vampCount + 1	
            call BlzSetEventDamage(   GetEventDamage()* 0.75 )
        endif

        //Vampirism
        set r1 = GetUnitAbilityLevel(damageSource,'AUav')
        if r1 > 0 then
            set r2 = GetEventDamage()*(0.005 + 0.005 * r1 + GetClassUnitSpell(damageSource,11)* 0.02 )
            call Vamp(damageSource,damageTarget,r2)
            set vampCount = vampCount + 1
        endif

        //Dreadlord Passive
        if GetUnitTypeId(damageSourceHero) == 'O002' then
            set r2 = GetEventDamage()*(0.02 * I2R(GetHeroLevel(damageSourceHero)) )
            call Vamp(damageSource,damageTarget,r2)
            set vampCount = vampCount + 1
        endif	

        //Ghoul Passive
        if GetUnitTypeId(damageSource) == 'H01H' and attack then
            set i = GetHeroLevel(damageSource)
            set r2 = (GetEventDamage() + (BlzGetUnitMaxHP(damageTarget) * (0.025 + (0.00025 * i))))
            call Vamp(damageSource,damageTarget,r2)
            set vampCount = vampCount + 1
            call BlzSetEventDamage(   GetEventDamage()+ r2 ) 
        endif
        //Bone Armor Skeleton Defender
        set i = SkeletonDefender[targetPid]
        if i > 0 and IsHeroUnitId(GetUnitTypeId(damageTarget)) then
            if i > 12 then
                set i = 12
            endif
            call BlzSetEventDamage(   GetEventDamage() * (1 - (i * 0.08)))
        endif
        
        //Magic Necklace of Absorption
        if GetUnitAbilityLevel(damageTarget  ,'B00R') >= 1 and dmgType == DAMAGE_TYPE_MAGIC then
            call SetUnitState(damageTarget,UNIT_STATE_MANA,   GetUnitState( damageTarget  , UNIT_STATE_MANA  )  + GetEventDamage()* 0.75 )
        endif

        //Bloody Axe
        if dmgType ==  DAMAGE_TYPE_NORMAL and IsHeroUnitId(GetUnitTypeId(damageTarget)) == false then
            set i = UnitHasItemI( damageSource,'I078') 
            if i > 0 then
                set r2 = GetEventDamage()*(  0.25 * I2R(i))
                call Vamp(damageSource,damageTarget,r2)
                set vampCount = vampCount + 1  
            endif
        endif

        //Staff of Absolute Magic
        if GetUnitAbilityLevel(damageSourceHero  ,'B00O') >= 1 and dmgType == DAMAGE_TYPE_MAGIC then
            set r2 = GetEventDamage()* 0.33 
            call Vamp(damageSource,damageTarget,r2)
            set vampCount = vampCount + 1
        endif

        //Heavy Blow
        if GetUnitAbilityLevel(damageSource  ,'A04G') > 0 and dmgType ==  DAMAGE_TYPE_NORMAL and (BlzGetUnitAbilityCooldownRemaining(damageSourceHero,'A04G') <= 0 or CheckTimerZero(damageSourceHero,'A04G')) then
            if ZetoTimerStart(damageSourceHero,'A04G') then
                call AbilStartCD(damageSource,'A04G',0.3)
            endif
            call BlzSetEventDamage(  GetEventDamage() + 30 * GetUnitAbilityLevel(damageSource  ,'A04G')  )
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Orc\\Devour\\DevourEffectArt.mdl", damageTarget, "chest"))
        endif
        
        //Combustion
        if GetUnitAbilityLevel(damageSourceHero   ,'A04H') > 0 and dmgType == DAMAGE_TYPE_MAGIC and (BlzGetUnitAbilityCooldownRemaining(damageSourceHero,'A04H') <= 0 or CheckTimerZero(damageSourceHero,'A04H')) then
            if ZetoTimerStart(damageSourceHero,'A04H') then
                call AbilStartCD(damageSourceHero,'A04H',0.3)
            endif
            call BlzSetEventDamage(  GetEventDamage() + 30 * GetUnitAbilityLevel(damageSourceHero   ,'A04H')  )
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl", damageTarget, "chest"))
        endif

        //Frostmourne
        if GetUnitAbilityLevel(damageSourceHero ,'B008') >= 1 then
            call Vamp(damageSourceHero,damageTarget, (GetEventDamage()/ 4))	
            set vampCount = vampCount + 1 
        endif
        
        //Heavy Mace
        set i = UnitHasItemI( damageSource,'I07I') 
        if i > 0 and IsUnitType(damageSource,UNIT_TYPE_MELEE_ATTACKER) then
            set r1 =  (GetWidgetLife(damageTarget)/ 100)* 1.5 * I2R(i)  
            call Vamp(damageSource,damageTarget,r1)
            call BlzSetEventDamage( GetEventDamage()+ r1)
            set vampCount = vampCount + 1
        endif
        
        //Cutting
        if GLOB_cuttting then
            call Vamp(damageSource,damageTarget,GetEventDamage()/ 2 )
            set vampCount = vampCount + 1 
            call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Other\\PandarenBrewmasterBlood\\PandarenBrewmasterBlood.mdl", damageTarget, "chest"))
        endif 

        if vampCount > 0 and IsFxOnCooldown(damageSource, 0) == false then
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", damageSource, "chest"))
            call SetFxCooldown(damageSource, 0, 1)
        endif

        //Ancient Blood
        if GetUnitAbilityLevel(damageTarget,'A07T') > 0 and CuId != 'n00V' then
            set r1 = LoadReal(HT,GetHandleId(damageTarget),82340)
            set r2 = LoadReal(HT,GetHandleId(damageTarget),82341)
            set r3 = 1 - 0.01 * I2R(GetUnitAbilityLevel(damageTarget,'A07T') ) 
            
            if r1 == 0 then
                set r2 = 20000
            endif
            
            set r1 = r1 + GetEventDamage()
            loop
                exitwhen r3 * r2 > r1 
                set r1 = r1 - r2 * r3 
                set r2 = r2 + 250
                call SetHeroStr(damageTarget,GetHeroStr(damageTarget,false)+ 2,false)
                //remove bufs
                
                if BlzGetUnitAbilityCooldownRemaining(damageTarget, 'A07T') == 0 then
                    call AbilStartCD(damageTarget, 'A07T', 1)
                    set i1 = 0
                    loop
                        exitwhen i1 > 10
                        set i2 = GetInfoHeroSpell(damageTarget ,i1)
                        if i2 != 0 and IsSpellResettable(i2) then
                            call ResetSpell(damageTarget, i2, 1 + 0.25 * I2R(GetUnitAbilityLevel(damageTarget,'A07T')), false)
                        endif
                        set i1 = i1 + 1
                    endloop
                endif
                
                call RemoveDebuff(damageTarget, 1)
            endloop
            call SaveReal(HT,GetHandleId(damageTarget),82340,r1)
            call SaveReal(HT,GetHandleId(damageTarget),82341,r2)
        endif

        //Wild Runestone
        if UnitHasItemS(damageTargetHero, 'I0B6') and IsUnitType(damageTarget, UNIT_TYPE_HERO) == false and (not unlimitedAgony) then
            call BlzSetEventDamage( GetEventDamage() * 0.7)
        endif

        //Blademaster
        if GetUnitTypeId(damageSource) == 'N00K' and BladestormReady(damageSource) and attack then
            call BladestormDamage(damageSource, GetEventDamage(), dmgType ==  DAMAGE_TYPE_MAGIC)
        endif
        
        //Banshee passive
        if GetUnitTypeId(damageTarget) == 'H01I' then
            if GetEventDamage() >= GetUnitState(damageTarget,UNIT_STATE_MANA) then
                call SetUnitState(damageTarget,UNIT_STATE_MANA,0)
                call BlzSetEventDamage(GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE)+ 1)
            else
                call SetUnitState(damageTarget,UNIT_STATE_MANA,GetUnitState(damageTarget,UNIT_STATE_MANA) - GetEventDamage()    )     
                call BlzSetEventDamage(0)
            endif 
        endif

        //Holy Chain Mail
        if UnitHasItemS(damageTarget,'I07U') and (not unlimitedAgony) then   
            if BlzGetUnitMaxHP(damageTarget) > BlzGetUnitMaxMana(damageTarget) then
                if GetEventDamage() > BlzGetUnitMaxHP(damageTarget)/ 5 then
                    call BlzSetEventDamage(  BlzGetUnitMaxHP(damageTarget)/ 5 ) 
                endif
            else
                if GetEventDamage() > BlzGetUnitMaxMana(damageTarget)/ 5 then
                    call BlzSetEventDamage(  BlzGetUnitMaxMana(damageTarget)/ 5 ) 
                endif
            endif
        endif

        //Skeleton Brute
        if GetUnitTypeId(damageTarget) == 'N00O' then
            if BlzGetUnitAbilityCooldownRemaining(damageTarget, 'A0BA') == 0 and BlzGetUnitMaxHP(damageTarget) * 0.3 <= GetEventDamage() and GetUnitAbilityLevel(damageTarget, 'A0BB') == 0 then
                call SkeletonBrute(damageTarget)
            endif

            //Invul
            if GetUnitAbilityLevel(damageTarget, 'A0BB') > 0 then
                call BlzSetEventDamage(0)
            endif
        endif

        //Finishing Blow
        if GetEventDamage() > 0 and GetUnitAbilityLevel(damageSourceHero ,'A02N') >= 1 then
            if 100 *(GetWidgetLife(damageTarget)- GetEventDamage())/ GetUnitState(damageTarget,UNIT_STATE_MAX_LIFE)     <= R2I(GetUnitAbilityLevel(damageSourceHero ,'A02N'))  then
                call BlzSetEventDamage(9999999)
                call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", damageTarget, "chest"))
            endif
        endif

        //Murloc Warrior
        if GetUnitTypeId(damageTarget) == 'H01F' and GetHeroStr(damageTarget, true) < 2147483647 then
            set i1 = 1 + GetHeroLevel(damageTarget)/ 10 
            call SaveInteger(HT,GetHandleId(damageTarget),54021,i1 + LoadInteger(HT,GetHandleId(damageTarget),54021))
            call SetHeroStr(damageTarget,GetHeroStr(damageTarget,false)+ i1,false)
            call SetHeroAgi(damageTarget,GetHeroAgi(damageTarget,false)+ i1,false)
            call SetHeroInt(damageTarget,GetHeroInt(damageTarget,false)+ i1,false)
        endif

        //Flimsy Token
        if UnitHasItemS(damageTarget, 'I0A3') and GetUnitAbilityLevel(damageSource, 'B01Q') == 0 then
            call FlimsyToken(damageTarget, damageSource)
        endif

        //Stone Protection
        if GetUnitAbilityLevel(damageTarget,'A060') > 0 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'A060')<= 0.001 then
            call stoneProtect(damageTarget,CrUnitS)
        endif
        
        //Thunder Force
        if GetUnitAbilityLevel(damageSource,'A02S' ) >= 1 and attack then
            call UsOrderU(damageSource,damageTarget,GetUnitX(damageSource),GetUnitY(damageSource),'A02R',"chainlightning",  GetHeroInt(damageSource,true)*(20 + 8 * I2R(GetUnitAbilityLevel(damageSource,'A02S' )))/ 100, ABILITY_RLF_DAMAGE_PER_TARGET_OCL1 )
        endif

        if not onHit and GetEventDamage() > 0 then
            if dmgType == DAMAGE_TYPE_NORMAL then
                //Thorns
                if (GetUnitAbilityLevel(damageTarget, 'B01C') > 0 and IsUnitType(damageSource, UNIT_TYPE_MELEE_ATTACKER)) then

                    set r1 = 1 - (0.01 * GetUnitAbilityLevel(damageTargetHero, 'A088' + GetUnitAbilityLevel(damageTargetHero, 'A093')))
                    //call BJDebugMsg("thorns: r1:" + R2S(r1) + " ttl: " + R2S((GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A08F') * 0.01)) * r1))
                    if IsUnitType(damageSource, UNIT_TYPE_HERO) then
                        call MagicDamage(damageTarget,damageSource, (GetEventDamage() * ( 0.12 + (GetUnitAbilityLevel(damageTargetHero, 'A08F') * 0.03))) * r1, true)
                    else
                        call MagicDamage(damageTarget,damageSource, (GetEventDamage() * ( 0.18 + (GetUnitAbilityLevel(damageTargetHero, 'A08F') * 0.045))) * r1, true)
                    endif
                endif

                //Reflection
                if (GetUnitAbilityLevel(damageTarget, 'B01O') > 0 and IsUnitType(damageSource, UNIT_TYPE_RANGED_ATTACKER)) then
                    set r1 = 1 - (0.01 * GetUnitAbilityLevel(damageTargetHero, 'A088' + GetUnitAbilityLevel(damageTargetHero, 'A08F')))
                    //call BJDebugMsg("ref: r1:" + R2S(r1) + " ttl: " + R2S((GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A093') * 0.01)) * r1))
                    if IsUnitType(damageSource, UNIT_TYPE_HERO) then
                        call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (0.12 + (GetUnitAbilityLevel(damageTargetHero, 'A093') * 0.03))) * r1, true)
                    else
                        call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (0.12 + (GetUnitAbilityLevel(damageTargetHero, 'A093') * 0.045))) * r1, true)
                    endif
                endif

                //spiked carapaces
                if GetUnitAbilityLevel(damageTarget, 'AUts') > 0 and attack then
                    call MagicDamage(damageTarget,damageSource, GetEventDamage() * (0.03 + (GetUnitAbilityLevel(damageTargetHero, 'AUts') * 0.009)), true)
                endif
            endif

            if dmgType == DAMAGE_TYPE_MAGIC then

                //Wizardbane
                if GetUnitAbilityLevel(damageTarget, 'B01B') > 0 then
                    set r1 = 1 - (0.01 * GetUnitAbilityLevel(damageTargetHero, 'A08F' + GetUnitAbilityLevel(damageTargetHero, 'A093')))
                    //call BJDebugMsg("wb: r1:" + R2S(r1) + " ttl: " + R2S((GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A088') * 0.01)) * r1))
                    if IsUnitType(damageSource, UNIT_TYPE_HERO) then
                        call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A088') * 0.03)) * r1, true)
                    else
                        call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A088') * 0.05)) * r1, true)
                    endif
                    call DestroyEffect(AddSpecialEffectTargetFix("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", damageSource, "chest"))
                endif
            endif
        endif

        //Last Breath
        set i = GetUnitAbilityLevel(damageTarget, 'A05R')
        if i > 0 and GetEventDamage() > 0 then
            call LastBreath(damageTarget, i)
        else
            //if killed
            if GetUnitState(damageTarget, UNIT_STATE_LIFE) - GetEventDamage() <= 0 then

                //Skeleton Battlemaster (Black Arrow)
                set i = GetUnitAbilityLevel(damageTargetHero, 'A0AW')
                if i > 0 and GetUnitAbilityLevel(damageTarget, 'A0AX') > 0 /*and GetRandomInt(1,100) < (i + 10) * GetUnitLuck(damageTargetHero)*/ then
                    call SetUnitState(damageTarget, UNIT_STATE_LIFE, GetUnitState(damageTarget, UNIT_STATE_MAX_LIFE))
                    call BlzSetEventDamage(0)
                endif

                //Magic Necklace
                if UnitHasItemS(damageSourceHero, 'I05G') and dmgType ==  DAMAGE_TYPE_MAGIC then
                    set MacigNecklaceBonus.boolean[GetHandleId(damageTarget)] = true
                endif

                //Chest of Greed
                if UnitHasItemS(damageSourceHero, 'I05A') and dmgType == DAMAGE_TYPE_NORMAL then
                    set ChestOfGreedBonus.boolean[GetHandleId(damageTarget)] = true
                endif
            endif
        endif

        set damageSourceHero = null
        set damageTargetHero = null
        set damageTarget = null
        set damageSource = null
        set tim = null
    endfunction




    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_DAMAGED )
        call TriggerAddAction( trg, function Trig_Damage_Controller_After_Actions )
        set trg = null
    endfunction
endscope