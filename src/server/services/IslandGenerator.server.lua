-- IslandGenerator
-- Builds one cohesive Zelda-like island using rotated FillBlock
-- terraces (planar/angular shape language) instead of overlapping
-- FillBalls (round/blobby). Composition is asymmetric and
-- directional: low coast on the SE, rising terraces toward the
-- NW where the summit sits. Hand-placed, no procedural noise.

local Terrain = workspace.Terrain

local GRASS = Enum.Material.Grass
local ROCK  = Enum.Material.Rock
local SAND  = Enum.Material.Sand
local WATER = Enum.Material.Water
local AIR   = Enum.Material.Air

local function fillBlock(position, size, material)
	Terrain:FillBlock(CFrame.new(position), size, material)
end

local function fillBlockCFrame(cframe, size, material)
	Terrain:FillBlock(cframe, size, material)
end

local function fillBall(position, radius, material)
	Terrain:FillBall(position, radius, material)
end

-- Air-cut everything strictly above yLevel across the build region.
-- Region must stay under Roblox's ~4M voxel-per-FillBlock cap.
local function clearAbove(yLevel)
	local size = Vector3.new(600, 200, 600)
	fillBlock(Vector3.new(0, yLevel + size.Y / 2, 0), size, AIR)
end

-- Tier elevations
local WATER_Y       = 0
local CLIFF_TOP     = 45
local PLATEAU_TOP   = 50
local MID_LOW_TOP   = 62    -- lower middle terrace
local MID_TOP       = 78    -- upper middle terrace
local PEDESTAL_TOP  = 84    -- rock cliff under summit
local UPPER_TOP     = 102   -- summit terrace

print("[IslandGenerator] Starting island generation...")
Terrain:Clear()

-- =========================================================
-- 1. Surrounding ocean
-- =========================================================
print("[IslandGenerator] Filling ocean...")
fillBlock(
	Vector3.new(0, WATER_Y - 11, 0),
	Vector3.new(1400, 22, 1400),
	WATER
)

-- =========================================================
-- 2. Rock cliff foundation -- two rotated FillBlocks at different
-- angles overlapping to form an asymmetric polygonal landmass.
-- The block edges create natural inlets and protrusions where
-- they meet at angles. NW-SE elongation gives the directional
-- bias the composition needs.
-- =========================================================
print("[IslandGenerator] Building rock cliff foundation...")

local mainRockCF = CFrame.new(Vector3.new(-20, 7.5, -10))
	* CFrame.Angles(0, math.rad(-30), 0)
fillBlockCFrame(mainRockCF, Vector3.new(360, 75, 200), ROCK)

local secRockCF = CFrame.new(Vector3.new(20, 7.5, 30))
	* CFrame.Angles(0, math.rad(15), 0)
fillBlockCFrame(secRockCF, Vector3.new(280, 75, 180), ROCK)

clearAbove(CLIFF_TOP)

-- =========================================================
-- 3. Carve coastline inlets at two strategic points -- creates
-- bays for beaches and breaks the polygon's straight edges.
-- =========================================================
print("[IslandGenerator] Carving inlets...")
fillBall(Vector3.new(-10, 12, 145), 38, AIR)  -- DEEP south cove
fillBall(Vector3.new(180, 8, -25), 26, AIR)   -- east inlet

-- =========================================================
-- 4. Rock fins -- structural protrusions jutting from the cliff
-- face, all on the heavy NW side. The light SE side stays clean.
-- =========================================================
print("[IslandGenerator] Adding rock fins...")
local function rockFin(x, z, outwardX, outwardZ, width, depth, heightFrac)
	local outward = Vector3.new(outwardX, 0, outwardZ).Unit
	local center = Vector3.new(x, CLIFF_TOP / 2, z)
	local cf = CFrame.lookAt(center, center + outward)
	local height = (heightFrac or 0.95) * CLIFF_TOP - 2
	fillBlockCFrame(cf, Vector3.new(width, height, depth), ROCK)
end

