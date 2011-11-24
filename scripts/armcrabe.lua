include 'constants.lua'

--------------------------------------------------------------------------------
-- pieces
--------------------------------------------------------------------------------
local base = piece 'base' 
local ground = piece 'ground' 
local turret = piece 'turret' 
local blight = piece 'blight' 
local canon = piece 'canon' 
local barrel1 = piece 'barrel1' 
local barrel2 = piece 'barrel2' 
local flare1 = piece 'flare1' 
local flare2 = piece 'flare2' 
local flare3 = piece 'flare3' 
local flare4 = piece 'flare4' 
local flare5 = piece 'flare5' 
local flare6 = piece 'flare6' 
local flare7 = piece 'flare7' 
local rocket = piece 'rocket' 
local leg1 = piece 'leg1'	-- front right
local leg2 = piece 'leg2'	-- back right
local leg3 = piece 'leg3' 	-- back left
local leg4 = piece 'leg4' 	-- front left
local gflash = piece 'gflash' 

smokePiece = {base, turret}

--------------------------------------------------------------------------------
-- constants
--------------------------------------------------------------------------------

local restore_delay = 3000
local base_speed = 100

local SIG_MOVE = 2	
local SIG_AIM1 = 4
local SIG_AIM2 = 8
local SIG_CURL = 16

local PACE = 1.2

local legRaiseSpeed = math.rad(45)*PACE
local legRaiseAngle = math.rad(20)
local legLowerSpeed = math.rad(50)*PACE

local legForwardSpeed = math.rad(40)*PACE
local legForwardAngle = -math.rad(20)
local legBackwardSpeed = math.rad(35)*PACE
local legBackwardAngle = math.rad(25)
local legBackwardAngleMinor = math.rad(10)

--------------------------------------------------------------------------------
-- vars
--------------------------------------------------------------------------------
local bMoving = false
local bCurled = false
local bCurling = false
local nocurl = true

local gun_0 = 0

-- four-stroke tetrapedal walkscript
local function Walk()
	while bCurled or bCurling do Sleep(100) end
	SetUnitValue(COB.MAX_SPEED, base_speed)
	while true do
		-- Spring.Echo("left fore and right back move, left back and right fore anchor")
		Turn(leg4, z_axis, legRaiseAngle, legRaiseSpeed)	-- LF leg up
		Turn(leg4, y_axis, legForwardAngle, legForwardSpeed)	-- LF leg forward
		--Turn(leg3, z_axis, 0, legLowerSpeed)	-- LB leg down
		Turn(leg3, y_axis, legBackwardAngle, legBackwardSpeed)	-- LB leg back
		
		--Turn(leg1, z_axis, 0, legLowerSpeed)	-- RF leg down
		Turn(leg1, y_axis, -legBackwardAngleMinor, legBackwardSpeed)	-- RF leg back
		Turn(leg2, z_axis, -legRaiseAngle, legRaiseSpeed)	-- RB leg up
		Turn(leg2, y_axis, 0, legForwardSpeed)	-- RB leg forward	
		
		WaitForTurn(leg4, z_axis)
		WaitForTurn(leg4, y_axis)
		Sleep(0)
		
		-- Spring.Echo("lower left fore and right back")
		Turn(leg4, z_axis, 0, legLowerSpeed)	-- LF leg down		
		Turn(leg2, z_axis, 0, legLowerSpeed)	-- RB leg down
		Sleep(0)
		WaitForTurn(leg4, z_axis)
		
		-- Spring.Echo("left back and right fore move, left fore and right back anchor")
		--Turn(leg4, z_axis, 0, legLowerSpeed)	-- LF leg down
		Turn(leg4, y_axis, legBackwardAngleMinor, legBackwardSpeed)	-- LF leg back
		Turn(leg3, z_axis, legRaiseAngle, legRaiseSpeed)	-- LB leg up
		Turn(leg3, y_axis, 0, legForwardSpeed)	-- LB leg forward
		
		Turn(leg1, z_axis, -legRaiseAngle, legRaiseSpeed)	-- RF leg up
		Turn(leg1, y_axis, -legForwardAngle, legForwardSpeed)	-- RF leg forward
		--Turn(leg2, z_axis, 0, legLowerSpeed)	-- RB leg down
		Turn(leg2, y_axis, -legBackwardAngle, legBackwardSpeed)	-- RB leg back	
		WaitForTurn(leg1, z_axis)
		WaitForTurn(leg1, y_axis)
		Sleep(0)

		-- Spring.Echo("lower left back and right fore")
		Turn(leg3, z_axis, 0, legLowerSpeed)	-- LB leg down		
		Turn(leg1, z_axis, 0, legLowerSpeed)	-- RF leg down
		Sleep(0)
		WaitForTurn(leg3, z_axis)
	end
end

