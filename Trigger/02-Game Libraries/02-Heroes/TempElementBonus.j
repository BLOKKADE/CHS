library TempElementBonus initializer init requires CustomState, Utility

    //Combines the CustomelementId system and the Newbonus system to temporarily set their elementIds

    
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
        HashTable TempElementBonusTable
    endglobals

    function GetTempElementBonus takes integer id, integer abilId, integer elementId returns TempElementBonus
        return TempElementBonusTable[id][abilId][elementId]
    endfunction

    struct TempElementBonus extends array
        unit source
        integer bonus
        player p
        boolean enabled
        integer elementId
        integer sourceId
        integer endTick
        integer startTick
        real duration
        boolean buffLink
        integer buffId
        integer abilId
        boolean roundEnd

        private method periodic takes nothing returns nothing
            if ((not this.roundEnd) and T32_Tick > this.endTick) or (this.p != Player(21) and HasPlayerFinishedLevel(this.source, this.p)) or (not UnitAlive(this.source)) or (this.enabled == false) or (this.buffLink and T32_Tick - this.startTick > 16 and GetUnitAbilityLevel(this.source, this.buffId) == 0) then
                //call BJDebugMsg("disable tb")
                call this.destroy()
            endif
        endmethod  

        private method updateElementId takes nothing returns nothing
            //call BJDebugMsg("elementId: " + I2S(this.elementId) +", bonus: " + R2S(this.bonus))
            call AddUnitAbsoluteBonusCount(this.source, this.elementId, this.bonus)
        endmethod

        method activate takes nothing returns thistype
            call this.updateElementId()
            set this.endTick = T32_Tick + R2I(this.duration * 32)
            call this.startPeriodic()
            //call BJDebugMsg("activate tb")
            return this
        endmethod

        method addBuffLink takes integer buffId returns thistype
            set this.buffLink = true
            set this.buffId = buffId

            return this
        endmethod

        private method setHashTable takes nothing returns nothing
            if TempElementBonusTable[this.sourceId][this.abilId] == 0 then
                set TempElementBonusTable[this.sourceId][this.abilId] = Table.create()
            endif

            set TempElementBonusTable[this.sourceId][this.abilId][this.elementId] = this
        endmethod

        // 0 duration = end of round
        static method create takes unit source, integer elementId, integer bonus, real duration, integer abilSource returns thistype
            local thistype this = thistype.setup()

            set this.buffLink = false
            set this.buffId = 0
            set this.enabled = true
            set this.source = source
            set this.bonus = bonus
            set this.elementId = elementId
            set this.startTick = T32_Tick
            set this.sourceId = GetHandleId(this.source)
            set this.abilId = abilSource
            set this.p = GetOwningPlayer(source)
            set this.roundEnd = duration == 0.
            set this.duration = duration
            call this.setHashTable()
            //call BJDebugMsg("create tb")
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.bonus = 0 - this.bonus
            call this.stopPeriodic()
            call this.updateElementId()
            set TempElementBonusTable[this.sourceId][this.abilId][this.elementId] = 0
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
    function UniqueTempElementBonus takes unit u, integer elementId, integer bonus, real duration, integer abilId, integer buffLink returns nothing
        local TempElementBonus tBonus = GetTempElementBonus(GetHandleId(u), abilId, elementId)
        if tBonus == 0 or tBonus.enabled == false then
            set tBonus = TempElementBonus.create(u, elementId, bonus, duration, abilId)
            if buffLink != 0 then
                call tBonus.addBuffLink(buffLink)
            endif
            call tBonus.activate()
        elseif tBonus.enabled then
            //call BJDebugMsg("ba dur update")
            set tBonus.endTick = T32_Tick + R2I(duration * 32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set TempElementBonusTable = HashTable.create()
    endfunction
endlibrary