library FloatingTextLib

    function ShowFloatingText takes unit u, integer id returns nothing
        local texttag tt = CreateTextTag()
        local string objName = GetObjectName(id)
        local string msg = objName + "+15s CD"

        call SetTextTagText(tt, msg, 0.023) // Font size
        call SetTextTagPosUnit(tt, u, 0.0)
        call SetTextTagColor(tt, 255, 0, 0, 255) // Red color
        call SetTextTagVelocity(tt, 0.0, 0.04)
        call SetTextTagFadepoint(tt, 1.5)
        call SetTextTagLifespan(tt, 2.0)
        call SetTextTagPermanent(tt, false)
    endfunction

endlibrary
