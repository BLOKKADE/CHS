library AncientTeaching initializer init requires RandomShit, StableSpells
    function ResetAbility_A05U takes unit u,integer id returns nothing
        if BlzGetUnitAbilityCooldownRemaining(u,ANCIENT_TEACHING_ABILITY_ID)<= 0.001 and GetUnitAbilityLevel(u,ANCIENT_TEACHING_ABILITY_ID) > 0 and IsSpellResettable(id) then
            call AbilStartCD(u,ANCIENT_TEACHING_ABILITY_ID,BlzGetUnitAbilityCooldownRemaining(u,id)*(4 - 0.1 * I2R(GetUnitAbilityLevel(u,ANCIENT_TEACHING_ABILITY_ID)))) 
            call BlzEndUnitAbilityCooldown(u,id)
        
        endif
        

    endfunction


    function ResetAbilit_Ec takes nothing returns nothing
        call ResetAbility_A05U(Global_u,Global_i)
    endfunction




    function A05U_Reset_Timer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit U = LoadUnitHandle(HT,GetHandleId(t),2)
        local integer Id = LoadInteger(HT,GetHandleId(t),1)

        call ResetAbility_A05U(U,Id)

        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set t = null
        set U = null
    endfunction

    function Trig_Ancient_Teaching_Actions takes nothing returns nothing
        local unit U = GetTriggerUnit()
        local integer Id = GetSpellAbilityId()
        local timer t = null



        if GetUnitTypeId(GetTriggerUnit() ) == SORCERER_UNIT_ID then
            call USOrderA(GetTriggerUnit(),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),'A037',"fanofknives",  GetHeroLevel(GetTriggerUnit())* 50 , ConvertAbilityRealLevelField('Ocl1') )
        endif

        if Id != RESET_TIME_ABILITY_ID then
            if GetUnitAbilityLevel(U,ANCIENT_TEACHING_ABILITY_ID)> 0 and BlzGetUnitAbilityCooldownRemaining(U,ANCIENT_TEACHING_ABILITY_ID)<= 0.001 then
                set t = NewTimer()
                call SaveInteger(HT,GetHandleId(t),1,Id)
                call SaveUnitHandle(HT,GetHandleId(t),2, U)
                call TimerStart(t,0,false,function A05U_Reset_Timer)
                
            endif
        endif

        set U = null
        set t = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddAction( trg, function Trig_Ancient_Teaching_Actions )
        set trg = null
    endfunction
endlibrary