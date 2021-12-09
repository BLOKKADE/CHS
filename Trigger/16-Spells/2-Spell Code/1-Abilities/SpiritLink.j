library SpiritLink initializer init requires DummyOrder, AbilityDescription, MathRound
    globals
        Table SpiritLinkTable
    endglobals

    private function SpiritLinkFilter takes nothing returns boolean
        return GetUnitAbilityLevel(GetFilterUnit(), SPIRIT_LINK_BUFF_ID) > 0 and UnitAlive(GetFilterUnit()) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') == 0 and BlzIsUnitInvulnerable(GetFilterUnit()) == false
    endfunction

    private function AllUnitsFilter takes nothing returns boolean
        return UnitAlive(GetFilterUnit()) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') == 0 and BlzIsUnitInvulnerable(GetFilterUnit()) == false
    endfunction

    function GetSpiritLinkStruct takes integer id returns SpiritLinkStruct
        return SpiritLinkTable[id]
    endfunction

    struct SpiritLinkStruct extends array
        unit source
        group spiritLinkedUnits
        integer groupSize
        integer level
        real damageReduction
        integer pid
        integer tick
        integer endTick
        boolean enabled
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method updateDescription takes nothing returns nothing
            call UpdateAbilityDescription(GetDesriptionAbility(SPIRIT_LINK_ABILITY_ID, this.level - 1), Player(this.pid), SPIRIT_LINK_ABILITY_ID, "000", R2I((1 - this.damageReduction) * 100), level)
        endmethod

        private method refreshGroup takes nothing returns nothing
            local integer i = 0
            local real oldRed = this.damageReduction

            set this.groupSize = BlzGroupGetSize(this.spiritLinkedUnits)
            set this.level = IMaxBJ(GetUnitAbilityLevel(this.source, SPIRIT_LINK_ABILITY_ID), this.level)
            set this.damageReduction = 1

            //call BJDebugMsg("size: " + I2S(this.groupSize))

            loop
                //call BJDebugMsg("dr: " + R2S(this.damageReduction) + " * " + R2S(1 - (0.03 + (0.001 * this.level))) + " = " + R2S(this.damageReduction * (1 - (0.03 + (0.001 * this.level)))))
                set this.damageReduction = this.damageReduction * (1 - (0.03 + (0.001 * this.level)))
                set i = i + 1
                exitwhen i >= this.groupSize
            endloop

            //set this.damageReduction = this.damageReduction * 0.001

            if this.damageReduction < 0.1 then
                set this.damageReduction = 0.1
            endif

            if oldRed != this.damageReduction then
                call this.updateDescription()
            endif

            //call BJDebugMsg("reduction: " + R2S(this.damageReduction))
        endmethod

        method updateGroup takes nothing returns nothing
            local unit p
            local integer i = 0
            local DummyOrder dummy

            call GroupClear(this.spiritLinkedUnits)
            call GroupEnumUnitsOfPlayer(this.spiritLinkedUnits, Player(this.pid), Condition(function AllUnitsFilter))
            set this.groupSize = BlzGroupGetSize(this.spiritLinkedUnits)

            loop
                set p = BlzGroupUnitAt(this.spiritLinkedUnits, i)
                
                if p != null then
                    set dummy = DummyOrder.create(this.source, GetUnitX(this.source), GetUnitY(this.source), GetUnitFacing(this.source), 1)
                    call dummy.addActiveAbility('A0B2', 1, 852101)
                    call dummy.target(p)
                    call dummy.activate() 
                endif

                set i = i + 1
                exitwhen i > this.groupSize
            endloop

            call this.refreshGroup()

            set p = null
        endmethod
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.tick then
                set this.tick = T32_Tick + 32
                call GroupClear(this.spiritLinkedUnits)
                call GroupEnumUnitsOfPlayer(this.spiritLinkedUnits, Player(this.pid), Condition(function SpiritLinkFilter))
                call this.refreshGroup()
            endif
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 
    
        static method create takes unit source, integer level returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            //call BJDebugMsg("sl start")
            set this.source = source
            set this.spiritLinkedUnits = CreateGroup()
            set this.pid = GetPlayerId(GetOwningPlayer(this.source))
            set this.level = level

            call this.updateGroup()

            set this.enabled = true
            set this.tick = T32_Tick + 32
            set this.endTick = T32_Tick + R2I(15 * 32)   
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.damageReduction = 1
            call this.updateDescription()
            set this.enabled = false
            set SpiritLinkTable[GetHandleId(this.source)] = 0
            set this.source = null
            call DestroyGroup(this.spiritLinkedUnits)
            set this.spiritLinkedUnits = null
            //call BJDebugMsg("sl end")
            //call BJDebugMsg("ms end: " + I2S(this.bonus))
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    function DistributeSpiritLink takes unit hero, real damage returns real
        return damage * GetSpiritLinkStruct(GetHandleId(hero)).damageReduction
    endfunction

    function CastSpiritLink takes unit caster, integer level returns nothing
        local integer hid = GetHandleId(caster)
        if GetSpiritLinkStruct(hid).enabled == false then
            set SpiritLinkTable[hid] = SpiritLinkStruct.create(caster, level)
        elseif GetSpiritLinkStruct(hid).enabled then
            //call BJDebugMsg("sl dur update")
            call GetSpiritLinkStruct(hid).updateGroup()
            set GetSpiritLinkStruct(hid).endTick = T32_Tick + R2I(15 * 32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set SpiritLinkTable = Table.create()
    endfunction
endlibrary