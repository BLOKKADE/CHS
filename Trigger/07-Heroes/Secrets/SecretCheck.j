library SecretCheck initializer init
    globals
        HashTable SecretUnlocked
    endglobals

    public function CheckAbilitiesAndItems takes unit u returns nothing
        call PandaSkin_CheckAbilitiesAndItems(u)
        call RoboGoblinSkin_CheckAbilitiesAndItems(u)
    endfunction

    private function init takes nothing returns nothing
        set SecretUnlocked= HashTable.create()
    endfunction
endlibrary
