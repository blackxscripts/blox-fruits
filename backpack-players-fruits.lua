--// BLACK X - BACKPACK PLAYER ESP (V3 FINAL)

local Players = game:GetService("Players")

local API = loadstring(game:HttpGet("https://raw.githubusercontent.com/blackxscripts/blox-fruits/main/fruit_esp_module.lua"))()

-- PEGAR TODAS FRUTAS (CHAR + BACKPACK)
local function GetFruits(player)
    local fruits = {}

    -- Character
    if player.Character then
        for _,name in ipairs(API.GetFruitsFromCharacter(player.Character)) do
            fruits[#fruits+1] = name
        end
    end

    -- Backpack
    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        for _,tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and API.IsFruit(tool.Name) then
                fruits[#fruits+1] = tool.Name
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

    -- REMOVE SEMPRE (anti bug duplicado)
    local old = head:FindFirstChild("BX_ESP")
    if old then old:Destroy() end

    local fruits = GetFruits(player)
    if #fruits == 0 then return end

    local images = table.create(#fruits)

    for i, name in ipairs(fruits) do
        local img = API.GetImage(name)
        if img then
            images[i] = img
        end
    end

    API.CreateBillboard(head, images, UDim2.new(0,120,0,60), Vector3.new(0,3.5,0))
end

-- SISTEMA DE HOOK COMPLETO
local function Hook(player)

    local function HookChar(char)

        -- eventos do personagem
        char.ChildAdded:Connect(function(obj)
            if obj:IsA("Tool") then
                Update(player)
            end
        end)

        char.ChildRemoved:Connect(function(obj)
            if obj:IsA("Tool") then
                Update(player)
            end
        end)

        task.delay(0.5, function()
            Update(player)
        end)
    end

    -- Character
    if player.Character then
        HookChar(player.Character)
    end

    player.CharacterAdded:Connect(HookChar)

    -- Backpack seguro (sem bug)
    task.spawn(function()
        while player.Parent do
            local backpack = player:FindFirstChildOfClass("Backpack")
            if backpack then

                backpack.ChildAdded:Connect(function(obj)
                    if obj:IsA("Tool") then
                        Update(player)
                    end
                end)

                backpack.ChildRemoved:Connect(function(obj)
                    if obj:IsA("Tool") then
                        Update(player)
                    end
                end)

                break
            end
            task.wait()
        end
    end)
end

-- START
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
