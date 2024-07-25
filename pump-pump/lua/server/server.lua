


util.AddNetworkString('acceptProcess')

net.Receive('acceptProcess', function()
    local plyID = net.ReadInt(8)

    local plyEnt = Entity(plyID)

    local boneScaleTable = net.ReadTable()

    for k, v in pairs(boneScaleTable) do
        plyEnt:ManipulateBoneScale(k, v)

    end
end)