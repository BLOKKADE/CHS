library DraftHeroSelection initializer init requires RandomShit

    function DraftHeroButtonSelected takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[23]))then
            return false
        endif
        return true
    endfunction


    function IncrementedDraftHeroVoteCount takes nothing returns nothing
        set ModeVotesCount[21]=(ModeVotesCount[21]+ 1)
        call DialogDisplayBJ(true,GameDurDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        local trigger draftHeroSelectionTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(draftHeroSelectionTrigger,HeroModeDialog)
        call TriggerAddCondition(draftHeroSelectionTrigger,Condition(function DraftHeroButtonSelected))
        call TriggerAddAction(draftHeroSelectionTrigger,function IncrementedDraftHeroVoteCount)
        set draftHeroSelectionTrigger = null
    endfunction


endlibrary
