
//===========================================================================
//
//  Damage Engine 5.7.1.2 - update requires replacing the JASS script.
//
/*
    Three GUI Damage systems for the community of The Hive,
    Seven vJass Damage systems for the JASS-heads on their pedestals high,
    Nine competing Damage systems, doomed to die,
    One for Bribe on his dark throne
    In the Land of the Hive where the Workshop lies.
    One Damage Engine to rule them all, One Damage Engine to find them,
    One Damage Engine to bring them all and in cross-compatibility unite them.
*/
//! novjass
JASS API (work in progress - I have a lot of documentation to go through):
    struct Damage extends array
        readonly static unit  source        //stores udg_DamageEventSource
        readonly static unit  target        //stores udg_DamageEventTarget
        static real           amount        //stores udg_DamageEventAmount
        readonly unit         sourceUnit    //stores udg_DamageEventSource by index
        readonly unit         targetUnit    //stores udg_DamageEventTarget by index
        real                  damage        //stores udg_DamageEventAmount by index
        readonly real         prevAmt       //stores udg_DamageEventPrevAmt by index
        attacktype            attackType    //stores udg_DamageEventAttackT by index
        damagetype            damageType    //stores udg_DamageEventDamageT by index
        weapontype            weaponType    //stores udg_DamageEventWeaponT by index
        integer               userType      //stores udg_DamageEventType by index
        readonly integer      eFilter       //replaces the previous eventFilter variable
        readonly boolean      isAttack      //stores udg_IsDamageAttack by index
        readonly boolean      isCode        //stores udg_IsDamageCode by index
        readonly boolean      isMelee       //stores udg_IsDamageMelee by index
        readonly boolean      isRanged      //stores udg_IsDamageRanged by index
        readonly boolean      isSpell       //stores udg_IsDamageSpell by index
        real                  armorPierced  //stores udg_DamageEventArmorPierced by index
        integer               armorType     //stores udg_DamageEventArmorT by index
        integer               defenseType   //stores udg_DamageEventDefenseT by index
     
        static boolean operator enabled
        - Set to false to disable the damage event triggers/false to reverse that
     
        static method apply takes unit src, unit tgt, real amt, boolean a, boolean r, attacktype at, damagetype dt, weapontype wt returns Damage
        - Same arguments as "UnitDamageTarget" but has the benefit of being performance-friendly during recursive events.
        - Will automatically cause the damage to be registered as Code damage.
     
        static method applyMagic takes unit src, unit tgt, real amt, damagetype dt returns Damage
        - A simplified version of the above function that autofills in the booleans, attack type and weapon type.
        static method applyPhys takes unit src, unit tgt, real amt, boolean ranged, attacktype at, weapontype wt returns Damage
        - A different variation of the above which autofills the "attack" boolean and sets the damagetype to DAMAGE_TYPE_NORMAL.
    struct DamageTrigger extends array
        method operator filter= takes integer filter returns nothing
        // Apply primary filters such as DamageEngine_FILTER_MELEE/RANGED/SPELL which are based off of limitop handles to enable easier access for GUI folks
        // Full filter list:
        - global integer DamageEngine_FILTER_ATTACK
        - global integer DamageEngine_FILTER_MELEE
        - global integer DamageEngine_FILTER_OTHER
        - global integer DamageEngine_FILTER_RANGED
        - global integer DamageEngine_FILTER_SPELL
        - global integer DamageEngine_FILTER_CODE  
 
        boolean configured //set to True after configuring any filters listed below.
 
        method configure takes nothing returns nothing
        // Apply custom filters after setting any desired udg_DamageFilter variables (for GUI).
        // Alternatively, vJass users can set these instead. Just be mindful to set the variable
        // "configured" to true after settings these.
        unit    source
        unit    target
        integer sourceType
        integer targetType
        integer sourceBuff
        integer targetBuff
        real    damageMin
        integer attackType
        integer damageType
        integer userType
 
        //The string in the aruments below requires the following API:
        //  "" for standard damage event
        //  "Modifier(or Mod if you prefer)/After/Lethal/AOE" for the others
        static method getIndex takes trigger t, string eventName, real value returns integer
        static method registerTrigger takes trigger whichTrig, string var, real weight returns nothing
        static method unregister takes trigger t, string eventName, real value, boolean reset returns boolean
 
        static method operator [] takes code c returns trigger
        // Converts a code argument to a trigger, while checking if the same code had already been registered before.
    //The accepted strings here use the same criteria as DamageTrigger.getIndex/registerTrigger/unregister
    function TriggerRegisterDamageEngineEx takes trigger whichTrig, string eventName, real value, integer f returns nothing
    function TriggerRegisterDamageEngine takes trigger whichTrig, string eventName, real value returns nothing
    function RegisterDamageEngineEx takes code c, string eventName, real value, integer f returns nothing
    function RegisterDamageEngine takes code c, string eventName, real value returns nothing
//! endnovjass
//===========================================================================
library DamageEngine
globals
    private constant boolean USE_GUI        = false      //If you don't use any of the GUI events, set to false to slightly improve performance
                                                       
    private constant boolean USE_SCALING    = USE_GUI   //If you don't need or want to use DamageScalingUser/WC3 then set this to false
    private constant boolean USE_EXTRA      = true      //If you don't use DamageEventLevel or AOEDamageEvent, set this to false
    private constant boolean USE_ARMOR_MOD  = true      //If you do not modify nor detect armor/defense, set this to false
    private constant boolean USE_MELEE_RANGE= true      //If you do not detect melee nor ranged damage, set this to false
    private constant boolean USE_LETHAL     = true      //If you do not use LethalDamageEvent nor negative damage (explosive) types, set this to false
   
    private constant integer LIMBO          = 16        //When manually-enabled recursion is enabled via DamageEngine_recurion, the engine will never go deeper than LIMBO.
   
    public constant integer TYPE_CODE       = 1         //Must be the same as udg_DamageTypeCode, or 0 if you prefer to disable the automatic flag.
    public constant integer TYPE_PURE       = 2         //Must be the same as udg_DamageTypePure
    private constant real   DEATH_VAL       = 0.405     //In case Blizz ever changes this, it'll be a quick fix here.
    private timer           alarm           = CreateTimer()
    private boolean         alarmSet        = false
    //Values to track the original pre-spirit Link/defensive damage values
    private Damage          lastInstance    = 0
    private boolean         canKick         = true
    private boolean         totem           = false
    private boolean array   attacksImmune
    private boolean array   damagesImmune
    //Made global in order to use enable/disable behavior.
    private trigger         t1              = CreateTrigger()
    private trigger         t2              = CreateTrigger()
    private trigger         t3              = CreateTrigger() //Catches, stores recursive events
    //These variables coincide with Blizzard's "limitop" type definitions so as to enable users (GUI in particular) with some nice performance perks.
    public constant integer FILTER_ATTACK   = 0     //LESS_THAN
    public constant integer FILTER_MELEE    = 1     //LESS_THAN_OR_EQUAL
    public constant integer FILTER_OTHER    = 2     //EQUAL
    public constant integer FILTER_RANGED   = 3     //GREATER_THAN_OR_EQUAL
    public constant integer FILTER_SPELL    = 4     //GREATER_THAN
    public constant integer FILTER_CODE     = 5     //NOT_EQUAL
    public constant integer FILTER_MAX      = 6
    private integer         eventFilter     = FILTER_OTHER
    public boolean          inception       = false     //When true, it allows your trigger to potentially go recursive up to LIMBO. However it must be set per-trigger throughout the game and not only once per trigger during map initialization.
    private boolean         dreaming        = false
    private integer         sleepLevel      = 0
    private group           proclusGlobal   = CreateGroup() //track sources of recursion
    private group           fischerMorrow   = CreateGroup() //track targets of recursion
    private boolean         kicking         = false
    private boolean         eventsRun       = false
    private keyword         run
    private keyword         trigFrozen
    private keyword         levelsDeep
    private keyword         inceptionTrig
   
    private boolean         hasLethal       = false

    integer udg_NextDamageAbilitySource     = 0
