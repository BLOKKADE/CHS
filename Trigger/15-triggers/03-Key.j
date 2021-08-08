globals

    integer array SpellCP

endglobals


function Trig_Key_Actions takes nothing returns nothing
    local integer Pid = GetPlayerId(GetTriggerPlayer())
    local oskeytype Key = BlzGetTriggerPlayerKey()
    
    
    call DisplayTextToPlayer(GetLocalPlayer(),0,0,I2S(SpellCP[Pid]))
    call BlzSetAbilityStringField(BlzGetUnitAbility( udg_units01[Pid+1] ,SpellCP[Pid] )  ,ConvertAbilityStringField('ahky'),"J")
    call BlzSetAbilityIntegerField(BlzGetUnitAbility( udg_units01[Pid+1] ,SpellCP[Pid] )  ,ConvertAbilityIntegerField('ahky'),74)

endfunction


function ReigsterKeyEvent takes trigger tr, oskeytype key,integer metaKey,boolean keyDown returns nothing


   call BlzTriggerRegisterPlayerKeyEvent(tr,Player(0),key,metaKey,keyDown)
   call BlzTriggerRegisterPlayerKeyEvent(tr,Player(1),key,metaKey,keyDown)
   call BlzTriggerRegisterPlayerKeyEvent(tr,Player(2),key,metaKey,keyDown)
   call BlzTriggerRegisterPlayerKeyEvent(tr,Player(3),key,metaKey,keyDown)
   call BlzTriggerRegisterPlayerKeyEvent(tr,Player(4),key,metaKey,keyDown)
   call BlzTriggerRegisterPlayerKeyEvent(tr,Player(5),key,metaKey,keyDown)
   call BlzTriggerRegisterPlayerKeyEvent(tr,Player(6),key,metaKey,keyDown)
   call BlzTriggerRegisterPlayerKeyEvent(tr,Player(7),key,metaKey,keyDown)   
   

endfunction




//===========================================================================
function InitTrig_Key takes nothing returns nothing
    set gg_trg_Key = CreateTrigger(  )

    call ReigsterKeyEvent(gg_trg_Key,OSKEY_Q,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_W,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_E,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_R,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_T,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_Y,0,true)  
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_U,0,true) 
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_I,0,true) 
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_O,0,true)  
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_P,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_A,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_S,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_D,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_F,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_G,0,true)  
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_H,0,true) 
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_J,0,true) 
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_K,0,true) 
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_L,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_Z,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_X,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_C,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_V,0,true)
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_B,0,true)  
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_N,0,true) 
    call ReigsterKeyEvent(gg_trg_Key,OSKEY_M,0,true) 
    
    call TriggerAddAction( gg_trg_Key, function Trig_Key_Actions )
endfunction

