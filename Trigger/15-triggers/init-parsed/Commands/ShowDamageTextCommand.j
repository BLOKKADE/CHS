scope ToggleDmgTxt initializer init
    //===========================================================================
    globals
        boolean ShowDmgText = false
    endglobals

    function DamageText takes nothing returns nothing
        local string colour = "|ccffdde31"
        local string aType = ""
        if Damage.index.damageType == DAMAGE_TYPE_MAGIC then
            set colour = "|ccf31d4fd"
        endif

        if DamageSourceAbility != 0 then
            call BJDebugMsg(GetPlayerNameColour(GetOwningPlayer(DamageSource)) + ": " + GetObjectName(DamageSourceAbility) + "|r dealt " + colour + R2S(Damage.index.damage) + " dmg|r." )
        else
            
            if Damage.index.isSpell then
                set aType = aType + "spell "
            endif
    
            if Damage.index.isAttack then
                set aType = aType + "attack "
            endif

            call BJDebugMsg(GetPlayerNameColour(GetOwningPlayer(DamageSource)) + ": " + aType + "|rdealt " + colour + R2S(Damage.index.damage) + " dmg|r." )
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