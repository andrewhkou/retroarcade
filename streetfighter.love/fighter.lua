Fighter = {}

function Fighter.new(name, keyMap)
    local f = {}
    f.name = name
    f.health = 100
    f.keyMap = keyMap
    f.state = "stand"
    f.drawX = 100
    f.drawY = 100
    f.hitboxX = 0
    f.hitboxY = 0
    setmetatable(f, {__index = Fighter})
    return f
end

function Fighter:walkRight()
    self.drawX = self.drawX + 10
end

-- function Fighter:loseHealth()

-- end

-- function Fighter:walkLeft()

-- end

-- function Fighter:jump()

-- end

function Fighter:update(dt)
    if love.keyboard.isDown('d') then
        self.drawX = self.drawX + 10
    end


    if self.state == "walkRight" then
        self:walkRight()
    end
end

function Fighter:animate()
    love.graphics.rectangle('fill', self.drawX, self.drawY, 100, 200)
end