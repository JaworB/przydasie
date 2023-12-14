-- Name : Caucasus
-- Date : 16/10/2022

--[[
----------------------------------------------------
-- Settings                                    ---
----------------------------------------------------

GLOBAL SETTINGS

soloSize 		= number of AI to spawn in solo training
maxGroupSize	= maximum number of AI to spawn (RELATIVE to the number of blues alive in the group). Minimum size for group is 2. Ex : If 2 blue alive in the group and maxGroupSize=1, between 2 and 3 AI can spawn 
interceptSize	= number of AI to spawn in intercept
dogfightSize	= number of AI to spawn in dogfight
skillLevel		= level of AI.


SPECIFIC SETTINGS (defined for each categorie)

minRange 		= minimal distance at which the AI can spawn (in Nm)
maxRange 		= maximal distance at which the AI can spawn (in Nm)

bearingOffset 	= relative bearing span in which the AI can spawn compared to current heading. Ex : for a blue heading due north, 30 means the AI will spawn in a bearing between 330° and 030°

minAltitudeOffset 	= minimum altitude at which the AI can spawn (in ft) RELATIVE to the blue. Script will ensure the plane spawns at least 1500 ft above current ground level.
maxAltitudeOffset 	= maximum altitude at which the AI can spawn (in ft) RELATIVE to the blue. Spawn altitude is maxed at 30 000 ft to avoid stalls at spawn
			Example : minAltitude=-1000, maxAltitude=3000, blue is at 10 000 ft : AI will spawn at altitude between 8000 and 13 000 ft
	
aspectAngle 	= (only for intercept) angle between your aircraft nose and the AI nose in degres. 180 : the AI is facing you (HOT), 0 : the AI is COLD
aspectAngleOffset = (only for intercept) span of aspect angle relative to the medium value. Ex : if AspectAngle = 180 and AspectAngleSpan=20, the AI will spawn with an aspect angle between 160 and 200.



--]]
local soloSize=1			--Default = 1
local maxGroupSize=1		--Default = 1
local interceptSize=1		--Default = 1
local dogfightSize=1		--Default = 1
local skillLevel="Ace"		--Default = "Ace"  can be :"Ace", "Veteran", "Trained", "Rookie" (equivalent to resp : Excellent, High, Good, Average in the ME)


local settings={}

settings["Fox1_Old"]={
		minRange= 35, 				-- in Nm. Default = 30
		maxRange=50,				-- in Nm. Default = 50
		bearingOffset= 30,			--in degres. Default = 30
		minAltitudeOffset=	-10000,	--in ft. Default = -10 000
		maxAltitudeOffset=	10000}	--in ft. Default = 10 000

settings["Fox1_Modern"]={
		minRange= 35, 				-- in Nm. Default = 30
		maxRange=50,				-- in Nm. Default = 50
		bearingOffset= 30,			--in degres. Default = 30
		minAltitudeOffset=	-10000,	--in ft. Default = -10 000
		maxAltitudeOffset=	10000}	--in ft. Default = 10 000
		
settings["Fox2_Old"]={
		minRange= 25, 				-- in Nm. Default = 25
		maxRange=40,				-- in Nm. Default = 40
		bearingOffset= 30,			--in degres. Default = 30
		minAltitudeOffset=	-10000,	--in ft. Default = -10 000
		maxAltitudeOffset=	10000}	--in ft. Default = 10 000
		
settings["Fox2_Modern"]={
		minRange= 25, 				-- in Nm. Default = 25
		maxRange=40,				-- in Nm. Default = 40
		bearingOffset= 30,			--in degres. Default = 30
		minAltitudeOffset=	-10000,	--in ft. Default = -10 000
		maxAltitudeOffset=	10000}	--in ft. Default = 10 000
		
settings["Fox3"]={
		minRange= 35, 				-- in Nm. Default = 35
		maxRange=60,				-- in Nm. Default = 60
		bearingOffset= 30,			--in degres. Default = 30
		minAltitudeOffset=	-10000,	--in ft. Default = -10 000
		maxAltitudeOffset=	10000}	--in ft. Default = 10 000
		
settings["Intercept_Practice"]={
		minRange= 60,				-- in Nm  Default = 35
		maxRange=60,				-- in Nm  Default = 60
		bearingOffset= 0,			--in degres  Default = 0
		minAltitudeOffset=	0,		--in ft  Default = 0
		maxAltitudeOffset=	0,		--in ft  Default = 0
		aspectAngle=180,			--in degres  Default=180
		aspectAngleOffset=0}		--in degres Default=0

