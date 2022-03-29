library DummyActiveSpell initializer init requires AbilityData, ListT
    
    globals
        integer DummySpell_PointInstant = 0
        integer DummySpell_Unit = 1
        HashTable DummySpellList
        //[unitid].
        HashTable HeroAvailableDummySpells
        HashTable UnitDummySpells
        //spell id = lvl of ability
    endglobals

    function GetAssociatedSpell takes unit u, integer abilId returns integer
        return UnitDummySpells[GetHandleId(u)].integer[abilId]
    endfunction

    function GetAvailableDummySpellList takes unit u, integer dummySpellType returns IntegerList
        return HeroAvailableDummySpells[dummySpellType][GetHandleId(u)]
    endfunction

    function CreateDummySpellList takes unit u, integer dummySpellType returns IntegerList
        local IntegerList dummySpellList = IntegerList.create()
        local integer i = 0

        loop
            call dummySpellList.push(DummySpellList[dummySpellType][i])
            set i = i + 1
            exitwhen i > 9
        endloop

        set HeroAvailableDummySpells[dummySpellType][GetHandleId(u)] = dummySpellList

        //call ListT_print(dummySpellList, "dummy spell list")

        return dummySpellList
    endfunction

    function AddDummySpellToList takes unit u, integer abilId, integer dummySpellType returns nothing
        call GetAvailableDummySpellList(u, dummySpellType).push(abilId)
    endfunction

    function GetNextDummySpell takes unit u, integer dummySpellType returns integer
        local IntegerList dummySpellList = GetAvailableDummySpellList(u, dummySpellType)
        local integer dummyAbilId = 0
        
        if dummySpellList == 0 then
            set dummySpellList = CreateDummySpellList(u, dummySpellType) 
        endif

        //call BJDebugMsg("dummy spell list: " + I2S(dummySpellList))

        set dummyAbilId = dummySpellList.back()
        call dummySpellList.pop()

        //call BJDebugMsg("dummy spell: " + I2S(dummyAbilId))

        return dummyAbilId
    endfunction

    function RemoveDummyspell takes unit u, integer abilityId returns nothing
        local integer dummyAbilId = UnitDummySpells[GetHandleId(u)].integer[abilityId]
        if dummyAbilId != 0 then
            call UnitRemoveAbility(u, dummyAbilId)

            if GetAbilityOrderType(abilityId) == Order_Target then
                call AddDummySpellToList(u, dummyAbilId, 1)
            else
                call AddDummySpellToList(u, dummyAbilId, 0)
            endif

            set UnitDummySpells[GetHandleId(u)].integer[abilityId] = 0
            set UnitDummySpells[GetHandleId(u)].integer[dummyAbilId] = 0
        endif
    endfunction

    function UpdateDummySpells takes unit u, integer abilityId, integer level returns nothing
        local integer dummyAbilId = UnitDummySpells[GetHandleId(u)].integer[abilityId]
        local ability dummyAbil = BlzGetUnitAbility(u, dummyAbilId)
        local ability learnedAbil = BlzGetUnitAbility(u, abilityId)
        local integer orderType = GetAbilityOrderType(abilityId)

        //call BJDebugMsg("dabilid: " + I2S(dummyAbilId) + " dabil: " + I2S(GetHandleId(dummyAbil)) + " labil:" + I2S(GetHandleId(learnedAbil)) + " order: " + I2S(orderType))

        call BlzSetUnitAbilityManaCost(u, dummyAbilId, 0, BlzGetUnitAbilityManaCost(u, abilityId, level))
        call BlzSetAbilityRealLevelField(dummyAbil, ABILITY_RLF_COOLDOWN, 0, BlzGetAbilityRealLevelField(learnedAbil, ABILITY_RLF_COOLDOWN, level))
        call BlzSetAbilityRealLevelField(dummyAbil, ABILITY_RLF_CAST_RANGE, 0, BlzGetAbilityRealLevelField(learnedAbil, ABILITY_RLF_CAST_RANGE, level))
        call BlzSetAbilityRealLevelField(dummyAbil, ABILITY_RLF_AREA_OF_EFFECT, 0, BlzGetAbilityRealLevelField(learnedAbil, ABILITY_RLF_AREA_OF_EFFECT, level))

        if orderType == Order_Point then
            call BlzSetAbilityIntegerLevelField(dummyAbil, ABILITY_ILF_TARGET_TYPE, 0, 2)
        endif

        call SetUnitAbilityLevel(u, dummyAbilId, 2)
        call SetUnitAbilityLevel(u, dummyAbilId, 1)

        if GetLocalPlayer() == GetOwningPlayer(u) then
            call BlzSetAbilityTooltip(dummyAbilId, BlzGetAbilityTooltip(abilityId, level), 0)
            call BlzSetAbilityExtendedTooltip(dummyAbilId, BlzGetAbilityExtendedTooltip(abilityId, level), 0)
            call BlzSetAbilityIcon(dummyAbilId, BlzGetAbilityIcon(abilityId))
        endif
    endfunction

    function AddDummySpell takes unit u, integer abilityId, integer level, integer orderType returns nothing
        local integer dummyAbilId = GetNextDummySpell(u, orderType)
        local ability dummyAbil
        local ability learnedAbil
        call BlzUnitHideAbility(u, abilityId, true)
        call UnitAddAbility(u, dummyAbilId)

        set UnitDummySpells[GetHandleId(u)].integer[abilityId] = dummyAbilId
        set UnitDummySpells[GetHandleId(u)].integer[dummyAbilId] = abilityId

        call UpdateDummySpells(u, abilityId, level)
    endfunction

    function SetupDummySpell takes unit u, integer abilId, integer lvl, boolean new returns nothing
        local integer orderType = 0
        //call BJDebugMsg("hello?")
        if GetAbilityTargetType(abilId) == Target_Enemy and IsAbilityCasteable(abilId, false) and IsAbilityReplaceable(abilId) then

            set orderType = GetAbilityOrderType(abilId)
            if orderType == 2 or orderType == 3 then
                set orderType = 0   
            else
                set orderType = 1
            endif

            //call BJDebugMsg("sds abil: " + GetObjectName(abilId) + " lvl: " + I2S(lvl - 1) + "new: " + B2S(new) + " ordertype: " + I2S(orderType))
            if new then
                call AddDummySpell(u, abilId, lvl - 1, orderType)
            else
                call UpdateDummySpells(u, abilId, lvl - 1)
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set DummySpellList = HashTable.create()
        set HeroAvailableDummySpells = HashTable.create()
        set UnitDummySpells = HashTable.create()

        set DummySpellList[DummySpell_PointInstant][0] = 'A0BJ'
        set DummySpellList[DummySpell_PointInstant][1] = 'A0BO'
        set DummySpellList[DummySpell_PointInstant][2] = 'A0BN'
        set DummySpellList[DummySpell_PointInstant][3] = 'A0BM'
        set DummySpellList[DummySpell_PointInstant][4] = 'A0BG'
        set DummySpellList[DummySpell_PointInstant][5] = 'A0BH'
        set DummySpellList[DummySpell_PointInstant][6] = 'A0BI'
        set DummySpellList[DummySpell_PointInstant][7] = 'A0BP'
        set DummySpellList[DummySpell_PointInstant][8] = 'A0BK'
        set DummySpellList[DummySpell_PointInstant][9] = 'A0BL'

        set DummySpellList[DummySpell_Unit][0] = 'A0BX'
        set DummySpellList[DummySpell_Unit][1] = 'A0BZ'
        set DummySpellList[DummySpell_Unit][2] = 'A0BW'
        set DummySpellList[DummySpell_Unit][3] = 'A0BY'
        set DummySpellList[DummySpell_Unit][4] = 'A0BQ'
        set DummySpellList[DummySpell_Unit][5] = 'A0BR'
        set DummySpellList[DummySpell_Unit][6] = 'A0BS'
        set DummySpellList[DummySpell_Unit][7] = 'A0BT'
        set DummySpellList[DummySpell_Unit][8] = 'A0BU'
        set DummySpellList[DummySpell_Unit][9] = 'A0BV'
    endfunction
endlibrary