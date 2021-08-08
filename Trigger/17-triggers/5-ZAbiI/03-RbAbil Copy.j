globals


    integer array AbilSpellRB1
    integer AbilSRB1_count = 0 
    integer array AbilSpellRB2
    integer AbilSRB2_count = 0 
    
    integer array AbilSpellRB3
    integer AbilSRB3_count = 0 
endglobals



function InitDataRA4 takes nothing returns nothing

   set AbilSpellRB1[0] = 'AHtb'
   set AbilSpellRB1[1] = 'AHbn'
   set AbilSpellRB1[2] = 'AOhx'
   set AbilSpellRB1[3] = 'AOcl'
   set AbilSpellRB1[4] = 'AUfn'
   set AbilSpellRB1[5] = 'Auhf'
   set AbilSpellRB1[6] = 'Acrs'
   set AbilSpellRB1[7] = 'AEsh'
   set AbilSpellRB1[8] = 'Afae'
   set AbilSpellRB1[9] = 'AEer'
   set AbilSpellRB1[10] = 'ANab'
   set AbilSpellRB1[11] = 'ANso'
   set AbilSpellRB1[12] = 'ANdh'
   set AbilSpellRB1[13] = 'ANfl'  
   set AbilSpellRB1[14] = 'ACls'  
   set AbilSpellRB1[15] = 'ANpa'  
   set AbilSpellRB1[16] = 'ANen' 
   
   
   set AbilSRB1_count = 16
      

   set AbilSpellRB2[0] = 'AHfs'
   set AbilSpellRB2[1] = 'AHbz'
   set AbilSpellRB2[2] = 'AOsh'
   set AbilSpellRB2[3] = 'AUim'
   set AbilSpellRB2[4] = 'AUdd'
   set AbilSpellRB2[5] = 'AUcs'
   set AbilSpellRB2[6] = 'ANst'
   set AbilSpellRB2[7] = 'ANhs'
   set AbilSpellRB2[8] = 'ANcs'
   set AbilSpellRB2[9] = 'ANsi'
   set AbilSpellRB2[10] = 'ANrf'
   set AbilSpellRB2[11] = 'ANbf'
   set AbilSpellRB2[12] = 'A046'  
   set AbilSpellRB2[13] = 'Aclf'  
   set AbilSpellRB2[14] = 'Asta' 
   set AbilSpellRB2[15] = 'ANmo' 
   set AbilSpellRB2[16] = 'A05X' 
   set AbilSpellRB2[17] = 'A017'
   set AbilSpellRB2[18] = 'A046'   
   set AbilSRB2_count = 18
   
   set AbilSpellRB3[0] = 'AHtc'  
   set AbilSpellRB3[1] = 'AOws'  
   set AbilSpellRB3[2] = 'AEsf' 
   set AbilSpellRB3[3] = 'AEfk'      
   set AbilSpellRB3[4] = 'ANht'      
   set AbilSpellRB3[5] = 'AOsw'   
   set AbilSpellRB3[6] = 'AOsf' 
   set AbilSpellRB3[7] = 'AHwe'
      
   set AbilSRB3_count = 7  
   
   
   
   
   
   
   
   
   

endfunction


function GetRandomAbility1_B takes nothing returns integer
local integer I1 = GetRandomInt(0,AbilSRB1_count+AbilSRB2_count+AbilSRB3_count+2)


if I1 <=  AbilSRB1_count then

return AbilSpellRB1[I1]

elseif I1  <= AbilSRB1_count + AbilSRB2_count + 1 then

return AbilSpellRB2[I1-AbilSRB1_count-1]

else
return AbilSpellRB3[I1-AbilSRB1_count-AbilSRB2_count-2]

endif




return AbilSpellRB1[GetRandomInt(0,AbilSRB1_count) ] 
endfunction









function Trig_RbAbil_Copy_Actions takes nothing returns nothing

call InitDataRA4()
endfunction

//===========================================================================
function InitTrig_RbAbil_Copy takes nothing returns nothing
    set gg_trg_RbAbil_Copy = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_RbAbil_Copy, 0.00 )
    call TriggerAddAction( gg_trg_RbAbil_Copy, function Trig_RbAbil_Copy_Actions )
endfunction