settings["Intercept_Training"]={
		minRange= 50,				-- in Nm. Default = 35
		maxRange=80,				-- in Nm. Default = 60
		bearingOffset= 30,			--in degres. Default = 0
		minAltitudeOffset=	-10000,	--in ft. Default = -1000
		maxAltitudeOffset=	10000,	--in ft. Default = 1000
		aspectAngle=180,			--in degres. Default=180
		aspectAngleOffset=40}		--in degres.Default=40

settings["Intercept_Test"]={
		minRange= 50,				-- in Nm. Default = 35
		maxRange=80,				-- in Nm. Default = 60
		bearingOffset= 30,			--in degres. Default = 0
		minAltitudeOffset=	-10000,	--in ft. Default = -1000
		maxAltitudeOffset=	10000,	--in ft. Default = 1000
		aspectAngle=180,			--in degres. Default=180
		aspectAngleOffset=40}		--in degres.Default=40
		
settings["Dogfight_Defensive"]={
		minRange= 2, 				-- in Nm. Default = 2
		maxRange= 5,				--in Nm. Default = 5
		bearingOffset= 60,			--in degres. Default = 60
		minAltitudeOffset=	-5000,	--in ft. Default = -5000
		maxAltitudeOffset=	5000}	--in ft. Default = 5000

settings["Dogfight_Head-on"]={
		minRange= 10, 				-- in Nm. Default = 10
		maxRange= 15,				--in Nm. Default = 15
		bearingOffset= 0,			--in degres. Default = 0
		minAltitudeOffset=	-1000,	--in ft. Default = -1000
		maxAltitudeOffset=	1000}	--in ft. Default = 1000


local SpawnedUnits={}
local Tasks = {}
local EPLRS=false


--Remove all units created by the script
function ClearTraining()
	AIGroups=SET_GROUP:New():FilterPrefixes("RED_AI_"):FilterStart()
	AIGroups:ForEachGroup(
		function ( MooseGroup )
			MooseGroup:Destroy()
		end
	)
	MESSAGE:New("AA Training : all RED units have been removed", 10):ToAll()
end

local template={}
template["Fox1_Old"]={}
template["Fox1_Modern"]={}
template["Fox2_Old"]={}
template["Fox2_Modern"]={}
template["Fox3"]={}
template["Intercept_Training"]={}
template["Intercept_Test"]={}
template["Intercept_Practice"]={}
template["Dogfight"]={}

local groupMenu={}

function RandomInList(list)
	local length=#list
	local i=math.random(1,length)
	return list[i]
end

function gaussian (mean, variance)
    return  math.sqrt(-2 * variance * math.log(math.random())) *
            math.cos(2 * math.pi * math.random()) + mean
end

function InitializeTemplates()
	local templateGroups=SET_GROUP:New():FilterCoalitions("red"):FilterStart()
	local zone_Fox1_Old=ZONE:FindByName("Fox1_Old")
	local zone_Fox1_Modern=ZONE:FindByName("Fox1_Modern")
	local zone_Fox2_Old=ZONE:FindByName("Fox2_Old")
	local zone_Fox2_Modern=ZONE:FindByName("Fox2_Modern")
	local zone_Fox3=ZONE:FindByName("Fox3")
	local zone_Inter_Training=ZONE:FindByName("Intercept_Training")
	local zone_Inter_Test=ZONE:FindByName("Intercept_Test")
	local zone_Inter_Practice=ZONE:FindByName("Intercept_Practice")
	local zone_Dogfight=ZONE:FindByName("Dogfight")

	templateGroups:ForEachGroup(
		function(currentGroup)
			local name=currentGroup:GetName()
			local tempSpawn=SPAWN:New(name)
							:OnSpawnGroup( 
								function( spawnGroup )
									local spawnName=spawnGroup:GetName()
									-- MESSAGE:New(spawnName.." spawned", 5):ToAll()
									if spawnGroup:IsInZone(zone_Fox1_Old) then
										table.insert(template["Fox1_Old"],name)
									elseif spawnGroup:IsInZone(zone_Fox1_Modern) then
										table.insert(template["Fox1_Modern"],name)
									elseif spawnGroup:IsInZone(zone_Fox2_Old) then
										table.insert(template["Fox2_Old"],name)
									elseif spawnGroup:IsInZone(zone_Fox2_Modern) then
										table.insert(template["Fox2_Modern"],name)
									elseif spawnGroup:IsInZone(zone_Fox3) then
										table.insert(template["Fox3"],name)
									elseif spawnGroup:IsInZone(zone_Inter_Training) then
										table.insert(template["Intercept_Training"],name)
									elseif spawnGroup:IsInZone(zone_Inter_Test) then
										table.insert(template["Intercept_Test"],name)
									elseif spawnGroup:IsInZone(zone_Inter_Practice) then
										table.insert(template["Intercept_Practice"],name)
									elseif spawnGroup:IsInZone(zone_Dogfight) then
										table.insert(template["Dogfight"],name)
									end
									spawnGroup:Destroy()
								end
                             )
							:Spawn()
		end
	)

