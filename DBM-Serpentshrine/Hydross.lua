-- local mod	= DBM:NewMod("Hydross", "DBM-Serpentshrine")
-- local L		= mod:GetLocalizedStrings()

-- mod:SetRevision("20220518110528")
-- mod:SetCreatureID(21216)

-- mod:SetModelID(20162)

-- mod:RegisterCombat("combat")

-- mod:RegisterEventsInCombat(
-- 	"SPELL_AURA_APPLIED 38235 38246",
-- 	"SPELL_AURA_REMOVED 38246",
-- 	"SPELL_CAST_SUCCESS 38215 38216 38217 38219 38220 38221 38218 38231 40584 38222 38230 40583 25035"
-- )

-- --[[
-- (ability.id = 38215 or ability.id = 38216 or ability.id = 38217 or ability.id = 38219 or ability.id = 38220 or ability.id = 38221
--  or ability.id = 38218 or ability.id = 38231 or ability.id = 40584 or ability.id = 38222 or ability.id = 38230 or ability.id = 40583
--  or ability.id = 25035) and type = "cast"
-- --]]
-- local warnMark		= mod:NewAnnounce("WarnMark", 3, 38215)
-- local warnPhase		= mod:NewAnnounce("WarnPhase", 4)
-- local warnTomb		= mod:NewTargetNoFilterAnnounce(38235, 3)
-- local warnSludge	= mod:NewTargetNoFilterAnnounce(38246, 2)--Maybe filter it some if spammy?

-- local specWarnMark	= mod:NewSpecialWarning("SpecWarnMark")

-- local timerMark		= mod:NewTimer(15, "TimerMark", 38215, nil, nil, 2)
-- local timerSludge	= mod:NewTargetTimer(24, 38246, nil, nil, nil, 3)

-- local berserkTimer	= mod:NewBerserkTimer(600)

-- mod:AddRangeFrameOption("10")

-- local markOfH, markOfC = DBM:GetSpellInfo(38215), DBM:GetSpellInfo(38219)
-- local damage = {
-- 	[38215] = "10%", [38216] = "25%", [38217] = "50%", [38218] = "100%", [38231] = "250%", [40584] = "500%",
-- 	[38219] = "10%", [38220] = "25%", [38221] = "50%", [38222] = "100%", [38230] = "250%", [40583] = "500%",
-- }

-- local damageNext = {
-- 	[38215] = "25%", [38216] = "50%", [38217] = "100%", [38218] = "250%", [38231] = "500%", [40584] = "500%",
-- 	[38219] = "25%", [38220] = "50%", [38221] = "100%", [38222] = "250%", [38230] = "500%", [40583] = "500%",
-- }

-- function mod:OnCombatStart(delay)
-- 	timerMark:Start(16-delay, markOfH, "10%")
-- 	berserkTimer:Start(-delay)
-- 	if self.Options.RangeFrame then
-- 		DBM.RangeCheck:Show()
-- 	end
-- end

-- function mod:OnCombatEnd()
-- 	if self.Options.RangeFrame then
-- 		DBM.RangeCheck:Hide()
-- 	end
-- end

-- function mod:SPELL_AURA_APPLIED(args)
-- 	if args.spellId == 38235 then
-- 		warnTomb:CombinedShow(0.3, args.destName)
-- 	elseif args.spellId == 38246 then
-- 		warnSludge:Show(args.destName)
-- 		timerSludge:Start(args.destName)
-- 	end
-- end

-- function mod:SPELL_AURA_REMOVED(args)
-- 	if args.spellId == 38246 then
-- 		timerSludge:Stop(args.destName)
-- 	end
-- end

