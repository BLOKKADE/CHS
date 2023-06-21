library SaveFile requires FileIO, SaveCore
    
    private keyword SaveFileInit
    
    struct SaveFile extends array
        static constant string InvalidPath = "Unknown"
        static constant integer MIN = 1
        static constant integer MAX = 10
        
        private File file
	
        static method operator Folder takes nothing returns string
            return MapName
        endmethod

        static method getPath takes player p, integer slot returns string
            if (slot == 0) then
                return .Folder + "\\SaveSlot_" + GetPlayerName(p) + ".pld"
            elseif (slot == 1) then
                return .Folder + "\\SaveSlot_" + GetPlayerName(p) + "_Debug.pld"
            endif
            return "Unknown slot: " + I2S(slot)
        endmethod
        
        static method create takes player p, string title, integer slot, string data returns thistype
            if (GetLocalPlayer() == p) then
                call FileIO_Write(.getPath(p, slot), title + "\n" + "n" + data)
            endif
            return slot
        endmethod
        
        static method clear takes player p, integer slot returns thistype
            if (GetLocalPlayer() == p) then
                call FileIO_Write(.getPath(p, slot), "")
            endif
            return slot
        endmethod
        
        static method exists takes player p, integer slot returns boolean // async
            return StringLength(FileIO_Read(.getPath(p, slot))) > 1
        endmethod
        
        method getLines takes player p, integer line, boolean includePrevious returns string // async
            local string contents   = FileIO_Read(.getPath(p, this))
            local integer len       = StringLength(contents)
            local string char       = null
            local string buffer     = ""
            local integer curLine   = 0
            local integer i         = 0
            
            loop
                exitwhen i > len
                set char = SubString(contents, i, i + 1)
                if (char == "\n") then
                    set curLine = curLine + 1
                    if (curLine > line) then
                        return buffer
                    endif
                    if (not includePrevious) then
                        set buffer = ""
                    endif
                else
                    set buffer = buffer + char
                endif
                set i = i + 1
            endloop
            if (curLine == line) then
                return buffer
            endif
            return null
        endmethod
        
        method getLine takes player p, integer line returns string // async
            return .getLines(p, line, false)
        endmethod
        
        method getTitle takes player p returns string // async
            return .getLines(p, 0, false)
        endmethod
        
        method getData takes player p returns string // async
            return .getLines(p, 1, false)
        endmethod
        
        implement SaveFileInit
    endstruct
    
    private module SaveFileInit
        private static method onInit takes nothing returns nothing
            //set thistype.Folder = MapName
        endmethod
    endmodule
    
endlibrary