end


--Event that check when a client spawn in an aircraft.
ClientSet = SET_CLIENT:New():FilterOnce()

function SetEventHandler()
    ClientBirth = ClientSet:HandleEvent(EVENTS.PlayerEnterAircraft)
end

function ClientSet:OnEventPlayerEnterAircraft(event_data)
    local currentGroup = event_data.IniGroup
	local groupName=currentGroup:GetName()
    local playerName = event_data.IniPlayerName
	if groupMenu[groupName] then
		PurgeMenus(currentGroup)
	end
	-- MESSAGE:New("Menus spawn "..currentGroup:GetName()):ToAll()
	InitializeMenus(currentGroup)
end


--when the client spawns, adds the radio menus to the group
function InitializeMenus(currentGroup)

	local groupName=currentGroup.GroupName
	groupMenu[groupName]={}
	groupMenu[groupName].MenuTrainingSolo=MENU_GROUP:New(currentGroup,"Solo Training")
	groupMenu[groupName].SubMenu_BVR_F1_old = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox1 old", groupMenu[groupName].MenuTrainingSolo, BVR,{group=currentGroup,size="solo",opponent="Fox1_Old"})
	groupMenu[groupName].SubMenu_BVR_F1_modern = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox1 modern", groupMenu[groupName].MenuTrainingSolo, BVR,{group=currentGroup,size="solo",opponent="Fox1_Modern"})
	groupMenu[groupName].SubMenu_BVR_F2_old = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox2 old", groupMenu[groupName].MenuTrainingSolo, BVR,{group=currentGroup,size="solo",opponent="Fox2_Old"})
	groupMenu[groupName].SubMenu_BVR_F2_modern = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox2 modern", groupMenu[groupName].MenuTrainingSolo, BVR,{group=currentGroup,size="solo",opponent="Fox2_Modern"})
	groupMenu[groupName].SubMenu_BVR_F3 = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox3", groupMenu[groupName].MenuTrainingSolo, BVR,{group=currentGroup,size="solo",opponent="Fox3"})
	
	groupMenu[groupName].MenuTrainingGroup=MENU_GROUP:New(currentGroup,"Group Training")
	groupMenu[groupName].SubMenu_Group_F1_old = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox1 old", groupMenu[groupName].MenuTrainingGroup, BVR,{group=currentGroup,size="group",opponent="Fox1_Old"})
	groupMenu[groupName].SubMenu_Group_F1_modern = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox1 modern", groupMenu[groupName].MenuTrainingGroup, BVR,{group=currentGroup,size="group",opponent="Fox1_Modern"})
	groupMenu[groupName].SubMenu_Group_F2_old = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox2 old", groupMenu[groupName].MenuTrainingGroup, BVR,{group=currentGroup,size="group",opponent="Fox2_Old"})
	groupMenu[groupName].SubMenu_Group_F2_modern = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox2 modern", groupMenu[groupName].MenuTrainingGroup, BVR,{group=currentGroup,size="group",opponent="Fox2_Modern"})
	groupMenu[groupName].SubMenu_Group_F3 = MENU_GROUP_COMMAND:New (currentGroup, "BVR Fox3", groupMenu[groupName].MenuTrainingGroup, BVR,{group=currentGroup,size="group",opponent="Fox3"})
	
	groupMenu[groupName].MenuTrainingIntercept=MENU_GROUP:New(currentGroup,"Intercept")
	groupMenu[groupName].SubMenu_Intercept_Training = MENU_GROUP_COMMAND:New (currentGroup, "Training", groupMenu[groupName].MenuTrainingIntercept, Intercept,{group=currentGroup,size="solo",opponent="Intercept_Training"})
	groupMenu[groupName].SubMenu_Intercept_Test = MENU_GROUP_COMMAND:New (currentGroup, "Test", groupMenu[groupName].MenuTrainingIntercept, Intercept,{group=currentGroup,size="solo",opponent="Intercept_Test"})
	groupMenu[groupName].SubMenu_Intercept_Passive = MENU_GROUP_COMMAND:New (currentGroup, "Practice", groupMenu[groupName].MenuTrainingIntercept, Intercept,{group=currentGroup,size="solo",opponent="Intercept_Practice"})

	groupMenu[groupName].MenuTrainingDogfight=MENU_GROUP:New(currentGroup,"Dogfight")
	groupMenu[groupName].SubMenu_Dogfight_Headon = MENU_GROUP_COMMAND:New (currentGroup, "Head-on", groupMenu[groupName].MenuTrainingDogfight, Dogfight,{group=currentGroup,size="solo",opponent="Dogfight_Head-on"})
	groupMenu[groupName].SubMenu_Dogfight_Defensive = MENU_GROUP_COMMAND:New (currentGroup, "Defensive", groupMenu[groupName].MenuTrainingDogfight, Dogfight,{group=currentGroup,size="solo",opponent="Dogfight_Defensive"})
	
	groupMenu[groupName].MenuEPLRS=MENU_GROUP_COMMAND:New(currentGroup,"Turn EPLRS ON/OFF",nil, SwitchEPLRS)
	
	groupMenu[groupName].MenuClean=MENU_GROUP_COMMAND:New(currentGroup,"Clear units",nil,ClearTraining)

	groupMenu[groupName].MenuClean=MENU_GROUP_COMMAND:New(currentGroup,"Test Spawn tanker MPRS",nil,SpawnTanker)

