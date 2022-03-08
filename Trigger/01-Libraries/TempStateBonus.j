library TempStateBonus requires CustomState, NewBonus

    //Combines the CustomState system and the Newbonus system to temporarily set their states

    /*
    globals
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
    endglobals
    */

    function GetTempBonus takes integer id returns TempBonus
        return id
    endfunction

    struct TempBonus extends array
        unit source
        real bonus
        boolean stop
        integer state
        integer endTick
        integer startTick
        boolean buffLink
        integer buffId

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or (not UnitAlive(this.source)) or this.stop or (this.buffLink and T32_Tick - this.startTick > 16 and GetUnitAbilityLevel(this.source, this.buffId) == 0) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        private method updateState takes nothing returns nothing
            if state < 11 then
                call SaveReal(HT_unitstate, GetHandleId(this.source), this.state, LoadReal(HT_unitstate, GetHandleId(this.source), this.state) + this.bonus)
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

        static method create takes unit source, integer state, real bonus, real duration returns thistype
            local thistype this = thistype.setup()

            set this.buffLink = false
            set this.buffId = 0
            set this.stop = false
            set this.source = source
            set this.bonus = bonus
            set this.state = state
            set this.startTick = T32_Tick

            call this.updateState()
            
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.bonus = 0 - this.bonus
            call this.updateState()
            set this.source = null
            set this.stop = true
            set this.bonus = 0
            call this.recycle()
        endmethod

        implement Recycle
        implement T32x
    endstruct
endlibrary