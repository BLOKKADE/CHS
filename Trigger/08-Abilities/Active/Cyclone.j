library Cyclone requires AreaDamage, KnockbackHelper, AllowCasting
    struct CycloneStruct extends array
        unit source
        integer damageTick
        integer pullTick
        integer endTick
        integer pid
        real damage
        effect fx
        effect auraFx
        real x
        real y

        private method periodic takes nothing returns nothing
                if T32_Tick > this.damageTick then
                    set this.damageTick = T32_Tick + 6
                    call AreaDamage(this.source, this.x, this.y, this.damage, 350, false, CYCLONE_ABILITY_ID, true, false)
                endif
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, Player(this.pid)) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source, real x, real y, integer level returns thistype
            local thistype this = thistype.setup()
           // call BJDebugMsg("sl start")
            set this.source = source
            set this.endTick = T32_Tick + (10 * 32)
            set this.damageTick = T32_Tick + 11
            set this.pullTick = T32_Tick + (3 * 32)
            set this.pid = GetPlayerId(GetOwningPlayer(this.source))
            set this.x = x
            set this.y = y
            set this.damage = level * 15 + (GetHeroLevel(PlayerHeroes[this.pid]) * (level - 1))
            set this.fx = AddLocalizedSpecialEffect("Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl", this.x, this.y)
            set this.auraFx = AddLocalizedSpecialEffect("war3mapImported\\TornadoAura_noTC.mdx", this.x, this.y)
            call BlzSetSpecialEffectScale(this.auraFx, 2.5)

            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.source = null
            //call BJDebugMsg("sl end")
            call DestroyEffect(this.fx)
            call DestroyEffect(this.auraFx)
            set this.auraFx = null
            set this.fx = null
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    function Cyclone takes unit caster, real targetX, real targetY, integer level returns nothing
        call CycloneStruct.create(caster, targetX, targetY, level)
    endfunction
endlibrary