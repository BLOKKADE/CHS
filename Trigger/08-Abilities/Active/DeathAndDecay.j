library DeathAndDecay requires UnitHelpers, RandomShit, SpellFormula
    struct DndStruct extends array
        unit source
        integer level
        integer pid
        integer tick
        integer endTick
        real x
        real y
        
        private method damage takes nothing returns nothing
            local unit p
            local integer i = 0
            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, this.x, this.y, 300, Player(this.pid), false, Target_Enemy)
            //call BJDebugMsg("sldmg")
            //call BJDebugMsg("dmg: " + I2S(GetSpellValue(50, 10, this.level)) + " grp: " + I2S(BlzGroupGetSize(ENUM_GROUP)))
            loop
                set p = BlzGroupUnitAt(ENUM_GROUP, i)
                exitwhen p == null
                if p != null then
                    set udg_NextDamageAbilitySource = DEATH_AND_DECAY_ABILITY_ID
                    call Damage.applyMagic(this.source, p, BlzGetUnitMaxHP(p) * (0.01 * this.level), DAMAGE_TYPE_MAGIC)
                endif
                set i = i + 1
            endloop
        endmethod
    

        private method periodic takes nothing returns nothing
            if T32_Tick > this.tick and (not HasPlayerFinishedLevel(this.source, Player(pid))) then
                set this.tick = T32_Tick + 32
                call this.damage()
            endif
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source, real x, real y, integer level returns thistype
            local thistype this = thistype.setup()
           // call BJDebugMsg("sl start")
            set this.source = source
            set this.endTick = T32_Tick + (12 * 32)
            set this.tick = T32_Tick + 32
            set this.level = level
            set this.x = x
            set this.y = y
            set this.pid = GetPlayerId(GetOwningPlayer(this.source))
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.source = null
            //call BJDebugMsg("sl end")
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    function CastDeathAndDecay takes unit caster, real x, real y, integer level returns nothing
        call DndStruct.create(caster, x, y, level)
    endfunction
endlibrary