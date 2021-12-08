library ChannelOrder initializer FreeInitChannel
    globals 
        string array OrderString
        hashtable HTInfoSpell = InitHashtable()
    endglobals


    function FreeInitChannel takes nothing returns nothing

        set OrderString[0] = "slow" // random ability
        set OrderString[1] = "slowon"
        set OrderString[2] = "slowoff"
        set OrderString[3] = "magicundefense"
        set OrderString[4] = "magicdefense"
        set OrderString[5] = "heal"
        set OrderString[6] = "healon"
        set OrderString[7] = "healoff"   
        set OrderString[8] = "controlmagic"
        set OrderString[9] = "invisibility"
        set OrderString[10] = "magicleash"
        set OrderString[11] = "spellsteal"
        set OrderString[12] = "spellstealon"
        set OrderString[13] = "spellstealoff"
        set OrderString[14] = "polymorph"
        set OrderString[15] = "militia"
        set OrderString[16] = "militiaoff"
        set OrderString[17] = "dispel"
        set OrderString[18] = "etherealform"
        set OrderString[19] = "unetherealform"
        set OrderString[20] = "battlestations"
        set OrderString[21] = "unstableconcoction"
        set OrderString[22] = "unstableconcoctionon"
        set OrderString[23] = "unstableconcoctionoff"
        set OrderString[24] = "corporealform"
        set OrderString[25] = "uncorporealform"
        set OrderString[26] = "devour"
        set OrderString[27] = "purge"
        set OrderString[28] = "evileye"
        set OrderString[29] = "resurrection"
        set OrderString[30] = "massteleport"
        set OrderString[31] = "defend"
        set OrderString[32] = "undefend"
        set OrderString[33] = "farsight"
        set OrderString[34] = "earthquake"
        set OrderString[35] = "recharge"
        set OrderString[36] = "replenish"
        set OrderString[37] = "unloadcorpse"
        set OrderString[38] = "harvest"
        set OrderString[39] = "sacrifice"
        
        // InitSpellChanell
        call SaveInteger(HT,CYCLONE_ABILITY_ID,4,1)
        
        
    endfunction


    function SetChanellOrder takes unit u, integer i,integer id returns nothing
        local integer lvl = 0 
        if LoadInteger(HT,i,4) == 1 then

            call BlzSetAbilityStringLevelField(BlzGetUnitAbility(u,i),ABILITY_SLF_BASE_ORDER_ID_NCL6,lvl,OrderString[id])
        
        endif
    endfunction
endlibrary