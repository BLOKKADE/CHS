// Damaged

 //! textmacro H01H_Ghoul
if GetUnitTypeId(u_a) == 'H01H' and  is_attack   then
    set r2 = i*12
    call Vamp(u_a,u_t,r2)
    set i = GetHeroLevel(u_a)
    set Damage = Damage + i*12
    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", u_a, "chest")) 
endif
//! endtextmacro