local function Curl()
	if nocurl then return end
	--Spring.Echo("Initiating curl")
	Signal( SIG_CURL)
	SetSignalMask( SIG_CURL)
	
	Sleep(100)
	bCurling = true
	SetUnitValue(COB.MAX_SPEED, 1)

	Move( canon , y_axis, 5 , 2.5 )
	Move( base , y_axis, -5 , 2.5 )
	Move( base , z_axis, -5 , 2.5 )
	
	Turn( leg1 , y_axis, math.rad(45), math.rad(35) )
	Turn( leg4 , y_axis, math.rad(-45), math.rad(35) )
	Turn( leg2 , y_axis, math.rad(-45), math.rad(35) )
	Turn( leg3 , y_axis, math.rad(45), math.rad(35) )
	
	Turn( leg1 , z_axis, math.rad(45), math.rad(35) )
	Turn( leg4 , z_axis, math.rad(-45), math.rad(35) )
	Turn( leg2 , z_axis, math.rad(40), math.rad(35) )
	Turn( leg3 , z_axis, math.rad(-40), math.rad(35) )
	
	-- preturn (makes sure the legs turn in the right direction)
	Turn(leg2 , x_axis, math.rad(90), math.rad(95))
	Turn(leg3 , x_axis, math.rad(90), math.rad(95))
	Turn(leg1 , x_axis, math.rad(-90), math.rad(95))
	Turn(leg4 , x_axis, math.rad(-90), math.rad(95))
	Sleep(100)
	
	Turn(leg2 , x_axis, math.rad(180), math.rad(95))
	Turn(leg3 , x_axis, math.rad(180), math.rad(95))
	Turn(leg1 , x_axis, math.rad(180), math.rad(95))
	Turn(leg4 , x_axis, math.rad(180), math.rad(95))

    WaitForTurn(leg1, x_axis)
    WaitForTurn(leg2, x_axis)
    WaitForTurn(leg3, x_axis)
    WaitForTurn(leg4, x_axis)
        
    WaitForTurn(leg1, y_axis)
    WaitForTurn(leg2, y_axis)
    WaitForTurn(leg3, y_axis)
    WaitForTurn(leg4, y_axis)
        
    WaitForTurn(leg1, z_axis)
    WaitForTurn(leg2, z_axis)
    WaitForTurn(leg3, z_axis)
    WaitForTurn(leg4, z_axis)    
	
   	bCurled = true
   	bCurling = false
	Spring.SetUnitArmored(unitID,true)
end

local function ResetLegs()
	--Spring.Echo("Resetting legs")
	Turn( leg1 , y_axis, 0, math.rad(35) )
	Turn( leg2 , y_axis, 0, math.rad(35) )
	Turn( leg3 , y_axis, 0, math.rad(35) )
	Turn( leg4 , y_axis, 0, math.rad(35) )
	
	Turn( leg1 , z_axis, 0, math.rad(25) )
	Turn( leg2 , z_axis, 0, math.rad(25) )
	Turn( leg3 , z_axis, 0, math.rad(25) )
	Turn( leg4 , z_axis, 0, math.rad(25) )
	
	-- preturn (makes sure the legs turn in the right direction)
	Turn(leg2 , x_axis, math.rad(90), math.rad(95))
	Turn(leg3 , x_axis, math.rad(90), math.rad(95))
	Turn(leg1 , x_axis, math.rad(-90), math.rad(95))
	Turn(leg4 , x_axis, math.rad(-90), math.rad(95))
	Sleep(100)
	Turn( leg1 , x_axis, 0, math.rad(95) )
	Turn( leg2 , x_axis, 0, math.rad(95) )
	Turn( leg3 , x_axis, 0, math.rad(95) )
	Turn( leg4 , x_axis, 0, math.rad(95) )
	Spring.SetUnitArmored(unitID,false)
end

local function Uncurl()
	if not bMoving then return end
	--Spring.Echo("Initiating uncurl")
	Signal( SIG_CURL) 
	SetSignalMask( SIG_CURL)
	bCurled = false
	bCurling = true
	
	ResetLegs()
	
	Move( canon , y_axis, 0 , 2.5 )
	Move( base , y_axis, 0 , 2.5 )
	Move( base , z_axis, 0 , 2.5 )
    
    WaitForTurn(leg1, x_axis)
    WaitForTurn(leg2, x_axis)
    WaitForTurn(leg3, x_axis)
    WaitForTurn(leg4, x_axis)
        
    WaitForTurn(leg1, y_axis)
    WaitForTurn(leg2, y_axis)
    WaitForTurn(leg3, y_axis)
    WaitForTurn(leg4, y_axis)
        
    WaitForTurn(leg1, z_axis)
    WaitForTurn(leg2, z_axis)
    WaitForTurn(leg3, z_axis)
    WaitForTurn(leg4, z_axis)    
	
    --SetUnitValue(COB.MAX_SPEED, base_speed)
    bCurling = false
end

local function BlinkingLight()
	while GetUnitValue(COB.BUILD_PERCENT_LEFT) do
		Sleep( 3000)
	end
	while true do
		EmitSfx( blight,  1024+2 )
		Sleep( 2100)
	end
