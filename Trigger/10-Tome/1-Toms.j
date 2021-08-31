globals
    real array MagicProt
    real array MagicPwr
    real array PvpBonus

endglobals

function PlayerAddGold takes player p, integer i returns nothing

call SetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD,  GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD) + i )

endfunction

function IncomeText takes integer pid, boolean all returns nothing
    local integer i = 0
    loop
        if all then
            if pid == i then
                call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, "|cffdfb632You upgraded your creeps to|r |cffd64646level "+I2S(BonusNeutral + BonusNeutralPlayer[pid]) + "|r (|cffdf9432Global level: "+ I2S(BonusNeutral) +"|r)")
            elseif IncomeSpamDisabled[i] == false then
                call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, GetPlayerNameColour(Player(pid))+" |cffdfb632upgrades your creeps to|r |cffd64646level "+I2S(BonusNeutral + BonusNeutralPlayer[pid]) + "|r (|cffdf9432Global level: "+ I2S(BonusNeutral) +"|r)")
            endif
        else
            if pid == i then
                call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, "|cffdfb632You upgraded your creeps to|r |cffd64646level "+I2S(BonusNeutral + BonusNeutralPlayer[pid]) + "|r")
            elseif IncomeSpamDisabled[i] == false then
                call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, GetPlayerNameColour(Player(pid))+" |cffdfb632upgrades the creeps for themselves to|r |cffd64646level "+I2S(BonusNeutralPlayer[pid] ))
            endif
        endif
        set i = i + 1
        exitwhen i > 8
    endloop
endfunction