endglobals
native UnitAlive takes unit u returns boolean
//GUI Vars:
/*
    Retained from 3.8 and prior:
    ----------------------------
    unit            udg_DamageEventSource
    unit            udg_DamageEventTarget
    unit            udg_EnhancedDamageTarget
    group           udg_DamageEventAOEGroup
    integer         udg_DamageEventAOE
    integer         udg_DamageEventLevel
    real            udg_DamageModifierEvent
    real            udg_DamageEvent
    real            udg_AfterDamageEvent
    real            udg_DamageEventAmount
    real            udg_DamageEventPrevAmt
    real            udg_AOEDamageEvent
    boolean         udg_DamageEventOverride
    boolean         udg_NextDamageType
    boolean         udg_DamageEventType
    boolean         udg_IsDamageSpell
    //Added in 5.0:
    boolean          udg_IsDamageMelee
    boolean          udg_IsDamageRanged
    unit             udg_AOEDamageSource
    real             udg_LethalDamageEvent
    real             udg_LethalDamageHP
    real             udg_DamageScalingWC3
    integer          udg_DamageEventAttackT
    integer          udg_DamageEventDamageT
    integer          udg_DamageEventWeaponT
    //Added in 5.1:
    boolean          udg_IsDamageCode
    //Added in 5.2:
    integer          udg_DamageEventArmorT
    integer          udg_DamageEventDefenseT
    //Addded in 5.3:
    real             DamageEventArmorPierced
    real             udg_DamageScalingUser
    //Added in 5.4.2 to allow GUI users to re-issue the exact same attack and damage type at the attacker.
    attacktype array udg_CONVERTED_ATTACK_TYPE
    damagetype array udg_CONVERTED_DAMAGE_TYPE
    //Added after Reforged introduced the new native BlzGetDamageIsAttack
    boolean         udg_IsDamageAttack
    //Added in 5.6 to give GUI users control over the "IsDamageAttack", "IsDamageRanged" and "DamageEventWeaponT" field
    boolean         udg_NextDamageIsAttack  //The first boolean value in the UnitDamageTarget native
    boolean         udg_NextDamageIsMelee   //Flag the damage classification as melee
    boolean         udg_NextDamageIsRanged  //The second boolean value in the UnitDamageTarget native
    integer         udg_NextDamageWeaponT   //Allows control over damage sound effect
    //Added in 5.7 to enable efficient, built-in filtering (see the below "checkConfiguration" method - I recommend commenting-out anything you don't need in your map)
    integer udg_DamageFilterAttackT
    integer udg_DamageFilterDamageT     //filter for a specific attack/damage type
    unit    udg_DamageFilterSource
    unit    udg_DamageFilterTarget      //filter for a specific source/target
    integer udg_DamageFilterSourceT
    integer udg_DamageFilterTargetT     //unit type of source/target
    integer udg_DamageFilterType        //which DamageEventType was used
    integer udg_DamageFilterSourceB
    integer udg_DamageFilterTargetB     //if source/target has a buff
    real    udg_DamageFilterMinAmount   //only allow a minimum damage threshold
*/
struct DamageTrigger extends array
   
    //Map-makers should comment-out any booleans they will never need to check for.
    method checkConfiguration takes nothing returns boolean
        if this.userType != 0 and udg_DamageEventType != this.userType then
        //elseif this.source != null and this.source != udg_DamageEventSource then
        //elseif this.target != null and this.target != udg_DamageEventTarget then
        //elseif this.attackType >= 0 and this.attackType != udg_DamageEventAttackT then
        //elseif this.damageType >= 0 and this.damageType != udg_DamageEventDamageT then
        //elseif this.sourceType != 0 and GetUnitTypeId(udg_DamageEventSource) != this.sourceType then
        //elseif this.targetType != 0 and GetUnitTypeId(udg_DamageEventTarget) != this.targetType then
        //elseif this.sourceBuff != 0 and GetUnitAbilityLevel(udg_DamageEventSource, this.sourceBuff) == 0 then
        //elseif this.targetBuff != 0 and GetUnitAbilityLevel(udg_DamageEventTarget, this.targetBuff) == 0 then
        elseif udg_DamageEventAmount > this.damageMin then
            return true
        endif
        return false
    endmethod
   
    //The below variables are constant
    readonly static thistype        MOD             = 1
    readonly static thistype        SHIELD          = 4
    readonly static thistype        DAMAGE          = 5
    readonly static thistype        ZERO            = 6
    readonly static thistype        AFTER           = 7
    readonly static thistype        LETHAL          = 8
    readonly static thistype        AOE             = 9
    private static integer          count           = 9
    static thistype                 lastRegistered  = 0
    private static thistype array   trigIndexStack
    static thistype                 eventIndex = 0
    static boolean array            filters
    readonly string                 eventStr
    readonly real                   weight
    boolean                         configured
    boolean                         usingGUI
    //The below variables are private
    private thistype                next
    private trigger                 rootTrig
    boolean                         trigFrozen      //Whether the trigger is currently disabled due to recursion
    integer                         levelsDeep      //How deep the user recursion currently is.
    boolean                         inceptionTrig   //Added in 5.4.2 to simplify the inception variable for very complex DamageEvent trigger.
    unit    source
    unit    target
    integer sourceType
    integer targetType
    integer sourceBuff
    integer targetBuff
    real    damageMin
    integer attackType
    integer damageType
    integer userType
    method configure takes nothing returns nothing
        set this.attackType         = udg_DamageFilterAttackT
        set this.damageType         = udg_DamageFilterDamageT
        set this.source             = udg_DamageFilterSource
        set this.target             = udg_DamageFilterTarget
        set this.sourceType         = udg_DamageFilterSourceT
        set this.targetType         = udg_DamageFilterTargetT
        set this.sourceBuff         = udg_DamageFilterSourceB
        set this.targetBuff         = udg_DamageFilterTargetB
        set this.userType           = udg_DamageFilterType
        set this.damageMin          = udg_DamageFilterMinAmount
 
        set udg_DamageFilterAttackT =-1
        set udg_DamageFilterDamageT =-1
        set udg_DamageFilterSource  = null
        set udg_DamageFilterTarget  = null
        set udg_DamageFilterSourceT = 0
        set udg_DamageFilterTargetT = 0
        set udg_DamageFilterType    = 0
        set udg_DamageFilterSourceB = 0
        set udg_DamageFilterTargetB = 0
        set udg_DamageFilterMinAmount=0.00
 
        set this.configured         = true
    endmethod
    static method setGUIFromStruct takes boolean full returns nothing
        set udg_DamageEventAmount       = Damage.index.damage
        set udg_DamageEventAttackT      = GetHandleId(Damage.index.attackType)
        set udg_DamageEventDamageT      = GetHandleId(Damage.index.damageType)
        set udg_DamageEventWeaponT      = GetHandleId(Damage.index.weaponType)
        set udg_DamageEventType         = Damage.index.userType
