library BigNum

    //prefer algebraic approach because of real subtraction issues
    function log takes real y, real base returns real
        local real x
        local real factor = 1.0
        local real logy = 0.0
        local real sign = 1.0
        if(y < 0.) then
            return 0.0
        endif
        if(y < 1.) then
            set y = 1.0/y
            set sign = -1.0
        endif
        //Chop out powers of the base
        loop
            exitwhen y < 1.0001    //decrease this ( bounded below by 1) to improve precision
            if(y > base) then
                set y = y / base
                set logy = logy + factor
            else
                set base = SquareRoot(base)     //If you use just one base a lot, precompute its squareroots
                set factor = factor / 2.
            endif
        endloop
        return sign*logy
    endfunction
    
    struct BigNum_l
        integer leaf
        BigNum_l next
        debug static integer nalloc = 0
        
        static method create takes nothing returns BigNum_l
            local BigNum_l bl = BigNum_l.allocate()
            set bl.next = 0
            set bl.leaf = 0
            debug set BigNum_l.nalloc = BigNum_l.nalloc + 1
            return bl
        endmethod
        method onDestroy takes nothing returns nothing
            debug set BigNum_l.nalloc = BigNum_l.nalloc - 1
        endmethod
        
        //true:  want destroy
        method Clean takes nothing returns boolean
            if .next == 0 and .leaf == 0 then
                return true
            elseif .next != 0 and .next.Clean() then
                call .next.destroy()
                set .next = 0
                return .leaf == 0
            else
                return false
            endif
        endmethod
        
        method DivSmall takes integer base, integer denom returns integer
            local integer quotient
            local integer remainder = 0
            local integer num
            
            if .next != 0 then
                set remainder = .next.DivSmall(base,denom)
            endif
            
            set num = .leaf + remainder*base
            set quotient = num/denom
            set remainder = num - quotient*denom
            set .leaf = quotient
            return remainder
        endmethod
    endstruct
    
    struct BigNum
        BigNum_l list
        integer base
        
        static method create takes integer base returns BigNum
            local BigNum b = BigNum.allocate()
            set b.list = 0
            set b.base = base
            return b
        endmethod
    
        method onDestroy takes nothing returns nothing
            local BigNum_l cur = .list
            local BigNum_l next
            loop
                exitwhen cur == 0
                set next = cur.next
                call cur.destroy()
                set cur = next
            endloop
        endmethod
        
        method IsZero takes nothing returns boolean
            local BigNum_l cur = .list
            loop
                exitwhen cur == 0
                if cur.leaf != 0 then
                    return false
                endif
                set cur = cur.next
            endloop
            return true
        endmethod
        
        method Dump takes nothing returns nothing
            local BigNum_l cur = .list
            local string s = ""
            loop
                exitwhen cur == 0
                set s = I2S(cur.leaf)+" "+s
                set cur = cur.next
            endloop
            call BJDebugMsg(s)
        endmethod
        
        method Clean takes nothing returns nothing
            local BigNum_l cur = .list
            call cur.Clean()
        endmethod
        
        //fails if bignum is null
        //BASE() + carry must be less than MAXINT()
        method AddSmall takes integer carry returns nothing
            local BigNum_l next
            local BigNum_l cur = .list
            local integer sum
            
            if cur == 0 then
                set cur = BigNum_l.create()
                set .list = cur
            endif
            
            loop
                exitwhen carry == 0
                set sum = cur.leaf + carry
                set carry = sum / .base
                set sum = sum - carry*.base
                set cur.leaf = sum
                
                if cur.next == 0 then
                    set cur.next = BigNum_l.create()
                endif
                set cur = cur.next
            endloop
        endmethod
        
        //x*BASE() must be less than MAXINT()
        method MulSmall takes integer x returns nothing
            local BigNum_l cur = .list
            local integer product
            local integer remainder
            local integer carry = 0
            loop
                exitwhen cur == 0 and carry == 0
                set product = x * cur.leaf + carry
                set carry = product/.base
                set remainder = product - carry*.base
                set cur.leaf = remainder
                if cur.next == 0 and carry != 0 then
                    set cur.next = BigNum_l.create()
                endif
                set cur = cur.next
            endloop
        endmethod
        
        //Returns remainder
        method DivSmall takes integer denom returns integer
            return .list.DivSmall(.base,denom)
        endmethod
        
        method LastDigit takes nothing returns integer
            local BigNum_l cur = .list
            local BigNum_l next
            loop
                set next = cur.next
                exitwhen next == 0
                set cur = next
            endloop
            return cur.leaf
        endmethod
    endstruct
    
    private function prop_Allocator1 takes nothing returns boolean
        local BigNum b1
        local BigNum b2
        set b1 = BigNum.create(37)
        call b1.destroy()
        set b2 = BigNum.create(37)
        call b2.destroy()
        return b1 == b2
    endfunction
    
    private function prop_Allocator2 takes nothing returns boolean
        local BigNum b1
        local boolean b = false
        set b1 = BigNum.create(37)
        call b1.AddSmall(17)
        call b1.MulSmall(19)
        debug if BigNum_l.nalloc < 1 then
        debug     return false
        debug endif
        call b1.destroy()
        debug set b = BigNum_l.nalloc == 0
        return b
    endfunction
    
    private function prop_Arith takes nothing returns boolean
        local BigNum b1
        set b1 = BigNum.create(37)
        call b1.AddSmall(73)
        call b1.MulSmall(39)
        call b1.AddSmall(17)
        //n = 2864
        if b1.DivSmall(100) != 64 then
            return false
        elseif b1.DivSmall(7) != 0 then
            return false
        elseif b1.IsZero() then
            return false
        elseif b1.DivSmall(3) != 1 then
            return false
        elseif b1.DivSmall(3) != 1 then
            return false
        elseif not b1.IsZero() then
            return false
        endif
        return true
    endfunction
    
endlibrary
    