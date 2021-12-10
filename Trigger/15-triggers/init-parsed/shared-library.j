library SharedLibrary initializer init requires RandomShit

    function ShowDraftBuildings takes boolean b returns nothing
        local integer i = 0
        if AbilityMode == 2 then
            loop
                call ShowUnit(circle1, b)
                call ShowUnit(circle2, b)
                call ShowUnit(udg_Draft_DraftBuildings[i], b)
                call ShowUnit(udg_Draft_UpgradeBuildings[i], b)
                call SetTextTagVisibility(FloatingTextBuy, b)
                call SetTextTagVisibility(FloatingTextUpgrade, b)
                set i = i + 1
                exitwhen i > 9
            endloop
        endif
    endfunction


    function Trig_Hero_Dies_Func024Func001Func001A111a takes nothing returns nothing
    
    
    
        //	call DisableTrigger(udg_trigger107)
        //	call KillUnit(GetEnumUnit())
        //	call EnableTrigger(udg_trigger107)
    
    endfunction


    function Trig_Hero_Dies_Func024Func001Func0010010025551 takes nothing returns boolean
    
        call KillUnit(GetFilterUnit())
        return false
    endfunction


    function Trig_Start_Level_Func015Func002Func003Func001001 takes unit u returns boolean
        return GetUnitTypeId(u)=='h009' or GetUnitTypeId(u)=='h014' or GetUnitTypeId(u)=='h015' or GetUnitTypeId(u)=='h00B'
    endfunction



endlibrary
