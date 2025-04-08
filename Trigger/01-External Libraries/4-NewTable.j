library Table /* made by Bribe, special thanks to Vexorian & Nestharus, version 6

    One map, one hashtable, one Table struct.

    Version 6 combines multi-dimensional Tables, TableArray, HandleTable and StringTable into...

        ...Table.

    What's changed? What does the API look like now? Read on to find out:

    Universal Table operations:
    | static method create takes nothing returns Table
    |     create a new Table
    |
    | method destroy takes nothing returns nothing
    |     flush and destroy the Table.
    |
    |     NOTE: this method incorporates the former TableArray.flush() method.
    |
    | method flush takes nothing returns nothing
    |     Erase all saved values inside of the Table
    |
    |     NOTE: This does not flush all parallel instances in a forked Table.
    |           It only flushes the current Table instance.
    |
    | static method createFork takes integer width returns Table
    |     creates a Table that is a negative integer rather than positive one.
    |
    |     NOTE: formerly, this was `static method operator []` on TableArray.
    |
    | method switch takes integer offset returns Table
    |     switches from the current Table to any offset between 0 and 'width - 1'
    |
    |     NOTE: formerly, this was `method operator []` on TableArray.
    |
    |     NOTE: Only works with Tables created as forks.
    |
    | method measureFork takes nothing returns integer
    |     returns the number passed to `createFork`.
    |     formerly, this was `method size` on TableArray.
    |
    | method getKeys takes nothing returns Table
    |     returns a readonly Table containing:
    |       [0] - the number of tracked keys in the Table
    |       [1->number of keys] - contiguous list of keys found inside of the Table.
    |           Effectively combines Object.keys(obj) from JavaScript with 1-based arrays of Lua.
    |
    | -> How to iterate to access values:
    |
    |     local Table keys = myTable.getKeys()
    |     local integer i = keys[0]
    |     loop
    |         exitwhen i == 0
    |         call BJDebugMsg("My value is: " + I2S(myTable[keys[i]]))
    |         set i = i - 1
    |     endloop
    |

    Standard Table operations (store Tables or integers against integer keys):
    | method operator [] takes integer key returns Table
    |     load the value at index `key`
    |
    | method operator []= takes integer key, Table value returns nothing
    |     assign "value" to index `key` without tracking it. Like `rawset` in Lua.
    |
    | method remove takes integer key returns nothing
    |     remove the value at index `key`
    |
    | method has takes integer key returns boolean
    |     whether or not `key` has been assigned
    |
    | method save takes integer key, Table value returns Table
    |     a new method to not just add the value to the Table, but to also track it.
    |     Returns `this` Table, so `save` calls can be daisy-chained.
    |

    Multi-Dimensional Table operations (store nested Tables against integer keys):
    | method link takes integer key returns Table
    |     Checks if a Table already exists at the key, and creates one if not.
    |
    |     Note: Formerly, you needed to create a Table2/3/4/5D/T to access this method.
    |     Note: Can be substituted for `[]` if you are certain that the key is set.
    |
    |     Note: Links are all tracked by default. To avoid the extra tracking behavior,
    |           you can either use a static Table (`struct.typeid` or `key`) or you can
    |           use Table.createFork(1) instead of Table.create() or
    |           myTable.forkLink(1, key) instead of myTable.link(key)
    |
    | method forkLink takes integer width, integer key returns Table
    |       Checks if a Fork already exists at the key, and creates one with the chosen size if not.

    HandleTable operations (store Tables against handle keys):
    | method operator get takes handle key returns Tables
    |     Alias for `[]`
    |
    | method operator store takes handle key, Table value returns Table
    |     Alias for `save`
    |
    | method forget takes handle key returns nothing
    |     Alias for `remove`
    |
    | method stores takes handle key returns boolean
    |     Alias for `has`
    |
    | method bind takes handle key returns Table
    |     Alias for `link`
    |
    | method forkBind takes handle key returns Table
    |     Alias for `forkLink`

    StringTable operations (store Tables against string keys):
    | method operator read takes string key returns Table
    |     Alias for `[]`
    |
    | method operator write takes string key, Table value returns Table
    |     Alias for `save`
    |
    | method delete takes string key returns nothing
    |     Alias for `remove`
    |
    | method written takes string key returns boolean
    |     Alias for `has`
    |
    | method join takes string key returns Table
    |     Alias for `link`
    |
    | method forkJoin takes string key returns Table
    |     Alias for `forkLink`

    Tables that store non-integer/Table values can access the `standard` Table API just by using .type syntax:
    | myTable.unit[5] = GetTriggerUnit()
    | myTable.unit.save(10, GetTriggerUnit())
    | myTable.unit.store(GetAttacker(), GetTriggerUnit())
    | myTable.unit.write("whatever you want", GetTriggerUnit())
    |
    | myTable.handle.remove(10)
    | myTable.handle.forget(GetAttacker())
    | myTable.handle.delete("whatever you want")
    |
    | local string s = myTable.string[15]
    | local string t = myTable.string.get(GetSpellTargetUnit())
    | local string u = myTable.string.read("something you want")
    |
    | local boolean b = myTable.string.has(15)
    | local boolean c = myTable.string.stores(GetSpellTargetUnit())
    | local boolean d = myTable.string.written("something you want")

*/ requires optional Table5BC, optional TableVBC