-- function mod:SPELL_CAST_SUCCESS(args)
-- 	if args:IsSpellID(38215, 38216, 38217, 38219, 38220, 38221) then
-- 		warnMark:Show(args.spellName, damage[args.spellId] or "10%")
-- 		timerMark:Cancel()
-- 		timerMark:Show(args.spellName, damageNext[args.spellId] or "10%")
-- 	elseif args:IsSpellID(38218, 38231, 40584, 38222, 38230, 40583) then
-- 		warnMark:Show(args.spellName, damage[args.spellId] or "10%")
-- 		specWarnMark:Show(args.spellName, damage[args.spellId] or "10%")
-- 		timerMark:Cancel()
-- 		timerMark:Show(args.spellName, damageNext[args.spellId] or "10%")
-- 	elseif args.spellId == 25035 and self:AntiSpam(2) then
-- 		timerMark:Cancel()
-- 		if args:GetSrcCreatureID() == 22035 then
-- 			warnPhase:Show(L.Frost)
-- 			timerMark:Start(15.4, markOfH, "10%")
-- 		elseif args:GetSrcCreatureID() == 22036 then
-- 			warnPhase:Show(L.Nature)
-- 			timerMark:Start(15.4, markOfC, "10%")
-- 		end
-- 	end
-- end





---------------------------------------------
---------------------------------------------

local mod	= DBM:NewMod("Hydross", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220609123000") -- fxpw check 20220609123000


mod:SetCreatureID(21216)
mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellPull)
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:SetModelID(20162)


mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 38215 38216 38217 38218 38231 40584 38219 38220 38221 8222 38230 40583 38235 38246 309055",
	"SPELL_AURA_APPLIED 309046 309065 309068",
	"SPELL_AURA_APPLIED_DOSE 309046 309065 309068",
	"SPELL_AURA_REMOVED 309046 309065",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START 309052 309069 309072",
	"UNIT_HEALTH"

)

local warnMarkOfHydross     = mod:NewAnnounce("WarnMarkOfHydross", 3, 38215)
local warnMarkOfCorruption  = mod:NewAnnounce("WarnMarkOfCorruption", 3, 38219)
local warnWaterTomb         = mod:NewTargetAnnounce(38235, 3)
local warnVileSludge        = mod:NewTargetAnnounce(38246, 3)

local specWarnThreatReset   = mod:NewSpecialWarning("SpecWarnThreatReset", "-Tank|-Healer")

local timerMarkOfHydross    = mod:NewTimer(15, "TimerMarkOfHydross", 38215, nil, nil, 7)
local timerMarkOfCorruption = mod:NewTimer(15, "TimerMarkOfCorruption", 38219, nil, nil, 7)

local berserkTimer          = mod:NewBerserkTimer(600)

----------хм-------------------

local warnSklep         = mod:NewTargetAnnounce(309046, 4) -- лужа
local warnKor           = mod:NewTargetAnnounce(309065, 4) -- коррозия

local specWarnArrow     = mod:NewSpecialWarningMove(309052, 2) -- залп вод
local specWarnAya      = mod:NewSpecialWarningMove(309069, 2) -- залп яда
local specWarnYad       = mod:NewSpecialWarning("Yad", 309072, nil, nil, 1, 6) -- Перефаза яда
local specWarnChis      = mod:NewSpecialWarning("Chis", 309055, nil, nil, 1, 6) -- Перефаза чист

local specWarnSklep     = mod:NewSpecialWarningRun(309046, nil, nil, nil, 1, 4) -- лужа
local specWarnKor       = mod:NewSpecialWarningRun(309065, nil, nil, nil, 1, 4) -- коррозия
local yellSklep		= mod:NewYell(309046, nil, nil, nil, "YELL")
local yellSklepFades= mod:NewShortFadesYell(309046)
local yellKor		= mod:NewYell(309065)

local timerSklepCD		= mod:NewCDTimer(32, 309046, nil, nil, nil, 3) -- лужа
local timerKorCD		= mod:NewCDTimer(32, 309065, nil, nil, nil, 3) -- коррозия
local timerArrowCD		= mod:NewCDTimer(25, 309052, nil, nil, nil, 3) -- залп вод
local timerAyaCD		= mod:NewCDTimer(25, 309069, nil, nil, nil, 3) -- залп яда
local timerArrowCast	= mod:NewCastTimer(1.5, 309052, nil, nil, nil, 3) -- залп  вод каст
local timerAyaCast  	= mod:NewCastTimer(1.5, 309069, nil, nil, nil, 3) -- залп  яда каст
local timerYadCast		= mod:NewCastTimer(25, 309072, nil, nil, nil, 6) -- яд
local timerChisCast		= mod:NewCastTimer(20, 309055, nil, nil, nil, 6) -- чистота
local timerStaktimer    = mod:NewTargetTimer(30, 309068, nil, "Healer|Tank", nil, 1)

