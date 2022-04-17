library trigger85 initializer init requires RandomShit, PetDeath

    function Trig_Pandaren_Death_Sound_Initialization_Conditions takes nothing returns boolean
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Pandaren_Death_Sound_Initialization_Actions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        set udg_sounds01[1]= udg_sound17
        set udg_sounds01[2]= udg_sound18
        set udg_sounds01[3]= udg_sound19
        set udg_sounds01[4]= udg_sound20
        set udg_sounds01[5]= udg_sound21
        set udg_sounds01[6]= udg_sound22
        set udg_sounds01[7]= udg_sound23
        set udg_sounds01[8]= udg_sound24
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger85 = CreateTrigger()
        call TriggerAddCondition(udg_trigger85,Condition(function Trig_Pandaren_Death_Sound_Initialization_Conditions))
        call TriggerAddAction(udg_trigger85,function Trig_Pandaren_Death_Sound_Initialization_Actions)
    endfunction


endlibrary
