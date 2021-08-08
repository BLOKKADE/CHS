//Damaged 

 //! textmacro AEah_Thorns
 
 

if is_attack and GetUnitSpell(u_t,'AEah') > 0 then 
    set A = GetAbilityData(u_t,'AEah')
    call LossHp(u_t,u_a,A.GetParam1()*Damage)

endif
//! endtextmacro