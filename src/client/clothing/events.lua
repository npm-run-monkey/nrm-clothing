currentOutfit = {}

RegisterNetEvent('nrm-clothing:server:client:openClothingMenu')

AddEventHandler('nrm-clothing:server:client:openClothingMenu', function()
    local promise = getOutfit()

    Citizen.CreateThread(function()
        promise(function(pedData)
            currentOutfit = pedData
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'openShop',
                data = { visible = true, pedData = pedData}
            })
        end)
    end)

    enableCam();
end)

RegisterNetEvent('nrm-clothing:client:client:savePlayerClothing')

AddEventHandler('nrm-clothing:client:client:savePlayerClothing', function()
    local promise = getOutfit()

    Citizen.CreateThread(function()
        promise(function(pedData)
            TriggerServerEvent('nrm-clothing:client:server:sendPlayerClothing', pedData)
        end)
    end)
end)

RegisterKeyMapping('openClothing', 'Check if the player is in any clothing zone', 'keyboard', 'e');

RegisterCommand('openClothing', function()
    TriggerServerEvent('nrm-clothing:client:server:checkClothingStore')
end)