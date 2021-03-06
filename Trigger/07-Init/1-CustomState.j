library CustomState requires TimerUtils
    globals
        hashtable HT_unitstate = InitHashtable()

        constant integer BONUS_MAGICPOW                 = 1
        constant integer BONUS_MAGICRES                 = 2
        constant integer BONUS_EVASION                  = 3
        constant integer BONUS_BLOCK                    = 4
        constant integer BONUS_LUCK                     = 5
        constant integer BONUS_RUNEPOW                  = 6
        constant integer BONUS_SUMMONPOW                = 7
        constant integer BONUS_PVPBONUS                 = 8
        constant integer BONUS_PHYSPOW                  = 9
        constant integer BONUS_MISSCHANCE               = 10
    endglobals

    //Magic damage
    function SetUnitMagicDmg takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),1,r)
    endfunction

    function GetUnitMagicDmg takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),1)
    endfunction

    function AddUnitMagicDmg takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),1,LoadReal(HT_unitstate,GetHandleId(u),1)+ r)
    endfunction

    //Magic resistance
    function SetUnitMagicDef takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),2,r)
    endfunction

    function GetUnitMagicDef takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),2)
    endfunction

    function AddUnitMagicDef takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),2,LoadReal(HT_unitstate,GetHandleId(u),2)+ r)
    endfunction

    //Evasion
    function SetUnitEvasion takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),3,r)
    endfunction

    function AddUnitEvasion takes unit u,real r returns nothing
        set r = LoadReal(HT_unitstate,GetHandleId(u),3)+ r
        call SaveReal(HT_unitstate,GetHandleId(u),3,r)    
    endfunction

    function GetUnitEvasion takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),3)
    endfunction

    function GetUnitRealEvade takes unit u returns real
        return  1 - (50 /(50 + LoadReal(HT_unitstate,GetHandleId(u),3))) 
    endfunction

    //Miss Chance
    function SetUnitMissChance takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),10,r)
    endfunction

    function AddUnitMissChance takes unit u,real r returns nothing
        set r = LoadReal(HT_unitstate,GetHandleId(u),10)+ r
        call SaveReal(HT_unitstate,GetHandleId(u),10,r)    
    endfunction

    function GetUnitMissChance takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),10)
    endfunction

    //Block
    function SetUnitBlock takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),4,r)
    endfunction

    function GetUnitBlock takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),4)
    endfunction

    function AddUnitBlock takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),4,LoadReal(HT_unitstate,GetHandleId(u),4)+ r)
    endfunction

    //Luck
    function SetUnitLuck takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),5, 1)
    endfunction

    //function GetUnitLuck takes unit u returns real
    //    return LoadReal(HT_unitstate,GetHandleId(u),5)+1
    //endfunction

    function AddUnitLuck takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),5,LoadReal(HT_unitstate,GetHandleId(u),5)+ r)
    endfunction

    //rune Power
    function SetUnitPowerRune takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),6,r)
    endfunction

    //function GetUnitPowerRune takes unit u returns real
    //    return LoadReal(HT_unitstate,GetHandleId(u),6)
    //endfunction

    function AddUnitPowerRune takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),6,LoadReal(HT_unitstate,GetHandleId(u),6)+ r)
    endfunction

    //Summon Power
    function SetUnitSummonStronger takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),7,r)
    endfunction

    function GetUnitSummonStronger takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),7)
    endfunction

    function AddUnitSummonStronger takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),7,LoadReal(HT_unitstate,GetHandleId(u),7)+ r)
    endfunction

    //Pvp Bonus
    function SetUnitPvpBonus takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),8,r)
    endfunction

    function GetUnitPvpBonus takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),8)
    endfunction

    function AddUnitPvpBonus takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),8,LoadReal(HT_unitstate,GetHandleId(u),8)+ r)
    endfunction

    //Physical power
    function SetUnitPhysPow takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),9,r)
    endfunction

    function GetUnitPhysPow takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),9)
    endfunction

    function AddUnitPhysPow takes unit u,real r returns nothing
        call SaveReal(HT_unitstate,GetHandleId(u),9,LoadReal(HT_unitstate,GetHandleId(u),9)+ r)
    endfunction

    //Absolute limit
    function GetHeroMaxAbsoluteAbility takes unit u returns integer
        return LoadInteger(HT,GetHandleId(u),- 8852352)
    endfunction

    function AddHeroMaxAbsoluteAbility takes unit u returns boolean 
        if GetHeroMaxAbsoluteAbility(u) < 10 then

            call SaveInteger(HT,GetHandleId(u),- 8852352,LoadInteger(HT,GetHandleId(u),- 8852352)+ 1)
            call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,("|cffffcc00An extra Absolute Ability slot is available."))
            return true
        else
            return false

        endif
    endfunction
endlibrary
