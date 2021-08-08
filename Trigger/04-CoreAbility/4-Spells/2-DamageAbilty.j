struct DamageAbility
    integer id = 0
    integer number = 0 
    
    static method create takes integer id, integer number returns DamageAbility
        local DamageAbility D = DamageAbility.allocate()
        set D.id = id
        set D.number = number 
        return D
    endmethod
endstruct