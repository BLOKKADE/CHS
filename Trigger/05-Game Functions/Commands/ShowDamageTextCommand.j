library ToggleDmgTxt initializer init requires DamageEngineHelpers, GetPlayerNames, Command, VotingResults, PvpRoundRobin
    //===========================================================================
    globals
        Table ShowDmgText
    endglobals

    function DamageText takes boolean death returns string
        local string colour = "|ccffdde31"
        local string aType = ""
        local string output = ""
        local string dmgType = "|r dealt "
        local string end = "."

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
        //if damage source is an attack or unknown ability
        else
            //if damage source is a summon
            if SUMMONS.contains(DamageSourceTypeId) then
                set aType = aType + GetObjectName(DamageSource) + " "
            endif

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

        return output
    endfunction

    //death = true shows for all players
    function ShowDamageText takes boolean death returns nothing
        local string output = DamageText(death)
        local DuelGame duelGame

        if death then
            // Display damage messages like normal if it is a non simultaneous duel
            if (SimultaneousDuelMode == 1 or DuelGameList.size() == 1) or BrStarted then // No simultaneous duels or there is only one duel (Only 2 people in game, or odd player duel)
                //if death then show to everyone else show to player with dt enabled
                call DisplayTimedTextToForce(GetPlayersAll(), 20, output)
            else
                // Only show messages to the simultaneous duel teams
                set duelGame = DuelGame.getPlayerDuelGame(GetOwningPlayer(DamageSource))
                call DisplayTimedTextToForce(duelGame.team1, 20, output)
                call DisplayTimedTextToForce(duelGame.team2, 20, output)
            endif
        else
            if ShowDmgText.boolean[DamageSourcePid] then
                call DisplayTimedTextToPlayer(Player(DamageSourcePid), 0, 0, 20, output)
            endif

            if ShowDmgText.boolean[DamageTargetPid] then
                call DisplayTimedTextToPlayer(Player(DamageTargetPid), 0, 0, 20, output)
            endif
        endif
    endfunction

    function ToggleDmgTxt takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if ShowDmgText.boolean[pid] then
            set ShowDmgText.boolean[pid] = false
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccffdde31Disabled damage text|r")
        else
            set ShowDmgText.boolean[pid] = true
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccf61fd31Enabled damage text|r")
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        set ShowDmgText = Table.create()
        call Command.create(CommandHandler.ToggleDmgTxt).name("DamageText").handles("damagetext").handles("dt").help("dt", "Toggles text display for damage taken by your hero. (can lag)")
    endfunction
endlibrary