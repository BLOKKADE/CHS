library ToggleDmgTxt initializer init requires DamageEngineHelpers, GetPlayerNames, Command, VotingResults, PvpRoundRobin
    //===========================================================================
    globals
        Table ShowDmgTextIn     // For incoming damage
        Table ShowDmgTextOut    // For outgoing damage
        Table ShowDmgTextInAt   // Threshold for incoming
        Table ShowDmgTextOutAt  // Threshold for outgoing
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
            set output = (GetPlayerNameColour(GetOwningPlayer(DamageSource)) + ": " + GetObjectName(DamageSourceAbility) + " lvl: " + I2S(DamageSourceAbilityLevel) + " " + aType + dmgType + colour + R2S(Damage.index.damage) + "|r dmg" )
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
            // Show outgoing damage to source player
            if ShowDmgTextOut.boolean[DamageSourcePid] and Damage.index.damage > ShowDmgTextOutAt.integer[DamageSourcePid] then
                call DisplayTimedTextToPlayer(Player(DamageSourcePid), 0, 0, 20, output)
            endif
            // Show incoming damage to target player
            if ShowDmgTextIn.boolean[DamageTargetPid] and Damage.index.damage > ShowDmgTextInAt.integer[DamageTargetPid] then
                call DisplayTimedTextToPlayer(Player(DamageTargetPid), 0, 0, 20, output)
            endif
        endif
    endfunction

    //death = true shows for all players
    function ShowDamageText takes boolean death returns nothing
        if (ShowDmgTextOut.boolean[DamageSourcePid] and Damage.index.damage > ShowDmgTextOutAt.integer[DamageSourcePid]) or /*
        */ (ShowDmgTextIn.boolean[DamageTargetPid] and Damage.index.damage > ShowDmgTextInAt.integer[DamageTargetPid]) then
            call ShowLoggingText(death, DamageText(death))
        endif
    endfunction

    function ToggleDmgTxt takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local string cmd = args[0]
        local integer limit = 0
        local player p = GetTriggerPlayer()
        local string incomingStatus
        local string outgoingStatus
        
        if cmd == "dtc" then  // Damage text current command
            // Set incoming status message
            if ShowDmgTextIn.boolean[pid] then
                set incomingStatus = "|ccf61fd31Enabled|r (threshold: " + I2S(ShowDmgTextInAt.integer[pid]) + ")"
            else
                set incomingStatus = "|ccffdde31Disabled|r"
            endif
            // Set outgoing status message
            if ShowDmgTextOut.boolean[pid] then
                set outgoingStatus = "|ccf61fd31Enabled|r (threshold: " + I2S(ShowDmgTextOutAt.integer[pid]) + ")"
            else
                set outgoingStatus = "|ccffdde31Disabled|r"
            endif
            // Display the current settings
            call DisplayTimedTextToPlayer(p, 0, 0, 10, "Current Damage Text Settings:")
            call DisplayTimedTextToPlayer(p, 0, 0, 10, "Incoming: " + incomingStatus)
            call DisplayTimedTextToPlayer(p, 0, 0, 10, "Outgoing: " + outgoingStatus)
        elseif cmd == "dti" or cmd == "dtin" or cmd == "dtt" then  // Incoming damage commands
            if args.length > 1 then
                set limit = S2I(args[1])
            endif
            if ShowDmgTextIn.boolean[pid] and limit == 0 then
                set ShowDmgTextIn.boolean[pid] = false
                call DisplayTimedTextToPlayer(p, 0, 0, 10, "|ccffdde31Disabled incoming damage text|r")
            else
                set ShowDmgTextIn.boolean[pid] = true
                set ShowDmgTextInAt.integer[pid] = limit
                call DisplayTimedTextToPlayer(p, 0, 0, 10, "|ccf61fd31Enabled incoming damage text|r when damage taken > " + I2S(limit))
            endif
        elseif cmd == "dto" or cmd == "dtout" or cmd == "dtd" then  // Outgoing damage commands
            if args.length > 1 then
                set limit = S2I(args[1])
            endif
            if ShowDmgTextOut.boolean[pid] and limit == 0 then
                set ShowDmgTextOut.boolean[pid] = false
                call DisplayTimedTextToPlayer(p, 0, 0, 10, "|ccffdde31Disabled outgoing damage text|r")
            else
                set ShowDmgTextOut.boolean[pid] = true
                set ShowDmgTextOutAt.integer[pid] = limit
                call DisplayTimedTextToPlayer(p, 0, 0, 10, "|ccf61fd31Enabled outgoing damage text|r when damage dealt > " + I2S(limit))
            endif
        else  // dt command enables/disables both
            if args.length > 1 then
                set limit = S2I(args[1])
            endif
            if ShowDmgTextIn.boolean[pid] and ShowDmgTextOut.boolean[pid] and limit == 0 then
                set ShowDmgTextIn.boolean[pid] = false
                set ShowDmgTextOut.boolean[pid] = false
                call DisplayTimedTextToPlayer(p, 0, 0, 10, "|ccffdde31Disabled all damage text|r")
            else
                set ShowDmgTextIn.boolean[pid] = true
                set ShowDmgTextOut.boolean[pid] = true
                set ShowDmgTextInAt.integer[pid] = limit
                set ShowDmgTextOutAt.integer[pid] = limit
                call DisplayTimedTextToPlayer(p, 0, 0, 10, "|ccf61fd31Enabled all damage text|r when damage > " + I2S(limit))
            endif
        endif
        
        set p = null
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        set ShowDmgTextIn = Table.create()
        set ShowDmgTextOut = Table.create()
        set ShowDmgTextInAt = Table.create()
        set ShowDmgTextOutAt = Table.create()
        
        // dt command (toggles both incoming and outgoing)
        call Command.create(CommandHandler.ToggleDmgTxt).name("damagetext").handles("damagetext").handles("dt").help("dt", "Toggles text display for damage dealt and taken by your hero. (can lag). Optional threshold: -dt 1000")
        
        // dti command (toggles incoming damage)
        call Command.create(CommandHandler.ToggleDmgTxt).name("damagetextincoming").handles("dti").handles("dtin").handles("dtt").help("dti", "Toggles text display for damage taken by your hero. (can lag). Optional threshold: -dti 1000")
        
        // dto command (toggles outgoing damage)
        call Command.create(CommandHandler.ToggleDmgTxt).name("damagetextoutgoing").handles("dto").handles("dtout").handles("dtd").help("dto", "Toggles text display for damage dealt by your hero. (can lag). Optional threshold: -dto 1000")
        
        // dtc command (shows current damage text settings)
        call Command.create(CommandHandler.ToggleDmgTxt).name("damagetextcurrent").handles("dtc").help("dtc", "Shows the current damage text settings for incoming and outgoing damage.")
    endfunction
endlibrary