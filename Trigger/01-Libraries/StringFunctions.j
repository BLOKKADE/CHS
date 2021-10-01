library StringFunctions requires MathRound
    //String functions v1.04
    //made by MaskedPoptart
    //--------------------IMPORTANT FUNCTIONS------------------------
     
        function FindIndexFrom takes string mainString, string stringToFind, integer startingIndex returns integer
            local integer msLength = StringLength(mainString)
            local integer sfLength = StringLength(stringToFind)
            local integer i = startingIndex
            if(sfLength > msLength or i < 0)then
                return -1
            endif
            loop
                exitwhen i > msLength - sfLength
                if(SubString(mainString, i, i+sfLength) == stringToFind)then
                    return i
                endif
                set i = i + 1
            endloop
            return -1
        endfunction
    
    ////////////////////////////////////////////////////
    
        function CountNewLines takes string input returns integer
            local integer index = 0
            local integer prevIndex = 0
            local integer count = 1
    
            loop
                set index = FindIndexFrom(input, "|n", index +1)
                if index - prevIndex > 48 then
                    set count = count + MathRound_floor(((index-prevIndex) - 10) / 48)
                endif
                exitwhen index == -1
                set count = count + 1
                set prevIndex = index
            endloop
            
            call BJDebugMsg("lines: " + I2S(count))
            return count
        endfunction
    endlibrary