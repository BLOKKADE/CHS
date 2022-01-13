scope OnDamage initializer init

    globals
        trigger TrgOnDamage
    endglobals

    private function SetTypeDamage takes unit u, integer unitId returns nothing
        if Damage.index.damageType != DAMAGE_TYPE_SPIRIT_LINK then
            if Damage.index.isAttack then
                set Damage.index.damageType = DAMAGE_TYPE_NORMAL
            else 
                set Damage.index.damageType = DAMAGE_TYPE_MAGIC
            endif

            //Seer
            if unitId == SEER_UNIT_ID then
                if Damage.index.damageType == DAMAGE_TYPE_NORMAL then
                    set Damage.index.damageType = DAMAGE_TYPE_MAGIC
                else
                    set Damage.index.damageType = DAMAGE_TYPE_NORMAL
                endif
            else
                //Staff of Power
                if UnitHasItemS(u, 'I080') or unitId == 'n00W' or unitId == 'n01H' or unitId == SKELETON_WARMAGE_1_UNIT_ID then
                    set Damage.index.damageType = DAMAGE_TYPE_MAGIC
                endif
            endif
        endif
    endfunction

    private function OnDamage takes nothing returns nothing
        local integer unitId = GetUnitTypeId(Damage.index.source)

        set DamageSource = Damage.index.sourceUnit
        set DamageTarget = Damage.index.targetUnit

        set DamageSourceId = GetHandleId(DamageTarget)
        set DamageTargetId = GetHandleId(DamageTarget)

        set DamageSourcePid = GetPlayerId(GetOwningPlayer(DamageSource))
        set DamageTargetPid = GetPlayerId(GetOwningPlayer(DamageTarget))

        set DamageSourceHero = udg_units01[DamageSourcePid + 1]
        set DamageTargetHero = udg_units01[DamageTargetPid + 1]

        set DamageSourceMagicPower = 1
        set DamageTargetMagicRes = 0

        set DamageSourcePhysPower = 1

        set DamageIsTrue = false
        set DamageIsCutting = false

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
        if unitId == PRIEST_1_UNIT_ID then
            set DamageSourceId = GetDummyId(DamageSource)
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
        if RetaliationDamage.real[DamageSourceId] > 0 then
            //call BJDebugMsg("ra dmg: " + R2S(RetaliationDamage.real[DamageSourceId]) + " new: " + R2S(GetEventDamage() * RetaliationDamage.real[DamageSourceId]))
            set Damage.index.damage = (Damage.index.damage * RetaliationDamage.real[DamageSourceId])
            set RetaliationDamage.real[DamageSourceId] = 0
            set DamageSourceMagicPower = DamageSourceMagicPower + (GetUnitMagicDmg(DamageSource) / 100)
        endif

        //Scorched Earth
        if ScorchedEarthDummy.boolean[DamageSourceId] then
            set ScorchedEarthSource[DamageTargetId] = DamageSourcePid
            set Damage.index.damage = 0
            return
        endif

        //Thunderwitch passive
        if ThunderBoltSource.boolean[DamageSourceId] then
            set DamageSourceMagicPower = DamageSourceMagicPower + (GetUnitMagicDmg(DamageSourceHero) / 100)
        endif

        //modified damage source after this, so can't detect dummy units, those need to go ^^^
        if unitId == PRIEST_1_UNIT_ID or unitId == 'h014' or unitId == 'n00V' or unitId == 'n01L' then
            set DamageSource = DamageSourceHero
            set unitId = GetUnitTypeId(DamageSource)
            set DamageSourceId = GetHandleId(DamageSource)
        endif

        set DamageSourceLuck = GetUnitLuck(DamageSource)
        set DamageTargetLuck = GetUnitLuck(DamageTarget)

        call SetTypeDamage(DamageSource, unitId)

        //call BJDebugMsg("MOD1.0 source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))
    endfunction

    private function init takes nothing returns nothing
        set TrgOnDamage = CreateTrigger()
        call TriggerAddAction(TrgOnDamage, function OnDamage)
        call DamageTrigger.registerTrigger(TrgOnDamage, "Mod", 1.0)
    endfunction

endscope