RegisterNetEvent('nrm-clothing:client:client:openClothingMenu')

AddEventHandler('nrm-clothing:client:client:openClothingMenu', function()
    local promise = getOutfit()

    Citizen.CreateThread(function()
        promise(function(pedData)
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

RegisterCommand('open', function()
    TriggerEvent('nrm-clothing:client:client:openClothingMenu')
end)