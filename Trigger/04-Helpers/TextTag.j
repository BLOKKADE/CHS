library TextTag
    globals
        constant real TEXT_SIZE = 0.024
        constant real TEXT_VEL = 0.09
        constant real TEXT_LIFE = 1
        constant real TEXT_FADE = 0.6
    endglobals
    
    function CreateTextTagTimer takes string text, real height, real x, real y, real z, real time returns nothing
        local texttag floatingText = CreateTextTag()

        call SetTextTagText(floatingText,text,height * TEXT_SIZE)
        call SetTextTagPos(floatingText,x,y,z)
        call SetTextTagColor(floatingText,255,255,120,200)
        
        call SetTextTagVelocity(floatingText,0.01, TEXT_VEL)
        call SetTextTagFadepoint(floatingText, time - (time * 0.1))
        call SetTextTagLifespan(floatingText, time)
        call SetTextTagPermanent(floatingText,false)
        
        set floatingText = null
    endfunction

    function CreateTextTagTimerColor takes string text, real height, real x, real y, real z, real time, integer r, integer g, integer b returns nothing
        local texttag floatingText = CreateTextTag()

        call SetTextTagText(floatingText,text,height * TEXT_SIZE)
        call SetTextTagPos(floatingText,x,y,z)
        call SetTextTagColor(floatingText,r,g,b,200)
        
        call SetTextTagVelocity(floatingText,0.01, TEXT_VEL)
        call SetTextTagFadepoint(floatingText, time - (time * 0.1))
        call SetTextTagLifespan(floatingText, time)
        call SetTextTagPermanent(floatingText,false)

        set floatingText = null
    endfunction
endlibrary
