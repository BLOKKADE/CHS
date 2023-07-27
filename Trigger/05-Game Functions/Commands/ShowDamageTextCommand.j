library ToggleDmgTxt initializer init requires DamageEngineHelpers, GetPlayerNames, Command, VotingResults, PvpRoundRobin
    //===========================================================================
    globals
        Table ShowDmgText
        Table ShowDmgTextAt
    endglobals

    function ShowOtherDamageText takes unit source, unit target, real value, string damageType returns string
        local string output = ""

        set output = (GetPlayerNameColour(GetOwningPlayer(source)) + ": " + damageType + "|r dealt " + R2S(value) + "|r dmg to " + GetPlayerNameColour(GetOwningPlayer(target)) + "|r")
    
        //debug mode shows handle id to differentiate between multiple units
        if DebugModeEnabled then
            set output = output + " id: " + I2S(GetHandleId(DamageTarget))
        endif
        
        return output
    endfunction

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

        //if damage source is a summon
        if SUMMONS.contains(DamageSourceTypeId) then
            set aType = aType + GetObjectName(DamageSourceTypeId) + " "
        endif

        if Damage.index.isSpell then
            set aType = aType + "spell"
        endif

        if Damage.index.isAttack then
            set aType = aType + "attack"
        endif

        //if damage source was an ability
        if DamageSourceAbility != 0 then
            set output = (GetPlayerNameColour(GetOwningPlayer(DamageSource)) + ": " + GetObjectName(DamageSourceAbility) + " " + aType + dmgType + colour + R2S(Damage.index.damage) + "|r dmg" )
        //if damage source is an attack or unknown ability
        else
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

    function ShowLoggingText takes boolean death, string output returns nothing
        local DuelGame duelGame

        if death then
            set duelGame = DuelGame.getPlayerDuelGame(GetOwningPlayer(DamageSource))

            // Display damage messages like normal if it is a non simultaneous duel
            if (SimultaneousDuelMode == 1 or DuelGameList.size() == 1) or BrStarted then // No simultaneous duels or there is only one duel (Only 2 people in game, or odd player duel)
                //if death then show to everyone else show to player with dt enabled
                call DisplayTimedTextToForce(GetPlayersAll(), 20, output)
            else
                // Only show messages to the simultaneous duel teams
                call DisplayTimedTextToForce(duelGame.team1, 20, output)
                call DisplayTimedTextToForce(duelGame.team2, 20, output)
            endif
        else
            if ShowDmgText.boolean[DamageSourcePid] and Damage.index.damage > ShowDmgTextAt.integer[DamageSourcePid] then
                call DisplayTimedTextToPlayer(Player(DamageSourcePid), 0, 0, 20, output)
            endif

            if ShowDmgText.boolean[DamageTargetPid] and Damage.index.damage > ShowDmgTextAt.integer[DamageTargetPid] then
                call DisplayTimedTextToPlayer(Player(DamageTargetPid), 0, 0, 20, output)
            endif
        endif
    endfunction

    //death = true shows for all players
    function ShowDamageText takes boolean death returns nothing
        if (ShowDmgText.boolean[DamageSourcePid] and Damage.index.damage > ShowDmgTextAt.integer[DamageSourcePid]) or (ShowDmgText.boolean[DamageTargetPid] and Damage.index.damage > ShowDmgTextAt.integer[DamageTargetPid]) then
            call ShowLoggingText(death, DamageText(death))
        endif
    endfunction

    function ToggleDmgTxt takes Args args returns nothing
        local integer limit = S2I(args[1])
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if ShowDmgText.boolean[pid] and limit == 0 then
            set ShowDmgText.boolean[pid] = false
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccffdde31Disabled damage text|r")
        else
            set ShowDmgText.boolean[pid] = true
            set ShowDmgTextAt.integer[pid] = limit
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccf61fd31Enabled damage text|r when damage instance is higher than " + I2S(limit))
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        set ShowDmgText = Table.create()
        set ShowDmgTextAt = Table.create()
        call Command.create(CommandHandler.ToggleDmgTxt).name("DamageText").handles("damagetext").handles("dt").help("dt", "Toggles text display for damage taken by your hero. (can lag)")
    endfunction
endlibrary