-------------------------------------------
--- Leave Engine Running, Made by FAXES ---
-------------------------------------------

--- Config ---
RestrictEmer = false -- Only allow this feature for emergency vehicles.
keepDoorOpen = true -- Keep the door open when getting out.

--- Code ---
local notify = false

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)

        if not notify then
            if IsPedInAnyVehicle(ped, true) then
                ShowNotification("Hold ~b~F ~w~when exiting to leave engine running.")
                notify = true
            end
        end
        if RestrictEmer then
            if GetVehicleClass(veh) == 18 then
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    Citizen.Wait(150)
                    if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                        SetVehicleEngineOn(veh, true, true, false)
                        if keepDoorOpen then
                            TaskLeaveVehicle(ped, veh, 256)
                        else
                            TaskLeaveVehicle(ped, veh, 0)
                        end
                    end
                end
            end
        else
            if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                Citizen.Wait(150)
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    SetVehicleEngineOn(veh, true, true, false)
                    if keepDoorOpen then
                        TaskLeaveVehicle(ped, veh, 256)
                    else
                        TaskLeaveVehicle(ped, veh, 0)
                    end
                end
            end
        end
	end
end)

