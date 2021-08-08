//Damaged 

 //! textmacro AUts_Spiked_Carapace
 
 

if is_attack and GetUnitSpell(u_t,'AUts') > 0 and IsUnitType(u_a,UNIT_TYPE_MELEE_ATTACKER)  then 
    set A = GetAbilityData(u_t,'AUts')
    call LossHp(u_t,u_a,A.GetParam1()*Damage)

endif
//! endtextmacro