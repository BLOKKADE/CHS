/*library trigger12 initializer init requires RandomShit

    function Trig_Devastating_Blow_Ennhance_Actions takes nothing returns nothing
        set udg_integer53 = 1
        loop
            exitwhen udg_integer53 > 8
    
            if GetUnitAbilityLevel(PlayerHeroes[udg_integer53],'A050') > 0 and BlzGetUnitAbilityCooldownRemaining(PlayerHeroes[udg_integer53],'A050')<= 0 and udg_effects01[udg_integer53] == null then
                call DestroyEffectBJ(udg_effects01[udg_integer53])
                call AddSpecialEffectTargetUnitBJ("hand left",PlayerHeroes[udg_integer53],"Abilities\\Weapons\\LavaSpawnMissile\\LavaSpawnMissile.mdl")
                set udg_effects01[udg_integer53]= GetLastCreatedEffectBJ()
                call DestroyEffectBJ(udg_effects02[udg_integer53])
                call AddSpecialEffectTargetUnitBJ("hand right",PlayerHeroes[udg_integer53],"Abilities\\Weapons\\LavaSpawnMissile\\LavaSpawnMissile.mdl")
                set udg_effects02[udg_integer53]= GetLastCreatedEffectBJ()
            endif
    
            set udg_integer53 = udg_integer53 + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger12 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger12,0.25)
        call TriggerAddAction(udg_trigger12,function Trig_Devastating_Blow_Ennhance_Actions)
    endfunction


endlibrary*/