static if USE_ARMOR_MOD then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        set udg_DamageEventArmorPierced = Damage.index.armorPierced
        set udg_DamageEventArmorT       = Damage.index.armorType
        set udg_DamageEventDefenseT     = Damage.index.defenseType
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        if full then
            set udg_DamageEventSource   = Damage.index.sourceUnit
            set udg_DamageEventTarget   = Damage.index.targetUnit
            set udg_DamageEventPrevAmt  = Damage.index.prevAmt
            set udg_IsDamageAttack      = Damage.index.isAttack
            set udg_IsDamageCode        = Damage.index.isCode
            set udg_IsDamageSpell       = Damage.index.isSpell
static if USE_MELEE_RANGE then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            set udg_IsDamageMelee       = Damage.index.isMelee
            set udg_IsDamageRanged      = Damage.index.isRanged
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        endif
    endmethod
    static method setStructFromGUI takes nothing returns nothing
        set Damage.index.damage        = udg_DamageEventAmount
        set Damage.index.attackType    = ConvertAttackType(udg_DamageEventAttackT)
        set Damage.index.damageType    = ConvertDamageType(udg_DamageEventDamageT)
        set Damage.index.weaponType    = ConvertWeaponType(udg_DamageEventWeaponT)
        set Damage.index.userType      = udg_DamageEventType
static if USE_ARMOR_MOD then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        set Damage.index.armorPierced  = udg_DamageEventArmorPierced
        set Damage.index.armorType     = udg_DamageEventArmorT
        set Damage.index.defenseType   = udg_DamageEventDefenseT
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
    endmethod
    static method getVerboseStr takes string eventName returns string
        if eventName == "Modifier" or eventName == "Mod" then
            return "udg_DamageModifierEvent"
        endif
        return "udg_" + eventName + "DamageEvent"
    endmethod
    private static method getStrIndex takes string var, real lbs returns thistype
        local integer root = R2I(lbs)
        if var == "udg_DamageModifierEvent" then
            if root >= 4 then
                set root= SHIELD //4.00 or higher
            else  
                set root= MOD    //Less than 4.00
            endif
        elseif var == "udg_DamageEvent" then
            if root == 2 or root == 0 then
                set root= ZERO
            else
                set root= DAMAGE //Above 0.00 but less than 2.00, generally would just be 1.00
            endif
        elseif var == "udg_AfterDamageEvent" then
            set root    = AFTER
        elseif var == "udg_LethalDamageEvent" then
            set root    = LETHAL
        elseif var == "udg_AOEDamageEvent" then
            set root    = AOE
        else
            set root    = 0
            //! runtextmacro optional DAMAGE_EVENT_REG_PLUGIN_GDD()
            //! runtextmacro optional DAMAGE_EVENT_REG_PLUGIN_PDD()
            //! runtextmacro optional DAMAGE_EVENT_REG_PLUGIN_01()
            //! runtextmacro optional DAMAGE_EVENT_REG_PLUGIN_02()
            //! runtextmacro optional DAMAGE_EVENT_REG_PLUGIN_03()
            //! runtextmacro optional DAMAGE_EVENT_REG_PLUGIN_04()
            //! runtextmacro optional DAMAGE_EVENT_REG_PLUGIN_05()
        endif
        return root
    endmethod
    private method toggleAllFilters takes boolean flag returns nothing
        set filters[this + FILTER_ATTACK]   = flag
        set filters[this + FILTER_MELEE]    = flag
        set filters[this + FILTER_OTHER]    = flag
        set filters[this + FILTER_RANGED]   = flag
        set filters[this + FILTER_SPELL]    = flag
        set filters[this + FILTER_CODE]     = flag
    endmethod
    method operator filter= takes integer f returns nothing
        set this = this*FILTER_MAX
        if f == FILTER_OTHER then
            call this.toggleAllFilters(true)
        else
            if f == FILTER_ATTACK then
                set filters[this + FILTER_ATTACK]   = true
                set filters[this + FILTER_MELEE]    = true
                set filters[this + FILTER_RANGED]   = true
            else
                set filters[this + f] = true
            endif
        endif
    endmethod
    static method registerVerbose takes trigger whichTrig, string var, real lbs, boolean GUI, integer filt returns thistype
        local thistype index= getStrIndex(var, lbs)
        local thistype i    = 0
        local thistype id   = 0
 
        if index == 0 then
            return 0
        elseif lastRegistered.rootTrig == whichTrig and lastRegistered.usingGUI then
            set filters[lastRegistered*FILTER_MAX + filt] = true //allows GUI to register multiple different types of Damage filters to the same trigger
            return 0
        endif
 
        if not hasLethal and index == LETHAL then
            set hasLethal = true
        endif
        if trigIndexStack[0] == 0 then
            set count              = count + 1   //List runs from index 10 and up
            set id                 = count
        else
            set id                 = trigIndexStack[0]
            set trigIndexStack[0]  = trigIndexStack[id]
        endif
        set lastRegistered         = id
        set id.filter              = filt
        set id.rootTrig            = whichTrig
        set id.usingGUI            = GUI
        set id.weight              = lbs
        set id.eventStr            = var
       
        //Next 2 lines added to fix a bug when using manual vJass configuration,
        //discovered and solved by lolreported
        set id.attackType          = -1
        set id.damageType          = -1
 
        loop
            set i = index.next
            exitwhen i == 0 or lbs < i.weight
            set index = i
        endloop      
        set index.next = id
        set id.next    = i
 
        //call BJDebugMsg("Registered " + I2S(id) + " to " + I2S(index) + " and before " + I2S(i))
        return lastRegistered
    endmethod
    static method registerTrigger takes trigger t, string var, real lbs returns thistype
        return registerVerbose(t, DamageTrigger.getVerboseStr(var), lbs, false, FILTER_OTHER)
    endmethod
    private static thistype prev = 0
    static method getIndex takes trigger t, string eventName, real lbs returns thistype
        local thistype index = getStrIndex(getVerboseStr(eventName), lbs)
        loop
            set prev = index
            set index = index.next
            exitwhen index == 0 or index.rootTrig == t
        endloop
        return index
    endmethod
    static method unregister takes trigger t, string eventName, real lbs, boolean reset returns boolean
        local thistype index        = getIndex(t, eventName, lbs)
        if index == 0 then
            return false
        endif
        set prev.next               = index.next
     
        set trigIndexStack[index]   = trigIndexStack[0]
        set trigIndexStack[0]       = index
 
        if reset then
            call index.configure()
            set index.configured    = false
            set index               = index*FILTER_MAX
            call index.toggleAllFilters(false)
        endif
        return true
    endmethod
    method run takes nothing returns nothing
        local integer cat = this
        local Damage d = Damage.index
static if USE_GUI then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        local boolean structUnset = false
        local boolean guiUnset = false
        local boolean mod = cat <= DAMAGE
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        if dreaming then
            return    
        endif          
        set dreaming = true
        call DisableTrigger(t1)
        call DisableTrigger(t2)
        call EnableTrigger(t3)
        //call BJDebugMsg("Start of event running")
        loop                                  
            set this = this.next
            exitwhen this == 0
            exitwhen cat == MOD and (udg_DamageEventOverride or udg_DamageEventType == TYPE_PURE)
            exitwhen cat == SHIELD and udg_DamageEventAmount <= 0.00
static if USE_LETHAL then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            exitwhen cat == LETHAL and udg_LethalDamageHP > DEATH_VAL
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
         
            set eventIndex = this
            if not this.trigFrozen and filters[this*FILTER_MAX + d.eFilter] and IsTriggerEnabled(this.rootTrig) and (not this.configured or this.checkConfiguration()) then
