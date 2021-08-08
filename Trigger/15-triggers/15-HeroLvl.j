globals
    integer array LastLvlHero
    integer array BRL_BONUS 
    boolean array Bonus25l
    boolean array Bonus50l
    boolean array Bonus75l
    boolean array Bonus100l
    boolean array Bonus125l
    boolean array Bonus150l
    boolean array Bonus175l
    boolean array Bonus200l
endglobals




function LetinantBonus takes unit UnitHero returns nothing
    local integer RandomI
    
        set RandomI = GetRandomInt(1,3)
        if RandomI == 1 then
            call SetHeroStr(UnitHero,GetHeroStr(UnitHero,false)+8,false) 
        elseif RandomI == 2 then
            call SetHeroAgi(UnitHero,GetHeroAgi(UnitHero,false)+8,false)   
        elseif RandomI == 3 then    
            call SetHeroInt(UnitHero,GetHeroInt(UnitHero,false)+8,false)   
        endif
        set RandomI = GetRandomInt(1,3)
        if RandomI == 1 then
            call SetHeroStr(UnitHero,GetHeroStr(UnitHero,false)+8,false) 
        elseif RandomI == 2 then
            call SetHeroAgi(UnitHero,GetHeroAgi(UnitHero,false)+8,false)   
        elseif RandomI == 3 then    
            call SetHeroInt(UnitHero,GetHeroInt(UnitHero,false)+8,false)   
        endif

endfunction


function BaraBonus takes unit UnitHero returns nothing
    local integer AbilLvl
    local integer AbilId


    set AbilId  = 'Aspl'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif

    set AbilId  = 'Auhf'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
    
    set AbilId  = 'AOsh'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif

    set AbilId  = 'AEer'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
    
    set AbilId  = 'ANdr'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
 
    set AbilId  = 'AEim'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
    
    set AbilId  = 'AHtb'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif   
    
    set AbilId  = 'ANcs'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif   
    
    set AbilId  = 'ACls'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif 
    
    set AbilId  = 'A017'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif 
             

    set AbilId  = 'ANvc'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif 

    set AbilId  = 'AOmi'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 40 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif 



endfunction






function MasterBonus takes unit UnitHero returns nothing
    local integer AbilLvl
    local integer AbilId


    set AbilId  = 'AHwe'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif

    set AbilId  = 'AHpx'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
    
    set AbilId  = 'AOsf'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif

    set AbilId  = 'AOsw'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
    
    set AbilId  = 'AUcb'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
 
    set AbilId  = 'AUin'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
    
    set AbilId  = 'Arai'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif   
    
    set AbilId  = 'AEsv'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif   
    
    set AbilId  = 'Arsq'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif 
    
    set AbilId  = 'ANsg'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
    
    
    set AbilId  = 'ANlm'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif 
    
    set AbilId  = 'ANsw'
    set AbilLvl =  GetUnitAbilityLevel(UnitHero,AbilId)
    if AbilLvl > 0 and AbilLvl < 30 then
        call SetUnitAbilityLevel(UnitHero,AbilId,AbilLvl+1) 
    endif
            
endfunction

function ItemLvlAction takes unit u, integer lvl returns nothing
local integer i = 0 

set i = UnitHasItemI(u,'I071')
if i > 0 then
     call SetHeroStr(u, GetHeroStr(u,false) + 2*i ,false)
endif
set i = UnitHasItemI(u,'I072')
if i > 0 then
     call SetHeroInt(u, GetHeroInt(u,false) + 2*i ,false)
endif
set i = UnitHasItemI(u,'I073')
if i > 0 then
     call SetHeroAgi(u, GetHeroAgi(u,false) + 2*i ,false)
endif



endfunction

function UpdateAbilityDesc takes unit h, player p, integer heroLvl returns nothing
    local integer abilLvl
    local integer abilId
    local string s
    
    set abilId = 'A089'
    set abilLvl = GetUnitAbilityLevel(h, abilId)
    if abilLvl > 0 then
        set s = GetDesriptionAbility(abilId, abilLvl -1)
        set s = UpdateAbilityDescription(s, p, abilId, ",s00,", R2I(SpellData[GetHandleId(h)].real[3]), abilLvl)
        call UpdateAbilityDescription(s, p, abilId, ",s01,", R2I((100 * abilLvl) * (1 + 0.02 * heroLvl)), abilLvl)
    endif
