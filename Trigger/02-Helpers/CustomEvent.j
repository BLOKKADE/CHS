library CustomEvent
    globals
        integer CUSTOM_EVENT_LEARN_ABILITY = 1
        integer CUSTOM_EVENT_UNLEARN_ABILITY = 2
        integer CUSTOM_EVENT_FIX_START_ROUND = 3
        integer CUSTOM_EVENT_START_ROUND = 4
        integer CUSTOM_EVENT_COMPLETE_LEVEL = 5

        private hashtable htE = InitHashtable()
    endglobals

    struct customEvent 
        unit EventUnit = null
        integer EventSpellId = 0
        boolean LearnedAbilityIsNew = false
    endstruct
    


    function DispachEvent takes integer s, customEvent e returns nothing
        local trigger tr = null
        local integer i = 0
        set tr = LoadTriggerHandle(htE, s, 0)

        if tr == null then
            return
        endif

        call SaveTriggerHandle(htE, s, 1, tr)
        call SaveInteger(htE, GetHandleId(tr), 1, e)
        call ConditionalTriggerExecute(tr)
        call e.destroy()
        set tr = null
    endfunction

    function GetTriggerCustomEvent takes trigger t returns customEvent
        return LoadInteger(htE, GetHandleId(t), 1)
    endfunction


    function EventSubscriber takes integer e, code fun returns nothing
        local trigger tr = LoadTriggerHandle(htE, e, 0)
        if tr == null then
            set tr = CreateTrigger()
            call SaveTriggerHandle(htE, e, 0, tr)
        endif
        call TriggerAddCondition(tr, Condition(fun))
    endfunction


endlibrary

