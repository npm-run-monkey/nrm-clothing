cam = 0
camOffset = 0
headingToCam = 0

function enableCam()
    -- Camera
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), -0.05, 2.25, 0.25)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if(not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(PlayerPedId()) + 180)
    end

    if customCamLocation ~= nil then
        SetCamCoord(cam, customCamLocation.x, customCamLocation.y, customCamLocation.z)
        SetCamRot(cam, 0.0, 0.0, customCamLocation.w)
    end

    headingToCam = GetEntityHeading(PlayerPedId()) + 90
    camOffset = 2.0
end

function disableCam()
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(cam, false)

    FreezeEntityPosition(PlayerPedId(), false)
end

function GetPositionByRelativeHeading(ped, head, dist)
    local pedPos = GetEntityCoords(ped)

    local finPosx = pedPos.x + math.cos(head * (math.pi / 180)) * dist
    local finPosy = pedPos.y + math.sin(head * (math.pi / 180)) * dist

    return finPosx, finPosy
end