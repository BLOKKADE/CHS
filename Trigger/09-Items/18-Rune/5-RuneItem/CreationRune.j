library CreationRune requires RandomShit, CustomState, SpellFormula
    function CreationRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local unit U
        
        set U = CreateUnit( GetOwningPlayer(u),'h01Z',GetUnitX(u)+ 40 * CosBJ(- 30 + GetUnitFacing(u)),GetUnitY(u)+ 40 * SinBJ(- 30 + GetUnitFacing(u)),GetUnitFacing(u) )
            call BlzSetUnitMaxHP(U, BlzGetUnitMaxHP(U)- 1000 + R2I(GetHeroLevel(u)*(1000)/* * (1 + GetUnitAbsoluteEffective(u,Element_Wild))*/))
            call BlzSetUnitBaseDamage(U,BlzGetUnitBaseDamage(U,0) + 150 + R2I((50)* GetHeroLevel(u) /** (1 + GetUnitAbsoluteEffective(u,Element_Wild))*/) ,0)
            call SetWidgetLife(U,BlzGetUnitMaxHP(U) )
            call AddUnitCustomState(U, BONUS_MAGICRES, 66)
            call UnitAddAbility(U, 'A06I')
            call SetUnitAbilityLevel(U, 'A06I', 30)

            call UnitAddAbility(U, BASH_ABILITY_ID)
            call SetUnitAbilityLevel(U, BASH_ABILITY_ID, 30)

            call UnitAddAbility(U, CUTTING_ABILITY_ID)
            call SetUnitAbilityLevel(U, CUTTING_ABILITY_ID, 30)
            call IssueImmediateOrderById(U, 852185) 
            call UnitApplyTimedLife(U,FEARLESS_DEFENDERS_ABILITY_ID,15)
            

        set u = null
        set U = null
        return false
    endfunction
endlibrary
