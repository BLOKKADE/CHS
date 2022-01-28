library Savecode requires BigNum

    private constant function uppercolor takes nothing returns string
        return "|cffcfcfcf"
    endfunction

    private constant function lowercolor takes nothing returns string
        return "|cff00ff00"
    endfunction

    private constant function numcolor takes nothing returns string
        return "|cfffffb00"
    endfunction

    private function player_charset takes nothing returns string
        return "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    endfunction

    private function player_charsetlen takes nothing returns integer
        return StringLength(player_charset())
    endfunction

    private function charset takes nothing returns string
        return "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    endfunction

    private function charsetlen takes nothing returns integer
        return StringLength(charset())
    endfunction

    private function BASE takes nothing returns integer
        return charsetlen()
    endfunction

    private constant function HASHN takes nothing returns integer
        return 5000 //1./HASHN() is the probability of a random code being valid
    endfunction

    private constant function MAXINT takes nothing returns integer
        return 2147483647
    endfunction

    private function player_chartoi takes string c returns integer
        local integer i = 0
        local string cs = player_charset()
        local integer len = player_charsetlen()
        loop
            exitwhen i>=len or c == SubString(cs,i,i+1)
            set i = i + 1
        endloop
        return i
    endfunction

    private function chartoi takes string c returns integer
        local integer i = 0
        local string cs = charset()
        local integer len = charsetlen()
        loop
            exitwhen i>=len or c == SubString(cs,i,i+1)
            set i = i + 1
        endloop
        return i
    endfunction

    private function itochar takes integer i returns string
        return SubString(charset(),i,i+1)
    endfunction

    //You probably want to use a different char set for this
    //Also, use a hash that doesn't suck so much
    private function scommhash takes string s returns integer
        local integer array count
        local integer i = 0
        local integer len = StringLength(s)
        local integer x
        set s = StringCase(s,true)
        loop
            exitwhen i >= len
            set x = player_chartoi(SubString(s,i,i+1))
            set count[x] = count[x] + 1
            set i = i + 1
        endloop
        set i = 0
        set len = player_charsetlen()
        set x = 0
        loop
            exitwhen i>= len
            set x = count[i]*count[i]*i+count[i]*x+x+199
    //      call BJDebugMsg(I2S(x)+" "+I2S(count[i]))
    //      call TriggerSleepAction(0.)
            set i = i + 1
        endloop
        if x < 0 then
            set x = -x
        endif
        return x
    endfunction

    private function modb takes integer x returns integer
        if x >= BASE() then
            return x - BASE()
        elseif x < 0 then
            return x + BASE()
        else
            return x
        endif
    endfunction

    struct Savecode
        real digits     //logarithmic approximation
        BigNum bignum
        
        static method create takes nothing returns Savecode
            local Savecode sc = Savecode.allocate()
            set sc.digits = 0.
            set sc.bignum = BigNum.create(BASE())
            return sc
        endmethod
        
        method onDestroy takes nothing returns nothing
            call .bignum.destroy()
        endmethod

        method Encode takes integer val, integer max returns nothing
            set .digits = .digits + log(max+1,BASE())
            call .bignum.MulSmall(max+1)
            call .bignum.AddSmall(val)
        endmethod
        
        method Decode takes integer max returns integer
            return .bignum.DivSmall(max+1)
        endmethod
        
        method IsEmpty takes nothing returns boolean
            return .bignum.IsZero()
        endmethod
        
        method Length takes nothing returns real
            return .digits
        endmethod
        
        method Clean takes nothing returns nothing
            call .bignum.Clean()
        endmethod
        
            //These functions get too intimate with BigNum_l
        method Pad takes nothing returns nothing
            local BigNum_l cur = .bignum.list
            local BigNum_l prev
            local integer maxlen = R2I(1.0 + .Length())
            
            loop
                exitwhen cur == 0
                set prev = cur
                set cur = cur.next
                set maxlen = maxlen - 1
            endloop
            loop
                exitwhen maxlen <= 0
                set prev.next = BigNum_l.create()
                set prev = prev.next
                set maxlen = maxlen - 1
            endloop
        endmethod
        
        method ToString takes nothing returns string
            local BigNum_l cur = .bignum.list
            local string s = ""
            loop
                exitwhen cur == 0
                set s = itochar(cur.leaf) + s
                set cur = cur.next
            endloop
            return s
        endmethod
        
        method FromString takes string s returns nothing
            local integer i = StringLength(s)-1
            local BigNum_l cur = BigNum_l.create()
            set .bignum.list = cur
            loop
                set cur.leaf = chartoi(SubString(s,i,i+1))      
                exitwhen i <= 0
                set cur.next = BigNum_l.create()
                set cur = cur.next
                set i = i - 1
            endloop
        endmethod
        
        method Hash takes nothing returns integer
            local integer hash = 0
            local integer x
            local BigNum_l cur = .bignum.list
            loop
                exitwhen cur == 0
                set x = cur.leaf
                set hash = ModuloInteger(hash+79*hash/(x+1) + 293*x/(1+hash - (hash/BASE())*BASE()) + 479,HASHN())
                set cur = cur.next
            endloop
            return hash
        endmethod

        //this is not cryptographic which is fine for this application
        //sign = 1 is forward
        //sign = -1 is backward
        method Obfuscate takes integer key, integer sign returns nothing
            local integer seed = GetRandomInt(0,MAXINT())
            local integer advance
            local integer x
            local BigNum_l cur = .bignum.list
        
        
            if sign == -1 then
                call SetRandomSeed(.bignum.LastDigit())
                set cur.leaf = modb(cur.leaf + sign*GetRandomInt(0,BASE()-1))
                set x = cur.leaf
            endif
            
            call SetRandomSeed(key)
            loop
                exitwhen cur == 0
                
                if sign == -1 then
                    set advance = cur.leaf
                endif
                set cur.leaf = modb(cur.leaf + sign*GetRandomInt(0,BASE()-1))
                if sign == 1 then
                    set advance = cur.leaf
                endif
                set advance = advance + GetRandomInt(0,BASE()-1)
                call SetRandomSeed(advance)
                
                set x = cur.leaf
                set cur = cur.next
            endloop
            
            if sign == 1 then
                call SetRandomSeed(x)
                set .bignum.list.leaf = modb(.bignum.list.leaf + sign*GetRandomInt(0,BASE()-1))
            endif
            
            call SetRandomSeed(seed)
        endmethod
        
        method Dump takes nothing returns nothing
            local BigNum_l cur = .bignum.list
            local string s = ""
            set s = "max: "+R2S(.digits)
            
            loop
                exitwhen cur == 0
                set s = I2S(cur.leaf)+" "+s
                set cur = cur.next
            endloop
            call BJDebugMsg(s)
        endmethod
        
        method Save takes player p, integer loadtype returns string
            local integer key = scommhash(GetPlayerName(p))+loadtype*73
            local string s
            local integer hash
            call .Clean()
            set hash = .Hash()
            call .Encode(hash,HASHN())
            call .Clean()
            
            /////////////////////// Save code information.  Comment out next two lines in implementation
            //call BJDebugMsg("Expected length: " +I2S(R2I(1.0+.Length())))
            //call BJDebugMsg("Room left in last char: "+R2S(1.-ModuloReal((.Length()),1)))
            ///////////////////////
            
            call .Pad()
            call .Obfuscate(key,1)
            return .ToString()
        endmethod
        
        method Load takes player p, string s, integer loadtype returns boolean
            local integer ikey = scommhash(GetPlayerName(p))+loadtype*73
            local integer inputhash
            
            call .FromString(s)
            call .Obfuscate(ikey,-1)
            set inputhash = .Decode(HASHN())
            
            call .Clean()
            
            return inputhash == .Hash()
        endmethod
    endstruct
    private function isupper takes string c returns boolean
        return c == StringCase(c,true)
    endfunction

    private function ischar takes string c returns boolean
        return S2I(c) == 0 and c!= "0"
    endfunction

    private function chartype takes string c returns integer
        if(ischar(c)) then
            if isupper(c) then
                return 0
            else
                return 1
            endif
        else
            return 2
        endif
    endfunction

    private function testchar takes string c returns nothing
        if(ischar(c)) then
            if isupper(c) then
                call BJDebugMsg(c+" isupper")
            else
                call BJDebugMsg(c+" islower")
            endif
        else
            call BJDebugMsg(c+ " isnumber")
        endif
    endfunction

    public function colorize takes string s returns string
        local string out = ""
        local integer i = 0
        local integer len = StringLength(s)
        local integer ctype
        local string c
        loop
            exitwhen i >= len
            set c = SubString(s,i,i+1)
            set ctype = chartype(c)
            if ctype == 0 then
                set out = out + uppercolor()+c+"|r"
            elseif ctype == 1 then
                set out = out + lowercolor()+c+"|r"
            else
                set out = out + numcolor()+c+"|r"
            endif
            set i = i + 1
        endloop
        return out
    endfunction

    private function prop_Savecode takes nothing returns boolean
        local string s
        local Savecode loadcode

    //--- Data you want to save ---
        local integer medal1 = 10
        local integer medal2 = 3
        local integer medalmax = 13
        local integer XP = 1337
        local integer XPmax = 1000000

        local Savecode savecode = Savecode.create()

        call SetPlayerName(Player(0),"yomp")
        call SetPlayerName(Player(1),"fruitcup")

        call savecode.Encode(medal1,medalmax)
        call savecode.Encode(medal2,medalmax)
        call savecode.Encode(XP,XPmax)

    //--- Savecode_save generates the savecode for a specific player ---
        set s = savecode.Save(Player(0),1)
        call savecode.destroy()
    //  call BJDebugMsg("Savecode: " + Savecode_colorize(s))

    //--- User writes down code, inputs again ---

        set loadcode = Savecode.create()
        if loadcode.Load(Player(0),s,1) then
    //      call BJDebugMsg("load ok")
        else
            call BJDebugMsg("load failed")   
            return false
        endif

    //Must decode in reverse order of encodes

    //               load object : max value that data can take
        if XP != loadcode.Decode(XPmax) then
            return false
        elseif medal2 != loadcode.Decode(medalmax) then
            return false
        elseif medal1 != loadcode.Decode(medalmax) then
            return false
        endif
        call loadcode.destroy()
        return true
    endfunction

endlibrary