static if USE_GUI then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
                if mod then
                    if this.usingGUI then
                        if guiUnset then
                            set guiUnset = false
                            call setGUIFromStruct(false)
                        endif
                        //! runtextmacro optional DAMAGE_EVENT_FILTER_PLUGIN_PDD()
                    elseif structUnset then
                        set structUnset = false
                        call setStructFromGUI()
                    endif
                endif
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
                //! runtextmacro optional DAMAGE_EVENT_FILTER_PLUGIN_01()
                //! runtextmacro optional DAMAGE_EVENT_FILTER_PLUGIN_02()
                //! runtextmacro optional DAMAGE_EVENT_FILTER_PLUGIN_03()
                //! runtextmacro optional DAMAGE_EVENT_FILTER_PLUGIN_04()
                //! runtextmacro optional DAMAGE_EVENT_FILTER_PLUGIN_05()
               
                //JASS users who do not use actions can modify the below block to just evaluate.
                //It should not make any perceptable difference in terms of performance.
                if TriggerEvaluate(this.rootTrig) then
                    call TriggerExecute(this.rootTrig)
                endif
                //! runtextmacro optional DAMAGE_EVENT_MOD_PLUGIN_01()
                //! runtextmacro optional DAMAGE_EVENT_MOD_PLUGIN_02()
                //! runtextmacro optional DAMAGE_EVENT_MOD_PLUGIN_03()
                //! runtextmacro optional DAMAGE_EVENT_MOD_PLUGIN_04()
                //! runtextmacro optional DAMAGE_EVENT_MOD_PLUGIN_05()
static if USE_GUI then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
                if mod then
                    if this.usingGUI then
                        //! runtextmacro optional DAMAGE_EVENT_MOD_PLUGIN_PDD()
                        if cat != MOD then
                            set d.damage        = udg_DamageEventAmount
                        else
                            set structUnset = true
                        endif
                    elseif cat != MOD then
                        set udg_DamageEventAmount = d.damage
                    else
                        set guiUnset = true
                    endif
                endif
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            endif
        endloop
static if USE_GUI then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        if structUnset then
            call setStructFromGUI()
        endif
        if guiUnset then
            call setGUIFromStruct(false)
        endif
else// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        call setGUIFromStruct(false)
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        //call BJDebugMsg("End of event running")
        call DisableTrigger(t3)
        call EnableTrigger(t1)
        call EnableTrigger(t2)
        set dreaming                                = false
    endmethod
    static trigger array    autoTriggers
    static boolexpr array   autoFuncs
    static integer          autoN = 0
    static method operator [] takes code c returns trigger
        local integer i             = 0
        local boolexpr b            = Filter(c)
        loop
            if i == autoN then
                set autoTriggers[i] = CreateTrigger()
                set autoFuncs[i]    = b
                call TriggerAddCondition(autoTriggers[i], b)
                exitwhen true
            endif
            set i = i + 1
            exitwhen b == autoFuncs[i]
        endloop
        return autoTriggers[i]
    endmethod
endstruct
//! runtextmacro optional DAMAGE_EVENT_USER_STRUCT_PLUGIN_01()
//! runtextmacro optional DAMAGE_EVENT_USER_STRUCT_PLUGIN_02()
//! runtextmacro optional DAMAGE_EVENT_USER_STRUCT_PLUGIN_03()
//! runtextmacro optional DAMAGE_EVENT_USER_STRUCT_PLUGIN_04()
//! runtextmacro optional DAMAGE_EVENT_USER_STRUCT_PLUGIN_05()
struct Damage extends array
    readonly unit           sourceUnit    //stores udg_DamageEventSource
    readonly unit           targetUnit    //stores udg_DamageEventTarget
    real                    damage        //stores udg_DamageEventAmount
    readonly real           prevAmt       //stores udg_DamageEventPrevAmt
    attacktype              attackType    //stores udg_DamageEventAttackT
    damagetype              damageType    //stores udg_DamageEventDamageT
    weapontype              weaponType    //stores udg_DamageEventWeaponT
    integer                 userType      //stores udg_DamageEventType
    integer                 abilitySource //stores udg_DamageAbilitySource
    readonly boolean        isAttack      //stores udg_IsDamageAttack
    readonly boolean        isCode        //stores udg_IsDamageCode
    readonly boolean        isSpell       //stores udg_IsDamageSpell
static if USE_MELEE_RANGE then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
    readonly boolean        isMelee       //stores udg_IsDamageMelee
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
    readonly boolean        isRanged      //stores udg_IsDamageRanged
    readonly integer        eFilter       //stores the previous eventFilter variable
   
static if USE_ARMOR_MOD then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
    real                    armorPierced  //stores udg_DamageEventArmorPierced
    integer                 armorType     //stores udg_DamageEventArmorT
    integer                 defenseType   //stores udg_DamageEventDefenseT
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
    readonly static Damage  index       = 0
    private static Damage   damageStack = 0
    private static Damage   prepped     = 0
    private static integer  count = 0 //The number of currently-running queued or sequential damage instances
    private Damage          stackRef
    private DamageTrigger   recursiveTrig
    private integer         prevArmorT
    private integer         prevDefenseT
    static method operator source takes nothing returns unit
        return udg_DamageEventSource
    endmethod
    static method operator target takes nothing returns unit
        return udg_DamageEventTarget
    endmethod
    static method operator amount takes nothing returns real
        return Damage.index.damage
    endmethod
    static method operator amount= takes real r returns nothing
        set Damage.index.damage = r
    endmethod
   
static if USE_ARMOR_MOD then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
    private method setArmor takes boolean reset returns nothing
        local real pierce
        local integer at
        local integer dt
        if reset then
            set pierce =  udg_DamageEventArmorPierced
            set at     =  Damage.index.prevArmorT
            set dt     =  Damage.index.prevDefenseT
            set udg_DamageEventArmorPierced = 0.00
            set this.armorPierced           = 0.00
        else
            set pierce = -udg_DamageEventArmorPierced
            set at     =  udg_DamageEventArmorT
            set dt     =  udg_DamageEventDefenseT
        endif
        if pierce != 0.00 and pierce != -0.00 then
            call BlzSetUnitArmor(udg_DamageEventTarget, BlzGetUnitArmor(udg_DamageEventTarget) + pierce)
        endif
        if Damage.index.prevArmorT != udg_DamageEventArmorT then
            call BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_ARMOR_TYPE, at)
        endif
        if Damage.index.prevDefenseT != udg_DamageEventDefenseT then
            call BlzSetUnitIntegerField(udg_DamageEventTarget, UNIT_IF_DEFENSE_TYPE, dt)
        endif
    endmethod
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
static if USE_EXTRA then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
    private static method onAOEEnd takes nothing returns nothing
        if udg_DamageEventAOE > 1 then
            call DamageTrigger.AOE.run()
        endif
        set udg_DamageEventAOE          = 0
        set udg_DamageEventLevel        = 0
        set udg_EnhancedDamageTarget    = null
        set udg_AOEDamageSource         = null
        call GroupClear(udg_DamageEventAOEGroup)
    endmethod
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
   
    private static method afterDamage takes nothing returns nothing
        if udg_DamageEventPrevAmt != 0.00 and udg_DamageEventDamageT != 0 then
            call DamageTrigger.AFTER.run()
            set udg_DamageEventDamageT  = 0
            set udg_DamageEventPrevAmt  = 0.00
        endif
    endmethod
    private method doPreEvents takes boolean natural returns boolean
