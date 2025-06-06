library TerrainPathability initializer Init
//******************************************************************************
//* BY: Rising_Dusk, edited by BPower
//* 
//* This script can be used to detect the type of pathing at a specific point.
//* It is valuable to do it this way because the IsTerrainPathable is very
//* counterintuitive and returns in odd ways and aren't always as you would
//* expect. This library, however, facilitates detecting those things reliably
//* and easily.
//* 
//******************************************************************************
//* 
//*    > function IsTerrainDeepWater    takes real x, real y returns boolean
//*    > function IsTerrainShallowWater takes real x, real y returns boolean
//*    > function IsTerrainLand         takes real x, real y returns boolean
//*    > function IsTerrainPlatform     takes real x, real y returns boolean
//*    > function IsTerrainWalkable     takes real x, real y returns boolean
//* 
//* These functions return true if the given point is of the type specified
//* in the function's name and false if it is not. For the IsTerrainWalkable
//* function, the MAX_RANGE constant below is the maximum deviation range from
//* the supplied coordinates that will still return true.
//* 
//* The IsTerrainPlatform works for any preplaced walkable destructable. It will
//* return true over bridges, destructable ramps, elevators, and invisible
//* platforms. Walkable destructables created at runtime do not create the same
//* pathing hole as preplaced ones do, so this will return false for them. All
//* other functions except IsTerrainWalkable return false for platforms, because
//* the platform itself erases their pathing when the map is saved.
//* 
//* After calling IsTerrainWalkable(x, y), the following two global variables
//* gain meaning. They return the X and Y coordinates of the nearest walkable
//* point to the specified coordinates. These will only deviate from the
//* IsTerrainWalkable function arguments if the function returned false.
//* 
//* Variables that can be used from the library:
//*     [real]    TerrainPathability_X
//*     [real]    TerrainPathability_Y
//* 
    globals
        private constant real    MAX_RANGE     = 100.
        private constant integer DUMMY_ITEM_ID = 'wolg'
    endglobals

    globals    
        private item       Item   = null
        private rect       Find   = null
        private item array stack
        private integer    size   = 0
        public  real       X      = 0.
        public  real       Y      = 0.
    endglobals

    function IsTerrainDeepWater takes real x, real y returns boolean
        return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)
    endfunction
    function IsTerrainShallowWater takes real x, real y returns boolean
        return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)
    endfunction
    function IsTerrainLand takes real x, real y returns boolean
        return IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY)
    endfunction
    function IsTerrainPlatform takes real x, real y returns boolean
        return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)
    endfunction

    private function HideItem takes nothing returns nothing
        if IsItemVisible(GetEnumItem()) then
            set stack[size] = GetEnumItem()
            call SetItemVisible(stack[size], false)
            set size = size + 1
        endif
    endfunction
    function IsTerrainWalkable takes real x, real y returns boolean
        //Hide any items in the area to avoid conflicts with our item
        call MoveRectTo(Find, x, y)
        call EnumItemsInRect(Find ,null, function HideItem)

        // check if Item is deleted
        if GetItemTypeId(Item) == 0 then
            set Item = CreateItem(DUMMY_ITEM_ID, 0, 0)
        endif
        
        //Try to move the test item and get its coords
        call SetItemPosition(Item, x, y) //Unhides the item
        set X = GetItemX(Item)
        set Y = GetItemY(Item)

        //reset position
        call SetItemPosition(Item, 0, 0)

        call SetItemVisible(Item, false)//Hide it again
        //Unhide any items hidden at the start
        loop
            exitwhen (0 == size)
            set size = size - 1
            call SetItemVisible(stack[size], true)
            set stack[size] = null
        endloop

        //Return walkability
        return (X-x)*(X-x)+(Y-y)*(Y-y) <= MAX_RANGE and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)
    endfunction

    private function Init takes nothing returns nothing
        set Find = Rect(0., 0., 128., 128.)
        set Item = CreateItem(DUMMY_ITEM_ID, 0, 0)
        call SetItemVisible(Item, false)
    endfunction
endlibrary

library IsTerrainWalkable uses TerrainPathability
endlibrary