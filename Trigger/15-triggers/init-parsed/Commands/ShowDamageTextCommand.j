scope ToggleDmgTxt initializer init
    //===========================================================================
    globals
        boolean ShowDmgText = false
    endglobals

    function DamageText takes boolean death returns nothing
        local string colour = "|ccffdde31"
        local string aType = ""
        local string output = ""
        local string dmgType = "|r dealt "

        if IsMagicDamage() then
            set colour = "|ccf31d4fd"
        endif

        if death then
            set dmgType = "|r killed " + GetPlayerNameColour(GetOwningPlayer(DamageTarget)) + "|r dealing: "
        endif

        if DamageSourceAbility != 0 then
            set output = (GetPlayerNameColour(GetOwningPlayer(DamageSource)) + ": " + GetObjectName(DamageSourceAbility) + dmgType + colour + R2S(Damage.index.damage) + "|r dmg." )
        else
            
            if Damage.index.isSpell then
                set aType = aType + "spell"
            endif
    
            if Damage.index.isAttack then
                set aType = aType + "attack"
            endif

            set output = (GetPlayerNameColour(GetOwningPlayer(DamageSource)) + ": " + aType + dmgType + colour + R2S(Damage.index.damage) + "|r dmg." )
        endif

        if death then
            call DisplayTimedTextToForce(GetPlayersAll(), 20, output)
        else
            call BJDebugMsg(output)
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
endscope