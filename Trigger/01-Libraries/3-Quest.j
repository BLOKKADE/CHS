scope Quests initializer init
    function AddQuest takes string title, string description, string icon, boolean required, boolean discovered, boolean completed returns nothing
        set bj_lastCreatedQuest = CreateQuest()
        call QuestSetTitle(bj_lastCreatedQuest, title)
        call QuestSetDescription(bj_lastCreatedQuest, description)
        call QuestSetIconPath(bj_lastCreatedQuest, icon)
        call QuestSetRequired(bj_lastCreatedQuest, required)
        call QuestSetDiscovered(bj_lastCreatedQuest, discovered)
        call QuestSetCompleted(bj_lastCreatedQuest, completed)
    endfunction

    function AddQuestItem takes quest q, string desc, boolean completed returns nothing
        set bj_lastCreatedQuestItem = QuestCreateItem(q)
        call QuestItemSetDescription(bj_lastCreatedQuestItem, desc)
        call QuestItemSetCompleted(bj_lastCreatedQuestItem, completed)
    endfunction
    
    function QuestSetUp takes nothing returns nothing
        call AddQuest("General Information", "Continuation of Custom Hero Survival 1.9.xx by Snowww & BLOKKADE.\nThanks to everyone on the Discord for feedback and suggestions.", "ReplaceableTextures\\PassiveButtons\\PASTimeEclipse3.blp", true, true, false)
        call AddQuestItem(bj_lastCreatedQuest, "Visit the discord to join our community!", false)
        call AddQuestItem(bj_lastCreatedQuest, "discord.gg/dtTcyMGTyu", false)
        
        call AddQuest("Commands", "-zoom xxxx, zooms your camera in or out.\n-clear, clears all text off your screen.\n-hint, disables hints.\n-time, displays playtime\n-nis, disables income texts from other players", "ReplaceableTextures\\PassiveButtons\\PASScarlet_Aegis_Icon.blp", false, true, false)
        
        call AddQuest("Selected Mode", "", "ReplaceableTextures\\CommandButtons\\BTNWisp.blp", false, true, false)
    endfunction
    
    private function init takes nothing returns nothing
        call QuestSetUp()
    endfunction
endscope