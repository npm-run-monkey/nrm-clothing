local pedOutfitBluePrint = 
{
    ["Masker"] = {
        type = "item",
        componentId = 1
    },
    ["Armen"] = {
        type = "item",
        componentId = 3
    },
    ["Broek"] = {
        type = "item",
        componentId = 4
    },
    ["Rugzak"] = {
        type = "item",
        componentId = 5
    },
    ["Schoenen"] = {
        type = "item",
        componentId = 6
    },
    ["Accessoires"] = {
        type = "item",
        componentId = 7
    },
    ["T-Shirt"] = {
        type = "item",
        componentId = 8
    },
    ["Kevlar"] = {
        type = "item",
        componentId = 9
    },
    ["Badge"] = {
        type = "item",
        componentId = 10
    },
    ["Torso"] = {
        type = "item",
        componentId = 11
    },
    ["Hoofddeksel"] = {
        type = "prop",
        componentId = 0
    },
    ["Bril"] = {
        type = "prop",
        componentId = 1
    },
    ["Oorbel"] = {
        type = "prop",
        componentId = 2
    },
    ["Horloge"] = {
        type = "prop",
        componentId = 6
    },
    ["Armband"] = {
        type = "prop",
        componentId = 7
    }
}

getOutfit = function()
    local co = coroutine.create(function()
        local ped = PlayerPedId()
        local pedData = {}
    
        for k, v in pairs(pedOutfitBluePrint) do
            local itemData = {}
    
            if (v.type == "item") then
                itemData["title"] = k 
                itemData["type"] = v.type 
                itemData["componentId"] = v.componentId 
                itemData["drawable"] = GetPedDrawableVariation(ped, v.componentId) 
                itemData["texture"] = GetPedTextureVariation(ped, v.componentId) 
            end
    
            if (v.type == "prop") then
                itemData["title"] = k
                itemData["type"] = v.type
                itemData["componentId"] = v.componentId
                itemData["drawable"] = GetPedPropIndex(ped, v.componentId)
                itemData["texture"] = GetPedPropTextureIndex(ped, v.componentId) 
            end
    
            table.insert(pedData, itemData);
        end
        return json.encode(pedData)
    end)

    return function(callback)
        local success, result = coroutine.resume(co)
        if success then
            callback(result)
        else
            print("Error:", result)
        end
    end
end

changeVariation = function(component, drawable, texture)
    local ped = PlayerPedId()

    RequestModel('mp_m_freemode_01')

    while not HasModelLoaded('mp_m_freemode_01') do
        Wait(0)
    end

    if GetEntityModel(ped) ~= GetHashKey('mp_m_freemode_01') then
        SetPlayerModel(PlayerId(), 'mp_m_freemode_01')
    end
    
    SetPedComponentVariation(ped, component, drawable - 1, texture - 1, 0);
end

changeProp = function(component, drawable, texture)
    local ped = PlayerPedId()

    if (drawable == 0) then
        ClearPedProp(ped, component)
        return;
    end

    SetPedPropIndex(ped, component, drawable - 1, texture - 1, true)
end