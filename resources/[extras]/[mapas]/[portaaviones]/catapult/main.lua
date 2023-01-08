local isInValidPlane = false
local isBeingUsed = false

local customNames = false -- set to true to turn on custom models
local planeList = {'HYDRA', 'LAZER'} -- planes that are whitelisted if customNames is true


RegisterCommand('catapult1', function(source) -- no need to change anything past here
    local MyPedVeh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
    local Height = GetEntityHeightAboveGround(MyPedVeh)
    local Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.24

    local MyPed = GetPlayerPed(-1)
    local PedPlane = IsPedInAnyPlane(MyPed)

    local v = vector3(3028.04, -4595.18, 16.25)
    local playercoords = GetEntityCoords(GetPlayerPed(-1))
    local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, playercoords.x, playercoords.y, playercoords.z)

    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local VehModel = GetEntityModel(vehicle)
    local VehModelName = GetDisplayNameFromVehicleModel(VehModel)

    if distance >= 250 then
        TriggerEvent('chat:addMessage', {
            color = {15, 184, 15},
            multiline = true,
            args = {"[Catapult]", "You are too far to attach to the catapult!"}
          })
        return
    end
    
    if MyPedVeh == 0 then
        TriggerEvent('chat:addMessage', {
            color = {15, 184, 15},
            multiline = true,
            args = {"[Catapult]", "You are not in a vehicle!"}
          })
        return
    end
    
    if customNames then
        lookForValidPlane()
        Citizen.Wait(100)
        if isInValidPlane == false then
            TriggerEvent('chat:addMessage', {
                color = {15, 184, 15},
                multiline = true,
                args = {"[Catapult]", 'You are not in a fighter jet or approved vehicle!'}
              })
            return
        end
    end

    if(Height > 20) then 
        TriggerEvent('chat:addMessage', {
            color = {15, 184, 15},
            multiline = true,
            args = {"[Catapult]", 'You need to be on the ground to attach to the catapult!'}
          })
        return
    end

    if(Speed > 20) then
        TriggerEvent('chat:addMessage', {
            color = {15, 184, 15},
            multiline = true,
            args = {"[Catapult]", 'You are going too fast to attach to attach to the catapult!'}
          })
        return
    end

    if isBeingUsed then
        TriggerEvent('chat:addMessage', {
            color = {15, 184, 15},
            multiline = true,
            args = {"[Catapult]", 'You are already using a catapult!'}
          })
        return
    end

    isBeingUsed = true
    SetEntityCoordsNoOffset(vehicle, v.x, v.y, playercoords.z)
    SetEntityHeading(vehicle, 15.0)
    TriggerEvent('chat:addMessage', {
        color = {15, 184, 15},
        multiline = true,
        args = {"[Catapult]", 'Launching in 3 seconds!'}
      })
    Citizen.Wait(3000)
    TriggerEvent('chat:addMessage', {
        color = {15, 184, 15},
        multiline = true,
        args = {"[Catapult]", 'Launching...'}
      })
    Citizen.Wait(100)
    SetVehicleForwardSpeed(vehicle, 120.0)
    Citizen.Wait(700)
    SetVehicleForwardSpeed(vehicle, 110.0)
    Citizen.Wait(900)
    isBeingUsed = false
end)

RegisterCommand('catapult2', function(source) -- lol coppy paste bc im lazy
  local MyPedVeh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
  local Height = GetEntityHeightAboveGround(MyPedVeh)
  local Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.24

  local MyPed = GetPlayerPed(-1)
  local PedPlane = IsPedInAnyPlane(MyPed)

  local v = vector3(3041.07, -4591.98, 16.25)
  local playercoords = GetEntityCoords(GetPlayerPed(-1))
  local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, playercoords.x, playercoords.y, playercoords.z)

  local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  local VehModel = GetEntityModel(vehicle)
  local VehModelName = GetDisplayNameFromVehicleModel(VehModel)

  if distance >= 250 then
      TriggerEvent('chat:addMessage', {
          color = {15, 184, 15},
          multiline = true,
          args = {"[Catapult]", "You are too far to attach to the catapult!"}
        })
      return
  end
  
  if MyPedVeh == 0 then
      TriggerEvent('chat:addMessage', {
          color = {15, 184, 15},
          multiline = true,
          args = {"[Catapult]", "You are not in a vehicle!"}
        })
      return
  end
  
  if customNames then
      lookForValidPlane()
      Citizen.Wait(100)
      if isInValidPlane == false then
          TriggerEvent('chat:addMessage', {
              color = {15, 184, 15},
              multiline = true,
              args = {"[Catapult]", 'You are not in a fighter jet or approved vehicle!'}
            })
          return
      end
  end

  if(Height > 20) then 
      TriggerEvent('chat:addMessage', {
          color = {15, 184, 15},
          multiline = true,
          args = {"[Catapult]", 'You need to be on the ground to attach to the catapult!'}
        })
      return
  end

  if(Speed > 20) then
      TriggerEvent('chat:addMessage', {
          color = {15, 184, 15},
          multiline = true,
          args = {"[Catapult]", 'You are going too fast to attach to attach to the catapult!'}
        })
      return
  end

  if isBeingUsed then
      TriggerEvent('chat:addMessage', {
          color = {15, 184, 15},
          multiline = true,
          args = {"[Catapult]", 'You are already using a catapult!'}
        })
      return
  end

  isBeingUsed = true
  SetEntityCoordsNoOffset(vehicle, v.x, v.y, playercoords.z)
  SetEntityHeading(vehicle, 18.0)
  TriggerEvent('chat:addMessage', {
      color = {15, 184, 15},
      multiline = true,
      args = {"[Catapult]", 'Launching in 3 seconds!'}
    })
  Citizen.Wait(3000)
  TriggerEvent('chat:addMessage', {
      color = {15, 184, 15},
      multiline = true,
      args = {"[Catapult]", 'Launching...'}
    })
  Citizen.Wait(100)
  SetVehicleForwardSpeed(vehicle, 120.0)
  Citizen.Wait(700)
  SetVehicleForwardSpeed(vehicle, 110.0)
  Citizen.Wait(900)
  isBeingUsed = false
end)

function lookForValidPlane()
    Citizen.CreateThread(function()
    local i = 1
    local planeListNum = #planeList
    isInValidPlane = false
        while planeListNum + 1 > i do
            Citizen.Wait(0)
            local currentPlane = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
            if planeList[i] == currentPlane then
                isInValidPlane = true
                return
            else
                i = i + 1 
            end
        end
    end)
end