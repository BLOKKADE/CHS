library LimitedSummon
   //Version 1.1
   //LimitedSummon allows to limit the amount of units summoned by a summoner.
   //The summons are splited into limitGroups, limits only affect 1 limitGroup.
   //LimitSummon does not use any events, the data is updated everytime you call a function of LimitSummon.
   
   //=======
   //API
      //function LimitedSummon takes unit summoner, unit summon, integer limitGroup, integer limit returns boolean
          //summoner the summoning unit.
          //summon the unit summoned.
          //limitGroup (a number); summons with the same limitGroup (Nr) are sharing the same limit.
          //limit the amount of living summons allowed at the same time.
          //will kill when the amount of living summons of that group from that summoner exceeds the limit.
          //call with summon = null to do only a desummon based on limit.
          //returns true if units were desummoned with that call.
          //   >The desummoned Units are inside the unitGroup LimitedSummon__desummoned
      
      //function LimitedSummonEx takes integer limitGroup, integer limit returns boolean
          //Wrapper to be used inside a Unit Summon Event. Using GetSummoningUnit() and GetSummonedUnit() for the units.
      
      //function LimitedSummonGetOldest takes unit summoner, integer limitGroup returns unit
          //Returns the oldest living unit beeing summoned by summoner using limitGroup
   //=======
   globals
      private integer countReuse = 0
      private integer countData = 0
      private integer array reuse
      private unit array dataSummon
      private unit array dataSummoner
      private integer array dataGroup
      private integer array noteNext
      private integer array notePrev
    
      public string desummonArt = "Abilities\\Spells\\NightElf\\ForceOfNature\\EntanglementBirthTarget.mdl" //Displayed below Units beeing Desummoned cause of Limit Exceeded.
      public boolean displayDesummonArt = true
      public group desummoned = CreateGroup() //Contains units beeing desummoned
   
   endglobals
   
   private function Remove takes integer index returns nothing
      set noteNext[notePrev[index]] = noteNext[index]
      set notePrev[noteNext[index]] = notePrev[index]
    
      //clean refs
      set dataSummon[index] = null
      set dataSummoner[index] = null
   
      //make index reuseable
      set reuse[countReuse] = index
      set countReuse = countReuse + 1
   endfunction
   
   function LimitedSummonGetOldest takes unit summoner, integer limitGroup returns unit
      local integer indexLoop = 0
    
      //loop all summons to count summons, finding the oldest of that limitGroup. And Purge the list.
      loop
          set indexLoop = noteNext[indexLoop]
          exitwhen indexLoop == 0
          if not IsUnitType(dataSummon[indexLoop], UNIT_TYPE_DEAD) and GetUnitTypeId(dataSummon[indexLoop]) != 0 then
              if dataGroup[indexLoop] == limitGroup and dataSummoner[indexLoop] == summoner then
                  return dataSummon[indexLoop]
              endif
          else //This summon is dead or removed!
              call Remove(indexLoop)
              set indexLoop = notePrev[indexLoop]
          endif
      endloop
    
      return null
   endfunction
   
   function LimitedSummon takes unit summoner, unit summon, integer limitGroup, integer summonlimit returns boolean
      local integer indexEnter
      local integer countOld = 0
      local integer indexLoop = 0
      local boolean desummonedSomthing = false
      call GroupClear(desummoned)
   
      if summon != null then
          if countReuse != 0 then
              set countReuse = countReuse - 1
              set indexEnter = reuse[countReuse]
          else
              set countData = countData + 1
              set indexEnter = countData
          endif
      
          set noteNext[indexEnter] = 0
          set noteNext[notePrev[0]] = indexEnter
          set notePrev[indexEnter] = notePrev[0]
          set notePrev[0] = indexEnter
      
          set dataSummon[indexEnter] = summon
          set dataSummoner[indexEnter] = summoner
          set dataGroup[indexEnter] = limitGroup
      endif
   
      //loop all summons to count summons, finding the oldest of that limitGroup. And Purge the list.
      loop
          set indexLoop = notePrev[indexLoop]
          exitwhen indexLoop == 0
          if not IsUnitType(dataSummon[indexLoop], UNIT_TYPE_DEAD) and GetUnitTypeId(dataSummon[indexLoop]) != 0 then
              if dataGroup[indexLoop] == limitGroup and dataSummoner[indexLoop] == summoner then
                  set countOld = countOld + 1
                  if countOld > summonlimit then //limit was excedd?
                      set desummonedSomthing = true
                      if displayDesummonArt then
                          call DestroyEffect(AddSpecialEffect(desummonArt, GetUnitX(dataSummon[indexLoop]), GetUnitY(dataSummon[indexLoop])))
                      endif
                      call GroupAddUnit(desummoned, dataSummon[indexLoop])
                      call KillUnit(dataSummon[indexLoop])
                  
                      call Remove(indexLoop)
                      set indexLoop = noteNext[indexLoop]
                  endif
              endif
          else //This summon is dead or removed!
              call Remove(indexLoop)
              set indexLoop = noteNext[indexLoop]
          endif
      endloop
      return desummonedSomthing
   endfunction
   
   function LimitedSummonEx takes integer limitGroup, integer summonlimit returns boolean
      return LimitedSummon(GetSummoningUnit(), GetSummonedUnit(), limitGroup, limit)
   endfunction
   
   endlibrary