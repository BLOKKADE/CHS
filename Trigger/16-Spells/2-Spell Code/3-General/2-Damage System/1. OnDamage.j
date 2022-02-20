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
            if UnitHasItemS(u, 'I080') and Damage.index.damageType != DAMAGE_TYPE_MAGIC then
                set StaffOfPowerCritNegate = true
                set Damage.index.damageType = DAMAGE_TYPE_MAGIC
            elseif DamageSourceTypeId == 'n00W' or DamageSourceTypeId == 'n01H' or DamageSourceTypeId == SERPENT_WARD_1_UNIT_ID or DamageSourceTypeId == SKELETON_WARMAGE_1_UNIT_ID or (Damage.index.isAttack and (IsAbilityEnabled(DamageSource, SEARING_ARROWS_ABILITY_ID) or IsAbilityEnabled(DamageSource, COLD_ARROWS_ABILITY_ID))) then
                set Damage.index.damageType = DAMAGE_TYPE_MAGIC
            endif

            //all non phys dmg = magic
            if Damage.index.isSpell and not IsPhysDamage() then
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

        set DamageSourceHero = udg_units01[DamageSourcePid + 1]
        set DamageTargetHero = udg_units01[DamageTargetPid + 1]

        set DamageSourceMagicPower = 1
        set DamageTargetMagicRes = 1

        set DamageSourcePhysPower = 0

        set DamageIsTrue = false
        set DamageIsCutting = false
        set StaffOfPowerCritNegate = false
        set DamageShowText = false

        if Damage.index.userType == DamageType_Onhit then
            set DamageIsOnHit = true
        else
            set DamageIsOnHit = false
        endif

        //some abilities like faerie fire start a 0 damage event this negates that
        if Damage.index.damage == 0 or DeathReviveInvul.boolean[DamageTargetPid] then
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
        if DamageSourceTypeId == PRIEST_1_UNIT_ID then
            set DamageSourceId = GetDummyId(DamageSource)
            set DamageSourceAbility = DummyAbilitySource[DamageSourceId]
            set DamageSourceMagicPower = DamageSourceMagicPower + (GetUnitMagicDmg(DamageSource) / 100)
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
        if RetaliationDamage.real[DamageSourceId] > 0 then
            //call BJDebugMsg("ra dmg: " + R2S(RetaliationDamage.real[DamageSourceId]) + " new: " + R2S(GetEventDamage() * RetaliationDamage.real[DamageSourceId]))
            set Damage.index.damage = (Damage.index.damage * RetaliationDamage.real[DamageSourceId])
            set RetaliationDamage.real[DamageSourceId] = 0
        endif

        //Scorched Earth
        if ScorchedEarthDummy.boolean[DamageSourceId] then
            set ScorchedEarthSource[DamageTargetId] = DamageSourcePid
            set Damage.index.damage = 0
            return
        endif

        //modified damage source after this, so can't detect dummy units, those need to go ^^^
        if DamageSourceTypeId == PRIEST_1_UNIT_ID or DamageSourceTypeId == 'h014' or DamageSourceTypeId == 'n00V' or DamageSourceTypeId == 'n01L' then
            set DamageSource = DamageSourceHero
            set DamageSourceTypeId = GetUnitTypeId(DamageSource)
            set DamageSourceId = GetHandleId(DamageSource)
        endif

        set DamageSourceLuck = GetUnitLuck(DamageSource)
        set DamageTargetLuck = GetUnitLuck(DamageTarget)

        call SetTypeDamage(DamageSource)
/*
        if Damage.index.isAttack then
            call BJDebugMsg("post attack dmg: " + I2S(GetHandleId(Damage.index.damageType)) + "phys:" + B2S(IsPhysDamage()) + "magic:" + B2S(IsMagicDamage()))
        elseif Damage.index.isSpell then
            call BJDebugMsg("post spell dmg: " + I2S(GetHandleId(Damage.index.damageType)) + "phys:" + B2S(IsPhysDamage()) + "magic:" + B2S(IsMagicDamage()) + "src: " + GetObjectName(DamageSourceAbility))
        else
            call BJDebugMsg("post dmg, phys:" + B2S(IsPhysDamage()) + "magic:" + B2S(IsMagicDamage()))
        endif*/

        //call BJDebugMsg("MOD1.0 source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))
    endfunction

    private function init takes nothing returns nothing
        set TrgOnDamage = CreateTrigger()
        call TriggerAddAction(TrgOnDamage, function OnDamage)
        call DamageTrigger.registerTrigger(TrgOnDamage, "Mod", 1.0)
    endfunction

endscope