mod:AddSetIconOption("SetIconOnSklepTargets", 309046, true, true, {6, 7, 8})
mod:AddSetIconOption("SetIconOnKorTargets", 309065, true, true, {6, 7, 8})
mod:AddBoolOption("AnnounceSklep", false)
mod:AddBoolOption("AnnounceKor", false)

mod.vb.phase = 0
local SklepTargets = {}
local KorTargets = {}
mod.vb.SklepIcon = 8
mod.vb.KorlIcon = 8

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetSklepIcons()
		table.sort(SklepTargets, sort_by_group)
		for i, v in ipairs(SklepTargets) do
			if mod.Options.AnnounceSklep then
				if DBM:GetRaidRank() > 0 then
					SendChatMessage(L.SklepIcon:format(self.vb.SklepIcons, UnitName(v)), "RAID_WARNING")
				else
					SendChatMessage(L.SklepIcon:format(self.vb.SklepIcons, UnitName(v)), "RAID")
				end
			end
			if self.Options.SetIconOnSklepTargets then
				self:SetIcon(UnitName(v), self.vb.SklepIcons, 10)
			end
			self.vb.SklepIcons = self.vb.SklepIcons - 1
		end
		if #SklepTargets >= 3 then
			warnSklep:Show(table.concat(SklepTargets, "<, >"))
			table.wipe(SklepTargets)
			self.vb.SklepIcons = 8
		end
	end
	function mod:SetKorIcons()
		table.sort(KorTargets, sort_by_group)
		for i, v in ipairs(KorTargets) do
			if mod.Options.AnnounceKor then
				if DBM:GetRaidRank() > 0 then
					SendChatMessage(L.KorIcon:format(self.vb.KorIcon, UnitName(v)), "RAID_WARNING")
				else
					SendChatMessage(L.KorIcon:format(self.vb.KorIcon, UnitName(v)), "RAID")
				end
			end
			if self.Options.SetIconOnKorTargets then
				self:SetIcon(UnitName(v), self.vb.KorIcon)
			end
			self.vb.KorIcon = self.vb.KorIcon - 1
		end
		if #KorTargets >= 3 then
			warnKor:Show(table.concat(KorTargets, "<, >"))
			table.wipe(KorTargets)
			self.vb.KorIcon = 8
		end
	end
end

function mod:OnCombatStart()
	berserkTimer:Start()
	self.vb.phase = 1
	self.vb.SklepIcons = 8
	self.vb.KorIcon = 8
	if mod:IsDifficulty("heroic25") then
	timerArrowCD:Start()
	timerSklepCD:Start()
	else
	timerMarkOfHydross:Start("10")
	DBM:FireCustomEvent("DBM_EncounterStart", 21216, "Hydross the Unstable")
	end
end

function mod:OnCombatEnd(wipe)
	DBM:FireCustomEvent("DBM_EncounterEnd", 21216, "Hydross the Unstable", wipe)
end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 309052 then --залп вод
	timerArrowCD:Start()
	timerArrowCast:Start()
	specWarnArrow:Show()
	elseif spellId == 309069 then --залп яда
	timerAyaCD:Start()
	timerAyaCast:Start()
	specWarnAya:Show()
	elseif spellId == 309072 then  --грязная фаза
	timerYadCast:Start(25)
	timerKorCD:Start(52)
	timerAyaCD:Start()
	specWarnYad:Show()
	timerArrowCD:Cancel()
	timerSklepCD:Cancel()
	end
end

