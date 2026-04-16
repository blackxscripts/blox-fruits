--// BLACK X - Fruit API Module (Final)

local FruitAPI = {}

--// DATABASE (IMAGENS RAW)
local Fruits = {
    ["Rocket"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Rocket_Fruit.png",
    ["Spin"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Spin_Fruit.png",
    ["Blade"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Blade_Fruit.png",
    ["Spring"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Spring_Fruit.png",
    ["Bomb"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Bomb_Fruit.png",
    ["Smoke"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Smoke_Fruit.png",
    ["Spike"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Spike_Fruit.png",

    ["Flame"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Flame_Fruit.png",
    ["Falcon"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Falcon_Fruit.png",
    ["Ice"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Ice_Fruit.png",
    ["Sand"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Sand_Fruit.png",
    ["Dark"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Dark_Fruit.png",

    ["Diamond"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Diamond_Fruit.png",
    ["Light"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Light_Fruit.png",
    ["Rubber"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Rubber_Fruit.png",
    ["Ghost"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Ghost_Fruit.png",

    ["Magma"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Magma_Fruit.png",
    ["Quake"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Quake_Fruit.png",
    ["Buddha"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Buddha_Fruit.png",
    ["Love"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Love_Fruit.png",
    ["Spider"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Spider_Fruit.png",
    ["Sound"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Sound_Fruit.png",
    ["Phoenix"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Phoenix_Fruit.png",
    ["Portal"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Portal_Fruit.png",
    ["Blizzard"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Blizzard_Fruit.png",

    ["Gravity"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Gravity_Fruit.png",
    ["Mammoth"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Mammoth_Fruit.png",
    ["T-Rex"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/T-Rex_Fruit.png",
    ["Dough"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Dough_Fruit.png",
    ["Shadow"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Shadow_Fruit.png",
    ["Venom"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Venom_Fruit.png",
    ["Control"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Control_Fruit.png",
    ["Spirit"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Spirit_Fruit.png",
    ["Kitsune"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Kitsune_Fruit.png",
    ["Dragon"] = "https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/Dragon_Fruit.png"
}

--// EXPOR DATABASE
FruitAPI.Fruits = Fruits

--// CHECK
function FruitAPI.IsFruit(name)
    return Fruits[name] ~= nil
end

--// PEGAR IMAGEM
function FruitAPI.GetImage(name)
    return Fruits[name]
end

--// PEGAR FRUTAS DO PLAYER
function FruitAPI.GetFruitsFromCharacter(char)
    local list = {}

    for _,v in pairs(char:GetChildren()) do
        if v:IsA("Tool") and Fruits[v.Name] then
            table.insert(list, v.Name)
        end
    end

    return list
end

--// ESP DE CHÃO (IMAGEM)
function FruitAPI.CreateWorldESP(part, fruitName)
    if not Fruits[fruitName] then return end
    if not part or not part:IsA("BasePart") then return end
    if part:FindFirstChild("BX_ESP") then return end

    local bill = Instance.new("BillboardGui")
    bill.Name = "BX_ESP"
    bill.Size = UDim2.new(0,100,0,100)
    bill.AlwaysOnTop = true
    bill.MaxDistance = 10000
    bill.StudsOffset = Vector3.new(0,2.5,0)
    bill.Parent = part

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(1,0,1,0)
    img.BackgroundTransparency = 1
    img.Image = Fruits[fruitName]
    img.Parent = bill
end

--// LIMPAR ESP
function FruitAPI.ClearESP()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:FindFirstChild("BX_ESP") then
            v.BX_ESP:Destroy()
        end
    end
end

return FruitAPI
