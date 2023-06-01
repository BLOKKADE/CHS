library RetaliationAura initializer init requires AbilityData, CastSpellOnTarget

    globals
        private unit RetaliationUnit = null
        Table RetaliationDamage
    endglobals

    private function RetaliationSourceFilter takes nothing returns boolean
        return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(RetaliationUnit)) and GetUnitAbilityLevel(GetFilterUnit(), RETALIATION_AUR_ABILITY_ID) > 0 and GetRandomInt(1,100) < 40* GetUnitCustomState(GetFilterUnit(), BONUS_LUCK) and DistanceBetweenUnits(GetFilterUnit(), RetaliationUnit) < 580 + (20 * GetUnitAbilityLevel(GetFilterUnit(), RETALIATION_AUR_ABILITY_ID))
    endfunction

    function CastRetaliation takes unit source, unit target, integer abilId, integer abilLevel returns nothing
        local unit caster = null
        local unit spellTarget = source
        local real damage = 0
        local integer lvl = 0
        local DummyOrder dummy = 0
        local AbilityModifiers abilMods = 0
        loop
            set caster = FirstOfGroup(ENUM_GROUP)
            exitwhen caster == null
            
            //cast on caster if spell is used on allies
            if target != null and IsUnitEnemy(target, GetOwningPlayer(source)) == false then
                set spellTarget = caster
            endif

            //get dummy
            set dummy = CastSpell(caster, spellTarget, abilId, abilLevel, GetAbilityOrderType(abilId), GetUnitX(source), GetUnitY(source))
            call AddUnitCustomState(dummy.dummy, BONUS_MAGICPOW, GetUnitCustomState(source, BONUS_MAGICPOW))

            //Set bonus damage
            set AbilityModifiers.createOrGet(dummy.dummy).RetaliationAuraBonus = 0.25 + (0.025 * GetUnitAbilityLevel(caster, RETALIATION_AUR_ABILITY_ID))
            //call BJDebugMsg("retdmg: " + R2S(RetaliationDamage.real[GetHandleId(dummy.dummy)]) + " hid: " + I2S(GetHandleId(dummy.dummy)))
            call DestroyEffect(AddLocalizedSpecialEffectTarget("war3mapImported\\Shiva'sWrath.mdx", caster, "origin"))
            call dummy.activate()
            call GroupRemoveUnit(ENUM_GROUP, caster)
        endloop

        set spellTarget = null
        set caster = null
    endfunction

    function GetRetaliationSource takes unit source, unit target, integer abilId, integer abilLevel returns nothing
        call GroupClear(ENUM_GROUP)
        set RetaliationUnit = source
        call GroupEnumUnitsInArea(ENUM_GROUP, GetUnitX(source), GetUnitY(source), 1200, Condition(function RetaliationSourceFilter))
        //call BJDebugMsg("rag: " + I2S(BlzGroupGetSize(RetaliationGroup)))
        if BlzGroupGetSize(ENUM_GROUP) > 0 then
            call CastRetaliation(source, target, abilId, abilLevel)
        endif
    endfunction

    private function init takes nothing returns nothing
        set RetaliationDamage = Table.create()
    endfunction
endlibrary