static if USE_ARMOR_MOD then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        set this.armorType      = BlzGetUnitIntegerField(this.targetUnit, UNIT_IF_ARMOR_TYPE)
        set this.defenseType    = BlzGetUnitIntegerField(this.targetUnit, UNIT_IF_DEFENSE_TYPE)
        set this.prevArmorT     = this.armorType
        set this.prevDefenseT   = this.defenseType
        set this.armorPierced   = 0.00
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        set Damage.index        = this
        call DamageTrigger.setGUIFromStruct(true)
       
        call GroupAddUnit(proclusGlobal, udg_DamageEventSource)
        call GroupAddUnit(fischerMorrow, udg_DamageEventTarget)
        //! runtextmacro optional DAMAGE_EVENT_PRE_VARS_PLUGIN_01()
        //! runtextmacro optional DAMAGE_EVENT_PRE_VARS_PLUGIN_02()
        //! runtextmacro optional DAMAGE_EVENT_PRE_VARS_PLUGIN_03()
        //! runtextmacro optional DAMAGE_EVENT_PRE_VARS_PLUGIN_04()
        //! runtextmacro optional DAMAGE_EVENT_PRE_VARS_PLUGIN_05()
        if udg_DamageEventAmount != 0.00 then
            set udg_DamageEventOverride = udg_DamageEventDamageT == 0
            call DamageTrigger.MOD.run()
static if not USE_GUI then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            call DamageTrigger.setGUIFromStruct(false)
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            if natural then
                call BlzSetEventAttackType(this.attackType)
                call BlzSetEventDamageType(this.damageType)
                call BlzSetEventWeaponType(this.weaponType)
                call BlzSetEventDamage(udg_DamageEventAmount)
            endif
static if USE_ARMOR_MOD then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            call this.setArmor(false)
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            return false
        endif
        return true
    endmethod
    private static method unfreeze takes nothing returns nothing
        local Damage i = damageStack
        loop
            exitwhen i == 0
            set i                                    = i - 1
            set i.stackRef.recursiveTrig.trigFrozen  = false
            set i.stackRef.recursiveTrig.levelsDeep  = 0
        endloop                          
        call EnableTrigger(t1)
        call EnableTrigger(t2)
        set kicking                                 = false
        set damageStack                             = 0
        set prepped                                 = 0
        set dreaming                                = false
        set sleepLevel                              = 0
        call GroupClear(proclusGlobal)
        call GroupClear(fischerMorrow)
        //call BJDebugMsg("Cleared up the groups")
    endmethod
    static method finish takes nothing returns nothing
        local Damage i                                  = 0
        local integer exit                        
        if eventsRun then                        
            set eventsRun                               = false
            call afterDamage()
        endif
        if canKick and not kicking then
            if damageStack != 0 then
                set kicking                             = true
                loop
                    set sleepLevel                      = sleepLevel + 1
                    set exit                            = damageStack
                    loop
                        set prepped                     = i.stackRef
                        if UnitAlive(prepped.targetUnit) then //Added just in case dead units had issues.
                            call prepped.doPreEvents(false) //don't evaluate the pre-event
                            if prepped.damage > 0.00 then
                                call DisableTrigger(t1) //Force only the after armor event to run.
                                call EnableTrigger(t2)  //in case the user forgot to re-enable this
                                set totem               = true
                                call UnitDamageTarget(prepped.sourceUnit, prepped.targetUnit, prepped.damage, prepped.isAttack, prepped.isRanged, prepped.attackType, prepped.damageType, prepped.weaponType)
                            else
                                //No new events run at all in this case
                                if udg_DamageEventDamageT != 0 then
                                    call DamageTrigger.DAMAGE.run()
                                endif
                                if prepped.damage < 0.00 then
                                    //No need for BlzSetEventDamage here
                                    call SetWidgetLife(prepped.targetUnit, GetWidgetLife(prepped.targetUnit) - prepped.damage)
                                endif
static if USE_ARMOR_MOD then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
                                call prepped.setArmor(true)
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
                            endif
                            call afterDamage()
                        endif
                        set i = i + 1
                        exitwhen i == exit
                    endloop
                    exitwhen i == damageStack
                endloop
            endif
            call unfreeze()
        endif
    endmethod
    private static method failsafeClear takes nothing returns nothing
static if USE_ARMOR_MOD then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        call Damage.index.setArmor(true)
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        set canKick         = true
        set kicking         = false
        set totem           = false
        if udg_DamageEventDamageT != 0 then
            call DamageTrigger.DAMAGE.run()
            set eventsRun   = true
        endif
        call finish()
    endmethod
    static method operator enabled= takes boolean b returns nothing
        if b then
            if dreaming then
                call EnableTrigger(t3)
            else
                call EnableTrigger(t1)
                call EnableTrigger(t2)
            endif
        else
            if dreaming then
                call DisableTrigger(t3)
            else
                call DisableTrigger(t1)
                call DisableTrigger(t2)
            endif
        endif
    endmethod
    static method operator enabled takes nothing returns boolean
        return IsTriggerEnabled(t1)
    endmethod
   
    private static boolean arisen = false
   
    private static method getOutOfBed takes nothing returns nothing
        if totem then
            call failsafeClear() //WarCraft 3 didn't run the DAMAGED event despite running the DAMAGING event.
        else
            set canKick     = true
            set kicking     = false
            call finish()
        endif
static if USE_EXTRA then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        call onAOEEnd()
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        set arisen = true
    endmethod
   
    private static method wakeUp takes nothing returns nothing
        set dreaming = false
        set Damage.enabled = true
        call ForForce(bj_FORCE_PLAYER[0], function thistype.getOutOfBed) //Moved to a new thread in case of a thread crash
        if not arisen then
            //call BJDebugMsg("DamageEngine issue: thread crashed!")
            call unfreeze()
        else
            set arisen = false
        endif
        set Damage.count    = 0
        set Damage.index    = 0
        set alarmSet        = false
        //call BJDebugMsg("Timer wrapped up")
    endmethod
    private method addRecursive takes nothing returns nothing
        if this.damage != 0.00 then
            set this.recursiveTrig = DamageTrigger.eventIndex
            if not this.isCode then
                set this.isCode = true
                set this.userType = TYPE_CODE
            endif
            set inception = inception or DamageTrigger.eventIndex.inceptionTrig
            if kicking and IsUnitInGroup(this.sourceUnit, proclusGlobal) and IsUnitInGroup(this.targetUnit, fischerMorrow) then
                if not inception then
                    set DamageTrigger.eventIndex.trigFrozen = true
                elseif not DamageTrigger.eventIndex.trigFrozen then
                    set DamageTrigger.eventIndex.inceptionTrig = true
                    if DamageTrigger.eventIndex.levelsDeep < sleepLevel then
                        set DamageTrigger.eventIndex.levelsDeep = DamageTrigger.eventIndex.levelsDeep + 1
                        if DamageTrigger.eventIndex.levelsDeep >= LIMBO then
                            set DamageTrigger.eventIndex.trigFrozen = true
                        endif
                    endif
                endif
            endif
            set damageStack.stackRef = this
            set damageStack = damageStack + 1
            //call BJDebugMsg("damageStack: " + I2S(damageStack) + " levelsDeep: " + I2S(DamageTrigger.eventIndex.levelsDeep) + " sleepLevel: " + I2S(sleepLevel))
        endif
        set inception = false
    endmethod
    private static method clearNexts takes nothing returns nothing
        set udg_NextDamageIsAttack      = false
        set udg_NextDamageType          = 0
        set udg_NextDamageWeaponT       = 0
        set udg_NextDamageAbilitySource = 0