rockFin(-200, -130, -0.7, -0.7, 14, 32, 0.95)  -- NW (HEAVY)
rockFin(-235,  -45, -1.0, -0.2, 16, 36, 0.95)  -- W-NW (HEAVY)
rockFin(-160, -180, -0.4, -1.0, 14, 30, 0.85)  -- N (HEAVY)
rockFin(-225,   80, -1.0,  0.2, 12, 28, 0.80)  -- W

-- =========================================================
-- 5. Grass plateau cap -- two rotated FillBlocks matching the
-- rock blocks but inset 5 studs per side. Leaves a visible rocky
-- cliff lip around the perimeter when viewed from above.
-- =========================================================
print("[IslandGenerator] Capping with grass plateau...")
local mainPlateauCF = CFrame.new(
	Vector3.new(-20, (CLIFF_TOP + PLATEAU_TOP) / 2, -10)
) * CFrame.Angles(0, math.rad(-30), 0)
fillBlockCFrame(
	mainPlateauCF,
	Vector3.new(350, PLATEAU_TOP - CLIFF_TOP + 4, 190),
	GRASS
)

local secPlateauCF = CFrame.new(
	Vector3.new(20, (CLIFF_TOP + PLATEAU_TOP) / 2, 30)
) * CFrame.Angles(0, math.rad(15), 0)
fillBlockCFrame(
	secPlateauCF,
	Vector3.new(270, PLATEAU_TOP - CLIFF_TOP + 4, 170),
	GRASS
)

clearAbove(PLATEAU_TOP)

-- =========================================================
-- 6. Lower middle terrace -- rotated grass slab, offset NW from
-- the plateau center. First step of the directional uplift.
-- =========================================================
print("[IslandGenerator] Building lower middle terrace...")
local midLowCF = CFrame.new(
	Vector3.new(-55, (PLATEAU_TOP + MID_LOW_TOP) / 2, -55)
) * CFrame.Angles(0, math.rad(-30), 0)
fillBlockCFrame(
	midLowCF,
	Vector3.new(195, MID_LOW_TOP - PLATEAU_TOP + 6, 135),
	GRASS
)

clearAbove(MID_LOW_TOP)

-- =========================================================
-- 7. Upper middle terrace -- smaller, offset further NW. Second
-- step of the directional uplift toward the summit.
-- =========================================================
print("[IslandGenerator] Building upper middle terrace...")
local midHighCF = CFrame.new(
	Vector3.new(-90, (MID_LOW_TOP + MID_TOP) / 2, -90)
) * CFrame.Angles(0, math.rad(-30), 0)
fillBlockCFrame(
	midHighCF,
	Vector3.new(150, MID_TOP - MID_LOW_TOP + 6, 105),
	GRASS
)

clearAbove(MID_TOP)

-- =========================================================
-- 8. Summit rock pedestal -- rotated rock block sitting at the
-- NW high point. Cliff support beneath the summit grass.
-- =========================================================
print("[IslandGenerator] Building summit rock pedestal...")
local pedestalCF = CFrame.new(
	Vector3.new(-115, (MID_TOP + PEDESTAL_TOP) / 2, -115)
) * CFrame.Angles(0, math.rad(-30), 0)
fillBlockCFrame(
	pedestalCF,
	Vector3.new(120, PEDESTAL_TOP - MID_TOP + 6, 90),
	ROCK
)

clearAbove(PEDESTAL_TOP)

-- =========================================================
-- 9. Summit grass -- two rotated grass blocks at slightly
-- different angles for an irregular oblong terrace. Broader
-- than the pedestal so grass overhangs the rock (uplifted-land
-- reading, not a placed platform). Asymmetric, NW-biased.
-- =========================================================
print("[IslandGenerator] Building summit terrace...")
local summitMainCF = CFrame.new(
	Vector3.new(-115, (PEDESTAL_TOP + UPPER_TOP) / 2, -115)
) * CFrame.Angles(0, math.rad(-30), 0)
fillBlockCFrame(
	summitMainCF,
	Vector3.new(135, UPPER_TOP - PEDESTAL_TOP + 6, 100),
	GRASS
)

