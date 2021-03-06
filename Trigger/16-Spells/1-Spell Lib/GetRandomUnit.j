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
            if this.heroPriority and BlzGroupGetSize(this.heroGroup) > 0 then
                set this.pickedUnit = BlzGroupUnitAt(this.heroGroup, GetRandomInt(0, BlzGroupGetSize(this.heroGroup) - 1))
                call GroupRemoveUnit(this.heroGroup, this.pickedUnit)
                //call BJDebugMsg("ruh hp")
            else
                //call BJDebugMsg("ruh u")
                set this.pickedUnit = BlzGroupUnitAt(this.RandomUnitHelperGroup, GetRandomInt(0, BlzGroupGetSize(this.RandomUnitHelperGroup) - 1))
            endif
            call GroupRemoveUnit(this.RandomUnitHelperGroup, this.pickedUnit)

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

        method EnumUnits takes real x, real y, real range, integer targetType, player p returns thistype
            local unit temp
            call GroupClear(ENUM_GROUP1)
            //call BJDebugMsg("trgtp: " + I2S(targetType) + " p: " + I2S(GetPlayerId(p)))
            call EnumTargettableUnitsInRange(ENUM_GROUP1, x, y, range, p, this.allowMagicImmune, targetType)
            loop
                set temp = FirstOfGroup(ENUM_GROUP1)
                //call BJDebugMsg("gru" + GetUnitName(temp) + " : " + I2S(GetHandleId(temp)))
                exitwhen temp == null
                if temp != this.exclusionTarget and IsUnitInGroup(temp, this.RandomUnitHelperGroup) == false and GetUnitAbilityLevel(temp, 'Aloc') == 0 then
                    //call BJDebugMsg("ruh ally excl double check")
                    if (this.exclusionGroup != null and IsUnitInGroup(temp, this.exclusionGroup) == false) or this.exclusionGroup == null then
                        call GroupAddUnit(this.RandomUnitHelperGroup, temp)
                        //call BJDebugMsg("ruh u add: " + GetUnitName(temp) + " : " + I2S(GetHandleId(temp)))
                        if this.heroPriority and IsUnitType(temp, UNIT_TYPE_HERO) and IsUnitInGroup(temp, this.heroGroup) == false then  
                            call GroupAddUnit(this.heroGroup, temp)
                            //call BJDebugMsg("ruh hp add")
                        endif
                    endif
                endif
                call GroupRemoveUnit(ENUM_GROUP1, temp)
            endloop
            return this
        endmethod

        method checkMagicImmune takes nothing returns thistype
            set this.allowMagicImmune = true
            return this
        endmethod

        method doHeroPriority takes nothing returns thistype
            set this.heroPriority = true
            set this.heroGroup = NewGroup()
            return this
        endmethod

        method excludeUnit takes unit u returns thistype
            set this.exclusionTarget = u
            return this
        endmethod
    
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

        //call BJDebugMsg("range: " + R2S(range))
        call RUH.EnumUnits(x, y, range, targetType, p)
        return RUH.GetRandomUnit(false)
    endfunction
endlibrary