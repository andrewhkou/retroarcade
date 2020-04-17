Fight = {}

function Fight.new(player1, player2)
    local o = {}
    o.player1 = player1
    o.player2 = player2
    setmetatable(o, { __index = Fight })
    return o
end

function Fight:applyDamage()
    if player1.hitPlayer(player2, player1.getWidth(), player1.getHeight()) then
        player1.loseHealth(math.random(1, 200))
    elseif player2.hitPlayer(player1, player2.getWidth(), player2.getHeight()) then
        player2.loseHealth(math.random(1, 200))
    end 
end