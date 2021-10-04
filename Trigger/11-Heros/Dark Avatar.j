library DarkAvatar initializer init requires CustomState, HeroLvlTable

    globals
        HashTable AvatarMode
    endglobals

    function ResetAvatar takes integer hid, unit u, integer mode returns nothing

        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) - AvatarMode[hid].real[1])
        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) - AvatarMode[hid][2], 0)
        call AddUnitMagicDmg(u, 0 - AvatarMode[hid].real[3])
        call AddUnitMagicDef(u, 0 - AvatarMode[hid].real[4])
        call SetBonus(u, 0, 0)
        call SetBonus(u, 1, 0)
        call SetBonus(u, 2, 0)
        call SetBonus(u, 3, 0)

        set AvatarMode[hid].real[1] = 0
        set AvatarMode[hid].integer[2] = 0
        set AvatarMode[hid].real[3] = 0
        set AvatarMode[hid].real[4] = 0

        if mode == 0 then
            call UnitRemoveAbility(u, 'A0AI')
            call UnitRemoveAbility(u, 'A0AJ')
            set AvatarMode[hid][0] = 0
        elseif mode == 1 then
            call UnitRemoveAbility(u, 'A0AI')
            call UnitAddAbility(u, 'A0AJ')
            set AvatarMode[hid][0] = 1
        else
            call UnitRemoveAbility(u, 'A0AJ')
            call UnitAddAbility(u, 'A0AI')
            set AvatarMode[hid][0] = 2
        endif
    endfunction

    function SetAvatarMode takes unit u, integer heroLevel returns nothing
        local integer hid = GetHandleId(u)
        local integer light = GetClassUnitSpell(u, Element_Light)
        local integer dark = GetClassUnitSpell(u, Element_Dark)
        local integer iBonus = 0
        local real rBonus = 0

        if light > dark then
            if AvatarMode[hid][0] != 1 then
                call ResetAvatar(hid, u, 1)
            endif
            set rBonus = (heroLevel * 0.01) * (BlzGetUnitArmor(u) - AvatarMode[hid].real[1])
            if rBonus != AvatarMode[hid].real[1] then
                call BlzSetUnitArmor(u, BlzGetUnitArmor(u) - AvatarMode[hid].real[1] + rBonus)
                set AvatarMode[hid].real[1] = rBonus
            endif
            call SetBonus(u, 1, heroLevel * 0.01)

            set iBonus = (heroLevel * 35)
            if iBonus != AvatarMode[hid][2] then
                call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) - AvatarMode[hid][2] + iBonus, 0)
                set AvatarMode[hid][2] = iBonus
                call SetBonus(u, 0, iBonus)
            endif

        elseif dark > light then
            if AvatarMode[hid][0] != 2 then
                call ResetAvatar(hid, u, 2)
            endif

            set rBonus = (heroLevel * 0.75)
            if rBonus != AvatarMode[hid].real[3] then
                call AddUnitMagicDmg(u, 0 - AvatarMode[hid].real[3] + rBonus)
                set AvatarMode[hid].real[3] = rBonus
                call SetBonus(u, 2, rBonus)
            endif

            set rBonus = (heroLevel * 0.3)
            if rBonus != AvatarMode[hid].real[4] then
                call AddUnitMagicDef(u, 0 - AvatarMode[hid].real[4] + rBonus)
                set AvatarMode[hid].real[4] = rBonus
                call SetBonus(u, 3, rBonus)
            endif
        else
            if AvatarMode[hid][0] != 0 then
                call ResetAvatar(hid, u, 0)
            endif 
        endif
    endfunction

    private function init takes nothing returns nothing
        set AvatarMode = HashTable.create()
    endfunction
endlibrary