endfunction


function Trig_HeroLvl_Actions takes nothing returns nothing
    local integer RandomI
    local unit UnitHero = GetTriggerUnit()
    local integer TypeHero =  GetUnitTypeId(UnitHero)
    local integer I_l = GetHeroLevel(UnitHero)-1
    local player Pl = GetOwningPlayer(UnitHero)
    local integer Pid = GetPlayerId(Pl)
    local integer RI = I_l-LastLvlHero[Pid]
    local boolean Economic =  GetUnitAbilityLevel(UnitHero,'Asal') == 0 and GetUnitAbilityLevel(UnitHero,'A02W') == 0


    if I_l < 250 then
    
        if Economic then
          call AdjustPlayerStateBJ( (I_l+20)*(RI), Pl, PLAYER_STATE_RESOURCE_GOLD )
          call AdjustPlayerStateBJ( 8*(RI), Pl, PLAYER_STATE_RESOURCE_LUMBER)
        else
          call AdjustPlayerStateBJ( (I_l+2)*(RI), Pl, PLAYER_STATE_RESOURCE_GOLD )
          call AdjustPlayerStateBJ( 4*(RI), Pl, PLAYER_STATE_RESOURCE_LUMBER)
        endif
    
    endif
    

    if (Bonus25l[Pid])==false and I_l >= 25 then
	set Bonus25l[Pid] = true
  	call AdjustPlayerStateBJ( 25, Pl, PLAYER_STATE_RESOURCE_LUMBER) 
    endif
    if (Bonus50l[Pid])==false and I_l >= 50 then
	 set Bonus50l[Pid] = true
  	 call AdjustPlayerStateBJ( 50, Pl, PLAYER_STATE_RESOURCE_LUMBER)
    endif
    if (Bonus75l[Pid])==false and I_l >= 75 then
	 set Bonus75l[Pid] = true
  	 call AdjustPlayerStateBJ( 75, Pl, PLAYER_STATE_RESOURCE_LUMBER)
    endif
    if (Bonus100l[Pid])==false and I_l >= 100 then
	 set Bonus100l[Pid] = true
  	 call AdjustPlayerStateBJ( 125, Pl, PLAYER_STATE_RESOURCE_LUMBER)
    endif
    if (Bonus125l[Pid])==false and I_l >= 125 then
	 set Bonus125l[Pid] = true
  	 call AdjustPlayerStateBJ( 150, Pl, PLAYER_STATE_RESOURCE_LUMBER)
    endif
    if (Bonus150l[Pid])==false and I_l >= 150 then
	 set Bonus150l[Pid] = true
  	 call AdjustPlayerStateBJ( 175, Pl, PLAYER_STATE_RESOURCE_LUMBER)
    endif
    if (Bonus175l[Pid])==false and I_l >= 175 then
	 set Bonus175l[Pid] = true
  	 call AdjustPlayerStateBJ( 200, Pl, PLAYER_STATE_RESOURCE_LUMBER)
    endif
    if (Bonus200l[Pid])==false and I_l >= 200 then
	 set Bonus200l[Pid] = true
  	 call AdjustPlayerStateBJ( 300, Pl, PLAYER_STATE_RESOURCE_LUMBER)
    endif

    call ResourseRefresh(Pl) 

    call ItemLvlAction(UnitHero,RI)
    
    
    if TypeHero == 'E000' then //Letinant    

         loop
            exitwhen  LastLvlHero[Pid] ==  I_l
            call LetinantBonus(UnitHero)
            set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop
       
    elseif TypeHero == 'H005' then
    
              call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'Aap1'),ABILITY_RLF_DAMAGE_PER_SECOND_APL2,0,10+I_l*25 )
               set LastLvlHero[Pid] =   I_l
               
     elseif TypeHero == 'H006' then
     
         loop
            exitwhen  LastLvlHero[Pid] ==  I_l    
            call SetPlayerTechResearchedSwap( 'R002', ( 2 + GetPlayerTechCountSimple('R002', Pl) ), Pl )
            call SetPlayerTechResearchedSwap( 'R001', ( 3 + GetPlayerTechCountSimple('R001', Pl) ), Pl )
            set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop   
        
        
        
    elseif TypeHero == 'H002' then  
    
       
        loop
            exitwhen  LastLvlHero[Pid] ==  I_l     
            call BlzSetUnitMaxHP(UnitHero,  BlzGetUnitMaxHP(UnitHero) + 265 )
            call BlzSetUnitMaxMana(UnitHero,  BlzGetUnitMaxMana(UnitHero) + 265 )
            
             set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop 
      
      
      
        
    elseif TypeHero == 'H001' then  
  
         loop
            exitwhen  LastLvlHero[Pid] ==  I_l     

            call BlzSetUnitMaxMana(UnitHero,  BlzGetUnitMaxMana(UnitHero) + 600 )
            
             set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop  
   
     elseif TypeHero == 'H004' then  
     
      
             call SetUnitAbilityLevel(UnitHero,'A030',2)
             call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A030'),ABILITY_RLF_DAMAGE_BONUS_PERCENT,0, I2R(I_l+1)*0.02 )
             call SetUnitAbilityLevel(UnitHero,'A030',1)
         
             set LastLvlHero[Pid] =   I_l  
       
     elseif TypeHero == 'H003' then     
            loop
                exitwhen  LastLvlHero[Pid] ==  I_l     
                call SetHeroInt(UnitHero, GetHeroInt(UnitHero,false) + GetRandomInt(1,11) ,false)
                 if GetHeroStr(UnitHero,false) == 0 then
                    call SetHeroInt(UnitHero, GetHeroInt(UnitHero,false) + GetRandomInt(1,11) ,false)
                 endif
                 if GetHeroAgi(UnitHero,false) == 0 then
                    call SetHeroInt(UnitHero, GetHeroInt(UnitHero,false) + GetRandomInt(1,11) ,false)
                 endif  
             set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
           endloop  
         
     elseif TypeHero == 'O003' then  
     
            loop
                exitwhen  LastLvlHero[Pid] ==  I_l     
     
                set RandomI = GetRandomInt(1,3)
                
                if RandomI == 1 then
                    call SetHeroStr(UnitHero,GetHeroStr(UnitHero,false)+GetRandomInt(1,19) ,false) 
                elseif RandomI == 2 then
                    call SetHeroAgi(UnitHero,GetHeroAgi(UnitHero,false)+GetRandomInt(1,19),false)   
                elseif RandomI == 3 then    
                    call SetHeroInt(UnitHero,GetHeroInt(UnitHero,false)+GetRandomInt(1,19),false)   
                endif                

                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop    
            
     elseif TypeHero == 'O004' then 
     elseif TypeHero == 'O002' then   
     elseif TypeHero == 'O005' then   
     
            loop
                exitwhen  LastLvlHero[Pid] ==  I_l  
                
                 //call BlzSetUnitBaseDamage(UnitHero, BlzGetUnitBaseDamage(UnitHero,0) + 15 ,0)          
                 call BlzSetUnitDiceSides(UnitHero, BlzGetUnitDiceSides(UnitHero,0) + 35 ,0)  
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop      
            
     elseif TypeHero == 'O000' then                   
 
            loop
                exitwhen  BRL_BONUS[Pid] ==  I_l/2 
                
                 call BaraBonus(UnitHero)      
     
                set BRL_BONUS[Pid] = BRL_BONUS[Pid] + 1
            endloop   
                      
                      
                         
     elseif TypeHero == 'O008' then  
     
        loop
            exitwhen  LastLvlHero[Pid] ==  I_l    
            call SetPlayerTechResearchedSwap( 'R000', ( 2 + GetPlayerTechCountSimple('R000', Pl) ), Pl )
            set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop   
     
     
     
     
     elseif TypeHero == 'O007' then  
     
     
             loop
            exitwhen  LastLvlHero[Pid] ==  I_l  
           call AdjustPlayerStateBJ( 6, Pl, PLAYER_STATE_RESOURCE_LUMBER )    
           call BlzSetUnitMaxHP(UnitHero,  BlzGetUnitMaxHP(UnitHero) + 66 )
           call BlzSetUnitMaxMana(UnitHero,  BlzGetUnitMaxMana(UnitHero) + 66 )
            set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop            
          
     elseif TypeHero == 'O001' then      
     
     elseif TypeHero == 'U000' then       
        loop
            exitwhen  LastLvlHero[Pid] ==  I_l    
           
           if GetHeroStr(UnitHero,false)*2 > GetHeroAgi(UnitHero,false) then
              call    SetHeroAgi(UnitHero,GetHeroAgi(UnitHero,false) +20 ,false)
           elseif GetHeroStr(UnitHero,false) > GetHeroAgi(UnitHero,false)  then
              call    SetHeroAgi(UnitHero,GetHeroAgi(UnitHero,false) +10 ,false)           
           else
              call    SetHeroAgi(UnitHero,GetHeroAgi(UnitHero,false) +5 ,false)      
           endif
           
           
            set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop  
     elseif TypeHero == 'N00K' then          
             loop
                exitwhen  LastLvlHero[Pid] ==  I_l  
                
                 call BlzSetUnitBaseDamage(UnitHero, BlzGetUnitBaseDamage(UnitHero,0) + 16 ,0)          
     
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop  
            
                         
                
     elseif TypeHero == 'N024' then   
            loop
                exitwhen  LastLvlHero[Pid] ==  I_l  
                
        
                 call BlzSetUnitRealField(UnitHero,ConvertUnitRealField('uhpr'),BlzGetUnitRealField(UnitHero,ConvertUnitRealField('uhpr')) + 3)
                 call BlzSetUnitArmor(UnitHero, BlzGetUnitArmor(UnitHero) +2 )
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop      
                      
     elseif TypeHero == 'N00I' then   
     
     
            loop
                exitwhen  LastLvlHero[Pid] ==  I_l  
                
        
                 call BlzSetUnitRealField(UnitHero,ConvertUnitRealField('uhpr'),BlzGetUnitRealField(UnitHero,ConvertUnitRealField('uhpr')) + 6)
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop 
            
    elseif TypeHero == 'N00L' then  
    
    		call TriggerSleepAction(0.1)
            loop
                exitwhen  LastLvlHero[Pid] ==  I_l  
                
                 call AddHeroXP(UnitHero, (LastLvlHero[Pid]+1)*55  ,true)
                
               set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
           endloop  
           
            
    elseif TypeHero == 'H00A' then  
    
            loop
                exitwhen  LastLvlHero[Pid] ==  I_l  
                
                 
                    set Glory[Pid] = Glory[Pid] + 30
                    
               set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
           endloop          
            
            call ResourseRefresh(GetOwningPlayer(UnitHero)) 
    elseif TypeHero == 'N00P' then              
            
            
            
            loop
                exitwhen  BRL_BONUS [Pid] ==  I_l /2
                
                 call MasterBonus(UnitHero)      
     
                set BRL_BONUS[Pid] = BRL_BONUS[Pid] + 1
            endloop   
            
       
    elseif TypeHero == 'N00B' then                          
    
                    call SetUnitAbilityLevel(UnitHero,'A031',2)
        call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A031'),ABILITY_RLF_ARMOR_BONUS_HAD1,0, -(I_l+1)*3 )         
                   call SetUnitAbilityLevel(UnitHero,'A031',1)
            
          set LastLvlHero[Pid]  = I_l 
  
     elseif TypeHero == 'N00R' then         
        
     elseif TypeHero == 'N00O' then   
     
        loop
            exitwhen  LastLvlHero[Pid] ==  I_l    
            call SetPlayerTechResearchedSwap( 'R001', ( 2 + GetPlayerTechCountSimple('R001', Pl) ), Pl )
            call BlzSetUnitArmor(UnitHero, BlzGetUnitArmor(UnitHero) +2 )
            set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop  
        
     elseif TypeHero == 'H008' then   
     
     
     elseif TypeHero == 'N00Q' then     
     
     
    
        
            call SetUnitAbilityLevel(UnitHero,'A032',2)
             call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A032'),ABILITY_RLF_DAMAGE_BONUS_PERCENT,0, I2R(I_l+1)*25 )
             call SetUnitAbilityLevel(UnitHero,'A032',1)
         
             set LastLvlHero[Pid] =   I_l           
             
  
     elseif TypeHero == 'N00C' then          
              
        loop
            exitwhen  LastLvlHero[Pid] ==  I_l     
            call BlzSetUnitMaxHP(UnitHero,  BlzGetUnitMaxHP(UnitHero) + 600 )

            
             set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop 
        
     elseif TypeHero == 'O006' then         
     
             loop
                exitwhen  LastLvlHero[Pid] ==  I_l  
                
        
                 call BlzSetUnitRealField(UnitHero,ConvertUnitRealField('umpr'),BlzGetUnitRealField(UnitHero,ConvertUnitRealField('umpr')) + 15)
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop        
        
      elseif TypeHero == 'H007' then       
        
        
        
      elseif TypeHero == 'H000' then         
             call SetUnitAbilityLevel(UnitHero,'A034',2)
             call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A034'),ABILITY_RLF_DAMAGE_BONUS_HBH3 ,0,1 + I2R(I_l+1)*50 )
             call SetUnitAbilityLevel(UnitHero,'A034',1)
                          set LastLvlHero[Pid] =   I_l     
                          
                          
        elseif TypeHero == 'H016' then     
     
     
    
        
            call SetUnitAbilityLevel(UnitHero,'A038',2)
             call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A038'),ABILITY_RLF_INITIAL_DAMAGE_PXF1,0, I2R(I_l+1)*50 )
             call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A038'),ABILITY_RLF_DAMAGE_PER_SECOND_PXF2,0, I2R(I_l+1)*10 )
             call SetUnitAbilityLevel(UnitHero,'A038',1)
         
             set LastLvlHero[Pid] =   I_l   
             
                elseif TypeHero == 'N02K' then  
                                    
                                    
            call SetUnitAbilityLevel(UnitHero,'A03H',2)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A03H'),ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2,0, -(I_l+1)*0.06 )         
            call SetUnitAbilityLevel(UnitHero,'A03H',1)
            
          set LastLvlHero[Pid]  = I_l  

    	 elseif TypeHero == 'H01D' then         
     
             loop
                exitwhen  LastLvlHero[Pid] ==  I_l  
                
        	 call BlzSetUnitMaxMana(UnitHero,  BlzGetUnitMaxMana(UnitHero) + 100)
                 call BlzSetUnitRealField(UnitHero,ConvertUnitRealField('umpr'),BlzGetUnitRealField(UnitHero,ConvertUnitRealField('umpr')) + 1)
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop 
            
        elseif TypeHero == 'H017' then
     
         loop
            exitwhen  LastLvlHero[Pid] ==  I_l    
            call AddUnitBlock(UnitHero,16)
            set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
        endloop         
          
        elseif TypeHero == 'O00C' then
     
         loop
            exitwhen  LastLvlHero[Pid] ==  I_l    
            call AddUnitEvasion(UnitHero,0.9)
            set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
         endloop 
         
        elseif TypeHero == 'H01G' then
     
         loop
            exitwhen  LastLvlHero[Pid] ==  I_l    
            call AddUnitMagicDmg(UnitHero,2)
            set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
         endloop 
        
    endif
    
    call UpdateAbilityDesc(UnitHero, Pl, GetHeroLevel(UnitHero))

	 set LastLvlHero[Pid]  = I_l  
endfunction

//===========================================================================
function InitTrig_HeroLvl takes nothing returns nothing
    set gg_trg_HeroLvl = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_HeroLvl, EVENT_PLAYER_HERO_LEVEL )
    call TriggerAddAction( gg_trg_HeroLvl, function Trig_HeroLvl_Actions )
endfunction

