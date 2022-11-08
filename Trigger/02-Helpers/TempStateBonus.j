library TempStateBonus initializer init requires CustomState, NewBonus, Utility

    //Combines the CustomState system and the Newbonus system to temporarily set their states

    
    globals
        /*
        constant integer BONUS_MAGICPOW                 = 1
        constant integer BONUS_MAGICRES                 = 2
        constant integer BONUS_EVASION                  = 3
        constant integer BONUS_BLOCK                    = 4
        constant integer BONUS_LUCK                     = 5
        constant integer BONUS_RUNEPOW                  = 6
        constant integer BONUS_SUMMONPOW                = 7
        constant integer BONUS_PVP                 = 8
        constant integer BONUS_PHYSPOW                  = 9
        constant integer BONUS_MISSCHANCE               = 10
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
        constant integer BONUS_NEGATIVEHPREGEN          = 21
        */
        HashTable TempBonusTable
    endglobals

    function GetTempBonus takes integer id, integer abilId, integer state returns TempBonus
        return TempBonusTable[id][abilId][state]
    endfunction

    struct TempBonus extends array
        unit source
        real bonus
        player p
        boolean enabled
        integer state
        integer sourceId
        integer endTick
        integer startTick
        boolean buffLink
        integer buffId
        integer abilId
        boolean roundEnd

        private method periodic takes nothing returns nothing
            if (not this.roundEnd and T32_Tick > this.endTick) or HasPlayerFinishedLevel(this.source, this.p) or (not UnitAlive(this.source)) or (this.enabled == false) or (this.buffLink and T32_Tick - this.startTick > 16 and GetUnitAbilityLevel(this.source, this.buffId) == 0) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        private method updateState takes nothing returns nothing
            if state < 11 or state == 21 then
                call AddUnitCustomState(this.source, this.state, this.bonus)
            else
                if state < 18 then
                    call AddUnitBonus(this.source, this.state, R2I(this.bonus))
                else
                    call AddUnitBonusReal(this.source, this.state, this.bonus)
                endif
            endif
        endmethod

        method addBuffLink takes integer buffId returns nothing
            set this.buffLink = true
            set this.buffId = buffId
        endmethod

        private method setHashTable takes nothing returns nothing
            if TempBonusTable[this.sourceId][this.abilId] == 0 then
                set TempBonusTable[this.sourceId][this.abilId] = Table.create()
            endif

            set TempBonusTable[this.sourceId][this.abilId][this.state] = this
        endmethod

        static method create takes unit source, integer state, real bonus, real duration, integer abilSource returns thistype
            local thistype this = thistype.setup()

            set this.buffLink = false
            set this.buffId = 0
            set this.enabled = true
            set this.source = source
            set this.bonus = bonus
            set this.state = state
            set this.startTick = T32_Tick
            set this.sourceId = GetHandleId(this.source)
            set this.abilId = abilSource
            set this.p = GetOwningPlayer(source)
            set this.roundEnd = duration == 0.
            call this.setHashTable()

            call this.updateState()
            
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.bonus = 0 - this.bonus
            call this.updateState()
            set TempBonusTable[this.sourceId][this.abilId][this.state] = 0
            set this.source = null
            set this.p = null
            set this.enabled = false
            set this.bonus = 0
            call this.recycle()
        endmethod

        implement Recycle
        implement T32x
    endstruct

    //0 duration = end of round
    function UniqueTempBonus takes unit u, integer state, real bonus, real duration, integer abilId, integer buffLink returns nothing
        local TempBonus tBonus = GetTempBonus(GetHandleId(u), abilId, state)
        if tBonus == 0 or tBonus.enabled == false then
            set tBonus = TempBonus.create(u, state, bonus, duration, abilId)
            if buffLink != 0 then
                call tBonus.addBuffLink(buffLink)
            endif
        elseif tBonus.enabled then
            //call BJDebugMsg("ba dur update")
            set tBonus.endTick = T32_Tick + R2I(duration * 32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set TempBonusTable = HashTable.create()
    endfunction
endlibrary