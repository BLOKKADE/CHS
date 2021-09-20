library MathRound

    public function floor takes real r returns integer
        local integer i = R2I(r)
    
        if r == i then
            return i
        endif
    
        if r > 0 then
            return i
        else // if r < 0 then
            return i - 1
        endif
    endfunction
    
    public function ceil takes real r returns integer
        local integer i = R2I(r)
    
        if r == i then
            return i
        endif
    
        if r > 0 then
            return i + 1
        else // if r < 0 then
            return i
        endif
    endfunction
    
    public function round takes real r returns integer
        if r > 0 then
            return R2I(r + 0.5)
        else // if r < 0 then
            return R2I(r - 0.5)
        endif
    endfunction
    
    public function nearest_floor takes real r, real n returns real
        return floor(r / n) * n
    endfunction
    
    public function nearest_ceil takes real r, real n returns real
        return ceil(r / n) * n
    endfunction
    
    public function nearest takes real r, real n returns real
        return round(r / n) * n
    endfunction
    
    public function round_places takes real r, real places returns real
        local real ten_pow_places = Pow(10, places)
        return round(r * ten_pow_places) / ten_pow_places
    endfunction
    
    endlibrary