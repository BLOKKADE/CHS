globals

    hashtable HT_AbilityData  = InitHashtable()

    integer array AbilSpellRA1
    integer AbilSRA1_count = 0 
    integer array AbilSpellRA2
    integer AbilSRA2_count = 0 
    
    integer array AbilSpellRA3
    integer AbilSRA3_count = 0 
endglobals

function SaveAbilData takes integer Abil, string order, integer typ returns nothing

    call SaveInteger(HT_AbilityData,Abil,1,typ)
    call SaveStr(HT_AbilityData,Abil,2,order)
endfunction


function InitDataA1 takes nothing returns nothing
   call SaveAbilData('Aclf',"cloudoffog",2)
   call SaveAbilData('AHtb',"thunderbolt",1)
   call SaveAbilData('AHbn',"banish",1)
   call SaveAbilData('AHfs',"flamestrike",2)
   call SaveAbilData('AHwe',"waterelemental",3)
   call SaveAbilData('AHtc',"thunderclap",3)
   call SaveAbilData('AHhb',"holybolt",1)
   call SaveAbilData('AHbz',"blizzard",2)   
   call SaveAbilData('AHpx',"summonphoenix",3)  
   call SaveAbilData('Ainf',"innerfire",1)
   
   
    call SaveAbilData('AOww',"whirlwind",3)
    call SaveAbilData('AOhw',"healingwave",1)
    call SaveAbilData('AOws',"stomp",3)
    call SaveAbilData('AOls',"Locustswarm",3)
    call SaveAbilData('AOsw',"ward",2)
    call SaveAbilData('AOhx',"hex",3)
    call SaveAbilData('AOvd',"voodoo",3)
    call SaveAbilData('AOwk',"windwalk",3)
    call SaveAbilData('AOsh',"shockwave",2)
    call SaveAbilData('AOcl',"chainlightning",1)
    call SaveAbilData('Absk',"berserk",3)
    call SaveAbilData('Aspl',"spiritlink",1)
    call SaveAbilData('Ablo',"bloodlust",1)
    call SaveAbilData('Ahwd',"healingward",2)
    call SaveAbilData('Asta',"stasistrap",2)   
    
    
    
    call SaveAbilData('AUfn',"frostnova",1)  
    call SaveAbilData('AUcb',"Carrionscarabs",3)
    call SaveAbilData('AUin',"dreadlordinferno",2)
    call SaveAbilData('AUfu',"frostarmor",1)
    call SaveAbilData('AUim',"impale",2)
    call SaveAbilData('AUdp',"deathpact",1)
    call SaveAbilData('AUdd',"deathanddecay",2)
    call SaveAbilData('AUcs',"carrionswarm",2)
    call SaveAbilData('Aam2',"antimagicshell",1)
    call SaveAbilData('Arai',"raisedead",3)
    call SaveAbilData('Auhf',"unholyfrenzy",1)
    call SaveAbilData('Acrs',"curse",1)
   
    
    
    call SaveAbilData('AEsv',"spiritofvengeance",3)       
    call SaveAbilData('AEfk',"fanofknives",3)
    call SaveAbilData('AEer',"entanglingroots",1)
    call SaveAbilData('AEsf',"starfall",3)
    call SaveAbilData('AEim',"immolation",3)
    call SaveAbilData('AHfa',"flamingarrows",1)
    call SaveAbilData('AEtq',"tranquility",3)   
    call SaveAbilData('AEsh',"shadowstrike",1)       
    call SaveAbilData('Afae',"faeriefire",1)
    call SaveAbilData('Arej',"rejuvination",1)
    
    
    
    call SaveAbilData('ANhs',"healingspray",2)
    call SaveAbilData('ANbr',"battleroar",3)
    call SaveAbilData('ANvc',"volcano",2)
    call SaveAbilData('ANst',"stampede",2) 
    call SaveAbilData('ANcs',"clusterrockets",2)       
    call SaveAbilData('ANab',"acidbomb",1)
    call SaveAbilData('ANsi',"silence",2)
    call SaveAbilData('ANrf',"rainoffire",2)
    call SaveAbilData('ANbf',"breathoffire",2)
    call SaveAbilData('ANsy',"summonfactory",2)
    
    
    call SaveAbilData('Arsq',"summonquillbeast",3)    
    call SaveAbilData('ANsg',"summongrizzly",3)  
    call SaveAbilData('ANlm',"slimemonster",3)  
    call SaveAbilData('ANsw',"summonwareagle",3)  
    call SaveAbilData('ANfl',"forkedlightning",1)  
    call SaveAbilData('ANso',"soulburn",1)  
    call SaveAbilData('ACls',"lightningshield",1)  

    call SaveAbilData('ANdh',"drunkenhaze",1)    
    call SaveAbilData('A046',"breathoffrost",2)  
    call SaveAbilData('ANpa',"parasite",1)  
    call SaveAbilData('ANen',"ensnare",1)
     call SaveAbilData('ANht',"howlofterror",3)  

     call SaveAbilData('ANmo',"monsoon",2)
     call SaveAbilData('AOsf',"spiritwolf",3) 
     
     call SaveAbilData('A05X',"channel",2)
     call SaveAbilData('A017',"channel",2) 
     call SaveAbilData('ANsi',"silence",2) 
