globals
    boolexpr RuneOfStorm_b
endglobals


function CastRuneOfStorm takes nothing returns boolean

    if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(GetFilterUnit())) then
            
        call SetUnitX(GetFilterUnit(),GetUnitX(GLOB_RUNE_U)+GetRandomReal(-50,50))
        call SetUnitY(GetFilterUnit(),GetUnitY(GLOB_RUNE_U)+GetRandomReal(-50,50))  
        call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveMissile.mdl", GetFilterUnit(), "chest"))  
        call UnitDamageTarget(GLOB_RUNE_U,GetFilterUnit(),1000*GLOB_RUNE_POWER,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endif
    return false
endfunction

function RuneOfStorm takes nothing returns boolean
   local unit u = GLOB_RUNE_U
   local real power = GLOB_RUNE_POWER 

    call GroupEnumUnitsInRange(GL_GR,GetUnitX(u),GetUnitY(u),300+100*power,RuneOfStorm_b )



   return false
endfunction