library AncientElement initializer init requires RandomShit, AbsoluteElements, AoeDamage
    globals
        Table AncientElementFx
        Table AncientElementIds
    endglobals

    private function GetAncientElementFx takes nothing returns string
        return AncientElementFx.string[GetRandomInt(1, AncientElementFx[0])]
    endfunction

    function PickElement takes unit caster returns integer
        local integer absoluteCount = LoadInteger(HT, GetHandleId(caster), 941561)

        if absoluteCount > 0 then
            return GetAbsoluteElement(GetHeroSpellAtPosition(caster, (10) + GetRandomInt(1, absoluteCount)))
        else
            return GetRandomInt(1, Element_Maximum)
        endif
    endfunction

    function UseAncientElement takes unit caster, integer level returns nothing
        local integer elementId = PickElement(caster)
        local integer element = AncientElementIds[elementId]
        //call BJDebugMsg("ae: " + I2S(element))
        call CreateTextTagTimerColor(ClassAbil[elementId],1,GetUnitX(caster),GetUnitY(caster),80,1,255,255,255)
        call AreaDamage(caster, GetUnitX(caster), GetUnitY(caster), GetSpellValue(40, 5, level), 600, false, element)
        call DestroyEffect(AddLocalizedSpecialEffect(GetAncientElementFx(), GetUnitX(caster), GetUnitY(caster)))
        call AbilStartCD(caster, ANCIENT_ELEMENT_ABILITY_ID, 2)
    endfunction

    private function SetAeElementData takes integer id, integer element returns nothing
        set ElementData[element].integer[id] = 1
        set AncientElementIds[element] = id
    endfunction

    private function init takes nothing returns nothing
        set AncientElementFx = Table.create()
        set AncientElementIds = Table.create()

        set AncientElementFx.string[1] = "war3mapImported\\Flamestrike Blood II.mdx"
        set AncientElementFx.string[2] = "war3mapImported\\Flamestrike Dark Blood II.mdx"
        set AncientElementFx.string[3] = "war3mapImported\\Flamestrike Dark Void II.mdx"
        set AncientElementFx.string[4] = "war3mapImported\\Flamestrike II.mdx"
        set AncientElementFx.string[5] = "war3mapImported\\Flamestrike Mystic II.mdx"
        set AncientElementFx.string[6] = "war3mapImported\\Flamestrike Nature II.mdx"
        set AncientElementFx.string[7] = "war3mapImported\\Flamestrike Starfire II.mdx"
        set AncientElementFx.integer[0] = 7

        //set ancient element dummy elements
        call SetAeElementData('AE00', Element_Fire)
        call SetAeElementData('AE01', Element_Water)
        call SetAeElementData('AE02', Element_Wind)
        call SetAeElementData('AE03', Element_Earth)
        call SetAeElementData('AE04', Element_Wild)
        call SetAeElementData('AE05', Element_Energy)
        call SetAeElementData('AE06', Element_Dark)
        call SetAeElementData('AE07', Element_Light)
        call SetAeElementData('AE08', Element_Cold)
        call SetAeElementData('AE09', Element_Poison)
        call SetAeElementData('AE10', Element_Blood)
        call SetAeElementData('AE11', Element_Arcane)
    endfunction
endlibrary