library LearnAbsolute initializer init requires SpellsLearned, Functions
    function UnlearnAbsolute takes unit u, integer id returns nothing
        local integer count = LoadCountHeroSpell(u, 1)
        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,"|cfff76863Removed |r" + BlzGetAbilityTooltip(id, GetUnitAbilityLevel(u, id) - 1))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", u, "origin"))
        call UnitRemoveAbility(u, id)
        call SaveCountHeroSpell(u,count - 1,1)
        call SaveInteger(HT,GetHandleId(u),941561, LoadInteger(HT,GetHandleId(u),941561)  - 1 )
        call FunResetAbility(id,u)
    endfunction

    private function BuyLevel takes player p, unit u, integer abil, boolean maxBuy, boolean new returns nothing
        local integer i = GetUnitAbilityLevel(u, abil) + 1
        local integer cost = BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') )
        local integer lumber = GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER)
        local location unitLocation = GetUnitLoc(u)

        if maxBuy then
            loop
                if lumber - cost < 0 then
                    exitwhen true
                endif
                set lumber = lumber - cost
                set i = i + 1
                exitwhen i >= 30
            endloop
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, lumber)
        endif

        if new then
            call UnitAddAbility(u, abil)
            call BlzUnitDisableAbility(u,abil,false,true)
            call AddSpellPlayerInfo(abil,u,1)
            call SpellLearnedFunc(u, abil)
            
        endif
        if i > 1 then
            call SetUnitAbilityLevel(u, abil, i)
        endif
        call FuncEditParam(abil,u)
        call AddSpecialEffectLocBJ(unitLocation,"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call DisplayTimedTextToPlayer(p, 0, 0, 2.0, "|cffbbff00Learned |r" + BlzGetAbilityTooltip(abil, GetUnitAbilityLevel(u, abil) - 1))

        call RemoveLocation(unitLocation)
        set unitLocation = null
    endfunction

    function Trig_AbsoluteAbilityLevelup_Actions takes nothing returns nothing
        local integer ItemId = GetItemTypeId(GetManipulatedItem())
        local integer counter = 0 
        local integer abilityId = GetAbilityFromItem(ItemId)
        local integer abilityLevel 
        local unit u = GetTriggerUnit()

        if IsUnitType(u, UNIT_TYPE_HERO) then
            if ItemId == 'I09R' then
                //call BJDebugMsg("aalu unlearn")
                set counter = LoadInteger(HT,GetHandleId(u),941561) 
                if counter > 0 then
                    call UnlearnAbsolute(u, GetLastLearnedSpell(u, SpellList_Absolute, true))
                endif
            endif
            if IsAbsolute(abilityId) then
                //call BJDebugMsg("aalu is absolute")
                set counter = LoadInteger(HT,GetHandleId(u),941561) 
                set abilityLevel = GetUnitAbilityLevel(u,abilityId)
                //call BJDebugMsg("aalu counter: " + I2S(counter))
                if abilityLevel > 0 then
                
                    if abilityLevel < 30 then
                        call BuyLevel(GetOwningPlayer(u), u, abilityId, HoldShift[GetPlayerId(GetOwningPlayer(u))], false)
                    else
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(u),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(u) )
                        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 2, "|cffffe600Failed to learn|r: maximum abilities reached")
                    endif
                    
                else
                    if counter < 10 and counter <= GetHeroMaxAbsoluteAbility(u) then
                        //call BJDebugMsg("aalu add")
                        call SaveInteger(HT,GetHandleId(u),941561,counter + 1 )
                        call BuyLevel(GetOwningPlayer(u), u, abilityId, HoldShift[GetPlayerId(GetOwningPlayer(u))], true)
                        if counter == 0 then
                            call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10, "You can |cff9dff00find the Absolute ability|r when you hover over the icon on the |cff00e1fftop left of your screen|r below the Info (F9) button.")
                        endif
                    elseif counter > GetHeroMaxAbsoluteAbility(u) then
                        //call BJDebugMsg("aalu acorn")
                        call DisplayTimedTextToPlayer(GetOwningPlayer(u),0,0,2, "Buy an |cffbbff00Absolute Acorn|r at |cffffd900Power Ups Shop II|r to buy more Absolute abilities. (|cffff1100Max:" + I2S(GetHeroMaxAbsoluteAbility(u) + 1) + "|r)"  ) 
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(u),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(u) )

                    endif
                endif
            endif
        endif
        set u = null
    endfunction
    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_PICKUP_ITEM )
        call TriggerAddAction( trg, function Trig_AbsoluteAbilityLevelup_Actions )
        set trg = null
    endfunction
endlibrary