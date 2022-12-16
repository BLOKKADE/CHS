library CustomState initializer init requires TimerUtils
    globals
        hashtable HT_unitstate = InitHashtable()
        HashTable CustomUnitState

        constant integer BONUS_MAGICPOW                 = 1
        constant integer BONUS_MAGICRES                 = 2
        constant integer BONUS_EVASION                  = 3
        constant integer BONUS_BLOCK                    = 4
        constant integer BONUS_LUCK                     = 5
        constant integer BONUS_RUNEPOW                  = 6
        constant integer BONUS_SUMMONPOW                = 7
        constant integer BONUS_PVP                      = 8
        constant integer BONUS_PHYSPOW                  = 9
        constant integer BONUS_MISSCHANCE               = 10
        //11-20 are in NewBonus.j
        /*
        DO NOT USE WITH the UNITCUSTOMSTATE functions
        constant integer BONUS_DAMAGE                   = 11
        constant integer BONUS_ARMOR                    = 12
        constant integer BONUS_AGILITY                  = 13
        constant integer BONUS_STRENGTH                 = 14
        constant integer BONUS_INTELLIGENCE             = 15
        constant integer BONUS_HEALTH                   = 16
        constant integer BONUS_MANA                     = 17
        constant integer BONUS_HEALTHREGEN              = 18
        constant integer BONUS_MANAREGEN                = 19
        constant integer BONUS_ATTACKSPEED              = 20
        */
        constant integer BONUS_NEGATIVEHPREGEN          = 21
        constant integer BONUS_GLORYREGEN               = 22
    endglobals

    function SetUnitCustomState takes unit u, integer stat, real value returns nothing
        set CustomUnitState[GetHandleId(u)].real[stat] = value
    endfunction

    function GetUnitCustomState takes unit u, integer stat returns real
        return CustomUnitState[GetHandleId(u)].real[stat]
    endfunction

    function AddUnitCustomState takes unit u, integer stat, real value returns nothing
        set CustomUnitState[GetHandleId(u)].real[stat] = GetUnitCustomState(u, stat) + value
    endfunction

    //Absolute count bonus 100-149
    function SetUnitAbsoluteBonusCount takes unit u,integer id, integer i returns nothing
        call SaveInteger(HT_unitstate,GetHandleId(u),100+id,i)
    endfunction
    
    function GetUnitAbsoluteBonusCount takes unit u, integer id returns integer
        return LoadInteger(HT_unitstate,GetHandleId(u),100+id)
     endfunction

     function AddUnitAbsoluteBonusCount takes unit u, integer id, integer i returns nothing
         call SaveInteger(HT_unitstate,GetHandleId(u),100+id,LoadInteger(HT_unitstate,GetHandleId(u),100+id)+ i)
     endfunction

    function ResetUnitCustomState takes unit u returns nothing
        call CustomUnitState.remove(GetHandleId(u))
    endfunction

    private function init takes nothing returns nothing
        set CustomUnitState = HashTable.create()
    endfunction
endlibrary
