library trigger81 initializer init requires RandomShit, PetDeath

    function Trig_Hero_Dies_After_Victory_Func008C takes nothing returns boolean
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_After_Victory_Conditions takes nothing returns boolean
        if(not Trig_Hero_Dies_After_Victory_Func008C())then
            return false
        endif
        return true
    endfunction

    //removes all of the players units
    function Trig_Hero_Dies_After_Victory_Func004A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Hero_Dies_After_Victory_Func007C takes nothing returns boolean
        if(not(PlayerCount==0))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_After_Victory_Func007Func006C takes nothing returns boolean
        if(not(InitialPlayerCount > 1))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_After_Victory_Func007Func007A takes nothing returns nothing
        call CustomDefeatBJ(GetEnumPlayer(),"Defeat!")
    endfunction


    function Trig_Hero_Dies_After_Victory_Actions takes nothing returns nothing
        set PlayerCount =(PlayerCount - 1)
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit()))+(" |cffffcc00has fallen at level " +(I2S(RoundNumber)+ "!|r")))))
        call DisableTrigger(HeroPassivePetDeathTrigger)
        call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_After_Victory_Func004A)
        call EnableTrigger(HeroPassivePetDeathTrigger)
        if(Trig_Hero_Dies_After_Victory_Func007C())then
            call DisableTrigger(udg_trigger116)
            call DisableTrigger(GetTriggeringTrigger())
            call DisableTrigger(PlayerCompleteRoundTrigger)
            call TriggerSleepAction(2)
            if(Trig_Hero_Dies_After_Victory_Func007Func006C())then
                call CustomVictoryBJ(SingleplayerPlayer,true,true)
            else
                call CustomDefeatBJ(SingleplayerPlayer,"Defeat!")
            endif
            call ForForce(DefeatedPlayers,function Trig_Hero_Dies_After_Victory_Func007Func007A)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set HeroDiesInRoundTrigger = CreateTrigger()
        call DisableTrigger(HeroDiesInRoundTrigger)
        call TriggerRegisterAnyUnitEventBJ(HeroDiesInRoundTrigger,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(HeroDiesInRoundTrigger,Condition(function Trig_Hero_Dies_After_Victory_Conditions))
        call TriggerAddAction(HeroDiesInRoundTrigger,function Trig_Hero_Dies_After_Victory_Actions)
    endfunction


endlibrary
