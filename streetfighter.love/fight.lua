Fight = {}

function love.lowmemory()
    cachetable = {}
    collectgarbage()
end

function Fight.new(player1, player2)
    local o = {}
    o.player1 = player1
    o.player2 = player2
    o.winner = 0
    setmetatable(o, { __index = Fight })
    return o
end

function Fight:applyDamage()
    if self.player1:isDead() then
        game.winner = 2
    end 
    if self.player2:isDead() then 
        game.winner = 1
    end
    if self.player1.punch then
        if self.player1.direction == 'right' then
            if math.abs(self.player1.y - self.player2.y) <= self.player2.height then
                if self.player2.x - self.player1.x <= self.player2.width and self.player2.x >= self.player1.x then
                    self.player2:loseHealth(self.player1)
                end
            end
        elseif self.player1.direction == 'left' then
            if math.abs(self.player1.y - self.player2.y) <= self.player2.height then
                if self.player1.x - self.player2.x <= self.player2.width and self.player2.x <= self.player1.x then
                    self.player2:loseHealth(self.player1)
                end
            end
        end
    end
    if self.player2.punch then 
        if self.player2.direction == 'right' then
            if math.abs(self.player1.y - self.player2.y) <= self.player1.height then
                if self.player1.x - self.player2.x <= self.player1.width and self.player2.x <= self.player1.x then
                    self.player1:loseHealth(self.player2)
                end
            end
        elseif self.player2.direction == 'left' then
            if math.abs(self.player1.y - self.player2.y) <= self.player1.height then
                if self.player2.x - self.player1.x <= self.player1.width and self.player2.x >= self.player1.x then
                    self.player1:loseHealth(self.player2)
                end
            end
        end
    end

end
