//Damaged 

 //! textmacro I05G_MagicNecklaceOfAbsorption
if GetUnitAbilityLevel(u_t  ,'B00R') >= 1 and  BlzGetEventDamageType() !=  DAMAGE_TYPE_NORMAL  then
    if u_t == u_a then
        call AddHeroXP(u_t, R2I(Damage*0.015),true)
    else
        call AddHeroXP(u_t, R2I(Damage*0.15),true)
    endif
    call SetUnitState(u_t,UNIT_STATE_MANA,   GetUnitState( u_t  , UNIT_STATE_MANA  )  +     Damage*0.75 )
endif
 //! endtextmacro