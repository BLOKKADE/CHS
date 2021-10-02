/*function DataEffect takes integer spell, integer id, integer fieldId  returns nothing
call SaveInteger(HT,spell,- 23000 + id,fieldId)
endfunction




function Trig_EffectInit_Actions takes nothing returns nothing

    call DataEffect('Aclf',0,'ahdu')
    call DataEffect('Aclf',1,'aare')
    call DataEffect('Aclf',2,'Nsi3')

    call DataEffect('AHav',0,'Hav3')
    call DataEffect('AHav',1,'Hav1')
    call DataEffect('AHav',2,'Hav2')

    call DataEffect('AHad',0,'Had1')

    call DataEffect('AHab',0,'Hab1')

    call DataEffect('AHds',0,'ahdu')

    call DataEffect('AHtb',0,'Htb1')
    call DataEffect('AHtb',1,'ahdu')

    call DataEffect('AHbn',0,'ahdu')

    call DataEffect('AHds',0,'Hfs1')
    call DataEffect('AHds',1,'Hfs3')

    call DataEffect('AHtc',0,'Htc1')

    call DataEffect('AHnb',0,'Hhb1')

    call DataEffect('AHbz',0,'Hnz2')

    call DataEffect('Ainf',0,'Inf2')
    call DataEffect('Ainf',1,'Inf1')

    call DataEffect('Aoar',0,'Oar1')

    call DataEffect('AOr2',0,'Oae2')
    call DataEffect('AOr2',1,'Oae1')

    call DataEffect('AOae',0,'Oae1')
    call DataEffect('AOae',1,'Oae2')

    call DataEffect('AOhv',0,'Ocl1')

    call DataEffect('AOws',0,'Wrs1')
    call DataEffect('AOws',1,'ahdu')
    call DataEffect('AOws',2,'aduu')

    call DataEffect('AOsh',0,'Osh1')

    call DataEffect('AOcl',0,'Ocl1')

    call DataEffect('Absk',0,'ahdu')

    call DataEffect('Aakb',0,'Akb1')

    call DataEffect('Ablo',0,'Blo1')
    call DataEffect('Ablo',1,'Blo2')
    call DataEffect('Ablo',2,'Blo3')


    call DataEffect('Asta',0,'Sta4')


endfunction

//===========================================================================
function InitTrig_EffectInit takes nothing returns nothing
    set gg_trg_EffectInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_EffectInit, function Trig_EffectInit_Actions )
endfunction

*/