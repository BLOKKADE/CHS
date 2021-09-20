globals
    real array MagicProt
    real array MagicPwr
    real array PvpBonus

endglobals

function PlayerAddGold takes player p, integer i returns nothing

call SetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD,  GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD) + i )

endfunction

function PlayerReturnLumber takes item it, integer II, player p returns nothing 
    call AdjustPlayerStateBJ(BlzGetItemIntegerField(it, ConvertItemIntegerField('iclr') ),p,PLAYER_STATE_RESOURCE_LUMBER)
    call ResourseRefresh(p)
    call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName(II) + " - [|cffffcc00Max Level|r]")
endfunction

function IncomeText takes integer pid, boolean all returns nothing
    local integer i = 0
    loop
        if all then
            if pid == i then
                call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, "|cffdfb632You upgraded your creeps to|r |cffd64646level "+I2S(BonusNeutral + BonusNeutralPlayer[pid]) + "|r (|cffdf9432Global level: "+ I2S(BonusNeutral) +"|r)")
            elseif IncomeSpamDisabled[i] == false then
                call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, GetPlayerNameColour(Player(pid))+" |cffdfb632upgrades your creeps to|r |cffd64646level "+I2S(BonusNeutral + BonusNeutralPlayer[i]) + "|r (|cffdf9432Global level: "+ I2S(BonusNeutral) +"|r)")
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
       if GetHeroXP(u) >=  20000  then
              call AddAgilityLevelBonus(u, 1)
              
              call UnitAddItemById(u,'I05K')
              call RemoveItem(It)
       endif

    elseif   II == 'I05I' then
       if GetHeroXP(u) >=  20000  then
            call AddIntelligenceLevelBonus(u, 1)
               call UnitAddItemById(u,'I05K')
              call RemoveItem(It)
       endif

    elseif   II  == 'I05J' then
       if GetHeroXP(u) >=  20000  then
              call AddStrengthLevelBonus(u, 1)
              call UnitAddItemById(u,'I05K')
              
              call RemoveItem(It)
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
              call BlzSetUnitRealField(u,ConvertUnitRealField('uhpr'),BlzGetUnitRealField(u,ConvertUnitRealField('uhpr')) + 150)
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
          if Glory[pid] >= 1500 then
              call BlzSetUnitRealField(u,ConvertUnitRealField('umpr'),BlzGetUnitRealField(u,ConvertUnitRealField('umpr')) + 100)
              call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
              set  Glory[pid]= Glory[pid]-1500
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
        elseif  II  == 'I09W' then
            if Glory[pid] >= 1500 then
                call SetHeroStr(u, GetHeroStr(u, false) + 30, true)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                set  Glory[pid]= Glory[pid]- 1500
           endif  
        elseif  II  == 'I09X' then
            if Glory[pid] >= 1200 then
                call SetHeroAgi(u, GetHeroAgi(u, false) +30, true)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                set  Glory[pid]= Glory[pid]- 1200
           endif  
        elseif  II  == 'I09U' then
            if Glory[pid] >= 1000 then
                call SetHeroInt(u, GetHeroInt(u, false) + 30, true)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                set  Glory[pid]= Glory[pid]- 1000
           endif  
        elseif  II  == 'I09Y' then
            if Glory[pid] >= 1500 then
                call AddUnitEvasion(u, 5)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                set  Glory[pid]= Glory[pid]- 1500
           endif  
        elseif  II  == 'I09V' then
            if Glory[pid] >= 2000 then
                call AddUnitBlock(u, 100)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                set  Glory[pid]= Glory[pid]- 2000
           endif 
        elseif  II  == 'I09T' then
            if Glory[pid] >= 10000 and GetUnitMoveSpeed(u) < 522 then
                call SetUnitMoveSpeed(u, 522)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                set  Glory[pid]= Glory[pid]- 10000
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

        //Vigour Token
        elseif  II  == 'I0A4' then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                 call UnitAddItem(u,CreateItem('I0A2',0,0))
                 set  Glory[pid]= Glory[pid]- 10000 
            else
                 call PlayerAddGold( GetOwningPlayer(u),20000)
          endif

        //Flimsy Token
        elseif  II  == 'I0A6' then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                 call UnitAddItem(u,CreateItem('I0A3',0,0))
                 set  Glory[pid]= Glory[pid]- 10000 
            else
                 call PlayerAddGold( GetOwningPlayer(u),20000)
          endif

        //Spellbane Token
        elseif  II  == 'I0A5' then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                 call UnitAddItem(u,CreateItem('I0A1',0,0))
                 set  Glory[pid]= Glory[pid]- 10000 
            else
                 call PlayerAddGold( GetOwningPlayer(u),20000)
          endif	
        
        //Mask of Elusion
        elseif  II  == 'I0A8' then   
            if Glory[pid] >= 20000 and UnitHasFullItems(u) == false then
                 call UnitAddItem(u,CreateItem('I0AD',0,0))
                 set  Glory[pid]= Glory[pid]- 20000 
            else
                 call PlayerAddGold( GetOwningPlayer(u),30000)
          endif

        //Mask of Vitality
        elseif  II  == 'I0A7' then   
            if Glory[pid] >= 20000 and UnitHasFullItems(u) == false then
                 call UnitAddItem(u,CreateItem('I0AC',0,0))
                 set  Glory[pid]= Glory[pid]- 20000 
            else
                 call PlayerAddGold( GetOwningPlayer(u),30000)
          endif

        //Mask of Protection
        elseif  II  == 'I0A9' then   
            if Glory[pid] >= 20000 and UnitHasFullItems(u) == false then
                 call UnitAddItem(u,CreateItem('I0AE',0,0))
                 set  Glory[pid]= Glory[pid]- 20000 
            else
                 call PlayerAddGold( GetOwningPlayer(u),30000)
          endif	

          //Sword of Blodthirst
        elseif  II  == 'I0AG' then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                 call UnitAddItem(u,CreateItem('I0AI',0,0))
                 set  Glory[pid]= Glory[pid]- 10000 
            else
                 call PlayerAddGold( GetOwningPlayer(u),15000)
          endif

        //Wisdom Chestplate
        elseif  II  == 'I0AA' then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                 call UnitAddItem(u,CreateItem('I0AH',0,0))
                 set  Glory[pid]= Glory[pid]- 10000 
            else
                 call PlayerAddGold( GetOwningPlayer(u),30000)
          endif

        //Lucky Pants
        elseif  II  == 'I0AB' then   
            if Glory[pid] >= 20000 and UnitHasFullItems(u) == false then
                 call UnitAddItem(u,CreateItem('I0AJ',0,0))
                 set  Glory[pid]= Glory[pid]- 20000 
            else
                 call PlayerAddGold( GetOwningPlayer(u),30000)
          endif	

        //Income all
       elseif  II  == 'I074' then   

            set Income[pid] = Income[pid] + 90
            set BonusNeutral = BonusNeutral  + 1
            set BonusNeutralPlayer[pid] =BonusNeutralPlayer[pid] +  3
            call IncomeText(pid, true)
            
        //Income individual
        elseif  II  == 'I09O' then   

		set Income[pid] = Income[pid] + 90
		set BonusNeutralPlayer[pid] =BonusNeutralPlayer[pid] +  4
		call IncomeText(pid, false)

        //Life
       elseif   II == 'I07D' then
           if GetHeroXP(u) >=  100000  then
              set Lives[pid] = Lives[pid] + 1
              call DisplayTimedTextToPlayer(p, 0, 0, 5, "|cffffcc00Lives: |r" + I2S(Lives[pid]))
                  call UnitAddItemById(u,'I07C')
                  call RemoveItem(It)
           endif
           
        //Absolute Acorn
        elseif II == 'I09D' then
            if GetHeroXP(u) >= 50000 and AddHeroMaxAbsoluteAbility(u)then
                call UnitAddItemById(u,'I09E')
            else
                call PlayerAddGold( GetOwningPlayer(u),8000)  

            endif
        
        //Summon Attack
        elseif II == 'I04K' then
            call SetPlayerTechResearched(p, 'R000', GetPlayerTechCount(p, 'R000', true) + 1)
            call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName(II) + " - [|cffffcc00Level " + I2S(GetPlayerTechCount(p, 'R000', true)) + "|r]")

        //Summon Armor
        elseif II == 'I04L' then
            call SetPlayerTechResearched(p, 'R001', GetPlayerTechCount(p, 'R001', true) + 1)
            call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName(II) + " - [|cffffcc00Level " + I2S(GetPlayerTechCount(p, 'R001', true)) + "|r]")

        //Summon hit points
        elseif II == 'I04M' then
            call SetPlayerTechResearched(p, 'R002', GetPlayerTechCount(p, 'R002', true) + 1)
            call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName(II) + " - [|cffffcc00Level " + I2S(GetPlayerTechCount(p, 'R002', true)) + "|r]")
        
        //Summon Crit
        elseif II == 'I0AP' then
            if SummonCrit[pid] < 30 then
                set SummonCrit[pid] = SummonCrit[pid] + 1
                call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName(II) + " - [|cffffcc00Level " + I2S(SummonCrit[pid]) + "|r]")
            else
                call PlayerReturnLumber(It, II, p)
            endif
        //Summon Cutting
        elseif II == 'I0AS' then
            if SummonCutting[pid] < 30 then
                set SummonCutting[pid] = SummonCutting[pid] + 1
                call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName(II) + " - [|cffffcc00Level " + I2S(SummonCutting[pid]) + "|r]")
            else
                call PlayerReturnLumber(It, II, p)
            endif
        //Summon Ice Armor
        elseif II == 'I0AQ' then
            if SummonIceArmor[pid] < 30 then
                set SummonIceArmor[pid] = SummonIceArmor[pid] + 1
                call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName(II) + " - [|cffffcc00Level " + I2S(SummonIceArmor[pid]) + "|r]")
            else
                call PlayerReturnLumber(It, II, p)
            endif
        //Summon Last Breath
        elseif II == 'I0AR' then
            if SummonLastBreath[pid] < 30 then
                set SummonLastBreath[pid] = SummonLastBreath[pid] + 1
                call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName(II) + " - [|cffffcc00Level " + I2S(SummonLastBreath[pid]) + "|r]")
            else
                call PlayerReturnLumber(It, II, p)
            endif
        //Summon Wild Defense
        elseif II == 'I087' then
            if SummonWildDefense[pid] < 30 then
                set SummonWildDefense[pid] = SummonWildDefense[pid] + 1
                call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName(II) + " - [|cffffcc00Level " + I2S(SummonWildDefense[pid]) + "|r]")
            else
                call PlayerReturnLumber(It, II, p)
            endif
    endif


	call ResourseRefresh(GetOwningPlayer(u)) 
	set It = null
	set u =null
    set p = null
endfunction


//===========================================================================
function InitTrig_Toms takes nothing returns nothing
    set gg_trg_Toms = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Toms, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddAction( gg_trg_Toms, function Trig_Toms_Actions )
endfunction

