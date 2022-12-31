library PandarenDeathSounds initializer init requires RandomShit, PetDeath

    private function PandarenDeathSoundsConditions takes nothing returns boolean
        return IsTriggerEnabled(GetTriggeringTrigger()) == true
    endfunction

    private function PandarenDeathSoundsActions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())

        set udg_sounds01[1] = udg_sound17
        set udg_sounds01[2] = udg_sound18
        set udg_sounds01[3] = udg_sound19
        set udg_sounds01[4] = udg_sound20
        set udg_sounds01[5] = udg_sound21
        set udg_sounds01[6] = udg_sound22
        set udg_sounds01[7] = udg_sound23
        set udg_sounds01[8] = udg_sound24
    endfunction

    private function init takes nothing returns nothing
        set PandarenDeathSoundsTrigger = CreateTrigger()
        call TriggerAddCondition(PandarenDeathSoundsTrigger, Condition(function PandarenDeathSoundsConditions))
        call TriggerAddAction(PandarenDeathSoundsTrigger, function PandarenDeathSoundsActions)
    endfunction

endlibrary
