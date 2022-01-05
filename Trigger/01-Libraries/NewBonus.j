library NewBonus
    /* ----------------------- NewBonus v2.0 by Chopinski ----------------------- */
    //! novjass
        Since ObjectMerger is broken and we still have no means to edit
        bonus values (green values) i decided to create a light weight
        Bonus library that works in the same way that the original Bonus Mod
        by Earth Fury did. NewBonus requires patch 1.30+.
    
        How it works?
        By using the new Object API recently introduced to warcraft, we can now
        modify an ability field, so when giving an unit a bonus, we add a specific
        ability to that unit, if it do not have it already, and change that ability
        bonus value to the desired value. Retrieving the amount is also trivial, by
        just reading that field value.
    
        How to Import?
        Importing bonus mod is really simple. Just copy the 9 abilities with the
        prefix "NewBonus" from the Object Editor into your map and match their new raw
        code to the bonus types in the global block below. Then create a trigger called
        NewBonus, convert it to custom text and paste this code there. You done!
    
        API:
        function GetUnitBonus takes unit u, integer bonus_type returns integer
           	-> Returns the specified bonus amount for the unit
           	-> Example: set amount = GetUnitBonus(GetTriggerUnit(), BONUS_AGILITY)

        function SetUnitBonus takes unit u, integer bonus_type, integer amount returns integer
           	-> Set the specified bonus type to amount for the unit
           	-> Example: call SetUnitBonus(GetTriggerUnit(), BONUS_DAMAGE, 100)
 
        function RemoveUnitBonus takes unit u, integer bonus_type returns nothing
           	-> Removes the Specified bonus type from unit
           	-> Example: call RemoveUnitBonus(GetTriggerUnit(), BONUS_AGILITY)
 
        function AddUnitBonus takes unit u, integer bonus_type, integer amount returns integer
           	-> Add the specified amount for the specified bonus tyte for unit
           	-> Example: call AddUnitBonus(GetTriggerUnit(), BONUS_DAMAGE, 100)

        function GetUnitBonusReal takes unit u, integer bonus_type returns real
        	-> Returns the specified bonus amount for the unit
        	-> Example: set amount = GetUnitBonusReal(GetTriggerUnit(), BONUS_HEALTH_REGEN)

    	function SetUnitBonusReal takes unit u, integer bonus_type, real amount returns nothing
        	-> Set the specified bonus type to amount for the unit
        	-> Example: call SetUnitBonusReal(GetTriggerUnit(), BONUS_ATTACK_SPEED, 0.15)

    	function RemoveUnitBonusReal takes unit u, real bonus_type returns nothing
        	-> Removes the Specified bonus type from unit
        	-> Example: call RemoveUnitBonusReal(GetTriggerUnit(), BONUS_MANA_REGEN)

    	function AddUnitBonusReal takes unit u, integer bonus_type, real amount returns real
        	-> Add the specified amount for the specified bonus tyte for unit
        	-> Example: call AddUnitBonusReal(GetTriggerUnit(), BONUS_LIFE_STEAL, 0.33)
    
        Added in version 1.5:
            Upper and Lower limit to max bonus amount set to 2147483647 and -2147483648
            to avoid over/under flowing the integer fields. AddUnitBonus() 
            now returns the amount of bonus that was actually setted. In case of no over/under flow, 
            it returns the amount passed, in case of over/under flow it returns the amount that 
            was allowed to be setted. It is still up to the user to call the functions without
            passing integers that already over/under flown.
        
        Added in version 1.7
            - Fixed a bug when Adding Health/Mana bonus not keeping the unit Health/Mana Percentage
            - Added the funcitons: They manipuilate real bonuses values correctly.
                - GetUnitBonusReal() 
                - SetUnitBonusReal() 
                - RemoveUnitBonusReal() 
                - AddUnitBonusReal()
            - Refactored the LinkBonusToItem() to use the On Drop event instead of a periodic timer to check the link
            - Included an Expanded version of NewBonus and NewBonusUtils that take advangtage of the Damage Inteface System and Cooldown Reduction System
            - Renamed 4 bonus types for better readability.
            - Removed the "Ex" from the end of the API functions
    
        Credits to Earth Fury for the original Bonus idea
    //! endnovjass
    /* ----------------------------------- END ---------------------------------- */
       
    globals
        //The bonus types
        constant integer BONUS_DAMAGE                  = 11
        constant integer BONUS_ARMOR                   = 12
        constant integer BONUS_AGILITY                 = 13
        constant integer BONUS_STRENGTH                = 14
        constant integer BONUS_INTELLIGENCE            = 15
        constant integer BONUS_HEALTH                  = 16
        constant integer BONUS_MANA                    = 17
        constant integer BONUS_HEALTH_REGEN            = 18
        constant integer BONUS_MANA_REGEN              = 19
        constant integer BONUS_ATTACK_SPEED            = 20
    
        //The abilities codes for each bonus
        //When pasting the abilities over to your map
        //their raw code should match the bonus here
        private constant integer DAMAGE_ABILITY           = 'A0A8'
        private constant integer ARMOR_ABILITY            = 'A00L'
        private constant integer STATS_ABILITY            = 'A0B4'
        private constant integer HEALTH_ABILITY           = 'A00N'
        private constant integer MANA_ABILITY             = 'A00S'
        private constant integer HEALTHREGEN_ABILITY      = 'A01C'
        private constant integer MANAREGEN_ABILITY        = 'A01G'
        private constant integer ATTACKSPEED_ABILITY      = 'A0A5'
    
        //The abilities fields that are modified. For the sake of readability
        private constant abilityintegerlevelfield DAMAGE_FIELD           = ABILITY_ILF_ATTACK_BONUS
        private constant abilityintegerlevelfield ARMOR_FIELD            = ABILITY_ILF_DEFENSE_BONUS_IDEF
        private constant abilityintegerlevelfield AGILITY_FIELD          = ABILITY_ILF_AGILITY_BONUS
        private constant abilityintegerlevelfield STRENGTH_FIELD         = ABILITY_ILF_STRENGTH_BONUS_ISTR
        private constant abilityintegerlevelfield INTELLIGENCE_FIELD     = ABILITY_ILF_INTELLIGENCE_BONUS
        private constant abilityintegerlevelfield HEALTH_FIELD           = ABILITY_ILF_MAX_LIFE_GAINED
        private constant abilityintegerlevelfield MANA_FIELD             = ABILITY_ILF_MAX_MANA_GAINED
        private constant abilityreallevelfield    HEALTHREGEN_FIELD      = ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED
        private constant abilityreallevelfield    MANAREGEN_FIELD        = ABILITY_RLF_AMOUNT_REGENERATED
        private constant abilityreallevelfield    ATTACKSPEED_FIELD      = ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1
    endglobals
    
    struct NewBonus
        //SetUnitAbilityBonusI() and SetUnitAbilityBonusR are necessary to manage abilities that have integer fields and real fields
        //but the return is normalized to reals
        static method SetUnitAbilityBonusI takes unit u, integer abilCode, abilityintegerlevelfield field, integer amount returns integer
            if GetUnitAbilityLevel(u, abilCode) == 0 then
                call UnitAddAbility(u, abilCode)
                call UnitMakeAbilityPermanent(u, true, abilCode)
            endif
        
            //Increasing and Decreasing is necessary since the abilities do not get updated just by changing
            //it's fields values. In the future, if Blizzard decides to patch it, it could be removed.
            if BlzSetAbilityIntegerLevelField(BlzGetUnitAbility(u, abilCode), field, 0, amount) then
                call IncUnitAbilityLevel(u, abilCode)
                call DecUnitAbilityLevel(u, abilCode)
            endif
        
            return BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(u, abilCode), field, 0)
        endmethod

        static method SetUnitAbilityBonusR takes unit u, integer abilCode, abilityreallevelfield field, real amount returns real
            if GetUnitAbilityLevel(u, abilCode) == 0 then
                call UnitAddAbility(u, abilCode)
                call UnitMakeAbilityPermanent(u, true, abilCode)
            endif
        
            if BlzSetAbilityRealLevelField(BlzGetUnitAbility(u, abilCode), field, 0, amount) then
                call IncUnitAbilityLevel(u, abilCode)
                call DecUnitAbilityLevel(u, abilCode)
            endif
        
            return BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilCode), field, 0)
        endmethod

        static method GetUnitBonus takes unit u, integer bonus_type returns integer
            if bonus_type == BONUS_DAMAGE then
                return BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(u, DAMAGE_ABILITY), DAMAGE_FIELD, 0)
            elseif bonus_type == BONUS_ARMOR then
                return BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(u, ARMOR_ABILITY), ARMOR_FIELD, 0)
            elseif bonus_type == BONUS_HEALTH then
                return BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(u, HEALTH_ABILITY), HEALTH_FIELD, 0)
            elseif bonus_type == BONUS_MANA then
                return BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(u, MANA_ABILITY), MANA_FIELD, 0)
            elseif bonus_type == BONUS_AGILITY then
                return BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(u, STATS_ABILITY), AGILITY_FIELD, 0)
            elseif bonus_type == BONUS_STRENGTH then
                return BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(u, STATS_ABILITY), STRENGTH_FIELD, 0)
            elseif bonus_type == BONUS_INTELLIGENCE then
                return BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(u, STATS_ABILITY), INTELLIGENCE_FIELD, 0)
            else
                call DisplayTimedTextToPlayer(Player(0), 0, 0, 10, "Invalid Bonus Type")
            endif
            
            return -1
        endmethod

        static method SetUnitBonus takes unit u, integer bonus_type, integer amount returns integer
            local real p

            if bonus_type == BONUS_DAMAGE then
                return SetUnitAbilityBonusI(u, DAMAGE_ABILITY, DAMAGE_FIELD, amount)
            elseif bonus_type == BONUS_ARMOR then
                return SetUnitAbilityBonusI(u, ARMOR_ABILITY, ARMOR_FIELD, amount)
            elseif bonus_type == BONUS_HEALTH then
                set p = GetUnitLifePercent(u)
                call BlzSetUnitMaxHP(u, (BlzGetUnitMaxHP(u) + amount - GetUnitBonus(u, bonus_type)))
                call SetUnitLifePercentBJ(u, p)
                return SetUnitAbilityBonusI(u, HEALTH_ABILITY, HEALTH_FIELD, amount)
            elseif bonus_type == BONUS_MANA then
                set p = GetUnitManaPercent(u)
                call BlzSetUnitMaxMana(u, (BlzGetUnitMaxMana(u) + amount - GetUnitBonus(u, bonus_type)))
                call SetUnitManaPercentBJ(u, p)
                return SetUnitAbilityBonusI(u, MANA_ABILITY, MANA_FIELD, amount)
            elseif bonus_type == BONUS_AGILITY then
                return SetUnitAbilityBonusI(u, STATS_ABILITY, AGILITY_FIELD, amount)
            elseif bonus_type == BONUS_STRENGTH then
                return SetUnitAbilityBonusI(u, STATS_ABILITY, STRENGTH_FIELD, amount)
            elseif bonus_type == BONUS_INTELLIGENCE then
                return SetUnitAbilityBonusI(u, STATS_ABILITY, INTELLIGENCE_FIELD, amount)
            else
                call DisplayTimedTextToPlayer(Player(0), 0, 0, 10, "Invalid Bonus Type")
            endif

            return -1
        endmethod

        static method AddUnitBonus takes unit u, integer bonus_type, integer amount returns integer
            local integer current_amount = GetUnitBonus(u, bonus_type)

            // Added in version 1.5 to avoid overflow/underflow of the field value
            if amount > 0 and current_amount > 2147483647 - amount then //Overflow
                set amount = 2147483647 - current_amount
            elseif amount < 0 and current_amount < -2147483648 - amount then //Underflow
                set amount = -2147483648 - current_amount
            endif

            call SetUnitBonus(u, bonus_type, (current_amount + amount))

            return amount
        endmethod

        // Funtions that handle the real bonus types

        static method GetUnitBonusR takes unit u, integer bonus_type returns real
            if bonus_type == BONUS_HEALTH_REGEN then
                return BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, HEALTHREGEN_ABILITY), HEALTHREGEN_FIELD, 0)
            elseif bonus_type == BONUS_MANA_REGEN then
                return BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, MANAREGEN_ABILITY), MANAREGEN_FIELD, 0)
            elseif bonus_type == BONUS_ATTACK_SPEED then
                return BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, ATTACKSPEED_ABILITY), ATTACKSPEED_FIELD, 0)
            else
                call DisplayTimedTextToPlayer(Player(0), 0, 0, 10, "Invalid Bonus Type")
            endif
            
            return -1.0
        endmethod

        static method SetUnitBonusR takes unit u, integer bonus_type, real amount returns nothing
            if bonus_type == BONUS_HEALTH_REGEN then
                call SetUnitAbilityBonusR(u, HEALTHREGEN_ABILITY, HEALTHREGEN_FIELD, amount)
            elseif bonus_type == BONUS_MANA_REGEN then
                call SetUnitAbilityBonusR(u, MANAREGEN_ABILITY, MANAREGEN_FIELD, amount)
            elseif bonus_type == BONUS_ATTACK_SPEED then
                call SetUnitAbilityBonusR(u, ATTACKSPEED_ABILITY, ATTACKSPEED_FIELD, amount)
            else
                call DisplayTimedTextToPlayer(Player(0), 0, 0, 10, "Invalid Bonus Type")
            endif
        endmethod

        static method AddUnitBonusR takes unit u, integer bonus_type, real amount returns nothing
            if bonus_type == BONUS_HEALTH_REGEN then
                call SetUnitBonusR(u, bonus_type, GetUnitBonusR(u, bonus_type) + amount)
            elseif bonus_type == BONUS_MANA_REGEN then
                call SetUnitBonusR(u, bonus_type, GetUnitBonusR(u, bonus_type) + amount)
            elseif bonus_type == BONUS_ATTACK_SPEED then
                call SetUnitBonusR(u, bonus_type, GetUnitBonusR(u, bonus_type) + amount)
            else
                call DisplayTimedTextToPlayer(Player(0), 0, 0, 10, "Invalid Bonus Type")
            endif
        endmethod
    endstruct
    
    /* -------------------------------------------------------------------------- */
    /*                               JASS Public API                              */
    /* -------------------------------------------------------------------------- */
    
    function GetUnitBonus takes unit u, integer bonus_type returns integer
        return NewBonus.GetUnitBonus(u, bonus_type)
    endfunction

    function SetUnitBonus takes unit u, integer bonus_type, integer amount returns integer
        return NewBonus.SetUnitBonus(u, bonus_type, amount)
    endfunction
    
    function RemoveUnitBonus takes unit u, integer bonus_type returns nothing
        call NewBonus.SetUnitBonus(u, bonus_type, 0)
    endfunction
    
    function AddUnitBonus takes unit u, integer bonus_type, integer amount returns integer
        return NewBonus.AddUnitBonus(u, bonus_type, amount)
    endfunction

    // functions for manipulating the real bonus types

    function GetUnitBonusReal takes unit u, integer bonus_type returns real
        return NewBonus.GetUnitBonusR(u, bonus_type)
    endfunction

    function SetUnitBonusReal takes unit u, integer bonus_type, real amount returns nothing
        call NewBonus.SetUnitBonusR(u, bonus_type, amount)
    endfunction
    
    function RemoveUnitBonusReal takes unit u, integer bonus_type returns nothing
        call NewBonus.SetUnitBonusR(u, bonus_type, 0)
    endfunction
    
    function AddUnitBonusReal takes unit u, integer bonus_type, real amount returns real
        call NewBonus.AddUnitBonusR(u, bonus_type, amount)
        return amount
    endfunction
endlibrary