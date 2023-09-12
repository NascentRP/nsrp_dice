QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('dice', 'Roll Dice', { { name = 'sides', help = 'How many sides the dice should have' } }, false, function(source, args)
    local ped = GetPlayerPed(source)
    local pCoords = GetEntityCoords(ped)
    local die = 6
    if args[1] ~= nil and tonumber(args[1]) then
        die = tonumber(args[1])
    end
    if die > 1000 then
        return
    end
    local result = math.random(1,die)
    local msg = 'Rolled a ' .. die .. ' sided dice and landed on ' .. result
    TriggerClientEvent('nsrp_dice:doRoll', source)
    Wait(1500)
    for k,v in pairs(QBCore.Functions.GetPlayers()) do
        local target = GetPlayerPed(v)
        local tCoords = GetEntityCoords(target)
        if #(pCoords - tCoords) < 7 then
            TriggerClientEvent('chat:addMessage', v, {
                color = { 0, 255, 0},
                multiline = true,
                args = {'Dice | '.. GetPlayerName(source), msg}
            })
        end
    end
end, 'user')