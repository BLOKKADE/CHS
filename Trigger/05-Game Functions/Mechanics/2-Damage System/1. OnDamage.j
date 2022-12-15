scope OnDamage initializer init

    globals
        trigger TrgOnDamage
    endglobals

    private function SetTypeDamage takes unit u returns nothing
        if Damage.index.damageType != DAMAGE_TYPE_SPIRIT_LINK then

            if DamageSourceAbility == CRUSHING_WAVE_ABILITY_ID then
                set Damage.index.damageType = DAMAGE_TYPE_NORMAL
            endif

            //Staff of Power
            if UnitHasItemType(u, 'I080') and Damage.index.damageType != DAMAGE_TYPE_MAGIC then
                if DamageSourceTypeId != SEER_UNIT_ID then
                    set StaffOfPowerCritNegate = true
                endif
                set Damage.index.damageType = DAMAGE_TYPE_MAGIC
            elseif DamageSourceTypeId == 'n00W' or DamageSourceTypeId == 'n01H' or DamageSourceTypeId == SERPENT_WARD_1_UNIT_ID or DamageSourceTypeId == SKELETON_WARMAGE_1_UNIT_ID or (Damage.index.isAttack and (IsAbilityEnabled(DamageSource, SEARING_ARROWS_ABILITY_ID) or IsAbilityEnabled(DamageSource, COLD_ARROWS_ABILITY_ID))) then
                set Damage.index.damageType = DAMAGE_TYPE_MAGIC
            endif

            //all non phys dmg = magic
            if Damage.index.isSpell and (not IsPhysDamage()) then
                set Damage.index.damageType = DAMAGE_TYPE_MAGIC
            endif

            //Seer
            if DamageSourceTypeId == SEER_UNIT_ID and GetUnitAbilityLevel(u, 'A09Q') == 0 then
                if IsPhysDamage() then
                    set Damage.index.damageType = DAMAGE_TYPE_MAGIC
                elseif IsMagicDamage() then
                    set Damage.index.damageType = DAMAGE_TYPE_NORMAL
                endif
            endif
            
        endif
    endfunction

    private function OnDamage takes nothing returns nothing

        set DamageSource = Damage.index.sourceUnit
        set DamageTarget = Damage.index.targetUnit

        set DamageSourceId = GetHandleId(DamageSource)
        set DamageTargetId = GetHandleId(DamageTarget)

        set DamageSourceTypeId = GetUnitTypeId(DamageSource)
        set DamageTargetTypeId = GetUnitTypeId(DamageTarget)

        set DamageSourcePid = GetPlayerId(GetOwningPlayer(DamageSource))
        set DamageTargetPid = GetPlayerId(GetOwningPlayer(DamageTarget))

        set DamageSourceHero = PlayerHeroes[DamageSourcePid + 1]
        set DamageTargetHero = PlayerHeroes[DamageTargetPid + 1]

        set DamageSourceMagicPower = 1
        set DamageTargetMagicRes = 1

        set DamageSourcePhysPower = 0

        set DamageIsTrue = false
        set DamageIsCutting = false
        set StaffOfPowerCritNegate = false
        set DamageShowText = false

        if Damage.index.userType == DamageType_Onhit then
            set DamageIsOnHit = 1
        else
            set DamageIsOnHit = 0
        endif

        //some abilities like faerie fire start a 0 damage event this negates that
        if Damage.index.damage == 0 then
            return
        endif

        /*
        //Some abilities are counted as attacks by setting DamageIsAttack before they use UnitDamageTarget
        if DamageIsAttack then
            set attack = true
            set DamageIsAttack = false
        endif
        */

        //Modify player hero when creep because they dont have a hero
        if GetOwningPlayer(DamageTarget) == Player(11) then
            set DamageTargetHero = DamageTarget
        endif

        if GetOwningPlayer(DamageSource) == Player(11) then
            set DamageSourceHero = DamageSource
        endif

        //not sure when this is applicable
        if DamageSource == null then
            set DamageSourceHero = null
        endif

        //set damage source ability
        if not IsUnitType(DamageSource, UNIT_TYPE_HERO) then
            if DamageSourceTypeId == PRIEST_1_UNIT_ID then
                set DamageSourceId = GetDummyId(DamageSource)
                set DamageSourceMagicPower = DamageSourceMagicPower + (GetUnitCustomState(DamageSource, BONUS_MAGICPOW) / 100)
            endif
            //call BJDebugMsg("get das: " + GetObjectName(DummyAbilitySource[DamageSourceId]))
            set DamageSourceAbility = DummyAbilitySource[DamageSourceId]
        else
            set DamageSourceAbility = Damage.index.abilitySource
        endif

        /*
        //check if onhit is set
        if TypeDmg_b == 2 then
            set notOnHit = false
            set TypeDmg_b = 0
        endif 
        */

        /*
        //check if damage is from spiritlink (dummy)
        if GLOB_SpiritLink then
            set spiritLink = true
            set GLOB_SpiritLink = false
        endif
        */

        set ChestOfGreedBonus.boolean[DamageTargetId] = false
        set MagicNecklaceBonus.boolean[DamageTargetId] = false

        //call BJDebugMsg("hid: " + I2S(DamageSourceId) + " retdmg: " + R2S(RetaliationDamage.real[DamageSourceId]))
        //Retaliation Aura damage calculation
        if GetUnitAbilMods(DamageSource).RetaliationAuraBonus > 0 then
            //call BJDebugMsg("ra dmg: " + R2S(RetaliationDamage.real[DamageSourceId]) + " new: " + R2S(GetEventDamage() * RetaliationDamage.real[DamageSourceId]))
            set Damage.index.damage = (Damage.index.damage * RetaliationDamage.real[DamageSourceId])
        endif

        //Terrestrial Glaive
        if GetUnitAbilMods(DamageSource).TerrestrialGlaiveDamage then
            set Damage.index.damageType = DAMAGE_TYPE_NORMAL
        endif

        //Scorched Earth
        if ScorchedEarthDummy.boolean[DamageSourceId] then
            set ScorchedEarthSource[DamageTargetId] = DamageSourcePid
            set Damage.index.damage = 0
            return
        endif

        set DamageIsSuddenDeath = DamageSourceTypeId == SUDDEN_DEATH_UNIT_ID

        //modified damage source after this, so can't detect dummy units, those need to go ^^^
        if DamageSourceTypeId == PRIEST_1_UNIT_ID or DamageSourceTypeId == SUDDEN_DEATH_UNIT_ID or DamageSourceTypeId == 'n01L' then
            set DamageSource = DamageSourceHero
            set DamageSourceTypeId = GetUnitTypeId(DamageSource)
            set DamageSourceId = GetHandleId(DamageSource)
        endif


        set DamageSourceLuck = GetUnitCustomState(DamageSource, BONUS_LUCK)
        set DamageTargetLuck = GetUnitCustomState(DamageTarget, BONUS_LUCK)

        call SetTypeDamage(DamageSource)
        /*
        if Damage.index.isAttack then
            call BJDebugMsg("post attack dmg: " + I2S(GetHandleId(Damage.index.damageType)) + "phys:" + B2S(IsPhysDamage()) + "magic:" + B2S(IsMagicDamage()))
        elseif Damage.index.isSpell then
            call BJDebugMsg("post spell dmg: " + I2S(GetHandleId(Damage.index.damageType)) + "phys:" + B2S(IsPhysDamage()) + "magic:" + B2S(IsMagicDamage()) + "src: " + GetObjectName(DamageSourceAbility))
        else
            call BJDebugMsg("post dmg, phys:" + B2S(IsPhysDamage()) + "magic:" + B2S(IsMagicDamage()))
        endif
        */

        //call BJDebugMsg("MOD1.0 src: " + GetUnitName(DamageSource) + " trg: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage) + " dsrc: " + GetObjectName(DamageSourceAbility))
    endfunction

    private function init takes nothing returns nothing
        set TrgOnDamage = CreateTrigger()
        call TriggerAddAction(TrgOnDamage, function OnDamage)
        call DamageTrigger.registerTrigger(TrgOnDamage, "Mod", 1.0)
    endfunction

endscope