globals
    private integer tableKeyGen = 8190  //Index generation for Tables starts from here. Configure it if your map contains more than this many structs or 'key' objects.

    private hashtable hashTable = InitHashtable() // The last hashtable.

    private constant boolean TEST = false      // set to `true` to enable error messages and `print`/`toString` API.
    private constant boolean DEEP_TEST = false // set to `true` to enable informational messages.

    private keyword addKey
    private keyword addTypedKey

    private keyword IntegerModule
    private keyword RealModule
    private keyword BooleanModule
    private keyword StringModule
    private keyword PlayerModule
    private keyword WidgetModule
    private keyword DestructableModule
    private keyword ItemModule
    private keyword UnitModule
    private keyword AbilityModule
    private keyword TimerModule
    private keyword TriggerModule
    private keyword TriggerConditionModule
    private keyword TriggerActionModule
    private keyword TriggerEventModule
    private keyword ForceModule
    private keyword GroupModule
    private keyword LocationModule
    private keyword RectModule
    private keyword BooleanExprModule
    private keyword SoundModule
    private keyword EffectModule
    private keyword UnitPoolModule
    private keyword ItemPoolModule
    private keyword QuestModule
    private keyword QuestItemModule
    private keyword DefeatConditionModule
    private keyword TimerDialogModule
    private keyword LeaderboardModule
    private keyword MultiboardModule
    private keyword MultiboardItemModule
    private keyword TrackableModule
    private keyword DialogModule
    private keyword ButtonModule
    private keyword TextTagModule
    private keyword LightningModule
    private keyword ImageModule
    private keyword UbersplatModule
    private keyword RegionModule
    private keyword FogStateModule
    private keyword FogModifierModule
    private keyword HashtableModule
    private keyword FrameModule

    private keyword AgentStruct
    private keyword HandleStruct
    private keyword IntegerStruct
    private keyword RealStruct
    private keyword BooleanStruct
    private keyword StringStruct
    private keyword PlayerStruct
    private keyword WidgetStruct
    private keyword DestructableStruct
    private keyword ItemStruct
    private keyword UnitStruct
    private keyword AbilityStruct
    private keyword TimerStruct
    private keyword TriggerStruct
    private keyword TriggerConditionStruct
    private keyword TriggerActionStruct
    private keyword TriggerEventStruct
    private keyword ForceStruct
    private keyword GroupStruct
    private keyword LocationStruct
    private keyword RectStruct
    private keyword BooleanExprStruct
    private keyword SoundStruct
    private keyword EffectStruct
    private keyword UnitPoolStruct
    private keyword ItemPoolStruct
    private keyword QuestStruct
    private keyword QuestItemStruct
    private keyword DefeatConditionStruct
    private keyword TimerDialogStruct
    private keyword LeaderboardStruct
    private keyword MultiboardStruct
    private keyword MultiboardItemStruct
    private keyword TrackableStruct
    private keyword DialogStruct
    private keyword ButtonStruct
    private keyword TextTagStruct
    private keyword LightningStruct
    private keyword ImageStruct
    private keyword UbersplatStruct
    private keyword RegionStruct
    private keyword FogStateStruct
    private keyword FogModifierStruct
    private keyword HashtableStruct
    private keyword FrameStruct
endglobals

