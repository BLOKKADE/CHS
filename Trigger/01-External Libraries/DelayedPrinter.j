
library DelayedPrinter uses StaticQueue
	struct DelayedPrinter
		implement StaticQueue
		
		private string value
		private static constant real INTERVAL = 0.2
		private static constant integer RUN_LENGTH = 1
		
		private static method doTick takes nothing returns nothing
			local integer i = 0
			local player lp = GetLocalPlayer()
			loop
				exitwhen RUN_LENGTH == i  // maximum number of lines to show per "tick"
				exitwhen first == sentinel // we are out of messages
				call DisplayTimedTextToPlayer(lp, 0, 0, 20, first.value)
				call pop()
				set i = i + 1
			endloop
		endmethod
		
		/** 
		 * print text for all players
		 */
		public static method print takes string s returns nothing
			set enqueue().value = s
			
		endmethod
		
		/** 
		 * print text for only player p
		 */
		public static method printPlayer takes player p, string s returns nothing
			if GetLocalPlayer() == p then
				set enqueue().value = s
			endif
		endmethod
	
		private static method onInit takes nothing returns nothing
			local trigger t = CreateTrigger()
			call TriggerRegisterTimerEvent(t, INTERVAL, true)
			call TriggerAddAction(t, function DelayedPrinter.doTick)
			set t = null
		endmethod
	endstruct
endlibrary
