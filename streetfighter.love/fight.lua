Fight = {}

function Fight.new(player1, player2)
    local o = {}
    o.player1 = player1
    o.player2 = player2
    o.winner = 0
    setmetatable(o, { __index = Fight })
    return o
end

function Fight:applyDamage()
    -- if self.player1.hitPlayer(self.player2) then
    --     self.player1.loseHealth(math.random(1, 200))
    -- elseif self.player2.hitPlayer(self.player1) then
    --     self.player2.loseHealth(math.random(1, 200))
    -- end 
    if self.player1:isDead() then
        game.winner = 2
    end 
    if self.player2:isDead() then 
        game.winner = 1
    end
    if self.player1.punch then
        if math.abs(self.player1.y - self.player2.y) <= self.player1.height then
            if math.abs(self.player1.x - self.player2.x) <= self.player2.width then
                self.player2:loseHealth(self.player1)
            end
        end
    end
    if self.player2.punch then 
        if math.abs(self.player1.y - self.player2.y) <= self.player1.height then
            if math.abs(self.player1.x - self.player2.x) <= self.player2.width then
                self.player1:loseHealth(self.player2)
            end
        end
    end

end