static if USE_MELEE_RANGE then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        set udg_NextDamageIsMelee       = false
        set udg_NextDamageIsRanged      = false
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
    endmethod
    static method create takes unit src, unit tgt, real amt, boolean a, attacktype at, damagetype dt, weapontype wt returns Damage
        local Damage d      = Damage.count + 1
        set Damage.count    = d
        set d.sourceUnit    = src
        set d.targetUnit    = tgt
        set d.damage        = amt
        set d.prevAmt       = amt
                     
        set d.attackType    = at
        set d.damageType    = dt
        set d.weaponType    = wt
                     
        set d.isAttack      = udg_NextDamageIsAttack or a
        set d.isSpell       = d.attackType == null and not d.isAttack
        return d
    endmethod
    private static method createFromEvent takes nothing returns Damage
        local Damage d                  = create(GetEventDamageSource(), GetTriggerUnit(), GetEventDamage(), BlzGetEventIsAttack(), BlzGetEventAttackType(), BlzGetEventDamageType(), BlzGetEventWeaponType())
        set d.isCode                    = udg_NextDamageType != 0 or udg_NextDamageIsAttack or udg_NextDamageIsRanged or udg_NextDamageIsMelee or udg_NextDamageAbilitySource != 0 or d.damageType == DAMAGE_TYPE_MIND or udg_NextDamageWeaponT != 0 or (d.damage != 0.00 and d.damageType == DAMAGE_TYPE_UNKNOWN)
 
        if d.isCode then
            if udg_NextDamageType != 0 then
                set d.userType          = udg_NextDamageType
            else
                set d.userType          = TYPE_CODE
            endif
static if USE_MELEE_RANGE then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            set d.isMelee               = udg_NextDamageIsMelee
            set d.isRanged              = udg_NextDamageIsRanged
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            set d.eFilter               = FILTER_CODE
            if udg_NextDamageWeaponT != 0 then
                set d.weaponType        = ConvertWeaponType(udg_NextDamageWeaponT)
                set udg_NextDamageWeaponT = 0
            endif
            set d.abilitySource         = udg_NextDamageAbilitySource
        else
            set d.userType              = 0
            set d.abilitySource         = 0
            if d.damageType == DAMAGE_TYPE_NORMAL and d.isAttack then
static if USE_MELEE_RANGE then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
                set d.isMelee           = IsUnitType(d.sourceUnit, UNIT_TYPE_MELEE_ATTACKER)
                set d.isRanged          = IsUnitType(d.sourceUnit, UNIT_TYPE_RANGED_ATTACKER)
                if d.isMelee and d.isRanged then
                    set d.isMelee       = d.weaponType != null  // Melee units play a sound when damaging
                    set d.isRanged      = not d.isMelee         // In the case where a unit is both ranged and melee, the ranged attack plays no sound.
                endif
                if d.isMelee then
                    set d.eFilter       = FILTER_MELEE
                elseif d.isRanged then
                    set d.eFilter       = FILTER_RANGED
                else
                    set d.eFilter       = FILTER_ATTACK
                endif
else
                set d.eFilter           = FILTER_ATTACK
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            else
                if d.isSpell then
                    set d.eFilter       = FILTER_SPELL
                else
                    set d.eFilter       = FILTER_OTHER
                endif
static if USE_MELEE_RANGE then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
                set d.isMelee           = false
                set d.isRanged          = false
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            endif
        endif
        call clearNexts()
        return d
    endmethod
    private static method onRecursion takes nothing returns boolean //New in 5.7
        local Damage d  = Damage.createFromEvent()
        call d.addRecursive()
        call BlzSetEventDamage(0.00)
        return false
    endmethod
    private static method onDamaging takes nothing returns boolean
        local Damage d              = Damage.createFromEvent()
        //call BJDebugMsg("Pre-damage event running for " + GetUnitName(GetTriggerUnit()))
        if alarmSet then
            if totem then //WarCraft 3 didn't run the DAMAGED event despite running the DAMAGING event.
                if d.damageType == DAMAGE_TYPE_SPIRIT_LINK or d.damageType == DAMAGE_TYPE_DEFENSIVE or d.damageType == DAMAGE_TYPE_PLANT then
                    set totem       = false
                    set lastInstance= Damage.index
                    set canKick     = false
                else
                    call failsafeClear() //Not an overlapping event - just wrap it up
                endif
            else
                call finish() //wrap up any previous damage index
            endif
           
static if USE_EXTRA then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            if d.sourceUnit != udg_AOEDamageSource then
                call onAOEEnd()
                set udg_AOEDamageSource = d.sourceUnit
            elseif d.targetUnit == udg_EnhancedDamageTarget then
                set udg_DamageEventLevel= udg_DamageEventLevel + 1
            elseif not IsUnitInGroup(d.targetUnit, udg_DamageEventAOEGroup) then
                set udg_DamageEventAOE  = udg_DamageEventAOE + 1
            endif
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        else
            call TimerStart(alarm, 0.00, false, function Damage.wakeUp)
            set alarmSet                = true
static if USE_EXTRA then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            set udg_AOEDamageSource     = d.sourceUnit
            set udg_EnhancedDamageTarget= d.targetUnit
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        endif
static if USE_EXTRA then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        call GroupAddUnit(udg_DamageEventAOEGroup, d.targetUnit)
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        if d.doPreEvents(true) then
            call DamageTrigger.ZERO.run()
            set canKick                 = true
            call finish()
        endif
        set totem                       = lastInstance == 0 or attacksImmune[udg_DamageEventAttackT] or damagesImmune[udg_DamageEventDamageT] or not IsUnitType(udg_DamageEventTarget, UNIT_TYPE_MAGIC_IMMUNE)
        return false
    endmethod
    private static method onDamaged takes nothing returns boolean
        local real r                    = GetEventDamage()
        local Damage d                  = Damage.index
        //call BJDebugMsg("Second damage event running for " + GetUnitName(GetTriggerUnit()))
        if prepped > 0 then
            set prepped                 = 0
        elseif dreaming or d.prevAmt == 0.00 then
            return false
        elseif totem then
            set totem                   = false
        else
            //This should only happen for stuff like Spirit Link or Thorns Aura/Carapace
            call afterDamage()
            set Damage.index            = lastInstance
            set lastInstance            = 0
            set d                       = Damage.index
            set canKick                 = true
            call DamageTrigger.setGUIFromStruct(true)
        endif
static if USE_ARMOR_MOD then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        call d.setArmor(true)
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
       
static if USE_SCALING then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        if udg_DamageEventAmount != 0.00 and r != 0.00 then
            set udg_DamageScalingWC3    = r / udg_DamageEventAmount
        elseif udg_DamageEventAmount > 0.00 then
            set udg_DamageScalingWC3    = 0.00
        else                      
            set udg_DamageScalingWC3    = 1.00
            if udg_DamageEventPrevAmt == 0.00 then
                set udg_DamageScalingUser = 0.00
            else
                set udg_DamageScalingUser = udg_DamageEventAmount/udg_DamageEventPrevAmt
            endif
        endif                    
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        set udg_DamageEventAmount       = r
        set d.damage                    = r
 
        //! runtextmacro optional DAMAGE_EVENT_VARS_PLUGIN_GDD()
        //! runtextmacro optional DAMAGE_EVENT_VARS_PLUGIN_PDD()
        //! runtextmacro optional DAMAGE_EVENT_VARS_PLUGIN_01()
        //! runtextmacro optional DAMAGE_EVENT_VARS_PLUGIN_02()
        //! runtextmacro optional DAMAGE_EVENT_VARS_PLUGIN_03()
        //! runtextmacro optional DAMAGE_EVENT_VARS_PLUGIN_04()
        //! runtextmacro optional DAMAGE_EVENT_VARS_PLUGIN_05()
 
        if udg_DamageEventAmount > 0.00 then
            call DamageTrigger.SHIELD.run()
