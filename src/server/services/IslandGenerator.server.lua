local Terrain = workspace.Terrain

local MATERIAL_GRASS = Enum.Material.Grass
local MATERIAL_ROCK = Enum.Material.Rock
local MATERIAL_SAND = Enum.Material.Sand
local MATERIAL_WATER = Enum.Material.Water
local MATERIAL_WOOD = Enum.Material.WoodPlanks
local MATERIAL_CANOPY = Enum.Material.LeafyGrass
local MATERIAL_AIR = Enum.Material.Air

local CENTER = Vector3.new(0, 0, 0)

local function fillBlock(position, size, material)
    Terrain:FillBlock(CFrame.new(position), size, material)
end

local function fillBall(position, radius, material)
    Terrain:FillBall(position, radius, material)
end

local function carveBlock(position, size)
    fillBlock(position, size, MATERIAL_AIR)
end

local function carveBall(position, radius)
    fillBall(position, radius, MATERIAL_AIR)
end

local function clearWorld()
    Terrain:Clear()
end

local function createOcean()
    fillBlock(Vector3.new(0, -32, 0), Vector3.new(700, 28, 700), MATERIAL_WATER)
end

local function createBaseIsland()
    fillBall(CENTER + Vector3.new(0, -22, 0), 150, MATERIAL_GRASS)
    fillBall(Vector3.new(0, -10, 0), 110, MATERIAL_GRASS)

    fillBall(Vector3.new(0, 6, 0), 85, MATERIAL_GRASS)
    fillBall(Vector3.new(0, 22, 0), 58, MATERIAL_GRASS)
    fillBall(Vector3.new(0, 36, 0), 34, MATERIAL_GRASS)

    fillBlock(Vector3.new(0, 18, -100), Vector3.new(145, 55, 75), MATERIAL_ROCK)
    fillBlock(Vector3.new(-45, 34, -130), Vector3.new(70, 68, 42), MATERIAL_ROCK)
    fillBlock(Vector3.new(48, 30, -125), Vector3.new(78, 58, 48), MATERIAL_ROCK)

    fillBlock(Vector3.new(105, -8, 5), Vector3.new(95, 20, 165), MATERIAL_SAND)
    fillBall(Vector3.new(140, -14, 12), 62, MATERIAL_SAND)

    fillBall(Vector3.new(-10, -2, 108), 82, MATERIAL_GRASS)
    fillBlock(Vector3.new(0, 5, 126), Vector3.new(145, 28, 72), MATERIAL_GRASS)

    fillBlock(Vector3.new(-110, 4, 0), Vector3.new(78, 34, 130), MATERIAL_ROCK)
    fillBall(Vector3.new(-142, -4, 38), 48, MATERIAL_ROCK)
    fillBall(Vector3.new(-135, -6, -48), 42, MATERIAL_ROCK)
end

local function carveLandmarks()
    carveBall(Vector3.new(0, 10, -108), 34)
    carveBlock(Vector3.new(0, 5, -138), Vector3.new(42, 22, 40))

    carveBall(Vector3.new(158, -9, 10), 45)
    fillBlock(Vector3.new(160, -25, 10), Vector3.new(85, 18, 105), MATERIAL_WATER)

    carveBall(Vector3.new(0, 26, -13), 10)
    carveBlock(Vector3.new(0, 16, -16), Vector3.new(13, 24, 10))

    carveBlock(Vector3.new(-110, 24, 0), Vector3.new(48, 22, 58))
end

local function createPaths()
    fillBlock(Vector3.new(78, 2, 0), Vector3.new(92, 5, 18), MATERIAL_SAND)
    fillBlock(Vector3.new(35, 9, 12), Vector3.new(70, 5, 16), MATERIAL_SAND)

    fillBlock(Vector3.new(34, 20, -22), Vector3.new(72, 8, 18), MATERIAL_GRASS)
    fillBlock(Vector3.new(-28, 30, 30), Vector3.new(68, 8, 18), MATERIAL_GRASS)

    fillBlock(Vector3.new(-70, 12, 4), Vector3.new(70, 5, 16), MATERIAL_ROCK)
end

local function createWorldTree()
    fillBlock(Vector3.new(0, 70, 0), Vector3.new(24, 140, 24), MATERIAL_WOOD)
    fillBall(Vector3.new(0, 26, 0), 28, MATERIAL_WOOD)

    fillBlock(Vector3.new(46, 15, 10), Vector3.new(95, 18, 16), MATERIAL_WOOD)
    fillBlock(Vector3.new(-46, 15, -10), Vector3.new(95, 18, 16), MATERIAL_WOOD)
    fillBlock(Vector3.new(10, 15, 46), Vector3.new(16, 18, 95), MATERIAL_WOOD)
    fillBlock(Vector3.new(-10, 15, -46), Vector3.new(16, 18, 95), MATERIAL_WOOD)

    fillBlock(Vector3.new(70, 8, 42), Vector3.new(90, 10, 12), MATERIAL_WOOD)
    fillBlock(Vector3.new(-72, 8, 38), Vector3.new(88, 10, 12), MATERIAL_WOOD)
    fillBlock(Vector3.new(42, 8, -72), Vector3.new(12, 10, 88), MATERIAL_WOOD)
    fillBlock(Vector3.new(-38, 8, -76), Vector3.new(12, 10, 86), MATERIAL_WOOD)

    fillBall(Vector3.new(0, 145, 0), 64, MATERIAL_CANOPY)
    fillBall(Vector3.new(42, 132, 15), 40, MATERIAL_CANOPY)
    fillBall(Vector3.new(-38, 138, -20), 44, MATERIAL_CANOPY)
    fillBall(Vector3.new(8, 165, -28), 38, MATERIAL_CANOPY)
    fillBall(Vector3.new(-12, 158, 34), 36, MATERIAL_CANOPY)
end

local function scatterDetails()
    for i = 1, 12 do
        local angle = math.rad(i * 37)
        local distance = 65 + (i % 6) * 14
        local x = math.cos(angle) * distance
        local z = math.sin(angle) * distance
        local y = -4 + (i % 5) * 3

        fillBall(Vector3.new(x, y, z), 6 + (i % 4) * 3, MATERIAL_ROCK)
    end

    fillBall(Vector3.new(210, -14, -55), 20, MATERIAL_ROCK)
    fillBall(Vector3.new(-205, -16, 75), 24, MATERIAL_ROCK)
    fillBall(Vector3.new(35, -18, 215), 18, MATERIAL_ROCK)

    fillBall(Vector3.new(122, -10, 72), 16, MATERIAL_WATER)
    fillBall(Vector3.new(96, -9, -58), 13, MATERIAL_WATER)
end

clearWorld()
createOcean()
createBaseIsland()
createWorldTree()
carveLandmarks()
createPaths()
scatterDetails()

print("[IslandGenerator] Generated improved world-tree island prototype.")
