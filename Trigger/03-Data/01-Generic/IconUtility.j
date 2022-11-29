library IconUtility
    function GetIconPath takes string name returns string
        return "ReplaceableTextures\\CommandButtons\\BTN" + name + ".blp"
    endfunction

    function GetPassiveIconPath takes string name returns string
        return "ReplaceableTextures\\PassiveButtons\\DISBTN" + name + ".blp"
    endfunction

    function GetDisabledIconPath takes string name returns string
        return "ReplaceableTextures\\CommandButtonsDisabled\\DISBTN" + name + ".blp"
    endfunction
endlibrary
