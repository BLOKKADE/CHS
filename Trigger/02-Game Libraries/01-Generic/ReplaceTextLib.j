library ReplaceTextLib
    function ReplaceText takes string stringToReplace, string value, string inputString returns string
        local integer replaceLength = StringLength(stringToReplace)
        local integer inputLength = StringLength(inputString)
        local integer i = 0
        
        loop
            exitwhen i > inputLength
            if SubString(inputString, i, i + replaceLength) == stringToReplace then
                return SubString(inputString, 0, i) + value + SubString(inputString, i + replaceLength, inputLength)
            endif
            set i = i + 1
        endloop
        
        return inputString
    endfunction
endlibrary
