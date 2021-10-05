library UnitStateSys initializer init requires RandomShit
    globals
        integer array SkeletonDefender
        boolean array bnos_a

        integer array SummonCrit
        integer array SummonCutting
        integer array SummonLastBreath
        integer array SummonIceArmor
        integer array SummonWildDefense
    endglobals

    function RandomAbilityLevel takes integer id, unit hero returns integer
        if id == 0 then
            return LoadInteger(HT,GetHandleId(hero),- 4555101)
        endif
        return id
    endfunction

    function AddSummonAbility takes unit u, integer abilId, integer level returns nothing
        call UnitAddAbility(u, abilId)
        call SetUnitAbilityLevel(u, abilId, level)
    endfunction

    function SummonUnit takes unit u returns nothing
        local integer i = GetUnitTypeId(u)
        local integer i2 = 0
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        local unit hero = udg_units01[pid + 1]
        local integer UpgradeU = 15 * UnitHasItemI(hero,'I07K')
        local real wild = 1 + GetUnitSummonStronger(hero)/ 100

        //Beastmaster
        if GetUnitTypeId(hero) == 'N00P' then
            set UpgradeU = UpgradeU + R2I(GetHeroLevel(hero) * 0.25)
        endif

        //Wild Defense
        if SummonWildDefense[pid] > 0 then
            call AddUnitMagicDef(u,10 * SummonWildDefense[pid])
            call AddUnitEvasion(u,1 * SummonWildDefense[pid])
            call AddUnitBlock(u,10 * SummonWildDefense[pid])
            call AddSummonAbility(u, 'A06X', SummonWildDefense[pid])
        endif

        if SummonCrit[pid] > 0 and i != 'h009' then
            call AddSummonAbility(u, 'AOcr', SummonCrit[pid])
        endif

        if SummonCutting[pid] > 0 then
            call AddSummonAbility(u, 'A081', SummonCutting[pid])
        endif

        if SummonLastBreath[pid] > 0 then
            call AddSummonAbility(u, 'A05R', SummonLastBreath[pid])
        endif

        if SummonIceArmor[pid] > 0 then
            call AddSummonAbility(u, 'A053', SummonIceArmor[pid])
        endif

        //Water Elemental
        if i == 'hwt3' or i == 'hwt2' or i == 'hwat' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'AHwe'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 25,0)
            call AddUnitMagicDef(u,15 * i2)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 500)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )
        
            //Feral Spirit Wolf
        elseif i == 'osw3' or i == 'osw2' or i == 'osw1' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'AOsf'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 25,0)
            call AddUnitEvasion(u,15 * i2)
            if GetUnitAbilityLevel(u, 'AOcr') > 0 then
                call SetUnitAbilityLevel(u, 'AOcr', GetUnitAbilityLevel(u, 'AOcr') + 1)
            else
                call UnitAddAbility(u, 'AOcr')
            endif
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 500)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )

            //Serpent Ward 
        elseif i == 'osp3' or i == 'osp2' or i == 'osp1' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'AOsw'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 30,0)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(10.1 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 300)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )
        
            //Skeleton Warrior Skeleton Mage
        elseif i == 'uske' or i == 'uskm' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'Arai'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 100,0)
            call AddUnitEvasion(u,15 * i2)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 200)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )

            //Summon Mountain Giant
        elseif i == 'e00N' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'AEsv'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 50,0)
            call AddUnitBlock(u,500 * i2)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 1500)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )

            //Summon Quilbeast
        elseif i == 'nqb4' or i == 'nqb3' or i == 'nqb2' or i == 'nqb1' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'Arsq'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 50,0)
            call BlzSetUnitRealField(u,ConvertUnitRealField('uhpr'),BlzGetUnitRealField(u,ConvertUnitRealField('uhpr')) + 25 * i2)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 300)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )

            //Summon Bear
        elseif i == 'ngz3' or i == 'ngz2' or i == 'ngz1'  then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'ANsg'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 30,0)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + I2R(i2)))  ,0)
            call BlzSetUnitArmor(u,BlzGetUnitArmor(u)+ 20 * i2)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 500)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )

            //Summon Hawk
        elseif i == 'nwe3' or i == 'nwe2' or i == 'nwe1'  then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'ANsw'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 25,0)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(7 /(12.1 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 500)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )
        
            //Phoenix
        elseif i == 'h009' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'AHpx'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 400,0)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(7 /(12.1 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 5000)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )
        
            //Lava Spawn
        elseif i == 'nlv3' or i == 'nlv2' or i == 'nlv1' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'ANlm'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 15,0)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(10.1 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 700)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )

            //Inferno
        elseif i == 'n01E' or (i >= 'n01O' and i <= 'n01Z') or (i >= 'n020' and i <= 'n02G') then
            set i2 = UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 500,0)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(20 /(20 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 5000)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))

            if i2 != 0 then
                call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )
            endif

            //Pocket Factory
        elseif i == 'n011' or i == 'n010' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'ANsy'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 30,0)
            call AddUnitMagicDmg(u,45 * i2)
            call AddUnitMagicDef(u,15 * i2)
            call AddUnitEvasion(u,5 * i2)
            call BlzSetUnitArmor(u,BlzGetUnitArmor(u)+ 5 * i2)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 500)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )
        
            //??? Priest?
        elseif i == 'h015' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'ANba'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 30,0)
            call AddUnitMagicDef(u,5 * i2)
            call AddUnitEvasion(u,5 * i2)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + i2))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 175)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )

            //Parasite
        elseif i == 'ncfs' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'ANpa'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 30,0)
            call AddUnitMagicDef(u,5 * i2)
            call AddUnitEvasion(u,5 * i2)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + i2))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 175)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )

            //Carrion Beetle
        elseif i == 'u001' then
            set i2 = RandomAbilityLevel(GetUnitAbilityLevel(hero,'AUcb'),hero) + UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 35,0)
            call AddUnitMagicDef(u,5 * i2)
            call AddUnitEvasion(u,5 * i2)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + i2))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 500)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )

            //Raise Dead Black Arrow Skeletons
        elseif i == 'n02S' or i == 'n02R' or i == 'h01A' or i == 'u003' then
            set i2 = UpgradeU
            call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ i2 * 30,0)
            call AddUnitMagicDef(u,5 * i2)
            call AddUnitEvasion(u,5 * i2)
            call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8 + I2R(i2)))  ,0)
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ i2 * 250)
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
                
            if i2 != 0 then
                call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(i2) )
            endif
        endif 

        //wild Defense
        if wild != 1 then      
            call BlzSetUnitBaseDamage(u,R2I(I2R(BlzGetUnitBaseDamage(u,0))* wild),0)  
            call BlzSetUnitMaxHP(u,R2I(I2R(BlzGetUnitMaxHP(u))* wild))
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
        endif

        //Skeleton Defender
        if i == 'u003' then
            set SkeletonDefender[pid] = SkeletonDefender[pid] + 1
        endif 

        set u = null
        set hero = null
    endfunction



    function SummonUnitS takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call SummonUnit(LoadUnitHandle(HT,GetHandleId(t),1))
        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set t = null
    endfunction



    function Trig_UnitStateSys_Actions takes nothing returns nothing
        ///call UnitAddAbility(GetTriggerUnit(),'A06K')
        local unit u = GetTriggerUnit()
        local timer t = null
        local integer pid
        //call UnitAddAbility(u,'A057')
        //call BlzUnitDisableAbility(u,'A057',false,true)

        if IsUnitIllusion(u) and IsUnitType(u, UNIT_TYPE_HERO) then
            set pid = GetPlayerId(GetOwningPlayer(u)) + 1
            call SetHeroStr(u, GetHeroStr(udg_units01[pid], false), false)
            call SetHeroAgi(u, GetHeroAgi(udg_units01[pid], false), false)
            call SetHeroInt(u, GetHeroInt(udg_units01[pid], false), false)
        endif

        if GetUnitTypeId(u) == 'H017' then
            call AddUnitBlock(u,50)
            call AddUnitMagicDef(u,15)
        endif


        if GetUnitTypeId(u) == 'H01G' then
            call AddUnitMagicDmg(u,5)
        endif


        if GetUnitTypeId(u) == 'O00C' then
            call AddUnitEvasion(u,10)
        endif

        if GetUnitTypeId(u) == 'O006' then
            call AddHeroMaxAbsoluteAbility(u)
            call SetBonus(u, 0, 1)
        endif

        if IsHeroUnitId(GetUnitTypeId(u)) == false then
            set t = NewTimer()
            call SaveUnitHandle(HT,GetHandleId(t),1,u)
            call TimerStart(t,0,false,function SummonUnitS)
        endif

        set t = null
        set u = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterEnterRectSimple( trg, GetPlayableMapRect() )
        call TriggerAddAction( trg, function Trig_UnitStateSys_Actions )
        set trg = null
    endfunction
endlibrary
