-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local InsertService = game:GetService("InsertService")

-- Notification system
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

-- Notify the user
Notification:Notify(
    {Title = "Discord - meowbucks", Description = "MEOWBUCKS MADE THIS SCRIPT"},
    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "option"},
    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84), Callback = function(State) print(tostring(State)) end}
)
wait(1)
Notification:Notify(
    {Title = "Discord - meowbucks", Description = "MEOWBUCKS MADE THIS SCRIPT"},
    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84)}
)
wait(1)
Notification:Notify(
    {Title = "Discord - meowbucks", Description = "MEOWBUCKS MADE THIS SCRIPT"},
    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "default"}
)

-- Ensure the local player is valid
local player = Players.LocalPlayer
if not player then
    warn("LocalPlayer not found")
    return
end

-- Define the URL for the .rbxm asset
local assetUrl = "https://github.com/RegularVynixu/Utilities/raw/main/Doors/Item%20Spawner/Assets/Crucifix.rbxm"

-- Function to load the .rbxm asset
local function loadRbxmAsset(url)
    -- Function to handle HTTP request
    local function fetchAssetData()
        return xpcall(function()
            return HttpService:GetAsync(url)
        end, function(err)
            warn("HTTP request failed:", err)
            return nil
        end)
    end

    -- Function to handle asset loading
    local function processAsset(data)
        local assetModel = Instance.new("Model")
        assetModel.Name = "CustomCrucifix"
        assetModel.Parent = player.Backpack

        local assetContainer = Instance.new("Folder")
        assetContainer.Name = "AssetContainer"
        assetContainer.Parent = assetModel

        -- Load asset data
        local function loadAsset()
            return xpcall(function()
                local assetData = Instance.new("ModuleScript")
                assetData.Source = data
                assetData.Parent = assetContainer

                local deserializedAsset = InsertService:LoadAsset(assetData.Source)
                if deserializedAsset then
                    deserializedAsset.Parent = assetContainer
                else
                    error("Failed to deserialize asset")
                end
            end, function(err)
                warn("Failed to load asset data:", err)
            end)
        end

        coroutine.wrap(loadAsset)()
    end

    -- Main execution
    local data, errorMsg = fetchAssetData()
    if data then
        processAsset(data)
    else
        warn("Failed to fetch asset data:", errorMsg)
    end
end

-- Call the function to load the asset
loadRbxmAsset(assetUrl)