struct Table extends array
    private static method operator shadowTable takes nothing returns Table
        // Table:Table:integer|real|string
        return HashtableStruct.typeid
    endmethod
    private static method operator parentTable takes nothing returns Table
        // Table:Table
        return RealStruct.typeid
    endmethod
    private static method operator hasChildTables takes nothing returns Table
        // Table:boolean
        return BooleanStruct.typeid
    endmethod
    private static method operator seenTables takes nothing returns Table
        // Table:boolean
        return StringStruct.typeid
    endmethod
    private static method operator instanceData takes nothing returns Table
        // Table:integer
        return Table.typeid
    endmethod
    private static method operator widths takes nothing returns Table
        // Table:integer
        return HandleStruct.typeid
    endmethod
    private static method operator recycledArrays takes nothing returns Table
        // The same table, but with a better name for its purpose.
        return HandleStruct.typeid
    endmethod
    private static integer forkKeyGen = 0
    private static boolean isShadow = false
    private static integer cleanUntil
    private static Table tableToClean

    method operator [] takes integer key returns Table
        return LoadInteger(hashTable, this, key)
    endmethod
    method read takes string key returns Table
        return this[StringHash(key)]
    endmethod
    method get takes handle key returns Table
        return this[GetHandleId(key)]
    endmethod

    method operator []= takes integer key, Table value returns nothing
        call SaveInteger(hashTable, this, key, value)
    endmethod

    method has takes integer key returns boolean
        return HaveSavedInteger(hashTable, this, key)
    endmethod
    method written takes string key returns boolean
        return this.has(StringHash(key))
    endmethod
    method stores takes handle key returns boolean
        return this.has(GetHandleId(key))
    endmethod

    // Remove all keys and values from a Table instance
    method flush takes nothing returns nothing
        local Table shadow = shadowTable[this]
        call FlushChildHashtable(hashTable, this)
        if this > 0 and shadow > 0 then
            call FlushChildHashtable(hashTable, shadow)
        endif
        call RemoveSavedBoolean(hashTable, hasChildTables, this)
    endmethod

    // This method enables quick table[parentIndex][childIndex].
    //
    // local Table table = Table.createFork(3)
    // set table[15] = 40 // index 0 remains on the same table, so there is no need to switch to one of the parallel tables.
    // set table.switch(1).unit[5] = GetTriggerUnit()
    // set table.switch(2)[10] = 20
    //
    // Inline-friendly when not running in `TEST` mode
    //
    method switch takes integer key returns Table
        static if TEST then
            local integer i = widths[this]
            if i == 0 then
                call BJDebugMsg("Table.switch Error: Tried to invoke 'switch' method on invalid Table: " + I2S(this))
            elseif key < 0 or key >= i then
                call BJDebugMsg("Table.switch Error: Tried to get key [" + I2S(key) + "] from outside bounds: " + I2S(i))
            endif
        endif
        return this + key
    endmethod

    // Returns a new Table instance that can save/load any hashtable-compatible data type.
    static method create takes nothing returns Table
        local Table table = instanceData[0]

        if table == 0 then
            set table = tableKeyGen + 1
            set tableKeyGen = table
            static if DEEP_TEST then
                call BJDebugMsg("Table.create getting new index: " + I2S(table))
            endif
        else
            set instanceData[0] = instanceData[table]
            static if DEEP_TEST then
                call BJDebugMsg("Table.create recycling index: " + I2S(table))
            endif
        endif

        set instanceData[table] = -1

        if isShadow then
            set isShadow = false
        else
            set isShadow = true
            set shadowTable[table] = Table.create()
        endif

        return table
    endmethod

    private method recycle takes nothing returns nothing
        call this.flush()
        if instanceData[this] != -1 then
            static if TEST then
                call BJDebugMsg("Table.recycle Error: " + I2S(this) + " is already inactive!")
            endif
            return
        endif
        set instanceData[this] = instanceData[0]
        set instanceData[0] = this
    endmethod

    private method setInactive takes nothing returns nothing
        local Table shadow = shadowTable[this]
        call this.recycle()
        if shadow > 0 then
            static if DEEP_TEST then
                call BJDebugMsg("Setting " + I2S(this) + " and its shadow " + I2S(shadow) + " to inactive state.")
            endif
            call shadow.recycle()
            call RemoveSavedInteger(hashTable, shadowTable, this)
            call RemoveSavedInteger(hashTable, parentTable, this)
        else
            static if DEEP_TEST then
                call BJDebugMsg("Setting Table: " + I2S(this) + " to inactive state.")
            endif
        endif
    endmethod

    // Returns:
    // -1: invalid Table for this operation (key/typeid/fork Table, or simply a destroyed/incorrect reference to a Table).
    //  0: key does not exist yet in the Table
    // >0: key exists in the Table.
    method getKeyIndex takes integer key returns integer
        local Table shadow = shadowTable[this]
        if this <= 0 or shadow == 0 then
            return -1
        endif
        return R2I(LoadReal(hashTable, shadow, key))
    endmethod

    method addKey takes integer key returns nothing
        local Table shadow
        local integer i = this.getKeyIndex(key)
        if i == 0 then
            set shadow = shadowTable[this]
            set i = shadow[0] + 1
            set shadow[0] = i
            set shadow[i] = key
            call SaveReal(hashTable, shadow, key, i)
            static if DEEP_TEST then
                call BJDebugMsg("Increasing table " + I2S(this) + "'s' key size to " + I2S(i))
            endif
        endif
    endmethod

    static if TEST then
        method addTypedKey takes integer key, string whichType returns nothing
            local Table shadow = shadowTable[this]
            local string oldType = LoadStr(hashTable, shadow, key)
            if oldType != null and oldType != whichType then
                call BJDebugMsg("Table.addKey Error: Type " + whichType + " and " + oldType + " saved at key: " + I2S(key))
            endif
            call SaveStr(hashTable, shadow, key, whichType)
            call this.addKey(key)
        endmethod
    endif

    private method nestTable takes integer key, Table table returns nothing
        set this[key] = table
        static if TEST then
            call this.addTypedKey(key, "Table")
        else
            call this.addKey(key)
        endif
        set parentTable[table] = this
        call SaveBoolean(hashTable, hasChildTables, this, true)
    endmethod

    method link takes integer key returns Table
        local Table table = this[key]
        if table == 0 then
            set table = Table.create()
            static if DEEP_TEST then
                call BJDebugMsg("Table(" + I2S(this) + ")[" + I2S(key) + "] => Table(" + I2S(table) + ")")
            endif
        elseif instanceData[table] != -1 then
            static if TEST then
                call BJDebugMsg("Table.link Error: Invalid Table " + I2S(table) + " found at key " + I2S(key))
            endif
            return 0
        endif
        call this.nestTable(key, table)
        return table
    endmethod

    method save takes integer key, Table value returns Table
        static if TEST then
            call Table(this).addTypedKey(key, "Table")
        else
            call Table(this).addKey(key)
        endif
        set this[key] = value
        return this
    endmethod
    method write takes string key, Table value returns Table
        return this.save(StringHash(key), value)
    endmethod
    method store takes handle key, Table value returns Table
        return this.save(GetHandleId(key), value)
    endmethod

    method join takes string key returns Table
        return this.link(StringHash(key))
    endmethod

    method bind takes handle key returns Table
        return this.link(GetHandleId(key))
    endmethod

    private static method cleanFork takes nothing returns nothing
        local Table table = tableToClean
        local integer exitWhen = table + 0x1000
        if exitWhen < cleanUntil then
            set tableToClean = exitWhen
            //Avoids hitting the op limit
            call ForForce(bj_FORCE_PLAYER[0], function Table.cleanFork)
        else
            set exitWhen = cleanUntil
        endif
        loop
            exitwhen table == exitWhen
            call table.flush()
            set table = table + 1
        endloop
    endmethod

    private method destroyFork takes nothing returns boolean
        local integer width = widths[this]
        local Table recycled
        local integer i = width

        if this >= 0 or width == 0 then
            return false
        endif

        set tableToClean = this
        set cleanUntil = this + widths[this]
        call Table.cleanFork()

        call RemoveSavedInteger(hashTable, widths, this) //Clear the array size from hash memory

        set recycled = recycledArrays.link(width)
        set recycled[this] = recycled[0]
        set recycled[0] = this

        return true
    endmethod

    // Returns a special type of Table with `width` parallel indices.
    //
    // local Table fork = Table.fork(width)
    //
    static method createFork takes integer width returns Table
        local Table recycled = recycledArrays.link(width) //Get the unique recycle list for this array size
        local Table fork = recycled[0]                         //The last-destroyed fork that had this array size

        if width <= 0 then
            static if TEST then
                call BJDebugMsg("Table.createFork Error: Invalid specified width: " + I2S(width))
            endif
            return 0
        endif

        if fork == 0 then
            set fork = forkKeyGen - width // If we start with 8190, the first fork index will be -8190
            set forkKeyGen = fork
        else
            set recycled[0] = recycled[fork]  //Set the last destroyed to the last-last destroyed
            call RemoveSavedInteger(hashTable, recycled, fork)
        endif

        set widths[fork] = width
        return fork
    endmethod

    method forkLink takes integer width, integer key returns Table
        local Table table = this[key]
        if table == 0 then
            set table = Table.createFork(width)
        elseif widths[this] == 0 then
            static if TEST then
                call BJDebugMsg("Table.forkLink Error: Invalid Table " + I2S(table) + " found at key " + I2S(key))
            endif
            return 0
        endif
        call this.nestTable(key, table)
        return table
    endmethod

    method forkJoin takes integer width, string key returns Table
        return this.forkLink(width, StringHash(key))
    endmethod

    method forkBind takes integer width, handle key returns Table
        return this.forkLink(width, GetHandleId(key))
    endmethod

    method getKeys takes nothing returns integer
        local Table shadow = shadowTable[this]
        if this <= 0 or shadow == 0 then
            static if TEST then
                call BJDebugMsg("Table.getKeys Error: Called on invalid Table " + I2S(this))
            endif
            return 0
        endif
        return shadow
    endmethod

    method measureFork takes nothing returns integer
        return widths[this]
    endmethod

    private method destroyDeep takes nothing returns nothing
        local Table shadow = shadowTable[this]
        local integer i = shadow[0] //get the number of tracked indices
        local Table table

        static if DEEP_TEST then
            call BJDebugMsg("Destroying Table: " + I2S(this) + " and all of its child tables.")
        endif

        // Mark this table as seen to avoid potentially-infinite recursion
        call SaveBoolean(hashTable, seenTables, this, true)

        loop
            exitwhen i == 0
            // Get the actual table using the index from shadow
            set table = this[shadow[i]]
            if table > 0 then
                if instanceData[table] == -1 and /*
                    */ parentTable[table] == this and /*
                    */ not LoadBoolean(hashTable, seenTables, table) /*
                */ then
                    if LoadBoolean(hashTable, hasChildTables, table) then
                        call table.destroyDeep()
                    else
                        call table.setInactive()
                    endif
                endif
            elseif table < 0 then
                call this.destroyFork()
            endif
            set i = i - 1
        endloop
        call this.setInactive()
    endmethod

    // Removes all data from a Table instance and recycles its index.
    method destroy takes nothing returns nothing
        if instanceData[this] != -1 then
            if not this.destroyFork() then
                static if TEST then
                    call BJDebugMsg("Table.destroy Error: Inactive Table: " + I2S(this))
                endif
            endif
        else
            if LoadBoolean(hashTable, hasChildTables, this) then
                call this.destroyDeep()
                call FlushChildHashtable(hashTable, seenTables)
            else
                call this.setInactive()
            endif
        endif
    endmethod

    method removeKey takes integer key returns nothing
        local Table shadow
        local Table child = this[key]
        local integer i = this.getKeyIndex(key)
        local integer top
        if i > 0 then
            set shadow = shadowTable[this]
            static if TEST then
                call RemoveSavedString(hashTable, shadow, key)
            endif
            set top = shadow[0]
            if top == 1 then
                call FlushChildHashtable(hashTable, shadow)
            else
                call RemoveSavedReal(hashTable, shadow, key)
                set shadow[0] = top - 1
                if top != i then
                    set key = shadow[top]
                    set shadow[i] = key
                    call SaveReal(hashTable, shadow, key, i)
                endif
                call RemoveSavedInteger(hashTable, shadow, top)
            endif
        endif
        if child > 0 and /*
            */ instanceData[child] == -1 and /*
            */ parentTable[child] == this /*
        */ then
            call child.destroy()
        endif
    endmethod

    method remove takes integer key returns nothing
        call this.removeKey(key)
        call RemoveSavedInteger(hashTable, this, key)
    endmethod
    method delete takes string key returns nothing
        call this.remove(StringHash(key))
    endmethod
    method forget takes handle key returns nothing
        call this.remove(GetHandleId(key))
    endmethod

    method operator handle takes nothing returns HandleStruct
        return this
    endmethod

    method operator agent takes nothing returns AgentStruct
        return this
    endmethod

    // Implement modules for handle/agent/integer/real/boolean/string/etc syntax.
    implement IntegerModule
    implement RealModule
    implement BooleanModule
    implement StringModule
    implement PlayerModule
    implement WidgetModule
    implement DestructableModule
    implement ItemModule
    implement UnitModule
    implement AbilityModule
    implement TimerModule
    implement TriggerModule
    implement TriggerConditionModule
    implement TriggerActionModule
    implement TriggerEventModule
    implement ForceModule
    implement GroupModule
    implement LocationModule
    implement RectModule
    implement BooleanExprModule
    implement SoundModule
    implement EffectModule
    implement UnitPoolModule
    implement ItemPoolModule
    implement QuestModule
    implement QuestItemModule
    implement DefeatConditionModule
    implement TimerDialogModule
    implement LeaderboardModule
    implement MultiboardModule
    implement MultiboardItemModule
    implement TrackableModule
    implement DialogModule
    implement ButtonModule
    implement TextTagModule
    implement LightningModule
    implement ImageModule
    implement UbersplatModule
    implement RegionModule
    implement FogStateModule
    implement FogModifierModule
    implement HashtableModule
    implement FrameModule

    static if TEST then
        private method toStringFn takes integer depth returns string
            local Table shadow = shadowTable[this]
            local integer i = shadow[0]
            local string indent = ""
            local integer k = 0
            local string output
            local Table table
            local string typeOf
            local string value
            local integer keyOf
            local string parsedKey

            // Determine if this is a tracked table and if it's already been seen
            if this > 0 and shadow > 0 then
                if HaveSavedBoolean(hashTable, seenTables, this) then
                    // Show already-referenced Table:
                    return "Seen Table(" + I2S(this) + ")"
                endif
                call SaveBoolean(hashTable, seenTables, this, true)
                if i == 0 then
                    // Show empty Table:
                    return "Table(" + I2S(this) + ")[]"
                endif
                set output = "Table(" + I2S(this) + ")["
            elseif instanceData[this] > 0 then
                return "Destroyed Table(" + I2S(this) + ")"
            elseif widths[this] > 0 then
                return "Tables " + I2S(this) + " through " + I2S(this + widths[this] - 1)
            elseif instanceData[this] == 0 then
                return "Invalid Table(" + I2S(this) + ")"
            endif

            loop
                exitwhen k == depth
                set indent = indent + "  "
                set k = k + 1
            endloop

            loop
                exitwhen i == 0
                set keyOf = shadow[i]
                set typeOf = LoadStr(hashTable, shadow, keyOf)
                set parsedKey = I2S(keyOf)
                if typeOf == "Table" then
                    set table = this[keyOf]
                    set typeOf = ""
                    if instanceData[keyOf] == -1 or widths[keyOf] > 0 then
                        set parsedKey = Table(keyOf).toStringFn(depth)
                    endif
                    if instanceData[table] == -1 or widths[table] > 0 then
                        set value = table.toStringFn(depth + 1)
                    else
                        set value = I2S(table) // simple integer
                    endif
                elseif typeOf == "integer" then
                    set typeOf = ""
                    set value = I2S(this[keyOf])
                elseif typeOf == "string" then
                    set typeOf = ""
                    set value = "\"" + LoadStr(hashTable, this, keyOf) + "\""
                elseif typeOf == "real" then
                    set typeOf = ""
                    set value = R2S(LoadReal(hashTable, this, keyOf))
                elseif typeOf == "boolean" then
                    set typeOf = ""
                    if LoadBoolean(hashTable, this, keyOf) then
                        set value = "true"
                    else
                        set value = "false"
                    endif
                elseif typeOf == null then
                    set typeOf = ""
                    set value = "untracked value"
                else
                    set value = ""
                endif
                set output = output + "\n" + indent + "  [" + parsedKey + "] = " + typeOf + value
                set i = i - 1
            endloop

            return output + "\n" + indent + "]"
        endmethod

        method toString takes nothing returns string
            local string result = this.toStringFn(0)
            call seenTables.flush()
            return result
        endmethod

        method print takes nothing returns nothing
            call BJDebugMsg(toString())
        endmethod
    endif

    //! runtextmacro optional TABLE_VBC_METHODS()
