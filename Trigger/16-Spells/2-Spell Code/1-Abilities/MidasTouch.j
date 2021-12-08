library MidasTouch initializer init requires DummyOrder

    globals
        Table MidasTouchGold
        Table MidasTouchCasts
        Table MidasTouchLastCast
        private real MidasBonus = 0.5
    endglobals

    function GetMidasTouch takes integer id returns MidasTouch
        return MidasTouchGold[id]
    endfunction
    
    struct MidasTouch extends array
        unit target
        boolean stop
        integer bonus
        integer hpBonus
        real armorBonus
        real blockBonus
        real magicDefBonus
        real magicDmgBonus
        integer dmgBonus
        integer endTick

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        method updateStats takes boolean negative returns nothing
            local real multiplier = 1
            if negative then
                set multiplier = - 1
            endif
            call BlzSetUnitMaxHP(this.target, BlzGetUnitMaxHP(this.target) + R2I(this.hpBonus * multiplier)) 
            call BlzSetUnitArmor(this.target, BlzGetUnitArmor(this.target) + (this.armorBonus * multiplier))
            call SetUnitBlock(this.target, GetUnitBlock(this.target) + (this.blockBonus * multiplier))
            call SetUnitMagicDef(this.target, GetUnitMagicDef(this.target) + (this.magicDefBonus * multiplier))
            call SetUnitMagicDmg(this.target, GetUnitMagicDmg(this.target) + (this.magicDmgBonus * multiplier))
            call BlzSetUnitBaseDamage(this.target, BlzGetUnitBaseDamage(this.target, 0) + R2I(this.dmgBonus * multiplier), 0)
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or this.stop or SuddenDeathEnabled then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        static method create takes unit target, integer bonus, real duration returns thistype
            local thistype this

            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.target = target
            set this.bonus = bonus
            //call BJDebugMsg("gold: " + R2S(bonus))
            set this.stop = false
            set this.endTick = T32_Tick + R2I(duration * 32)
            set this.hpBonus = R2I(BlzGetUnitMaxHP(this.target) * MidasBonus)
            //call BJDebugMsg("hp: +" + I2S(this.hpBonus))
            set this.armorBonus = BlzGetUnitArmor(this.target) * MidasBonus
            //call BJDebugMsg("armor: +" + R2S(this.armorBonus))
            set this.blockBonus = GetUnitBlock(this.target) * MidasBonus
            //call BJDebugMsg("block: +" + R2S(this.blockBonus))
            set this.magicDefBonus = GetUnitMagicDef(this.target) * MidasBonus
            //call BJDebugMsg("magicdef: +"  + R2S(this.magicDefBonus))
            set this.magicDmgBonus = GetUnitMagicDmg(this.target) * MidasBonus
            //call BJDebugMsg("magicdmg: +" + R2S(this.magicDmgBonus))
            set this.dmgBonus = R2I(BlzGetUnitBaseDamage(this.target, 0) * MidasBonus)
            //call BJDebugMsg("dmg: +" + I2S(this.dmgBonus))
            call this.updateStats(false)
            call CalculateNewCurrentHP(this.target, this.hpBonus)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set MidasTouchGold[GetHandleId(this.target)] = 0
            call this.updateStats(true)
            set this.target = null  
            set recycleNext = recycle
            set recycle = this
        endmethod

        implement T32x
    endstruct

    function CastMidasTouch takes unit caster, unit target, integer level returns nothing
        local integer uhid = GetHandleId(caster)
        local integer hid = GetHandleId(target)
        local real abilPower = ((GetUnitAbilityLevel(caster, PILLAGE_ABILITY_ID) + GetUnitAbilityLevel(caster, LEARNABILITY_ABILITY_ID) + GetUnitAbilityLevel(caster, HOLY_ENLIGHTENMENT_ABILITY_ID)) * 2)
        local real power = RMaxBJ((100 - abilPower) / 100, 0)
        local integer bonus = R2I((499 + (26 * level)) * power)
        local integer i = MidasTouchCasts[uhid]
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 6)
        
        if MidasTouchLastCast[uhid] != udg_integer02 then
            set MidasTouchCasts[uhid] = 0
            set i = 0
            set MidasTouchLastCast[uhid] = udg_integer02
        endif
        set MidasTouchCasts[uhid] = MidasTouchCasts[uhid] + 1

        call dummy.addActiveAbility('A0A3', 1, 852662)
        call dummy.target(target)
        call dummy.activate()

        loop
            exitwhen i <= 0
            set bonus = R2I(bonus * 0.9)
            set i = i - 1 
        endloop
        
        if GetMidasTouch(hid) == 0 then
            //call BJDebugMsg("midas power:" + R2S(power) + " abilpower: " + R2S(abilPower) +" gold: " + I2S((499 + (26 * level))) + " total: " + I2S(R2I((499 + (26 * level)) * power)))
            set MidasTouchGold[hid] = MidasTouch.create(target, bonus, 10.5)
        else
            set GetMidasTouch(hid).endTick = T32_Tick + R2I(10.5 * 32)
        endif
        //call BJDebugMsg("dh: " + I2S(DousingHexChance.integer[GetHandleId(target)]))
    endfunction

    private function init takes nothing returns nothing
        set MidasTouchGold = Table.create()
        set MidasTouchCasts = Table.create()
        set MidasTouchLastCast = Table.create()
    endfunction
endlibrary