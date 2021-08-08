globals
    group GL_GR = CreateGroup()
    boolexpr RuneOfChaos_b
    integer GLOB_LVL_abil = 0
endglobals


function CastRuneOfChaos takes nothing returns boolean

    if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(GetFilterUnit())) and GetWidgetLife(GetFilterUnit()) > 0.405 then
            
            call CastRandomSpell1(GLOB_RUNE_U,GetRandomAbility1(), GLOB_LVL_abil,GetFilterUnit(),0,0) 
    endif
    return false
endfunction

function RuneOfChaos takes nothing returns boolean
   local unit u = GLOB_RUNE_U
   local real power = GLOB_RUNE_POWER 
   local integer lvl = 10 + R2I((power-1)*10)
   local integer lp = 0
   local integer i = 0
    if lvl > 30 then
        set lp = (lp + lvl - 30)/3
        set lvl = 30
    endif
    
    loop
        set GLOB_LVL_abil = lvl
        call GroupEnumUnitsInRange(GL_GR,GetUnitX(u),GetUnitY(u),400+75*power,RuneOfChaos_b )
        set i = i + 1
        exitwhen i >= lp
    endloop

   return false
endfunction