endstruct

/*
    Create API for stuff like:
        set table.unit[key] = GetTriggerUnit()
        local boolean b = table.handle.has(key)
        local unit u = table.unit[key]
        set table.handle.remove(key)

    These structs include the entire hashtable API as wrappers.

    Feel free to remove any types that you don't use.
*/

struct HandleStruct extends array
    method remove takes integer key returns nothing
        call Table(this).removeKey(key)
        call RemoveSavedHandle(hashTable, this, key)
    endmethod
    method delete takes string key returns nothing
        call this.remove(StringHash(key))
    endmethod
    method forget takes handle key returns nothing
        call this.remove(GetHandleId(key))
    endmethod

    method operator []= takes integer key, handle h returns nothing
        if h != null then
            // "But I need hashtables to typecast generic handles into ..." - say no more. I got u fam.
            call SaveFogStateHandle(hashTable, this, key, ConvertFogState(GetHandleId(h)))
        else
            call this.remove(key)
        endif
    endmethod
    method save takes integer key, agent value returns Table
        static if TEST then
            call Table(this).addTypedKey(key, "handle")
        else
            call Table(this).addKey(key)
        endif
        set this[key] = value
        return this
    endmethod
    method write takes string key, agent value returns Table
        return this.save(StringHash(key), value)
    endmethod
    method store takes handle key, agent value returns Table
        return this.save(GetHandleId(key), value)
    endmethod

    method has takes integer key returns boolean
        return HaveSavedHandle(hashTable, this, key)
    endmethod
    method written takes string key returns boolean
        return this.has(StringHash(key))
    endmethod
    method stores takes handle key returns boolean
        return this.has(GetHandleId(key))
    endmethod
