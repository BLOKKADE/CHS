library SaveHelperLib initializer Init requires SyncHelper, PlayerUtils, SaveFile, SaveCore

    // There are a ton of methods in here that we don't use
    // Uses GUI variables from the "Save Init" trigger. You can modify these functions to use your own variables.
    private keyword SaveHelperInit
    
    struct SaveHelper extends array
        
        static constant hashtable Hashtable = InitHashtable()
        static constant integer KEY_ITEMS = 1
        static constant integer KEY_UNITS = 2
        static constant integer KEY_NAMES = 3
        
        static method MaxCodeSyncLength takes nothing returns integer
            return SaveLoadMaxLength
        endmethod
        
        static method GetUserHero takes User user returns unit
            return SavePlayerHero[user.id]
        endmethod
        
        static method RemoveUserHero takes User user returns nothing
            call RemoveUnit(SavePlayerHero[user.id])
            set SavePlayerHero[user.id] = null
        endmethod
        
        static method SetUserHero takes User user, unit u returns nothing
            set SavePlayerHero[user.id] = u
        endmethod
        
        static method IsUserLoading takes User user returns boolean
            return SavePlayerLoading[user.id]
        endmethod
        
        static method SetUserLoading takes User user, boolean flag returns nothing
            set SavePlayerLoading[user.id] = flag
        endmethod
        
        static method SetSaveSlot takes User user, integer slot returns nothing
            set SaveCurrentSlot[user.id] = slot
        endmethod
        
        static method GetSaveSlot takes User user returns integer
            return SaveCurrentSlot[user.id]
        endmethod
        
        static method GetUnitTitle takes unit u returns string
            return GetObjectName(GetUnitTypeId(u)) + " (" + GetHeroProperName(u) + ")"
        endmethod
        
        static method GetMapName takes nothing returns string
            return MapName
        endmethod
        
        static method MaxAbilityLevel takes nothing returns integer
            return 10
        endmethod
        
        static method MaxAbilities takes nothing returns integer
            return SaveAbilityTypeMax
        endmethod
        
        static method MaxItems takes nothing returns integer
            return SaveItemTypeMax
        endmethod
        
        static method MaxUnits takes nothing returns integer
            return SaveUnitTypeMax
        endmethod
        
        static method MaxNames takes nothing returns integer
            return SaveNameMax
        endmethod

        static method MaxHeroStat takes nothing returns integer
            return SaveUnitMaxStat
        endmethod
        
        static method GetAbility takes integer index returns integer
            return SaveAbilityType[index]
        endmethod
        
        static method GetItem takes integer index returns integer
            return SaveItemType[index]
        endmethod
        
        static method GetUnit takes integer index returns integer
            return SaveUnitType[index]
        endmethod
        
        static method ConvertItemId takes integer itemId returns integer
            return LoadInteger(thistype.Hashtable, KEY_ITEMS, itemId)
        endmethod

        static method ConvertUnitId takes integer unitId returns integer
            return LoadInteger(thistype.Hashtable, KEY_UNITS, unitId)
        endmethod
        
        static method GetHeroNameFromID takes integer id returns string
            return SaveNameList[id]
        endmethod
        
        static method GetHeroNameID takes string name returns integer
            return LoadInteger(thistype.Hashtable, KEY_NAMES, StringHash(name))
        endmethod
        
        static method ConvertHeroName takes string name returns string
            return SaveNameList[GetHeroNameID(name)]
        endmethod
        
        static method GUILoadNext takes nothing returns nothing
            set SaveValue[SaveCount] = Savecode(SaveTempInt).Decode(SaveMaxValue[SaveCount])
        endmethod
        
        static method GetLevelXP takes integer level returns real
            local real xp = HeroXPLevelFactor // level 1
            local integer i = 1

            loop
                exitwhen i > level
                set xp = (xp*HeroXPPrevLevelFactor) + (i+1) * HeroXPLevelFactor
                set i = i + 1
            endloop
            return xp-HeroXPLevelFactor
        endmethod
        
        static method Init takes nothing returns nothing // called at the end of "Save Init" trigger
            local integer i = 0
            loop
                exitwhen i >= thistype.MaxItems() //or SaveItemType[i] == 0
                
                call SaveInteger(thistype.Hashtable, KEY_ITEMS, SaveItemType[i], i)
                
                set i = i + 1
            endloop
            set i = 0
            loop
                exitwhen i >= thistype.MaxUnits() //or SaveUnitType[i] == 0
                
                call SaveInteger(thistype.Hashtable, KEY_UNITS, SaveUnitType[i], i)
                
                set i = i + 1
            endloop
            set i = 1
            loop
                exitwhen i >= SaveHelper.MaxNames() or SaveNameList[i] == "" or SaveNameList[i] == null
                
                call SaveInteger(thistype.Hashtable, KEY_NAMES, StringHash(SaveNameList[i]), i)
                
                set i = i + 1
            endloop
        endmethod
    endstruct
    
    // We aren't using this
    /*function GetHeroSaveCode takes unit u returns string
        if (SaveUseGUI) then
            call TriggerExecute(gg_trg_Save_GUI)
            return SaveTempString
        endif
        
        return ""
    endfunction*/
    
    private function LoadSaveSlot_OnLoad takes nothing returns nothing
        local player p = GetTriggerPlayer()
        local string prefix = BlzGetTriggerSyncPrefix()
        local string data = BlzGetTriggerSyncData()
        local User user = User[p]
        
        call SaveHelper.SetUserLoading(user, false)
        
        if (SaveUseGUI) then
            set SaveLoadEvent_Code = data
            set SaveLoadEvent_Player = p
            set SaveLoadEvent = 1.
            set SaveLoadEvent = -1
        endif
    endfunction
    
    function LoadSaveSlot takes player p, integer slot returns nothing
        local SaveFile savefile = SaveFile(slot)
        local string s
        local User user = User[p]
        
        if (not SaveFile.exists(p, slot)) then
            call DisplayTextToPlayer(p, 0, 0, "Did not find any save data.")
            return
        elseif (SaveHelper.IsUserLoading(user)) then
            call DisplayTextToPlayer(p, 0, 0, "Please wait while your character synchronizes.")
        else
            set s = savefile.getData(p)
            if (GetLocalPlayer() == p) then
                call SyncString(s)
            endif
            call ClearTextMessages()
            call DisplayTimedTextToPlayer(p, 0, 0, 15, "Synchronzing with other players...")
            call SaveHelper.SetSaveSlot(user, slot)
        endif
    endfunction
    
    function DeleteCharSlot takes player p, integer slot returns nothing
        if (GetLocalPlayer() == p) then
            call SaveFile(slot).clear(p, slot)
        endif
    endfunction
    
    function SaveCharToSlot takes unit u, integer slot, string s returns nothing
        local player p = GetOwningPlayer(u)
        if (GetLocalPlayer() == p) then
            call SaveFile(slot).create(p, SaveHelper.GetUnitTitle(u), slot, s)
        endif
        call SaveHelper.SetSaveSlot(User[p], slot)
    endfunction
    
    private function Init takes nothing returns nothing
        call OnSyncString(function LoadSaveSlot_OnLoad)
    endfunction
    
endlibrary