endfunction 

function InitDataRA2 takes nothing returns nothing

   set AbilSpellRA1[0] = 'AHtb'
   set AbilSpellRA1[1] = 'AHbn'
   set AbilSpellRA1[2] = 'AOhx'
   set AbilSpellRA1[3] = 'AOcl'
   set AbilSpellRA1[4] = 'AUfn'
   set AbilSpellRA1[5] = 'Auhf'
   set AbilSpellRA1[6] = 'Acrs'
   set AbilSpellRA1[7] = 'AEsh'
   set AbilSpellRA1[8] = 'Afae'
   set AbilSpellRA1[9] = 'AEer'
   set AbilSpellRA1[10] = 'ANab'
   set AbilSpellRA1[11] = 'ANso'
   set AbilSpellRA1[12] = 'ANdh'
   set AbilSpellRA1[13] = 'ANfl'  
   set AbilSpellRA1[14] = 'ACls'  
   set AbilSpellRA1[15] = 'ANpa'  
   set AbilSpellRA1[16] = 'ANen' 
   
   
   set AbilSRA1_count = 16
      

   set AbilSpellRA2[0] = 'AHfs'
   set AbilSpellRA2[1] = 'AHbz'
   set AbilSpellRA2[2] = 'AOsh'
   set AbilSpellRA2[3] = 'AUim'
   set AbilSpellRA2[4] = 'AUdd'
   set AbilSpellRA2[5] = 'AUcs'
   set AbilSpellRA2[6] = 'ANst'
   set AbilSpellRA2[7] = 'ANhs'
   set AbilSpellRA2[8] = 'ANcs'
   set AbilSpellRA2[9] = 'ANsi'
   set AbilSpellRA2[10] = 'ANrf'
   set AbilSpellRA2[11] = 'ANbf'
   set AbilSpellRA2[12] = 'A046'  
   set AbilSpellRA2[13] = 'Aclf'  
   set AbilSpellRA2[14] = 'Asta' 
   set AbilSpellRA2[15] = 'ANmo' 
   set AbilSpellRA2[16] = 'A05X' 
   set AbilSpellRA2[17] = 'A017'      
   set AbilSpellRA2[18] = 'A046'   
   
   set AbilSRA2_count = 18
   
   set AbilSpellRA3[0] = 'AHtc'  
   set AbilSpellRA3[1] = 'AOws'  
   set AbilSpellRA3[2] = 'AEsf' 
   set AbilSpellRA3[3] = 'AEfk'      
   set AbilSpellRA3[4] = 'ANht'      
   set AbilSRA3_count = 4  
   
   
   
   
   
   
   
   
   

endfunction



function Trig_AbilS_Copy_Actions takes nothing returns nothing
call InitDataA1()
call InitDataRA2()
endfunction

//===========================================================================
function InitTrig_AbilS_Copy takes nothing returns nothing
    set gg_trg_AbilS_Copy = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_AbilS_Copy, 0.00 )
    call TriggerAddAction( gg_trg_AbilS_Copy, function Trig_AbilS_Copy_Actions )
endfunction