end

local function CurlDelay()	--workaround for crabe getting stuck in fac
	while GetUnitValue(COB.BUILD_PERCENT_LEFT) > 0 do
		Sleep(330)
	end
	Sleep(2000)
	nocurl = false
end

function script.Create()
	base_speed = GetUnitValue(COB.MAX_SPEED)
	--set ARMORED to false
	Hide( flare1)
	Hide( flare2)
	Hide( flare3)
	Hide( flare4)
	Hide( flare5)
	Hide( flare6)
	Hide( flare7)
	
	--StartThread(MotionControl)
	StartThread(SmokeUnit)
	--StartThread(BlinkingLight)
	StartThread(CurlDelay)
end

local function Motion()
	Signal(SIG_MOVE)
	SetSignalMask(SIG_MOVE)
	bMoving = true
	Sleep(66)
	Uncurl()
	Walk()
end

function script.StartMoving()
	--Spring.Echo("Moving")
	StartThread(Motion)
end

function script.StopMoving()
	--Spring.Echo("Stopped moving")
	bMoving = false
	Signal(SIG_MOVE)
	StartThread(Curl)
end

local function Rock(anglex, anglez)	
	Turn( base , z_axis, -anglex, math.rad(50) )
	Turn( base , x_axis, anglez, math.rad(50) )
	WaitForTurn(base, z_axis)
	WaitForTurn(base, x_axis)
	Turn( base , z_axis, 0, math.rad(20) )
	Turn( base , x_axis, 0, math.rad(20) )
end
	
function script.RockUnit(anglex, anglez)
	StartThread(Rock, math.rad(anglex), math.rad(anglez))
end

local function RestoreAfterDelay1()
	Sleep( 3000)
	Turn( turret , y_axis, 0, math.rad(70) )
	Turn( canon , x_axis, 0, math.rad(50) )
end

local function RestoreAfterDelay2()
	Sleep( 3000)
	Turn( rocket , y_axis, 0, math.rad(70) )
	Turn( rocket , x_axis, 0, math.rad(50) )
end

function script.AimWeapon(num, heading, pitch)
	if num == 1 then
		Signal( SIG_AIM1)
		SetSignalMask( SIG_AIM1)
		Turn( turret , y_axis, heading, math.rad(70) )
		Turn( canon , x_axis, -pitch, math.rad(50) )
		WaitForTurn(turret, y_axis)
		WaitForTurn(canon, x_axis)
		StartThread(RestoreAfterDelay1)
		return (not bCurling)
	elseif num == 2 then
		Signal( SIG_AIM2)
		SetSignalMask( SIG_AIM2)
		Turn( rocket , y_axis, math.rad(heading ), math.rad(190) )
		Turn( rocket , x_axis, 0, math.rad(150) )
		WaitForTurn(rocket, y_axis)
		WaitForTurn(rocket, x_axis)
		StartThread(RestoreAfterDelay2)
		return true
	end
end

function script.FireWeapon(num)
	if num == 1 then
		Move( barrel1 , z_axis, -1.2  )
		EmitSfx( flare1,  1024+0 )	
		EmitSfx( gflash,  1024+1 )
		Move( barrel2 , z_axis, -1.2  )
		Sleep(150)
		Move( barrel1 , z_axis, 0 , 3 )
		Move( barrel2 , z_axis, 0 , 3 )
	elseif num == 2 then
		gun_0 = gun_0 + 1
		if gun_0 == 3 then
			gun_0 = 0
		end
	end
end

function script.AimFromWeapon(num)
	if num == 1 then return turret
	else return rocket end
end

function script.QueryWeapon(num)
	if num == 1 then return flare1
	else
		if gun_0 == 0 then return flare2 
		elseif gun_0 == 1 then return flare3 
		else return flare4 end
	end
end

function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage/maxHealth
	if severity <= .25  then
		Explode(base, sfxNone)
		return 1
	elseif (severity <= .50 ) then
		Explode(base, sfxNone)
		Explode(leg1, sfxNone)
		Explode(leg2, sfxNone)
		Explode(leg3, sfxNone)
		Explode(leg4, sfxNone)
		return 1
	elseif (severity <= .99 ) then
		Explode(base, sfxShatter)
		Explode(leg1, sfxShatter)
		Explode(leg2, sfxShatter)
		Explode(leg3, sfxShatter)
		Explode(leg4, sfxShatter)
		Explode(turret, sfxFall + sfxSmoke + sfxFire + sfxExplode)
		return 2
	else
		Explode(base, sfxShatter)
		Explode(leg1, sfxShatter)
		Explode(leg2, sfxShatter)
		Explode(leg3, sfxShatter)
		Explode(leg4, sfxShatter)
		Explode(turret, sfxFall + sfxSmoke + sfxFire + sfxExplode)
		Explode(canon, sfxFall + sfxSmoke + sfxFire)
		return 2
	end
end
