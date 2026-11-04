library Subterfuge initializer Init

    globals
        // ===================== CONFIG =====================
        private constant real    DURATION           = 10.    // how long the skins stay swapped
        private constant boolean SWAP_COLORS        = true   // each body takes on the colour of the model it's wearing, so the
                                                               // player-colour doesn't give the swap away
        private constant boolean MATCH_ORDERS       = true   // each unit carries on the other's walking / chasing / patrolling
        private constant boolean MATCH_MOVE_SPEED   = true   // each unit moves at the speed of the model it's wearing (restored afterwards)
        private constant boolean PAN_CAMERA         = false  // true = the caster's camera jumps to their new spot
        private constant real    FALLBACK_RUN_DIST  = 1500.  // if a walking unit's destination is unknown, it keeps walking this far on its heading

        private constant real    INTERVAL           = 0.1
        // ====================================================

        private constant integer ORDER_STOP         = 851972
        private constant integer ORDER_SMART        = 851971
        private constant integer ORDER_MOVE         = 851986
        private constant integer ORDER_ATTACK       = 851983
        private constant integer ORDER_ATTACKGROUND = 851984
        private constant integer ORDER_PATROL       = 851990

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()

        private hashtable OrderHash = InitHashtable()   // unit -> the last move/attack/patrol-type order it was given
        private hashtable BusyHash  = InitHashtable()   // unit -> the Subterfuge currently disguising it
    endglobals

    //==================================================================
    // Order tracking. Warcraft can't tell us where a unit is walking to, so we note every order as it is given.
    // That lets a swapped unit carry on toward the very same destination.
    //==================================================================
    private function SaveOrder takes unit u, integer oid, integer kind, real x, real y, unit tgt returns nothing
        local integer id = GetHandleId(u)

        call SaveInteger(OrderHash, id, 0, oid)
        call SaveInteger(OrderHash, id, 1, kind)     // 0 = no destination, 1 = point, 2 = unit
        call SaveReal(OrderHash, id, 2, x)
        call SaveReal(OrderHash, id, 3, y)
        if tgt == null then
            call RemoveSavedHandle(OrderHash, id, 4)
        else
            call SaveUnitHandle(OrderHash, id, 4, tgt)
        endif
    endfunction

    private function OnPointOrder takes nothing returns boolean
        call SaveOrder(GetTriggerUnit(), GetIssuedOrderId(), 1, GetOrderPointX(), GetOrderPointY(), null)
        return false
    endfunction

    private function OnTargetOrder takes nothing returns boolean
        local unit t = GetOrderTargetUnit()

        if t != null then
            call SaveOrder(GetTriggerUnit(), GetIssuedOrderId(), 2, GetUnitX(t), GetUnitY(t), t)
        else
            call SaveOrder(GetTriggerUnit(), GetIssuedOrderId(), 0, 0., 0., null)
        endif
        set t = null
        return false
    endfunction

    private function OnImmediateOrder takes nothing returns boolean
        call SaveOrder(GetTriggerUnit(), GetIssuedOrderId(), 0, 0., 0., null)
        return false
    endfunction

    private function OnDeath takes nothing returns boolean
        call FlushChildHashtable(OrderHash, GetHandleId(GetTriggerUnit()))
        return false
    endfunction

    private function IsMovingOrder takes integer oid returns boolean
        return oid == ORDER_SMART or oid == ORDER_MOVE or oid == ORDER_ATTACK or oid == ORDER_ATTACKGROUND or oid == ORDER_PATROL
    endfunction

    //==================================================================
    // One swap. Index 0 is the caster, index 1 is the target.
    //
    // What the swap does, all in one instant (no frame passes in between):
    //   - the two units trade places
    //   - each is turned (instantly, not turning over time) to face the way the other was facing
    //   - they trade skins, so the model that was at each spot is still at that spot
    //   - they trade player colours, so the models keep the colour they had
    //   - each is handed the other's movement: if one was walking somewhere, the other is now
    //     walking to the same place, at the same speed
    // After DURATION the skins, colours and speeds go back to normal.
    //==================================================================
    private struct SubterfugeInstance
        unit array u[2]
        integer array skin[2]
        playercolor array col[2]
        real array spd[2]
        real array face[2]
        real array px[2]
        real array py[2]
        integer array oid[2]       // the movement-type order each was carrying out (0 = standing still)
        integer array kind[2]
        real array ox[2]
        real array oy[2]
        unit array tg[2]

        real t
        boolean done
        boolean speedMatched

        //--------------------------------------------------------
        // Notes what unit i was doing: walking somewhere, chasing someone, or standing still
        method captureOrder takes integer i returns nothing
            local integer cur = GetUnitCurrentOrder(.u[i])
            local integer id = GetHandleId(.u[i])

            set .oid[i] = 0
            set .kind[i] = 0
            set .tg[i] = null

            if IsMovingOrder(cur) then
                set .oid[i] = cur

                // only trust our notes if they match what the unit is actually doing right now
                if HaveSavedInteger(OrderHash, id, 0) and LoadInteger(OrderHash, id, 0) == cur then
                    set .kind[i] = LoadInteger(OrderHash, id, 1)
                    set .ox[i] = LoadReal(OrderHash, id, 2)
                    set .oy[i] = LoadReal(OrderHash, id, 3)

                    if .kind[i] == 2 then
                        set .tg[i] = LoadUnitHandle(OrderHash, id, 4)
                        if .tg[i] == null or GetWidgetLife(.tg[i]) < 0.405 then
                            set .kind[i] = 0
                            set .tg[i] = null
                        endif
                    endif
                endif
            endif
        endmethod

        //--------------------------------------------------------
        // Unit i takes over whatever unit j was doing
        method takeOver takes integer i, integer j returns nothing
            local unit t = .tg[j]
            local boolean ok = true

            if .oid[j] == 0 then
                // j was standing still, so i stands still
                call IssueImmediateOrderById(.u[i], ORDER_STOP)

            elseif .kind[j] == 1 then
                call IssuePointOrderById(.u[i], .oid[j], .ox[j], .oy[j])

            elseif .kind[j] == 2 and t != null then
                // if j was heading for i, then now that the skins are swapped it's heading for j's body instead
                if t == .u[i] then
                    set t = .u[j]
                endif
                set ok = IssueTargetOrderById(.u[i], .oid[j], t)
                if not ok then
                    call IssueImmediateOrderById(.u[i], ORDER_STOP)
                endif

            elseif .oid[j] == ORDER_SMART or .oid[j] == ORDER_MOVE then
                // we know it was walking but not where to: keep it walking the way it was facing
                call IssuePointOrderById(.u[i], ORDER_MOVE, .px[j] + Cos(.face[j] * bj_DEGTORAD) * FALLBACK_RUN_DIST, .py[j] + Sin(.face[j] * bj_DEGTORAD) * FALLBACK_RUN_DIST)

            else
                call IssueImmediateOrderById(.u[i], ORDER_STOP)
            endif

            set t = null
        endmethod

        //--------------------------------------------------------
        static method create takes unit caster, unit target returns thistype
            local thistype this = thistype.allocate()
            local integer i = 0
            local integer id
            local thistype old

            set .u[0] = caster
            set .u[1] = target
            set .t = 0.
            set .done = false
            set .speedMatched = false

            // if either unit is still disguised by an earlier Subterfuge, undo that first
            loop
                exitwhen i > 1
                set id = GetHandleId(.u[i])
                if HaveSavedInteger(BusyHash, id, 0) then
                    set old = LoadInteger(BusyHash, id, 0)
                    call old.restore()
                endif
                set i = i + 1
            endloop

            // note everything about both units BEFORE anything changes
            set i = 0
            loop
                exitwhen i > 1
                set .skin[i] = BlzGetUnitSkin(.u[i])
                set .col[i]  = GetPlayerColor(GetOwningPlayer(.u[i]))
                set .spd[i]  = GetUnitMoveSpeed(.u[i])
                set .face[i] = GetUnitFacing(.u[i])
                set .px[i]   = GetUnitX(.u[i])
                set .py[i]   = GetUnitY(.u[i])
                set .tg[i]   = null
                call .captureOrder(i)
                set i = i + 1
            endloop

            // ---------- the swap ----------
            // positions
            call SetUnitX(.u[0], .px[1])
            call SetUnitY(.u[0], .py[1])
            call SetUnitX(.u[1], .px[0])
            call SetUnitY(.u[1], .py[0])

            // facing: instant, so nobody visibly spins round
            call BlzSetUnitFacingEx(.u[0], .face[1])
            call BlzSetUnitFacingEx(.u[1], .face[0])

            // skins and colours
            call BlzSetUnitSkin(.u[0], .skin[1])
            call BlzSetUnitSkin(.u[1], .skin[0])
            if SWAP_COLORS then
                call SetUnitColor(.u[0], .col[1])
                call SetUnitColor(.u[1], .col[0])
            endif

            // speeds (only if both units can actually move)
            if MATCH_MOVE_SPEED and .spd[0] > 0. and .spd[1] > 0. then
                set .speedMatched = true
                call SetUnitMoveSpeed(.u[0], .spd[1])
                call SetUnitMoveSpeed(.u[1], .spd[0])
            endif

            // movement: each carries on the other's walking, chasing or standing still
            if MATCH_ORDERS then
                call .takeOver(0, 1)
                call .takeOver(1, 0)
            endif

            if PAN_CAMERA then
                call PanCameraToTimedForPlayer(GetOwningPlayer(.u[0]), .px[1], .py[1], 0.)
            endif

            call SaveInteger(BusyHash, GetHandleId(.u[0]), 0, this)
            call SaveInteger(BusyHash, GetHandleId(.u[1]), 0, this)

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // Puts the skins, colours and speeds back (safe to call more than once)
        method restore takes nothing returns nothing
            local integer i = 0

            if .done then
                return
            endif
            set .done = true

            loop
                exitwhen i > 1
                call BlzSetUnitSkin(.u[i], .skin[i])
                if SWAP_COLORS then
                    call SetUnitColor(.u[i], .col[i])
                endif
                if .speedMatched then
                    call SetUnitMoveSpeed(.u[i], .spd[i])
                endif
                call RemoveSavedInteger(BusyHash, GetHandleId(.u[i]), 0)
                set i = i + 1
            endloop
        endmethod

        //--------------------------------------------------------
        // returns true when this swap is over
        method step takes nothing returns boolean
            set .t = .t + INTERVAL
            if .t >= DURATION then
                call .restore()
            endif
            return .done
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer i = 0

            call .restore()
            loop
                exitwhen i > 1
                set .u[i] = null
                set .tg[i] = null
                set i = i + 1
            endloop
        endmethod

        //--------------------------------------------------------
        static method tickAll takes nothing returns nothing
            local integer i = Count - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = Active[i]
                if this.step() then
                    call this.destroy()
                    set Count = Count - 1
                    set Active[i] = Active[Count]
                endif
                set i = i - 1
            endloop

            if Count == 0 then
                call PauseTimer(Tick)
            endif
        endmethod
    endstruct

    //==================================================================
    // Public entry point, called from your ability dispatcher.
    function CastSubterfuge takes unit hero, unit target, integer lvl returns nothing
        if hero == null or target == null or hero == target then
            return
        endif
        if GetWidgetLife(target) < 0.405 or IsUnitType(target, UNIT_TYPE_DEAD) or IsUnitType(target, UNIT_TYPE_STRUCTURE) then
            return
        endif

        call SubterfugeInstance.create(hero, target)
    endfunction

    private function Init takes nothing returns nothing
        local trigger t

        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
        call TriggerAddCondition(t, Condition(function OnPointOrder))

        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
        call TriggerAddCondition(t, Condition(function OnTargetOrder))

        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_ORDER)
        call TriggerAddCondition(t, Condition(function OnImmediateOrder))

        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(t, Condition(function OnDeath))

        set t = null
    endfunction

endlibrary