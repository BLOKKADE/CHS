scope Killing initializer init    
    function TimerMagDmg  takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HT,GetHandleId(t),1)

        call AddUnitMagicDmg(u,-15*LoadInteger(HT,GetHandleId(t),2))


        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)

        set t =null
        set u = null
    endfunction

    function Trig_Killing_Actions takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer uid = GetHandleId(u)
        local unit k = GetKillingUnit()
        local player Pu = GetOwningPlayer(u)
        local player Pk = GetOwningPlayer(k)
        local integer PidU =  GetPlayerId(Pu)
        local integer PidK =  GetPlayerId(Pk)
        local unit Gu = udg_units01[PidU+1]
        local unit Ku = udg_units01[PidK+1]
        local integer i = 0

        local timer t


        //Incinerate
        if LoadInteger(HT,GetHandleId(u),-300004)+160 > T32_Tick then

            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", u, "head"))
            call AreaDamage(LoadUnitHandle(HT,uid,-300003),GetUnitX(u),GetUnitY(u),LoadInteger(HT,uid,-300002),300, true, 'B014')

        endif


        if IsHeroUnitId(GetUnitTypeId(u)) == false  then

            //Strong Chest Mail
            set i =  UnitHasItemI( Ku,'I079') 
            if i > 0 and k != null then
                call Vamp(Ku,Gu, BlzGetUnitMaxHP(Ku)*0.1*I2R(i))
                call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", Ku, "chest"))      
            endif

            //Amulet of the Night
            set i =  UnitHasItemI( Ku,'I07E') 
            if i > 0 and GetOwningPlayer(u) == Player(11) then

                call AddUnitMagicDmg(Ku,i*15)

                set t = NewTimer()
                call SaveUnitHandle(HT,GetHandleId(t),1,Ku)
                call SaveInteger(HT,GetHandleId(t),2,i)
                call TimerStart(t,10,false,function TimerMagDmg )
            endif

            call FixUnit(GetTriggerUnit())
        endif
        set t = null
        set u = null
        set k = null
        set Ku = null
        set Gu = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_DEATH )
        call TriggerAddAction( trg, function Trig_Killing_Actions )
        set trg = null
    endfunction
endscope