library Table5BC

    //! textmacro TABLE_ARRAY_BC
    struct TableArray extends array
    
        static method operator [] takes integer width returns TableArray
            return Table.createFork(width)
        endmethod
    
        method operator size takes nothing returns integer
            return Table(this).measureFork()
        endmethod
    
        method operator [] takes integer key returns Table
            return Table(this).switch(key)
        endmethod
    
        method destroy takes nothing returns nothing
            call Table(this).destroy()
        endmethod
    
        method flush takes nothing returns nothing
            call Table(this).destroy()
        endmethod
    
    endstruct
    //! endtextmacro
    
    //! textmacro TableXD takes NAME, MAP_TO_WHAT, CREATE
    struct $NAME$ extends array
        method operator [] takes integer key returns $MAP_TO_WHAT$
            return Table(this).link(key)
        endmethod
        method remove takes integer key returns nothing
            call Table(this).remove(key)
        endmethod
        method has takes integer key returns boolean
            return Table(this).has(key)
        endmethod
        method destroy takes nothing returns nothing
            call Table(this).destroy()
        endmethod
        static method create takes nothing returns $NAME$
            return Table.$CREATE$
        endmethod
    endstruct
    //! endtextmacro
    
endlibrary