endstruct

struct AgentStruct extends array
    method operator []= takes integer key, agent value returns nothing
        call SaveAgentHandle(hashTable, this, key, value)
    endmethod
    method save takes integer key, agent value returns Table
        static if TEST then
            call Table(this).addTypedKey(key, "agent")
        else
            call Table(this).addKey(key)
        endif
        set this[key] = value
        return this
    endmethod
    method write takes string key, agent value returns Table
        return this.save(StringHash(key), value)
    endmethod
    method store takes handle key, agent value returns Table
        return this.save(GetHandleId(key), value)
    endmethod
endstruct

//! textmacro BASIC_VALUE_TABLE takes SUPER, FUNC, TYPE
struct $SUPER$Struct extends array
    method operator [] takes integer key returns $TYPE$
        return Load$FUNC$(hashTable, this, key)
    endmethod
    method get takes handle key returns $TYPE$
        return this[GetHandleId(key)]
    endmethod
    method read takes string key returns $TYPE$
        return this[StringHash(key)]
    endmethod

    method operator []= takes integer key, $TYPE$ value returns nothing
        call Save$FUNC$(hashTable, this, key, value)
    endmethod
    method save takes integer key, $TYPE$ value returns Table
        static if TEST then
            call Table(this).addTypedKey(key, "$TYPE$")
        else
            call Table(this).addKey(key)
        endif
        set this[key] = value
        return this
    endmethod
    method store takes handle key, $TYPE$ value returns Table
        return this.save(GetHandleId(key), value)
    endmethod
    method write takes string key, $TYPE$ value returns Table
        return this.save(StringHash(key), value)
    endmethod

    method has takes integer key returns boolean
        return HaveSaved$SUPER$(hashTable, this, key)
    endmethod
    method written takes string key returns boolean
        return this.has(StringHash(key))
    endmethod
    method stores takes handle key returns boolean
        return this.has(GetHandleId(key))
    endmethod

    method remove takes integer key returns nothing
        call Table(this).removeKey(key)
        call RemoveSaved$SUPER$(hashTable, this, key)
    endmethod
    method delete takes string key returns nothing
        call this.remove(StringHash(key))
    endmethod
    method forget takes handle key returns nothing
        call this.remove(GetHandleId(key))
    endmethod
