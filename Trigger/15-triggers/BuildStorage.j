library SaveBuild requires Table, RandomShit, CustomState

    globals
        PlayerBuild array PlayerBuilds
    endglobals

    private function GetBuildObject takes integer id returns BuildObjects
        return id
    endfunction

    struct BuildItem extends array
        integer id
        integer num
        
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        method export takes nothing returns string
            return GetObjectName(this.id)
        endmethod

        static method create takes integer itemId, integer itemNum returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.id = itemId
            set this.num = itemNum
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set recycleNext = recycle
            set recycle = this
        endmethod
    endstruct

    struct BuildAbil extends array 
        integer id
        integer level
        integer num

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        method export takes nothing returns string
            //call BJDebugMsg("export: " + GetObjectName(this.id) + ", lvl: " + I2S(this.level) + ", id: " + I2S(this.num))
            return GetObjectName(this.id) + ": " + I2S(this.level)
        endmethod

        static method create takes integer abilityId, integer lvl, integer num returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            //call BJDebugMsg("create: " + GetObjectName(abilityId) + ", lvl: " + I2S(lvl) + ", id: " + I2S(num))
            set this.id = abilityId
            set this.level = lvl
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set recycleNext = recycle
            set recycle = this
        endmethod
    endstruct

    struct BuildObjects extends array 
        Table objects
        integer nCount

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        method getItem takes integer num returns BuildItem
            return this.objects[num]
        endmethod

        method addItem takes BuildItem buildItem returns nothing
            set this.objects[buildItem.num] = buildItem
            //call BJDebugMsg("id: " + I2S(this) + " num: "+ I2S(this.objects[buildItem.num]))
        endmethod

        method getAbil takes integer num returns BuildAbil
            return this.objects[num]
        endmethod

        method addAbil takes BuildAbil buildAbil returns nothing
            set this.objects[buildAbil.num] = buildAbil
            //call BJDebugMsg("id: " + I2S(this) + " num: "+ I2S(this.objects[buildAbil.num]))
        endmethod

        static method AddToString takes BuildObjects buildObject, string s, string returnS, boolean next returns string
            if s != "" then
                set buildObject.nCount = buildObject.nCount + 1
                if buildObject.nCount >= 4 then
                    set buildObject.nCount = 0
                    return returnS + s + "\n"
                else
                    if next then
                        return returnS + s + " - "
                    else
                        return returnS + s
                    endif
                endif
            else
                return returnS
            endif
        endmethod

        method export takes boolean abil returns string
            local integer i = 0
            local string returnS = ""
            local BuildAbil buildAbil
            local integer next = 0
            local BuildItem buildItem
            loop
                if abil then
                    set i = i + 1
                    set buildAbil = this.getAbil(i)
                    set next = this.getAbil(i+1)
                    //call BJDebugMsg("id: " + I2S(this) + " obj: " + I2S(buildAbil))
                    if buildAbil != 0 then
                        set returnS = this.AddToString(this, buildAbil.export(), returnS, next != 0)
                    endif
                else
                    set buildItem = this.getItem(i)
                    set next = this.getItem(i+1)
                    //call BJDebugMsg("id: " + I2S(this) + " obj: " + I2S(buildItem))
                    if buildItem != 0 then
                        set returnS = this.AddToString(this, buildItem.export(), returnS, next != 0)
                    endif
                    set i = i + 1
                endif
                exitwhen (abil and i >= 20) or (not abil and i > 5)
            endloop
            return returnS
        endmethod

        static method create takes nothing returns thistype
            local thistype this

            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set objects = Table.create()

            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set recycleNext = recycle
            set recycle = this
        endmethod
    endstruct

    struct PlayerBuild extends array
        integer finalRound
        unit hero
        HashTable heroInfo
        Table abilities
        Table items

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        method GetHeroInfo takes integer round returns string
            local string s = ""
            set s = s + "attack damage: " + heroInfo[round].string[0] + " - "
            set s = s + "attack speed: " + heroInfo[round].string[1] + " - "
            set s = s + "armor: " + heroInfo[round].string[2] + " - "
            set s = s + "Block: " + heroInfo[round].string[3] + "\n"
            set s = s + "Move speed: " + heroInfo[round].string[4] + " - "
            set s = s + "Strength: " + heroInfo[round].string[5] + " - "
            set s = s + "Agility: " + heroInfo[round].string[6] + " - "
            set s = s + "Intelligence: " + heroInfo[round].string[7] + "\n"
            set s = s + "Magic power: " + heroInfo[round].string[8] + " - "
            set s = s + "Magic resistance: " + heroInfo[round].string[9] + " - "
            set s = s + "Evasion: " + heroInfo[round].string[10] + " - "
            set s = s + "Pvp: " + heroInfo[round].string[11]
            return s
        endmethod

        method SetHeroInfo takes integer round returns nothing
            set heroInfo[round].string[0] = I2S(BlzGetUnitBaseDamage(this.hero, 0) + BlzGetUnitDiceNumber(this.hero, 0)) + " - " + I2S(BlzGetUnitBaseDamage(this.hero, 0) + (BlzGetUnitDiceNumber(this.hero, 0) * BlzGetUnitDiceSides(this.hero, 0)))
            set heroInfo[round].string[1] = R2S(BlzGetUnitAttackCooldown(this.hero, 0))
            set heroInfo[round].string[2] = R2SW(BlzGetUnitArmor(this.hero), 1, 0)
            set heroInfo[round].string[3] = R2SW(GetUnitBlock(this.hero), 1, 0)
            set heroInfo[round].string[4] = R2SW(GetUnitMoveSpeed(this.hero), 1, 0)
            set heroInfo[round].string[5] = I2S(GetHeroStr(this.hero, true))
            set heroInfo[round].string[6] = I2S(GetHeroAgi(this.hero, true))
            set heroInfo[round].string[7] = I2S(GetHeroInt(this.hero, true))
            set heroInfo[round].string[8] = R2SW(GetUnitMagicDmg(this.hero), 1, 1)
            set heroInfo[round].string[9] = R2SW(GetUnitMagicDef(this.hero), 1, 1)
            set heroInfo[round].string[10] = R2SW(GetUnitEvasion(this.hero), 1, 1)
            set heroInfo[round].string[11] = R2SW(GetUnitPvpBonus(this.hero), 1, 1)
        endmethod

        method export takes integer round returns string
            local string s = ""
            //call BJDebugMsg("round: " + I2S(round) + " obj: " + I2S(this.abilities[round]))
            set s = GetUnitName(this.hero) + " lvl: " + I2S(GetHeroLevel(this.hero)) + "\n"
            set s = s + GetHeroInfo(round) + "\n"
            set s = s + "Abilities: \n" + GetBuildObject(this.abilities[round]).export(true)
            set s = s + "Items: \n" + GetBuildObject(this.items[round]).export(false)
            return s
        endmethod

        method updateBuild takes integer round returns nothing
            local integer i = 1
            local integer objectId
            local integer lvl = 0
            set this.finalRound = round

            set this.abilities[round] = BuildObjects.create()
            set this.items[round] = BuildObjects.create()
            call SetHeroInfo(round)
            //call BJDebugMsg("created")
            set i = 1
            loop
                set objectId = GetInfoHeroSpell(this.hero, i)
                set lvl = GetUnitAbilityLevel(this.hero, objectId)
                if objectId != 0 then
                    //call BJDebugMsg("abil id: " + GetObjectName(objectId) + " lvl: " + I2S(lvl) + " round: " + I2S(round) + "obj: " + I2S(this.abilities[round]))
                    if GetBuildObject(this.abilities[round-1]).getAbil(i).level == lvl then
                        call GetBuildObject(this.abilities[round]).addAbil(GetBuildObject(this.abilities[round-1]).getAbil(i))
                        //call BJDebugMsg("transferred prev round abil")
                    else
                        call GetBuildObject(this.abilities[round]).addAbil(BuildAbil.create(objectId, lvl, i))
                        //call BJDebugMsg("created round abil")
                    endif
                endif
                set i = i + 1
                exitwhen i > 20
            endloop

            set i = 0
            loop
                set objectId = GetItemTypeId(UnitItemInSlot(this.hero, i))
                if objectId != 0 then
                    //call BJDebugMsg("item id: " + GetObjectName(objectId))
                    if GetBuildObject(this.items[round-1]).getItem(i).id == objectId then
                        call GetBuildObject(this.items[round]).addItem(GetBuildObject(this.items[round-1]).getItem(i).id)
                        //call BJDebugMsg("transferred prev round item")
                    else
                        call GetBuildObject(this.items[round]).addItem(BuildItem.create(objectId, i))
                        //call BJDebugMsg("created round item")
                    endif
                endif
                set i = i + 1
                exitwhen i > 5
            endloop
        endmethod
    
        static method create takes unit hero returns thistype
            local thistype this 
            
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            
            //call BJDebugMsg(GetUnitName(hero))
            set this.hero = hero
            set this.abilities = Table.create()
            set this.items = Table.create()
            set this.heroInfo = HashTable.create()

            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set recycleNext = recycle
            set recycle = this
        endmethod
    endstruct

    function StoreBuildTimer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer pid = GetTimerData(t)
        if PlayerBuilds[pid] != 0 then
            call PlayerBuilds[pid].updateBuild(udg_integer02)
        else
            set PlayerBuilds[pid] = PlayerBuild.create(udg_units01[pid+1])
            call PlayerBuilds[pid].updateBuild(udg_integer02)
        endif
        //call BJDebugMsg(PlayerBuilds[pid].export(udg_integer02))
        call ReleaseTimer(t)
        set t = null
    endfunction

    function StoreBuild takes integer pid returns nothing
        call TimerStart(NewTimerEx(pid), 0, false, function StoreBuildTimer)
    endfunction

    function StoreAllPlayerBuilds takes nothing returns nothing
        local integer i = 0
        loop
            if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(Player(i)) == MAP_CONTROL_USER and udg_units01[i+1] != null then
                call StoreBuild(i)
            endif
            set i = i + 1
            exitwhen i > 7
        endloop
    endfunction

endlibrary