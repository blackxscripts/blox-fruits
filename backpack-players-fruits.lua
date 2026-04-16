--// BLACK X - BACKPACK PLAYER ESP (REMENDADO V2)

local Players = game:GetService("Players")

-- MODULE
local API = loadstring(game:HttpGet("https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/fruit_esp_module.lua"))()

-- PEGAR TODAS FRUTAS (CHAR + BACKPACK)
local function GetFruits(player)
    local fruits = {}

    -- Character (equipado)
    if player.Character then
        for _,name in ipairs(API.GetFruitsFromCharacter(player.Character)) do
            table.insert(fruits, name)
        end
    end

    -- Backpack (inventário)
    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        for _,tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and API.IsFruit(tool.Name) then
                table.insert(fruits, tool.Name)
            end
        end
    end

    return fruits
end

-- ATUALIZAR ESP
local function Update(player)
    local char = player.Character
    if not char then return end

    local head = char:FindFirstChild("Head")
    if not head then return end

    -- REMOVER ESP ANTIGO (anti bug)
    local old = head:FindFirstChild("BX_ESP")
    if old then old:Destroy() end

    local fruits = GetFruits(player)
    if #fruits == 0 then return end

    local images = {}
    for _,name in ipairs(fruits) do
        local img = API.GetImage(name)
        if img then
            table.insert(images, img)
        end
    end

    if #images == 0 then return end

    API.CreateBillboard(
        head,
        images,
        UDim2.new(0, 120, 0, 60),
        Vector3.new(0, 3.5, 0)
    )
end

-- HOOK DO PLAYER (EVENTOS)
local function Hook(player)
    local function SetupChar(char)
        -- atualizar ao equipar/desequipar
        char.ChildAdded:Connect(function()
            Update(player)
        end)

        char.ChildRemoved:Connect(function()
            Update(player)
        end)

        -- update inicial
        task.wait(0.5)
        Update(player)
    end

    -- Character
    if player.Character then
        SetupChar(player.Character)
    end

    player.CharacterAdded:Connect(SetupChar)

    -- Backpack (mais seguro)
    task.spawn(function()
        while not player:FindFirstChildOfClass("Backpack") do
            task.wait()
        end

        local backpack = player:FindFirstChildOfClass("Backpack")

        backpack.ChildAdded:Connect(function()
            Update(player)
        end)

        backpack.ChildRemoved:Connect(function()
            Update(player)
        end)
    end)
end

-- INICIAR
for _,p in ipairs(Players:GetPlayers()) do
    if p ~= Players.LocalPlayer then
        Hook(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= Players.LocalPlayer then
        Hook(p)
    end
end)
