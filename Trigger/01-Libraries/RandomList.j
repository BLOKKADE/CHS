library RandomList initializer init

    struct RandomList extends array
        Table Entries
        real totalWeight = 0

        function Entry integer id, real weight returns nothing
            set totalWeight = totalWeight + weight
            set Entries[0]
        endfunction

        static method create takes nothing returns nothing 
            set Entries = Table.create()
        endmethod

    endstruct
endlibrary