end

function PurgeMenus(currentGroup)
	groupMenu[currentGroup].MenuTrainingSolo:Remove()
	groupMenu[groupName].MenuTrainingGroup:Remove()
	groupMenu[groupName].MenuTrainingIntercept:Remove()
	groupMenu[groupName].MenuTrainingDogfight:Remove()
	groupMenu[groupName].MenuEPLRS:Remove()
	groupMenu[groupName].MenuClean:Remove()
end


function Intercept(parameters)
	local currentSettings=settings[parameters.opponent]
	local name=RandomInList(template[parameters.opponent])
	
	--Set Spawn point and heading
	local spawnRange=math.random(currentSettings.minRange,currentSettings.maxRange)*1852

	local blueHeading=parameters.group:GetHeading()	
	local spawnBearing=gaussian(blueHeading,currentSettings.bearingOffset^2)%360
	local blueCoord=parameters.group:GetCoordinate()
	local spawnPoint=blueCoord:Translate(spawnRange,spawnBearing)
	
	--Set Altitude
	local minAlt=math.max(spawnPoint:GetLandHeight()+500,parameters.group:GetAltitude()+currentSettings.minAltitudeOffset)
	local maxAlt=math.min(parameters.group:GetAltitude()+currentSettings.maxAltitudeOffset,30000*0.3048)
	spawnPoint:SetAltitude(math.random(minAlt,maxAlt), true)

	local spawnHeading=(blueHeading+currentSettings.aspectAngle+math.random(-currentSettings.aspectAngleOffset,currentSettings.aspectAngleOffset))%360 

	--Set group Size
	local spawnSize=currentSettings.interceptSize
		
	local trainingSpawn=SPAWN:NewWithAlias(name,"RED_AI_"..#SpawnedUnits)
					:InitHeading(spawnHeading)
					:InitGrouping(spawnSize)
					:InitSkill(skillLevel)
					:InitAIOff()
					:SpawnFromVec3(spawnPoint)
					
	--behavior
	trainingSpawn:OptionROTEvadeFire()
	trainingSpawn:OptionROEHoldFire()
					
	--building route
	local speed=math.min(trainingSpawn:GetSpeedMax(),810) --810 km/h = mach 0.8
	local coord1=spawnPoint:Translate(spawnRange,spawnHeading,true)
	local wpt1=blueCoord:WaypointAirFlyOverPoint(COORDINATE.WaypointAltType.BARO, speed)

	--make the plane follow the route
	trainingSpawn:Route({wpt1},2)
	table.insert(SpawnedUnits,trainingSpawn)
end

function Dogfight(parameters) 	--Spawn an ennemi at close range, guns only
	local currentSettings=settings[parameters.opponent]
	local name=RandomInList(template["Dogfight"])

	--Set Spawn point and heading
	local spawnRange=math.random(currentSettings.minRange,currentSettings.maxRange)*1852

	local blueHeading=parameters.group:GetHeading()	
	local spawnBearing=gaussian(blueHeading,currentSettings.bearingOffset^2)%360

	
	if parameters.opponent=="Dogfight_Defensive" then 		--if defensive, AI spawns relative to blue's tail
		spawnBearing=(spawnBearing+180)%360
	end
	
	local blueCoord=parameters.group:GetCoordinate()
	local spawnPoint=blueCoord:Translate(spawnRange,spawnBearing)

	--Set Altitude
	local minAlt=math.max(spawnPoint:GetLandHeight()+500,parameters.group:GetAltitude()+currentSettings.minAltitudeOffset)
	local maxAlt=math.min(parameters.group:GetAltitude()+currentSettings.maxAltitudeOffset,30000*0.3048)
	spawnPoint:SetAltitude(math.random(minAlt,maxAlt), true)
	
	local trainingSpawn=SPAWN:NewWithAlias(name,"RED_AI_"..#SpawnedUnits)
					:InitHeading((spawnBearing+180)%360 )
					:InitGrouping(dogfightSize)
					:InitSkill(skillLevel)
					:SpawnFromVec3(spawnPoint)
					:OptionROEWeaponFree()
					
		--building route
	--make the plane follow the route
	local speed=math.min(trainingSpawn:GetSpeedMax(),810)
	local wpt1=blueCoord:WaypointAirFlyOverPoint(COORDINATE.WaypointAltType.BARO, speed)
	trainingSpawn:Route({wpt1},2)
	table.insert(SpawnedUnits,trainingSpawn)

end

function BVR(parameters)
	local currentSettings=settings[parameters.opponent]
	local name=RandomInList(template[parameters.opponent])
	-- MESSAGE:New("opponent "..parameters.opponent):ToAll()
	--Set Spawn point and heading
	local spawnRange=math.random(currentSettings.minRange,currentSettings.maxRange)*1852

	local blueHeading=parameters.group:GetHeading()	
	local spawnBearing=gaussian(blueHeading,currentSettings.bearingOffset^2)%360
	
	local blueCoord=parameters.group:GetCoordinate()
	local spawnPoint=blueCoord:Translate(spawnRange,spawnBearing)

	--Set Altitude
	local minAlt=math.max(spawnPoint:GetLandHeight()+500,parameters.group:GetAltitude()+currentSettings.minAltitudeOffset)
	local maxAlt=math.min(parameters.group:GetAltitude()+currentSettings.maxAltitudeOffset,30000*0.3048)
	spawnPoint:SetAltitude(math.random(minAlt,maxAlt), true)
	
	local spawnHeading=(spawnBearing+180)%360

	if parameters.size=="solo" then
		spawnSize=soloSize
	elseif parameters.size=="group" then
		spawnSize=math.random(2,parameters.group:GetSize()+maxGroupSize)
	end
	
	--spawn unit
	local trainingSpawn=SPAWN:NewWithAlias(name,"RED_AI_"..#SpawnedUnits)
					:InitHeading((spawnBearing+180)%360 )
					:InitGrouping(spawnSize)
					:InitSkill(skillLevel)
					:SpawnFromVec3(spawnPoint)
					:OptionROEWeaponFree()
					
	--building route
	local speed=math.min(trainingSpawn:GetSpeedMax(),810) --810 km/h = mach 0.8
	local wpt1=blueCoord:WaypointAirFlyOverPoint(COORDINATE.WaypointAltType.BARO, speed)

	--make the plane follow the route
	trainingSpawn:Route({wpt1},2)
				 :EnRouteTaskEngageTargets(60, TargetTypes, 0)
	table.insert(SpawnedUnits,trainingSpawn)
	
end


function SwitchEPLRS()
	local AWACS= GROUP:FindByName( "Magic#001" )
	EPLRS=not EPLRS
	AWACS:CommandEPLRS(EPLRS)
	if EPLRS then 
		MESSAGE:New("EPLRS ON"):ToAll()
		AWACS:CommandEPLRS(EPLRS)
	else
		local spawnAwacs=SPAWN:New("Magic")
		:Spawn()
	end
end

function SpawnTanker()
	local spawnTanker=SPAWN:New("Texaco")

MESSAGE:New("Script loaded v1.2", 5):ToAll()
InitializeTemplates()
local spawnAwacs=SPAWN:New("Magic")
		:Spawn()
--create the menu for the players already spawned
local clientList=SET_CLIENT:New():FilterCoalitions("blue"):FilterOnce()
	clientList:ForEachClient(
		function(currentClient)
			local clientGroup=currentClient:GetGroup()
			if clientGroup~=nil and groupMenu[groupName]==nil then
				InitializeMenus(clientGroup)
				MESSAGE:New("Menus initialized"):ToGroup(clientGroup)
			end
		end
	)


SetEventHandler()


