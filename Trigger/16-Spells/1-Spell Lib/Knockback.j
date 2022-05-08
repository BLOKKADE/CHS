//******************************************************************************
//*                                                                            *
//*                             K N O C K B A C K                              *
//*                                Actual Code                                 *
//*                                   v1.07                                    *
//*                                                                            *
//*                              By: Rising_Dusk                               *
//*                                                                            *
//******************************************************************************

library Knockback initializer Init needs TerrainPathability, GroupUtils, Table, RandomShit
    globals
        //*********************************************************
        //* These are the configuration constants for the system
        //*
        //* EFFECT_ATTACH_POINT:  Where on the unit the effect attaches
        //* EFFECT_PATH_WATER:    What special effect to attach over water
        //* EFFECT_PATH_GROUND:   What special effect to attach over ground
        //* DEST_RADIUS:          Radius around which destructs die
        //* DEST_RADIUS_SQUARED:  Radius squared around which destructs die
        //* ADJACENT_RADIUS:      Radius for knocking back adjacent units
        //* ADJACENT_FACTOR:      Factor for collision speed transfers
        //* TIMER_INTERVAL:       The interval for the timer that gets run
        //* ISSUE_LAST_ORDER:     A boolean to issue last orders or not
        //*
        private constant string         EFFECT_ATTACH_POINT = "origin"
        private constant string         EFFECT_PATH_WATER   = "war3mapImported\\File00000001.mdl"
        private constant string         EFFECT_PATH_GROUND  = "war3mapImported\\File00000326.mdl"
        private constant real           DEST_RADIUS         = 180.
        private constant real           DEST_RADIUS_SQUARED = DEST_RADIUS*DEST_RADIUS
        private constant real           ADJACENT_RADIUS     = 180.
        private constant real           ADJACENT_FACTOR     = 0.75
        private constant real           TIMER_INTERVAL      = 0.05
        private constant boolean        ISSUE_LAST_ORDER    = true
        
        //*********************************************************
        //* These are static constants used by the system and shouldn't be changed
        //*
        //* Timer:                The timer that runs all of the effects for the spell
        //* Counter:              The counter for how many KB instances exist
        //* HitIndex:             Indexes for a given unit's knockback
        //* Knockers:             The array of all struct instances that exist
        //* Entries:              Counters for specific unit instances in system
        //* ToClear:              How many instances to remove on next run
        //* DesBoolexpr:          The check used for finding destructables
        //* AdjBoolexpr:          The check for picking adjacent units to knockback
        //* DestRect:             The rect used to check for destructables
        //*
        private          timer          Timer
        private          integer        Counter             = 0
        private          Table HitIndex
        private          Table Knockers
        private          Table Entries
        private          Table ToClear
        private          boolexpr       DesBoolexpr         = null
        private          boolexpr       AdjBoolexpr         = null
        private          rect           DestRect            = Rect(0,0,1,1)
        
        //* Temporary variables used by the system
        private          real           TempX               = 0.
        private          real           TempY               = 0.
        private          unit           TempUnit1           = null
        private          unit           TempUnit2           = null
    endglobals
    
    //* Boolean for whether or not to display effects on a unit
    private function ShowEffects takes unit u returns boolean
        return not IsUnitType(u, UNIT_TYPE_FLYING)
    endfunction
    
    //* Functions for the destructable destruction
    private function KillDests_Check takes nothing returns boolean
        local real x = GetDestructableX(GetFilterDestructable())
        local real y = GetDestructableY(GetFilterDestructable())
        return (TempX-x)*(TempX-x) + (TempY-y)*(TempY-y) <= DEST_RADIUS_SQUARED
    endfunction
    
    private function KillDests takes nothing returns nothing
        call KillDestructable(GetEnumDestructable())
    endfunction
    
    //* Functions for knocking back adjacent units
    private function KnockAdj_Check takes nothing returns boolean
        return TempUnit2 != GetFilterUnit() and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(TempUnit1)) and IsUnitType(GetFilterUnit(), UNIT_TYPE_GROUND) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) and UnitAlive(GetFilterUnit()) and GetUnitAbilityLevel(GetFilterUnit(), 'Avul') <= 0
    endfunction
    
    //******************************************************************************
    //* Some additional functions that can be used
    function KnockbackStop takes unit targ returns boolean
        local integer id = GetHandleId(targ)
        set ToClear[id] = Entries[id]
        return ToClear[id] > 0
    endfunction
    function IsKnockedBack takes unit targ returns boolean
        return Entries[GetHandleId(targ)] > 0
    endfunction
    
    //* Struct for the system, I recommend leaving it alone
    private struct knocker
        unit Source      = null
        unit Target      = null
        group HitGroup   = null
        effect KBEffect  = null
        integer FXMode   = 0
        boolean KillDest = false
        boolean KnockAdj = false
        boolean ChainAdj = false
        boolean ShowEff  = false
        real Decrement   = 0.
        real Displace    = 0.
        real CosA        = 0.
        real SinA        = 0.
        
        public method checkterrain takes knocker n returns integer
            local integer i = 0
            local real x = GetUnitX(n.Target)
            local real y = GetUnitY(n.Target)
            if IsTerrainLand(x, y) then
                set i = 1
            elseif IsTerrainShallowWater(x, y) then
                set i = 2
            endif
            return i
        endmethod
        static method create takes unit source, unit targ, real angle, real disp, real dec, boolean killDestructables, boolean knockAdjacent, boolean chainAdjacent returns knocker
            local knocker n = knocker.allocate()
            set n.Target    = targ
            set n.Source    = source
            set n.FXMode    = n.checkterrain(n)
            set n.HitGroup  = NewGroup()
            set n.KillDest  = killDestructables
            set n.KnockAdj  = knockAdjacent
            set n.ChainAdj  = chainAdjacent
            set n.ShowEff   = ShowEffects(targ)
            set n.Decrement = dec
            set n.Displace  = disp
            set n.CosA      = Cos(angle)
            set n.SinA      = Sin(angle)
            
            if n.ShowEff then
                if n.FXMode == 1 then
                    set n.KBEffect = AddSpecialEffectTargetFix(EFFECT_PATH_GROUND, n.Target, EFFECT_ATTACH_POINT)
                elseif n.FXMode == 2 then
                    set n.KBEffect = AddSpecialEffectTargetFix(EFFECT_PATH_WATER, n.Target, EFFECT_ATTACH_POINT)
                debug else
                    debug call BJDebugMsg(SCOPE_PREFIX+" Error (On Create): Unknown Terrain Type")
                endif
            endif
            
            return n
        endmethod
        private method onDestroy takes nothing returns nothing
            local integer id = GetHandleId(this.Target)
            set Entries[id] = Entries[id] - 1
            if UnitAlive(this.Target) and Entries[id] <= 0 and ISSUE_LAST_ORDER then
                //* Issue last order if activated
                //call IssueLastOrder(this.Target)
            endif
            if this.ShowEff then
                //* Destroy effect if it exists
                call DestroyEffect(this.KBEffect)
            endif
            call ReleaseGroup(this.HitGroup)
        endmethod
    endstruct
    
    private function Update takes nothing returns nothing
        local unit u       = null
        local unit s       = null
        local knocker n    = 0
        local knocker m    = 0
        local integer i    = Counter - 1
        local integer mode = 0
        local integer id   = 0
        local real xi      = 0.
        local real yi      = 0.
        local real xf      = 0.
        local real yf      = 0.
        
        loop
            exitwhen i < 0
            set n    = Knockers[i]
            set u    = n.Target
            set mode = n.FXMode
            set id   = GetHandleId(u)
            
            set xi   = GetUnitX(u)
            set yi   = GetUnitY(u)
            
            if n.Displace <= 0 or ToClear[id] > 0 then
                //* Clean up the knockback when it is over
                if ToClear[id] > 0 then
                    set ToClear[id] = ToClear[id] - 1
                endif
                call n.destroy()
                set Counter = Counter - 1
                if Counter < 0 then
                    call PauseTimer(Timer)
                    set Counter = 0
                else
                    set Knockers[i] = Knockers[Counter]
                endif
            else
                //* Propagate the knockback in space and time
                set xf = xi + n.Displace*n.CosA
                set yf = yi + n.Displace*n.SinA
                call SetUnitPosition(u, xf, yf)
                set n.FXMode = n.checkterrain(n)
                
                //* Modify the special effect if necessary
                if n.ShowEff then
                    if n.FXMode == 1 and mode == 2 then
                        call DestroyEffect(n.KBEffect)
                        set n.KBEffect = AddSpecialEffectTargetFix(EFFECT_PATH_GROUND, n.Target, EFFECT_ATTACH_POINT)
                    elseif n.FXMode == 2 and mode == 1 then
                        call DestroyEffect(n.KBEffect)
                        set n.KBEffect = AddSpecialEffectTargetFix(EFFECT_PATH_WATER, n.Target, EFFECT_ATTACH_POINT)
                    debug elseif n.FXMode == 0 then
                        debug call BJDebugMsg(SCOPE_PREFIX+" Error (In Update): Unknown Terrain Type")
                    endif
                endif
                
                //* Decrement displacement left to go
                set n.Displace = n.Displace - n.Decrement
                
                //* Destroy destructables if desired
                if n.KillDest then
                    set TempX = GetUnitX(u)
                    set TempY = GetUnitY(u)
                    call MoveRectTo(DestRect, TempX, TempY)
                    call EnumDestructablesInRect(DestRect, DesBoolexpr, function KillDests)
                endif
                
                //* Knockback nearby units if desired
                if n.KnockAdj then
                    set xi         = GetUnitX(u)
                    set yi         = GetUnitY(u)
                    set TempUnit1  = n.Source
                    set TempUnit2  = u
                    call GroupEnumUnitsInRange(ENUM_GROUP, xi, yi, ADJACENT_RADIUS, AdjBoolexpr)
                    loop
                        set s = FirstOfGroup(ENUM_GROUP)
                        exitwhen s == null
                        if not IsUnitInGroup(s, n.HitGroup) then
                            set xf = GetUnitX(s)
                            set yf = GetUnitY(s)
                            call GroupAddUnit(n.HitGroup, s)
                            set m = knocker.create(n.Source, s, Atan2(yf-yi, xf-xi), n.Displace*ADJACENT_FACTOR, n.Decrement, n.KillDest, n.ChainAdj, n.ChainAdj)
                            call GroupAddUnit(m.HitGroup, u)
                            set Knockers[Counter] = m
                            set Counter           = Counter + 1
                        endif
                        call GroupRemoveUnit(ENUM_GROUP, s)
                    endloop
                endif
            endif
            set i = i - 1
        endloop
        
        set u = null
        set s = null
    endfunction
    
    //******************************************************************************
    //* How to knockback a unit
    function KnockbackTarget takes unit source, unit targ, real angle, real startspeed, real decrement, boolean killDestructables, boolean knockAdjacent, boolean chainAdjacent, boolean override returns boolean
        local knocker n  = 0
        local integer id = GetHandleId(targ)
        local boolean b  = true
        
        if override == false then
            if BlzIsUnitInvulnerable(targ) or GetUnitAbilityLevel(targ, 'BEer') > 0 or GetUnitAbilityLevel(targ, HARDENED_SKIN_ABILITY_ID) > 0 or UnitHasItemS(targ, 'I090') then
                return false
            endif
        endif
        
        if IsUnitExcluded(targ) then
            return false
        endif
        
        //* Protect users from themselves
        if decrement <= 0. or startspeed <= 0. or targ == null then
            debug call BJDebugMsg(SCOPE_PREFIX+" Error (On Call): Invalid Starting Conditions")
            set b = false
        else
            //* Can't chain if you don't knockback adjacent units
            if not knockAdjacent and chainAdjacent then
                set chainAdjacent = false
            endif
            set n = knocker.create(source, targ, angle*bj_DEGTORAD, startspeed*TIMER_INTERVAL, decrement*TIMER_INTERVAL*TIMER_INTERVAL, killDestructables, knockAdjacent, chainAdjacent)
            if Counter == 0 then
                call TimerStart(Timer, TIMER_INTERVAL, true, function Update)
            endif
            
            set Entries[id]       = Entries[id] + 1
            set HitIndex[id]      = Counter + 1
            set Knockers[Counter] = n
            set Counter           = Counter + 1
        endif
        return b
    endfunction
    
    private function Init takes nothing returns nothing
        set HitIndex = Table.create()
        set Knockers = Table.create()
        set Entries = Table.create()
        set ToClear = Table.create()
        set Timer = NewTimer()
        call SetRect(DestRect, -DEST_RADIUS, -DEST_RADIUS, DEST_RADIUS, DEST_RADIUS)
        set DesBoolexpr = Condition(function KillDests_Check)
        set AdjBoolexpr = Condition(function KnockAdj_Check)
    endfunction
    endlibrary