static if not USE_GUI then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            set udg_DamageEventAmount = d.damage
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
static if USE_LETHAL then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            if hasLethal or udg_DamageEventType < 0 then
                set udg_LethalDamageHP = GetWidgetLife(udg_DamageEventTarget) - udg_DamageEventAmount
                if udg_LethalDamageHP <= DEATH_VAL then
                    if hasLethal then
                        call DamageTrigger.LETHAL.run()
           
                        set udg_DamageEventAmount = GetWidgetLife(udg_DamageEventTarget) - udg_LethalDamageHP
                        set d.damage = udg_DamageEventAmount
                    endif
                    if udg_DamageEventType < 0 and udg_LethalDamageHP <= DEATH_VAL then
                        call SetUnitExploded(udg_DamageEventTarget, true)
                    endif
                endif
            endif
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
static if USE_SCALING then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            if udg_DamageEventPrevAmt == 0.00 or udg_DamageScalingWC3 == 0.00 then
                set udg_DamageScalingUser = 0.00
            else
                set udg_DamageScalingUser = udg_DamageEventAmount/udg_DamageEventPrevAmt/udg_DamageScalingWC3
            endif
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
        endif
        if udg_DamageEventDamageT != 0 then
            call DamageTrigger.DAMAGE.run()
        endif
        call BlzSetEventDamage(udg_DamageEventAmount)
        set eventsRun                   = true
        if udg_DamageEventAmount == 0.00 then
            call finish()
        endif
        return false
    endmethod
    static method apply takes unit src, unit tgt, real amt, boolean a, boolean r, attacktype at, damagetype dt, weapontype wt returns Damage
        local Damage d
        if udg_NextDamageType == 0 then
           set udg_NextDamageType = TYPE_CODE
        endif
        if dreaming then
            set d               = create(src, tgt, amt, a, at, dt, wt)
            set d.isCode        = true
            set d.eFilter       = FILTER_CODE
                         
            set d.userType      = udg_NextDamageType
            set d.abilitySource = udg_NextDamageAbilitySource
static if USE_MELEE_RANGE then// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            if not d.isSpell then
                set d.isRanged = udg_NextDamageIsRanged or r
                set d.isMelee  = not d.isRanged
            endif
endif// \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ /
            call d.addRecursive()
        else
            call UnitDamageTarget(src, tgt, amt, a, r, at, dt, wt)
            set d = Damage.index
            call finish()
        endif
        call clearNexts()
        return d
    endmethod
    static method applyMagic takes unit src, unit tgt, real amt, damagetype dt returns Damage
        return apply(src, tgt, amt, false, false, null, dt, null)
    endmethod
    static method applyPhys takes unit src, unit tgt, real amt, boolean ranged, attacktype at, weapontype wt returns Damage
        return apply(src, tgt, amt, true, ranged, at, DAMAGE_TYPE_NORMAL, wt)
    endmethod
    //===========================================================================
    private static method onInit takes nothing returns nothing
        call TriggerRegisterAnyUnitEventBJ(t1, EVENT_PLAYER_UNIT_DAMAGING)
        call TriggerAddCondition(t1, Filter(function Damage.onDamaging))
 
        call TriggerRegisterAnyUnitEventBJ(t2, EVENT_PLAYER_UNIT_DAMAGED)
        call TriggerAddCondition(t2, Filter(function Damage.onDamaged))
 
        //For recursion
        call TriggerRegisterAnyUnitEventBJ(t3, EVENT_PLAYER_UNIT_DAMAGING)
        call TriggerAddCondition(t3, Filter(function Damage.onRecursion))
        call DisableTrigger(t3)
 
        //For preventing Thorns/Defensive glitch.
        //Data gathered from https://www.hiveworkshop.com/threads/repo-in-progress-mapping-damage-types-to-their-abilities.316271/
        set attacksImmune[0]  = false   //ATTACK_TYPE_NORMAL
        set attacksImmune[1]  = true    //ATTACK_TYPE_MELEE  
        set attacksImmune[2]  = true    //ATTACK_TYPE_PIERCE  
        set attacksImmune[3]  = true    //ATTACK_TYPE_SIEGE  
        set attacksImmune[4]  = false   //ATTACK_TYPE_MAGIC  
        set attacksImmune[5]  = true    //ATTACK_TYPE_CHAOS  
        set attacksImmune[6]  = true    //ATTACK_TYPE_HERO    
 
        set damagesImmune[0]  = true    //DAMAGE_TYPE_UNKNOWN      
        set damagesImmune[4]  = true    //DAMAGE_TYPE_NORMAL          
        set damagesImmune[5]  = true    //DAMAGE_TYPE_ENHANCED        
        set damagesImmune[8]  = false   //DAMAGE_TYPE_FIRE            
        set damagesImmune[9]  = false   //DAMAGE_TYPE_COLD              
        set damagesImmune[10] = false   //DAMAGE_TYPE_LIGHTNING        
        set damagesImmune[11] = true    //DAMAGE_TYPE_POISON          
        set damagesImmune[12] = true    //DAMAGE_TYPE_DISEASE          
        set damagesImmune[13] = false   //DAMAGE_TYPE_DIVINE            
        set damagesImmune[14] = false   //DAMAGE_TYPE_MAGIC            
        set damagesImmune[15] = false   //DAMAGE_TYPE_SONIC            
        set damagesImmune[16] = true    //DAMAGE_TYPE_ACID            
        set damagesImmune[17] = false   //DAMAGE_TYPE_FORCE            
        set damagesImmune[18] = false   //DAMAGE_TYPE_DEATH            
        set damagesImmune[19] = false   //DAMAGE_TYPE_MIND              
        set damagesImmune[20] = false   //DAMAGE_TYPE_PLANT            
        set damagesImmune[21] = false   //DAMAGE_TYPE_DEFENSIVE        
        set damagesImmune[22] = true    //DAMAGE_TYPE_DEMOLITION      
        set damagesImmune[23] = true    //DAMAGE_TYPE_SLOW_POISON      
        set damagesImmune[24] = false   //DAMAGE_TYPE_SPIRIT_LINK      
        set damagesImmune[25] = false   //DAMAGE_TYPE_SHADOW_STRIKE    
        set damagesImmune[26] = true    //DAMAGE_TYPE_UNIVERSAL
    endmethod
    //! runtextmacro optional DAMAGE_EVENT_STRUCT_PLUGIN_DMGPKG()
    //! runtextmacro optional DAMAGE_EVENT_STRUCT_PLUGIN_01()
    //! runtextmacro optional DAMAGE_EVENT_STRUCT_PLUGIN_02()
    //! runtextmacro optional DAMAGE_EVENT_STRUCT_PLUGIN_03()
    //! runtextmacro optional DAMAGE_EVENT_STRUCT_PLUGIN_04()
    //! runtextmacro optional DAMAGE_EVENT_STRUCT_PLUGIN_05()