endstruct
module $SUPER$Module
    method operator $TYPE$ takes nothing returns $SUPER$Struct
        return this
    endmethod
endmodule
//! endtextmacro
//! runtextmacro BASIC_VALUE_TABLE("Real", "Real", "real")
//! runtextmacro BASIC_VALUE_TABLE("Boolean", "Boolean", "boolean")
//! runtextmacro BASIC_VALUE_TABLE("String", "Str", "string")
//! runtextmacro BASIC_VALUE_TABLE("Integer", "Integer", "integer")

//! textmacro HANDLE_VALUE_TABLE takes FUNC, TYPE
struct $FUNC$Struct extends array
    method operator [] takes integer key returns $TYPE$
        return Load$FUNC$Handle(hashTable, this, key)
    endmethod
    method get takes handle key returns $TYPE$
        return this[GetHandleId(key)]
    endmethod
    method read takes string key returns $TYPE$
        return this[StringHash(key)]
    endmethod

    method operator []= takes integer key, $TYPE$ value returns nothing
        call Save$FUNC$Handle(hashTable, this, key, value)
    endmethod
    method save takes integer key, $TYPE$ value returns Table
        static if TEST then
            call Table(this).addTypedKey(key, "$TYPE$")
        else
            call Table(this).addKey(key)
        endif
        set this[key] = value
        return this
    endmethod
    method store takes handle key, $TYPE$ value returns Table
        return this.save(GetHandleId(key), value)
    endmethod
    method write takes string key, $TYPE$ value returns Table
        return this.save(StringHash(key), value)
    endmethod

    // deprecated; use handle.has/stores/written
    method has takes integer key returns boolean
        return HaveSavedHandle(hashTable, this, key)
    endmethod

    // deprecated; use handle.remove/forget/delete
    method remove takes integer key returns nothing
        call HandleStruct(this).remove(key)
    endmethod
