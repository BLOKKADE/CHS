library CustomGameEvent initializer init requires ListT
    globals
        //all events used by the library

        //when a round starts for all players
        integer EVENT_GAME_ROUND_START          =   0

        // when all players have finished a round
        integer EVENT_GAME_ROUND_END            =   1

        //when a player learns a new ability
        integer EVENT_LEARN_ABILITY             =   2

        //when a player levels an ability
        integer EVENT_LEVEL_ABILITY             =   3

        //when a player unlearns an ability
        integer EVENT_UNLEARN_ABILITY           =   4

        //??? resets murloc stats (can be removed once thats refactored)
        integer EVENT_FIX_START_ROUND           =   5

        integer EVENT_PLAYER_ROUND_TELEPORT     =   6

        //When a player starts a round (urn)
        integer EVENT_PLAYER_ROUND_START        =   7

        //when a player finished a round
        integer EVENT_PLAYER_ROUND_COMPLETE     =   8

        // when a fun br round ends
        integer EVENT_FUN_BR_ROUND_END          =   9

        // when a fun br round ends
        integer EVENT_FUN_BR_ROUND_START        =   10

        string array EventName

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

        //all arguments
        static method createAll takes player p, integer abilId, integer roundNumber, boolean pvp returns thistype
			local thistype this = thistype.allocate()
			
			set this.hero = PlayerHeroes[GetPlayerId(p)]
            set this.abilId = abilId
            set this.roundNumber = roundNumber
            set this.isPvp = pvp
            set this.p = p

			return this
		endmethod

        //set pvp automatically
        static method create takes player p, integer abilId, integer roundNumber returns thistype
			local thistype this = thistype.allocate()
			
			set this.hero = PlayerHeroes[GetPlayerId(p)]
            set this.abilId = abilId
            set this.roundNumber = roundNumber
            set this.isPvp = IsUnitInGroup(this.hero, DuelingHeroes) or BrStarted
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

        //call BJDebugMsg("ev: " + EventName[ev] + ", p: " + GetPlayerNameColour(eventInfo.p))

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

        set EventName[0] = "EVENT_GAME_ROUND_START"
        set EventName[1] = "EVENT_GAME_ROUND_END"
        set EventName[2] = "EVENT_LEARN_ABILITY"
        set EventName[3] = "EVENT_LEVEL_ABILITY"
        set EventName[4] = "EVENT_UNLEARN_ABILITY"
        set EventName[5] = "EVENT_FIX_START_ROUND"
        set EventName[6] = "EVENT_PLAYER_ROUND_TELEPORT"
        set EventName[7] = "EVENT_PLAYER_ROUND_START"
        set EventName[8] = "EVENT_PLAYER_ROUND_COMPLETE"
    endfunction
endlibrary
