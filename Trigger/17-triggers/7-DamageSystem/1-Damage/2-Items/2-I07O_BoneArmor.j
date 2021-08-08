//Damaged 

 //! textmacro I07O_BoneArmor
set i = SkeletonDefender[GetPlayerId(GetOwningPlayer(GUT))]
if i > 0 and  IsHeroUnitId(GetUnitTypeId(u_t )) then
    set Damage = Damage - Damage*I2R(i)*0.08
endif
//! endtextmacro