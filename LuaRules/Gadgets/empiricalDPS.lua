function gadget:GetInfo()
  return {
    name      = "Empirical DPS",
    desc      = "Tool for determining real DPS values",
    author    = "Google Frog",
    date      = "12 Sep 2011",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

if (not gadgetHandler:IsSyncedCode()) then
    return
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-- Spawn two units of opposing teams, set one to hold fire.

local last
local start, damage

function gadget:UnitDamaged(unitID, unitDefID,  unitTeam, unitDamage, paralyzer, 
                            weaponID, attackerID, attackerDefID, attackerTeam)
    --local wd = WeaponDefs[weaponID]
	--if wd then
	--	local aoe = wd.damageAreaOfEffect
	--	local dist = 0.09
	--	local edgeEff = wd.edgeEffectiveness
	--	local writeDamage = wd.damages[0]
	--	local theoryDamage = writeDamage*(aoe-dist)/(aoe + 0.01 - dist*edgeEff)
	--	local theoryDist = -unitDamage/writeDamage*(aoe + 0.01)+aoe
	--	Spring.Echo(wd.customParams.statsdamage)
	--	Spring.Echo(unitDamage)
	--	Spring.Echo(theoryDamage)
	--	Spring.Echo(aoe)
	--	Spring.Echo(edgeEff)
	--	Spring.Echo(theoryDist)
	--end
	
	--Spring.SetUnitExperience(attackerID,0.001)
    local frame = Spring.GetGameFrame()
    -- delay
    if last then
        --Spring.Echo(frame-last)
    end
    last = frame
    -- dps
    if start then
        --Spring.Echo(damage/(frame-start)*30)
        damage = damage + unitDamage
    else
        start = frame
        damage = unitDamage
    end
	--Spring.Echo("Damage: " .. damage)
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    local frame = Spring.GetGameFrame()
    if start then
        Spring.Echo("Total DPS: " .. UnitDefs[unitDefID].health/(frame - start)*30)
        start = nil
    end
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam)
    damage = 0
    start = nil
end
