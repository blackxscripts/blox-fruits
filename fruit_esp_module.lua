--// BLACK X - Fruit API Module (PRO)

local FruitAPI = {}

--// =========================
-- DATABASE (SOURCE OF TRUTH)
-- =========================
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

FruitAPI.Fruits = Fruits

--// =========================
-- CORE API
-- =========================

function FruitAPI.IsFruit(name)
    return Fruits[name] ~= nil
end

function FruitAPI.GetImage(name)
    return Fruits[name]
end

function FruitAPI.GetAll()
    return Fruits
end

function FruitAPI.GetFruitsFromCharacter(char)
    local list = {}

    for _,v in ipairs(char:GetChildren()) do
        if v:IsA("Tool") and Fruits[v.Name] then
            table.insert(list, v.Name)
        end
    end

    return list
end

--// =========================
-- ESP (VISUAL LAYER)
-- =========================

function FruitAPI.CreateBillboard(parent, images, size, offset)
    if not parent then return end

    local old = parent:FindFirstChild("BX_ESP")
    if old then old:Destroy() end

    local bill = Instance.new("BillboardGui")
    bill.Name = "BX_ESP"
    bill.Size = size or UDim2.new(0,100,0,100)
    bill.AlwaysOnTop = true
    bill.MaxDistance = 10000
    bill.StudsOffset = offset or Vector3.new(0,3,0)
    bill.Parent = parent

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,1,0)
    frame.BackgroundTransparency = 1
    frame.Parent = bill

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0,3)
    layout.Parent = frame

    for _,imgUrl in ipairs(images) do
        local img = Instance.new("ImageLabel")
        img.Size = UDim2.new(0,40,0,40)
        img.BackgroundTransparency = 1
        img.Image = imgUrl
        img.Parent = frame
    end

    return bill
end

function FruitAPI.CreateWorldESP(part, fruitName)
    if not part or not part:IsA("BasePart") then return end
    if not Fruits[fruitName] then return end

    return FruitAPI.CreateBillboard(
        part,
        {Fruits[fruitName]},
        UDim2.new(0,100,0,100),
        Vector3.new(0,2.5,0)
    )
end

function FruitAPI.CreatePlayerESP(character)
    local head = character:FindFirstChild("Head")
    if not head then return end

    local fruits = FruitAPI.GetFruitsFromCharacter(character)
    if #fruits == 0 then
        local old = head:FindFirstChild("BX_ESP")
        if old then old:Destroy() end
        return
    end

    local images = {}
    for _,name in ipairs(fruits) do
        table.insert(images, Fruits[name])
    end

    return FruitAPI.CreateBillboard(head, images)
end

--// =========================
-- UTIL
-- =========================

function FruitAPI.ClearESP()
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:FindFirstChild("BX_ESP") then
            v.BX_ESP:Destroy()
        end
    end
end

return FruitAPI
