library ToggleDmgTxt initializer init requires DamageEngineHelpers, GetPlayerNames, Command, VotingResults, PvpRoundRobin
    //===========================================================================
    globals
        boolean ShowDmgText = false
    endglobals

    function DamageText takes boolean death returns nothing
        local string colour = "|ccffdde31"
        local string aType = ""
        local string output = ""
        local string dmgType = "|r dealt "
        local string end = "."
        local DuelGame duelGame

        //set colour when dealing magic dmg
        if IsMagicDamage() then
            set colour = "|ccf31d4fd"
        endif

        //death message
        if death then
            set dmgType = "|r killed " + GetPlayerNameColour(GetOwningPlayer(DamageTarget)) + "|r dealing: "
        endif

        //if damage source was an ability
        if DamageSourceAbility != 0 then
            set output = (GetPlayerNameColour(GetOwningPlayer(DamageSource)) + ": " + GetObjectName(DamageSourceAbility) + dmgType + colour + R2S(Damage.index.damage) + "|r dmg" )
        else
            //if damage source is an attack or unknown ability

            if Damage.index.isSpell then
                set aType = aType + "spell"
            endif
    
            if Damage.index.isAttack then
                set aType = aType + "attack"
            endif

            set output = (GetPlayerNameColour(GetOwningPlayer(DamageSource)) + ": " + aType + dmgType + colour + R2S(Damage.index.damage) + "|r dmg" )
        endif

        //debug mode shows handle id to differentiate between multiple units
        if DebugModeEnabled then
            set end = " to " + I2S(GetHandleId(DamageTarget)) + "."
        endif

        //add . or debug text to output
        set output = output + end

        // Display damage messages like normal if it is a non simultaneous duel
        if (SimultaneousDuelMode == 1 or DuelGameList.size() == 1) then // No simultaneous duels or there is only one duel (Only 2 people in game, or odd player duel)
            //if death then show to everyone else show to player with dt enabled
            if death then
                call DisplayTimedTextToForce(GetPlayersAll(), 20, output)
            else
                call BJDebugMsg(output)
            endif
        // Only show messages to the simultaneous duel teams
        else
            set duelGame = DuelGame.getPlayerDuelGame(GetOwningPlayer(DamageSource))
            call DisplayTimedTextToForce(duelGame.team1, 20, output)
            call DisplayTimedTextToForce(duelGame.team2, 20, output)
        endif
    endfunction

    function ToggleDmgTxt takes Args args returns nothing
        if GetTriggerPlayer() == GetLocalPlayer() then
            if ShowDmgText then
                set ShowDmgText = false
                call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccffdde31Disabled damage text|r")
            else
                set ShowDmgText = true
                call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccf61fd31Enabled damage text|r")
            endif
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        call Command.create(CommandHandler.ToggleDmgTxt).name("DamageText").handles("damagetext").handles("dt").help("dt", "Toggles text display for damage taken by your hero. (can lag)")
    endfunction
endlibrary