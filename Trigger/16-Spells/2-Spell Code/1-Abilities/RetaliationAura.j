library RetaliationAura initializer init requires AbilityData, CastSpellOnTarget

    globals
        private group RetaliationGroup = CreateGroup()
        private unit RetaliationUnit = null
        Table RetaliationDamage
    endglobals

    private function RetaliationSourceFilter takes nothing returns boolean
        return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(RetaliationUnit)) == true and GetUnitAbilityLevel(GetFilterUnit(), 'A0A9') > 0 and GetRandomInt(1,100) < 40 and DistanceBetweenUnits(GetFilterUnit(), RetaliationUnit) < 580 + (20 * GetUnitAbilityLevel(GetFilterUnit(), 'A0A9'))
    endfunction

    function CastRetaliation takes unit source, unit target, integer abilId, integer abilLevel returns nothing
        local unit caster = null
        local unit spellTarget = source
        local real damage = 0
        local integer lvl = 0
        local DummyOrder dummy = 0
        loop
            set caster = FirstOfGroup(RetaliationGroup)
            exitwhen caster == null
            
            //cast on caster if spell is used on allies
            if target != null and IsUnitEnemy(target, GetOwningPlayer(source)) == false then
                set spellTarget = caster
            endif

            //if caster has the ability do 100% bonus damage
            set lvl = GetUnitAbilityLevel(caster, abilId)
            if lvl > 0 then
                if lvl > abilLevel then
                    set abilLevel = lvl
                endif
                set damage = 1
            endif

            //get dummy
            set dummy = CastSpell(caster, spellTarget, abilId, abilLevel, GetAbilityOrderType(abilId), GetUnitX(source), GetUnitY(source))

            //Set bonus damage
            set RetaliationDamage.real[GetHandleId(dummy.dummy)] = 0.25 + (0.025 * GetUnitAbilityLevel(caster, 'A0A9')) + damage
            call dummy.activate()
            call GroupRemoveUnit(ArcaneAssaultGroup, target)
        endloop

        set spellTarget = null
        set caster = null
    endfunction

    function GetRetaliationSource takes unit source, unit target, integer abilId, integer abilLevel returns nothing
        call GroupClear(RetaliationGroup)
        set RetaliationUnit = source
        call GroupEnumUnitsInRange(RetaliationGroup, GetUnitX(source), GetUnitY(source), 1200, Condition(function RetaliationSourceFilter))
        if BlzGroupGetSize(RetaliationGroup) > 0 then
            call CastRetaliation(source, target, abilId, abilLevel)
        endif
    endfunction

    private function init takes nothing returns nothing
        set RetaliationDamage = Table.create()
    endfunction
endlibrary