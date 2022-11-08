/*
    Lightning System v1.03
    by Adiktuz
   
    Basically it allows you to easily create timed or un-timed lightning effects
   
    Features:
        ->You can create lightnings between two points, two unit, or a point and a unit.
        ->For lightnings attached to a unit, the system automatically updates the lightning
          for changes on the unit (like  unit position, height etc)
        ->Specify the height of the lightning
        ->Create timed-lightnings that get automatically destroyed when their duration is over
        ->Supports moving points too (but the lightnings are forced to be timed)
        ->Allows you to add actions that will run when a lightning has ended and during
          update (time of which is equal to T32's period)
        ->Allows you to attach any type of custom data to each instance
       
    Methods available
       
        How to use: call Lightning.methodName(parameters)
       
        unitToPoint takes unit unit1, real x, real y, real sourceZ, real targetZ, boolean timed, real duration, string leffect, integer eventkey returns thistype
        unitToUnit takes unit unit1, unit unit2, real sourceZ, real targetZ, boolean timed, real duration, string leffect, integer eventkey  returns thistype
        pointToPoint takes real sourceX, real sourceY,real targetX, real targetY, real sourceZ, real targetZ, boolean timed, real duration, string leffect, integer eventkey  returns thistype
        pointToPointEx takes real sourceX, real deltaSourceX, real sourceY, real deltaSourceY, real targetX, real deltaTargetX, real targetY, real deltaTargetY, real sourceZ, real targetZ, real duration, string leffect, integer eventkey  returns thistype
        unitToPointEx takes unit unit1, real x, real xx, real y, real yx, real sourceZ, real targetZ, real duration, string leffect, integer eventkey  returns thistype
        pointToPointExZ takes real sourceX, real deltaSourceX, real sourceY, real deltaSourceY, real targetX, real deltaTargetX, real targetY, real deltaTargetY, real sourceZ, real sourceCurZ, real targetZ, real targetCurZ, real duration, string leffect, integer eventkey  returns thistype
        unitToPointExZ takes unit unit1, real x, real xx, real y, real yx, real sourceZ, real targetZ, real targetCurZ, real duration, string leffect, integer eventkey  returns thistype
       
        Parameters:
       
        unit unit1 -> unit end of the lightning
        unit unit2 -> other unit end of the lightning for the UTU methods
        real x,y -> X,Y coordinates of the point end of the lightning for the UTP methods
        real sourceX,sourceY -> X,Y coordinates of the first point of the lightning for the PTP methods
        real sourceZ,targetZ -> height of the lightning at each ends (actual height is calculated as z + height of unit (if there's a unit end) + locationZ)
        real deltaSourceX,deltaSourceY,deltaTargetX,deltaTargetY,sourceCurZ,targetCurZ -> for the Ex and ExZ methods, the final value of each coordinate/height
             (the lightning moves from sourceX to deltaSourceX, etc through the given time)
        boolean timed -> whether the lightning has a timed life or not, defaulted to true for the Ex and ExZ methods
        real duration -> timed life of the lightning
        string leffect -> string name of the lightning effect
        integer eventkey -> a key used to determine the correct update and end functions to run if available
                            (if you're not using the update and end events, you're probably saf to just set it to 0)
       
        Note: all of the above methods return the Lightning instance so you can save it in a variable
       
        Extra/Interface/Events:
       
        registerUpdateEvent(integer eventkey, code ToDo) returns nothing
        -> allows you to register an action that will be run whenever a lightning with the
           same eventkey as the one registered is updated (every T32_PERIOD)
       
        registerEndEvent(integer eventkey, code ToDo) returns nothing
        -> allows you to register an action that will be run whenever a lightning with the
           same eventkey as the one registered ends
       
        NOTE: If you're going to use the next three functions/methods, make sure you set the
              corresponding boolean at the globals block to true
       
        registerGlobalUpdateEvent(code ToDo) returns nothing
        -> allows you to register an action that will be run whenever a lightning
           is updated (every T32_PERIOD)
       
        registerGlobalEndEvent(code ToDo) returns nothing
        -> allows you to register an action that will be run whenever a lightning ends
       
        registerGlobalCreateEvent(code ToDo) returns nothing
        -> allows you to register an action that will be run whenever a lightning is created
       
        To allow creation and usage of custom data that is attached to every instance
        turn the boolean USE_CUSTOM_DATA to true
       
        then to add a custom data to an instance:
       
        for integers:
       
        set YourLightningInstance.customData[integer key] = value
       
        for others:
       
        set YourLightningInstance.customData.type[integer key] = value
       
        ->type can be real,unit,trigger,effect, etc...
       
        ->integer key is the key that will point to the data, you can utilize StringHash if you want to use strings
          something like: customData.real[StringHash("damage")]
         
        then to load data:
       
        YourLightningInstance.customData.type[integer key]
       
        To forcefully remove a lightning:
       
        remove() returns nothing
       
        To obtain which lightning instance triggered the events:
       
        instance()
*/


    //DO NOT EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING
   
   
    //Note: I've set the checkvisibility field to false because the lightnings look
    //      weird when I set it to true (sometimes they "jump")
   
    library LightningSystem requires T32, Table//, SpecialEffect

        globals
            //Set this to true if you're gonna use the global update event handler
            private constant boolean USE_GLOBAL_UPDATE = false
            //Set this to true if you're gonna use the global end event handler
            private constant boolean USE_GLOBAL_END = false
            //Set this to true if you're gonna use the global create event handler
            private constant boolean USE_GLOBAL_CREATE = false
            //Set this to true if you're gonna use the custom data feature
            private constant boolean USE_CUSTOM_DATA = true
            private location loc = Location(0,0)
            public Table UpdateTable
            public Table EndTable
            private trigger globalUpdate
            private trigger globalEnd
            private trigger globalCreate
        endglobals
       
        private module init
            static method onInit takes nothing returns nothing
                set EndTable = Table.create()
                set UpdateTable = Table.create()
                static if USE_GLOBAL_UPDATE then
                    set globalUpdate = CreateTrigger()
                endif
                static if USE_GLOBAL_END then
                    set globalEnd = CreateTrigger()
                endif
                static if USE_GLOBAL_CREATE then
                    set globalCreate = CreateTrigger()
                endif
            endmethod
        endmodule
       
        struct Lightning extends array
            lightning light
            real sourceX
            real targetX
            real sourceY
            real targetY
            real sourceZ
            real targetZ
            real deltaSourceX
            real deltaTargetX
            real deltaSourceY
            real deltaTargetY
            real sourceCurZ
            real targetCurZ
            real deltaSourceZ
            real deltaTargetZ
            unit u1
            unit u2
            //SpecialEffect e1
            //SpecialEffect e2
            integer xtype
            boolean timed
            boolean moving
            real duration
            integer eventkey
            Table customData
            static thistype instance
            private static integer instanceCount = 0
            private static thistype recycle = 0
            private thistype recycleNext
           
            static method registerEndEvent takes integer eventkey, code toDo returns nothing
                if not EndTable.handle.has(eventkey) then
                    set EndTable.trigger[eventkey] = CreateTrigger()
                endif
                call TriggerAddCondition(EndTable.trigger[eventkey],Filter(toDo))
            endmethod
           
            static method registerUpdateEvent takes integer eventkey, code toDo returns nothing
                if not UpdateTable.handle.has(eventkey) then
                    set UpdateTable.trigger[eventkey] = CreateTrigger()
                endif
                call TriggerAddCondition(UpdateTable.trigger[eventkey],Filter(toDo))
            endmethod
           
            static method registerGlobalEndEvent takes code toDo returns nothing
                call TriggerAddCondition(globalEnd,Filter(toDo))
            endmethod
           
            static method registerGlobalUpdateEvent takes code toDo returns nothing
                call TriggerAddCondition(globalUpdate,Filter(toDo))
            endmethod
           
            static method registerGlobalCreateEvent takes code toDo returns nothing
                call TriggerAddCondition(globalCreate,Filter(toDo))
            endmethod
           
            method remove takes nothing returns nothing
                call DestroyLightning(this.light)
                set instance = this
                if EndTable.handle.has(this.eventkey) then
                    call TriggerEvaluate(EndTable.trigger[this.eventkey])
                endif
                static if USE_GLOBAL_END then
                    call TriggerEvaluate(globalEnd)
                endif
                call this.stopPeriodic()
                set this.deltaSourceZ = 0.0
                set this.deltaTargetZ = 0.0
                set .recycleNext=recycle
                set recycle=this
            endmethod
           
            static method new takes nothing returns thistype
                local thistype this
                if (recycle == 0) then
                    set instanceCount = instanceCount + 1
                    return instanceCount
                else
                    set this = recycle
                    set recycle = recycle.recycleNext
                endif
                return this
            endmethod
           
            private method periodic takes nothing returns nothing
                if this.xtype == 1 then
                    set this.sourceX = GetUnitX(this.u1)
                    set this.sourceY = GetUnitY(this.u1)
                    call MoveLocation(loc, this.sourceX,this.sourceY)
                    set this.sourceCurZ = sourceZ + GetUnitFlyHeight(this.u1) + GetLocationZ(loc)
                    if this.moving then
                        set this.targetX = this.targetX + this.deltaTargetX
                        set this.targetY = this.targetY + this.deltaTargetY
                    endif
                    call MoveLocation(loc, this.targetX,this.targetY)
                    if this.deltaTargetZ != 0.0 then
                        set this.targetZ = this.targetZ + this.deltaTargetZ
                    endif
                    set this.targetCurZ = targetZ + GetLocationZ(loc) + this.deltaTargetZ
                    call MoveLightningEx(this.light,false,this.sourceX,this.sourceY,this.sourceCurZ,this.targetX,this.targetY,this.targetCurZ)
                elseif this.xtype == 2 then
                    set this.sourceX = GetUnitX(this.u1)
                    set this.sourceY = GetUnitY(this.u1)
                    set this.targetX = GetUnitX(this.u2)
                    set this.targetY = GetUnitY(this.u2)
                    call MoveLocation(loc, this.sourceX,this.sourceY)
                    set this.sourceCurZ = sourceZ + GetUnitFlyHeight(this.u1) + GetLocationZ(loc)
                    call MoveLocation(loc, this.targetX,this.targetY)
                    set this.targetCurZ = targetZ + GetUnitFlyHeight(this.u2) + GetLocationZ(loc)
                    call MoveLightningEx(this.light,false,this.sourceX,this.sourceY,this.sourceCurZ,this.targetX,this.targetY,this.targetCurZ)
                    /*
                elseif this.xtype == 4 then
                    set this.sourceX = GetUnitX(this.u1)
                    set this.sourceY = GetUnitY(this.u1)
                    set this.targetX = this.e1.x
                    set this.targetY = this.e1.y
                    call MoveLocation(loc, this.sourceX,this.sourceY)
                    set this.sourceCurZ = sourceZ + GetUnitFlyHeight(this.u1) + GetLocationZ(loc)
                    call MoveLocation(loc, this.targetX,this.targetY)
                    set this.targetCurZ = targetZ + this.e1.z + GetLocationZ(loc)
                    call MoveLightningEx(this.light,false,this.sourceX,this.sourceY,this.sourceCurZ,this.targetX,this.targetY,this.targetCurZ)
                elseif this.xtype == 5 then
                    set this.sourceX = this.e1.x
                    set this.sourceY = this.e1.y
                    set this.targetX = this.e2.x
                    set this.targetY = this.e2.y
                    call MoveLocation(loc, this.sourceX,this.sourceY)
                    set this.sourceCurZ = sourceZ + this.e1.z + GetLocationZ(loc)
                    call MoveLocation(loc, this.targetX,this.targetY)
                    set this.targetCurZ = targetZ + this.e2.z + GetLocationZ(loc)
                    call MoveLightningEx(this.light,false,this.sourceX,this.sourceY,this.sourceCurZ,this.targetX,this.targetY,this.targetCurZ)
                    */
                else
                    if this.moving then
                        set this.sourceX = this.sourceX + this.deltaSourceX
                        set this.targetX = this.targetX + this.deltaTargetX
                        set this.sourceY = this.sourceY + this.deltaSourceY
                        set this.targetY = this.targetY + this.deltaTargetY
                        call MoveLocation(loc, this.sourceX,this.sourceY)
                        if this.deltaSourceZ != 0.0 then
                            set this.sourceZ = this.sourceZ + this.deltaSourceZ
                        endif
                        if this.deltaTargetZ != 0.0 then
                            set this.targetZ = this.targetZ + this.deltaTargetZ
                        endif
                        set this.sourceCurZ = sourceZ + GetLocationZ(loc) + this.deltaSourceZ
                        call MoveLocation(loc, this.targetX,this.targetY)
                        set this.targetCurZ = targetZ + GetLocationZ(loc) + this.deltaTargetZ
                        call MoveLightningEx(this.light,false,this.sourceX,this.sourceY,this.sourceCurZ,this.targetX,this.targetY,this.targetCurZ)
                    endif
                endif
                set instance = this
                if UpdateTable.handle.has(this.eventkey) then
                    call TriggerEvaluate(UpdateTable.trigger[this.eventkey])
                endif
                static if USE_GLOBAL_UPDATE then
                    call TriggerEvaluate(globalUpdate)
                endif
                if this.timed then
                    set this.duration = this.duration - T32_PERIOD
                    if this.duration <= 0.0 then
                        call this.remove()
                    endif
                endif
            endmethod
           
            implement T32x
           
            static method unitToPoint takes unit unit1, real x, real y, real sourceZ, real targetZ, boolean timed, real duration, string leffect, integer eventkey returns thistype
                local thistype this = thistype.new()
                set this.u1 = unit1
                set this.u2 = null
                set this.sourceX = GetUnitX(this.u1)
                set this.sourceY = GetUnitY(this.u1)
                set this.targetX = x
                set this.targetY = y
                call MoveLocation(loc, this.sourceX,this.sourceY)
                set this.sourceZ = sourceZ + GetUnitFlyHeight(this.u1) + GetLocationZ(loc)
                call MoveLocation(loc, this.targetX,this.targetY)
                set this.targetZ = targetZ + GetLocationZ(loc)
                set this.timed = timed
                set this.duration = duration
                set this.eventkey = eventkey
                set this.light = AddLightningEx(leffect,false,this.sourceX,this.sourceY,this.sourceZ,this.targetX,this.targetY,this.targetZ)
                set this.xtype = 1
                set this.moving = false
                static if USE_CUSTOM_DATA then
                    if this.customData < 0 then
                        set this.customData = Table.create()
                    endif
                endif
                static if USE_GLOBAL_CREATE then
                    call TriggerEvaluate(globalCreate)
                endif
                call this.startPeriodic()
                return this
            endmethod
           
            static method unitToUnit takes unit unit1, unit unit2, real sourceZ, real targetZ, boolean timed, real duration, string leffect, integer eventkey  returns thistype
                local thistype this = thistype.new()
                set this.u1 = unit1
                set this.u2 = unit2
                set this.sourceX = GetUnitX(this.u1)
                set this.sourceY = GetUnitY(this.u1)
                set this.targetX = GetUnitX(this.u2)
                set this.targetY = GetUnitY(this.u2)
                call MoveLocation(loc, this.sourceX,this.sourceY)
                set this.sourceZ = sourceZ + GetUnitFlyHeight(this.u1) //+ GetLocationZ(loc)
                call MoveLocation(loc, this.targetX,this.targetY)
                set this.targetZ = targetZ + GetUnitFlyHeight(this.u2) //+ GetLocationZ(loc)
                set this.timed = timed
                set this.duration = duration
                set this.eventkey = eventkey
                set this.light = AddLightningEx(leffect,false,this.sourceX,this.sourceY,this.sourceZ,this.targetX,this.targetY,this.targetZ)
                set this.xtype = 2
                set this.moving = false
                static if USE_CUSTOM_DATA then
                    if this.customData < 0 then
                        set this.customData = Table.create()
                    endif
                endif
                static if USE_GLOBAL_CREATE then
                    call TriggerEvaluate(globalCreate)
                endif
                call this.startPeriodic()
                return this
            endmethod
           
            static method pointToPoint takes real sourceX, real sourceY,real targetX, real targetY, real sourceZ, real targetZ, boolean timed, real duration, string leffect, integer eventkey  returns thistype
                local thistype this = thistype.new()
                set this.u1 = null
                set this.u2 = null
                set this.sourceX = sourceX
                set this.sourceY = sourceY
                set this.targetX = targetX
                set this.targetY = targetY
                call MoveLocation(loc, this.sourceX,this.sourceY)
                set this.sourceZ = sourceZ + GetLocationZ(loc)
                call MoveLocation(loc, this.targetX,this.targetY)
                set this.targetZ = targetZ + GetLocationZ(loc)
                set this.timed = timed
                set this.duration = duration
                set this.eventkey = eventkey
                set this.light = AddLightningEx(leffect,false,this.sourceX,this.sourceY,this.sourceZ,this.targetX,this.targetY,this.targetZ)
                set this.xtype = 3
                set this.moving = false
                static if USE_CUSTOM_DATA then
                    if this.customData < 0 then
                        set this.customData = Table.create()
                    endif
                endif
                static if USE_GLOBAL_CREATE then
                    call TriggerEvaluate(globalCreate)
                endif
                call this.startPeriodic()
                return this
            endmethod
           
            static method pointToPointEx takes real sourceX, real deltaSourceX, real sourceY, real deltaSourceY, real targetX, real deltaTargetX, real targetY, real deltaTargetY, real sourceZ, real targetZ, real duration, string leffect, integer eventkey  returns thistype
                local thistype this = thistype.new()
                set this.u1 = null
                set this.u2 = null
                set this.sourceX = sourceX
                set this.sourceY = sourceY
                set this.targetX = targetX
                set this.targetY = targetY
                set this.deltaSourceX = (deltaSourceX - sourceX)*(T32_PERIOD/duration)
                set this.deltaSourceY = (deltaSourceY - sourceY)*(T32_PERIOD/duration)
                set this.deltaTargetX = (deltaTargetX - targetX)*(T32_PERIOD/duration)
                set this.deltaTargetY = (deltaTargetY - targetY)*(T32_PERIOD/duration)
                call MoveLocation(loc, this.sourceX,this.sourceY)
                set this.sourceZ = sourceZ + GetLocationZ(loc)
                call MoveLocation(loc, this.targetX,this.targetY)
                set this.targetZ = targetZ + GetLocationZ(loc)
                set this.timed = true
                set this.duration = duration
                set this.eventkey = eventkey
                set this.light = AddLightningEx(leffect,false,this.sourceX,this.sourceY,this.sourceZ,this.targetX,this.targetY,this.targetZ)
                set this.xtype = 3
                set this.moving = true
                static if USE_CUSTOM_DATA then
                    if this.customData < 0 then
                        set this.customData = Table.create()
                    endif
                endif
                static if USE_GLOBAL_CREATE then
                    call TriggerEvaluate(globalCreate)
                endif
                call this.startPeriodic()
                return this
            endmethod
           
            static method unitToPointEx takes unit unit1, real x, real xx, real y, real yx, real sourceZ, real targetZ, real duration, string leffect, integer eventkey  returns thistype
                local thistype this = thistype.new()
                set this.u1 = unit1
                set this.u2 = null
                set this.sourceX = GetUnitX(this.u1)
                set this.sourceY = GetUnitY(this.u1)
                set this.targetX = x
                set this.targetY = y
                set this.deltaTargetX = (xx - x)*(T32_PERIOD/duration)
                set this.deltaTargetY = (yx - y)*(T32_PERIOD/duration)
                call MoveLocation(loc, this.sourceX,this.sourceY)
                set this.sourceZ = sourceZ + GetUnitFlyHeight(this.u1) + GetLocationZ(loc)
                call MoveLocation(loc, this.targetX,this.targetY)
                set this.targetZ = targetZ + GetLocationZ(loc)
                set this.timed = true
                set this.duration = duration
                set this.eventkey = eventkey
                set this.light = AddLightningEx(leffect,false,this.sourceX,this.sourceY,this.sourceZ,this.targetX,this.targetY,this.targetZ)
                set this.xtype = 1
                set this.moving = true
                static if USE_CUSTOM_DATA then
                    if this.customData < 0 then
                        set this.customData = Table.create()
                    endif
                endif
                static if USE_GLOBAL_CREATE then
                    call TriggerEvaluate(globalCreate)
                endif
                call this.startPeriodic()
                return this
            endmethod
           
            static method pointToPointExZ takes real sourceX, real deltaSourceX, real sourceY, real deltaSourceY, real targetX, real deltaTargetX, real targetY, real deltaTargetY, real sourceZ, real sourceCurZ, real targetZ, real targetCurZ, real duration, string leffect, integer eventkey  returns thistype
                local thistype this = thistype.new()
                set this.u1 = null
                set this.u2 = null
                set this.sourceX = sourceX
                set this.sourceY = sourceY
                set this.targetX = targetX
                set this.targetY = targetY
                set this.deltaSourceZ = (sourceCurZ - sourceZ)*(T32_PERIOD/duration)
                set this.deltaTargetZ = (targetCurZ-targetZ)*(T32_PERIOD/duration)
                set this.deltaSourceX = (deltaSourceX - sourceX)*(T32_PERIOD/duration)
                set this.deltaSourceY = (deltaSourceY - sourceY)*(T32_PERIOD/duration)
                set this.deltaTargetX = (deltaTargetX - targetX)*(T32_PERIOD/duration)
                set this.deltaTargetY = (deltaTargetY - targetY)*(T32_PERIOD/duration)
                call MoveLocation(loc, this.sourceX,this.sourceY)
                set this.sourceZ = sourceZ + GetLocationZ(loc)
                call MoveLocation(loc, this.targetX,this.targetY)
                set this.targetZ = targetZ + GetLocationZ(loc)
                set this.timed = true
                set this.duration = duration
                set this.eventkey = eventkey
                set this.light = AddLightningEx(leffect,false,this.sourceX,this.sourceY,this.sourceZ,this.targetX,this.targetY,this.targetZ)
                set this.xtype = 3
                set this.moving = true
                static if USE_CUSTOM_DATA then
                    if this.customData < 0 then
                        set this.customData = Table.create()
                    endif
                endif
                static if USE_GLOBAL_CREATE then
                    call TriggerEvaluate(globalCreate)
                endif
                call this.startPeriodic()
                return this
            endmethod
           
            static method unitToPointExZ takes unit unit1, real x, real xx, real y, real yx, real sourceZ, real targetZ, real targetCurZ, real duration, string leffect, integer eventkey  returns thistype
                local thistype this = thistype.new()
                set this.u1 = unit1
                set this.u2 = null
                set this.sourceX = GetUnitX(this.u1)
                set this.sourceY = GetUnitY(this.u1)
                set this.targetX = x
                set this.targetY = y
                set this.deltaTargetZ = (targetCurZ - targetZ)*(T32_PERIOD/duration)
                set this.deltaTargetX = (xx - x)*(T32_PERIOD/duration)
                set this.deltaTargetY = (yx - y)*(T32_PERIOD/duration)
                call MoveLocation(loc, this.sourceX,this.sourceY)
                set this.sourceZ = sourceZ + GetUnitFlyHeight(this.u1) + GetLocationZ(loc)
                call MoveLocation(loc, this.targetX,this.targetY)
                set this.targetZ = targetZ + GetLocationZ(loc)
                set this.timed = true
                set this.duration = duration
                set this.eventkey = eventkey
                set this.light = AddLightningEx(leffect,false,this.sourceX,this.sourceY,this.sourceZ,this.targetX,this.targetY,this.targetZ)
                set this.xtype = 1
                set this.moving = true
                static if USE_CUSTOM_DATA then
                    if this.customData < 0 then
                        set this.customData = Table.create()
                    endif
                endif
                static if USE_GLOBAL_CREATE then
                    call TriggerEvaluate(globalCreate)
                endif
                call this.startPeriodic()
                return this
            endmethod
    
            /*
            static method unitToEffect takes unit unit1, SpecialEffect effect1, real sourceZ, real targetZ, boolean timed, real duration, string leffect, integer eventkey  returns thistype
                local thistype this = thistype.new()
                set this.u1 = unit1
                set this.e1 = effect1
                set this.sourceX = GetUnitX(this.u1)
                set this.sourceY = GetUnitY(this.u1)
                set this.targetX = this.e1.x
                set this.targetY = this.e1.y
                call MoveLocation(loc, this.sourceX,this.sourceY)
                set this.sourceZ = sourceZ + GetUnitFlyHeight(this.u1) //+ GetLocationZ(loc)
                call MoveLocation(loc, this.targetX,this.targetY)
                set this.targetZ = targetZ + this.e1.z //+ GetLocationZ(loc)
                set this.timed = timed
                set this.duration = duration
                set this.eventkey = eventkey
                set this.light = AddLightningEx(leffect,false,this.sourceX,this.sourceY,this.sourceZ,this.targetX,this.targetY,this.targetZ)
                set this.xtype = 4
                set this.moving = false
                static if USE_CUSTOM_DATA then
                    if this.customData < 0 then
                        set this.customData = Table.create()
                    endif
                endif
                static if USE_GLOBAL_CREATE then
                    call TriggerEvaluate(globalCreate)
                endif
                call this.startPeriodic()
                return this
            endmethod
    
            static method effectToEffect takes SpecialEffect effect1, SpecialEffect effect2, real sourceZ, real targetZ, boolean timed, real duration, string leffect, integer eventkey  returns thistype
                local thistype this = thistype.new()
                set this.e1 = effect1
                set this.e2 = effect2
                set this.sourceX = this.e1.x
                set this.sourceY = this.e1.y
                set this.targetX = this.e2.x
                set this.targetY = this.e2.y
                call MoveLocation(loc, this.sourceX,this.sourceY)
                set this.sourceZ = sourceZ + this.e1.z //+ GetLocationZ(loc)
                call MoveLocation(loc, this.targetX,this.targetY)
                set this.targetZ = targetZ + this.e2.z //+ GetLocationZ(loc)
                set this.timed = timed
                set this.duration = duration
                set this.eventkey = eventkey
                set this.light = AddLightningEx(leffect,false,this.sourceX,this.sourceY,this.sourceZ,this.targetX,this.targetY,this.targetZ)
                set this.xtype = 5
                set this.moving = false
                static if USE_CUSTOM_DATA then
                    if this.customData < 0 then
                        set this.customData = Table.create()
                    endif
                endif
                static if USE_GLOBAL_CREATE then
                    call TriggerEvaluate(globalCreate)
                endif
                call this.startPeriodic()
                return this
            endmethod*/
           
            implement init
        endstruct
       
    endlibrary