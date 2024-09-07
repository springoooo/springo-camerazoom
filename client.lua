local zoomedIn = false
local playerHeading = 0
local cam

-- FUNCTIONS: 
local function isPlayerInFirstPerson()
    return Config.DisableInFirstPerson and GetFollowPedCamViewMode() == 4
end

local function isPlayerStationary()
    if not Config.RequireStationary then return true end
    local ped = PlayerPedId()
    return IsPedStill(ped) and not IsPedInAnyVehicle(ped, false)
end

local function isCameraInAllowedCone()
    if not Config.EnableConeRestriction then return true end
    local ped = PlayerPedId()
    local pedHeading = GetEntityHeading(ped)
    local camRot = GetGameplayCamRot(2)
    local camHeading = (camRot.z + 360) % 360

    local angleDiff = math.abs(pedHeading - camHeading)
    if angleDiff > 180 then
        angleDiff = 360 - angleDiff
    end

    return angleDiff <= Config.ConeAngle
end

local function zoomIn()
    if isPlayerInFirstPerson() or not isPlayerStationary() or (Config.DisableInVehicle and IsPedInAnyVehicle(PlayerPedId(), false)) or not isCameraInAllowedCone() then return end 
    if not zoomedIn then
        zoomedIn = true
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        local playerPed = PlayerPedId()
        local coords = GetGameplayCamCoord()
        local rot = GetGameplayCamRot(2)
        playerHeading = GetEntityHeading(PlayerPedId())
        --AttachCamToEntity(cam, playerPed, 0.0, 0.0, 1.0, true)
        AttachCamToPedBone(cam, playerPed, 12844, 0.3, -0.5, 0.0, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z)
        SetCamRot(cam, rot.x, rot.y, rot.z, 2)
        SetCamFov(cam, Config.ZoomFOV)
        SetCamActive(cam, true)
        RenderScriptCams(true, 1, 300, true, true)
        SetTimecycleModifier("focus") 
        SetTimecycleModifierStrength(2.0)
    end
end

local function zoomOut()
    if zoomedIn then
        SetCamFov(cam, Config.NormalFOV)
        SetCamActive(cam, false)
        RenderScriptCams(0, 1, 300, true, true) 
        DestroyCam(cam, false)
        zoomedIn = false
        ClearTimecycleModifier()
    end
end

local function updateCameraRotation()
    if zoomedIn then
        local mouseX = GetDisabledControlNormal(1, 1) * Config.RotationSpeed
        local mouseY = GetDisabledControlNormal(1, 2) * Config.RotationSpeed
        local rotation = GetCamRot(cam, 2)
        SetCamRot(cam, rotation.x - mouseY, rotation.y, rotation.z - mouseX, 2)
        if not isPlayerStationary() then
            zoomOut()
        end
    end
end


-- KEYBINDINGS:
RegisterCommand("+zoom", function()
    if not zoomedIn then
        Wait(50)
        zoomIn()
    end
end, false)

RegisterCommand("-zoom", function()
    if zoomedIn then
        Wait(50)
        zoomOut()
    end
end, false)

RegisterKeyMapping("+zoom", "Zoom In/Out", "mouse_button", Config.ZoomKey)


-- THREADS: 
if Config.EnableZoom then
    CreateThread(function()
        while true do
            Wait(0)
            if zoomedIn then
                updateCameraRotation()
            end
        end
    end)
end


