library Math
    //some commonly used math functions
    function GetCenterPointX takes real x1, real x2 returns real
        return x1 - (x1 - x2) / 2
    endfunction
    
    function GetCenterPointY takes real y1, real y2 returns real
        return y1 - (y1 - y2) / 2
    endfunction
        
    function CalculateDistance takes real x1, real x2, real y1, real y2 returns real
        local real x = x2 - x1
        local real y = y2 - y1
        return SquareRoot(x * x + y * y)
    endfunction
    
    function DistanceBetweenUnits takes unit u1, unit u2 returns real
        local real x = GetUnitX(u2) - GetUnitX(u1)
        local real y = GetUnitY(u2) - GetUnitY(u1)
        return SquareRoot(x * x + y * y)
    endfunction
    
    function GetAngleToTarget takes unit source, unit target returns real
        return Atan2(GetUnitY(target)- GetUnitY(source),GetUnitX(target)- GetUnitX(source))
    endfunction
        
    function GetAngleToTargetPoint takes real x1, real x2, real y1, real y2 returns real
        return Atan2(y2 - y1,x2 - x1)
    endfunction
    
    function CalcX takes real casterx, real angle, real distance returns real
        return casterx + distance * Cos((angle)* bj_DEGTORAD)
    endfunction
    
    function CalcY takes real castery, real angle, real distance returns real
        return castery + distance * Sin((angle)* bj_DEGTORAD)
    endfunction
endlibrary