endstruct
    public function DebugStr takes nothing returns nothing
        local integer i                      = 0
        loop
            set udg_CONVERTED_ATTACK_TYPE[i] = ConvertAttackType(i)
            exitwhen i == 6
            set i                            = i + 1
        endloop
        set i                                = 0
        loop
            set udg_CONVERTED_DAMAGE_TYPE[i] = ConvertDamageType(i)
            exitwhen i == 26
            set i                            = i + 1
        endloop
        set udg_AttackTypeDebugStr[0]        = "SPELLS"   //ATTACK_TYPE_NORMAL in JASS
        set udg_AttackTypeDebugStr[1]        = "NORMAL"   //ATTACK_TYPE_MELEE in JASS
        set udg_AttackTypeDebugStr[2]        = "PIERCE"
        set udg_AttackTypeDebugStr[3]        = "SIEGE"
        set udg_AttackTypeDebugStr[4]        = "MAGIC"
        set udg_AttackTypeDebugStr[5]        = "CHAOS"
        set udg_AttackTypeDebugStr[6]        = "HERO"
        set udg_DamageTypeDebugStr[0]        = "UNKNOWN"
        set udg_DamageTypeDebugStr[4]        = "NORMAL"
        set udg_DamageTypeDebugStr[5]        = "ENHANCED"
        set udg_DamageTypeDebugStr[8]        = "FIRE"
        set udg_DamageTypeDebugStr[9]        = "COLD"
        set udg_DamageTypeDebugStr[10]       = "LIGHTNING"
        set udg_DamageTypeDebugStr[11]       = "POISON"
        set udg_DamageTypeDebugStr[12]       = "DISEASE"
        set udg_DamageTypeDebugStr[13]       = "DIVINE"
        set udg_DamageTypeDebugStr[14]       = "MAGIC"
        set udg_DamageTypeDebugStr[15]       = "SONIC"
        set udg_DamageTypeDebugStr[16]       = "ACID"
        set udg_DamageTypeDebugStr[17]       = "FORCE"
        set udg_DamageTypeDebugStr[18]       = "DEATH"
        set udg_DamageTypeDebugStr[19]       = "MIND"
        set udg_DamageTypeDebugStr[20]       = "PLANT"
        set udg_DamageTypeDebugStr[21]       = "DEFENSIVE"
        set udg_DamageTypeDebugStr[22]       = "DEMOLITION"
        set udg_DamageTypeDebugStr[23]       = "SLOW_POISON"
        set udg_DamageTypeDebugStr[24]       = "SPIRIT_LINK"
        set udg_DamageTypeDebugStr[25]       = "SHADOW_STRIKE"
        set udg_DamageTypeDebugStr[26]       = "UNIVERSAL"
        set udg_WeaponTypeDebugStr[0]        = "NONE"    //WEAPON_TYPE_WHOKNOWS in JASS
        set udg_WeaponTypeDebugStr[1]        = "METAL_LIGHT_CHOP"
        set udg_WeaponTypeDebugStr[2]        = "METAL_MEDIUM_CHOP"
        set udg_WeaponTypeDebugStr[3]        = "METAL_HEAVY_CHOP"
        set udg_WeaponTypeDebugStr[4]        = "METAL_LIGHT_SLICE"
        set udg_WeaponTypeDebugStr[5]        = "METAL_MEDIUM_SLICE"
        set udg_WeaponTypeDebugStr[6]        = "METAL_HEAVY_SLICE"
        set udg_WeaponTypeDebugStr[7]        = "METAL_MEDIUM_BASH"
        set udg_WeaponTypeDebugStr[8]        = "METAL_HEAVY_BASH"
        set udg_WeaponTypeDebugStr[9]        = "METAL_MEDIUM_STAB"
        set udg_WeaponTypeDebugStr[10]       = "METAL_HEAVY_STAB"
        set udg_WeaponTypeDebugStr[11]       = "WOOD_LIGHT_SLICE"
        set udg_WeaponTypeDebugStr[12]       = "WOOD_MEDIUM_SLICE"
        set udg_WeaponTypeDebugStr[13]       = "WOOD_HEAVY_SLICE"
        set udg_WeaponTypeDebugStr[14]       = "WOOD_LIGHT_BASH"
        set udg_WeaponTypeDebugStr[15]       = "WOOD_MEDIUM_BASH"
        set udg_WeaponTypeDebugStr[16]       = "WOOD_HEAVY_BASH"
        set udg_WeaponTypeDebugStr[17]       = "WOOD_LIGHT_STAB"
        set udg_WeaponTypeDebugStr[18]       = "WOOD_MEDIUM_STAB"
        set udg_WeaponTypeDebugStr[19]       = "CLAW_LIGHT_SLICE"
        set udg_WeaponTypeDebugStr[20]       = "CLAW_MEDIUM_SLICE"
        set udg_WeaponTypeDebugStr[21]       = "CLAW_HEAVY_SLICE"
        set udg_WeaponTypeDebugStr[22]       = "AXE_MEDIUM_CHOP"
        set udg_WeaponTypeDebugStr[23]       = "ROCK_HEAVY_BASH"
        set udg_DefenseTypeDebugStr[0]       = "LIGHT"
        set udg_DefenseTypeDebugStr[1]       = "MEDIUM"
        set udg_DefenseTypeDebugStr[2]       = "HEAVY"
        set udg_DefenseTypeDebugStr[3]       = "FORTIFIED"
        set udg_DefenseTypeDebugStr[4]       = "NORMAL"   //Typically deals flat damage to all armor types
        set udg_DefenseTypeDebugStr[5]       = "HERO"
        set udg_DefenseTypeDebugStr[6]       = "DIVINE"
        set udg_DefenseTypeDebugStr[7]       = "UNARMORED"
        set udg_ArmorTypeDebugStr[0]         = "NONE"      //ARMOR_TYPE_WHOKNOWS in JASS, added in 1.31
        set udg_ArmorTypeDebugStr[1]         = "FLESH"
        set udg_ArmorTypeDebugStr[2]         = "METAL"
        set udg_ArmorTypeDebugStr[3]         = "WOOD"
        set udg_ArmorTypeDebugStr[4]         = "ETHEREAL"
        set udg_ArmorTypeDebugStr[5]         = "STONE"
    endfunction
    //===========================================================================
    //
    // Setup of automatic events from GUI and custom ones from JASS alike
    //
    //===========================================================================
    public function RegisterFromHook takes trigger whichTrig, string var, limitop op, real value returns nothing
        call DamageTrigger.registerVerbose(whichTrig, var, value, true, GetHandleId(op))
    endfunction
    hook TriggerRegisterVariableEvent RegisterFromHook
    function TriggerRegisterDamageEngineEx takes trigger whichTrig, string eventName, real value, integer f returns DamageTrigger
        return DamageTrigger.registerVerbose(whichTrig, DamageTrigger.getVerboseStr(eventName), value, false, f)
    endfunction
    function TriggerRegisterDamageEngine takes trigger whichTrig, string eventName, real value returns DamageTrigger
        return DamageTrigger.registerTrigger(whichTrig, eventName, value)
    endfunction
    function RegisterDamageEngineEx takes code c, string eventName, real value, integer f returns DamageTrigger
        return TriggerRegisterDamageEngineEx(DamageTrigger[c], eventName, value, f)
    endfunction
    //Similar to TriggerRegisterDamageEvent, although takes code instead of trigger as the first argument.
    function RegisterDamageEngine takes code c, string eventName, real value returns DamageTrigger
        return RegisterDamageEngineEx(c, eventName, value, FILTER_OTHER)
    endfunction
    //For GUI to tap into more powerful vJass event filtering:
    //! textmacro DAMAGE_TRIGGER_CONFIG
        if not DamageTrigger.eventIndex.configured then
    //! endtextmacro
    //! textmacro DAMAGE_TRIGGER_CONFIG_END
            call DamageTrigger.eventIndex.configure()
            if not DamageTrigger.eventIndex.checkConfiguration() then
                return
            endif
        endif
    //! endtextmacro
endlibrary