//Damaged 

 //! textmacro AUav_Vampirism
set r1 = GetUnitAbilityLevel(u_a,'AUav')
if r1 > 0 then
    set r2 = Damage*(0.005 + 0.005*r1 +  LoadReal(HT,GetHandleId(u_a),-32145)*0.02 )
    call Vamp(u_a,u_t,r2)
    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", u_a, "chest"))   
endif
//! endtextmacro