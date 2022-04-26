library trigger55 initializer init requires RandomShit

    function Trig_Dialog_Initialization_Func047Func001C takes nothing returns boolean
        if(not(InitialPlayerCount > 1))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Initialization_Func047Func001Func001C takes nothing returns boolean
        if(not(udg_boolean15==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Initialization_Func047A takes nothing returns nothing
        if(Trig_Dialog_Initialization_Func047Func001C())then
            if(Trig_Dialog_Initialization_Func047Func001Func001C())then
                call DialogDisplayBJ(true,GameModeDialog,GetEnumPlayer())
            else
                call DialogDisplayBJ(true,GameModeDialog,udg_player03)
            endif
        else
            call DialogDisplayBJ(true,AbilModeDialog,GetEnumPlayer())
        endif
    endfunction


    function Trig_Dialog_Initialization_Func049001 takes nothing returns boolean
        return(IsTriggerEnabled(udg_trigger77)!=true)
    endfunction


    function Trig_Dialog_Initialization_Func054001 takes nothing returns boolean
        return(IsTriggerEnabled(udg_trigger77)!=true)
    endfunction


    function Trig_Dialog_Initialization_Func055A takes nothing returns nothing
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call DialogDisplayBJ(false,GameDurDialog,GetEnumPlayer())
        call DialogDisplayBJ(false,IncomeModeDialog,GetEnumPlayer())
        call DialogDisplayBJ(false,GameModeDialog,GetEnumPlayer())
        call DialogDisplayBJ(false,AbilModeDialog,GetEnumPlayer())
        call DialogDisplayBJ(false,HeroModeDialog,GetEnumPlayer())
        call DialogDisplayBJ(false,BettingModeDialog,GetEnumPlayer())
        call DialogDisplayBJ(false,udg_dialog06,GetEnumPlayer())
    endfunction


    function Trig_Dialog_Initialization_Func056C takes nothing returns boolean
        if(not(IsTriggerEnabled(udg_trigger77)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Initialization_Actions takes nothing returns nothing
        call EnableTrigger(GetTriggeringTrigger())
    
        //rounds
        call DialogSetMessageBJ(GameDurDialog,"Game Duration/Difficulty")
        call DialogAddButtonBJ(GameDurDialog,"Fast/Easy: 25 rounds, 45 min")
        set udg_buttons01[1]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(GameDurDialog,"Long/Medium: 50 rounds, 90 min")
        set udg_buttons01[2]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(GameDurDialog,"Doesn't Matter")
        set udg_buttons01[3]= GetLastCreatedButtonBJ()
    
        //game mode
        call DialogSetMessageBJ(GameModeDialog,"Game Mode")
    
        call DialogAddButtonBJ(GameModeDialog,"Normal (Recommended)")
        set udg_buttons01[4]= GetLastCreatedButtonBJ()	
    
        call DialogAddButtonBJ(GameModeDialog,"Immortal: Easy")
        set udg_buttons01[18]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(GameModeDialog,"Doesn't Matter")
        set udg_buttons01[6]= GetLastCreatedButtonBJ()
    
        //abilities
        call DialogSetMessageBJ(AbilModeDialog,"Ability Options")
    
        call DialogAddButtonBJ(AbilModeDialog,"Pick Abilities (Recommended)")
        set udg_buttons01[7]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(AbilModeDialog,"Random Abilities")
        set udg_buttons01[8]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(AbilModeDialog,"Draft Abilities")
        set udg_buttons01[22]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(AbilModeDialog,"Doesn't Matter")
        set udg_buttons01[9]= GetLastCreatedButtonBJ()
    
        //heroes
        call DialogSetMessageBJ(HeroModeDialog,"Hero Options")
    
        call DialogAddButtonBJ(HeroModeDialog,"Pick Hero (Recommended)")
        set udg_buttons01[15]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(HeroModeDialog,"Draft Hero")
        set udg_buttons01[23]= GetLastCreatedButtonBJ()

        call DialogAddButtonBJ(HeroModeDialog,"Random Hero")
        set udg_buttons01[16]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(HeroModeDialog,"Doesn't Matter")
        set udg_buttons01[17]= GetLastCreatedButtonBJ()
    
        //income
        call DialogSetMessageBJ(IncomeModeDialog,"Creep Upgrade Options")
    
        call DialogAddButtonBJ(IncomeModeDialog,"Global")
        set udg_buttons01[19]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(IncomeModeDialog,"Individual (Recommended)")
        set udg_buttons01[20]= GetLastCreatedButtonBJ()

        call DialogAddButtonBJ(IncomeModeDialog,"Auto-Eco (Recommended)")
        set udg_buttons01[10]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(IncomeModeDialog,"Disabled")
        set udg_buttons01[21]= GetLastCreatedButtonBJ()
    
        //betting
        call DialogSetMessageBJ(BettingModeDialog,"Betting Options")
    
        call DialogAddButtonBJ(BettingModeDialog,"Enable: Show votes")
        set udg_buttons01[11]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(BettingModeDialog,"Enable: Hide votes")
        set udg_buttons01[12]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(BettingModeDialog,"Disabled (Recommended)")
        set udg_buttons01[13]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(BettingModeDialog,"Doesn't Matter")
        set udg_buttons01[14]= GetLastCreatedButtonBJ()
    
        call ForForce(GetPlayersAll(),function Trig_Dialog_Initialization_Func047A)
        if(Trig_Dialog_Initialization_Func049001())then
            return
        endif

        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call TriggerSleepAction(25.00)
        if(Trig_Dialog_Initialization_Func054001())then
            return
        endif

        call ForForce(GetPlayersAll(),function Trig_Dialog_Initialization_Func055A)
        if(Trig_Dialog_Initialization_Func056C())then
            call TriggerExecute(udg_trigger77)
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger55 = CreateTrigger()
        call DisableTrigger(udg_trigger55)
        call TriggerAddAction(udg_trigger55,function Trig_Dialog_Initialization_Actions)
    endfunction


endlibrary
