library MeteorStrike requires RandomShit, TimerUtils

    //============================================================
    // Knockback data
    //============================================================
    private struct KnockData
        unit u
        real startX
        real startY
        real destX
        real destY
        real totalDist
        real speed
        real duration
        real elapsed
        real maxHeight
        timer t
    endstruct

    private function Knockback_Periodic takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local KnockData d = LoadInteger(udg_Hash, GetHandleId(t), 0)
        local real progress
        local real currentDist
        local real x
        local real y
        local real height
        local real angle

        set d.elapsed = d.elapsed + 0.03
        set progress = d.elapsed / d.duration

        if progress >= 1.0 then
            call SetUnitPosition(d.u, d.destX, d.destY)
            call SetUnitFlyHeight(d.u, 0, 0)
            call PauseUnit(d.u, false)
            call d.destroy()
            call ReleaseTimer(t)
            return
        endif

        set currentDist = d.totalDist * progress
        set angle = Atan2(d.destY - d.startY, d.destX - d.startX)
        set x = d.startX + Cos(angle) * currentDist
        set y = d.startY + Sin(angle) * currentDist

        call SetUnitX(d.u, x)
        call SetUnitY(d.u, y)

        set height = d.maxHeight * 4.0 * progress * (1.0 - progress)
        call SetUnitFlyHeight(d.u, height, 0)
    endfunction

    // Finds a safe landing spot that is walkable
    private function GetSafeKnockbackPoint takes real startX, real startY, real angle, real desiredDist returns location
        local real dist = desiredDist
        local real x
        local real y
        local location loc

        loop
            set x = startX + Cos(angle) * dist
            set y = startY + Sin(angle) * dist

            // Check if the point is walkable
            if not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) then
                // Found a valid spot
                set loc = Location(x, y)
                return loc
            endif

            set dist = dist - 25.0   // step back 25 units and try again

            exitwhen dist <= 50.0    // minimum push distance
        endloop

        // Fallback: just go a short distance
        set loc = Location(startX + Cos(angle) * 50.0, startY + Sin(angle) * 50.0)
        return loc
    endfunction

    function MeteorStrike_Knockback takes unit u, real centerX, real centerY returns nothing
        local real ux = GetUnitX(u)
        local real uy = GetUnitY(u)
        local real dx = ux - centerX
        local real dy = uy - centerY
        local real dist = SquareRoot(dx*dx + dy*dy)
        local real angle
        local real pushDist
        local location safeLoc
        local real destX
        local real destY
        local KnockData d
        local timer t

        if IsUnitType(u, UNIT_TYPE_STRUCTURE) or IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) then
            return
        endif

        if dist < 1.0 then
            set angle = GetRandomReal(0, 360) * bj_DEGTORAD
            set pushDist = 900.0
        else
            set angle = Atan2(dy, dx)
            set pushDist = 900.0 - (dist / 400.0) * 650.0
            if pushDist < 250.0 then
                set pushDist = 250.0
            endif
        endif

        // Get a safe (walkable) destination
        set safeLoc = GetSafeKnockbackPoint(ux, uy, angle, pushDist)
        set destX = GetLocationX(safeLoc)
        set destY = GetLocationY(safeLoc)
        call RemoveLocation(safeLoc)

        set d = KnockData.create()
        set d.u = u
        set d.startX = ux
        set d.startY = uy
        set d.destX = destX
        set d.destY = destY
        set d.totalDist = SquareRoot((destX-ux)*(destX-ux) + (destY-uy)*(destY-uy))
        set d.speed = 450.0
        set d.duration = d.totalDist / d.speed
        if d.duration < 0.15 then
            set d.duration = 0.15
        endif
        set d.elapsed = 0.0
        set d.maxHeight = 160.0 + (d.totalDist / 900.0) * 140.0

        call UnitAddAbility(u, 'Amrf')
        call UnitRemoveAbility(u, 'Amrf')
        call SetUnitFlyHeight(u, 0, 0)
        call PauseUnit(u, true)

        set t = NewTimer()
        set d.t = t
        call SaveInteger(udg_Hash, GetHandleId(t), 0, d)
        call TimerStart(t, 0.03, true, function Knockback_Periodic)
    endfunction

    //============================================================
    // Actual damage + knockback
    //============================================================
    private function MeteorStrike_DoDamage takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real x = LoadReal(udg_Hash, GetHandleId(t), 1)
        local real y = LoadReal(udg_Hash, GetHandleId(t), 2)
        local integer level = LoadInteger(udg_Hash, GetHandleId(t), 3)
        local unit caster = LoadUnitHandle(udg_Hash, GetHandleId(t), 4)
        local group g = CreateGroup()
        local unit u
        local real dist
        local real damage
        local real fullDmg = 100.0 * level

        call GroupEnumUnitsInRange(g, x, y, 400.0, null)

        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call GroupRemoveUnit(g, u)

            if UnitAlive(u) and IsUnitEnemy(u, GetOwningPlayer(caster)) then
                set dist = SquareRoot((GetUnitX(u)-x)*(GetUnitX(u)-x) + (GetUnitY(u)-y)*(GetUnitY(u)-y))

                set damage = fullDmg * (1.0 - dist / 400.0)
                if damage < 0 then
                    set damage = 0
                endif

                call UnitDamageTarget(caster, u, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
                call MeteorStrike_Knockback(u, x, y)
            endif
        endloop

        call DestroyGroup(g)
        call FlushChildHashtable(udg_Hash, GetHandleId(t))
        call ReleaseTimer(t)

        set t = null
        set caster = null
        set g = null
        set u = null
    endfunction

    //============================================================
    // Impact
    //============================================================
    function MeteorStrike_Impact takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real x = LoadReal(udg_Hash, GetHandleId(t), 1)
        local real y = LoadReal(udg_Hash, GetHandleId(t), 2)
        local integer level = LoadInteger(udg_Hash, GetHandleId(t), 3)
        local unit caster = LoadUnitHandle(udg_Hash, GetHandleId(t), 4)
        local effect beam = LoadEffectHandle(udg_Hash, GetHandleId(t), 5)
        local effect circle = LoadEffectHandle(udg_Hash, GetHandleId(t), 6)
        local effect meteor
        local timer damageTimer = NewTimer()

        // Remove both indicators
        call DestroyEffect(beam)
        call DestroyEffect(circle)

        // Start meteor animation
        set meteor = AddSpecialEffect("Units\\Demon\\Infernal\\InfernalBirth.mdl", x, y)
        call DestroyEffect(meteor)

        // Delay damage + knockback
        call SaveReal(udg_Hash, GetHandleId(damageTimer), 1, x)
        call SaveReal(udg_Hash, GetHandleId(damageTimer), 2, y)
        call SaveInteger(udg_Hash, GetHandleId(damageTimer), 3, level)
        call SaveUnitHandle(udg_Hash, GetHandleId(damageTimer), 4, caster)

        call TimerStart(damageTimer, 0.85, false, function MeteorStrike_DoDamage)

        call FlushChildHashtable(udg_Hash, GetHandleId(t))
        call ReleaseTimer(t)

        set t = null
        set caster = null
        set beam = null
        set circle = null
        set meteor = null
        set damageTimer = null
    endfunction

    //============================================================
    // Cast
    //============================================================
    function CastMeteorStrike takes unit hero, real x, real y, integer lvl returns nothing
        local timer t = NewTimer()
        local effect beam
        local effect circle

        // Vertical light beam
        set beam = AddSpecialEffect("Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl", x, y)

        // Lasting ground circle (classic AOE indicator)
        set circle = AddSpecialEffect("Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl", x, y)
        call BlzSetSpecialEffectScale(circle, 18.2)
        call BlzSetSpecialEffectColor(circle, 255, 50, 50)  // reddish tint

        call SaveReal(udg_Hash, GetHandleId(t), 1, x)
        call SaveReal(udg_Hash, GetHandleId(t), 2, y)
        call SaveInteger(udg_Hash, GetHandleId(t), 3, lvl)
        call SaveUnitHandle(udg_Hash, GetHandleId(t), 4, hero)
        call SaveEffectHandle(udg_Hash, GetHandleId(t), 5, beam)
        call SaveEffectHandle(udg_Hash, GetHandleId(t), 6, circle)

        call TimerStart(t, 3.00, false, function MeteorStrike_Impact)

        set t = null
        set beam = null
        set circle = null
    endfunction

endlibrary