function Trig_Toms_Actions takes nothing returns nothing
    local item It = GetManipulatedItem()
    local integer II = GetItemTypeId(It)
    local unit u = GetTriggerUnit()
    local player p = GetOwningPlayer(u)
    local integer pid = GetPlayerId(p)
    

    if II == 'I05H' then

       if GetHeroXP(GetTriggerUnit()) >=  20000  then
       
              call BlzSetUnitRealField(GetTriggerUnit(),ConvertUnitRealField('uagp'),  BlzGetUnitRealField(GetTriggerUnit(),ConvertUnitRealField('uagp')) + 1 )
              call SetHeroAgi(GetTriggerUnit(),GetHeroAgi(GetTriggerUnit(),false) - GetHeroLevel(GetTriggerUnit())+1 ,false)
              
              call UnitAddItemById(GetTriggerUnit(),'I05K')
              call RemoveItem(GetManipulatedItem())
       endif



    elseif   II == 'I05I' then

       if GetHeroXP(GetTriggerUnit()) >=  20000  then
       
              call BlzSetUnitRealField(GetTriggerUnit(),ConvertUnitRealField('uinp'),  BlzGetUnitRealField(GetTriggerUnit(),ConvertUnitRealField('uinp')) + 1 )
              call SetHeroInt(GetTriggerUnit(),GetHeroInt(GetTriggerUnit(),false) - GetHeroLevel(GetTriggerUnit())+1 ,false)
              
               call UnitAddItemById(GetTriggerUnit(),'I05K')
              call RemoveItem(GetManipulatedItem())
       endif
     elseif   II  == 'I05J' then

       if GetHeroXP(GetTriggerUnit()) >=  20000  then
       
              call BlzSetUnitRealField(GetTriggerUnit(),ConvertUnitRealField('ustp'),  BlzGetUnitRealField(GetTriggerUnit(),ConvertUnitRealField('ustp')) + 1 )
              call SetHeroStr(GetTriggerUnit(),GetHeroStr(GetTriggerUnit(),false) - GetHeroLevel(GetTriggerUnit())+1 ,false)
              
              call UnitAddItemById(GetTriggerUnit(),'I05K')
              
              call RemoveItem(GetManipulatedItem())
       endif
       
       
     elseif  II  == 'I06O' then
          if Glory[pid] >= 1500 then
              call BlzSetUnitArmor(u,BlzGetUnitArmor(u)+20)
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]-1500
          endif
     elseif  II  == 'I06N' then
          if Glory[pid] >= 1500 then
              call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+100,0)
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]-1500
          endif    
     elseif  II  == 'I06M' then
          if Glory[pid] >= 1500 then
              call BlzSetUnitRealField(u,ConvertUnitRealField('uhpr'),BlzGetUnitRealField(u,ConvertUnitRealField('uhpr')) + 30)
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]-1500
          endif      
      elseif  II  == 'I06Q' then
          if Glory[pid] >= 2000 then
            
              call AddUnitMagicDef(u,3)
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]-2000
          endif    
      elseif  II  == 'I06R' then
          if Glory[pid] >= 2000 then
              call AddUnitMagicDmg (u,3)
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]-2000
          endif    
      elseif  II  == 'I06T' then
          if Glory[pid] >= 2000 then
              call BlzSetUnitRealField(u,ConvertUnitRealField('umpr'),BlzGetUnitRealField(u,ConvertUnitRealField('umpr')) + 40)
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]-2000
          endif   
       elseif  II  == 'I06S' then
          if Glory[pid] >= 2000 then
             // set PvpBonus[pid] = PvpBonus[pid]+1.5
              call AddUnitPvpBonus(u,1.5)
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]-2000 
         endif  
       elseif  II  == 'I06P' then
          if Glory[pid] >= 1 then
              call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + R2I(Glory[pid]*1.5)  )
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]- R2I(Glory[pid]) 
         endif      
       elseif  II  == 'I06U' then
          if Glory[pid] >= 1 then
              call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) + R2I(Glory[pid])  )
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]- R2I(Glory[pid]) 
         endif  

       elseif  II  == 'I06W' then   
    	   if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
    	        call UnitAddItem(u,CreateItem('I06V',0,0))
    	        set  Glory[pid]= Glory[pid]- 10000 
	       else
                call PlayerAddGold( GetOwningPlayer(u),15000)
	     endif
       elseif  II  == 'I070' then   
    	   if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
    	        call UnitAddItem(u,CreateItem('I06X',0,0))
    	        set  Glory[pid]= Glory[pid]- 10000 
	       else
                call PlayerAddGold( GetOwningPlayer(u),15000)
	     endif
       elseif  II  == 'I06Z' then   
    	   if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
    	        call UnitAddItem(u,CreateItem('I06Y',0,0))
    	        set  Glory[pid]= Glory[pid]- 10000 
	       else
                call PlayerAddGold( GetOwningPlayer(u),15000)
	     endif	   
       elseif  II  == 'I074' then   

		set Income[pid] = Income[pid] + 90
		set BonusNeutral = BonusNeutral  + 1
		set BonusNeutralPlayer[pid] =BonusNeutralPlayer[pid] +  3
        call IncomeText(pid, true)
        
        elseif  II  == 'I09O' then   

		set Income[pid] = Income[pid] + 90
		set BonusNeutralPlayer[pid] =BonusNeutralPlayer[pid] +  4
		call IncomeText(pid, false)

       elseif   II == 'I07D' then
           if GetHeroXP(u) >=  100000  then
              set Lives[pid] = Lives[pid] + 1
                  call UnitAddItemById(u,'I07C')
                  call RemoveItem(GetManipulatedItem())
           endif
           
        elseif II == 'I09D' then
            if GetHeroXP(u) >= 50000 and AddHeroMaxAbsoluteAbility(u)then
                call UnitAddItemById(GetTriggerUnit(),'I09E')

            else
                call PlayerAddGold( GetOwningPlayer(u),8000)  

            endif
	else
       
    endif


	call ResourseRefresh(GetOwningPlayer(u)) 
	set It = null
	set u =null

endfunction


//===========================================================================
function InitTrig_Toms takes nothing returns nothing
    set gg_trg_Toms = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Toms, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddAction( gg_trg_Toms, function Trig_Toms_Actions )
endfunction

