// Damaged

 //! textmacro O002_DreadLord
if GetUnitTypeId(u_a) == 'O002' then
    set r2 = Damage*(0.02*I2R(GetHeroLevel(u_a)) )
    call Vamp(u_a,u_t,r2)
    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", u_a, "chest"))
endif
//! endtextmacro