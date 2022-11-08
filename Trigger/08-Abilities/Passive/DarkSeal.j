library DarkSeal initializer init requires CustomEvent

    struct DarkSeal
        integer Str = 0
        integer Agi = 0
        integer Int = 0
        integer Hp = 0 


        public method Execute takes unit u, integer i1 returns DarkSeal
            local integer i2 = GetHeroStr(u, false)
            local real r1 = 0

            set i2 = i2 - i1
            set i1 = GetHeroStr(u, false) - i2
            set this.Str = this.Str + i1
            set r1 = GetUnitState(u, UNIT_STATE_LIFE)
            call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 26* i1)
            set this.Hp = this.Hp + 26*i1
            call SetHeroStr(u, i2, false)
            call SetUnitState(u, UNIT_STATE_LIFE,   r1)

            set i2 = GetHeroAgi(u, false)
            set i2 = i2 - i1
            set this.Agi = this.Agi + GetHeroAgi(u, false) - i2
            call SetHeroAgi(u, i2, false)

            set i2 = GetHeroInt(u, false)
            set i2 = i2 - i1
            set this.Int = this.Int + GetHeroInt(u, false) - i2
            call SetHeroInt(u, i2, false)

            return this
        endmethod
    endstruct


    private function End takes nothing returns boolean
        local customEvent e = GetTriggerCustomEvent(GetTriggeringTrigger())
        local unit u = e.EventUnit
        local DarkSeal ds = LoadInteger(HT,GetHandleId(u), DARK_SEAL_ABILITY_ID)
        if ds != 0 then
            call SetHeroStr(u, GetHeroStr(u, false) + ds.Str, false)
            call SetHeroAgi(u, GetHeroAgi(u, false) + ds.Agi, false)
            call SetHeroInt(u, GetHeroInt(u, false) + ds.Int, false)
            call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) - ds.Hp)
            set ds.Str = 0
            set ds.Agi = 0
            set ds.Int = 0
            set ds.Hp = 0
        endif

        set u = null
        return false
    endfunction


    private function init takes nothing returns nothing
        call EventSubscriber(CUSTOM_EVENT_FIX_START_ROUND, function End)
        call EventSubscriber(CUSTOM_EVENT_COMPLETE_LEVEL, function End)
    endfunction

endlibrary