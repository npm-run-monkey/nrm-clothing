RegisterNUICallback('changeVariation', function(data, cb)
    local data = json.decode(data);
    
    changeVariation(data.componentId, data.drawable, data.texture)
end)

RegisterNUICallback('changeProp', function(data, cb)
    local data = json.decode(data);
    
    changeProp(data.componentId, data.drawable, data.texture)
end)

RegisterNUICallback('closeShop', function(data, cb)
    local buy = json.decode(data).buy
    
    disableCam()
    SendNUIMessage({
        action = 'openShop',
        data = { visible = false, pedData = {}}
    })

    SetNuiFocus(false, false)

    if (buy) then
        TriggerEvent('nrm-clothing:client:client:savePlayerClothing');
        exports['nrm-lib'].showNotify(nil, 'Kledingwinkel', 'succes', 'Je kleding is Opgeslagen!', 5000);
        return
    end

    TriggerServerEvent('nrm-clothing:client:server:restorePlayerClothing', currentOutfit);
    currentOutfit = {}

    exports['nrm-lib'].showNotify(nil, 'Kledingwinkel', 'error', 'Je kleding is terug hersteld naar het origineel!', 5000);

    cb(true)
end)

RegisterNUICallback('rotate', function(data, cb)
    local side = json.decode(data).side;

    if (side == "left") then
        local side = json.decode(data).side;
        local ped = PlayerPedId()
        local pedPos = GetEntityCoords(ped)
        local camPos = GetCamCoord(cam)
        local heading = headingToCam
        heading = heading - 90.0
        headingToCam = heading
        local cx, cy = GetPositionByRelativeHeading(ped, heading, camOffset)
        SetCamCoord(cam, cx, cy, camPos.z)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, camPos.z)
        cb(true)
        return;
    end
    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped)
    local camPos = GetCamCoord(cam)
    local heading = headingToCam
    heading = heading + 90.0
    headingToCam = heading
    local cx, cy = GetPositionByRelativeHeading(ped, heading, camOffset)
    SetCamCoord(cam, cx, cy, camPos.z)
    PointCamAtCoord(cam, pedPos.x, pedPos.y, camPos.z)
    cb('ok')
end)

RegisterNUICallback('changeCam', function(data, cb)
    local value = json.decode(data).part
    local pedPos = GetEntityCoords(PlayerPedId())
    if value == "face" then
        camOffset = 0.75
        local cx, cy = GetPositionByRelativeHeading(PlayerPedId(), headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, pedPos.z + 0.50)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + 0.50)
    elseif value == "torso" then
        camOffset = 1.0
        local cx, cy = GetPositionByRelativeHeading(PlayerPedId(), headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, pedPos.z + 0.25)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + 0.25)
    elseif value == "shoes" then
        camOffset = 1.0
        local cx, cy = GetPositionByRelativeHeading(PlayerPedId(), headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, pedPos.z + -0.5)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + -0.5)
    elseif value == "leg" then
        camOffset = 1.0
        local cx, cy = GetPositionByRelativeHeading(PlayerPedId(), headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, pedPos.z - 0.25)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z - 0.25)
    else
        enableCam();
    end
    cb(true)
  end)