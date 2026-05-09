-- IslandGenerator
-- Generates rough terrain masses for the island calibration prototype.
-- No gameplay systems. Shapes only.

local Terrain = workspace.Terrain

local GRASS = Enum.Material.Grass
local ROCK = Enum.Material.Rock
local SAND = Enum.Material.Sand
local WATER = Enum.Material.Water
local WOOD = Enum.Material.WoodPlanks
local LEAFY = Enum.Material.LeafyGrass

local function fillBlock(position, size, material)
	Terrain:FillBlock(CFrame.new(position), size, material)
end

local function fillBall(position, radius, material)
	Terrain:FillBall(position, radius, material)
end

print("[IslandGenerator] Starting island generation...")

print("[IslandGenerator] Clearing existing terrain...")
Terrain:Clear()

-- Central hub: low grass mound centered on origin.
print("[IslandGenerator] Generating central hub...")
fillBall(Vector3.new(0, 4, 0), 95, GRASS)
fillBall(Vector3.new(0, 14, 0), 60, GRASS)

-- World tree placeholder: trunk + canopy ball over the hub.
print("[IslandGenerator] Placing world tree placeholder...")
fillBlock(Vector3.new(0, 95, 0), Vector3.new(28, 170, 28), WOOD)
fillBall(Vector3.new(0, 190, 0), 70, LEAFY)

-- North: elevated rock cliffs.
print("[IslandGenerator] Generating north cliffs...")
fillBlock(Vector3.new(0, 35, -180), Vector3.new(240, 90, 90), ROCK)
fillBall(Vector3.new(-70, 65, -215), 45, ROCK)
fillBall(Vector3.new(80, 60, -225), 50, ROCK)

-- East: low sandy shoreline with water just past the baseplate edge.
print("[IslandGenerator] Generating east shoreline...")
fillBlock(Vector3.new(185, 2, 0), Vector3.new(150, 12, 250), SAND)
fillBall(Vector3.new(235, 0, 70), 55, SAND)
fillBall(Vector3.new(235, 0, -70), 55, SAND)
fillBlock(Vector3.new(330, -2, 0), Vector3.new(80, 14, 280), WATER)

-- South: enclosed grass shelf with dense leafy mounds.
print("[IslandGenerator] Generating south enclosed terrain...")
fillBlock(Vector3.new(0, 8, 185), Vector3.new(230, 32, 90), GRASS)
fillBall(Vector3.new(-55, 32, 220), 55, LEAFY)
fillBall(Vector3.new(45, 32, 230), 60, LEAFY)
fillBall(Vector3.new(0, 38, 255), 52, LEAFY)

-- West: broken/uneven rock terrain.
print("[IslandGenerator] Generating west broken terrain...")
fillBlock(Vector3.new(-185, 14, 0), Vector3.new(120, 44, 200), ROCK)
fillBall(Vector3.new(-225, 18, 45), 48, ROCK)
fillBall(Vector3.new(-235, 6, -55), 42, ROCK)
fillBall(Vector3.new(-205, 36, -10), 35, ROCK)

print("[IslandGenerator] Island generation complete.")
