library CustomGameEvent initializer init requires ListT
    globals
        //all events used by the library
        integer EVENT_GAME_ROUND_START  =    0
        integer EVENT_GAME_ROUND_END    =    1
        integer EVENT_LEARN_ABILITY     =    2
        integer EVENT_LEVEL_ABILITY     =    3
        integer EVENT_UNLEARN_ABILITY   =    4
        integer EVENT_FIX_START_ROUND   =    5
        integer EVENT_START_ROUND       =    6
        integer EVENT_COMPLETE_LEVEL    =    7

        //stores all functions registered to events
        Table Events
    endglobals

    //arguments used for all events so far, not all are needed but oh well
    struct EventInfo
        unit hero
        player p
        integer abilId
        integer roundNumber
        boolean isPvp

        static method create takes player p, integer abilId, integer roundNumber returns thistype
			local thistype this = thistype.allocate()
			
			set this.hero = PlayerHeroes[GetPlayerId(p) + 1]
            set this.abilId = abilId
            set this.roundNumber = roundNumber
            set this.isPvp = ModuloInteger(this.roundNumber, 5) == 0
            set this.p = p

			return this
		endmethod

        private method onDestroy takes nothing returns nothing
            set this.hero = null
            set this.p = null
        endmethod
    endstruct

    function interface CustomEvent takes EventInfo eventInfo returns nothing

    function GetRegisteredCodeList takes integer ev returns IntegerList
        return Events[ev]
    endfunction

    function GetCustomEvent takes integer node returns CustomEvent
        return node
    endfunction

    //retreives all registered functions for an event and runs them with eventInfo as argument
    public function FireEvent takes integer ev, EventInfo eventInfo returns nothing
        local IntegerList registeredCode = GetRegisteredCodeList(ev)
        local IntegerListItem node = registeredCode.first

        if registeredCode != 0 then
            loop
                call GetCustomEvent(node.data).evaluate(eventInfo)
                set node = node.next
                exitwhen node == 0
            endloop
        endif

        call eventInfo.destroy()
    endfunction

    //registers a function for an event in an integerlist
    public function RegisterEventCode takes integer ev, CustomEvent func returns nothing
        local IntegerList registeredCode = Events[ev]

        if registeredCode == 0 then
            set registeredCode = IntegerList.create()
        endif

        call registeredCode.push(func)

        set Events[ev] = registeredCode
    endfunction

    private function init takes nothing returns nothing
        set Events = Table.create()
    endfunction
endlibrary
