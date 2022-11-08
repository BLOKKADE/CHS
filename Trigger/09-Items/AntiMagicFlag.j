library AntiMagicFlag requires RemoveBuffDelay
    function ActivateAntiMagicFlag takes unit source returns nothing
        call RemoveBuffsDelayed(source, 0, 0.2)
    endfunction
endlibrary