function mod:SPELL_AURA_APPLIED(args) -- все хм --
	local spellId = args.spellId
	if spellId == 309046 then
		SklepTargets[#SklepTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnSklep:Show()
			yellSklep:Yell()
			yellSklepFades:Countdown(spellId)
		end
		self:ScheduleMethod(0.1, "SetSklepIcons")
		timerSklepCD:Start()
	elseif spellId == 309065 then
		KorTargets[#KorTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnKor:Show()
			yellKor:Yell()
		end
		self:ScheduleMethod(0.1, "SetKorIcons")
		timerKorCD:Start()
		elseif spellId == 309068 then
			timerStaktimer:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 309046 then
		if self.Options.SetIconOnSklepTargets then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 309065 then
		if self.Options.SetIconOnKorTargets then
			self:SetIcon(args.destName, 0)
		end
	end
end


local sidToTimeH ={
	["38215"] = {10,25},
	["38216"] = {25,50},
	["38217"] = {50,100},
	["38218"] = {100,250},
	["38231"] = {250,500},
	["40584"] = {500,500},
}
local SidToTimeC ={
	["38219"] = {10,25},
	["38220"] = {25,50},
	["38221"] = {50,100},
	["38222"] = {100,250},
	["38230"] = {250,500},
	["40583"] = {500,500},

}

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if sidToTimeH[spellId] then
		warnMarkOfHydross:Show(sidToTimeH[spellId][1])
		timerMarkOfHydross:Start(sidToTimeH[spellId][2])

	-- if spellId == 38215 then
	-- 	warnMarkOfHydross:Show("10")
	-- 	timerMarkOfHydross:Start("25")
	-- elseif spellId == 38216 then
	-- 	warnMarkOfHydross:Show("25")
	-- 	timerMarkOfHydross:Start("50")
	-- elseif spellId == 38217 then
	-- 	warnMarkOfHydross:Show("50")
	-- 	timerMarkOfHydross:Start("100")
	-- elseif spellId == 38218 then
	-- 	warnMarkOfHydross:Show("100")
	-- 	timerMarkOfHydross:Start("250")
	-- elseif spellId == 38231 then
	-- 	warnMarkOfHydross:Show("250")
	-- 	timerMarkOfHydross:Start("500")
	-- elseif spellId == 40584 then
	-- 	warnMarkOfHydross:Show("500")
	-- 	timerMarkOfHydross:Start("500")

	elseif SidToTimeC[spellId] then
		warnMarkOfCorruption:Show(SidToTimeC[spellId][1])
		timerMarkOfCorruption:Start(SidToTimeC[spellId][2])

	-- elseif spellId == 38219 then
	-- 	warnMarkOfCorruption:Show("10")
	-- 	timerMarkOfCorruption:Start("25")
	-- elseif spellId == 38220 then
	-- 	warnMarkOfCorruption:Show("25")
	-- 	timerMarkOfCorruption:Start("50")
	-- elseif spellId == 38221 then
	-- 	warnMarkOfCorruption:Show("50")
	-- 	timerMarkOfCorruption:Start("100")
	-- elseif spellId == 38222 then
	-- 	warnMarkOfCorruption:Show("100")
	-- 	timerMarkOfCorruption:Start("250")
	-- elseif spellId == 38230 then
	-- 	warnMarkOfCorruption:Show("250")
	-- 	timerMarkOfCorruption:Start("500")
	-- elseif spellId == 40583 then
	-- 	warnMarkOfCorruption:Show("500")
	-- 	timerMarkOfCorruption:Start("500")

	elseif spellId == 38235 then
		warnWaterTomb:Show(args.destName)
	elseif spellId == 38246 then
		warnVileSludge:Show(args.destName)
	-------------- хм-------------------
    elseif  spellId == 309055 then -- чистая фаза
	    specWarnChis:Show()
        timerChisCast:Start()
	    timerKorCD:Cancel()
	    timerAyaCD:Cancel()
	    timerArrowCD:Start()
	    timerSklepCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if mod:IsDifficulty("heroic25") then
	else
	    if msg == L.YellPoison then
			timerMarkOfHydross:Cancel()
			timerMarkOfCorruption:Start("10")
			specWarnThreatReset:Show()
	    elseif msg == L.YellWater then
			timerMarkOfCorruption:Cancel()
			timerMarkOfHydross:Start("10")
			specWarnThreatReset:Show()
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED