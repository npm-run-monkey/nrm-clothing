local function roundToTwoDecimals(num)
  return math.floor(num * 100 + 0.5) / 100
end

RegisterCommand('coords', function()
  local coords = GetEntityCoords(GetPlayerPed(-1))

  print(roundToTwoDecimals(coords.x), roundToTwoDecimals(coords.y), roundToTwoDecimals(coords.z, 2))
end)