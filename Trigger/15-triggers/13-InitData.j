 globals
 
    integer array ItemN1
    
    integer array ItemN2
    
    integer array ItemN3
        
    
 
 endglobals
 
 
 function InitNagradi takes nothing returns nothing
 
 set ItemN1[1] =  'I01I'              //5
 set ItemN1[2] =  'I01F'
 set ItemN1[3] =  'I01G'
 set ItemN1[4] =  'I01H'
 
 set ItemN1[5] =  'I01J'             //10
 set ItemN1[6] =  'I01K'
 set ItemN1[7] =  'I01L'
 set ItemN1[8] =  'I01M'
 
 set ItemN1[9] =  'I01N'            //15
 set ItemN1[10] =  'I01O'
 set ItemN1[11] =  'I01P'
 set ItemN1[12] =  'I01Q' 
 

 set ItemN1[13] =  'I01D'           //20
 set ItemN1[14] =  'I01C'
 set ItemN1[15] =  'I03O'
 set ItemN1[16] =  'I03P'   
 
 
 
 set ItemN1[17] =  'I06K'   //25
 set ItemN1[18] =  'I04V'
 set ItemN1[19] =  'I04W'
 set ItemN1[20] =  'I061'
 
 
 set ItemN1[21] =  'I04Q'   //30
 set ItemN1[22] =  'I065'
 set ItemN1[23] =  'I06H'
 set ItemN1[24] =  'I04J'
 
 
 set ItemN1[25] =  'I06J'   //35
 set ItemN1[26] =  'I05G'
 set ItemN1[27] =  'I064'
 set ItemN1[28] =  'I05A' 
 

 set ItemN1[29] =  'I066'   //40
 set ItemN1[30] =  'I059'
 set ItemN1[31] =  'I06B'
 set ItemN1[32] =  'I05L'
 
 
 set ItemN1[33] =  'I04P'   //45
 set ItemN1[34] =  'I05D'
 set ItemN1[35] =  'I05B'
 set ItemN1[36] =  'I05U'
   
 
 
 
 endfunction

function Trig_InitData_Actions takes nothing returns nothing
call InitNagradi()
call InitBuffForLevel()
endfunction

//===========================================================================
function InitTrig_InitData takes nothing returns nothing
    set gg_trg_InitData = CreateTrigger(  )
    call TriggerAddAction( gg_trg_InitData, function Trig_InitData_Actions )
endfunction

