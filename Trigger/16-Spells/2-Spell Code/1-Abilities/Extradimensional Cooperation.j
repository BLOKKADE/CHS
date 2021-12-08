library ExtradimensionalCooperation requires RandomShit
    globals
        constant string FX_BLINK = "Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl"
        constant string FX_BLINK_TARGET = "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"
    endglobals

    function IsDamageExtradimensional takes unit u returns boolean
        return SpellData[GetHandleId(u)].boolean[5]
    endfunction

    function ResetExtraDimensional takes unit u returns nothing
        set SpellData[GetHandleId(u)].integer[6] = 0
        call UnitRemoveAbility(u, EXTRADIMENSIONAL_COOPERATION_BUFF_ID)
    endfunction

    struct ExtraDimensionalCoop extends array

        real dmg
        real newX
        real newY
        unit target
        unit ssdummy
        unit caster
        boolean magic
        integer endTick

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method periodic takes nothing returns nothing

            if T32_Tick > this.endTick then
                set SpellData[GetHandleId(this.caster)].boolean[5] = true

                if magic then
                    call UnitDamageTarget(this.caster, this.target, this.dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, null)
                else
                    set GLOB_typeDmg = 2
                    call UnitDamageTarget(this.caster, this.target, this.dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, null)
                endif

                set SpellData[GetHandleId(this.caster)].boolean[5] = false
                call ShowUnit(this.ssdummy, false)
                call RemoveUnit(this.ssdummy)
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        static method create takes unit caster, unit target, real damage, boolean magic returns ExtraDimensionalCoop
            local thistype this

            local real targetX = GetUnitX(target)
            local real targetY = GetUnitY(target)
            local real casterX = GetUnitX(caster)
            local real casterY = GetUnitY(caster)
            local real distance = GetRandomReal(100,200)
            local real angle = Deg2Rad(GetRandomReal(0,360))

            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.dmg = damage
            if IsUnitType(caster, UNIT_TYPE_MELEE_ATTACKER) then
                set this.newX = targetX + distance * Cos(angle)
                set this.newY = targetY + distance * Sin(angle)
            else
                set this.newX = casterX + distance * Cos(angle)
                set this.newY = casterY + distance * Sin(angle)
            endif
            set this.target = target
            set this.magic = magic
            set this.caster = caster
            set angle = Atan2(targetY - this.newY, targetX - this.newX)*(180.00 / 3.14159)

            set this.ssdummy = CreateUnit(GetOwningPlayer(caster), 'h00B', this.newX, this.newY, angle)
            call SetUnitVertexColor(this.ssdummy, 100, 100, 150, 100)
            call DestroyEffect(AddSpecialEffect(FX_BLINK, this.newX, this.newY))
            call SetUnitAnimation(this.ssdummy, "attack")
            call UnitApplyTimedLife(this.ssdummy, 'BTLF', 0.3)
            call SetUnitTimeScale(this.ssdummy, 3.)
            set this.endTick = T32_Tick + GetRandomInt(5,15)
            call this.startPeriodic()
            
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.caster = null
            set this.ssdummy = null
            set this.target = null
            set recycleNext = recycle
            set recycle = this
        endmethod

        implement T32x
    endstruct

    function CastExtradimensionalCoop takes unit caster, unit target, real damage, boolean magic returns nothing
        local integer i = SpellData[GetHandleId(caster)].integer[6]
        if i > 0 then
            call ExtraDimensionalCoop.create(caster, target, damage, magic)
            set SpellData[GetHandleId(caster)].integer[6] = i - 1
            if i - 1 == 0 then
                call UnitRemoveAbility(caster, EXTRADIMENSIONAL_COOPERATION_BUFF_ID)
            endif
        endif
    endfunction

    function ExtradimensionalCooperation takes unit caster, integer abilId returns nothing
        local unit u = CreateUnit(GetOwningPlayer(caster), PRIEST_1_UNIT_ID, GetUnitX(caster), GetUnitY(caster), 0)
        call UnitAddAbility(u, 'A08K')
        call IssueTargetOrderById(u, 852101, caster)
        call UnitApplyTimedLife(u,'BTLF', 3) 
        set SpellData[GetHandleId(caster)].integer[6] = SpellData[GetHandleId(caster)].integer[6] + 2 + GetUnitAbilityLevel(caster, abilId)
        //call BJDebugMsg("edc: " + I2S(SpellData[GetHandleId(caster)].integer[6]))
        set u = null
    endfunction
endlibrary