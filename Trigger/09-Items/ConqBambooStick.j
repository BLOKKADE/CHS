library ConqBambooStick initializer init requires CustomState, Utility

    globals
        HashTable ConqBambStickLightning
        HashTable ConqBambStick
        Table ConqBambStickStruct
    endglobals

    function BambooImmuneActive takes integer sourceId, integer enemyId returns boolean
        return ConqBambStick[sourceId].boolean[enemyId]
    endfunction

    function GetLightning takes integer hid, integer enemyHid returns Lightning
        return ConqBambStickLightning[hid].integer[enemyHid]
    endfunction

    function GetConqBambStickStruct takes integer id returns ConqBambStickS
        return ConqBambStickStruct[id]
    endfunction

    struct ConqBambStickS extends array
        unit source
        integer hid
        integer tick
        integer endTick

        private method reset takes nothing returns nothing
            local integer i = 0
            local unit enemyHero
            local integer enemyHid

            //call BJDebugMsg(GetUnitName(this.source) + " reset")
            loop
                set enemyHero = PlayerHeroes[i]
                if enemyHero != null and enemyHero != this.source then
                    set enemyHid = GetHandleId(enemyHero)
                    set ConqBambStick[this.hid].boolean[enemyHid] = false
                    /*if GetLightning(this.hid, enemyHid) != 0 then
                        call GetLightning(this.hid, enemyHid).remove()
                    endif
                    set ConqBambStickLightning[this.hid].integer[enemyHid] = 0**/
                endif
                set i = i + 1
                exitwhen i == 20
            endloop

            set enemyHero = null
        endmethod

        private method setVulnerable takes unit enemyHero, integer enemyHid returns nothing
            //call BJDebugMsg(GetUnitName(this.source) + " set vul: " + GetUnitName(enemyHero))
            set ConqBambStick[this.hid].boolean[enemyHid] = false
            /*if GetLightning(this.hid, enemyHid) == 0 then
                set ConqBambStickLightning[this.hid].integer[enemyHid] = Lightning.unitToUnit(this.source, enemyHero, 0., 0., false, 0., "SPLK", 0)
            endif*/
        endmethod

        private method setImmune takes unit enemyHero, integer enemyHid returns nothing
            //call BJDebugMsg(GetUnitName(this.source) + " set immune: " + GetUnitName(enemyHero))
            set ConqBambStick[this.hid].boolean[enemyHid] = true
            /*if GetLightning(this.hid, enemyHid) != 0 then
                call GetLightning(this.hid, enemyHid).remove()
            endif*/
        endmethod

        private method search takes nothing returns nothing
            local integer i = 0
            local unit enemyHero
            local integer enemyHid
            
            loop
                set enemyHero = PlayerHeroes[i]
                if enemyHero != null and enemyHero != this.source then
                    set enemyHid = GetHandleId(enemyHero)
                    if DistanceBetweenUnits(this.source, enemyHero) > 400 then
                        if not ConqBambStick[this.hid].boolean[enemyHid] then
                            call this.setImmune(enemyHero, enemyHid)
                        endif
                    else
                        if ConqBambStick[this.hid].boolean[enemyHid] then
                            call this.setVulnerable(enemyHero, enemyHid)
                        endif
                    endif
                endif
                set i = i + 1
                exitwhen i == 20
            endloop

            set enemyHero = null
        endmethod

        private method periodic takes nothing returns nothing
            set this.tick = this.tick + 1 
            if tick > 16 then
                set this.tick = 0
                call this.search()
            endif
            if T32_Tick > this.endTick or GetUnitAbilityLevel(this.source, CONQ_BAMBOO_STICK_BUFF_ID) == 0 or HasPlayerFinishedLevel(this.source, GetOwningPlayer(this.source)) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source returns thistype
            local thistype this = thistype.setup()
            set this.source = source
            set this.hid = GetHandleId(this.source)
            set this.tick = 0
            //call BJDebugMsg("conq s a")
            call this.reset()
            call UnitAddAbility(this.source, CONQ_BAMBOO_STICK_SUMMON_ABILITY_ID)

            set this.endTick = T32_Tick + R2I(10 * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set ConqBambStickStruct[this.hid] = 0
            call this.reset()
            call UnitRemoveAbility(this.source, CONQ_BAMBOO_STICK_SUMMON_ABILITY_ID)
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function CastConqBambooStick takes unit u returns nothing
        //call BJDebugMsg("conq a")
        if GetConqBambStickStruct(GetHandleId(u)) == 0 then
            //call BJDebugMsg("conq aa")
            set ConqBambStickStruct[GetHandleId(u)] = ConqBambStickS.create(u)
        else
            //call BJDebugMsg("conq ab")
            set GetConqBambStickStruct(GetHandleId(u)).endTick = T32_Tick + R2I(10 * 32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set ConqBambStickStruct = Table.create()
        set ConqBambStick = HashTable.create()
        set ConqBambStickLightning = HashTable.create()
    endfunction
endlibrary