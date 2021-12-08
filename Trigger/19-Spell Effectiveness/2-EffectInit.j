/*function DataEffect takes integer spell, integer id, integer fieldId  returns nothing
call SaveInteger(HT,spell,- 23000 + id,fieldId)
endfunction




function Trig_EffectInit_Actions takes nothing returns nothing

    call DataEffect(CLOUD_DUMMY_ABILITY_ID,0,'ahdu')
    call DataEffect(CLOUD_DUMMY_ABILITY_ID,1,'aare')
    call DataEffect(CLOUD_DUMMY_ABILITY_ID,2,'Nsi3')

    call DataEffect('AHav',0,'Hav3')
    call DataEffect('AHav',1,'Hav1')
    call DataEffect('AHav',2,'Hav2')

    call DataEffect(DEVOTION_AURA_ABILITY_ID,0,'Had1')

    call DataEffect(BRILLIANCE_AURA_ABILITY_ID,0,'Hab1')

    call DataEffect(DIVINE_SHIELD_ABILITY_ID,0,'ahdu')

    call DataEffect(STORM_BOLT_ABILITY_ID,0,'Htb1')
    call DataEffect(STORM_BOLT_ABILITY_ID,1,'ahdu')

    call DataEffect(BANISH_ABILITY_ID,0,'ahdu')

    call DataEffect(DIVINE_SHIELD_ABILITY_ID,0,'Hfs1')
    call DataEffect(DIVINE_SHIELD_ABILITY_ID,1,'Hfs3')

    call DataEffect(THUNDER_CLAP_ABILITY_ID,0,'Htc1')

    call DataEffect('AHnb',0,'Hhb1')

    call DataEffect(BLIZZARD_DUMMY_ABILITY_ID,0,'Hnz2')

    call DataEffect(INNER_FIRE_ABILITY_ID,0,'Inf2')
    call DataEffect(INNER_FIRE_ABILITY_ID,1,'Inf1')

    call DataEffect('Aoar',0,'Oar1')

    call DataEffect(SLOW_AURA_ABILITY_ID,0,'Oae2')
    call DataEffect(SLOW_AURA_ABILITY_ID,1,'Oae1')

    call DataEffect(ENDURANCE_AURA_ABILITY_ID,0,'Oae1')
    call DataEffect(ENDURANCE_AURA_ABILITY_ID,1,'Oae2')

    call DataEffect('AOhv',0,'Ocl1')

    call DataEffect(WAR_STOMP_ABILITY_ID,0,'Wrs1')
    call DataEffect(WAR_STOMP_ABILITY_ID,1,'ahdu')
    call DataEffect(WAR_STOMP_ABILITY_ID,2,'aduu')

    call DataEffect(SHOCKWAVE_ABILITY_ID,0,'Osh1')

    call DataEffect(CHAIN_LIGHTNING_ABILITY_ID,0,'Ocl1')

    call DataEffect(BERSERK_ABILITY_ID,0,'ahdu')

    call DataEffect(WAR_DRUMS_ABILITY_ID,0,'Akb1')

    call DataEffect(BLOODLUST_ABILITY_ID,0,'Blo1')
    call DataEffect(BLOODLUST_ABILITY_ID,1,'Blo2')
    call DataEffect(BLOODLUST_ABILITY_ID,2,'Blo3')


    call DataEffect(STASIS_TRAP_ABILITY_ID,0,'Sta4')


endfunction

//===========================================================================
function InitTrig_EffectInit takes nothing returns nothing
    set gg_trg_EffectInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_EffectInit, function Trig_EffectInit_Actions )
endfunction

*/