endstruct
module $FUNC$Module
    method operator $TYPE$ takes nothing returns $FUNC$Struct
        return this
    endmethod
endmodule
//! endtextmacro
//! runtextmacro HANDLE_VALUE_TABLE("Player", "player")
//! runtextmacro HANDLE_VALUE_TABLE("Widget", "widget")
//! runtextmacro HANDLE_VALUE_TABLE("Destructable", "destructable")
//! runtextmacro HANDLE_VALUE_TABLE("Item", "item")
//! runtextmacro HANDLE_VALUE_TABLE("Unit", "unit")
//! runtextmacro HANDLE_VALUE_TABLE("Ability", "ability")
//! runtextmacro HANDLE_VALUE_TABLE("Timer", "timer")
//! runtextmacro HANDLE_VALUE_TABLE("Trigger", "trigger")
//! runtextmacro HANDLE_VALUE_TABLE("TriggerCondition", "triggercondition")
//! runtextmacro HANDLE_VALUE_TABLE("TriggerAction", "triggeraction")
//! runtextmacro HANDLE_VALUE_TABLE("TriggerEvent", "event")
//! runtextmacro HANDLE_VALUE_TABLE("Force", "force")
//! runtextmacro HANDLE_VALUE_TABLE("Group", "group")
//! runtextmacro HANDLE_VALUE_TABLE("Location", "location")
//! runtextmacro HANDLE_VALUE_TABLE("Rect", "rect")
//! runtextmacro HANDLE_VALUE_TABLE("BooleanExpr", "boolexpr")
//! runtextmacro HANDLE_VALUE_TABLE("Sound", "sound")
//! runtextmacro HANDLE_VALUE_TABLE("Effect", "effect")
//! runtextmacro HANDLE_VALUE_TABLE("UnitPool", "unitpool")
//! runtextmacro HANDLE_VALUE_TABLE("ItemPool", "itempool")
//! runtextmacro HANDLE_VALUE_TABLE("Quest", "quest")
//! runtextmacro HANDLE_VALUE_TABLE("QuestItem", "questitem")
//! runtextmacro HANDLE_VALUE_TABLE("DefeatCondition", "defeatcondition")
//! runtextmacro HANDLE_VALUE_TABLE("TimerDialog", "timerdialog")
//! runtextmacro HANDLE_VALUE_TABLE("Leaderboard", "leaderboard")
//! runtextmacro HANDLE_VALUE_TABLE("Multiboard", "multiboard")
//! runtextmacro HANDLE_VALUE_TABLE("MultiboardItem", "multiboarditem")
//! runtextmacro HANDLE_VALUE_TABLE("Trackable", "trackable")
//! runtextmacro HANDLE_VALUE_TABLE("Dialog", "dialog")
//! runtextmacro HANDLE_VALUE_TABLE("Button", "button")
//! runtextmacro HANDLE_VALUE_TABLE("TextTag", "texttag")
//! runtextmacro HANDLE_VALUE_TABLE("Lightning", "lightning")
//! runtextmacro HANDLE_VALUE_TABLE("Image", "image")
//! runtextmacro HANDLE_VALUE_TABLE("Ubersplat", "ubersplat")
//! runtextmacro HANDLE_VALUE_TABLE("Region", "region")
//! runtextmacro HANDLE_VALUE_TABLE("FogState", "fogstate")
//! runtextmacro HANDLE_VALUE_TABLE("FogModifier", "fogmodifier")
//! runtextmacro HANDLE_VALUE_TABLE("Hashtable", "hashtable")
//! runtextmacro HANDLE_VALUE_TABLE("Frame", "framehandle")

//! runtextmacro optional TABLE_VBC_STRUCTS()

// Run these only to support backwards-compatibility.
// If you want to use them, include the Table5BC library in your script.
//! runtextmacro optional TABLE_ARRAY_BC()
//! runtextmacro optional TableXD("Table2D", "Table", "createFork(1)")
//! runtextmacro optional TableXD("Table3D", "Table2D", "createFork(1)")
//! runtextmacro optional TableXD("Table4D", "Table3D", "createFork(1)")
//! runtextmacro optional TableXD("Table5D", "Table4D", "createFork(1)")
//! runtextmacro optional TableXD("Table2DT", "Table", "create()")
//! runtextmacro optional TableXD("Table3DT", "Table2DT", "create()")
//! runtextmacro optional TableXD("Table4DT", "Table3DT", "create()")
//! runtextmacro optional TableXD("Table5DT", "Table4DT", "create()")
//! runtextmacro optional TableXD("HashTable", "Table", "createFork(1)")
//! runtextmacro optional TableXD("HashTableEx", "Table", "create()")

endlibrary