local summitSpurCF = CFrame.new(
	Vector3.new(-100, (PEDESTAL_TOP + UPPER_TOP) / 2, -135)
) * CFrame.Angles(0, math.rad(-15), 0)
fillBlockCFrame(
	summitSpurCF,
	Vector3.new(85, UPPER_TOP - PEDESTAL_TOP + 6, 60),
	GRASS
)

clearAbove(UPPER_TOP)

-- =========================================================
-- 10. Plateau rock outcrops -- 3 small bedrock formations on
-- the heavy NW plateau area. Selective articulation only.
-- =========================================================
print("[IslandGenerator] Adding NW rock outcrops...")
local function rockOutcrop(x, z, sizeX, sizeZ, heightAbove, angleDeg)
	local centerY = PLATEAU_TOP + heightAbove / 2 - 2
	local sizeY = heightAbove + 4
	local cf = CFrame.new(Vector3.new(x, centerY, z))
		* CFrame.Angles(0, math.rad(angleDeg), 0)
	fillBlockCFrame(cf, Vector3.new(sizeX, sizeY, sizeZ), ROCK)
end

rockOutcrop(-180,  -55, 28, 12, 9,  35)
rockOutcrop(-145,    5, 18, 10, 7, -25)
rockOutcrop(-115,  -85, 16,  9, 6,  50)

-- =========================================================
-- 11. NW rock peak -- one tall rock formation on the NW corner.
-- The single dominant rock anchor of the heavy side.
-- =========================================================
print("[IslandGenerator] Adding NW rock peak...")
fillBall(Vector3.new(-220, PLATEAU_TOP, -150), 22, ROCK)
fillBall(Vector3.new(-205, PLATEAU_TOP - 4, -170), 16, ROCK)

-- =========================================================
-- 12. Traversal ramps: plateau -> midLow -> midHigh -> summit.
-- Each ramp segment is angled NW so the climb implies a single
-- continuous ascent direction.
-- =========================================================
print("[IslandGenerator] Carving traversal ramps...")
local function ramp(fromPos, toPos, width, thickness)
	local mid = (fromPos + toPos) / 2
	local len = (toPos - fromPos).Magnitude
	local cframe = CFrame.lookAt(mid, toPos)
	fillBlockCFrame(cframe, Vector3.new(width, thickness, len), GRASS)
end

ramp(
	Vector3.new(  20, PLATEAU_TOP   - 5,  20),
	Vector3.new( -25, MID_LOW_TOP   - 5, -25),
	28, 10
)
ramp(
	Vector3.new( -55, MID_LOW_TOP - 5, -55),
	Vector3.new( -90, MID_TOP     - 5, -90),
	24, 10
)
ramp(
	Vector3.new(-100, MID_TOP   - 5, -90),
	Vector3.new(-115, UPPER_TOP - 5,-115),
	20, 10
)

-- =========================================================
-- 13. Beaches -- elongated multi-ball formations following the
-- coastline curves at three pockets along the lighter S/SE side.
-- =========================================================
print("[IslandGenerator] Adding beaches...")
local function beach(x, z, length, dirX, dirZ, ballRadius, depth)
	local dir = Vector3.new(dirX, 0, dirZ).Unit
	local halfLen = length / 2
	local y = WATER_Y - (depth or 12)
	fillBall(Vector3.new(x, y, z) + dir * (-halfLen * 0.66), ballRadius, SAND)
	fillBall(Vector3.new(x, y, z),                            ballRadius * 1.1, SAND)
	fillBall(Vector3.new(x, y, z) + dir * ( halfLen * 0.66), ballRadius, SAND)
end

beach( -10, 150, 75,  1.0,  0.2, 26, 22)  -- DOMINANT south cove
beach( 180, -25, 50,  0.3, -1.0, 18, 14)  -- east inlet
beach( 110, 140, 40,  0.9, -0.4, 16, 12)  -- SE small (NE-SW diagonal)

print("[IslandGenerator] Island generation complete.")
