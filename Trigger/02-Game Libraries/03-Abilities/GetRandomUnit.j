library GetRandomUnit initializer init requires UnitHelpers
    globals
        RandomUnitHelper RUH
        group ENUM_GROUP1 = CreateGroup()
    endglobals

    struct RandomUnitHelper extends array
        group RandomUnitHelperGroup
        group exclusionGroup
        group heroGroup
        unit exclusionTarget
        boolean createdExclusionGroup
        boolean heroPriority
        boolean allowMagicImmune
        unit pickedUnit
        integer endTick

        method GetRandomUnit takes boolean exclude returns unit
        //pick a random unit from the hero group if hero priority is enabled, else get random unit
            if this.heroPriority and BlzGroupGetSize(this.heroGroup) > 0 then
                set this.pickedUnit = BlzGroupUnitAt(this.heroGroup, GetRandomInt(0, BlzGroupGetSize(this.heroGroup) - 1))
                call GroupRemoveUnit(this.heroGroup, this.pickedUnit)
            else
                set this.pickedUnit = BlzGroupUnitAt(this.RandomUnitHelperGroup, GetRandomInt(0, BlzGroupGetSize(this.RandomUnitHelperGroup) - 1))
            endif
            call GroupRemoveUnit(this.RandomUnitHelperGroup, this.pickedUnit)

            //add picked unit to exclusion group to prevent it from being picked again
            if exclude then
                if this.exclusionGroup == null then
                    set this.exclusionGroup = NewGroup()
                    set this.createdExclusionGroup = true
                endif
                //call BJDebugMsg("ruh excl add")
                call GroupAddUnit(this.exclusionGroup, this.pickedUnit) 
            endif

            return this.pickedUnit
        endmethod

        //enumerate all units and filter out the unneeded ones
        method EnumUnits takes real x, real y, real range, integer targetType, player p returns thistype
            local unit temp
            call GroupClear(ENUM_GROUP1)

            //get all units in range, targettype = ally or enemy or any
            call EnumTargettableUnitsInRange(ENUM_GROUP1, x, y, range, p, this.allowMagicImmune, targetType)
            loop
                set temp = FirstOfGroup(ENUM_GROUP1)
                exitwhen temp == null
                //make sure unit is not excluded or in the exclusion group, and not already in the picked units group and doesnt have locus
                if temp != this.exclusionTarget and IsUnitInGroup(temp, this.RandomUnitHelperGroup) == false and GetUnitAbilityLevel(temp, 'Aloc') == 0 then
                    if (this.exclusionGroup != null and IsUnitInGroup(temp, this.exclusionGroup) == false) or this.exclusionGroup == null then
                        call GroupAddUnit(this.RandomUnitHelperGroup, temp)
                        //also add to hero group if hero priority is enabled
                        if this.heroPriority and IsUnitType(temp, UNIT_TYPE_HERO) and IsUnitInGroup(temp, this.heroGroup) == false then  
                            call GroupAddUnit(this.heroGroup, temp)
                        endif
                    endif
                endif
                call GroupRemoveUnit(ENUM_GROUP1, temp)
            endloop
            return this
        endmethod

        //allows magic immune units to be picked
        method checkMagicImmune takes nothing returns thistype
            set this.allowMagicImmune = true
            return this
        endmethod

        //check if there are nearby heroes first
        method doHeroPriority takes nothing returns thistype
            set this.heroPriority = true
            set this.heroGroup = NewGroup()
            return this
        endmethod

        //exclude a specific unit from the units picked by the helper
        method excludeUnit takes unit u returns thistype
            set this.exclusionTarget = u
            return this
        endmethod
    
        //exclude group g from the units picked by the helper
        method excludeGroup takes group g returns thistype
            set this.exclusionGroup = g
            //call BJDebugMsg("excl g: " + I2S(BlzGroupGetSize(this.exclusionGroup)))
            return this
        endmethod

        method periodic takes nothing returns nothing
            if T32_Tick >= this.endTick then
                //call BJDebugMsg("dummy destroy")
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod
        implement T32x
        implement Recycle

        //destroy all groups used for the struct
        method destroyGroups takes nothing returns nothing
            if this.heroGroup != null then
                call ReleaseGroup(this.heroGroup)
            endif
            if this.createdExclusionGroup then
                call ReleaseGroup(this.exclusionGroup)
            endif
            if this.RandomUnitHelperGroup != null then
                call ReleaseGroup(this.RandomUnitHelperGroup)
            endif
        endmethod

        //resets all variables in the struct back to default
        method reset takes nothing returns thistype
            call this.destroyGroups()
            set this.createdExclusionGroup = false
            set this.exclusionTarget = null
            set this.pickedUnit = null
            set this.heroGroup = null
            set this.exclusionGroup = null
            set this.allowMagicImmune = false
            set this.heroPriority = false
            set this.RandomUnitHelperGroup = NewGroup()
            return this
        endmethod
        
        //create RandomUnitHelper, duration can be used to temporarily store the data if callbacks are needed
        // duration = 0 = infinite
        static method create takes real duration returns thistype
            local thistype this = thistype.setup()
            
            call this.reset()

            if duration != 0  then
                set this.endTick = T32_Tick + R2I((duration * 32))
                call this.startPeriodic()
            endif
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call this.reset()
            //call BJDebugMsg("dummy destroyed")
            call this.recycle()
        endmethod
    endstruct

    private function init takes nothing returns nothing
        set RUH = RandomUnitHelper.create(0)
    endfunction

    function GetRandomUnit takes real x, real y, real range, player p, integer targetType, boolean heroPriority, boolean allowMagicImmune returns unit
        call RUH.reset()

        if heroPriority then
            call RUH.doHeroPriority()
        endif

        if allowMagicImmune then
            call RUH.checkMagicImmune()
        endif

        //call BJDebugMsg("range: " + R2S(range) + ", tt: " + I2S(targetType) + ", x: " + R2S(x) + ", y: " + R2S(y) + ", player: " + GetPlayerName(p))
        call RUH.EnumUnits(x, y, range, targetType, p)
        return RUH.GetRandomUnit(false)
    endfunction
endlibrary