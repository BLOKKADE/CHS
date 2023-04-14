library Generic
    function B2S takes boolean b returns string
        if b then
            return "true"
        else
            return "false"
        endif
    endfunction
endlibrary
