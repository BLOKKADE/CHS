
library Command initializer init uses DelayedPrinter, StringHashEx
    /*************************************************************
    
    -dosometing
    -dosomething else with params
    
    example creation of command:
    call Command.create(CommandHandler.printHelpMessage).name("help").handles("help").help("help <command name>", "Prints the help text for the given command")
    call Command.create(CommandHandler.printCommandList).name("list").handles("list").help("list", "Prints the list of all commands you have access to")
    
    example command handler:
    function printHelpMessage takes Args args returns nothing
        if Command.fromName(args[1]) == 0 then
            return
        endif
		if args.length == 2 then
			call DelayedPrinter.printPlayer(GetTriggerPlayer(), Command.fromName(args[1]).dusage)
			call DelayedPrinter.printPlayer(GetTriggerPlayer(), Command.fromName(args[1]).dhelp)
		else
			call DelayedPrinter.printPlayer(GetTriggerPlayer(), Command.fromName("help").dusage)
			call DelayedPrinter.printPlayer(GetTriggerPlayer(), Command.fromName("help").dhelp)
		endif
	endfunction
    
    *************************************************************/
    
    struct Args
    	private string str
    	private integer array begins[20]
    	private integer array ends[20]
    	private integer nargs = 0
    	
    	/**
    	 *  tokenise a command string, return an Args instance with at most N indicies
    	 *  @param commandString: the string to tokenise
    	 *  @param maxArgs: the maximum number of parameters you expect to take,
    	 *      allows easy handling of the case where the last argument has spaces in it
    	 */
    	public static method parseN takes string commandString, integer maxArgs returns thistype
    		local thistype this = thistype.create()
    		local integer commandLength = StringLength(commandString)
    		local integer tail = 0
    		local integer head = 0
    		local boolean quoted = false
    		set this.str = commandString
    		// split the command string breaking on spaces
    		loop
    			exitwhen head >= commandLength

    			if SubString(commandString, head, head + 1) == "\"" then
    				set quoted = true
    				loop
						set head = head + 1
    					exitwhen head >= commandLength
    					exitwhen SubString(commandString, head, head + 1) == "\""
    				endloop
    				set head = head + 1
    			endif
    			
    			if SubString(commandString, head, head + 1) == " " or (head == commandLength)  or (this.nargs==maxArgs) then
    				if (this.nargs==maxArgs) then
    					set head = commandLength
    				endif
    				set this.begins[nargs] = tail
    				set this.ends[nargs] = head
    				
    				// if the string is in quotes
    				if quoted then
    					set this.begins[nargs] = tail + 1
    					set this.ends[nargs] = head - 1
    				endif
    				
    				set this.nargs = this.nargs + 1
    				set tail = head + 1
    			endif
    			set quoted = false
    			set head = head + 1
    		endloop
			set this.begins[nargs] = tail
			set this.ends[nargs] = head
			set this.nargs = this.nargs + 1
			set tail = head
    		return this
    	endmethod
    	
    	public static method parse takes string commandString returns thistype
    		return thistype.parseN(commandString, 9999999)
    	endmethod
    	
    	public method operator[] takes integer i returns string
    		if i < this.nargs then
    			//call BJDebugMsg("arg index: " + I2S(i) + ": " + SubString(this.str, this.begins[i], this.ends[i]))
    			return SubString(this.str, this.begins[i], this.ends[i])
    		endif
    		return ""
    	endmethod
    	
    	public method operator length takes nothing returns integer
    		return this.nargs
    	endmethod
    	
    endstruct
    
    
    //function interface CommandHandler takes string commandName, StringStack args returns nothing
    function interface CommandHandler takes Args args returns nothing
    
	function printHelpMessage takes Args args returns nothing
        if Command.fromName(args[1]) == 0 then
        return
        endif
		// this needs to be a method so it has access to private state
		if args.length == 2 then
			call DelayedPrinter.printPlayer(GetTriggerPlayer(), Command.fromName(args[1]).dusage)
			call DelayedPrinter.printPlayer(GetTriggerPlayer(), Command.fromName(args[1]).dhelp)
		else
			call DelayedPrinter.printPlayer(GetTriggerPlayer(), Command.fromName("help").dusage)
			call DelayedPrinter.printPlayer(GetTriggerPlayer(), Command.fromName("help").dhelp)
		endif
	endfunction
	
	function printCommandList takes Args args returns nothing
		local integer i = 1
		call DelayedPrinter.printPlayer(GetTriggerPlayer(), "The list of commands:")
		
		loop
			exitwhen i > Command.commandCount
			if Command(i).triggerPlayerHasPrivileges() then
				call DelayedPrinter.printPlayer(GetTriggerPlayer(), Command.COMMAND_PREFIX + Command(i).dname)
			endif
			set i = i + 1
		endloop
	endfunction
	
    struct Command
    	public static constant string COMMAND_PREFIX = "-"
        private static Table commandMapping
        public static integer commandCount = 0

		public string dname
		public CommandHandler dhandler
		public string dhelp
		public string dusage
        
        // used as a hit for Args.parseN(str,int)
        private integer dnmaxargs = 9999999
        
        public static method create takes CommandHandler ch returns thistype
        	local thistype this = thistype.allocate()
        	set this.dhandler = ch
        	set commandCount = commandCount + 1
        	return this
        endmethod
        
        // specify the names that this commancd corresponds to, can have multiple names/aliases
        public method handles takes string commandName returns thistype
			set commandName = StringCase(commandName, false)
        	set commandMapping[StringHashEx(commandName)] = this
        	return this
        endmethod
		
        // sets the canonical name
        public method name takes string commandName returns thistype
			set commandName = StringCase(commandName, false)
        	set this.dname = commandName
        	return this
        endmethod
        
        /**
         *  tell the command the maximum number of arguments it will ever receive
         *  and it can handle the whitespace in the last argument better
         */
        public method nargs takes integer nargs returns thistype
        	set this.dnmaxargs = nargs
        	return this
        endmethod
        
        // usage = 1 line string, eg "help <command>", command prefix will be automatically prepended
        // verbose = long help text, can be anything and multiline
        public method help takes string usage, string verbose returns thistype
        	set this.dusage=usage
        	set this.dhelp=verbose
        	return this
        endmethod
        
        public static method fromName takes string commandName returns thistype
        	return thistype(commandMapping[StringHashEx(commandName)])
        endmethod
        
        public method triggerPlayerHasPrivileges takes nothing returns boolean
        	// This can be expanded on to only allow certain commands to execute based off variables 
            return true
        endmethod
        
        public static method doCommand takes string commandName, string eventString returns nothing
        	local Command comm = Command.fromName(commandName)
        	local Args args = Args.parseN(eventString, comm.dnmaxargs)
        	if comm.triggerPlayerHasPrivileges() then
            	call CommandHandler(comm.dhandler).evaluate(args)
            	call args.destroy()
            else
            	call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,20,"You lack permissions to use that command")
            endif
        endmethod

        private static method onInit takes nothing returns nothing
            set commandMapping = Table.create()
            
            // Create a help command if we really want this
            call Command.create(CommandHandler.printHelpMessage).name("help").handles("help").help("help <command name>", "Prints the help text for the given command")
            call Command.create(CommandHandler.printCommandList).name("list").handles("list").help("list", "Prints the list of all commands you have access to")
        endmethod
        
        
        // ---- COMPATIBILITY WITH OLD API ----
		public static method registerCommand takes string commandName, CommandHandler func returns nothing
			call Command.create(func).name(commandName).handles(commandName)
        endmethod
        public static method registerHelp takes string commandName, string helpstring returns nothing
            call thistype.fromName(commandName).help(commandName, helpstring)
        endmethod
    endstruct
    
    private function actions takes nothing returns nothing
        local string eventString = GetEventPlayerChatString()
        local player triggerPlayer = GetTriggerPlayer()
        local Args args
        local string commandName
        
		set eventString = StringCase(eventString, false)
        set eventString = SubString(eventString, 1, StringLength(eventString))
        set args = Args.parseN(eventString,2)
        set commandName = args[0]
        call Command.doCommand(commandName, eventString)
        call args.destroy()
    endfunction
    
    private function init takes nothing returns nothing
        local integer i = 0
        local trigger t = CreateTrigger()
        loop
            call TriggerRegisterPlayerChatEvent(t, Player(i), Command.COMMAND_PREFIX, false)
            set i = i + 1
            exitwhen i > 9 // Just needs to be registesred for all players
        endloop
        call TriggerAddAction(t, function actions)
    endfunction
    
endlibrary
