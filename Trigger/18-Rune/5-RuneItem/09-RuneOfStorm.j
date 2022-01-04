library StormRune requires RandomShit
    globals
        boolexpr RuneOfStorm_b
    endglobals


    function CastRuneOfStorm takes nothing returns boolean

        if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(GetFilterUnit())) then
                
            call SetUnitX(GetFilterUnit(),GetUnitX(GLOB_RUNE_U)+ GetRandomReal(- 50,50))
            call SetUnitY(GetFilterUnit(),GetUnitY(GLOB_RUNE_U)+ GetRandomReal(- 50,50))  
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveMissile.mdl", GetFilterUnit(), "chest"))  
            set udg_NextDamageAbilitySource = 'I08I'
            call Damage.applySpell(GLOB_RUNE_U, GetFilterUnit(), 1000 * GLOB_RUNE_POWER, DAMAGE_TYPE_MAGIC)
        endif
        return false
    endfunction

    function RuneOfStorm takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        call GroupEnumUnitsInRange(GL_GR,GetUnitX(u),GetUnitY(u),300 + 100 * power,RuneOfStorm_b )


        set u = null
        return false
    endfunction
endlibrary