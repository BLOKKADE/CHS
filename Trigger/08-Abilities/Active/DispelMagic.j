library DispelMagic initializer InitDispelMagic requires UnitHelpers

    // Main dispel logic
    function DispelMagicEffect takes unit caster, real x, real y, integer level returns nothing
        local real aoe = 150.0 + (level - 1) * 10.0 // Linear scale to 450 at level 30
        local group g = CreateGroup()
        local unit u
        local player owner = GetOwningPlayer(caster)
        local real damage

        call GroupEnumUnitsInRange(g, x, y, aoe, null)

        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call GroupRemoveUnit(g, u)

            if IsUnitAlly(u, owner) then
                call RemoveFirstUnitBuff(u, 1, BUFFTYPE_NEGATIVE)
            elseif IsUnitEnemy(u, owner) then
                call RemoveFirstUnitBuff(u, 1, BUFFTYPE_POSITIVE)

                if IsUnitIllusion(u) then
                    set damage = GetWidgetLife(u) * 0.5
                    call UnitDamageTarget(caster, u, damage, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                endif
            endif
        endloop

        call DestroyGroup(g)
    endfunction


    // Optional initializer if you want to hook this into a spell cast system
    private function InitDispelMagic takes nothing returns nothing
        // Example: register with your custom spell system
        // call RegisterSpellEffect('DMBB', DispelMagicEffect)
    endfunction

endlibrary

