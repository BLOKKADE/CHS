library AttackCooldown requires MegaSpeed, UnitItems, RemoveBuffs

    function ModifyAttackCooldown takes unit u, integer hid returns real
        // base attack cooldown
        local real r1 = LoadReal(HT, hid, - 1001)
        local real r2 = r1
        local integer i1 = GetUnitAbilityLevel(u, MEGA_SPEED_ABILITY_ID)
        local real temp = 0
        local real gloryAttackCdBonus = r1 * GloryAttackCdBonus.real[hid]

        //Mega Speed and Glory Attack Cd
        if gloryAttackCdBonus != 0 then
            set r2 = RMaxBJ(r1 - gloryAttackCdBonus, 0.50)
        endif

        //Mega Speed
        if i1 != 0 and r2 > 0.5 then
            set r2 = r2 - MegaSpeedBonus(u, i1, r2)
        endif

        //Speed Blade active: is overridden if already lower than 0.6 from mega speed/default
        if GetUnitAbilityLevel(u, SPEED_BLADE_BUFF_ID) > 0 then
            if r2 > 0.65 then
                set r2 = 0.65
            else
                call RemoveUnitBuff(u, SPEED_BLADE_BUFF_ID)
            endif
        endif

        //Hammer of the Gods
        set r2 = r2 + GetUnitItemTypeCount(u,'I066') * 1.4

        //Flimsy Token
        if GetUnitAbilityLevel(u, FLIMSY_TOKEN_BUFF_ID) > 0 then
            set r2 = r2 + 0.3
        endif

        //Lightning Shield
        if GetUnitAbilityLevel(u, LIGHTNING_SHIELD_DUMMY_ABILITY_ID) > 0 then
            set r2 = r2 + 0.2
        endif

        //Speed Blade passive
        if UnitHasItemType(u,SPEED_BLADE_ITEM_ID) then
            set r2 = r2 * 0.8
        endif

        //Troll passive
        if GetUnitTypeId(u) == TROLL_BERSERKER_UNIT_ID then
            set r2 = r2 * TrollBerserkerBonus.real[hid]
        endif

        //Berserk Attack CD
        if GetUnitAbilityLevel(u, BERSERK_BUFF_ID) > 0 then
                set r2 = r2 * 0.5
        endif

        if r2 != BlzGetUnitAttackCooldown(u, 0) then
            call BlzSetUnitAttackCooldown(u, r2, 0)
        endif

        return r2
    endfunction
endlibrary
