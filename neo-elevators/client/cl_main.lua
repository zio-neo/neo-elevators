local QBCore = exports['qb-core']:GetCoreObject()
local inElevator = false

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if Config.Target then
            for k, v in pairs(Config.Elevators) do
                for m, n in pairs(v.Floors) do
                    exports['qb-target']:RemoveZone("Name: "..k.." | Floor: "..m)
                end
            end
        end
    end
end)

CreateThread(function()
    if Config.Target then
        for k, v in pairs(Config.Elevators) do
            for m, n in pairs(v.Floors) do
                exports['qb-target']:AddBoxZone("Name: "..k.." | Floor: "..m, n.Coord, n.Poly.Length, n.Poly.Width, {
                    name = "Name: "..k.." | Floor: "..m,
                    heading = n.Poly.Heading,
                    debugPoly = false,
                    minZ = n.Poly.minZ,
                    maxZ = n.Poly.maxZ,
                }, {
                    options = {
                        {
                            type = "client",
                            icon = v.TargetIcon,
                            label = v.Target,
                            action = function()
                                TriggerEvent('neo-elevators:client:useElevator', v, m, k)
                            end,
                            canInteract = function ()
                                local Ply = PlayerPedId()
                                if IsPedInAnyVehicle(Ply) or inElevator then return false end
                                return true
                            end,
                            job = v.Job,
                        }
                    },
                distance = 2.5,
                })
            end
        end
    else
        local Sleep
        while true do
            local Ply = PlayerPedId()
            Sleep = 2000
            for k, v in pairs(Config.Elevators) do
                for m, n in pairs(v.Floors) do
                    local PlyCoord = GetEntityCoords(Ply)
                    local Distance = #(PlyCoord - n.Coord)
                    if Distance < v.Distance and not IsPedInAnyVehicle(Ply) then
                        Sleep = 0
                        QBCore.Functions.DrawText3D(n.Coord.x, n.Coord.y, n.Coord.z, Config.DrawTextKey.String..v.Target)
                        if IsControlJustPressed(0, Config.DrawTextKey.Key) then
                            PlayerData = QBCore.Functions.GetPlayerData()
                            if v.Job ~= nil then
                                if PlayerData.job == v.Job then 
                                    TriggerEvent('neo-elevators:client:useElevator', v, m, k)
                                else
                                    QBCore.Functions.Notify(Config.Lang.NotAllowed, 'error', 7500) 
                                end
                            else
                                TriggerEvent('neo-elevators:client:useElevator', v, m, k)
                            end
                        end
                    end
                end
            end
            Wait(Sleep)
        end    
    end
end)

RegisterNetEvent('neo-elevators:client:useElevator', function(DataV, DataM, DataK)
    if inElevator then QBCore.Functions.Notify(Config.Lang.AlreadyInElevator, 'error', 7500) return end
    local UsedElevator = {{
        header = DataK,
        icon = DataV.TargetIcon,
        isMenuHeader = true
    }}
    for k, v in pairs(DataV.Floors) do
        if k ~= DataM then
            table.insert(UsedElevator, {
                header = v.Label,
                isMenuHeader = false,
                params = {
                    event = "neo-elevators:client:elevatorUsed",
                    args = {
                        Progressbar = {
                            Duration = DataV.Progressbar.Duration,
                            Label = DataV.Progressbar.Label, 
                        },
                        SoundEffect = {
                            WhereToPlay = DataV.SoundEffect.WhereToPlay,
                            OnStartEffect = DataV.SoundEffect.OnStartSoundEffect,
                            OnFinishEffect = DataV.SoundEffect.OnFinishSoundEffect,
                            Loudness = DataV.SoundEffect.Loudness,
                        },
                        GoTo = v.Spawn.PlayerSpawn, 
                        GoToHeading = v.Spawn.PlayerHeading
                    },
                }
            })
        else
            table.insert(UsedElevator, {
                header = v.Label.." "..Config.Lang.OnThisFloor,
                isMenuHeader = true,
                params = {
                    event = "neo-elevators:client:elevatorUsed",
                    args = {
                        Progressbar = {
                            Duration = DataV.Progressbar.Duration,
                            Label = DataV.Progressbar.Label, 
                        },
                        SoundEffect = {
                            WhereToPlay = DataV.SoundEffect.WhereToPlay,
                            OnStartEffect = DataV.SoundEffect.OnStartSoundEffect,
                            OnFinishEffect = DataV.SoundEffect.OnFinishSoundEffect,
                            Loudness = DataV.SoundEffect.Loudness,
                        },
                        GoTo = v.Spawn.PlayerSpawn, 
                        GoToHeading = v.Spawn.PlayerHeading
                    },
                }
            })
        end
    end
    exports['qb-menu']:openMenu(UsedElevator)
end)

RegisterNetEvent('neo-elevators:client:elevatorUsed', function(Data)
    local Ply = PlayerPedId()
    if Data.SoundEffect.WhereToPlay == "OnStart" or Data.SoundEffect.WhereToPlay == "Both" then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", Data.SoundEffect.OnStartEffect, Data.SoundEffect.Loudness)
    end
    inElevator = true
    if Config.Fade then
        DoScreenFadeOut(1000)
    end
    QBCore.Functions.Progressbar('zn_elevator', Data.Progressbar.Label, Data.Progressbar.Duration, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = Config.Anim.Dict,
        anim = Config.Anim.Name,
        flags = Config.Anim.Flags,
    }, {}, {}, function()
        if Data.SoundEffect.WhereToPlay == "OnFinish" or Data.SoundEffect.WhereToPlay == "Both" then
            TriggerServerEvent("InteractSound_SV:PlayOnSource", Data.SoundEffect.OnFinishEffect, Data.SoundEffect.Loudness)
        end
        if Config.SecondalFade then
            DoScreenFadeOut(2000)
            Wait(2000)
            SetEntityCoords(Ply, Data.GoTo.x, Data.GoTo.y, Data.GoTo.z)
            SetEntityHeading(Ply, Data.GoToHeading)
            Wait(1000)
            DoScreenFadeIn(2000)
        end
        if Config.Fade then
            Wait(500)
            DoScreenFadeIn(1000)
        end
        inElevator = false
    end, function()
        if Data.SoundEffect.WhereToPlay == "OnFinish" or Data.SoundEffect.WhereToPlay == "Both" then
            TriggerServerEvent("InteractSound_SV:PlayOnSource", Data.SoundEffect.OnFinishEffect, Data.SoundEffect.Loudness)
        end
        QBCore.Functions.Notify(Config.Lang.ChangedMind, 'error', 7500)
        DoScreenFadeIn(1000)
        inElevator = false
    end)
end)