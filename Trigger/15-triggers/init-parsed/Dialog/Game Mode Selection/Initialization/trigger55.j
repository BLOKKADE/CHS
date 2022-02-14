library trigger55 initializer init requires RandomShit

    function Trig_Dialog_Initialization_Func047Func001C takes nothing returns boolean
        if(not(udg_integer13 > 1))then
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
                call DialogDisplayBJ(true,udg_dialog02,GetEnumPlayer())
            else
                call DialogDisplayBJ(true,udg_dialog02,udg_player03)
            endif
        else
            call DialogDisplayBJ(true,udg_dialog03,GetEnumPlayer())
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
        call DialogDisplayBJ(false,udg_dialog01,GetEnumPlayer())
        call DialogDisplayBJ(false,IncomeDialog,GetEnumPlayer())
        call DialogDisplayBJ(false,udg_dialog02,GetEnumPlayer())
        call DialogDisplayBJ(false,udg_dialog03,GetEnumPlayer())
        call DialogDisplayBJ(false,udg_dialog07,GetEnumPlayer())
        call DialogDisplayBJ(false,udg_dialog05,GetEnumPlayer())
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
        call DialogSetMessageBJ(udg_dialog01,"Game Duration/Difficulty")
        call DialogAddButtonBJ(udg_dialog01,"Fast/Easy: 25 rounds, 45 min")
        set udg_buttons01[1]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog01,"Long/Medium: 50 rounds, 90 min")
        set udg_buttons01[2]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog01,"Doesn't Matter")
        set udg_buttons01[3]= GetLastCreatedButtonBJ()
    
        //game mode
        call DialogSetMessageBJ(udg_dialog02,"Game Mode")
    
        call DialogAddButtonBJ(udg_dialog02,"Normal (Recommended)")
        set udg_buttons01[4]= GetLastCreatedButtonBJ()	
    
        call DialogAddButtonBJ(udg_dialog02,"Immortal: Easy")
        set udg_buttons01[18]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog02,"Doesn't Matter")
        set udg_buttons01[6]= GetLastCreatedButtonBJ()
    
        //abilities
        call DialogSetMessageBJ(udg_dialog03,"Ability Options")
    
        call DialogAddButtonBJ(udg_dialog03,"Pick Abilities (Recommended)")
        set udg_buttons01[7]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog03,"Random Abilities")
        set udg_buttons01[8]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog03,"Draft Abilities")
        set udg_buttons01[22]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog03,"Doesn't Matter")
        set udg_buttons01[9]= GetLastCreatedButtonBJ()
    
        //heroes
        call DialogSetMessageBJ(udg_dialog07,"Hero Options")
    
        call DialogAddButtonBJ(udg_dialog07,"Pick Hero (Recommended)")
        set udg_buttons01[15]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog07,"Random Hero")
        set udg_buttons01[16]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog07,"Doesn't Matter")
        set udg_buttons01[17]= GetLastCreatedButtonBJ()
    
        //income
        call DialogSetMessageBJ(IncomeDialog,"Creep Upgrade Options")
    
        call DialogAddButtonBJ(IncomeDialog,"Global")
        set udg_buttons01[19]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(IncomeDialog,"Individual (Recommended)")
        set udg_buttons01[20]= GetLastCreatedButtonBJ()

        call DialogAddButtonBJ(IncomeDialog,"Economy")
        set udg_buttons01[10]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(IncomeDialog,"Disabled")
        set udg_buttons01[21]= GetLastCreatedButtonBJ()
    
        //betting
        call DialogSetMessageBJ(udg_dialog05,"Betting Options")
    
        call DialogAddButtonBJ(udg_dialog05,"Enable: Show votes")
        set udg_buttons01[11]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog05,"Enable: Hide votes")
        set udg_buttons01[12]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog05,"Disabled (Recommended)")
        set udg_buttons01[13]= GetLastCreatedButtonBJ()
    
        call DialogAddButtonBJ(udg_dialog05,"Doesn't Matter")
        set udg_buttons01[14]= GetLastCreatedButtonBJ()
    
        call ForForce(GetPlayersAll(),function Trig_Dialog_Initialization_Func047A)
        if(Trig_Dialog_Initialization_Func049001())then
            return
        else
            call DoNothing()
        endif
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Mode Selection")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,30.00)
        call TriggerSleepAction(30.00)
        if(Trig_Dialog_Initialization_Func054001())then
            return
        else
            call DoNothing()
        endif
        call ForForce(GetPlayersAll(),function Trig_Dialog_Initialization_Func055A)
        if(Trig_Dialog_Initialization_Func056C())then
            call TriggerExecute(udg_trigger77)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger55 = CreateTrigger()
        call DisableTrigger(udg_trigger55)
        call TriggerAddAction(udg_trigger55,function Trig_Dialog_Initialization_Actions)
    endfunction


endlibrary
